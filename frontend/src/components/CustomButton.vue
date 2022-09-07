<template>
  <div :style="{backgroundColor: color}" style="width: 100%; padding-top: 18px; padding-bottom: 18px; border-radius: 5px">
      <div style="display: flex; justify-content: center; align-items: center; align-content: center">
        <i :class="logo" :style="{color: logoColor}"></i>
        <div style="padding-left: 12px; color: white; font-weight: bold; font-size: 18px">
          {{ buttonText }}
        </div>
      </div>
    </div>
</template>

<script>

export default {
  name: "CustomButton",
  props: {
    logo: {
      type: String,
      default: "far fa-flag"
    },
    logoColor: {
      type: String,
      default: "#FFFFFF"
    },
    color: {
      type: String,
      default: "#FFFFFF"
    },
    buttonText: {
      type: String,
      default: "Unknown"
    }
  },
}
</script>

<style scoped>
</style>
