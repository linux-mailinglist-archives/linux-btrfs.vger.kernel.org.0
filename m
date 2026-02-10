Return-Path: <linux-btrfs+bounces-21621-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFi+HnnAi2m1aQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21621-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 00:34:17 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 180D2120099
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 00:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0926307EEA0
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 23:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCDE30E0ED;
	Tue, 10 Feb 2026 23:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfXABiuR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70432DC76F;
	Tue, 10 Feb 2026 23:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770766296; cv=none; b=UDUm1BA9X8P8QClrOoio1M6RPmalvq+LN+6PAMwq4MSoX4tdUfx3OxZOd6tbcGaiRgiz29LF/h8d5BfhTjN1cKbaqgcw1yTLsr25qB/uEHKHEuKXy3vpO2BULzYygOml0m2TO5q9mtCPDSNGq8khuoLdC9wTJtz4j1riuEMFtDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770766296; c=relaxed/simple;
	bh=y5xW8saOkqoWwCqzmV8yDdTrGXfunGZ0DVZiXNpimjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVY/Eb2aCRK9JECgPIvaQcnQiiRnmpFG5RlEohVce8XxsLYw+izmT4Be98UwnVffz2mObnA3Z+q1efOE2WQdNFOaDWmW0LuTY/AYMlN/xucus8+FnPXP3kj32/xA+UlLDX0D39uFvHYng9UFktxhfmX3jvpM+YHhyWUd1Qd3rzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfXABiuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF8CC116C6;
	Tue, 10 Feb 2026 23:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770766296;
	bh=y5xW8saOkqoWwCqzmV8yDdTrGXfunGZ0DVZiXNpimjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GfXABiuRqJMynjXb8XVtf48da5QhRTt8HrcpHDaW+Mj5S+i/mqp0zbC/lN3L41cbp
	 +xvSmifh5a3xhuz5mJag7963WMM0EA9yPhXerSXObNa/EUP4Wczgl7EgFVzARM35jn
	 vss8eOtvd1O1vXyxWFTHRzkxj7O4okMraS5Djzh7eI/suwzzhhTqPQ/c9HRknpYQlZ
	 2JgEAUaGIGdPKYWibse4GPpwJhE4+b1pPJ4kzZrjG+Sl0ih30v81hvlTu624OGnTPl
	 03eaO2aNdIl9z0DP/PhWio9iQT99E1l9kdRu7EMOWTagZRtRFQ1CofHinVy/A6aofr
	 0d0lxAPGmfpxQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.12] btrfs: fallback to buffered IO if the data profile has duplication
Date: Tue, 10 Feb 2026 18:30:52 -0500
Message-ID: <20260210233123.2905307-7-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21621-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 180D2120099
X-Rspamd-Action: no action

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 7c2830f00c3e086292c1ee9f27b61efaf8e76c9a ]

[BACKGROUND]
Inspired by a recent kernel bug report, which is related to direct IO
buffer modification during writeback, that leads to contents mismatch of
different RAID1 mirrors.

[CAUSE AND PROBLEMS]
The root cause is exactly the same explained in commit 968f19c5b1b7
("btrfs: always fallback to buffered write if the inode requires
checksum"), that we can not trust direct IO buffer which can be modified
halfway during writeback.

Unlike data checksum verification, if this happened on inodes without
data checksum but has the data has extra mirrors, it will lead to
stealth data mismatch on different mirrors.

This will be way harder to detect without data checksum.

Furthermore for RAID56, we can even have data without checksum and data
with checksum mixed inside the same full stripe.

In that case if the direct IO buffer got changed halfway for the
nodatasum part, the data with checksum immediately lost its ability to
recover, e.g.:

" " = Good old data or parity calculated using good old data
"X" = Data modified during writeback

              0                32K                      64K
  Data 1      |                                         |  Has csum
  Data 2      |XXXXXXXXXXXXXXXX                         |  No csum
  Parity      |                                         |

In above case, the parity is calculated using data 1 (has csum, from
page cache, won't change during writeback), and old data 2 (has no csum,
direct IO write).

After parity is calculated, but before submission to the storage, direct
IO buffer of data 2 is modified, causing the range [0, 32K) of data 2
has a different content.

Now all data is submitted to the storage, and the fs got fully synced.

Then the device of data 1 is lost, has to be rebuilt from data 2 and
parity. But since the data 2 has some modified data, and the parity is
calculated using old data, the recovered data is no the same for data 1,
causing data checksum mismatch.

[FIX]
Fix the problem by checking the data allocation profile.
If our data allocation profile is either RAID0 or SINGLE, we can allow
true zero-copy direct IO and the end user is fully responsible for any
race.

However this is not going to fix all situations, as it's still possible
to race with balance where the fs got a new data profile after the data
allocation profile check.
But this fix should still greatly reduce the window of the original bug.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=99171
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Here is my detailed analysis:

---

## Commit Analysis: "btrfs: fallback to buffered IO if the data profile
has duplication"

### 1. COMMIT MESSAGE ANALYSIS

The commit has an extremely detailed and well-structured message with
[BACKGROUND], [CAUSE AND PROBLEMS], and [FIX] sections. Key points:

- **Root cause**: Direct IO buffers can be modified by userspace during
  writeback. This is a known issue — the same root cause was addressed
  for checksummed inodes by commit 968f19c5b1b7.
- **Impact**: On filesystems with redundant data profiles (RAID1,
  RAID5/6, DUP, RAID10, RAID1C3/C4), modified DIO buffers cause **silent
  data mismatch across mirrors**. This is *data corruption* — different
  mirrors/copies hold different content.
- **RAID56 amplification**: For RAID56, the problem is worse — corrupted
  parity renders checksummed data unrecoverable, since parity is
  calculated from pre-modification data but the actual written data may
  differ.
- **Referenced bug**: [bugzilla.kernel.org
  #99171](https://bugzilla.kernel.org/show_bug.cgi?id=99171) — a long-
  standing issue dating back to 2015.
- **Authors**: Qu Wenruo (key btrfs developer), signed-off by David
  Sterba (btrfs maintainer).

### 2. CODE CHANGE ANALYSIS

The patch is **12 lines, single file** (`fs/btrfs/direct-io.c`),
touching only `btrfs_direct_write()`:

**Variable declaration added:**
```c
const u64 data_profile = btrfs_data_alloc_profile(fs_info) &
                         BTRFS_BLOCK_GROUP_PROFILE_MASK;
```

**Early bailout check added before `relock:` label:**
```c
if (data_profile != BTRFS_BLOCK_GROUP_RAID0 && data_profile != 0)
    goto buffered;
```

The logic is:
- `btrfs_data_alloc_profile()` returns the current data allocation
  profile, which includes type + profile bits
- After masking with `BTRFS_BLOCK_GROUP_PROFILE_MASK`, the result is:
  - `0` for SINGLE (no profile bits)
  - `BTRFS_BLOCK_GROUP_RAID0` for RAID0
  - Other values for RAID1/DUP/RAID5/RAID6/RAID10/RAID1C3/RAID1C4
- Only SINGLE and RAID0 are allowed through to direct IO — these have no
  data duplication
- All other profiles fall back to `buffered:` where the kernel controls
  the page cache

The `goto buffered` jumps to the existing `buffered:` label (line 965 in
current code) that handles the buffered write fallback, including NOWAIT
handling. This is safe because the inode lock has NOT been taken yet at
this point.

### 3. THE BUG MECHANISM IN DETAIL

The bug occurs in this sequence:
1. Application opens a file with O_DIRECT on a btrfs filesystem with
   RAID1/RAID5/RAID6/DUP data profile
2. Application issues a direct IO write
3. btrfs begins writing the data to multiple mirrors/parity
4. During writeback (between when the data is read from the user buffer
   and when it's written to disk), another thread or the application
   itself modifies the DIO buffer
5. Different mirrors receive different content — some get the original
   data, some get the modified data
6. For NODATASUM inodes, there's **no checksum to detect this mismatch**
7. If a drive fails and rebuild is needed, the wrong data may be
   reconstructed

This is *silent data corruption* — the most insidious kind, since the
user doesn't know it happened.

### 4. CLASSIFICATION

This is a **data corruption fix**. It prevents silent data mismatch on
RAID mirrors caused by DIO buffer modification during writeback. This is
firmly in the "data corruption" category of stable-worthy fixes.

### 5. SCOPE AND RISK ASSESSMENT

- **Lines changed**: 12 added, 0 removed — extremely small
- **Files touched**: 1 (`fs/btrfs/direct-io.c`)
- **Risk of regression**: LOW. The worst case is a performance
  regression — direct IO falls back to buffered IO on RAID
  configurations. But:
  - The buffered IO path is well-tested and reliable
  - Users who need zero-copy DIO on RAID can still use NODATASUM (it was
    already the common practice)
  - Data integrity is more important than performance
- **Subsystem maturity**: btrfs is mature; the `btrfs_direct_write()`
  function is well-understood

### 6. DEPENDENCY ANALYSIS

- **`btrfs_data_alloc_profile()`**: Exists since v5.4-rc1 (commit
  878d7b679491). Available in ALL active stable trees (5.15.y, 6.1.y,
  6.6.y, 6.12.y).
- **`BTRFS_BLOCK_GROUP_PROFILE_MASK`**: Exists in
  `include/uapi/linux/btrfs_tree.h` since very early btrfs — available
  everywhere.
- **`buffered:` label**: Exists in `btrfs_direct_write()` since the
  function was written — available everywhere.
- **Commit 968f19c5b1b7**: IS an ancestor of this commit (confirmed).
  However, this patch does NOT strictly depend on it — the new check is
  placed BEFORE `relock:`, before the inode lock is taken, and uses
  `goto buffered` which existed before 968f. The two fixes are
  complementary but independent:
  - 968f handles checksummed inodes (checksum mismatch)
  - This commit handles redundant profiles (mirror mismatch)
- **File location**: On v6.12+, code is in `fs/btrfs/direct-io.c`. On
  v6.6 and earlier, the direct IO code was in `fs/btrfs/inode.c` (moved
  by commit 9aa29a20b7009 in v6.7). Backports to v6.6 and earlier would
  need path adjustment.

### 7. USER IMPACT

- **Who is affected**: Anyone using btrfs with RAID1, RAID10, RAID5,
  RAID6, or DUP data profiles and direct IO writes. This is a **very
  common scenario** — VM images on btrfs RAID1 is a standard deployment
  pattern.
- **Severity**: **Data corruption** — silent mirror mismatch that can
  lead to data loss on rebuild.
- **How long the bug has existed**: Since btrfs RAID support was added.
  The bugzilla (#99171) was filed in 2015.
- **Acknowledgment in commit**: The author acknowledges this is an
  incomplete fix (race with balance can still occur), but it "greatly
  reduces the window."

### 8. STABILITY INDICATORS

- Author: Qu Wenruo — prolific btrfs developer, deeply understands the
  subsystem
- Committer: David Sterba — btrfs maintainer, reviewed and accepted
- Committed 2026-01-29, authored 2025-11-01 — has had time for review
- The commit is already on multiple autosel candidate branches,
  confirming interest in backporting

### Concerns

1. **Performance impact**: Users on RAID configurations who previously
   got zero-copy DIO will now get buffered IO. This is a behavioral
   change, though documented and deliberate.
2. **Incomplete fix**: The commit acknowledges a remaining race with
   `balance` changing profiles. But a partial fix that "greatly reduces
   the window" is better than no fix.
3. **Needs 968f19c5b1b7 for clean apply**: The diff context includes
   code from 968f. However, the fix can be adapted to apply without it —
   only the surrounding context differs. The core logic (profile check +
   goto buffered) is self-contained.

### Verdict

This commit fixes **silent data corruption** on btrfs RAID
configurations — one of the most serious categories of bugs. The fix is
minimal (12 lines), self-contained, obviously correct, and has zero risk
of introducing new crashes or instability (worst case: performance
regression from buffered IO fallback). The bug has been known since 2015
(bugzilla #99171) and affects a common use case. The author and
committer are the primary btrfs maintainers.

**YES**

 fs/btrfs/direct-io.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 07e19e88ba4b3..5443d69efe956 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -814,6 +814,8 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t ret;
 	unsigned int ilock_flags = 0;
 	struct iomap_dio *dio;
+	const u64 data_profile = btrfs_data_alloc_profile(fs_info) &
+				 BTRFS_BLOCK_GROUP_PROFILE_MASK;
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		ilock_flags |= BTRFS_ILOCK_TRY;
@@ -827,6 +829,16 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_pos + iov_iter_count(from) <= i_size_read(inode) && IS_NOSEC(inode))
 		ilock_flags |= BTRFS_ILOCK_SHARED;
 
+	/*
+	 * If our data profile has duplication (either extra mirrors or RAID56),
+	 * we can not trust the direct IO buffer, the content may change during
+	 * writeback and cause different contents written to different mirrors.
+	 *
+	 * Thus only RAID0 and SINGLE can go true zero-copy direct IO.
+	 */
+	if (data_profile != BTRFS_BLOCK_GROUP_RAID0 && data_profile != 0)
+		goto buffered;
+
 relock:
 	ret = btrfs_inode_lock(BTRFS_I(inode), ilock_flags);
 	if (ret < 0)
-- 
2.51.0


