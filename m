Return-Path: <linux-btrfs+bounces-17024-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CE9B8E90A
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 00:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715EA18998A1
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Sep 2025 22:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486D5251793;
	Sun, 21 Sep 2025 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GIayMVI6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GIayMVI6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3122550BA
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Sep 2025 22:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758494519; cv=none; b=m6DK58xNgquDExrDFagwk70bdNIF/qngCd+BBZuRWa5zkaDHjmZ87zuEsjQi5ZfalEI+Cfd/wENcN5/Zu7w/LUcbq0NM3tGh+p8v97DRj3eKXJDrpqH8Ls3JnYQu/eU6V/TRZ0+wiZt35SIR/ZjKrO8zLkc5cz7/CF8qHIgehio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758494519; c=relaxed/simple;
	bh=Oq3iMi6/JCMEL+JsxqJddpd01mPy1mjTbUgGJEoP5Sk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLIo0MZfBGUAC82CdLULVV7F0MA6Qm0yBbY7eZjwSoA9oTpHYozrWSST0zZXa4/BAcQKdD7FiCT6BBzeLlDgMQd5XPp/bvXc9dUHkRTqOQjk6BI7sj7VYfTPvywG9DJp5xvBxbrq0T8XtjEWZgEBWHgkJbV+U3k5rwaVOonZA6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GIayMVI6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GIayMVI6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B2CA02240A
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Sep 2025 22:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758494479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5smTf8QxquUNmVU6Z06bfG6PkzgcdeOWHbOBoMDy56M=;
	b=GIayMVI6ourfDNNvpko5g8HyLCAS2Qy2+jmC8Yvqi7z3xdBWfE8EH0r8IgkXAeMiQ939BW
	OO7XFx4BtvK3MG2L8UUYiBEvdCoW6I9VTF2FQcUjAb5aVPAj1e3S3dusxr8q3KFFhvEV4p
	4TB4EvQTeJwhspl/9F9Jjpl7JORkGlw=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=GIayMVI6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758494479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5smTf8QxquUNmVU6Z06bfG6PkzgcdeOWHbOBoMDy56M=;
	b=GIayMVI6ourfDNNvpko5g8HyLCAS2Qy2+jmC8Yvqi7z3xdBWfE8EH0r8IgkXAeMiQ939BW
	OO7XFx4BtvK3MG2L8UUYiBEvdCoW6I9VTF2FQcUjAb5aVPAj1e3S3dusxr8q3KFFhvEV4p
	4TB4EvQTeJwhspl/9F9Jjpl7JORkGlw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00B2F13ACD
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Sep 2025 22:41:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gGCNLQ5/0GisdwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Sep 2025 22:41:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 8/9] btrfs: add extra ASSERT()s to catch unaligned bios
Date: Mon, 22 Sep 2025 08:10:50 +0930
Message-ID: <3e81d39bab2b434ae643cbc62bb1127c4ba2b9ca.1758494327.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1758494326.git.wqu@suse.com>
References: <cover.1758494326.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: B2CA02240A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Btrfs uses btrfs_bio to handle read/write of logical address, for the
incoming bs > ps support, btrfs has extra requirements:

- One folio must contain at least one fs block
- No fs block can cross folio boundaries

This requirement is not hard to maintain, thanks to the address space's
minimal folio order.

But not all btrfs bios are generated through address space, e.g.
compression and scrub.

To catch possible unaligned bios, introduce a helper,
assert_bbio_alginment(), for each btrfs_bio in btrfs_submit_bbio().

This will check the following things:

- bv_offset is aligned to block size
- bv_len is aligned to block size

With a btrfs bio passing above checks, unless it's empty it will ensure
the requirements for bs > ps support.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 909b208f9ef3..db2deaa4aad4 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -779,11 +779,38 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	return true;
 }
 
+static void assert_bbio_alignment(struct btrfs_bio *bbio)
+{
+#ifdef CONFIG_BTRFS_ASSERT
+	struct btrfs_fs_info *fs_info = bbio->fs_info;
+	struct bio_vec bvec;
+	struct bvec_iter iter;
+	const u32 blocksize = fs_info->sectorsize;
+
+	/* Metadata has no extra bs > ps alignment requirement. */
+	if (!is_data_bbio(bbio))
+		return;
+
+	bio_for_each_bvec(bvec, &bbio->bio, iter)
+		ASSERT(IS_ALIGNED(bvec.bv_offset, blocksize) &&
+		       IS_ALIGNED(bvec.bv_len, blocksize),
+		"root=%llu inode=%llu logical=%llu length=%u index=%u bv_offset=%u bv_len=%u",
+		btrfs_root_id(bbio->inode->root),
+		btrfs_ino(bbio->inode),
+		bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT,
+		bbio->bio.bi_iter.bi_size, iter.bi_idx,
+		bvec.bv_offset,
+		bvec.bv_len);
+#endif
+}
+
 void btrfs_submit_bbio(struct btrfs_bio *bbio, int mirror_num)
 {
 	/* If bbio->inode is not populated, its file_offset must be 0. */
 	ASSERT(bbio->inode || bbio->file_offset == 0);
 
+	assert_bbio_alignment(bbio);
+
 	while (!btrfs_submit_chunk(bbio, mirror_num))
 		;
 }
-- 
2.50.1


