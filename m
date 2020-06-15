Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFB31F93F2
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jun 2020 11:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgFOJwn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 05:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbgFOJwn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 05:52:43 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31FC42068E
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jun 2020 09:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592214762;
        bh=2CP6EME2eUoiPvgl2wvbLj9LgbsufaXJf5cJEQAnS80=;
        h=From:To:Subject:Date:From;
        b=rvYNcp9WHZmsKvXxfK9J5ptiIDpv8oZ5ryk4ACRJRKyIGCIxe2HMipX7ejC/cq8g1
         4v0bzVMnpW1OD5IRMgZ+dCbP66oDTLcwFSJ2pqpqORyVW7weAhhVLKL69eD/M59jvw
         yAb4Koew1M8+ZE+cJnUFksQN/V0zQ8H9oTTukQys=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] Btrfs: remove no longer used log_list member of struct btrfs_ordered_extent
Date:   Mon, 15 Jun 2020 10:36:48 +0100
Message-Id: <20200615093648.287105-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The 'log_list' member of an ordered extent was used keep track of which
ordered extents we needed to wait after logging metadata, but is not used
anymore since commit 5636cf7d6dc86f ("btrfs: remove the logged extents
infrastructure"), as we now always wait on ordered extent completion
before logging metadata. So just remove it since it's doing nothing and
making each ordered extent structure waste more memory (2 pointers).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ordered-data.c | 2 --
 fs/btrfs/ordered-data.h | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index e13b3d28c063..73d5352c401b 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -197,7 +197,6 @@ static int __btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
 	INIT_LIST_HEAD(&entry->root_extent_list);
 	INIT_LIST_HEAD(&entry->work_list);
 	init_completion(&entry->completion);
-	INIT_LIST_HEAD(&entry->log_list);
 	INIT_LIST_HEAD(&entry->trans_list);
 
 	trace_btrfs_ordered_extent_add(inode, entry);
@@ -429,7 +428,6 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry)
 	trace_btrfs_ordered_extent_put(entry->inode, entry);
 
 	if (refcount_dec_and_test(&entry->refs)) {
-		ASSERT(list_empty(&entry->log_list));
 		ASSERT(list_empty(&entry->trans_list));
 		ASSERT(list_empty(&entry->root_extent_list));
 		ASSERT(RB_EMPTY_NODE(&entry->rb_node));
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index c01c9698250b..35e81b80bd5d 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -101,9 +101,6 @@ struct btrfs_ordered_extent {
 	/* list of checksums for insertion when the extent io is done */
 	struct list_head list;
 
-	/* If we need to wait on this to be done */
-	struct list_head log_list;
-
 	/* If the transaction needs to wait on this ordered extent */
 	struct list_head trans_list;
 
-- 
2.26.2

