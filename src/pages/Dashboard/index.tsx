import React from "react";
import { View } from "react-native";
import { useAuth } from "../../hooks/AuthContext";
import Button from "../../components/Button";

const Dashboard: React.FC = () => {
  const { signOut } = useAuth();
  return (
    <View style={{ flex: 1, justifyContent: "center", margin: 16 }}>
      <Button onPress={signOut}>Sign Out</Button>
    </View>
  );
};

export default Dashboard;
