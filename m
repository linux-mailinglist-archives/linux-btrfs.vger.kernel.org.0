Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C8E29E321
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 03:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgJ2Cpi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 22:45:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43988 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgJ1Vdh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 17:33:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SDF5xW075057;
        Wed, 28 Oct 2020 13:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=kFGDvqJ0L/oJ71tFVifgbzyQH3OhKBr025RY9BjWQAk=;
 b=v6rX6p71QHwi3f1MRZVywoZAmBrVHxpK3WXP0KtLCMs0OHtYdeqBw0sVEmNE23HxzvD9
 xGvoRbJIQrzB3WiuD8l8cSoGuC5ahL7Dh7zIgW21kler8EHQF9MU9U3n/M4AXNMeWfwT
 GfWrngr2jEFGxtW5Ve6nVrN17VV5KYv8A8GfJk6htl+i90tdWrMYVf6K4khCQL7bqXYV
 o0i8+/RE51IiT9elSCpqkei7OGqyH0AMExiNf0F6+GLcrV/WsyQPEnugJUfEYEaU6LL4
 axRRDMTNtjTGgK9yocNUPq2OgpvUX0Y2v4rNL74XqPrrq/kXKt/N6zjc43ek27iPNSQl 4Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34cc7kyax0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 13:15:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SDALqk179921;
        Wed, 28 Oct 2020 13:15:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34cx1rydp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 13:15:04 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09SDF39D008175;
        Wed, 28 Oct 2020 13:15:03 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 06:15:03 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 1/3] btrfs: add btrfs_strmatch helper
Date:   Wed, 28 Oct 2020 21:14:45 +0800
Message-Id: <d3cfa1d20e7e0a86bbef9e078d887e90d1755b29.1603884513.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1603884513.git.anand.jain@oracle.com>
References: <cover.1603884513.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=1 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=1
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280089
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
index fcd6c7a9bbd1..5955379d3d9e 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -888,6 +888,24 @@ static ssize_t btrfs_generation_show(struct kobject *kobj,
 }
 BTRFS_ATTR(, generation, btrfs_generation_show);
 
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

