Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3319245A308
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 13:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbhKWMrg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 07:47:36 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40718 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236683AbhKWMre (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 07:47:34 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6EE251FD66;
        Tue, 23 Nov 2021 12:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637671465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         in-reply-to:in-reply-to:references:references;
        bh=5v4q3MxhLchbL8f3k5G6XKZTfsKLJAgdFW7+gAGcYz4=;
        b=ImCx1EVkyMT8d8lfxnlcei3U+wcHeyFZ6Qmoau5dsaCClGG70IKbC4stg8CBsywXJ8kHYr
        E9/MGgR+QvnZIU7iQOQ1idEQe5w1iuurKjTNlScsqtYVxVPg0tSkanDnjN1kAwcSVXneXZ
        odp4cMhGxatCqNeQ72eUsheQmGzeMZ0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E2D313DF4;
        Tue, 23 Nov 2021 12:44:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2BT8DCninGEfdgAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 23 Nov 2021 12:44:25 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4/4] btrfs: change name and type of private member of btrfs_free_space_ctl
Date:   Tue, 23 Nov 2021 14:44:22 +0200
Message-Id: <20211123124422.5830-5-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211123124422.5830-1-nborisov@suse.com>
References: <20211123124422.5830-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_free_space_ctl::private is either unset or it always points to
struct btrfs_block_group when it is set. So there's no point in keeping
the unhelpful 'private' name and keeping it an untyped pointer. Change
both the type and name to be self-describing. No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/free-space-cache.c | 12 ++++++------
 fs/btrfs/free-space-cache.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 1e1299bfe380..51c688c9d12c 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -666,7 +666,7 @@ static int io_ctl_read_bitmap(struct btrfs_io_ctl *io_ctl,
 
 static void recalculate_thresholds(struct btrfs_free_space_ctl *ctl)
 {
-	struct btrfs_block_group *block_group = ctl->private;
+	struct btrfs_block_group *block_group = ctl->block_group;
 	u64 max_bytes;
 	u64 bitmap_bytes;
 	u64 extent_bytes;
@@ -2084,7 +2084,7 @@ static u64 add_bytes_to_bitmap(struct btrfs_free_space_ctl *ctl,
 static bool use_bitmap(struct btrfs_free_space_ctl *ctl,
 		      struct btrfs_free_space *info)
 {
-	struct btrfs_block_group *block_group = ctl->private;
+	struct btrfs_block_group *block_group = ctl->block_group;
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	bool forced = false;
 
@@ -2153,7 +2153,7 @@ static int insert_into_bitmap(struct btrfs_free_space_ctl *ctl,
 		return 0;
 
 	if (ctl->op == &free_space_op)
-		block_group = ctl->private;
+		block_group = ctl->block_group;
 again:
 	/*
 	 * Since we link bitmaps right into the cluster we need to see if we
@@ -2769,7 +2769,7 @@ void btrfs_init_free_space_ctl(struct btrfs_block_group *block_group,
 	spin_lock_init(&ctl->tree_lock);
 	ctl->unit = fs_info->sectorsize;
 	ctl->start = block_group->start;
-	ctl->private = block_group;
+	ctl->block_group = block_group;
 	ctl->op = &free_space_op;
 	INIT_LIST_HEAD(&ctl->trimming_ranges);
 	mutex_init(&ctl->cache_writeout_mutex);
@@ -2865,8 +2865,8 @@ void __btrfs_remove_free_space_cache(struct btrfs_free_space_ctl *ctl)
 {
 	spin_lock(&ctl->tree_lock);
 	__btrfs_remove_free_space_cache_locked(ctl);
-	if (ctl->private)
-		btrfs_discard_update_discardable(ctl->private);
+	if (ctl->block_group)
+		btrfs_discard_update_discardable(ctl->block_group);
 	spin_unlock(&ctl->tree_lock);
 }
 
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index b35137e1f21a..0d245c0fc45e 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -54,7 +54,7 @@ struct btrfs_free_space_ctl {
 	s32 discardable_extents[BTRFS_STAT_NR_ENTRIES];
 	s64 discardable_bytes[BTRFS_STAT_NR_ENTRIES];
 	const struct btrfs_free_space_op *op;
-	void *private;
+	struct btrfs_block_group *block_group;
 	struct mutex cache_writeout_mutex;
 	struct list_head trimming_ranges;
 };
-- 
2.17.1

