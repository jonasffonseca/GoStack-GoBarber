import React, { useCallback, useRef, useState } from "react";
import { Container, Content, Background, AnimationContainer } from "./styles";
import logoImg from "../../assets/logo.svg";
import { FiLogIn, FiMail } from "react-icons/fi";
import Button from "../../components/Button";
import Input from "../../components/Input";
import { Form } from "@unform/web";
import { FormHandles } from "@unform/core";
import * as Yup from "yup";
import { Link } from "react-router-dom";
import { useToast } from "../../hooks/ToastContext";
import getValidationErrors from "../../utils/getValidationErrors";
import api from "../../services/api";

interface ForgotPasswordFormData {
  email: string;
}

const ForgotPassword: React.FC = () => {
  const [loading, setLoading] = useState(false);

  const formRef = useRef<FormHandles>(null);
  const { addToast } = useToast();

  const handleSubmit = useCallback(
    async (data: ForgotPasswordFormData) => {
      try {
        setLoading(true);
        formRef.current?.setErrors({});
        const schema = Yup.object().shape({
          email: Yup.string()
            .required("Email obrigatório")
            .email("Digite um e-mail válido"),
        });
        await schema.validate(data, {
          abortEarly: false,
        });

        //recuperacao de senha
        await api.post("/password/forgot", {
          email: data.email,
        });

        addToast({
          type: "success",
          title: "E-mail de Recuperação enviado",
          description:
            "Enviamos um e-mail para confirmar a recuperação de senha. Cheque sua caixa de entrada",
        });
      } catch (err) {
        if (err instanceof Yup.ValidationError) {
          console.log(err);

          const errors = getValidationErrors(err);

          formRef.current?.setErrors(errors);
          return;
        }
        addToast({
          title: "Erro na recuperação de senha",
          description: "Ocorreu um erro ao recuperar a senha.",
          type: "error",
        });
      } finally {
        setLoading(false);
      }
    },
    [addToast]
  );
  return (
    <Container>
      <Content>
        <AnimationContainer>
          <img src={logoImg} alt="GoBarber" />
          <Form ref={formRef} onSubmit={handleSubmit}>
            <h1>Recuperar Senha</h1>
            <Input name="email" icon={FiMail} placeholder="E-mail" />
            <Button loading={loading} type="submit">
              Recuperar
            </Button>
          </Form>
          <Link to="/">
            <FiLogIn />
            Voltar ao login
          </Link>
        </AnimationContainer>
      </Content>
      <Background />
    </Container>
  );
};

export default ForgotPassword;
