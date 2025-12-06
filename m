Return-Path: <linux-btrfs+bounces-19549-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 531A5CAA7AD
	for <lists+linux-btrfs@lfdr.de>; Sat, 06 Dec 2025 15:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AED083011B08
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Dec 2025 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6853B2FE580;
	Sat,  6 Dec 2025 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjoT4CXI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AAF2FE56E;
	Sat,  6 Dec 2025 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765029787; cv=none; b=mvhvbosAuH2DunD49qUuYWMjMncFBuix4boErECXP3U+OBORhUVDcb131P6r3/TBiYX4pCb5rLG2r6Yf1vRM8W4QvwWihFPUOUl758wS0kaJi2jH+1O6W08Pw37hh/e+Dtl32qkUdL4j9bM0SyE3XUjnHqEr3UApLaDjqJLpxIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765029787; c=relaxed/simple;
	bh=Cv1rkLZwSfO1XqtszF2yVxBBqj1l4Zku5hCFCCY0NwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YahB10cZD0zm59lwKo9ziXMaOuS3U95ECe+Vfr0FLBPGVC8QYyHcaFsztjI4QmaGb9GbMs1eO12uauvtbDfDnEiT5Vdo1njTVJCPgCp2tVC1SwlYic+CNdgGRrunXY4GiTRKMLB6CegaX6ixOGacMlxJ6Q+b8rXEIBGzW62AvMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjoT4CXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E72C4CEF5;
	Sat,  6 Dec 2025 14:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765029787;
	bh=Cv1rkLZwSfO1XqtszF2yVxBBqj1l4Zku5hCFCCY0NwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GjoT4CXIWDISJjpNHdODKMI7ORpeOM6JM50B7NlcekVvyq3TqvaHAvB/a7Zvv/Ymx
	 RsEk+oVM7wcD7OmlVMfM8PZRkSe/doZE5A77rcmJcgqLzks7u83/ytqI+ZBU5nEXXF
	 ubwEVrPSiCfzza7guhoAszU7xERkvugmxkG7jP5YRud2RxTWPQVSgLVF9x0JIiwokx
	 iOZo7lF4whHR+3RV3j62m9NCJGTKQr5hcdT041NtVRZKC37KIvFWIbaj2+XAWTRZFF
	 Zc3wPgE5nSr7ZHFWBatI5zwGfpfjSfmIssfBVtT9QT8UXR3+VtXOG3A/60oR3JbKAO
	 tm5gukIXMD8gQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-5.10] btrfs: scrub: always update btrfs_scrub_progress::last_physical
Date: Sat,  6 Dec 2025 09:02:12 -0500
Message-ID: <20251206140252.645973-7-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206140252.645973-1-sashal@kernel.org>
References: <20251206140252.645973-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 54df8b80cc63aa0f22c4590cad11542731ed43ff ]

[BUG]
When a scrub failed immediately without any byte scrubbed, the returned
btrfs_scrub_progress::last_physical will always be 0, even if there is a
non-zero @start passed into btrfs_scrub_dev() for resume cases.

This will reset the progress and make later scrub resume start from the
beginning.

[CAUSE]
The function btrfs_scrub_dev() accepts a @progress parameter to copy its
updated progress to the caller, there are cases where we either don't
touch progress::last_physical at all or copy 0 into last_physical:

- last_physical not updated at all
  If some error happened before scrubbing any super block or chunk, we
  will not copy the progress, leaving the @last_physical untouched.

  E.g. failed to allocate @sctx, scrubbing a missing device or even
  there is already a running scrub and so on.

  All those cases won't touch @progress at all, resulting the
  last_physical untouched and will be left as 0 for most cases.

- Error out before scrubbing any bytes
  In those case we allocated @sctx, and sctx->stat.last_physical is all
  zero (initialized by kvzalloc()).
  Unfortunately some critical errors happened during
  scrub_enumerate_chunks() or scrub_supers() before any stripe is really
  scrubbed.

  In that case although we will copy sctx->stat back to @progress, since
  no byte is really scrubbed, last_physical will be overwritten to 0.

[FIX]
Make sure the parameter @progress always has its @last_physical member
updated to @start parameter inside btrfs_scrub_dev().

At the very beginning of the function, set @progress->last_physical to
@start, so that even if we error out without doing progress copying,
last_physical is still at @start.

Then after we got @sctx allocated, set sctx->stat.last_physical to
@start, this will make sure even if we didn't get any byte scrubbed, at
the progress copying stage the @last_physical is not left as zero.

This should resolve the resume progress reset problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:



 fs/btrfs/scrub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ba20d9286a340..cff67ed630196 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3039,6 +3039,10 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	unsigned int nofs_flag;
 	bool need_commit = false;
 
+	/* Set the basic fallback @last_physical before we got a sctx. */
+	if (progress)
+		progress->last_physical = start;
+
 	if (btrfs_fs_closing(fs_info))
 		return -EAGAIN;
 
@@ -3057,6 +3061,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	sctx = scrub_setup_ctx(fs_info, is_dev_replace);
 	if (IS_ERR(sctx))
 		return PTR_ERR(sctx);
+	sctx->stat.last_physical = start;
 
 	ret = scrub_workers_get(fs_info);
 	if (ret)
-- 
2.51.0


