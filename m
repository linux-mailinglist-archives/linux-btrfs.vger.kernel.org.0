Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD97E486927
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 18:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242417AbiAFRte (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 12:49:34 -0500
Received: from santino.mail.tiscali.it ([213.205.33.245]:56242 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242286AbiAFRtd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 12:49:33 -0500
Received: from venice.bhome ([84.220.25.125])
        by santino.mail.tiscali.it with 
        id fVpV2600Z2hwt0401VpYUQ; Thu, 06 Jan 2022 17:49:32 +0000
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
Subject: [PATCH 1/6] btrfs: add flags to give an hint to the chunk allocator
Date:   Thu,  6 Jan 2022 18:49:18 +0100
Message-Id: <90f0d53b2ee4b1b9fd4cfa2d36994ad6d858753f.1641486794.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1641486794.git.kreijack@inwind.it>
References: <cover.1641486794.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1641491372; bh=VQY6O7Tid/B7P16mtGfsFnkVQ4gQfAUmnQyQiwZnzic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=1lcHOCTReFWwimnASsPR6N+V7Q/b2D1+oOL9IR2duAUmH+PFgpY3thncoiuCQXSrj
         weuCJJJOxz/IDRov5qIQECRU/TfKBTGqca1U7ihGXbioVPs+G5bDS47PpIB2goqMRR
         TXBgfyUiUsV3fvORowGVeImcpQFquWtLN8fLiJPY=
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

