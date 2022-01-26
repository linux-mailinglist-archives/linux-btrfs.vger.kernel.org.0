Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5913E49D373
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 21:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiAZUcW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 15:32:22 -0500
Received: from michael.mail.tiscali.it ([213.205.33.246]:59406 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229907AbiAZUcV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 15:32:21 -0500
Received: from venice.bhome ([78.14.151.50])
        by michael.mail.tiscali.it with 
        id nYYG2600e15VSme01YYJKH; Wed, 26 Jan 2022 20:32:19 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 1/7] btrfs: add flags to give an hint to the chunk allocator
Date:   Wed, 26 Jan 2022 21:32:08 +0100
Message-Id: <12942e1615af081413ec256da04bfa4fd0a6c155.1643228177.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643228177.git.kreijack@inwind.it>
References: <cover.1643228177.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1643229139; bh=VQY6O7Tid/B7P16mtGfsFnkVQ4gQfAUmnQyQiwZnzic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=xx6TPRxDJzJZalA3KKuZDbIx3KVAxRbbmtPqQ4dY3C70e2zvPj65NpU/gBS6azHgX
         v5+baR4YSdVmIbhlyMl/7xwZ5/BQ5rfDDC4OBP+xT/RPLMAK8wnJ59tlgLSu/5ikPC
         uSwJO2o1arD0n1a4gRxuMxHhf5ZEv69bJLtZJvRo=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Add the following flags to give an hint about which chunk should be
allocated in which disk:

- BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED
  preferred for data chunk, but metadata chunk allowed
- BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED
  preferred for metadata chunk, but data chunk allowed
- BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY
  only metadata chunk allowed
- BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY
  only data chunk allowed

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 include/uapi/linux/btrfs_tree.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 5416f1f1a77a..02955d5fcd21 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -386,6 +386,22 @@ struct btrfs_key {
 	__u64 offset;
 } __attribute__ ((__packed__));
 
+/* dev_item.type */
+
+/* btrfs chunk allocation hint */
+#define BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT	2
+/* btrfs chunk allocation hint mask */
+#define BTRFS_DEV_ALLOCATION_HINT_MASK	\
+	((1 << BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT) - 1)
+/* preferred data chunk, but metadata chunk allowed */
+#define BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED	(0ULL)
+/* preferred metadata chunk, but data chunk allowed */
+#define BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED	(1ULL)
+/* only metadata chunk are allowed */
+#define BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY		(2ULL)
+/* only data chunk allowed */
+#define BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY		(3ULL)
+
 struct btrfs_dev_item {
 	/* the internal btrfs device id */
 	__le64 devid;
-- 
2.34.1

