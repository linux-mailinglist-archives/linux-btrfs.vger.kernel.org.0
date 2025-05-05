Return-Path: <linux-btrfs+bounces-13676-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5880AAA0DD
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 00:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB88D1884F11
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 22:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAFC296FC7;
	Mon,  5 May 2025 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VP8hxYFq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3222296FA9;
	Mon,  5 May 2025 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483526; cv=none; b=awNv8QfTMDouCpyagP3Ho6kuIRHaxB1nmIpa2uEJ6RJDWE1bbA7C9RN6P4yVVtP+A8IPQT//GG9Hn21SjnduTLTagqlzMvI9h7RoExW3see1NvSN68TCyX05WPHYq9VO1cCKl795FqojPO0hZ77X5fDp3qsXq+h/UAiidDDP6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483526; c=relaxed/simple;
	bh=q1JvmxNM/hA0zdhzdIprJ7SuWYJlD1UWCpYgZR3dDsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EcYI4cm9TQVjePEB+Q6TCHQO1YqsjlYHGVxjFHKQsEUI1bV2mblFjRnXUiVEklA1cqtsh2iewwFwNxurxgTnEvlsdMowmSYQ6iqWzn8oWW9QBkSA9F+TZKcF1ktDY2NJ/OhsJivg7Ef4lHSlg7o3kbScfI56b2F+TOmtoX8waYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VP8hxYFq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D26C4CEED;
	Mon,  5 May 2025 22:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483525;
	bh=q1JvmxNM/hA0zdhzdIprJ7SuWYJlD1UWCpYgZR3dDsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VP8hxYFqZfV9zr/BKnl9X0awn/9wlPKQQk73a4O5SRbKaFKUKeCQMqjUvs3DGvCJg
	 r2nB2uJJ5TUPJbinvhPre/4Fo43owYjyHFKGMiHbNFXp+hBLQzyJVTdYddkGHZI0QI
	 H8aV5vzwIi/bVE36Fdk/bmzKju+osiH2VJkY6Rw2AHMU/2DZI3MRmqpM7W2Q2wdL1V
	 1/E5HS5XEmLdwQrUaWL9y5a9RuIPqjVOlP6QsG26gvKJClUZMd0oJk2dAqPGZcdE3C
	 ueQJaO2t/FfyAQborTnj5+D53YYfafbg7vKmc754t0edSQ1a82FKG2TUGKsrzIFg5Y
	 oRrbLoYcdmSXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 098/642] btrfs: allow buffered write to avoid full page read if it's block aligned
Date: Mon,  5 May 2025 18:05:14 -0400
Message-Id: <20250505221419.2672473-98-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 0d31ca6584f21821c708752d379871b9fce2dc48 ]

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
The test case creates a 8MiB file, then does buffered write into the 8MiB
using 4K block size, to overwrite the whole file.

On 4K page sized systems, since the write range covers the full block and
page, btrfs will not bother reading the page, just like what XFS and EXT4
do.

But on 64K page sized systems, although the 4K sized write is still block
aligned, it's not page aligned anymore, thus btrfs will read the full
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
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 4 ++++
 fs/btrfs/file.c      | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 039a0c36164e9..c01926f954fe1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -974,6 +974,10 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 			end_folio_read(folio, true, cur, iosize);
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
index a92997a583bd2..9facda5583ec3 100644
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
2.39.5


