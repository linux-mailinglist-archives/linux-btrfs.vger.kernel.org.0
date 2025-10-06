Return-Path: <linux-btrfs+bounces-17479-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0359BBEF37
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 20:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 510A94F1D1A
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Oct 2025 18:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8EC2DE6E6;
	Mon,  6 Oct 2025 18:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jy3Ic8Qu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FF82DFF33;
	Mon,  6 Oct 2025 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759774773; cv=none; b=pzQo3E5eQrV3l4a+yraAcd5koMWkCGbWEM1eqRI0NpTYTEzH8p3yop/BRv8Rmnp4N7u7wlk7DN/7gKqMwV+EY5RliFfSz/qvcWHmSRSj4VAHLHh3D32OBWNepWu2lhJjgkDH8kTYnpWuUjI4rOAOYeId+yWKmYyLjEhn9lchMko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759774773; c=relaxed/simple;
	bh=ii8PPEjk/4/DgRiIWepm+fW7yCRaehzXtUUPe7Xy4rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cksWdRGXoKpfdYrKalOgNnz3yShmvUdO22wKGoIp99APGToiEkkcuSG1xd9MM7apoP33P/PkGk53lA1SD+tq5/6nOXO0OqQgPrNOxbl7emWTIie7cAjfQV8TfXYy81B87fgy2VrZtFI3RPgk6j/QOHObhhyVEE4L8DoytNKj408=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jy3Ic8Qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEA2C4CEF7;
	Mon,  6 Oct 2025 18:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759774773;
	bh=ii8PPEjk/4/DgRiIWepm+fW7yCRaehzXtUUPe7Xy4rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jy3Ic8QuOeF1AphMlxLkEAW8FwFYiZ4k5ajJjPVKvmFn4TE4oDCThY8F90Dhm7o73
	 IIvSPxaDzae1OkwnoyotGgoeZPJNA4OfaaYr7Z1jrBYLzZgIMMIIJnp7mjOtPrZlnF
	 21g8Vj0Vz056eplg3XFaJKyvSv0zByYAsQhjb8DsSBSP9ow2e+pYgMeQR2ltAnjuok
	 ixt9Xfe+LpORrlhodQXJFjewWAvqYmRLgzquAkGnBXy5fJJVqQ+5jCsQYxFNZildjZ
	 Ra8jxtoWLTgswZy7wX5eDKofQFea9ecx5N4JTxXcidZiDeC+da3Pj7gQY1IuIV+wAg
	 GCi/f39Pi+BEw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.15] btrfs: scrub: replace max_t()/min_t() with clamp() in scrub_throttle_dev_io()
Date: Mon,  6 Oct 2025 14:17:55 -0400
Message-ID: <20251006181835.1919496-23-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit a7f3dfb8293c4cee99743132d69863a92e8f4875 ]

Replace max_t() followed by min_t() with a single clamp().

As was pointed by David Laight in
https://lore.kernel.org/linux-btrfs/20250906122458.75dfc8f0@pumpkin/
the calculation may overflow u32 when the input value is too large, so
clamp_t() is not used.  In practice the expected values are in range of
megabytes to gigabytes (throughput limit) so the bug would not happen.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Reviewed-by: David Sterba <dsterba@suse.com>
[ Use clamp() and add explanation. ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

## Analysis

### Change Classification
This commit is a **code quality improvement** that also addresses a
**theoretical overflow bug**. It replaces two lines with a single,
cleaner `clamp()` call:

**Before (fs/btrfs/scrub.c:1372-1373):**
```c
div = max_t(u32, 1, (u32)(bwlimit / (16 * 1024 * 1024)));
div = min_t(u32, 64, div);
```

**After:**
```c
div = clamp(bwlimit / (16 * 1024 * 1024), 1, 64);
```

### Key Points

1. **Already Backported**: This commit has already been backported to
   stable (commit 185af233e0914) by Sasha Levin on Oct 1, 2025,
   confirming it meets stable backport criteria.

2. **Bug Fixed (Theoretical)**: The original code casts `(bwlimit / (16
   * 1024 * 1024))` to u32, which could overflow if bwlimit exceeds ~64
   PiB/s. However, as the commit message explicitly states: "In practice
   the expected values are in range of megabytes to gigabytes
   (throughput limit) so the bug would not happen."

3. **Real Improvement**: By using `clamp()` instead of `clamp_t()`, the
   code avoids the explicit u32 cast, allowing the macro to handle types
   correctly. This was specifically recommended by David Laight in the
   mailing list discussion.

4. **Low Risk**:
   - Minimal code change (3 lines: +1, -2)
   - Functionality remains identical for all realistic values
   - No regression reports or follow-up fixes found
   - Reviewed by David Sterba (btrfs maintainer)

5. **Code Quality**: Improves readability by consolidating the min/max
   pattern into a single, more expressive `clamp()` call - a common
   kernel code modernization.

6. **Stable Tree Criteria**:
   - ✓ Small, contained change
   - ✓ No architectural modifications
   - ✓ Minimal regression risk
   - ✓ Fixes a (theoretical) bug
   - ✓ Already proven safe through upstream testing

### Conclusion
While this primarily improves code quality rather than fixing a critical
bug, it addresses a legitimate (if theoretical) overflow issue
identified during code review. The fact that it has already been
selected for stable backport by the stable tree maintainer confirms its
suitability. The change is extremely low-risk and represents the type of
defensive programming improvement appropriate for stable trees.

 fs/btrfs/scrub.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 6776e6ab8d108..fd4c1ca34b5e4 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1369,8 +1369,7 @@ static void scrub_throttle_dev_io(struct scrub_ctx *sctx, struct btrfs_device *d
 	 * Slice is divided into intervals when the IO is submitted, adjust by
 	 * bwlimit and maximum of 64 intervals.
 	 */
-	div = max_t(u32, 1, (u32)(bwlimit / (16 * 1024 * 1024)));
-	div = min_t(u32, 64, div);
+	div = clamp(bwlimit / (16 * 1024 * 1024), 1, 64);
 
 	/* Start new epoch, set deadline */
 	now = ktime_get();
-- 
2.51.0


