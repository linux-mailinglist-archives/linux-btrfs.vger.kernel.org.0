Return-Path: <linux-btrfs+bounces-20405-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 905A7D1387F
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 16:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA9A031337F7
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 14:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13A32DEA78;
	Mon, 12 Jan 2026 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7t397wz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243722DCF69;
	Mon, 12 Jan 2026 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229927; cv=none; b=uqxG+UcnHG2Ll0XX6iHHaDdWvQyex11s/PNdu3Oc1/7LhdwL9ECVWehPCrUXfqhMsZyuPEMvD0O6rTpo2cLIRhCWCf6la29mObX/npX1fJA+2J1JalxdiV9RKfq6ZGmJ7HguDttH48acKyNA7cZR5g3l5nOQ60a1qKxp4GuIsgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229927; c=relaxed/simple;
	bh=9IeoDBOvgld8a5i7Zf6FcVWBPUkXgXfr5TsWmwcnHWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoAumDyTRojap07eUJ7zijJ/OReCI91tY6fuZ2yYKylDt7fbyPxmUXi7ZZ6VxSmb25U9LT/UvtAZUoC9LLzO0m17xVroucMU/d0oeFS2ntP9OWiRL1ELag5liyAQ6mdgYV92n3AXxzyXQgSG+dcsu1GtLNZPc6YcT6VTPQ9VAFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7t397wz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9DFC2BCAF;
	Mon, 12 Jan 2026 14:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768229926;
	bh=9IeoDBOvgld8a5i7Zf6FcVWBPUkXgXfr5TsWmwcnHWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J7t397wzmf78ckdpFjOszgc5OVJCDYYktzkMIgTx72jYhUtge67o1W77yu6qkewtM
	 aTMGKMtQoW5RPYqpCHLloAq5h6my6cjwtSfhwM0gyXVIlKvZ9NVajXMEjhvzePzHti
	 VgLEC8TmBT7NxkFHFzDDXUZgMGVxe5l9lVnQB1jJuM78T70bTPcypjLpEKfwbHtXa+
	 5M1M7KpPs4NCcImjgG9q+8ebXXRjm3j2GIR4qsWAo+PGBKq1lr+hgmZ57QuRwca/nG
	 DMqwe3tVdeffYWacQGZoRP/8GlHIlx6Oa0TtLB98PEHAu/WBP9lhD0nT3fkWjPFi62
	 siEX9i7niV7kw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] btrfs: do not free data reservation in fallback from inline due to -ENOSPC
Date: Mon, 12 Jan 2026 09:58:05 -0500
Message-ID: <20260112145840.724774-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112145840.724774-1-sashal@kernel.org>
References: <20260112145840.724774-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit f8da41de0bff9eb1d774a7253da0c9f637c4470a ]

If we fail to create an inline extent due to -ENOSPC, we will attempt to
go through the normal COW path, reserve an extent, create an ordered
extent, etc. However we were always freeing the reserved qgroup data,
which is wrong since we will use data. Fix this by freeing the reserved
qgroup data in __cow_file_range_inline() only if we are not doing the
fallback (ret is <= 0).

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Commit Analysis: btrfs qgroup data reservation fix

### 1. COMMIT MESSAGE ANALYSIS

The commit message clearly describes a **bug fix** for btrfs qgroup
handling:
- When inline extent creation fails due to -ENOSPC, btrfs falls back to
  the normal COW (copy-on-write) path
- The bug: qgroup data reservation was being freed unconditionally
  before return
- This is incorrect because in the fallback case (ret == 1), the data
  will still be used through the COW path
- Fix: only free the reservation when NOT doing fallback (`ret <= 0`)

The commit has strong review credentials:
- Reviewed-by: Qu Wenruo (btrfs developer)
- Reviewed-by: David Sterba (btrfs maintainer)
- Author: Filipe Manana (prolific btrfs developer)

### 2. CODE CHANGE ANALYSIS

The change is extremely minimal:

```c
- btrfs_qgroup_free_data(inode, NULL, 0, fs_info->sectorsize, NULL);
+       if (ret <= 0)
+               btrfs_qgroup_free_data(inode, NULL, 0,
fs_info->sectorsize, NULL);
```

**Technical mechanism of the bug:**
1. `__cow_file_range_inline()` attempts to create an inline extent
2. If this fails with -ENOSPC, `ret` is set to 1 (signaling fallback to
   normal COW)
3. Before the fix, `btrfs_qgroup_free_data()` was called unconditionally
   at the `out:` label
4. The COW path then executes expecting to use the reserved qgroup data
5. **Problem:** The reservation was prematurely freed, causing incorrect
   qgroup accounting

**The fix logic:**
- `ret == 0`: Success → free the reservation (inline extent doesn't
  count as data extent)
- `ret < 0`: Real error → free the reservation (operation failed)
- `ret == 1`: Fallback to COW → **preserve** the reservation (data will
  be written)

### 3. CLASSIFICATION

- **Bug fix:** YES - fixes incorrect resource accounting
- **Feature addition:** NO
- **Security:** Not directly, but could affect quota enforcement
  integrity

### 4. SCOPE AND RISK ASSESSMENT

- **Lines changed:** ~3 lines effective change
- **Files touched:** 1 (fs/btrfs/inode.c)
- **Complexity:** Very low - simple conditional addition
- **Risk:** LOW - surgical fix, doesn't change any logic paths, just
  prevents premature resource freeing

### 5. USER IMPACT

**Affected users:**
- Anyone using btrfs with qgroups enabled
- Qgroups are widely used for container quota management (e.g., Docker,
  LXC) and enterprise storage

**Consequences of the bug:**
- Incorrect qgroup space accounting
- Potential quota enforcement failures
- Possible qgroup-related warnings or errors

**Trigger condition:**
- Inline extent creation fails with ENOSPC and falls back to COW
- Not uncommon when filesystems are near capacity

### 6. STABILITY INDICATORS

- Reviewed by two btrfs developers including the maintainer
- Author (Filipe Manana) is highly experienced in btrfs
- The fix is logically straightforward and obviously correct

### 7. DEPENDENCY CHECK

The fix is self-contained. Looking at the context:
```c
} else if (ret == -ENOSPC) {
    ret = 1;
    goto out;
}
```

The return value semantics (`ret == 1` for ENOSPC fallback) already
exist in the code. This fix should apply cleanly to any stable tree
containing this function.

## STABLE KERNEL CRITERIA EVALUATION

| Criterion | Assessment |
|-----------|------------|
| Obviously correct | ✅ Logic is clear and well-documented in comment |
| Fixes real bug | ✅ Incorrect qgroup accounting |
| Important issue | ✅ Affects quota management, data integrity |
| Small and contained | ✅ 3-line change, single file |
| No new features | ✅ Just a conditional guard |
| Applies cleanly | ✅ Self-contained, no dependencies |

## CONCLUSION

This commit is an excellent candidate for stable backporting. It fixes a
real bug in btrfs qgroup data reservation handling with a minimal,
surgical change. The bug causes incorrect resource accounting when
inline extent creation fails and falls back to COW - a scenario that can
happen in normal operation when filesystems approach capacity. The fix
is obviously correct, well-reviewed by btrfs maintainers, and has zero
risk of regression.

**YES**

 fs/btrfs/inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 51401d586a7b6..9e8be59ea3deb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -670,8 +670,12 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode,
 	 * it won't count as data extent, free them directly here.
 	 * And at reserve time, it's always aligned to page size, so
 	 * just free one page here.
+	 *
+	 * If we fallback to non-inline (ret == 1) due to -ENOSPC, then we need
+	 * to keep the data reservation.
 	 */
-	btrfs_qgroup_free_data(inode, NULL, 0, fs_info->sectorsize, NULL);
+	if (ret <= 0)
+		btrfs_qgroup_free_data(inode, NULL, 0, fs_info->sectorsize, NULL);
 	btrfs_free_path(path);
 	btrfs_end_transaction(trans);
 	return ret;
-- 
2.51.0


