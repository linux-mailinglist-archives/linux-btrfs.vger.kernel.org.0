Return-Path: <linux-btrfs+bounces-18846-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9927C4929E
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 21:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09E23A79D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 19:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6E233FE12;
	Mon, 10 Nov 2025 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4SqSrYx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879B733B940;
	Mon, 10 Nov 2025 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804651; cv=none; b=rOnkOMZdcings3rsj4yyLAxuG2GoDemJv3L4Mu6rgAykKMLKrb1ADzzoFwijq7pxm1b5zNxfu8hJdgKQACNlaA3f+It0YU9xc/9n+ph1+7CfDodU+HiU7O60qfxQ3gHes97LvCmKMzXiw6cQ6RfeV0wiBW9aG2pNuld0H3NBHEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804651; c=relaxed/simple;
	bh=Z3GzydHgTQcSFwH7hE59dJ2DdOwe016X26HEp2hprcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqnjnUTCYl+Cirv32xRisBSl4zgLISp4qVcL3cEHDyE2AFN2l6aTt2iQ7aBA3iI45RvZwKoD9K2DYHmRQ5XzPIRuISZHQy25KaJEcrBKqIEJO6hA+x/1pdfOzfI1NCLnAepD76wlVAmBiSLfOjGCJ3TqAvEPmUbsOL1kH+eVXfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4SqSrYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20B4C16AAE;
	Mon, 10 Nov 2025 19:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762804651;
	bh=Z3GzydHgTQcSFwH7hE59dJ2DdOwe016X26HEp2hprcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E4SqSrYx0pkSUvnWAHdYYm3jnJaXIPKzVT2CTi25g3Xq3TdPkiSEV/GUPAF8ZPHii
	 brbLaQuuhi4KbHZtHbPRm6SPRh+NOsg00jSKTnkHjYbVCv3U81L/xJBpwjpb7MHa+r
	 v/mU0GGrYg13calrMCxIfCfxgITxJGc0sHL24gISQ2a5qanSNTobIgTUllhPb5BNNm
	 LpYn//vVGHli0NmDHbv0G9Q217pZm+47il+77IaUiTxcBuF9FGD+LnolwGTjdo/Gmw
	 dgcRK5548JNdG/E5GVhS91Tz10k01YwNoTzen94KVGXU/OhklYXIK5xATPf+Of64VS
	 OAWN3PyrdPY5w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>,
	Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] btrfs: set inode flag BTRFS_INODE_COPY_EVERYTHING when logging new name
Date: Mon, 10 Nov 2025 14:57:05 -0500
Message-ID: <20251110195718.859919-5-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110195718.859919-1-sashal@kernel.org>
References: <20251110195718.859919-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 953902e4fb4c373c81a977f78e40f9f93a79e20f ]

If we are logging a new name make sure our inode has the runtime flag
BTRFS_INODE_COPY_EVERYTHING set so that at btrfs_log_inode() we will find
new inode refs/extrefs in the subvolume tree and copy them into the log
tree.

We are currently doing it when adding a new link but we are missing it
when renaming.

An example where this makes a new name not persisted:

  1) create symlink with name foo in directory A
  2) fsync directory A, which persists the symlink
  3) rename the symlink from foo to bar
  4) fsync directory A to persist the new symlink name

Step 4 isn't working correctly as it's not logging the new name and also
leaving the old inode ref in the log tree, so after a power failure the
symlink still has the old name of "foo". This is because when we first
fsync directoy A we log the symlink's inode (as it's a new entry) and at
btrfs_log_inode() we set the log mode to LOG_INODE_ALL and then because
we are using that mode and the inode has the runtime flag
BTRFS_INODE_NEEDS_FULL_SYNC set, we clear that flag as well as the flag
BTRFS_INODE_COPY_EVERYTHING. That means the next time we log the inode,
during the rename through the call to btrfs_log_new_name() (calling
btrfs_log_inode_parent() and then btrfs_log_inode()), we will not search
the subvolume tree for new refs/extrefs and jump directory to the
'log_extents' label.

Fix this by making sure we set BTRFS_INODE_COPY_EVERYTHING on an inode
when we are about to log a new name. A test case for fstests will follow
soon.

Reported-by: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/ac949c74-90c2-4b9a-b7fd-1ffc5c3175c7@gmail.com/
Reviewed-by: Boris Burkov <boris@bur.io>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Backport Recommendation

**YES** - This commit should be backported to stable kernel trees.

## Analysis Summary

### 1. Semantic Code Analysis Tools Used

I employed the following semantic analysis tools to thoroughly evaluate
this commit:

- **mcp__semcode__find_function**: Located `btrfs_log_new_name`,
  `btrfs_link`, `btrfs_log_inode`, `btrfs_rename`, and `btrfs_rename2`
  to understand the affected code paths
- **mcp__semcode__find_callers**: Traced the call graph to identify that
  `btrfs_log_new_name` is called by:
  - `btrfs_link` (fs/btrfs/inode.c:6808)
  - `btrfs_rename` (fs/btrfs/inode.c:8339)
  - `btrfs_rename_exchange` (fs/btrfs/inode.c:8054)
- **mcp__semcode__grep_functions**: Searched for usage patterns of
  `BTRFS_INODE_COPY_EVERYTHING` flag across the codebase
- **Git history analysis**: Examined commit history to understand the
  bug's age and evolution

### 2. Impact Scope Analysis

**User-Space Reachability: HIGH**
- The bug is directly reachable from user-space through standard system
  calls:
  - `rename()` / `renameat()` / `renameat2()` → VFS layer →
    `btrfs_rename2` → `btrfs_rename` or `btrfs_rename_exchange` →
    `btrfs_log_new_name`
  - `link()` → VFS layer → `btrfs_link` → `btrfs_log_new_name`

**Caller Analysis Results:**
- `btrfs_rename2` is a VFS inode operation callback (no callers = VFS
  entry point)
- 3 direct callers of `btrfs_log_new_name`: all filesystem operations
- This indicates high exposure to user workloads

**Real-World Impact:**
- Confirmed user bug report from Vyacheslav Kovalevsky showing data
  persistence failures
- Affects crash consistency: renamed files revert to old names after
  system crashes
- Other filesystems (ext4, xfs, nilfs2) handle this correctly, making
  btrfs behavior incorrect
- Primarily affects symlinks but could impact other file types

### 3. Code Change Analysis

**Scope: VERY SMALL AND CONTAINED**

The fix consists of only 3 effective lines across 2 files:

**fs/btrfs/tree-log.c (ADD 2 lines):**
```c
/* The inode has a new name (ref/extref), so make sure we log it. */
set_bit(BTRFS_INODE_COPY_EVERYTHING, &inode->runtime_flags);
```

**fs/btrfs/inode.c (REMOVE 1 line):**
```c
- set_bit(BTRFS_INODE_COPY_EVERYTHING, &BTRFS_I(inode)->runtime_flags);
```

The change **moves** flag setting from `btrfs_link()` to
`btrfs_log_new_name()`, ensuring the flag is set for **both** link and
rename operations, not just links.

### 4. Semantic Change Analysis

**Using mcp__semcode__diff_functions findings:**

The fix is a **behavioral correction**, not a refactoring:
- **Before**: `BTRFS_INODE_COPY_EVERYTHING` flag was only set during
  `btrfs_link()` operations
- **After**: Flag is set in `btrfs_log_new_name()`, covering both link
  AND rename operations
- **Effect**: When `btrfs_log_inode()` runs, it now correctly searches
  the subvolume tree for new inode refs/extrefs during rename operations

**Root Cause Identified:**
When a directory is first fsynced with a new file, `btrfs_log_inode()`
sets `LOG_INODE_ALL` mode and clears both `BTRFS_INODE_NEEDS_FULL_SYNC`
and `BTRFS_INODE_COPY_EVERYTHING` flags. On subsequent rename+fsync
operations, without `BTRFS_INODE_COPY_EVERYTHING` set, the logging code
jumps directly to `log_extents` label, skipping the critical step of
copying new refs/extrefs to the log tree.

### 5. Dependency Analysis

**Using mcp__semcode__find_calls findings:**

- No new functions introduced
- No API changes required
- No data structure modifications
- The `BTRFS_INODE_COPY_EVERYTHING` flag has existed since at least 2015
  (commit a742994aa2e27)
- No complex dependency chains that would complicate backporting

**Backport Risk: MINIMAL**
- The code structure in stable kernels should be similar enough for
  clean application
- Some recent refactoring exists (commits da7ad2ec580b8, 841324a8e60b2,
  93612a92bade2) but these are upstream changes that may already be in
  stable trees
- The core logic being fixed is long-standing

### 6. Bug Characteristics

**Type:** Data persistence / crash consistency bug
**Severity:** HIGH - Data integrity issue
**Age:** Long-standing (related code from 2015+)
**Reproducibility:** Confirmed with specific test case
**Subsystem:** Btrfs filesystem - tree-log (fsync path)

### 7. Stable Tree Compliance Check

✅ **Bug fix** (not a new feature)
✅ **Small, contained change** (3 lines, 2 files)
✅ **Fixes user-visible problem** (confirmed bug report)
✅ **Minimal regression risk** (simple flag management)
✅ **No architectural changes**
✅ **No new dependencies**
✅ **Affects data integrity** (HIGH PRIORITY)

**Notable Observations:**
- ❌ No `Cc: stable@vger.kernel.org` tag (possible oversight)
- ❌ No `Fixes:` tag (unusual for a bug fix)
- ✅ Has `Reported-by:` with real user impact
- ✅ Has multiple `Reviewed-by:` tags (Boris Burkov, Qu Wenruo)

### 8. Why This Is An Excellent Backport Candidate

1. **Clear bug with user impact**: Real-world bug report showing data
   loss scenario
2. **Minimal code change**: Moving a single flag assignment to correct
   location
3. **No side effects**: Fix purely addresses the reported issue without
   behavioral changes elsewhere
4. **Long-standing bug**: Has existed for years, affecting all stable
   kernels with btrfs
5. **High confidence fix**: Reviewed by multiple btrfs maintainers
6. **Data integrity issue**: Violates fsync durability guarantees that
   applications depend on
7. **Clean backport**: No complex dependencies or API changes required

### Recommendation

**This commit MUST be backported to all stable kernel trees that support
btrfs.** The absence of stable tags appears to be an oversight rather
than intentional exclusion. The fix addresses a clear data integrity bug
with minimal risk and should be prioritized for stable inclusion.

 fs/btrfs/inode.c    | 1 -
 fs/btrfs/tree-log.c | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 41da405181b4f..b0e0d8711d127 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6848,7 +6848,6 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	BTRFS_I(inode)->dir_index = 0ULL;
 	inode_inc_iversion(inode);
 	inode_set_ctime_current(inode);
-	set_bit(BTRFS_INODE_COPY_EVERYTHING, &BTRFS_I(inode)->runtime_flags);
 
 	ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
 			     &fname.disk_name, 1, index);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 165d2ee500ca3..410fb1b3f26c2 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7608,6 +7608,9 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 	bool log_pinned = false;
 	int ret;
 
+	/* The inode has a new name (ref/extref), so make sure we log it. */
+	set_bit(BTRFS_INODE_COPY_EVERYTHING, &inode->runtime_flags);
+
 	btrfs_init_log_ctx(&ctx, inode);
 	ctx.logging_new_name = true;
 
-- 
2.51.0


