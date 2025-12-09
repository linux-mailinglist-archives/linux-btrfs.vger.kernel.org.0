Return-Path: <linux-btrfs+bounces-19587-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1333CCAE779
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 01:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 134CF301C3DC
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 00:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E027221F11;
	Tue,  9 Dec 2025 00:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEV/vrr/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621D52153FB;
	Tue,  9 Dec 2025 00:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239405; cv=none; b=ua4cPDOYPxLMzsLBLzSX0sN+TOFiDaSMG0MtffHeHBpBXmc5xLefUg5AdQwTQ2FbWWrhFvJMSqq6dcf8wVvhu0WgnRN1PRZE7VM5P01+zAZFCxBFMoKIj0N67TIcQOkAgBhh5XbD5QVsA5EDZ9Bn0PE9WOq4PlgBJ+Ub8GwxB+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239405; c=relaxed/simple;
	bh=OpNSX1v9idoEn+6GZ+Br/BSw8EWqZDVgpOB95jDvS00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xddw/ZdiP8jmS3CgERPKldajEJh0CFI2iVIYNWKhE8IuRi0gRNfKW7C9mKVmnac+Hz4mxNpdau4U6z/cgOj9ATiMk1YYc1AMVsJkt97N4ciyx0BzV//y9lim4hqAn56WYiHzkEJtZR8I8BOzvoUIqTUEvGEd0750Bjn1Y8r7tvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEV/vrr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A168C4CEF1;
	Tue,  9 Dec 2025 00:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765239404;
	bh=OpNSX1v9idoEn+6GZ+Br/BSw8EWqZDVgpOB95jDvS00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SEV/vrr/bQK34Obzntn7eYxt/o1BYfMemoLPmHcej0OerVg0dm1xdYXhLlHPTM6/h
	 c+zZQGSw+OvESLTLJdaNHiB/zIV/k35LX/F6jX/tyaTW1ObVKjWlu0di1n8JnF2VZ+
	 Vkh/m/qT2rJyEQCzfVevKQTIfDebgbK2xSB8GUzg7f1LlmzXfNj+Dyjr3Co4FjH2/3
	 opPGbdI7QRotaamZwVx98/4zfYSQgfMzSE51dsd/F1Db7NRbJknisgWD7hEhM7n9OJ
	 IRfJOQKXbSeYc1rfc7rU5Hr6IAi4zKFB8bs41QDllzfjNcoa+Kd2NqxNVuMteC1JS8
	 6p5CCy/KAyWxw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.6] btrfs: abort transaction on item count overflow in __push_leaf_left()
Date: Mon,  8 Dec 2025 19:14:58 -0500
Message-ID: <20251209001610.611575-6-sashal@kernel.org>
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
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 5d8222a50ad37c98455da08b33ce49fe6b726c72 ]

If we try to push an item count from the right leaf that is greater than
the number of items in the leaf, we just emit a warning. This should
never happen but if it does we get an underflow in the new number of
items in the right leaf and chaos follows from it. So replace the warning
with proper error handling, by aborting the transaction and returning
-EUCLEAN, and proper logging by using btrfs_crit() instead of WARN(),
which gives us proper formatting and information about the filesystem.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Commit Analysis: btrfs: abort transaction on item count overflow in
__push_leaf_left()

### 1. COMMIT MESSAGE ANALYSIS

**Key points:**
- Fixes an item count overflow condition where `push_items >
  right_nritems`
- Currently only emits a WARN() but continues execution
- If triggered, causes "an underflow in the new number of items in the
  right leaf and chaos follows"
- Replaces warning with proper error handling (abort transaction, return
  -EUCLEAN)

**Tags:**
- No `Cc: stable@vger.kernel.org` tag
- No `Fixes:` tag
- Has two `Reviewed-by:` tags (Qu Wenruo and David Sterba - btrfs
  maintainer)

### 2. CODE CHANGE ANALYSIS

**Before (problematic):**
```c
if (push_items > right_nritems)
    WARN(1, KERN_CRIT "push items %d nr %u\n", push_items,
right_nritems);
// Continues execution despite the error!
```

**After (fixed):**
```c
if (unlikely(push_items > right_nritems)) {
    ret = -EUCLEAN;
    btrfs_abort_transaction(trans, ret);
    btrfs_crit(fs_info, "push items (%d) > right leaf items (%u)",
               push_items, right_nritems);
    goto out;
}
```

**Technical mechanism of the bug:**
- `__push_leaf_left()` pushes items from right leaf to left leaf in
  btrfs B-tree
- If `push_items > right_nritems`, later code does `right_nritems -=
  push_items`
- Since `right_nritems` is `u32`, this causes an **integer underflow**
- The underflowed value is then set via `btrfs_set_header_nritems(right,
  right_nritems)`
- This corrupts the B-tree structure, leading to filesystem corruption

### 3. CLASSIFICATION

- **Type:** Bug fix - upgrading inadequate error handling to proper
  abort
- **Not adding features:** Purely defensive error handling improvement
- **Severity:** Prevents potential filesystem/data corruption
- **Pattern:** Converts warn-and-continue to abort-and-return on
  corruption detection

### 4. SCOPE AND RISK ASSESSMENT

| Factor | Assessment |
|--------|------------|
| Lines changed | ~10 lines |
| Files touched | 1 (fs/btrfs/ctree.c) |
| Complexity | Very low |
| Subsystem maturity | btrfs is mature and widely used |
| Regression risk | **Near zero** - if condition never triggers,
behavior unchanged; if it does, abort is safer than corruption |

The change uses existing infrastructure (`btrfs_abort_transaction`,
`goto out` path) that's already present and tested.

### 5. USER IMPACT

- **Affected users:** All btrfs users
- **Code location:** Core B-tree code - fundamental to all btrfs
  operations
- **If bug triggers:** Filesystem corruption, potentially unmountable
  filesystem
- **Frequency:** Described as "should never happen" but defensive check
  was already there

### 6. STABILITY INDICATORS

- Two reviewers from btrfs team
- Signed off by btrfs maintainer (David Sterba)
- Conservative, defensive fix with well-understood behavior

### 7. DEPENDENCY CHECK

- Self-contained fix with no dependencies
- Uses existing error handling patterns present in all stable trees
- This code has existed in btrfs for many years

### DECISION RATIONALE

**For backporting:**
1. **Prevents data corruption** - the most critical category of bugs for
   filesystems
2. **Minimal risk** - the fix cannot cause regression in normal
   operation
3. **Small and surgical** - ~10 lines, single file, obvious correctness
4. **Well-reviewed** - two experienced btrfs developers signed off
5. **Core subsystem** - btrfs is used in production by enterprise users
   relying on stable trees
6. **Integer underflow** - these are exactly the type of bugs stable
   trees want fixed

**Against backporting:**
1. No explicit `Cc: stable` tag
2. No `Fixes:` tag
3. Condition described as "should never happen"

**Assessment:** While the maintainer didn't explicitly request stable
backport, the fix meets all stable criteria:
- Obviously correct (straightforward error handling)
- Fixes a real bug (underflow leading to corruption)
- Small and contained (10 lines, 1 file)
- No new features

The severity of the potential consequence (filesystem corruption)
combined with the trivial risk of the fix makes this an appropriate
stable candidate. Filesystems are exactly where defensive hardening
matters most for stable users.

**YES**

 fs/btrfs/ctree.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 561658aca018b..3acb3027584d7 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3398,9 +3398,13 @@ static noinline int __push_leaf_left(struct btrfs_trans_handle *trans,
 	btrfs_set_header_nritems(left, old_left_nritems + push_items);
 
 	/* fixup right node */
-	if (push_items > right_nritems)
-		WARN(1, KERN_CRIT "push items %d nr %u\n", push_items,
-		       right_nritems);
+	if (unlikely(push_items > right_nritems)) {
+		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
+		btrfs_crit(fs_info, "push items (%d) > right leaf items (%u)",
+			   push_items, right_nritems);
+		goto out;
+	}
 
 	if (push_items < right_nritems) {
 		push_space = btrfs_item_offset(right, push_items - 1) -
-- 
2.51.0


