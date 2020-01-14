Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF60213A0DA
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 07:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgANGJc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 01:09:32 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45602 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgANGJc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 01:09:32 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E68Ie2150376;
        Tue, 14 Jan 2020 06:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=pWQD7JRjcbPBaLP+Au4CAO8hV/RjSXQdQPfLp2iFjng=;
 b=qMBQ5GgdG2khl6wKiC7vLG8VP42rxocojcu7MOU8r7VdQLu7aNvpDnxIokkHWlk5KmpQ
 mfLuBJRwFFv5kueFbQ54gyCRxWMBcxYj1Qq8kZfePszpvgN1jSA8eGhn2ntAiR7xtHum
 H+pQTQ8Eb0KujlP+vgBRRJkSUTMYKVihmgBm05w/FqEgD8O+Pm3qO7HIlhkEIMCpwcbz
 0jN5SDeNv39zwgIr9+DQQ089gJxUuZ77nav8C4iSUKY0/jATAyz/KbVdQhv9L4zJhSiR
 cNKUpUOkm31RyfWgXHkYHhGYYi/5jJzQp8E12af2zR/FRfO+02rmocwQBNCTeY/Jn4yC pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xf74s3rc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 06:09:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E68j3B109507;
        Tue, 14 Jan 2020 06:09:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2xh2tn4rvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 06:09:27 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00E69QrW014513;
        Tue, 14 Jan 2020 06:09:26 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 22:09:25 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH 1/4] btrfs: add NO_FS_INFO to btrfs_printk
Date:   Tue, 14 Jan 2020 14:09:17 +0800
Message-Id: <20200114060920.4527-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001140054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001140054
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The first argument to btrfs_printk() wrappers such as
btrfs_warn_in_rcu(), btrfs_info_in_rcu(), etc.. is fs_info, but in some
context like scan and assembling of the volumes there isn't fs_info yet,
so those code generally don't use the btrfs_printk() wrappers and it
could could still use NULL but then it would become hard to distinguish
whether fs_info is NULL for genuine reason or a bug.

So introduce a define NO_FS_INFO to be used instead of NULL so that we
know the code where fs_info isn't initialized and also we have a
consistent logging functions. Thanks.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/ctree.h |  5 +++++
 fs/btrfs/super.c | 14 +++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 569931dd0ce5..625c7eee3d0f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -110,6 +110,11 @@ struct btrfs_ref;
 #define BTRFS_STAT_CURR		0
 #define BTRFS_STAT_PREV		1
 
+/*
+ * Used when we know that fs_info is not yet initialized.
+ */
+#define	NO_FS_INFO	((void *)0x1)
+
 /*
  * Count how many BTRFS_MAX_EXTENT_SIZE cover the @size
  */
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a906315efd19..5bd8a889fed0 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -216,9 +216,17 @@ void __cold btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, .
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	if (__ratelimit(ratelimit))
-		printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
-			fs_info ? fs_info->sb->s_id : "<unknown>", &vaf);
+	if (__ratelimit(ratelimit)) {
+		if (fs_info == NULL)
+			printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
+				"<unknown>", &vaf);
+		else if (fs_info == NO_FS_INFO)
+			printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
+				"...", &vaf);
+		else
+			printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
+				fs_info->sb->s_id, &vaf);
+	}
 
 	va_end(args);
 }
-- 
2.23.0

