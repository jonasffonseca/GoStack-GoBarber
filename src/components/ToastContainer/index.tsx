import React from "react";
import { Container } from "./styles";
import Toast from "./Toast";
import { ToastMessage } from "../../hooks/ToastContext";
import { useTransition } from "react-spring";

interface ToastContainerProps {
  messages: ToastMessage[];
}

const ToastContainer: React.FC<ToastContainerProps> = ({ messages }) => {
  const messagesWithTransitions = useTransition(
    messages,
    (message) => message.id,
    {
      from: { right: "-120%", opacity: 0, transform: "rotateZ(90deg)" },
      enter: { right: "0%", opacity: 1, transform: "rotateZ(0deg)" },
      leave: { right: "-120%", opacity: 0, transform: "rotateZ(90deg)" },
    }
  );

  return (
    <Container>
      {messagesWithTransitions.map(({ item, key, props }) => (
        <Toast key={key} style={props} message={item}></Toast>
      ))}
    </Container>
  );
};

export default ToastContainer;
