Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 732A680871
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Aug 2019 23:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfHCVoh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Aug 2019 17:44:37 -0400
Received: from smtp.dpl.mendix.net ([83.96.177.10]:50076 "EHLO
        smtp.dpl.mendix.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbfHCVog (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Aug 2019 17:44:36 -0400
Received: from mekker.bofh.dpl.mendix.net (mekker.bofh.dpl.mendix.net [IPv6:2001:828:13c8:10b::21])
        by smtp.dpl.mendix.net (Postfix) with ESMTP id B6A1C20262;
        Sat,  3 Aug 2019 23:36:34 +0200 (CEST)
From:   Hans van Kranenburg <hans@knorrie.org>
To:     linux-btrfs@vger.kernel.org
Cc:     Hans van Kranenburg <hans.van.kranenburg@mendix.com>
Subject: [PATCH] btrfs: clarify btrfs_ioctl_get_dev_stats padding
Date:   Sat,  3 Aug 2019 23:36:34 +0200
Message-Id: <20190803213634.32736-1-hans@knorrie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Hans van Kranenburg <hans.van.kranenburg@mendix.com>

In commit c11d2c236cc26 the get_dev_stats ioctl was added.

Shortly thereafter, in commit b27f7c0c150f7, the flags field was added.
However, the calculation for unused padding space was not updated, which
also invalidated the comment.

Clarify what happened to reduce confusion and wasted time for anyone
implementing this.

Signed-off-by: Hans van Kranenburg <hans.van.kranenburg@mendix.com>
---
 include/uapi/linux/btrfs.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 7885d79f7515..3ee0678c0a83 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -665,7 +665,12 @@ struct btrfs_ioctl_get_dev_stats {
 	/* out values: */
 	__u64 values[BTRFS_DEV_STAT_VALUES_MAX];
 
-	__u64 unused[128 - 2 - BTRFS_DEV_STAT_VALUES_MAX]; /* pad to 1k */
+	/*
+	 * This pads the struct to 1032 bytes. It was originally meant to pad to
+	 * 1024 bytes, but when adding the flags field, the padding calculation
+	 * was not adjusted.
+	 */
+	__u64 unused[128 - 2 - BTRFS_DEV_STAT_VALUES_MAX];
 };
 
 #define BTRFS_QUOTA_CTL_ENABLE	1
-- 
2.20.1

