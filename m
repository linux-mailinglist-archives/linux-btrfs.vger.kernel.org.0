Return-Path: <linux-btrfs+bounces-21295-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHbIOp4bgWm0EAMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21295-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Feb 2026 22:48:14 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA21D1C8F
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Feb 2026 22:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DEDA3015B90
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Feb 2026 21:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46B7314A65;
	Mon,  2 Feb 2026 21:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKRGplfL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E958229ACD7;
	Mon,  2 Feb 2026 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068838; cv=none; b=YYRi/CNM0LQJC2ETo/DYvB75fTMN88M3xM+v5kHCHn8as1M2J6y8iJFlQkg6l+XKMW2jXMioqgma4f2QFP0e48PEInMtwwucqUJ4ZxHc3ylb2dKoalb/POZwFAZlJ5J4mpSGvCC5wZ++Pw3+doxJ86UxkuVG8OOGsd0YmxaNcSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068838; c=relaxed/simple;
	bh=Uhu+OJ3/Ct+nm1SqSDzlrwEegfw9IFUXsLNNcY+v7es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4jurEk6BiesVhm+CjllmCnVTYSId9yJu7sj+KM/s70oZ1Q/F5t1NK3cNETdgjXDURA0aLiI4DWuA3xbzltmMQb5gUkSNHvFFWjG7SjU19Y6cP6Nr4rRShNsUUcW8TyVQ1SOVx3k9nmlph5JlfGU70ejZBNZiDpQShKwfSYMk88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKRGplfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CB8C116C6;
	Mon,  2 Feb 2026 21:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770068837;
	bh=Uhu+OJ3/Ct+nm1SqSDzlrwEegfw9IFUXsLNNcY+v7es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NKRGplfLh8xfzxssG9u10DG/T+lU2W1PyoUVsIu670b4dRab52dRRbgM68+cRRFH/
	 ZupNPb65rVCw975Wd2FmSradSWtq+ciTY7s3J8mlRUaBby4NOAd6J6UaXaDI9nZpLH
	 66vZuT9yI5jfadNDKHMtqdm1xzXiVJQR7gPKiAUJ4Z3RnST7IpVwlAUnJNckOrZ+GQ
	 F5EUPyWceycghKD3JN2m6bgQbycA/y0tKqohg6PvoqUJGBlQJGBInl8IeaLtDl/yXL
	 xakga/6ooDJuiUKaZhyW/YH/0Ew/9qJOIWNV5JGJKxBGysyo+Ost7H/pefaROJeA5j
	 dmRz7L6DQawuQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+b4a2af3000eaa84d95d5@syzkaller.appspotmail.com,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] btrfs: sync read disk super and set block size
Date: Mon,  2 Feb 2026 16:46:10 -0500
Message-ID: <20260202214643.212290-15-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[qq.com,syzkaller.appspotmail.com,suse.com,kernel.org,fb.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21295-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs,b4a2af3000eaa84d95d5];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 8DA21D1C8F
X-Rspamd-Action: no action

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit 3f29d661e5686f3aa14e6f11537ff5c49846f2e2 ]

When the user performs a btrfs mount, the block device is not set
correctly. The user sets the block size of the block device to 0x4000
by executing the BLKBSZSET command.
Since the block size change also changes the mapping->flags value, this
further affects the result of the mapping_min_folio_order() calculation.

Let's analyze the following two scenarios:

Scenario 1: Without executing the BLKBSZSET command, the block size is
0x1000, and mapping_min_folio_order() returns 0;

Scenario 2: After executing the BLKBSZSET command, the block size is
0x4000, and mapping_min_folio_order() returns 2.

do_read_cache_folio() allocates a folio before the BLKBSZSET command
is executed. This results in the allocated folio having an order value
of 0. Later, after BLKBSZSET is executed, the block size increases to
0x4000, and the mapping_min_folio_order() calculation result becomes 2.

This leads to two undesirable consequences:

1. filemap_add_folio() triggers a VM_BUG_ON_FOLIO(folio_order(folio) <
mapping_min_folio_order(mapping)) assertion.

2. The syzbot report [1] shows a null pointer dereference in
create_empty_buffers() due to a buffer head allocation failure.

Synchronization should be established based on the inode between the
BLKBSZSET command and read cache page to prevent inconsistencies in
block size or mapping flags before and after folio allocation.

[1]
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
RIP: 0010:create_empty_buffers+0x4d/0x480 fs/buffer.c:1694
Call Trace:
 folio_create_buffers+0x109/0x150 fs/buffer.c:1802
 block_read_full_folio+0x14c/0x850 fs/buffer.c:2403
 filemap_read_folio+0xc8/0x2a0 mm/filemap.c:2496
 do_read_cache_folio+0x266/0x5c0 mm/filemap.c:4096
 do_read_cache_page mm/filemap.c:4162 [inline]
 read_cache_page_gfp+0x29/0x120 mm/filemap.c:4195
 btrfs_read_disk_super+0x192/0x500 fs/btrfs/volumes.c:1367

Reported-by: syzbot+b4a2af3000eaa84d95d5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b4a2af3000eaa84d95d5
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

So this commit is going into v6.19. Let me now analyze the complete
picture.

## Analysis Summary

### 1. COMMIT MESSAGE ANALYSIS

**Subject:** "btrfs: sync read disk super and set block size"

**Key indicators:**
- **Reported-by: syzbot**: Indicates a real bug found by fuzzing
- **Closes: syzkaller bug link**: Confirms this is fixing a reported
  issue
- **Reviewed-by: Filipe Manana**: Core btrfs maintainer reviewed and
  approved
- **Signed-off-by: David Sterba**: Btrfs maintainer signed off

The commit message describes a race condition that leads to:
1. `VM_BUG_ON_FOLIO` assertion failure
2. Null pointer dereference in `create_empty_buffers()`

### 2. CODE CHANGE ANALYSIS

The fix is **extremely simple** - just 2 lines added:
```c
+       filemap_invalidate_lock(mapping);
        page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT,
GFP_NOFS);
+       filemap_invalidate_unlock(mapping);
```

**Root cause:** A race between:
1. `btrfs_read_disk_super()` allocating a folio via
   `read_cache_page_gfp()`
2. User space calling `BLKBSZSET` ioctl to change block size

When the block size changes mid-operation, the folio order requirements
change, causing either a BUG_ON or null pointer dereference.

**Why the fix works:** The `filemap_invalidate_lock()` provides
synchronization between the page cache reader and the block size setter
(in `set_blocksize()`), preventing the race.

### 3. CLASSIFICATION

- **Bug type:** Race condition leading to kernel crash (null pointer
  deref) or BUG_ON
- **Severity:** High - causes kernel panic/crash
- **Category:** Synchronization fix

### 4. SCOPE AND RISK ASSESSMENT

- **Lines changed:** 2 additions only
- **Files touched:** 1 (fs/btrfs/volumes.c)
- **Complexity:** Very low - just lock/unlock pair around existing call
- **Risk:** LOW - the lock is well-understood and used elsewhere for
  exactly this purpose

### 5. USER IMPACT

- **Who is affected:** Any btrfs user where concurrent block device
  operations occur
- **Triggering scenario:** User space modifying block device size while
  btrfs is mounting/reading superblock
- **Severity of impact:** Kernel crash (HIGH)

### 6. STABILITY INDICATORS

- **Reviewed-by:** Filipe Manana (senior btrfs developer at SUSE)
- **Multiple sign-offs:** Through the btrfs maintainer chain
- **Syzbot reported:** Reproducible issue

### 7. CRITICAL DEPENDENCY CHECK

**THIS IS THE KEY ISSUE:** The fix relies on `set_blocksize()` also
taking `filemap_invalidate_lock()`. This was added by commit
`c0e473a0d2264` ("block: fix race between set_blocksize and read paths")
which is **only in kernel 6.15+**.

Without that block layer fix:
- On kernels < 6.15: `set_blocksize()` does NOT take
  `filemap_invalidate_lock`, so this btrfs fix would NOT provide proper
  synchronization
- The btrfs fix by itself would be ineffective in preventing the race

### Risk vs Benefit Analysis

**Benefits:**
- Fixes real crash reported by syzbot
- Very small, surgical fix (2 lines)
- Well-reviewed by btrfs maintainers
- Follows established synchronization pattern

**Risks/Concerns:**
- **CRITICAL DEPENDENCY**: Requires `c0e473a0d2264` to be present for
  the synchronization to work
- Without the block layer fix, this btrfs fix is essentially a no-op
  (won't actually synchronize)
- The block layer fix is only in 6.15+, so backporting this btrfs fix to
  6.14 or earlier would be pointless without also backporting the block
  layer changes

### Conclusion

This commit fixes a real kernel crash (null pointer dereference) in
btrfs that was reported by syzbot. The fix itself is minimal and correct
- it adds proper locking around the `read_cache_page_gfp()` call to
synchronize with block size changes.

However, there is a **critical dependency issue**: This fix only
provides effective synchronization when paired with commit
`c0e473a0d2264` ("block: fix race between set_blocksize and read paths")
which adds the corresponding lock acquisition in `set_blocksize()`. That
commit is only in kernel 6.15+.

For stable trees **6.15.y and later**: This is a clear YES - fixes a
real crash with minimal risk.

For stable trees **6.14 and earlier**: The fix would be ineffective
without also backporting the block layer changes, which are more
invasive.

Given that the question is about backporting in general and this commit
would only be effective in 6.15+ (where the block layer infrastructure
exists), and the fix is correct, small, and addresses a real crash, the
answer depends on the target kernel. For the current stable (6.15+),
this should be backported.

**YES**

 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 48e717c105c35..8e7dcb12af4c4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1365,7 +1365,9 @@ struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
 				      (bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
 	}
 
+	filemap_invalidate_lock(mapping);
 	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
+	filemap_invalidate_unlock(mapping);
 	if (IS_ERR(page))
 		return ERR_CAST(page);
 
-- 
2.51.0


