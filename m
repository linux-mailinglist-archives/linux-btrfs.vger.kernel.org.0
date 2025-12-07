Return-Path: <linux-btrfs+bounces-19555-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BD2CABA15
	for <lists+linux-btrfs@lfdr.de>; Sun, 07 Dec 2025 22:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29B023015EC0
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Dec 2025 21:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3723B2E8B83;
	Sun,  7 Dec 2025 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aMHjjin4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="i8p51Z91"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8F01684A4
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Dec 2025 21:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765142069; cv=none; b=QtpvWd4Y6WLe2B8Rq7BciT044lNHxu/cWADDjDbYCsK7EQo6g+Y+T2StODXsRtp3tZc785M/x6Tf6w8xs+Lwy8GOndD7srqNtPNFrGFnGRJJxDn8/hfPzOWx92yglJUpHXFDEhUDKrWo5irqSXrlQ+W/eGrCCQYIKe+RN+dSzVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765142069; c=relaxed/simple;
	bh=CQxno53BAFkoGr63kiXWGhqDmSvq9JKEzo+5ZiUwk5A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=P5Kj+YoFA+FV6UtNPvbDiiXvxK9QzFtfb+cnDPgLbKFAXhkc8LFrCNxkybHrsxqWUsWiVVzVVg9xZi3NRZOySZ+t/o7a4AUtIGCoV9TFrGFphLA5JMfPmGTna8iuGhRqULVrPHVClqbef4EQAnoEH8SbHuJ0v6u+B9EfE7SIaqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aMHjjin4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=i8p51Z91; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC9EB5BD50
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Dec 2025 21:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765142065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UL0fIVBVeavMDXrH5qXl2A572mD2A17r9YGdgnf2GTo=;
	b=aMHjjin4/OGCXiqxS30stJvbYYE4tqapVBYHGuWzJcK+jhfFouamsXmr1IejWNBZHx4sur
	6fJFQjLKPf1M0NV+0TBoHLCM6THDqIFO1e9Vz/k5PftQc904DhU5Kr+xu61IKmJa9HtDMY
	mRgEfidEGMqd4cVI0X4IeFhd4z2oqq4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765142064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UL0fIVBVeavMDXrH5qXl2A572mD2A17r9YGdgnf2GTo=;
	b=i8p51Z91uhhj7z76hiPA59gjcN9Ii1bZiQ2fe8qnp60fKBqdCL6SMt33ncnAlGSdUbZqPf
	TIS+Sr8pw9d639cYXfmY4NYYmXX9BcbaRyqt4+ld1FVaMVjrZrX6c3T0Xp6xe33HCuIkMQ
	OF1RDQ3kdRrmT0XJeq4Nh1mE4r7Swz0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 224B23EA63
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Dec 2025 21:14:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8j39NC/uNWnWAwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 07 Dec 2025 21:14:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: enable direct IO for bs > ps cases
Date: Mon,  8 Dec 2025 07:43:58 +1030
Message-ID: <8490cf1099fa677bc3817257663c7abd85d46f2c.1765141954.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.69 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.09)[-0.442];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.69

Previously direct IO was disabled if the fs block size is larger than
the page size, the reasons are:

- Iomap direct IO can split the range ignoring the fs block alignment
  Which could trigger the bio size check from btrfs_submit_bio().

- The buffer is only ensured to be contiguous in user space memory
  The underlying physical memory is not ensured to be contiguous, and
  that can cause problems for the checksum generation/verification and
  RAID56 handling.

However above problems are solved by the following upstream commits:

- 001397f5ef49 ("iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag")
  Which added an extra flag that can be utilized by the fs to ensure
  the bio submitted by iomap is always aligned to fs block size.

- ec20799064c8 ("btrfs: enable encoded read/write/send for bs > ps cases")
- 8870dbeedcf9 ("btrfs: raid56: enable bs > ps support")
  Which makes btrfs to handle bios that are not backed by large folios
  but still are aligned to fs block size.

With above commits already in upstream, we can enable direct IO support
for bs > ps cases.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This is based on upstream kernel which relies on the commit from iomap
tree, which is not yet reflected in our for-next tree.
---
 fs/btrfs/direct-io.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 07e19e88ba4b..bc7cc2d81f8f 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -763,7 +763,7 @@ static ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter,
 	struct btrfs_dio_data data = { 0 };
 
 	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
-			    IOMAP_DIO_PARTIAL, &data, done_before);
+			    IOMAP_DIO_PARTIAL | IOMAP_DIO_FSBLOCK_ALIGNED, &data, done_before);
 }
 
 static struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
@@ -772,7 +772,7 @@ static struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *it
 	struct btrfs_dio_data data = { 0 };
 
 	return __iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
-			    IOMAP_DIO_PARTIAL, &data, done_before);
+			    IOMAP_DIO_PARTIAL | IOMAP_DIO_FSBLOCK_ALIGNED, &data, done_before);
 }
 
 static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
@@ -785,19 +785,6 @@ static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
 
 	if (iov_iter_alignment(iter) & blocksize_mask)
 		return -EINVAL;
-
-	/*
-	 * For bs > ps support, we heavily rely on large folios to make sure no
-	 * block will cross large folio boundaries.
-	 *
-	 * But memory provided by direct IO is only virtually contiguous, not
-	 * physically contiguous, and will break the btrfs' large folio requirement.
-	 *
-	 * So for bs > ps support, all direct IOs should fallback to buffered ones.
-	 */
-	if (fs_info->sectorsize > PAGE_SIZE)
-		return -EINVAL;
-
 	return 0;
 }
 
-- 
2.52.0


