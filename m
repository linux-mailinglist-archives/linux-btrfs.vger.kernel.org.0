Return-Path: <linux-btrfs+bounces-11630-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E51EBA3D5F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15F5A7AC750
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1041EE7D3;
	Thu, 20 Feb 2025 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SxX4GSh9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TgNkRw49"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202411F462D
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045717; cv=none; b=NCkbiXWQzBgBUHKMRFXJAHTl1HiQZc2UZ1TybkWORzd0UbGtGk7yN1vfB0kk2edkjHd7G82UPL2VPnA3qoyIPptQyt9lfANoJLlLYP1GylW+VOXaPAiRF/ucOP9xK7mXoB8pjBlcWSvHbAa6QBfKx43tURhtyCxg3FCQSOHc2xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045717; c=relaxed/simple;
	bh=lTl2Utm/WMfPNG7Ks5L1CtDYUa8gg1tg8W2ZA7mmTkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBdnytkdR4khqARjDOoPFINsZw7QhoBMQxnQfjq680UKoMzNi4DCWU+oQzG7l6TiDvKlPrrqz644kTDnGMt6Og1BQ6VJzqcL4xZ9lANEoDwRRWOgzcgHxE/yS+JL7mVAqpIUiXgi9hu5C549eUAvl4heAQlEC8I7FbHyKXK6e/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SxX4GSh9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TgNkRw49; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F286B1F387;
	Thu, 20 Feb 2025 10:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3h+h9Cfdtb3UuLisXzq7Em57C/hbkq+7BwibWkpa/5k=;
	b=SxX4GSh9PcrYCwIt8QU8OScOkEwsHImXY5qITfvQ5YHp8VeoYd/ltZqGkqKXmMFGCplVW+
	nhMZqmZwLvab5RbD7OOH3RZJ036hbV+cObFZq6wS1HZn+wnGGxrI31G7B8RTa03/hb2d7P
	DJ+1KwULGpJcELTroXhlxWMLsLnfgTY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=TgNkRw49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3h+h9Cfdtb3UuLisXzq7Em57C/hbkq+7BwibWkpa/5k=;
	b=TgNkRw49L3JKu14hfcci0XE8cd8dHM8c0iGMnXAyPmRGkpSJl3dod7PMrDmbl4exaTuLTv
	gJrn57wHdFc0UoVXcYRc4jprSZixl6Ixw26ppDWCQlw8u9y+zX57B/LRv0Z/vtEG4NqJVV
	bOANAWzoxxtUlJw1i4I2/ODOpRYfTIU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB7D013301;
	Thu, 20 Feb 2025 10:01:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Kyl7OY79tme0fwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:01:50 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 18/22] btrfs: pass struct btrfs_inode to btrfs_extent_same_range()
Date: Thu, 20 Feb 2025 11:01:46 +0100
Message-ID: <5f3dbd41c0a59916b88980a40f059618a561afef.1740045551.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740045551.git.dsterba@suse.com>
References: <cover.1740045551.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F286B1F387
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Pass a struct btrfs_inode to btrfs_extent_same_range() as it's an
internal interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/reflink.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index f3aa3f4e9684..63d4a4d22801 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -631,12 +631,12 @@ static void btrfs_double_mmap_unlock(struct btrfs_inode *inode1, struct btrfs_in
 	up_write(&inode2->i_mmap_lock);
 }
 
-static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
-				   struct inode *dst, u64 dst_loff)
+static int btrfs_extent_same_range(struct btrfs_inode *src, u64 loff, u64 len,
+				   struct btrfs_inode *dst, u64 dst_loff)
 {
 	const u64 end = dst_loff + len - 1;
 	struct extent_state *cached_state = NULL;
-	struct btrfs_fs_info *fs_info = BTRFS_I(src)->root->fs_info;
+	struct btrfs_fs_info *fs_info = src->root->fs_info;
 	const u64 bs = fs_info->sectorsize;
 	int ret;
 
@@ -646,9 +646,10 @@ static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
 	 * because we have already locked the inode's i_mmap_lock in exclusive
 	 * mode.
 	 */
-	lock_extent(&BTRFS_I(dst)->io_tree, dst_loff, end, &cached_state);
-	ret = btrfs_clone(src, dst, loff, len, ALIGN(len, bs), dst_loff, 1);
-	unlock_extent(&BTRFS_I(dst)->io_tree, dst_loff, end, &cached_state);
+	lock_extent(&dst->io_tree, dst_loff, end, &cached_state);
+	ret = btrfs_clone(&src->vfs_inode, &dst->vfs_inode, loff, len,
+			  ALIGN(len, bs), dst_loff, 1);
+	unlock_extent(&dst->io_tree, dst_loff, end, &cached_state);
 
 	btrfs_btree_balance_dirty(fs_info);
 
@@ -678,8 +679,8 @@ static int btrfs_extent_same(struct inode *src, u64 loff, u64 olen,
 	chunk_count = div_u64(olen, BTRFS_MAX_DEDUPE_LEN);
 
 	for (i = 0; i < chunk_count; i++) {
-		ret = btrfs_extent_same_range(src, loff, BTRFS_MAX_DEDUPE_LEN,
-					      dst, dst_loff);
+		ret = btrfs_extent_same_range(BTRFS_I(src), loff, BTRFS_MAX_DEDUPE_LEN,
+					      BTRFS_I(dst), dst_loff);
 		if (ret)
 			goto out;
 
@@ -688,7 +689,8 @@ static int btrfs_extent_same(struct inode *src, u64 loff, u64 olen,
 	}
 
 	if (tail_len > 0)
-		ret = btrfs_extent_same_range(src, loff, tail_len, dst, dst_loff);
+		ret = btrfs_extent_same_range(BTRFS_I(src), loff, tail_len,
+					      BTRFS_I(dst), dst_loff);
 out:
 	spin_lock(&root_dst->root_item_lock);
 	root_dst->dedupe_in_progress--;
-- 
2.47.1


