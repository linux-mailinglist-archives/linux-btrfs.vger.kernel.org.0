Return-Path: <linux-btrfs+bounces-8040-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D127C979979
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 01:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB6D28394B
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Sep 2024 23:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9BE77117;
	Sun, 15 Sep 2024 23:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mfxs1se2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mfxs1se2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1474882499
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Sep 2024 23:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726441928; cv=none; b=FBcQ3mtnNe3ZSjfFMfZKl5ebeLqbSMeCNFfdDYxR7vd48WvfE8Oy+7WJCaYzhaFVxrS5F3gXZPC7GVrKgrw5JoWcgECJXjurkEkCYxVpUExz+w51JxVmL/MygxxWdpHPOh6YEgogZHaqXB6OXmzNfqWcDyQS3eSHuOxI5dwjdAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726441928; c=relaxed/simple;
	bh=9bBusgCjGF53LYcgcdTXzbVlkkdksIta144VWw7xr10=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSoS/8qiHgOhNm5B/PWbdbpuPpWgmMT3VarMDY27JjLfC8wrG5VAXVnue0J/4BVLy2zD7MZ4BjGzEep7svJq7LzZGkUb5oORJNeJLvXFvA+Zpdgy1ppqORejyxYUAKpLgkuXMevJMjm5e3c/QPiLlcMpkxKzPVOhCKGRimFZk+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mfxs1se2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mfxs1se2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 597C321BCA
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Sep 2024 23:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726441915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZc2Y/Y4xOhSSdOayAc1iJ5f0t3P2u2QtUui6jhuBk8=;
	b=mfxs1se237/4NJMNBhQ5HAgzp9uJPg1zfXFM6vqL+W7eqgKIsMkzzEmLT92aDt/Om8xoxo
	ejv7Nd46NPp0oBtfeldt7pBqvOyZAyiiXseyvMhmhHfKe2TK23ICx84AYZtIlt4Do0nWQ5
	tou2TXaBYxFwzFqFeaJXkbSDpQ6MiV8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mfxs1se2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726441915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZc2Y/Y4xOhSSdOayAc1iJ5f0t3P2u2QtUui6jhuBk8=;
	b=mfxs1se237/4NJMNBhQ5HAgzp9uJPg1zfXFM6vqL+W7eqgKIsMkzzEmLT92aDt/Om8xoxo
	ejv7Nd46NPp0oBtfeldt7pBqvOyZAyiiXseyvMhmhHfKe2TK23ICx84AYZtIlt4Do0nWQ5
	tou2TXaBYxFwzFqFeaJXkbSDpQ6MiV8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F7BD1351A
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Sep 2024 23:11:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qFsGFLpp52aRLAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Sep 2024 23:11:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: mark all dirty sectors as locked inside writepage_delalloc()
Date: Mon, 16 Sep 2024 08:41:30 +0930
Message-ID: <923723bd483d3c30997e56f31f5ca80fc7630fd0.1726441226.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726441226.git.wqu@suse.com>
References: <cover.1726441226.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 597C321BCA
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Currently we only mark sectors as locked if there is a *NEW* delalloc
range for it.

But NEW delalloc range is not the same as dirty sectors we want to
submit, e.g:

        0       32K      64K      96K       128K
        |       |////////||///////|    |////|
                                       120K

For above 64K page size case, writepage_delalloc() for page 0 will find
and lock the delalloc range [32K, 96K), which is beyond the page
boundary.

Then when writepage_delalloc() is called for the page 64K, since [64K,
96K) is already locked, only [120K, 128K) will be locked.

This means, although range [64K, 96K) is dirty and will be submitted
later by extent_writepage_io(), it will not be marked as locked.

This is fine for now, as we call btrfs_folio_end_writer_lock_bitmap() to
free every non-compressed sector, and compression is only allowed for
full page range.

But this is not safe for future sector perfect compression support, as
this can lead to double folio unlock:

              Thread A                 |           Thread B
---------------------------------------+--------------------------------
                                       | submit_one_async_extent()
				       | |- extent_clear_unlock_delalloc()
extent_writepage()                     |    |- btrfs_folio_end_writer_lock()
|- btrfs_folio_edn_writer_lock_bitmap()|       |- btrfs_subpage_end_and_test_writer()
   |                                   |       |  |- atomic_sub_and_test()
   |                                   |       |     /* Now the atomic value is 0 */
   |- if (atomic_read() == 0)          |       |
   |- folio_unlock()                   |       |- folio_unlock()

The root cause is the above range [64K, 96K) is dirtied and should also
be locked but it isn't.

So to make everything more consistent and prepare for the incoming
sector perfect compression, mark all dirty sectors as locked.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1210e24b6277..1041a7060b2a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1170,6 +1170,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	u64 delalloc_end = page_end;
 	u64 delalloc_to_write = 0;
 	int ret = 0;
+	int bit;
 
 	/* Save the dirty bitmap as our submission bitmap will be a subset of it. */
 	if (btrfs_is_subpage(fs_info, inode->vfs_inode.i_mapping)) {
@@ -1179,6 +1180,12 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		bio_ctrl->submit_bitmap = 1;
 	}
 
+	for_each_set_bit(bit, &bio_ctrl->submit_bitmap, fs_info->sectors_per_page) {
+		u64 start = page_start + (bit << fs_info->sectorsize_bits);
+
+		btrfs_folio_set_writer_lock(fs_info, folio, start, fs_info->sectorsize);
+	}
+
 	/* Lock all (subpage) delalloc ranges inside the folio first. */
 	while (delalloc_start < page_end) {
 		delalloc_end = page_end;
@@ -1189,9 +1196,6 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		}
 		set_delalloc_bitmap(folio, &delalloc_bitmap, delalloc_start,
 				    min(delalloc_end, page_end) + 1 - delalloc_start);
-		btrfs_folio_set_writer_lock(fs_info, folio, delalloc_start,
-					    min(delalloc_end, page_end) + 1 -
-					    delalloc_start);
 		last_delalloc_end = delalloc_end;
 		delalloc_start = delalloc_end + 1;
 	}
-- 
2.46.0


