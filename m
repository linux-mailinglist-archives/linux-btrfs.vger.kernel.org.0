Return-Path: <linux-btrfs+bounces-11962-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE961A4B972
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 09:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDAA07A755F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 08:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423FF1EDA09;
	Mon,  3 Mar 2025 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mj8ua9h1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mj8ua9h1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8011EBA08
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990947; cv=none; b=hG9c9oeks9hlDthz2dUEYK4eV0wXzyBZH3wii1s1KYdTIiMX4/WaEteiMy24/V7hmUJk0AOTp3/KNgohYsEuNfXjIK70pLq3/p5BpfVL3jCUJHaGsecJFxoA0/sxCUT94Nd02nK6H05ZTE1e5wuSubH3z5en2AagRErSn0GGKIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990947; c=relaxed/simple;
	bh=GRZUTY+7d81RsBiXA1iNcuftmAnbdxK6BJAqFYj8l0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4GFQmhLhBmcCXeBvHROp+v1entjF3j2HCAGEjk+XcpSTZpBWr2qEyBCyiU37TfkeJ33RADSckdo3L8+09Ea6AjeXRNj8PzFNLueXPEeIk9tdEeI6OB/llJU4qToSpPRkh1LIxbWhmpYRMw5/eW/aXjVIDvz98EBDdSQx5b5RyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mj8ua9h1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mj8ua9h1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C3E8921168;
	Mon,  3 Mar 2025 08:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740990943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3xIGlFzWKD1gNi+gSIQnJ528NYhJqG5ws4DL1BE1lqE=;
	b=mj8ua9h1/GPa4Ftm+YQXNNm+6xKlObEssUSwRBUdCYnJv7Kx3nof2a2RqLpHVO19jclLfT
	Iq7G+YePYThO5M6iNTd+8RGvIpseq4ST+cET9h+WTqSUKqTKNbzYb5abgH5S0lOYZKcd2U
	zTnkB0d2oP6Lbviur6SKYy8ZAQRDS9Y=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mj8ua9h1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740990943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3xIGlFzWKD1gNi+gSIQnJ528NYhJqG5ws4DL1BE1lqE=;
	b=mj8ua9h1/GPa4Ftm+YQXNNm+6xKlObEssUSwRBUdCYnJv7Kx3nof2a2RqLpHVO19jclLfT
	Iq7G+YePYThO5M6iNTd+8RGvIpseq4ST+cET9h+WTqSUKqTKNbzYb5abgH5S0lOYZKcd2U
	zTnkB0d2oP6Lbviur6SKYy8ZAQRDS9Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C494B13939;
	Mon,  3 Mar 2025 08:35:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4K9dId5pxWdybwAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 03 Mar 2025 08:35:42 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v3 6/8] btrfs: allow buffered write to avoid full page read if it's block aligned
Date: Mon,  3 Mar 2025 19:05:14 +1030
Message-ID: <f63e7f8589a852bb1e74179ddc6bc6808437aaab.1740990125.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740990125.git.wqu@suse.com>
References: <cover.1740990125.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C3E8921168
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

But on 64K page sized systems, although the 4K sized write is still block
aligned, it's not page aligned any more, thus btrfs will read the full
page, which will be accounted by cgroup and fail the test.

As the test case itself expects such 4K block aligned write should not
trigger any read.

Such expected behavior is an optimization to reduce folio reads when
possible, and unfortunately btrfs does not implement such optimization.

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

With this optimization, btrfs can pass generic/563 even if the page size
is larger than fs block size.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 4 ++++
 fs/btrfs/file.c      | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0b0af6e11196..57906c226220 100644
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
index fe9e98f916f4..23a8fabd390e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -804,14 +804,15 @@ static int prepare_uptodate_folio(struct inode *inode, struct folio *folio, u64
 {
 	u64 clamp_start = max_t(u64, pos, folio_pos(folio));
 	u64 clamp_end = min_t(u64, pos + len, folio_pos(folio) + folio_size(folio));
+	const u32 blocksize = inode_to_fs_info(inode)->sectorsize;
 	int ret = 0;
 
 	if (folio_test_uptodate(folio))
 		return 0;
 
 	if (!force_uptodate &&
-	    IS_ALIGNED(clamp_start, PAGE_SIZE) &&
-	    IS_ALIGNED(clamp_end, PAGE_SIZE))
+	    IS_ALIGNED(clamp_start, blocksize) &&
+	    IS_ALIGNED(clamp_end, blocksize))
 		return 0;
 
 	ret = btrfs_read_folio(NULL, folio);
-- 
2.48.1


