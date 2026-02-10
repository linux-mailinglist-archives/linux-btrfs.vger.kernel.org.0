Return-Path: <linux-btrfs+bounces-21623-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDthBBDBi2l6aQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21623-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 00:36:48 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC7C12015E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 00:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52924311371A
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 23:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC91232C923;
	Tue, 10 Feb 2026 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkuD8lzV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CA419ABD8;
	Tue, 10 Feb 2026 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770766319; cv=none; b=pGHOQVBo8PJQ+3zx4i/2UhSMyalfH0tz0+Y81/qX7VP7OVqBGpgeHegAvDhA1DMdrVcc1fT10iSI1Pp31cCOfGtCnL9A7I1gFuQQJenBK+158bQCl2gcYmKL2+L6lIKOMCbUgEBJ0l3uB++jwdtTcHf+KOCXXhpXeVo9s5RgkbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770766319; c=relaxed/simple;
	bh=/LFcfH13Xvl2PqBIZxM2EkzvYZWWnm+n/Hix99upP2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ct/TwHfBovAkXEG6yycK2/zhrMmInDsse7OJwiH/zAibFL8PwCyacmouSfGek9udM4bchFxqE43dY2/WA+CPpggOuJ73jSjauWSE1c/9rdpexRHNx33lsdL60rl/a2EJE3PWRWKBZfveHlqUERQ5NaZa6B7jPQ+EkUnUYbF2Tnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkuD8lzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23FDC19423;
	Tue, 10 Feb 2026 23:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770766319;
	bh=/LFcfH13Xvl2PqBIZxM2EkzvYZWWnm+n/Hix99upP2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZkuD8lzVimPJnEKj4uAhZJqhRQxAczI6XUCeQWYgI0d8VMWIWKMvpKuU4qcxziOhQ
	 RCJB2J5DmLnVrsh0GbnmsIsqk4uNXCHyJj1jEvI6b+oJyhuuerS+s3Y+PZJruxPYpT
	 d5h8dOGB0ONY60+AlBcLUA4HHZm8nOWFkQqJncEtSlYpWB2m4mOCDRbQmvv5eELmXO
	 txVrmE5rFgPUzm7bowX6tJZ5PUgW7xLm55ycn2koTceaYQKW8LEDloIZvwtSBfn3VT
	 2TVoM2v9XFHSTa2nlWcSzpwhx3Ne1HFahEoN6IIlJjQh56n31m5+z8IMgW7t2vBwvD
	 6fM35JAeTLpsA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: jinbaohong <jinbaohong@synology.com>,
	Qu Wenruo <wqu@suse.com>,
	Robbie Ko <robbieko@synology.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.6] btrfs: handle user interrupt properly in btrfs_trim_fs()
Date: Tue, 10 Feb 2026 18:31:08 -0500
Message-ID: <20260210233123.2905307-23-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260210233123.2905307-1-sashal@kernel.org>
References: <20260210233123.2905307-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21623-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,synology.com:email]
X-Rspamd-Queue-Id: 7DC7C12015E
X-Rspamd-Action: no action

From: jinbaohong <jinbaohong@synology.com>

[ Upstream commit bfb670b9183b0e4ba660aff2e396ec1cc01d0761 ]

When a fatal signal is pending or the process is freezing,
btrfs_trim_block_group() and btrfs_trim_free_extents() return -ERESTARTSYS.
Currently this is treated as a regular error: the loops continue to the
next iteration and count it as a block group or device failure.

Instead, break out of the loops immediately and return -ERESTARTSYS to
userspace without counting it as a failure. Also skip the device loop
entirely if the block group loop was interrupted.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Robbie Ko <robbieko@synology.com>
Signed-off-by: jinbaohong <jinbaohong@synology.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a complete understanding. Let me provide my thorough
analysis.

---

## Detailed Analysis

### 1. COMMIT MESSAGE ANALYSIS

The commit message is clear and precise: when `btrfs_trim_block_group()`
or `btrfs_trim_free_extents()` return `-ERESTARTSYS` (due to fatal
signal or freezing), the current code treats it as a regular error. It
continues the loops, counts it as a failure, and logs misleading
warnings. The fix is to break out immediately and return `-ERESTARTSYS`
to userspace.

The commit has excellent review pedigree: reviewed by Qu Wenruo, Filipe
Manana, and David Sterba (the btrfs maintainer himself). Three separate
reviews is strong confidence.

### 2. CODE CHANGE ANALYSIS

The fix touches a single function `btrfs_trim_fs()` in `fs/btrfs/extent-
tree.c`, adding 11 lines across three locations:

**Location 1** - Block group loop: After `btrfs_trim_block_group()`
returns, check for `-ERESTARTSYS`/`-EINTR` and break immediately:

```c
if (ret == -ERESTARTSYS || ret == -EINTR) {
    btrfs_put_block_group(cache);
    break;
}
```

Note the critical `btrfs_put_block_group(cache)` call before `break` —
this prevents a reference count leak. When using `continue`, the loop
iterator `cache = btrfs_next_block_group(cache)` handles putting the old
reference. But on `break`, we must do it explicitly. This matches the
existing pattern earlier in the same loop:

```6530:6533:fs/btrfs/extent-tree.c
                if (cache->start >= range_end) {
                        btrfs_put_block_group(cache);
                        break;
                }
```

**Location 2** - Between the two loops: Skip the device trimming loop
entirely if the block group loop was interrupted:

```c
if (ret == -ERESTARTSYS || ret == -EINTR)
    return ret;
```

**Location 3** - Device loop and final return: Break out of the device
loop on interrupt and return appropriately:

```c
if (ret == -ERESTARTSYS || ret == -EINTR)
    break;
...
if (ret == -ERESTARTSYS || ret == -EINTR)
    return ret;
```

### 3. THE BUG MECHANISM

This bug is a **follow-up to commit `69313850dce33` ("btrfs: add
cancellation points to trim loops")** which was merged in v6.12 and is
`Cc: stable@vger.kernel.org # 5.15+`. That commit added
`btrfs_trim_interrupted()` checks to the inner trim functions
(`trim_no_bitmap`, `trim_bitmaps`, `btrfs_issue_discard`,
`btrfs_trim_free_extents`) so they return `-ERESTARTSYS` when a fatal
signal is pending or the process is freezing.

**The problem**: The outer function `btrfs_trim_fs()` was NOT updated to
handle this `-ERESTARTSYS` return. So the inner loops correctly detect
the interrupt and return early, but the outer loop just treats it as a
regular error and continues:

1. `btrfs_trim_block_group(cache_0)` → detects signal → returns
   `-ERESTARTSYS`
2. Outer loop: `bg_failed++`, `bg_ret = -ERESTARTSYS`, `continue`
3. `btrfs_trim_block_group(cache_1)` → detects signal again → returns
   `-ERESTARTSYS`
4. Repeat for ALL remaining block groups
5. Then iterate ALL devices, each returning `-ERESTARTSYS` immediately

On a large filesystem with thousands of block groups and multiple
devices, this means:
- **Delayed response to Ctrl+C/SIGKILL**: The process doesn't terminate
  promptly
- **Blocked system suspend**: `freezing(current)` remains true, but the
  outer loop keeps going, preventing the process from actually freezing.
  This was the exact scenario reported in [bug
  219180](https://bugzilla.kernel.org/show_bug.cgi?id=219180) and [SUSE
  bug 1229737](https://bugzilla.suse.com/show_bug.cgi?id=1229737)
- **Misleading dmesg warnings**: `btrfs_warn(fs_info, "failed to trim
  %llu block group(s)...")` fires, counting all the interrupted block
  groups as "failures"
- **Wrong return value**: Instead of returning `-ERESTARTSYS` cleanly to
  userspace, the function may return a mixed error code

### 4. SCOPE AND RISK ASSESSMENT

- **Size**: 11 lines added, 0 removed. Extremely small and surgical.
- **Files touched**: 1 (`fs/btrfs/extent-tree.c`)
- **Scope**: Only affects the interrupt/signal error path. The normal
  trim path (no signal pending) is completely unaffected — all new code
  is gated behind `ret == -ERESTARTSYS || ret == -EINTR` checks.
- **Risk**: Very low. The added checks are early-exit conditions that
  only trigger when a signal is pending or process is freezing. There's
  no way these can cause a regression in normal operation.
- **Reference counting**: Correctly handled
  (`btrfs_put_block_group(cache)` before break).

### 5. USER IMPACT

- **Who is affected**: Any user running `fstrim` on a btrfs filesystem
  who interrupts it (Ctrl+C) or has a system that suspends while trim is
  running. This is a very common scenario, especially on laptops with
  btrfs and periodic fstrim timers.
- **Call path**: `fstrim` → `FITRIM` ioctl → `btrfs_ioctl_fitrim()` →
  `btrfs_trim_fs()`
- **Severity**: The original bugs from the linked reports were about
  systems unable to suspend. The cancellation point commit
  (`69313850dce33`) fixed the inner loops but left the outer loop
  broken, meaning the fix was incomplete. This commit completes it.

### 6. DEPENDENCY CHECK

This commit depends on two preceding commits:

1. **`912d1c6680bdb` ("btrfs: continue trimming remaining devices on
   failure")** - Changes `break` to `continue` in the device loop.
   **Already targeted for stable** (`Fixes:` tag and `Cc:
   stable@vger.kernel.org # 5.4+`).

2. **`1cc4ada4182fa` ("btrfs: preserve first error in
   btrfs_trim_fs()")** - Changes `bg_ret = ret` to `if (!bg_ret) bg_ret
   = ret`. **Not targeted for stable**. This is a small context
   dependency; the core fix logic is independent of it.

Both prerequisites are small (1-line and 15-line changes respectively).
The first is already stable-bound. The second would be needed for clean
application but could alternatively be resolved by a minor context
adjustment during backport.

The fix also requires `69313850dce33` ("btrfs: add cancellation points
to trim loops") which is `Cc: stable # 5.15+` and should already be in
stable trees 5.15+.

### 7. STABILITY INDICATORS

- Reviewed by 3 btrfs experts
- The parent commit adding interruption infrastructure has been in
  stable since 5.15+
- The fix is straightforward conditional checks — no complex logic

### 8. CLASSIFICATION

This is a **bug fix** that:
- Fixes incomplete signal/interrupt handling
- Fixes potential system suspend blocking
- Fixes misleading kernel warnings
- Fixes incorrect error propagation to userspace
- Completes an existing stable fix (`69313850dce33`)

It is NOT:
- A new feature
- A performance optimization
- A code cleanup
- An API change

### Summary

This commit fixes a real, user-visible bug where btrfs trim operations
cannot be properly interrupted by signals (Ctrl+C) or system suspend. It
completes the fix started by `69313850dce33` (already in stable 5.15+)
which added cancellation points to inner trim loops but left the outer
loop in `btrfs_trim_fs()` unaware of the `-ERESTARTSYS` return code. The
fix is extremely small (11 lines), well-reviewed by 3 btrfs developers
including the maintainer, has zero risk to normal code paths, correctly
handles reference counting, and addresses the same class of bug (suspend
blocking) that motivated the original stable-tagged commit. It requires
two small prerequisite commits (one already stable-targeted) for clean
application.

**YES**

 fs/btrfs/extent-tree.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1bf081243efb2..8bdb609f58a7e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6555,6 +6555,10 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 						     range->minlen);
 
 			trimmed += group_trimmed;
+			if (ret == -ERESTARTSYS || ret == -EINTR) {
+				btrfs_put_block_group(cache);
+				break;
+			}
 			if (ret) {
 				bg_failed++;
 				bg_ret = ret;
@@ -6568,6 +6572,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 			"failed to trim %llu block group(s), last error %d",
 			bg_failed, bg_ret);
 
+	if (ret == -ERESTARTSYS || ret == -EINTR)
+		return ret;
+
 	mutex_lock(&fs_devices->device_list_mutex);
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
 		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
@@ -6576,6 +6583,8 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 		ret = btrfs_trim_free_extents(device, &group_trimmed);
 
 		trimmed += group_trimmed;
+		if (ret == -ERESTARTSYS || ret == -EINTR)
+			break;
 		if (ret) {
 			dev_failed++;
 			dev_ret = ret;
@@ -6589,6 +6598,8 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 			"failed to trim %llu device(s), last error %d",
 			dev_failed, dev_ret);
 	range->len = trimmed;
+	if (ret == -ERESTARTSYS || ret == -EINTR)
+		return ret;
 	if (bg_ret)
 		return bg_ret;
 	return dev_ret;
-- 
2.51.0


