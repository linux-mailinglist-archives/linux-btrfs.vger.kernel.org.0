Return-Path: <linux-btrfs+bounces-3277-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CC487BABB
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 10:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BEF41F2166D
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CD26E5EB;
	Thu, 14 Mar 2024 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XPK/Km21";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XPK/Km21"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5F96E2B3
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409835; cv=none; b=CCsCo201l/sPzK909Y5h4mO7aK4TCVhToQa3a0RiEBcUo8cw/OqpoDAZsHumzFLukKPymfedknMV5sxOkj9IlbEbG/KqyDrw6hpBZJyea4HdV4A4Y/RdpAhVmhRGqaKeWToJ8JAay/Tom75SJbTeY2MS1Sk1ZPZ7rs4U+np3lRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409835; c=relaxed/simple;
	bh=1rGFvwKZ9ruaY/wFabfMCJEUhxZ18bXmDIXy1XPKBHM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxamR5yFBoiYJhJoDjSCicZUBDuWi1JvrqRdHR/nOhm1TNU5t46L70/QkkQptROR/WBHiU1ljDOdH+nHXKT0XhNkrvcFSReua5QkIclvaoyoDaTKIbdpJnLJQ3S6uVPasqCC0asimMYWuvKIto93E5ICSZ/Tq1yqfhS03DqWAGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XPK/Km21; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XPK/Km21; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 118261F842
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710409832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s/+LuXzIqzU79/YNjxd7aHTICDFlJNmdOcwWQrzfktc=;
	b=XPK/Km21bz8VuEcYrX1/1JKf3OyHkdPS8WLkpwSHZGlRNkqzbATa5PLdsSal68x34tMTG0
	xEI2bdAmTzIR5EZOaZDEwB0DEXrgOnMBEKTZjE08VbxeMAV3IN/NYc66erlXA2GeilIH6e
	qRhU9E1stin/F/FfiHSPtPWkG3Djm7A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710409832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s/+LuXzIqzU79/YNjxd7aHTICDFlJNmdOcwWQrzfktc=;
	b=XPK/Km21bz8VuEcYrX1/1JKf3OyHkdPS8WLkpwSHZGlRNkqzbATa5PLdsSal68x34tMTG0
	xEI2bdAmTzIR5EZOaZDEwB0DEXrgOnMBEKTZjE08VbxeMAV3IN/NYc66erlXA2GeilIH6e
	qRhU9E1stin/F/FfiHSPtPWkG3Djm7A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C9A41386D
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qFemMWbI8mWPQQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/7] btrfs: scrub: simplify the inode iteration output
Date: Thu, 14 Mar 2024 20:20:18 +1030
Message-ID: <8a27a999b81dc317ff9420f87288cf9fdd6da4b7.1710409033.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710409033.git.wqu@suse.com>
References: <cover.1710409033.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 1.90
X-Spam-Flag: NO

The following two output are not really needed:

- nlinks
  Normally file inodes should have nlinks as 1, for those inodes have
  multiple hard links, the inode/root number is still enough to pin it
  down to certain inode.

- size
  The size is always fixed to sector size.

By removing the nlinks output, we can reduce one inode item lookup.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 277583464371..18b2ee3b1616 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -388,17 +388,13 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 				     u64 root, void *warn_ctx)
 {
-	u32 nlink;
 	int ret;
 	int i;
 	unsigned nofs_flag;
-	struct extent_buffer *eb;
-	struct btrfs_inode_item *inode_item;
 	struct scrub_warning *swarn = warn_ctx;
 	struct btrfs_fs_info *fs_info = swarn->dev->fs_info;
 	struct inode_fs_paths *ipath = NULL;
 	struct btrfs_root *local_root;
-	struct btrfs_key key;
 
 	local_root = btrfs_get_fs_root(fs_info, root, true);
 	if (IS_ERR(local_root)) {
@@ -406,26 +402,6 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 		goto err;
 	}
 
-	/*
-	 * this makes the path point to (inum INODE_ITEM ioff)
-	 */
-	key.objectid = inum;
-	key.type = BTRFS_INODE_ITEM_KEY;
-	key.offset = 0;
-
-	ret = btrfs_search_slot(NULL, local_root, &key, swarn->path, 0, 0);
-	if (ret) {
-		btrfs_put_root(local_root);
-		btrfs_release_path(swarn->path);
-		goto err;
-	}
-
-	eb = swarn->path->nodes[0];
-	inode_item = btrfs_item_ptr(eb, swarn->path->slots[0],
-					struct btrfs_inode_item);
-	nlink = btrfs_inode_nlink(eb, inode_item);
-	btrfs_release_path(swarn->path);
-
 	/*
 	 * init_path might indirectly call vmalloc, or use GFP_KERNEL. Scrub
 	 * uses GFP_NOFS in this context, so we keep it consistent but it does
@@ -451,12 +427,11 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 	 */
 	for (i = 0; i < ipath->fspath->elem_cnt; ++i)
 		btrfs_warn_in_rcu(fs_info,
-"%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu, length %u, links %u (path: %s)",
+"%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu, path: %s",
 				  swarn->errstr, swarn->logical,
 				  btrfs_dev_name(swarn->dev),
 				  swarn->physical,
 				  root, inum, offset,
-				  fs_info->sectorsize, nlink,
 				  (char *)(unsigned long)ipath->fspath->val[i]);
 
 	btrfs_put_root(local_root);
-- 
2.44.0


