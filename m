Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FD2347A9E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Mar 2021 15:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbhCXOXo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Mar 2021 10:23:44 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52181 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbhCXOXV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Mar 2021 10:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616595801; x=1648131801;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MSwEuRKj8KR/TKUM4pyPK8/5zvA9g5RtLAxBO+68Dog=;
  b=EvP9OtS0obttbFO1IbyGYoR7JSgWPwDQL7YTJBNOA+khQ1vgNl3iqeKD
   Kf4kyPyqImo1Ze66ASWqJUaGaIuTEijeNHUwIRIg+aOCt2KRQhITOd/TZ
   UHyXu3nvz80ohPPiBqtfR7aA43Nx0iwltS48kcv7sqkni6RXs71ky52Ch
   hz8f0lsyeDJRMsvc0OWtFxapwDsexbo8VI1y9WWF66RNEH4MkJQk+E4UG
   j0WOx3ZvuP3cLlqhFYLbrXD4pEth4ys9cEWOL9fBDvL9uu611ntgE23G5
   XKibZhlZ5BdIXVfETVMqhpYsHXFrRkgUFd5Uir1si7cqH2CUVIP/S/z60
   g==;
IronPort-SDR: YvVTBBmv2emUt+uYYOaDbeLG+bmZJvU6t8gvavQdqRPj3TPU82bprB1PySp33pw1mjak4dOAyF
 exYwZev5FnFP/+3KNoAlSUWxEwZhkhRIa8gw5DhfDG/vjMtsld8BF+EsvdnqBRtEoNx9WakEhL
 oYSRP9ksYYRiPdEEM7coKfZxP14djhHsYwGuvCRTgTGOWyK/7Rtr9xBDDYRqzcTrHugVUFuIsL
 sGO87VVUAu0d7e9HlDN9c5VRoFJX4Gt2xpiydzZh6MflKxB/wh6IYPL3ItpWiVu+WSKWR8jWwX
 9rw=
X-IronPort-AV: E=Sophos;i="5.81,274,1610380800"; 
   d="scan'208";a="167379126"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2021 22:23:21 +0800
IronPort-SDR: nz1ssueNzXBBBVRrJ/lqDLvgNUybQir0T/k4bEkuGxQ9Qyii3jsc0Ho81kDcNtYAyvZix3AvDY
 Kl/JiEySClwMHZnmgehMm9jG1JnW+MigaQBODzUOwij0z97hdiwkqF/7fMKtiycP/vj/i+yLVG
 LHxzh+ME5gqftE/nlTflwjHFho7722u43U/zIad4xnjYPxnc5asKX+ajMFM9+DazTGhs1K2yIR
 fmU1N57w0caCws0oNzUGjJ8qlvj/EJgNy010QHVgPSiQ2a+rhoBLwYtpVN99fWT65J5iyBY6Yp
 Qfy2HXY1fyFRRBxjigbo/Zp2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 07:05:25 -0700
IronPort-SDR: 5zoM2uv+VUI9k00eOKcIVTvGr42dgqfSx9pIkMmvbOMIdip0hgfJpJhBpkpbHL82wt7nOkmrhM
 HV4E6/WalgTJo6HcTOVqZ5TLOK/HYKucGg2mr4BnoWFUAiYOxLrJEUm4KGmaNwUsbt1m5Mxh4l
 d1+9Q2UXnctKS+rWKUA1VMAyke7INB3oj0UQ8twbNLZVn7AqiLrDAJGj44L5VgRDzRzn78xEot
 Z83UF6WkXpLyGdtREFylJ7nqBbZHL69wlPcfvdo96Ljoal+fQYBz7O43hyizRvTYWa5vIZG52i
 M3U=
WDCIronportException: Internal
Received: from fbvx1z2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.15])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Mar 2021 07:23:20 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: zoned: move log tree node allocation out of log_root_tree->log_mutex
Date:   Wed, 24 Mar 2021 23:23:11 +0900
Message-Id: <984c070461f31182e87d1b4f27c4565088a31b40.1616595693.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 6e37d2459941 ("btrfs: zoned: fix deadlock on log sync") pointed out
a deadlock warning and removed
mutex_{lock,unlock}(&fs_info->tree_root->log_mutex). While it looks like it
always cause a deadlock, we didn't see actual deadlock in fstests runs. The
reason is log_root_tree->log_mutex != fs_info->tree_root->log_mutex, not
taking the same lock. So, the warning was actually a false-positive.

Since btrfs_alloc_log_tree_node() is protected only by
fs_info->tree_root->log_mutex, we can (and should) move the code out of the
lock scope of log_root_tree->log_mutex and silence the warning.

Cc: Filipe Manana <fdmanana@suse.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/tree-log.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 92a368627791..72c4b66ed516 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3165,20 +3165,22 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 	 */
 	mutex_unlock(&root->log_mutex);
 
-	btrfs_init_log_ctx(&root_log_ctx, NULL);
-
-	mutex_lock(&log_root_tree->log_mutex);
-
 	if (btrfs_is_zoned(fs_info)) {
+		mutex_lock(&fs_info->tree_root->log_mutex);
 		if (!log_root_tree->node) {
 			ret = btrfs_alloc_log_tree_node(trans, log_root_tree);
 			if (ret) {
-				mutex_unlock(&log_root_tree->log_mutex);
+				mutex_unlock(&fs_info->tree_log_mutex);
 				goto out;
 			}
 		}
+		mutex_unlock(&fs_info->tree_root->log_mutex);
 	}
 
+	btrfs_init_log_ctx(&root_log_ctx, NULL);
+
+	mutex_lock(&log_root_tree->log_mutex);
+
 	index2 = log_root_tree->log_transid % 2;
 	list_add_tail(&root_log_ctx.list, &log_root_tree->log_ctxs[index2]);
 	root_log_ctx.log_transid = log_root_tree->log_transid;
-- 
2.31.0

