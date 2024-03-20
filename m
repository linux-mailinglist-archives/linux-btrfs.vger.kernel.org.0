Return-Path: <linux-btrfs+bounces-3461-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF601880A40
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 04:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A267A283A23
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 03:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B275D168AC;
	Wed, 20 Mar 2024 03:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uECvWB3r";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uECvWB3r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F2913AC4
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 03:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710906913; cv=none; b=pH70iftiLDde41nQgkFJ4ExAELPUA/YlmxvlP+t8Rb2amXZ+DO06Ccj0ugn1jng/VU71ppzO+mRD1aKrEKwvLFgc8SzMLHcokaCoID2r5usyDL86j4riPuGM0wpkprw4Ec9w5kxWKCfLAzgepwtzTlt4Ppq7AmhWT0OtbwLzPVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710906913; c=relaxed/simple;
	bh=pOVwi7Wh7yp2Xw3f1/jlLTgEDpctb3BjD4RMBpGrIVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUdARZN2Qlj8VJ3xnE+0vzZVRK39KyCXNU350mW7FFY6Cp/Rb3vUlOBaWMJqKX5inG209SmklRI2kyDze1bKFu+rpcVZqXXIYi9O9P7xk9wW/JX00XpfoVy2AQ/STOuNqdSVVoVbGuM2aI6bcRlN0wGsC2+rbKiw7UCsetAlRFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uECvWB3r; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uECvWB3r; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B6C133B82;
	Wed, 20 Mar 2024 03:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710906910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+xGc9ILGVHv+/r7RGc88yykfkif2rnkjdJjggDo2qs=;
	b=uECvWB3rJa628IXChtRl5C0a9FgHiejd0X9U2ZbNi7EQvqWSCs4EG6ekXUPvKJ2Kh4AVaZ
	ql0VaxaaNYKK/is8nE+UaR0/lZxLHwqBfGF7ni8ea09Wp5WkD8/2WcjtVI+d5HJhNqMxoh
	0Ezn8mJioD5k56mImoT1iLgq7CyrYXQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710906910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+xGc9ILGVHv+/r7RGc88yykfkif2rnkjdJjggDo2qs=;
	b=uECvWB3rJa628IXChtRl5C0a9FgHiejd0X9U2ZbNi7EQvqWSCs4EG6ekXUPvKJ2Kh4AVaZ
	ql0VaxaaNYKK/is8nE+UaR0/lZxLHwqBfGF7ni8ea09Wp5WkD8/2WcjtVI+d5HJhNqMxoh
	0Ezn8mJioD5k56mImoT1iLgq7CyrYXQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46DB8136AE;
	Wed, 20 Mar 2024 03:55:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eJ25Ohxe+mVlbgAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 20 Mar 2024 03:55:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 5/7] btrfs: scrub: simplify the inode iteration output
Date: Wed, 20 Mar 2024 14:24:55 +1030
Message-ID: <56f5b6279f2fbb5197d09e774619495d313df1ab.1710906371.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710906371.git.wqu@suse.com>
References: <cover.1710906371.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=uECvWB3r
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -1.51
X-Rspamd-Queue-Id: 6B6C133B82
X-Spam-Flag: NO

The following two output are not really needed:

- nlinks
  Normally file inodes should have nlinks as 1, for those inodes have
  multiple hard links, the inode/root number is still enough to pin it
  down to certain inode.

- size
  The size is always fixed to sector size.

By removing the nlinks output, we can reduce one inode item lookup.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ff952dd2b510..85f321e3e37c 100644
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


