Return-Path: <linux-btrfs+bounces-21836-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFGQIIVKnGmODAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21836-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 13:39:33 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BC11763E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 13:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AFB1308AF4F
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 12:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8153D366073;
	Mon, 23 Feb 2026 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqV86eGL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3BE366045;
	Mon, 23 Feb 2026 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850265; cv=none; b=BjZpEwvCVUvye6kMxYHnmnvzFl4c4rK2ws2JQFkdDeg6Ap5qH5d771lJTia1dKYWwJH1OUXgX8PfFnR7L2BQWgTDx6YNJGDkrYS2uzU8UWX2/7EnYHdIJnKeBi/yomdmqB6NS1eIJiEW15QB/FJ/gY++8d4jr6708HvZjGyBBR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850265; c=relaxed/simple;
	bh=qCNdhU8EOJo463mruZX+JLfGxhk7zjp/WuKH4k5Vmo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVgqukeoHPpGjnlOZbTQeng72u3/VtKBOgbeT57uJbkO50VryrqvpzsoQew6rDnpvjOepwVpmMtkcAec3UZrIxFEpQvIeW0rko6bsqy2Aczb+46c9hwpq8vA8ECwiy6d23+Evyvl1bND4iAvc3fjOJ6iedY05oI0p8GRx+hF6zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqV86eGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DE6C116D0;
	Mon, 23 Feb 2026 12:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771850265;
	bh=qCNdhU8EOJo463mruZX+JLfGxhk7zjp/WuKH4k5Vmo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pqV86eGLY+reqUEoIigl7EMynsfvuvvvyYMsC/D+LaQFO5F10Nt1nfK0FdqXGHSYe
	 bta2YvdvEiq7KLuZIMfdRV0CmXQTLUY57K5ZywOkLMbNsSrhuYAfNxlcNlYpowMLha
	 LFZBopwCEx2unqrmxxeQlKi9WAj6tTQrn54+jtfAhtzg81pqzncRzIQVr5VluH+9lr
	 sqMo/dm/q2xj8OU+gFNovhfS8nfk6P/aE6oPhHn1STLkAUsEpCHB213rqkGuVpyfTB
	 O3dCFVBkZEU37wBxMyDMzmpvPb+3WXvSJ9SlC2RF6X61DzUVl84Yk79sye1EZGZvMj
	 iUgspZqlFkqGQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Adarsh Das <adarshdas950@gmail.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.15] btrfs: replace BUG() with error handling in __btrfs_balance()
Date: Mon, 23 Feb 2026 07:37:09 -0500
Message-ID: <20260223123738.1532940-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223123738.1532940-1-sashal@kernel.org>
References: <20260223123738.1532940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.3
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,kernel.org,fb.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21836-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2BC11763E6
X-Rspamd-Action: no action

From: Adarsh Das <adarshdas950@gmail.com>

[ Upstream commit be6324a809dbda76d5fdb23720ad9b20e5c1905c ]

We search with offset (u64)-1 which should never match exactly.
Previously this was handled with BUG(). Now logs an error
and return -EUCLEAN.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### What the commit does

This commit replaces a `BUG()` call with proper error handling in
`__btrfs_balance()`. The `BUG()` is triggered when `btrfs_search_slot()`
returns an exact match (ret == 0) for key offset `(u64)-1`, which should
theoretically never happen. The existing code has a `/* FIXME break ?
*/` comment from 2012, indicating the developers always knew `BUG()` was
wrong here.

The fix:
1. Replaces `BUG()` with `btrfs_err()` logging + return `-EUCLEAN`
2. Properly releases `reclaim_bgs_lock` mutex before `goto error`
   (fixing what would have been a mutex held across a panic)
3. Uses `unlikely()` to indicate this is an exceptional path

### Bug severity assessment

**The existing `BUG()` crashes the kernel** (panic/oops). While the
condition "should never happen," if it does occur (e.g., due to
filesystem corruption, a prior failed relocate as the comment says, or a
metadata inconsistency), the result is a full kernel crash instead of a
graceful error return. This is in the btrfs balance path, which is user-
triggered via `btrfs balance start`.

Key points:
- **BUG() = kernel crash** - This is a real fix that prevents a kernel
  panic
- **User-triggerable**: The balance operation is initiated by userspace,
  so a corrupted filesystem could trigger this crash
- **The fix is small and surgical**: Only changes the error handling for
  one condition
- **Properly handles mutex**: The new code correctly unlocks
  `reclaim_bgs_lock` before the error path
- **Well-reviewed**: Reviewed by Qu Wenruo and David Sterba (btrfs
  maintainer)
- **BUG() has existed since 2012** (commit c9e9f97bdfb64d), affecting
  all stable trees

### Stable criteria evaluation

- **Obviously correct**: Yes - replacing BUG() with error handling is
  well-understood
- **Fixes a real bug**: Yes - a kernel crash/panic on a theoretically-
  impossible-but-not-actually-impossible condition
- **Small and contained**: Yes - one file, simple logic change in a
  single function
- **No new features**: Correct - pure error handling improvement
- **Risk**: Very low - the only change is what happens when ret == 0,
  and the new behavior (return error) is strictly better than crashing

### Verification

- `git blame` confirmed the BUG() has been present since commit
  c9e9f97bdfb64d (2012, "Btrfs: add basic restriper infrastructure")
- Read the code at lines 4104-4116: confirmed `reclaim_bgs_lock` is held
  when BUG() fires, so the panic would also leave a mutex locked
- The `/* FIXME break ? */` comment confirms this was a known issue
- The new code properly calls `mutex_unlock()` before `goto error`,
  matching the pattern used at line 4107 for `ret < 0`
- Reviewed-by from Qu Wenruo (btrfs developer) and David Sterba (btrfs
  maintainer)
- The commit exists as be6324a809dbd in the tree, dated 2026-02-03
- The affected function `__btrfs_balance()` has existed for many years
  and is present in all stable trees

### Risk vs Benefit

- **Benefit**: Prevents kernel crash (BUG/panic) on a condition that
  could occur with corrupted filesystems
- **Risk**: Near-zero - the condition was previously a crash; now it's a
  graceful error return. No behavioral change for the normal (ret != 0)
  path.

This is a textbook stable candidate: a small, well-reviewed fix that
replaces a kernel crash with proper error handling in a long-standing
code path. BUG() removal in favor of error handling is one of the most
common and safest types of stable backports.

**YES**

 fs/btrfs/volumes.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8a08412f3529a..14d988c3ef4f3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4112,8 +4112,14 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 		 * this shouldn't happen, it means the last relocate
 		 * failed
 		 */
-		if (ret == 0)
-			BUG(); /* FIXME break ? */
+		if (unlikely(ret == 0)) {
+			btrfs_err(fs_info,
+				  "unexpected exact match of CHUNK_ITEM in chunk tree, offset 0x%llx",
+				  key.offset);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
+			ret = -EUCLEAN;
+			goto error;
+		}
 
 		ret = btrfs_previous_item(chunk_root, path, 0,
 					  BTRFS_CHUNK_ITEM_KEY);
-- 
2.51.0


