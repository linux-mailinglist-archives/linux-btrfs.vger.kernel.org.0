Return-Path: <linux-btrfs+bounces-11389-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F99A31C5D
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 03:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402EF1889366
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 02:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4F21D86E8;
	Wed, 12 Feb 2025 02:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gkOAdw3v";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gkOAdw3v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA461D6DDD
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 02:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328798; cv=none; b=M26thcxwiHJZKHok7pxC9YwsmTWK5FG089ZtlZbU7GE+9mbdtQOwXEIcVNX4cJLDLFw9NJCdUrH4a57PQbvLM3YXm8p4KK7twXx1CAtbFMH+fMUI4rITtBMisJToAOYy0Cl3YKsXIKFx14XwTCVTfhm4XqHJA5AybrOwvHbgeA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328798; c=relaxed/simple;
	bh=KrOb/s/6eYbIrSEDr6uee+ki+Dc1iHO9sN4JbXaF9+Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJd/+8JriPtQbYufJMCVsA0+CeRLt46ppfk5lnvgs0JuzDE8aNmrQCoQw0BKmYQhutypJ18PTkm8YYn6lrnPCLWFsBEShTDstLe/uGOs+wPsm9iPVQa6e2IVhXrlXpYYrKaS2KkRcENQ8+S5OrcGrhyYWuOeneCgBQjX0A5f+mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gkOAdw3v; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gkOAdw3v; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 87F462005E
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 02:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739328793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kpvGchbLxgqKnNxHQ6b62x9pldTRCqRxe5YpBqB4brs=;
	b=gkOAdw3v/PBpInjybDDzMfQ0O2ZQVddAvFofvL4ADjtosGfqDzSjcLUa+0q7zaDDjRRVPT
	3XcflEKfhYBDyTFHmRuKoyye2T3kwwmXkv/kgNBAW56QTyVoa2KCtm4oH+7RkPvfx5zC0m
	zxPMVT+tldHQNncVx196I4vmG8haCWc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=gkOAdw3v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739328793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kpvGchbLxgqKnNxHQ6b62x9pldTRCqRxe5YpBqB4brs=;
	b=gkOAdw3v/PBpInjybDDzMfQ0O2ZQVddAvFofvL4ADjtosGfqDzSjcLUa+0q7zaDDjRRVPT
	3XcflEKfhYBDyTFHmRuKoyye2T3kwwmXkv/kgNBAW56QTyVoa2KCtm4oH+7RkPvfx5zC0m
	zxPMVT+tldHQNncVx196I4vmG8haCWc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C148B13874
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 02:53:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0Np/IBgNrGc/UAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 02:53:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs: allow buffered write to avoid full page read if it's block aligned
Date: Wed, 12 Feb 2025 13:22:47 +1030
Message-ID: <4516745df779bcccc39e9ca357575c20fa70c927.1739328504.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739328504.git.wqu@suse.com>
References: <cover.1739328504.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 87F462005E
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
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

[BUG]
Since the support of block size (sector size) < page size for btrfs,
test case generic/563 fails with 4K block size and 64K page size:

    --- tests/generic/563.out	2024-04-25 18:13:45.178550333 +0930
    +++ /home/adam/xfstests-dev/results//generic/563.out.bad	2024-09-30 09:09:16.155312379 +0930
    @@ -3,7 +3,8 @@
     read is in range
     write is in range
     write -> read/write
    -read is in range
    +read has value of 8388608
    +read is NOT in range -33792 .. 33792
     write is in range
    ...

[CAUSE]
The test case creates a 8MiB file, then buffered write into the 8MiB
using 4K block size, to overwrite the whole file.

On 4K page sized systems, since the write range covers the full block and
page, btrfs will no bother reading the page, just like what XFS and EXT4
do.

But 64K page sized systems, although the 4K sized write is still block
aligned, it's not page aligned any more, thus btrfs will read the full
page, causing more read than expected and fail the test case.

[FIX]
To skip the full page read, we need to do the following modification:

- Do not trigger full page read as long as the buffered write is block
  aligned
  This is pretty simple by modifying the check inside
  prepare_uptodate_page().

- Skip already uptodate blocks during full page read
  Or we can lead to the following data corruption:

  0       32K        64K
  |///////|          |

  Where the file range [0, 32K) is dirtied by buffered write, the
  remaining range [32K, 64K) is not.

  When reading the full page, since [0,32K) is only dirtied but not
  written back, there is no data extent map for it, but a hole covering
  [0, 64k).

  If we continue reading the full page range [0, 64K), the dirtied range
  will be filled with 0 (since there is only a hole covering the whole
  range).
  This causes the dirtied range to get lost.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 4 ++++
 fs/btrfs/file.c      | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 64812045a42d..abf43805ea92 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -971,6 +971,10 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 			end_folio_read(folio, true, cur, end - cur + 1);
 			break;
 		}
+		if (btrfs_folio_test_uptodate(fs_info, folio, cur, blocksize)) {
+			end_folio_read(folio, true, cur, blocksize);
+			continue;
+		}
 		em = get_extent_map(BTRFS_I(inode), folio, cur, end - cur + 1, em_cached);
 		if (IS_ERR(em)) {
 			end_folio_read(folio, false, cur, end + 1 - cur);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 81e6cb599585..83a7238e8c2e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -804,14 +804,15 @@ static int prepare_uptodate_folio(struct inode *inode, struct folio *folio, u64
 {
 	u64 clamp_start = max_t(u64, pos, folio_pos(folio));
 	u64 clamp_end = min_t(u64, pos + len, folio_pos(folio) + folio_size(folio));
+	const u32 sectorsize = inode_to_fs_info(inode)->sectorsize;
 	int ret = 0;
 
 	if (folio_test_uptodate(folio))
 		return 0;
 
 	if (!force_uptodate &&
-	    IS_ALIGNED(clamp_start, PAGE_SIZE) &&
-	    IS_ALIGNED(clamp_end, PAGE_SIZE))
+	    IS_ALIGNED(clamp_start, sectorsize) &&
+	    IS_ALIGNED(clamp_end, sectorsize))
 		return 0;
 
 	ret = btrfs_read_folio(NULL, folio);
-- 
2.48.1


