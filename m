Return-Path: <linux-btrfs+bounces-1481-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5869B82F360
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 18:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCCA1F24478
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 17:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB851CD24;
	Tue, 16 Jan 2024 17:43:14 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0534F1CD14
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705426993; cv=none; b=MMLZVOwkmE6wDWUgMB4iWC/vCXaxN3YMnj/X2P/9WCO4WVkJ5GIoe81jgjGyYpZuQ3i2BAKUVL95lTLLifmSDlxHhWZOnGvE+i4c6Ng7TcmF3CK+/U6Tw0S8uzUYTvuCHJmnkP/wosERM4JnXU6XjawW+YNxSreR4coWxoR/GFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705426993; c=relaxed/simple;
	bh=QFvUhPUyI5Z4lmQayq7jziy/6anvRL9poypC25DGg0Y=;
	h=Received:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Level:X-Rspamd-Server:
	 X-Spamd-Result:X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Flag; b=azw+8be5r0jtPM+HtF3E+VOnf3ntBnDHQoPAcf/bONc0rHJPgEsyU9pR0AZQp+9itFUxqwbm55xBl/udYksp80TbtzQM0YybSHK9TJNU4FQOHjOox+eWo8f99ZTxM9mjrH86OeNBxrBCaEQvRpHP12ZJ9IFliBdTT5BNczwmxjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E7EE220AC;
	Tue, 16 Jan 2024 17:43:10 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 26EE2133CE;
	Tue, 16 Jan 2024 17:43:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id n7V/CS7ApmUnNAAAn2gu4w
	(envelope-from <dsterba@suse.com>); Tue, 16 Jan 2024 17:43:10 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/3] btrfs: return errors from unpin_extent_range()
Date: Tue, 16 Jan 2024 18:42:53 +0100
Message-ID: <a92cd7bd04dbefaa78ce7143fac75d94f103a957.1705426614.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1705426614.git.dsterba@suse.com>
References: <cover.1705426614.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 2E7EE220AC
X-Spam-Flag: NO

Handle the lookup failure of the block group to unpin, this is a logic
error as the block group must exist at this point. If not, something else
must have freed it, like clean_pinned_extents() would do without locking
the unused_bg_unpin_mutex.

Push the errors to the callers, proper handling will be done in followup
patches.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c |  2 +-
 fs/btrfs/extent-tree.c | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index a9be9ac99222..1905d76772a9 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1429,7 +1429,7 @@ static bool clean_pinned_extents(struct btrfs_trans_handle *trans,
 	 * group in pinned_extents before we were able to clear the whole block
 	 * group range from pinned_extents. This means that task can lookup for
 	 * the block group after we unpinned it from pinned_extents and removed
-	 * it, leading to a BUG_ON() at unpin_extent_range().
+	 * it, leading to an error at unpin_extent_range().
 	 */
 	mutex_lock(&fs_info->unused_bg_unpin_mutex);
 	if (prev_trans) {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 8e8cc1111277..42293f617f42 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2780,6 +2780,7 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 	u64 total_unpinned = 0;
 	u64 empty_cluster = 0;
 	bool readonly;
+	int ret = 0;
 
 	while (start <= end) {
 		readonly = false;
@@ -2789,7 +2790,11 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 				btrfs_put_block_group(cache);
 			total_unpinned = 0;
 			cache = btrfs_lookup_block_group(fs_info, start);
-			BUG_ON(!cache); /* Logic error */
+			if (cache == NULL) {
+				/* Logic error, something removed the block group. */
+				ret = -EUCLEAN;
+				goto out;
+			}
 
 			cluster = fetch_cluster_info(fs_info,
 						     cache->space_info,
@@ -2858,7 +2863,8 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 
 	if (cache)
 		btrfs_put_block_group(cache);
-	return 0;
+out:
+	return ret;
 }
 
 int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
@@ -2888,7 +2894,8 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 						   end + 1 - start, NULL);
 
 		clear_extent_dirty(unpin, start, end, &cached_state);
-		unpin_extent_range(fs_info, start, end, true);
+		ret = unpin_extent_range(fs_info, start, end, true);
+		BUG_ON(ret);
 		mutex_unlock(&fs_info->unused_bg_unpin_mutex);
 		free_extent_state(cached_state);
 		cond_resched();
@@ -6170,7 +6177,11 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end)
 {
-	return unpin_extent_range(fs_info, start, end, false);
+	int ret;
+
+	ret = unpin_extent_range(fs_info, start, end, false);
+	BUG_ON(ret);
+	return ret;
 }
 
 /*
-- 
2.42.1


