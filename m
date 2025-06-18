Return-Path: <linux-btrfs+bounces-14758-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB29ADE2FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 07:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17771898AEB
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 05:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1E21F473C;
	Wed, 18 Jun 2025 05:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mWyANFC+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mWyANFC+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC43E3A1DB
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 05:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750224252; cv=none; b=W+8iJEzC14NtqBNclAL5qkyBrAk5SfwVNyn2gMs0Pfr+0KRxGk7f4/NRuxDLrldUD60uQpHB1zOzU11BjO2BPc0+LUI1lBCr+JoV4yoUHDrjnGbpcwIexbJ3KLo69uRo/zfGOsiNjEEyNb8gwKFbWHP36VD/Xj918/4sitZc8b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750224252; c=relaxed/simple;
	bh=VCX7HTxrTxJrt9tvMpdLrTfwS+c4R+mw9Ijaali1s+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGIxIqhkbf3xncbW0Q3qsg/L8I0wvR4gC9lvSluyrKcu9sc4AUf5PYxeBJqDkguQ/NBYv25P8kbJdlU5RlqygpxT57y1xDxWmcfN8XAsAnLwa/y1QIfvss8zjj4Z2EPEd0g02mjHRxWYXGjNGy191KZ9MW0uasb41HX3Wx3yzR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mWyANFC+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mWyANFC+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B09B91F7B5;
	Wed, 18 Jun 2025 05:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750224241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UVoPlU1MfiTTryFy7qEUuZK33DmQLCHA1PW17CcCd+Q=;
	b=mWyANFC+AcCx2eW/D88JxA21k4AXLeUiA6EhFnEeYUdLMvexyBERItwM2Ujz+K4PRfsOw0
	cKlntbpbchXS3F4KxxYKRX/6mS5mBkALE+XLWuNe/AZuuPhQbLDUXSBDw/7RdPPVUAgXMH
	ZGtGqWR9H/FuW2NcVk5ZM8DfCTAK7U4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750224241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UVoPlU1MfiTTryFy7qEUuZK33DmQLCHA1PW17CcCd+Q=;
	b=mWyANFC+AcCx2eW/D88JxA21k4AXLeUiA6EhFnEeYUdLMvexyBERItwM2Ujz+K4PRfsOw0
	cKlntbpbchXS3F4KxxYKRX/6mS5mBkALE+XLWuNe/AZuuPhQbLDUXSBDw/7RdPPVUAgXMH
	ZGtGqWR9H/FuW2NcVk5ZM8DfCTAK7U4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B077913A99;
	Wed, 18 Jun 2025 05:24:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +FeJHHBNUmgbVAAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 18 Jun 2025 05:24:00 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Tine Mezgec <tine.mezgec@gmail.com>
Subject: [PATCH 1/3] btrfs-progs: tune: fix uninitialized value which leads to failed resume
Date: Wed, 18 Jun 2025 14:53:39 +0930
Message-ID: <2bd3e92bdd49a7fd1c7e87993169afb1804a3d9e.1750223785.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750223785.git.wqu@suse.com>
References: <cover.1750223785.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

[BUG]
There is a bug report that btrfstune failed to resume an interrupted
conversion.

I reproduced locally with an image which is half converted, in extent
tree there are 3 block groups:

	item 0 key (1048576 BLOCK_GROUP_ITEM 4194304) itemoff 3971 itemsize 24
	item 3 key (5242880 BLOCK_GROUP_ITEM 8388608) itemoff 3881 itemsize 24
	item 8 key (13631488 BLOCK_GROUP_ITEM 8388608) itemoff 3687 itemsize 24

And 4 block groups in the new block group tree:

	item 0 key (22020096 BLOCK_GROUP_ITEM 117440512) itemoff 3971 itemsize 24
	item 1 key (139460608 BLOCK_GROUP_ITEM 117440512) itemoff 3947 itemsize 24
	item 2 key (256901120 BLOCK_GROUP_ITEM 117440512) itemoff 3923 itemsize 24
	item 3 key (374341632 BLOCK_GROUP_ITEM 117440512) itemoff 3899 itemsize 24

Then resume the conversion will fail with the following error:

 $ btrfstune  --convert-to-block-group-tree /dev/test/scratch1
 ERROR: failed to find block group for bytenr 13631488
 ERROR: failed to convert the filesystem to block group tree feature
 ERROR: btrfstune failed
 extent buffer leak: start 23224320 len 4096

Meanwhile as the above dump tree shows, the block group item 13631488 is
indeed in the old extent tree.

[CAUSE]
During opening of such half-converted fs, btrfs will load the block
group items in two steps:

- read_old_block_groups_from_root()
  Which will load the block groups from the old tree (extent tree in the
  above case).

- read_block_groups_from_root()
  Which will load the block groups from the new tree (block group tree in
  the above case).

The problem is inside read_old_block_groups_from_root(), which uses an
on-stack @key to not only indicate where to start the search.

Unfortuantely we didn't initiliaze that @key structure, resulting
garbarge initial value, which can be larger than all block group items
in the extent tree.

So those block group items are not loaded into our block group cache,
then leads to the conversion failure, as we rely on the block group
cache built at opening time.

[FIX]
Fix the uninitialized @key by initializing it to zero, as we expect to
search for the first block group item.

So that the block group items in the old tree can be properly loaded.

Reported-by: Tine Mezgec <tine.mezgec@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/a90b9418-48e8-47bf-8ec0-dd377a7c1f4e@gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 2b7a962f294b..46f4eecb760a 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -2860,7 +2860,7 @@ static int read_old_block_groups_from_root(struct btrfs_fs_info *fs_info,
 					   struct btrfs_root *root)
 {
 	struct btrfs_path path = {0};
-	struct btrfs_key key;
+	struct btrfs_key key = { 0 };
 	struct cache_extent *ce;
 	/* The last block group bytenr in the old root. */
 	u64 last_bg_in_old_root;
-- 
2.49.0


