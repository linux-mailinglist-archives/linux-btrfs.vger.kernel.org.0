Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9401610C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 12:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgBQLNJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 06:13:09 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34012 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbgBQLNJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 06:13:09 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01HBD5x6106044;
        Mon, 17 Feb 2020 11:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=1ZBrgt24O1C4pCqHd+Y/7lmncxgO+I82LUgkjMMen9g=;
 b=UNHayfga7B4M3HoaO8Zkh8oGBe9bDO7wBFb7fRyS1MqFaYFzvwKwm4hH/LWPkoBl/hzD
 0g2L0Ek53QYe10X0ldawSF2dVDWjI6sE4Komc5n2/TVGTNjGJ1KEaRXeSKmDBeMPHGt8
 Rq0HIi6liGGqJLT6eFaLBdvG8UucG8C3VXePZdWI8IfcLlwN+e6NHz9Qrd9KuoiA8LMQ
 snIrOSBr7L7UkmfTjs7H0vXQZfe1jK2vJSlTd8behQoKR+xP/a1K2XHjPJHZtWwV1BSv
 PJPVMYiYqNKGi4mWoTdexbJzjZRR3Z5BwjN4x2A6pfdm2o3en+CrWSEr5fOFZvUvIql5 gA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2y68kqqmmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 11:13:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01HB1dqx015921;
        Mon, 17 Feb 2020 11:12:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2y6t4fvgtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 11:12:57 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01HBCvQR011736;
        Mon, 17 Feb 2020 11:12:57 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Feb 2020 03:12:56 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com
Subject: [PATCH v5 1/5] btrfs: add btrfs_strmatch helper
Date:   Mon, 17 Feb 2020 19:12:41 +0800
Message-Id: <1581937965-16569-2-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581937965-16569-1-git-send-email-anand.jain@oracle.com>
References: <1581937965-16569-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9533 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=1
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002170096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9533 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 suspectscore=1 impostorscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002170097
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

