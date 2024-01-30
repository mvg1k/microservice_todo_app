#only 1 argument
if [ $# -ne 1 ]; then
    echo "CHOOSE ONLY ONE ARGUMENT: all, prod, stage or dev"
    exit 1
fi

#ENV that u need
environments=()
case "$1" in
    "all")
        environments=("prod" "stage" "dev")
        ;;
    "prod" | "stage" | "dev")
        environments=("$1")
        ;;
    *)
        echo "incorrect argument"
        exit 1
        ;;
esac


for environment in "${environments[@]}"; do
    values_file="./my1chart/values-$environment.yaml"
    helm install frontend-"$environment" my1chart -f "$values_file" --namespace "$environment"
done