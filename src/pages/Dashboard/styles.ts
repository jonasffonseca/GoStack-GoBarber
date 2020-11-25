import styled from "styled-components";
import dashboardBackground from "../../assets/dashboard-background.jpg";

export const Container = styled.div`
  height: 100vh;
  display: flex;
  align-items: stretch;
`;

export const Content = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 100%;
  max-width: 700px;

  button {
    width: 20%;
    margin-top: 70%;
  }
`;

export const Background = styled.div`
  flex: 1;
  background: url(${dashboardBackground}) no-repeat center;
  background-size: cover;
`;
