# Cyb3rhq Docker Copyright (C) 2017, Cyb3rhq Inc. (License GPLv2)
sleep 30
bash /usr/share/cyb3rhq-indexer/plugins/opensearch-security/tools/securityadmin.sh -cd /usr/share/cyb3rhq-indexer/opensearch-security/ -nhnv -cacert  $CACERT -cert $CERT -key $KEY -p 9200 -icl