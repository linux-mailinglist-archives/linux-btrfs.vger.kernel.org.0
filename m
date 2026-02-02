Return-Path: <linux-btrfs+bounces-21294-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH4QOJQbgWm0EAMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21294-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Feb 2026 22:48:04 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAA3D1C88
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Feb 2026 22:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25ACC301C725
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Feb 2026 21:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3535F316190;
	Mon,  2 Feb 2026 21:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUcye/ro"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826981C84BD;
	Mon,  2 Feb 2026 21:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068831; cv=none; b=H0cxHkzsd0QqTH6J3w44p2XIGGNjNd7B3fb64mxPHFo84mhWM1t4jux5m6s3csm9G5GRNgE0TBvC6pd1n2BCJVjWHmEtvOdf4c/NS2IVAK+bcdZuHrp+NcQ17cpt95c2bNMFEAdBh4zrRBqODvogBAOBFDnsubToZbLCG2y/ASM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068831; c=relaxed/simple;
	bh=2Vgx4ah3QCD/wKqotM08VvSQGy89QT7N5q9u7CQOhxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMAw3AjR+H+JQ1AE0xhpqY5dzkaNo7Dp3y/e/Cq2vZksJLZtxAjLPXvlx999oBlv6R6YzW2xEg9MajJO6jzAEICGXRj25CaRnTuEdhuCsjYP5+VeQTe9TUV+x/iNy9j7sXORI4/Pe7dIBJokq7cONfV23Z9dUiKVImjTYrylc7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUcye/ro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9475C2BC86;
	Mon,  2 Feb 2026 21:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770068831;
	bh=2Vgx4ah3QCD/wKqotM08VvSQGy89QT7N5q9u7CQOhxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZUcye/ronTYMEs/46ooywyd35mBBoA5HcihuQxyLecV0f1tBY01FqaW9FZNSTl+WS
	 Li8Zyxkm2GFh7rzFBa1L9ZYrm4/Ka48XJFLMuXi7vwQsm8zx9RfHieQNrM7I508C/E
	 CyPadaY9g4PEq6AT6ThVl6rfa/+yZLhYR1k9JP817dmKke9so24ZGpy0TBmjUtSwXu
	 OaWwgud1yKGNSRBBFsEz06nzyxCTq8OUsBwx0myNFHB1ucVX/wkcKcwL7cXve48G96
	 UvXmym5Blel39QG0AWP0fGrEhG/tK367PMilr9x2FP8ny+T5zopS6ZyCQlkNAC3i9+
	 77jLI4GUdfBww==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Qiang Ma <maqianga@uniontech.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] btrfs: fix Wmaybe-uninitialized warning in replay_one_buffer()
Date: Mon,  2 Feb 2026 16:46:07 -0500
Message-ID: <20260202214643.212290-12-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202214643.212290-1-sashal@kernel.org>
References: <20260202214643.212290-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21294-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 8FAA3D1C88
X-Rspamd-Action: no action

From: Qiang Ma <maqianga@uniontech.com>

[ Upstream commit 9c7e71c97c8cd086b148d0d3d1cd84a1deab023c ]

Warning was found when compiling using loongarch64-gcc 12.3.1:

  $ make CFLAGS_tree-log.o=-Wmaybe-uninitialized

  In file included from fs/btrfs/ctree.h:21,
		   from fs/btrfs/tree-log.c:12:
  fs/btrfs/accessors.h: In function 'replay_one_buffer':
  fs/btrfs/accessors.h:66:16: warning: 'inode_item' may be used uninitialized [-Wmaybe-uninitialized]
     66 |         return btrfs_get_##bits(eb, s, offsetof(type, member));         \
	|                ^~~~~~~~~~
  fs/btrfs/tree-log.c:2803:42: note: 'inode_item' declared here
   2803 |                 struct btrfs_inode_item *inode_item;
	|                                          ^~~~~~~~~~

Initialize the inode_item to NULL, the compiler does not seem to see the
relation between the first 'wc->log_key.type == BTRFS_INODE_ITEM_KEY'
check and the other one that also checks the replay phase.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a clear understanding of the code flow. Let me verify what
the commit changes and analyze it:

## Analysis Summary

### 1. COMMIT MESSAGE ANALYSIS

The commit addresses a compiler warning (`-Wmaybe-uninitialized`) for
the `inode_item` pointer in `replay_one_buffer()`. The warning is
triggered by certain compilers (loongarch64-gcc 12.3.1 in this case)
that don't recognize the relationship between:
- The first check: `wc->log_key.type == BTRFS_INODE_ITEM_KEY` (which
  assigns `inode_item`)
- The later use: `wc->log_key.type == BTRFS_INODE_ITEM_KEY && wc->stage
  == LOG_WALK_REPLAY_INODES` (which uses `inode_item`)

The compiler can't prove that `inode_item` is always initialized before
use due to the complex conditional logic.

### 2. CODE CHANGE ANALYSIS

The change is trivial:
```c
- struct btrfs_inode_item *inode_item;
+ struct btrfs_inode_item *inode_item = NULL;
```

Looking at the control flow:
- Line 2807: `if (wc->log_key.type == BTRFS_INODE_ITEM_KEY)` -
  inode_item is assigned via `btrfs_item_ptr()`
- Line 2838-2845: `if (wc->log_key.type == BTRFS_INODE_ITEM_KEY &&
  wc->stage == LOG_WALK_REPLAY_INODES)` - inode_item is used via
  `btrfs_inode_mode(eb, inode_item)`

Logically, whenever the second condition is true, the first condition
must also have been true (both check `wc->log_key.type ==
BTRFS_INODE_ITEM_KEY`), so `inode_item` will have been assigned. But
some compilers cannot deduce this relationship due to the second
condition also checking `wc->stage`.

### 3. CLASSIFICATION

This is a **build fix** - it silences a compiler warning. It falls under
the "BUILD FIXES" exception category:
- Fixes for compilation warnings
- Zero risk of runtime regression (initializing a pointer to NULL that
  will always be properly assigned before use)

### 4. SCOPE AND RISK ASSESSMENT

- **Lines changed**: 1 line
- **Files touched**: 1 file (fs/btrfs/tree-log.c)
- **Complexity**: Trivial - just adding `= NULL` initialization
- **Risk**: Extremely low - this is a defensive initialization that
  doesn't change runtime behavior

The only possible risk would be if the compiler warning was actually
detecting a real bug. However, analyzing the code:
- Line 2838 checks `wc->log_key.type == BTRFS_INODE_ITEM_KEY` AND
  `wc->stage == LOG_WALK_REPLAY_INODES`
- Line 2807 checks `wc->log_key.type == BTRFS_INODE_ITEM_KEY`
- If we reach line 2845 (where `inode_item` is used), we must have
  passed the check at 2838, which implies `wc->log_key.type ==
  BTRFS_INODE_ITEM_KEY` is true, which means we also entered the block
  at 2807 and assigned `inode_item`.

The warning is a false positive.

### 5. USER IMPACT

- This fixes a compiler warning that can be annoying for
  developers/users who enable `-Wmaybe-uninitialized`
- Some build configurations with stricter warning settings (e.g.,
  `-Werror`) could fail to compile without this fix
- The btrfs subsystem is widely used, so build issues affect many users

### 6. STABILITY INDICATORS

- **Reviewed-by: David Sterba <dsterba@suse.com>** - David Sterba is the
  btrfs maintainer
- **Signed-off-by: David Sterba <dsterba@suse.com>** - Merged by the
  maintainer
- This is a simple, obviously correct fix

### 7. DEPENDENCY CHECK

- No dependencies on other commits
- This is a self-contained one-line change
- The code exists in stable trees (tree-log.c is present in all kernel
  versions)

## Conclusion

This commit is an ideal candidate for stable backporting:

1. **Meets stable criteria**:
   - Obviously correct - trivial initialization
   - Fixes a real issue - compiler warning that could break builds with
     strict settings
   - Small and contained - single line change
   - No new features

2. **Falls under BUILD FIXES exception**: Compiler warning fixes are
   explicitly allowed in stable

3. **Zero risk**: Initializing a pointer to NULL that is guaranteed to
   be assigned before use cannot cause any runtime regression

4. **Maintainer approved**: Reviewed and merged by David Sterba, the
   btrfs maintainer

**YES**

 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 1444857de9fe8..ae2e035d013e2 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2800,7 +2800,7 @@ static int replay_one_buffer(struct extent_buffer *eb,
 
 	nritems = btrfs_header_nritems(eb);
 	for (wc->log_slot = 0; wc->log_slot < nritems; wc->log_slot++) {
-		struct btrfs_inode_item *inode_item;
+		struct btrfs_inode_item *inode_item = NULL;
 
 		btrfs_item_key_to_cpu(eb, &wc->log_key, wc->log_slot);
 
-- 
2.51.0


