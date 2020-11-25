import styled from "styled-components/native";
import { getBottomSpace } from "react-native-iphone-x-helper";
import { Platform } from "react-native";

export const Container = styled.View`
  flex: 1;
  align-items: center;
  justify-content: center;
  padding: 0 30px ${Platform.OS === "android" ? 100 : 0}px;
`;
export const Title = styled.Text`
  font-size: 24px;
  color: #f4ede8;
  font-family: "RobotoSlab-Medium";
  margin: 64px 0px 24px;
`;

export const BackToSignIn = styled.TouchableOpacity`
  align-items: center;
  justify-content: center;
  flex-direction: row;
  background: #312e38;
  border-top-width: 1px;
  border-color: #232129;
  padding: 26px 0 ${16 + getBottomSpace()}px;
`;
export const BackToSignInText = styled.Text`
  color: #fff;
  font-family: "RobotoSlab-Regular";
  font-size: 18px;
  margin-left: 16px;
`;
