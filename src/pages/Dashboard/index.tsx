import React from "react";
import Button from "../../components/Button";
import { useAuth } from "../../hooks/AuthContext";
import { Container, Background, Content } from "./styles";

const Dashboard: React.FC = () => {
  const { signOut } = useAuth();
  const name = localStorage.getItem("@GoBarber:name");
  return (
    <>
      <Container>
        <Content>
          <h1>Dashboard</h1>
          <h3>Olá {name}!</h3>
          <Button type="submit" onClick={signOut}>
            Logout
          </Button>
        </Content>
        <Background />
      </Container>
    </>
  );
};

export default Dashboard;
