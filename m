Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 065A84A39A
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 16:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfFROOh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 10:14:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:60376 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728982AbfFROOh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 10:14:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E662CAF7F
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 14:14:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5FECADA871; Tue, 18 Jun 2019 16:15:19 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com, David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: reorder struct btrfs_key for better alignment
Date:   Tue, 18 Jun 2019 16:15:14 +0200
Message-Id: <20190618141514.17322-1-dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We don't use the plain key for any on-disk operations so there's no
requirement for the member order. As the offset is a u64 that should be
on an 8byte aligned address, this can generate ineffective code on
strict alignment architectures and can potentially hurt even on others
(cross-cacheline access).

The resulting asm code on x86_64 only differes in the offset, no significant
change in size of the object size.

The alignment of the structure is unchanged.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 include/uapi/linux/btrfs_tree.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index aff1356c2bb8..9ca7adcf3b7f 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -342,10 +342,17 @@ struct btrfs_disk_key {
 	__le64 offset;
 } __attribute__ ((__packed__));
 
+/*
+ * NOTE: this structure does not match the on-disk format of key and must be
+ * converted with the right helpers. The btrfs_key is for in-memory use and the
+ * members are reordered for better alignment. It's still packed as it's never
+ * used in arrays and the extra alignment would consume stack space in
+ * functions.
+ */
 struct btrfs_key {
 	__u64 objectid;
-	__u8 type;
 	__u64 offset;
+	__u8 type;
 } __attribute__ ((__packed__));
 
 struct btrfs_dev_item {
-- 
2.21.0

