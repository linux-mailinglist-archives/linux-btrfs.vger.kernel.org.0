Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF8419F527
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 13:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgDFLve (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Apr 2020 07:51:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40632 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgDFLve (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Apr 2020 07:51:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036BnHj6027615
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Apr 2020 11:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=bszKer2+tebRvMuF2lhAhjztr5cP3v/1OBY0PY660F8=;
 b=ns/JMUsI6FDu5ISrFbA/3P5yiksji5kj0FGZmF8nVcs1+M9+nk8MqV/vvwlIcM2CuBa8
 4zkaLIt14BCjoFTRdVitApo9BEehu83eOX0tnaQdK6s2jIQEDBFtfzCVdIr5HsFhQzsU
 LbJfYkKZF+T3Qa0qRyDAwTjGa8Up4WM+WkQqdzeYiNQ6QwE5RmboV6KjFHKBTVAOx/kr
 VVSqD7BDc5mKW5C6xxE83ZcNh1fg4ijs9mD5PxFG5v2HI9WwC86BBwdrdo+tlSBOvLQy
 ahQE498Sf9oAnVR42l+XmH3N4M0JOoM6uRcb5yzN4Tr7WaYLN4FbTvTjx02CcJH86z0/ xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 306jvmx8eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Apr 2020 11:51:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036BlEPo064708
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Apr 2020 11:51:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 3073qcw4tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Apr 2020 11:51:32 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 036BpV94000660
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Apr 2020 11:51:31 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Apr 2020 04:51:31 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v7 1/5] btrfs: add btrfs_strmatch helper
Date:   Mon,  6 Apr 2020 19:51:07 +0800
Message-Id: <1586173871-5559-2-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1586173871-5559-1-git-send-email-anand.jain@oracle.com>
References: <1586173871-5559-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=1
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060104
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
2.23.0

