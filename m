Return-Path: <linux-btrfs+bounces-7919-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFB3974747
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 02:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F3E7B213C6
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 00:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B6D63B9;
	Wed, 11 Sep 2024 00:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NTetWz8v";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NTetWz8v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A578423D2
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726014088; cv=none; b=ewvl32OtqI7bEbmn1kSV5SVlkmk3EgTHJ+cjaIwATdmycrE6ApTNA1mptMTG/0SuPpngkMtltPKA5cA9VOxdB37UtVvEHTx98dJehlDZMI3qdzsjevw6RfQUPxich/nURrbWPBsE1hvG5YG2IZUMqn3CcoQ7EYKP+wz4NtKyWaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726014088; c=relaxed/simple;
	bh=WwQ5hcKiZmCx4c6IDzEGv1ZaJ7DdBvvOGmTIyB0NKtk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RrM0akBNopySrkj+wt7TiV0HbkunXrc2y2BrPygloPcfu8JdKB27gFYpwPLSjMVl019ZrWiWAgwSKLU1+MoUMUy/CxxMDf5TQ+x9zLkwNONaO/bC+Ol7thlmcXnlioy0URjQeXfksBT5PnUxOgLdmX196R5QGSYZh8cWzCsAUzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NTetWz8v; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NTetWz8v; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B4F01FCF7
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 00:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726014084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1jFz+cPfP68dpLGIpABMkXB4sdXpElCgjoPtYQQUuI8=;
	b=NTetWz8vWOoTvwoTPdtBWwHa2w1wahyImcbSy+9tiqqnSiNM9pzHbXkmqBIjaQwWhyXcxz
	y1FcsfGtZOQJCNYx2y/0EaetNu2h4MmdroBB4AV6BVFGqWn+71RRtfL5VIgdGAr9o4GGit
	rUiSM8YmGyZFsW3cgnk2poYaJmETUA8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=NTetWz8v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726014084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1jFz+cPfP68dpLGIpABMkXB4sdXpElCgjoPtYQQUuI8=;
	b=NTetWz8vWOoTvwoTPdtBWwHa2w1wahyImcbSy+9tiqqnSiNM9pzHbXkmqBIjaQwWhyXcxz
	y1FcsfGtZOQJCNYx2y/0EaetNu2h4MmdroBB4AV6BVFGqWn+71RRtfL5VIgdGAr9o4GGit
	rUiSM8YmGyZFsW3cgnk2poYaJmETUA8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B82E0132CB
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 00:21:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PShaHoPi4GbXWQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 00:21:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: do not assume the full page range is not dirty in extent_writepage_io()
Date: Wed, 11 Sep 2024 09:51:02 +0930
Message-ID: <6239c8bb8ce319c2940d6469ffcb7f5f6641db79.1726011300.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7B4F01FCF7
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The function extent_writepage_io() will submit the dirty sectors inside
the page for the write.

But recently to co-operate with the incoming subpage compression
enhancement, a new bitmap is introduced to
btrfs_bio_ctrl::submit_bitmap, to only avoid a subset of the dirty
range.

This is because we can have the following cases with 64K page size:

    0      16K       32K       48K       64K
    |      |/////////|         |/|
                                 52K

For range [16K, 32K), we queue the dirty range for compression, which is
ran in a delayed workqueue.
Then for range [48K, 52K), we go through the regular submission path.

In that case, our btrfs_bio_ctrl::submit_bitmap will exclude the range
[16K, 32K).

The dirty flags for the range [16K, 32K) is only cleared when the
compression is done, by the extent_clear_unlock_delalloc() call inside
submit_one_async_extent().

This patch fix the false alert by removing the
btrfs_folio_assert_not_dirty() check, since it's no longer correct for
subpage compression cases.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This should be the last patch before the enablement of sector perfect
compression support for subpage.

Locally I have already been testing the sector perfect compression, and
that's the last fix.

All the subpage related fixes can be applied out of order as long as the
final enablement patch is at the end of the queue, but for now
my local branch has the following patch order (git log sequence):

 btrfs: allow compression even if the range is not page aligned
 btrfs: do not assume the full page range is not dirty in extent_writepage_io()
 btrfs: make extent_range_clear_diryt_for_io() to handle sector size < page size cases
 btrfs: wait for writeback if sector size is smaller than page size
 btrfs: compression: add an ASSERT() to ensure the read-in length is sane
 btrfs: zstd: make the compression path to handle sector size < page size
 btrfs: zlib: make the compression path to handle sector size < page size
---
 fs/btrfs/extent_io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 644e00d5b0f8..982bb469046f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1391,8 +1391,6 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			goto out;
 		submitted_io = true;
 	}
-
-	btrfs_folio_assert_not_dirty(fs_info, folio, start, len);
 out:
 	/*
 	 * If we didn't submitted any sector (>= i_size), folio dirty get
-- 
2.46.0


