Return-Path: <linux-btrfs+bounces-19588-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFEACAE789
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 01:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30B3C300EBFC
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 00:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B812F2264A8;
	Tue,  9 Dec 2025 00:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWlQG/oy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE57C222584;
	Tue,  9 Dec 2025 00:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239420; cv=none; b=G4cmFLwFDbI4347UusnzCaQShAp9P9brEmEHAekDlp2KljfGnS9Kr5CMPDjJxB4mTzrDPZa0U1QU+Rbn0ieEY4fUdnMTmhylStt2uul0e/l/xMoNwqnKoTgHw70Slv9ZHWHXTQMqlUHrtx7NIORuTMZx1wXMP271ez7eeetYMt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239420; c=relaxed/simple;
	bh=9PCMDr/x1UlkMwVh+lZ9ztd2Lo4ONhtYQKg+LmudZtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S1LcHnWBZ+xqKjJWG9awlEWQE7XSCzKBNfR/H9f3Nx0uaW+K4w/LRvzdP8zoHwvY8uVKFaNJXGicKbuj8FvwvIRM+AH1GE+EvYGb0Bs+4UqC2/9sghu7np4Lt3IQq181s1alGxLG5SFLJ+pXPUkB4ZYxBSfnNstQodLNrYFjSPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWlQG/oy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98965C4CEF1;
	Tue,  9 Dec 2025 00:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765239419;
	bh=9PCMDr/x1UlkMwVh+lZ9ztd2Lo4ONhtYQKg+LmudZtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lWlQG/oyepOmxF5OCRRwF7x7y9Ijc/Euwk2mNjM2UTG6wjVMyaqaM9UIKjGhWsWO+
	 3oO/1MpnQZH4stoLi0MSJoFm2G2fa3Xh15s9eVjuwxsEqgJXGHySS4yV03EfVPH4W1
	 TmdjtYyb3yemh2OlvPgAT4bPXpzQsArBuFuxacxLfLLV2O9JjsfufNgrRmQrwWJOR2
	 83M+QdZRDV5y8cArW/492yV4u0M/wGsNrFOIUqeP0hPQsQxtQADVPzhoviRcq7PP9f
	 zFGjmGRC9kEThW+W9tVd9Dy2gsGAOwsihM+yaInBKeYP3clR/cyQc7hXkk74TO5kJq
	 Nl9qFw9zVveyw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-5.10] btrfs: scrub: always update btrfs_scrub_progress::last_physical
Date: Mon,  8 Dec 2025 19:15:05 -0500
Message-ID: <20251209001610.611575-13-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209001610.611575-1-sashal@kernel.org>
References: <20251209001610.611575-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18
Content-Type: text/plain; charset=UTF-8
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

## ANALYSIS SUMMARY

### 1. Commit Message Analysis

The commit describes a clear bug with well-structured [BUG], [CAUSE],
and [FIX] sections:
- **Bug**: When scrub fails early (before scrubbing any bytes),
  `last_physical` is returned as 0 instead of the `start` parameter,
  causing resume to restart from the beginning
- **Root cause**: Either `last_physical` isn't touched at all (early
  error paths) or it's left as 0 (kvzalloc zeroes sctx->stat)
- **Notable**: No explicit "Cc: stable@vger.kernel.org" or "Fixes:" tag,
  but has "Reviewed-by: David Sterba" (btrfs maintainer)

### 2. Code Change Analysis

The fix adds just **2 lines of code** (plus a comment):

```c
/* Set the basic fallback @last_physical before we got a sctx. */
if (progress)
    progress->last_physical = start;
```

And after `sctx` allocation:
```c
sctx->stat.last_physical = start;
```

**Technical mechanism**: The function `btrfs_scrub_dev()` takes a
`start` parameter indicating where to begin (or resume) scrubbing. The
`progress` struct is returned to userspace even on error (see
`btrfs_ioctl_scrub()` comment: "Copy scrub args to user space even if
btrfs_scrub_dev() returned an error...Later user space can...resume
scrub from where it left off"). Without this fix, if scrub fails early,
`last_physical` is 0, causing btrfs-progs to restart from the beginning.

### 3. Classification

- **Bug fix**: Yes - fixes incorrect initialization of a progress
  tracking field
- **Not an exception category**: Regular bug fix, not device
  IDs/quirks/DT

### 4. Scope and Risk Assessment

- **Scope**: 2 lines in 1 function (`btrfs_scrub_dev()`)
- **Risk**: **EXTREMELY LOW** - just initializing a value to `start`
  instead of leaving it as 0
- The fix is purely additive and defensive; it doesn't change the normal
  code path where scrubbing succeeds
- If scrubbing proceeds normally, `last_physical` gets updated with
  actual progress anyway

### 5. User Impact

- **Who**: Users with large btrfs filesystems who use scrub resume
- **Severity**: Moderate usability issue - scrub on multi-TB filesystems
  can take hours/days; restarting from 0 wastes significant time
- **Real-world**: The ioctl is explicitly designed for resume
  functionality (per the code comment), and btrfs-progs relies on this

### 6. Stability Indicators

- ✅ **Reviewed-by**: David Sterba (btrfs maintainer)
- ✅ **Signed-off-by**: David Sterba (btrfs maintainer)
- The fix has been properly reviewed through the btrfs maintainer tree

### 7. Dependency Check

- No dependencies on other commits
- The affected code structure (`btrfs_scrub_dev`,
  `btrfs_scrub_progress`, `start` parameter) has existed for many years
  and is present in all stable kernels

## Verdict

This commit is an excellent candidate for stable backport:

1. **Fixes a real bug**: Scrub resume is broken when scrub fails early
2. **Small and surgical**: Just 2 lines of initialization code
3. **Obviously correct**: Setting `last_physical = start` is clearly the
   right behavior
4. **Low risk**: Cannot break anything - just ensures proper
   initialization of a progress field
5. **Benefits stable users**: Large filesystem users who rely on scrub
   resume functionality
6. **Maintainer reviewed**: Reviewed and signed off by btrfs maintainer

The lack of explicit "Cc: stable" tag appears to be an oversight - the
bug clearly affects all kernels with scrub resume functionality, and the
fix is exactly the type of small, safe bugfix appropriate for stable
trees.

**YES**

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


