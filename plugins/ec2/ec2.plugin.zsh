export JAVA_HOME=${JAVA_HOME:-"/System/Library/Frameworks/JavaVM.framework/Home"}
export EC2_PRIVATE_KEY="$(/bin/ls -1rth $HOME/.ec2/pk-*.pem | tail -n1)"
export EC2_CERT="$(/bin/ls -1rth $HOME/.ec2/cert-*.pem | tail -n1)"
export EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.4.4.1/jars"
