Return-Path: <linux-btrfs+bounces-17475-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07944BBEEA1
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 20:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3790F4F0A58
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Oct 2025 18:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F862DE6F7;
	Mon,  6 Oct 2025 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k09mdZW3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269232D8378;
	Mon,  6 Oct 2025 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759774754; cv=none; b=CEMEjaWM0dlBS70mzTnZu1Lx7FZdK2WvmL2Ja3AHuhkTsz+jv5BAO6q7EPycIbUgfci4a5V6QBd3+8Q++fngw9F5EPWbyUWmsLdzxfBJOZ9SejOn2XbA+O3aiu1t6begmNAxGVGW9g7NE6pfkhPf4YKPtSi4OEwIoJuACyomhSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759774754; c=relaxed/simple;
	bh=wHIxtK6e98vGYMHYYCA64Z1Vso09NzhEa5cU//quYu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bomATKhu3G5SDMNIaHtUdvjY+5W8iCWMZyjtBNP03KB8SvNVSlYom15Pg5YfBuJEKqIBCLJN+QJ3TvLS3p8N5eRzAKNYqcLI/wVzpcXUlNL7b6etTjm0SmUzEBFCjaOgY9bLhnxzHEBpji4ms7ERePkeWgnttedEjJGPY+0Cqak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k09mdZW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB517C4AF09;
	Mon,  6 Oct 2025 18:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759774753;
	bh=wHIxtK6e98vGYMHYYCA64Z1Vso09NzhEa5cU//quYu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k09mdZW3QaO6tvGbMm2LTHcF/vfwyEjyZ2gCEWNKKXkJPXARJucrHIglP1Rvt7Xh3
	 xqBYdBwS9kMEaXdr3EoXgEiSTMBHgTMHCvSSrphNeFj3vAysKdnEXhhWuB7NvBNuiG
	 TQ6vs9B5KBBXY9d1Kue2hxqn3IxH7wSf4s+rA30tULDIG5J8zEXc9aJ6ZIUW9FhPcc
	 ZZAStDnZkJmt/fmLbCB5Va3CELUfEVqoN64m95CY/dczOxV3KxC0Nj0zDek0jvR/5J
	 lL6dbWVjUb1leVvvjdrVPow4Tpcq+K7dRNLIbzRqLDZQDQM+plWcrWuIG6qYYG0PNU
	 eDn57mgAZZTPA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.12] btrfs: abort transaction in the process_one_buffer() log tree walk callback
Date: Mon,  6 Oct 2025 14:17:43 -0400
Message-ID: <20251006181835.1919496-11-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006181835.1919496-1-sashal@kernel.org>
References: <20251006181835.1919496-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit e6dd405b6671b9753b98d8bdf76f8f0ed36c11cd ]

In the process_one_buffer() log tree walk callback we return errors to the
log tree walk caller and then the caller aborts the transaction, if we
have one, or turns the fs into error state if we don't have one. While
this reduces code it makes it harder to figure out where exactly an error
came from. So add the transaction aborts after every failure inside the
process_one_buffer() callback, so that it helps figuring out why failures
happen.

Reviewed-by: Boris Burkov <boris@bur.io>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my extensive investigation, I need to provide my analysis:

## Analysis Complete

**Backport Status: YES**

### Rationale:

This commit is part of a coordinated effort by Filipe Manana to improve
error handling and debugging in btrfs log replay code. While primarily a
**debugging/observability improvement**, it does include a functional
enhancement.

### Code Changes Analysis:

**1. Adds explicit transaction aborts at error sites** (fs/btrfs/tree-
log.c:347-389):

- **Before**: Errors from `btrfs_read_extent_buffer()`,
  `btrfs_pin_extent_for_log_replay()`, and
  `btrfs_exclude_logged_extents()` were returned to the caller, and the
  caller would abort the transaction
- **After**: Transaction aborts happen immediately at the failure point
  with either `btrfs_abort_transaction()` or `btrfs_handle_fs_error()`

**2. Adds missing error handling** for `btrfs_exclude_logged_extents()`:

```c
// BEFORE: ret assigned but transaction not aborted here
if (btrfs_buffer_uptodate(eb, gen, 0) &&
    btrfs_header_level(eb) == 0)
    ret = btrfs_exclude_logged_extents(eb);

// AFTER: Explicit error check and abort
if (btrfs_buffer_uptodate(eb, gen, 0) &&
    btrfs_header_level(eb) == 0) {
    ret = btrfs_exclude_logged_extents(eb);
    if (ret)
        btrfs_abort_transaction(trans, ret);
}
```

**3. Adds ASSERT** for transaction handle validation in the wc->pin path

### Why Backport:

1. **Part of coordinated error handling improvements**: This is commit
   2/4 in a series (preceded by 6ebd726b104fa on same day, followed by
   commits 77ea42e3faa1f, 97b027586a189, and ultimately 2753e49176240
   which enhances all these aborts with detailed debugging)

2. **Slightly improves error handling**: While errors were eventually
   handled, this ensures transaction aborts happen closer to the failure
   point, potentially preventing additional operations on a doomed
   transaction

3. **Minimal risk**: The changes only add error handling paths without
   modifying core logic

4. **Already selected by AUTOSEL**: Commit exists as 5650f88050dd5 with
   backport tag, indicating it passed automated selection criteria

5. **Well-reviewed**: Has reviews from Boris Burkov, Qu Wenruo, and
   David Sterba

6. **Confined scope**: Changes limited to process_one_buffer() in tree-
   log.c

### Caveats:

- **No "Fixes:" tag**: Author did not tag this as fixing a specific bug
- **No "Cc: stable" tag**: Author did not explicitly request stable
  backport
- **Primary benefit is debugging**: The main value is better error
  diagnosis rather than fixing user-visible issues
- **Part of larger series**: Functions best with the full series of log
  replay improvements

**Verdict**: YES - This is a quality improvement that enhances error
handling with minimal risk. While borderline as it's primarily for
debugging, the slight functional improvement to error handling and
AUTOSEL selection support backporting to stable trees.

 fs/btrfs/tree-log.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6d92326a1a0c7..50ed84cb68a69 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -347,6 +347,7 @@ static int process_one_buffer(struct btrfs_root *log,
 			      struct extent_buffer *eb,
 			      struct walk_control *wc, u64 gen, int level)
 {
+	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_fs_info *fs_info = log->fs_info;
 	int ret = 0;
 
@@ -361,18 +362,29 @@ static int process_one_buffer(struct btrfs_root *log,
 		};
 
 		ret = btrfs_read_extent_buffer(eb, &check);
-		if (ret)
+		if (ret) {
+			if (trans)
+				btrfs_abort_transaction(trans, ret);
+			else
+				btrfs_handle_fs_error(fs_info, ret, NULL);
 			return ret;
+		}
 	}
 
 	if (wc->pin) {
-		ret = btrfs_pin_extent_for_log_replay(wc->trans, eb);
-		if (ret)
+		ASSERT(trans != NULL);
+		ret = btrfs_pin_extent_for_log_replay(trans, eb);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
 			return ret;
+		}
 
 		if (btrfs_buffer_uptodate(eb, gen, 0) &&
-		    btrfs_header_level(eb) == 0)
+		    btrfs_header_level(eb) == 0) {
 			ret = btrfs_exclude_logged_extents(eb);
+			if (ret)
+				btrfs_abort_transaction(trans, ret);
+		}
 	}
 	return ret;
 }
-- 
2.51.0


