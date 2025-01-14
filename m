Return-Path: <linux-btrfs+bounces-10966-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B81CFA10357
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2025 10:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92541888ECD
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2025 09:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9E528EC8E;
	Tue, 14 Jan 2025 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LJ4EFs6/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LJ4EFs6/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF82284A69
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736848383; cv=none; b=Cp+pdwOf5qjQkPo4UewchLjuvcfJCyCX+z4D/W2Mia9PQ+wfjZNNTopUE6TdOgHez/nSckiuNFayVtKRBjzmNFUcreOYgxrDprZ4GAjjoG0Wcoz0b8bQHUuTSpUejHazmEdkrHxinTETseotxt8y1XWyRJUMvia3yObI1EBX+7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736848383; c=relaxed/simple;
	bh=lqrQuJqG+eqgBS6bcOL1mGyychL0tBqzoznolkNdvpo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H66eV0Ht08Y+jeQV6PybrO0XuS1G5jmhbryJqN+1sTRBDDQaTjcwBpovlXYF6RvPhFjAuFbq0uSWsKJIhGScGhxd1+WhHR3BEe7WfW+Q8lOZQ51UMMJTp5LGSsAAKX64CrkOucja5VTlxQJVqRUFtH+JHOEztx1i/vHgb8Cx/6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LJ4EFs6/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LJ4EFs6/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D7B142115B
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 09:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736848379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3AR4PhzXMnxJdsuAnW0/2u+qCiy8b0t8cuGbGMMuw2c=;
	b=LJ4EFs6/u4+0XG1zkieejkOyrlwzUiYfSzqDPP01J/aFpgQ+4kQkyQYUNENkkhpss93dUZ
	zBrMjJIcRz3jqiIJDHi55rlBRjPwjwV4K8R/9M5ztdPsBZyxpG32JmPcjYiUq1pBkIKqUt
	c0OILhPiDltVnY2Myv0HBjHc4Mb0bSk=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736848379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3AR4PhzXMnxJdsuAnW0/2u+qCiy8b0t8cuGbGMMuw2c=;
	b=LJ4EFs6/u4+0XG1zkieejkOyrlwzUiYfSzqDPP01J/aFpgQ+4kQkyQYUNENkkhpss93dUZ
	zBrMjJIcRz3jqiIJDHi55rlBRjPwjwV4K8R/9M5ztdPsBZyxpG32JmPcjYiUq1pBkIKqUt
	c0OILhPiDltVnY2Myv0HBjHc4Mb0bSk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F188139CB
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 09:52:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IISzNPozhmeMAQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 09:52:58 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: allow buffered write to avoid full page read if it's block aligned
Date: Tue, 14 Jan 2025 20:22:29 +1030
Message-ID: <9a369da2d41e2d4d2f6e96d08e61b819360997bc.1736848277.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <cover.1736848277.git.wqu@suse.com>
References: <cover.1736848277.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

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
index c0ac742a04b8..a298d009a6cb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -976,6 +976,10 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
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
index 176815585ba5..bb821fb89fc1 100644
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
2.48.0


