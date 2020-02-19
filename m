Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A24816436A
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 12:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgBSLbo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 06:31:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56478 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgBSLbo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 06:31:44 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JBS1sD129657;
        Wed, 19 Feb 2020 11:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=1ZBrgt24O1C4pCqHd+Y/7lmncxgO+I82LUgkjMMen9g=;
 b=HGO/oXhphHg95E/qm2N5xT2bT2/9sCxauyBKYqZIh4GkusBOuAkECGqF2K1LuKVybq7j
 8qAXHfE3DDT+wmelOWNuesrRCDUBhABsM7SxwBEQxClAk7EQ8sJmfJWtzvflUQNkIxhU
 Xo6IWsXprtsU3Yj+5vQ78PBbILVeZEpKu7j5lNe9N+ekJ5LMOl3vLvKV7g4q994BDLG/
 y7FfvDQ74gXKs/0GqWz0X/gpjWAGZn8NkkHnnRm/B78rr6XQnZMVA2hv0VATF2v4HpNU
 c+OcrTWVpv5lS9vBsKUqe+Z91mithDY3Y2cZ0R9bYVgcA+VRE9aK4CMVwtb+kckF2XDf HA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2y8ud12cjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 11:31:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JBRsoI117905;
        Wed, 19 Feb 2020 11:29:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2y8ud30afx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 11:29:39 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01JBTd5O006530;
        Wed, 19 Feb 2020 11:29:39 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 03:29:38 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.cz
Subject: [PATCH v6 1/5] btrfs: add btrfs_strmatch helper
Date:   Wed, 19 Feb 2020 19:29:22 +0800
Message-Id: <1582111766-8372-2-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582111766-8372-1-git-send-email-anand.jain@oracle.com>
References: <1582111766-8372-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 spamscore=0 suspectscore=1 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=1 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190087
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a generic helper to match the golden-string in the given-string,
and ignore the leading and trailing whitespaces if any.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Suggested-by: David Sterba <dsterba@suse.com>
---
v5: born

 fs/btrfs/sysfs.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 93cf76118a04..7bb68cef98ab 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -809,6 +809,29 @@ static ssize_t btrfs_checksum_show(struct kobject *kobj,
 
 BTRFS_ATTR(, checksum, btrfs_checksum_show);
 
+/*
+ * Match the %golden in the %given. Ignore the leading and trailing whitespaces
+ * if any.
+ */
+static int btrfs_strmatch(const char *given, const char *golden)
+{
+	size_t len = strlen(golden);
+	char *stripped;
+
+	/* strip leading whitespace */
+	stripped = skip_spaces(given);
+
+	if (strncmp(stripped, golden, len) == 0) {
+		/* strip trailing whitespace */
+		if (strlen(skip_spaces(stripped + len)))
+			return -EINVAL;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, label),
 	BTRFS_ATTR_PTR(, nodesize),
-- 
1.8.3.1

