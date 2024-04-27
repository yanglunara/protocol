PROTO_NAMES=(
    "auth"
    "constant"
    "errinfo"
)
for name in "${PROTO_NAMES[@]}"; do
  protoc --go_out=./${name} --go_opt=module=github.com/yanglunara/protocol/${name} --go-grpc_out=./${name} --go-grpc_opt=module=github.com/yanglunara/protocol/${name} ${name}/${name}.proto
  
  if [ $? -ne 0 ]; then
      echo "error processing ${name}.proto"
      exit $?
  fi
done

if [ "$(uname -s)" == "Darwin" ]; then
    find . -type f -name '*.pb.go' -exec sed -i '' 's/,omitempty"`/\"\`/g' {} +
else
    find . -type f -name '*.pb.go' -exec sed -i 's/,omitempty"`/\"\`/g' {} +
fi