Return-Path: <linux-btrfs+bounces-15665-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD8FB11727
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 05:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48993AE2E8C
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 03:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7191D238C06;
	Fri, 25 Jul 2025 03:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UKpj8M6n";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UKpj8M6n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1F0236431
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 03:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753414880; cv=none; b=ANJwTowd5K+pCMQhl8VP3RpIOMPlDxi5AknuzZhcF3HAw2JwcoGpXnuVr3DfGmAHq/lUtUVrDBiLkDaadipMTFFgMNM2LHZz8HWvQ57GzXpslmbPfgcRzqYWeX0b6W7y4jP//zYu8E9SrDjCL3zyJx7reDJn2eFnCBCdtC2mCQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753414880; c=relaxed/simple;
	bh=8OfUFNGsH1UWifs245d2r+j+7kQCcVDz0RuF/3nzM+w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D74ZM/0BaslxjdEQxmce6oVnS1c70chM97z8eHRfFS6I3ok4PyDEmUOBq7Ko4A1Zviz1Q6jtR1KeteMILlJp1IDrH0Rov8Otg/OBLInBaJPXLG5tqb+aE+COwz7jShtYa2DQfn6noEZ/275e7Hit7j0XtHOxMcyRvZmMj5XRbd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UKpj8M6n; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UKpj8M6n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AEE4B219C6
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 03:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753414863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c7s4CBoHr1wZYSteAeQbrJelBXpzzCXrxa+ad9TmDgQ=;
	b=UKpj8M6nwTxlwTwJ6IDqdabJ4mwLWdLOXbjbYIA8g+2VeH/HxOv8wOe0a6mw7G3oXPNxxo
	EI8DXn00KmbCLUcZItMtzomIFfh+Ec3iPt8QPqoBgJ3Bw2vCpZPiDr8PSukZL/bkr2dUL3
	M9Oe/N+4lW76Awgl/AkqKznmV4f17kA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=UKpj8M6n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753414863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c7s4CBoHr1wZYSteAeQbrJelBXpzzCXrxa+ad9TmDgQ=;
	b=UKpj8M6nwTxlwTwJ6IDqdabJ4mwLWdLOXbjbYIA8g+2VeH/HxOv8wOe0a6mw7G3oXPNxxo
	EI8DXn00KmbCLUcZItMtzomIFfh+Ec3iPt8QPqoBgJ3Bw2vCpZPiDr8PSukZL/bkr2dUL3
	M9Oe/N+4lW76Awgl/AkqKznmV4f17kA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC990134E8
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 03:41:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UL9MK878gmjbDQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 03:41:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: check/original: detect missing orphan items correctly
Date: Fri, 25 Jul 2025 13:10:41 +0930
Message-ID: <24cda813cf05892afb67f62f5c68cd28b478ec09.1753414100.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753414100.git.wqu@suse.com>
References: <cover.1753414100.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: AEE4B219C6
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

[BUG]
If we have a filesystem with a subvolume that has 0 refs but without an
orphan item, btrfs check won't report any error on it.

  $ btrfs ins dump-tree -t root /dev/test/scratch1
  btrfs-progs v6.15
  root tree
  node 5242880 level 1 items 2 free space 119 generation 11 owner ROOT_TREE
  node 5242880 flags 0x1(WRITTEN) backref revision 1
  fs uuid ff32309e-4e90-4402-b1ef-0a1f9f28bfff
  chunk uuid 6c373b6d-c866-4c8c-81fa-608bf5ef25e3
  	key (EXTENT_TREE ROOT_ITEM 0) block 5267456 gen 11
  	key (ROOT_TREE_DIR DIR_ITEM 2378154706) block 5246976 gen 11
  leaf 5267456 items 6 free space 2339 generation 11 owner ROOT_TREE
  leaf 5267456 flags 0x1(WRITTEN) backref revision 1
  fs uuid ff32309e-4e90-4402-b1ef-0a1f9f28bfff
  	[...]
  leaf 5246976 items 6 free space 1613 generation 11 owner ROOT_TREE
  leaf 5246976 flags 0x1(WRITTEN) backref revision 1
  checksum stored 47620783
  checksum calced 47620783
  fs uuid ff32309e-4e90-4402-b1ef-0a1f9f28bfff
  chunk uuid 6c373b6d-c866-4c8c-81fa-608bf5ef25e3
  	[...]
  	item 4 key (256 ROOT_ITEM 0) itemoff 2202 itemsize 439
  		generation 9 root_dirid 256 bytenr 5898240 byte_limit 0 bytes_used 581632
  		last_snapshot 0 flags 0x1000000000000(none) refs 0 <<<
  		drop_progress key (0 UNKNOWN.0 0) drop_level 0
  		level 2 generation_v2 9
  	item 5 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 1763 itemsize 439
  		generation 5 root_dirid 256 bytenr 5287936 byte_limit 0 bytes_used 4096
  		last_snapshot 0 flags 0x0(none) refs 1
  		drop_progress key (0 UNKNOWN.0 0) drop_level 0
  		level 0 generation_v2 5
  	^^^ No orphan item for subvolume 256.

Then "btrfs check" will not report anything wrong with it:

  Opening filesystem to check...
  Checking filesystem on /dev/test/scratch1
  UUID: ff32309e-4e90-4402-b1ef-0a1f9f28bfff
  [1/8] checking log skipped (none written)
  [2/8] checking root items
  [3/8] checking extents
  [4/8] checking free space tree
  [5/8] checking fs roots
  [6/8] checking only csums items (without verifying data)
  [7/8] checking root refs
  [8/8] checking quota groups skipped (not enabled on this FS)
  found 638976 bytes used, no error found <<<
  total csum bytes: 0
  total tree bytes: 638976
  total fs tree bytes: 589824
  total extent tree bytes: 16384
  btree space waste bytes: 289501
  file data blocks allocated: 0
   referenced 0

[CAUSE]
Although we have check_orphan_item() call inside check_root_refs(), it
relies the root record to have its 'found_root_item' member set.
Otherwise it will not report this as an error.

But that 'found_root_item' is always set to 0, if the subvolume has zero
ref, this means any subvolume with 0 refs will not have its orphan item
checked.

[FIX]
Set root_record::found_root_item to 1 inside check_fs_root().

As check_fs_root() is called after we found a root item, we should set
root_record::found_root_item to indicate this fact, and allows proper
orphan item check to be done.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/check/main.c b/check/main.c
index b78eb59d0c50..1536c1bbbccd 100644
--- a/check/main.c
+++ b/check/main.c
@@ -3728,8 +3728,7 @@ static int check_fs_root(struct btrfs_root *root,
 	if (root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID) {
 		rec = get_root_rec(root_cache, root->root_key.objectid);
 		BUG_ON(IS_ERR(rec));
-		if (btrfs_root_refs(root_item) > 0)
-			rec->found_root_item = 1;
+		rec->found_root_item = 1;
 	}
 
 	memset(&root_node, 0, sizeof(root_node));
-- 
2.50.0


