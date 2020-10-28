Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2467229D469
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Oct 2020 22:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgJ1VwD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 17:52:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56908 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgJ1VwA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 17:52:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09S4PHYR091857;
        Wed, 28 Oct 2020 04:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=lhndsfHcmCB851UH7f43mZ5gu01OsxgzjGWUCQlEf5o=;
 b=xf1jQFBE4RsC0Hf9Fcj66yz8qYoOz5AXroShywf2iG1SSoCmDYvt7W0tbcm7y52xZRov
 C5647bjh4+4oPykhDQmLD5gkPKfJ6FzMIC1zam6RekvdjN83E9UBtcefpQxLl2X0rVyl
 a4M8CV2HrvB5S2qLHFbT3TDn8ZwgLyXH8i/E3NxXPUx9OP8gXCkgME4jBjtWnj0jHqdW
 JzKhpXGRpyPI5q1rhQ0OzeFMplWUjG7gQBZrjl30lJbTHtPphVL95ZLENNAfXZBnRm2d
 /+Guq1UTGvIZxHLeQO6m2gCWYeIQ1jQLlJuneEQTUoX+azpfNtVRh6bf7c5J+CRlIj3x ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34cc7kw9dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 04:25:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09S4KJGI123838;
        Wed, 28 Oct 2020 04:25:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34cx1rgxsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 04:25:32 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09S4PU7o029369;
        Wed, 28 Oct 2020 04:25:30 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Oct 2020 21:25:30 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 1/3] btrfs: add btrfs_strmatch helper
Date:   Wed, 28 Oct 2020 12:25:02 +0800
Message-Id: <f69010da7ebe4ea360850529bf2198cf73287b70.1603858308.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1603858308.git.anand.jain@oracle.com>
References: <cover.1603858308.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=1 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=1
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280025
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a generic helper to match the golden-string in the given-string,
and ignore the leading and trailing whitespaces if any.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Suggested-by: David Sterba <dsterba@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
v10: return bool instead of int.
     drop unnecessary local variable and ( ) with in if.
v9: use Josef suggested C coding style, using single if statement.
v5: born
 fs/btrfs/sysfs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 279d9262b676..2e114f5181e8 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -854,6 +854,24 @@ static ssize_t btrfs_exclusive_operation_show(struct kobject *kobj,
 }
 BTRFS_ATTR(, exclusive_operation, btrfs_exclusive_operation_show);
 
+/*
+ * Match the %golden in the %given. Ignore the leading and trailing whitespaces
+ * if any.
+ */
+static bool btrfs_strmatch(const char *given, const char *golden)
+{
+	size_t len = strlen(golden);
+
+	/* skip leading whitespace */
+	given = skip_spaces(given);
+
+	if (strncmp(given, golden, len) == 0 &&
+	    !strlen(skip_spaces(given + len)))
+		return true;
+
+	return false;
+}
+
 static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, label),
 	BTRFS_ATTR_PTR(, nodesize),
-- 
2.25.1

