Return-Path: <linux-btrfs+bounces-20407-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF557D137C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 16:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C57503178CF5
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 15:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8AF2EA151;
	Mon, 12 Jan 2026 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPUhb6/z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC31C2DF130;
	Mon, 12 Jan 2026 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229957; cv=none; b=di2UUMyBmep04Po8+oeQGhQrEiWXu0hXEG31tNrGYWTQ4b71Clk5kxq/P5xeOB1oHYyro2JEq+R9v5V9YEh/iYJCvLUUXg5+nhG9q336BMFFwUZIBAaDs8TXffS5OmjJWxeup8KQSzEpHtwNOaJUH8omeQwEwIhdL4rPBCOj01k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229957; c=relaxed/simple;
	bh=Z5TDojuMgBADVfYFxKXv8kAQqPgNhjA9xpQie0XtfDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cnUQHBhzDQNryjzYGHGuhQVDi4hSpp4W6zdB7iUL8kaQFo6efEilrs9igDlk0/JEGzLcTAO/VWvyGvQNRn/GFakTzQwnIaZaGBMhAwMaryyssWgly2hdw/FC70sqrxVIJ4vBgHFLoUZyrE3hmEzWeEA3z5EZsVxNf7EpoPkPBiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPUhb6/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F06C2BCB1;
	Mon, 12 Jan 2026 14:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768229956;
	bh=Z5TDojuMgBADVfYFxKXv8kAQqPgNhjA9xpQie0XtfDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fPUhb6/zIEAUotn87+ppxnjcQVZqf+ZI5NuoBhIEAIAaRYwd37qpjptGxYEi5PYg/
	 d3lfG1YRVrg1UvNUvv6k10qxfkv500ZvNen1KJ827+uMRwJw9Phh4iXR2XKtxMy2gz
	 fu9VNx2ir/XKOe+s9rfFI9BTsgNVb1ZbVav+ppbtMUcXKCYTMlteClLFBny4MzPX2F
	 k2qSC6oJYjV0fRZhxAxZReqDGeuAJ0RQQ7m4BoAIBheyLhiZjc78Ky9oij3Nl+dyQ5
	 4korHy9KGW/IIvRfbKyFl0WvyuXaTDqC1msxA6hOHr4Sq9Wd/aSZDLD15P4gGWjdJK
	 zsdtfn3HcXoHA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.1] btrfs: fix reservation leak in some error paths when inserting inline extent
Date: Mon, 12 Jan 2026 09:58:22 -0500
Message-ID: <20260112145840.724774-21-sashal@kernel.org>
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

[ Upstream commit c1c050f92d8f6aac4e17f7f2230160794fceef0c ]

If we fail to allocate a path or join a transaction, we return from
__cow_file_range_inline() without freeing the reserved qgroup data,
resulting in a leak. Fix this by ensuring we call btrfs_qgroup_free_data()
in such cases.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Commit Analysis: btrfs: fix reservation leak in some error paths when
inserting inline extent

### 1. COMMIT MESSAGE ANALYSIS

The subject clearly indicates a **bug fix** for a "reservation leak" in
error paths. The body explains:
- When `btrfs_alloc_path()` fails or `btrfs_join_transaction()` fails,
  the function returned early
- The reserved qgroup data was never freed in these error paths
- This results in a resource leak

**Tags**: Reviewed-by and Signed-off-by from David Sterba (btrfs
maintainer), authored by Filipe Manana (experienced btrfs developer).
Excellent review coverage.

### 2. CODE CHANGE ANALYSIS

**The Bug (Before):**
```c
path = btrfs_alloc_path();
if (!path)
    return -ENOMEM;  // Early return - leaks qgroup reservation

trans = btrfs_join_transaction(root);
if (IS_ERR(trans)) {
    btrfs_free_path(path);
    return PTR_ERR(trans);  // Early return - leaks qgroup reservation
}
```

**The Fix (After):**
```c
path = btrfs_alloc_path();
if (!path) {
    ret = -ENOMEM;
    goto out;  // Goes to cleanup that calls btrfs_qgroup_free_data()
}

trans = btrfs_join_transaction(root);
if (IS_ERR(trans)) {
    ret = PTR_ERR(trans);
    trans = NULL;
    goto out;  // Goes to cleanup that calls btrfs_qgroup_free_data()
}
```

Additional changes:
- Initialize `trans = NULL` at declaration
- Add NULL check before `btrfs_end_transaction(trans)` in cleanup

**Root cause**: Early returns bypassed the `out` label where
`btrfs_qgroup_free_data()` is called for error cases (`ret <= 0`).

**Why the fix works**: Redirects error paths to use `goto out`, ensuring
all exits pass through existing cleanup logic.

### 3. CLASSIFICATION

- **Type**: Bug fix (resource leak)
- **Category**: Error handling fix in filesystem code
- **Not a feature addition**: Pure cleanup path fix

### 4. SCOPE AND RISK ASSESSMENT

- **Size**: ~20 lines changed in a single file (`fs/btrfs/inode.c`)
- **Scope**: Single function `__cow_file_range_inline()`
- **Complexity**: Very low - simple control flow change (early return →
  goto)
- **Risk**: Very low
  - Uses existing cleanup logic already tested for other error paths
  - The NULL check on `trans` is a proper safeguard
  - No algorithm changes, no new logic

### 5. USER IMPACT

- **Affected users**: btrfs users with qgroups enabled
- **Trigger conditions**: ENOMEM or transaction join failure during
  inline extent insertion
- **Severity**: Resource leak that accumulates over time, can cause
  incorrect qgroup accounting
- **Frequency**: Error conditions are rare, but when they occur, the
  leak is guaranteed

### 6. STABILITY INDICATORS

- Authored by Filipe Manana (prolific btrfs contributor)
- Reviewed by David Sterba (btrfs maintainer)
- Signed-off by David Sterba

### 7. DEPENDENCY CHECK

- Self-contained fix
- No dependencies on other commits
- The affected function and `btrfs_qgroup_free_data()` exist in stable
  trees
- The code structure is stable and not recently added

## Conclusion

This commit is an **ideal stable candidate**:

1. **Obviously correct**: Simple redirection of error paths to existing
   cleanup code
2. **Fixes a real bug**: Qgroup data reservation leak that can
   accumulate over time
3. **Small and contained**: ~20 lines, one file, one function
4. **No new features**: Pure bug fix
5. **Well-reviewed**: By btrfs maintainers
6. **Low risk**: Uses existing cleanup logic, minimal code change
7. **Important for users**: Btrfs with qgroups is a common configuration

The fix is surgical, low-risk, and addresses a genuine resource leak in
the btrfs filesystem. It meets all stable kernel criteria.

**YES**

 fs/btrfs/inode.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9e8be59ea3deb..0d61e0ee2f86f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -614,19 +614,22 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode,
 	struct btrfs_drop_extents_args drop_args = { 0 };
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_trans_handle *trans;
+	struct btrfs_trans_handle *trans = NULL;
 	u64 data_len = (compressed_size ?: size);
 	int ret;
 	struct btrfs_path *path;
 
 	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	trans = btrfs_join_transaction(root);
 	if (IS_ERR(trans)) {
-		btrfs_free_path(path);
-		return PTR_ERR(trans);
+		ret = PTR_ERR(trans);
+		trans = NULL;
+		goto out;
 	}
 	trans->block_rsv = &inode->block_rsv;
 
@@ -677,7 +680,8 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode,
 	if (ret <= 0)
 		btrfs_qgroup_free_data(inode, NULL, 0, fs_info->sectorsize, NULL);
 	btrfs_free_path(path);
-	btrfs_end_transaction(trans);
+	if (trans)
+		btrfs_end_transaction(trans);
 	return ret;
 }
 
-- 
2.51.0


