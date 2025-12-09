Return-Path: <linux-btrfs+bounces-19589-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07530CAE87C
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 01:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1180430F1AF4
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 00:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802CC22A1D4;
	Tue,  9 Dec 2025 00:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQuYrDgl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84A4221290;
	Tue,  9 Dec 2025 00:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239438; cv=none; b=NsjNP6bW+a+mIQcjdg7jCh6tPwL04j2Z6SVtUnnCfge+6kKBsXi+MT03bJR3jViLrCu3/Ek8RBWgJEXo121CSoqH3L6gs2Y1rHtzbdprqehsBWSo5w0MIj9GLPsh06EO5reguRk21QYFbM64WAqrleVa0BxJO9tMo6HT1pMw0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239438; c=relaxed/simple;
	bh=qloJSuOlkJhXHSjx9OWe0XQ5Ampo5gSkOCrrAaabDAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbqBLYTnWYjicW3NGF68GPyFjnYaN3jkM1wC24TRdWD/cIwDaLssu95KoVLGRwyjXj1kxxKB6KLbbBbkhj8GMLZy2AK0SamINxk3yUXpP2lDtSFQhfkOxFVwzeL7kUB49rdQB0FeHMgtboQy0Db0LvAzg6mDofDUzOJ2Qx+VYDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQuYrDgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5E7C4CEF1;
	Tue,  9 Dec 2025 00:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765239438;
	bh=qloJSuOlkJhXHSjx9OWe0XQ5Ampo5gSkOCrrAaabDAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pQuYrDglmdJGCRrcdji0xHIn9+wuccQbC+33rm4dYvYfRnps+NF/NGJ0W31tVoAsu
	 54Pfn/NNBVwTYqUUCKA16hgjBYQJpeYff2RRcd6kxxIgiqt413gBj2eEChfP1QUieg
	 dP6skTDwqWSHlEdqENoxPXbAIQD4iYsCv19MJIlfrfthB1KxUcmCd82xBPlA2pgDz+
	 oL9nB6K0TQuqVrUw5G2lcBWcS9+0OVe3x/g8GiBs3fZX+zvOILuUXyhrpSMq+TYvzo
	 So60zcgtzs2W0SLL88LQxU2UUF5HPWwLYHY/1RWQ6n/1X0ZD+fYwy99Rj7gdvKJJ5k
	 HrFWjLPoOy7jA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Calvin Owens <calvin@wbinvd.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.17] btrfs: use kvcalloc for btrfs_bio::csum allocation
Date: Mon,  8 Dec 2025 19:15:12 -0500
Message-ID: <20251209001610.611575-20-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit cfc7fe2b0f18c54b571b4137156f944ff76057c8 ]

[BUG]
There is a report that memory allocation failed for btrfs_bio::csum
during a large read:

  b2sum: page allocation failure: order:4, mode:0x40c40(GFP_NOFS|__GFP_COMP), nodemask=(null),cpuset=/,mems_allowed=0
  CPU: 0 UID: 0 PID: 416120 Comm: b2sum Tainted: G        W           6.17.0 #1 NONE
  Tainted: [W]=WARN
  Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
  Call trace:
   show_stack+0x18/0x30 (C)
   dump_stack_lvl+0x5c/0x7c
   dump_stack+0x18/0x24
   warn_alloc+0xec/0x184
   __alloc_pages_slowpath.constprop.0+0x21c/0x730
   __alloc_frozen_pages_noprof+0x230/0x260
   ___kmalloc_large_node+0xd4/0xf0
   __kmalloc_noprof+0x1c8/0x260
   btrfs_lookup_bio_sums+0x214/0x278
   btrfs_submit_chunk+0xf0/0x3c0
   btrfs_submit_bbio+0x2c/0x4c
   submit_one_bio+0x50/0xac
   submit_extent_folio+0x13c/0x340
   btrfs_do_readpage+0x4b0/0x7a0
   btrfs_readahead+0x184/0x254
   read_pages+0x58/0x260
   page_cache_ra_unbounded+0x170/0x24c
   page_cache_ra_order+0x360/0x3bc
   page_cache_async_ra+0x1a4/0x1d4
   filemap_readahead.isra.0+0x44/0x74
   filemap_get_pages+0x2b4/0x3b4
   filemap_read+0xc4/0x3bc
   btrfs_file_read_iter+0x70/0x7c
   vfs_read+0x1ec/0x2c0
   ksys_read+0x4c/0xe0
   __arm64_sys_read+0x18/0x24
   el0_svc_common.constprop.0+0x5c/0x130
   do_el0_svc+0x1c/0x30
   el0_svc+0x30/0xa0
   el0t_64_sync_handler+0xa0/0xe4
   el0t_64_sync+0x198/0x19c

[CAUSE]
Btrfs needs to allocate memory for btrfs_bio::csum for large reads, so
that we can later verify the contents of the read.

However nowadays a read bio can easily go beyond BIO_MAX_VECS *
PAGE_SIZE (which is 1M for 4K page sizes), due to the multi-page bvec
that one bvec can have more than one pages, as long as the pages are
physically adjacent.

This will become more common when the large folio support is moved out
of experimental features.

In the above case, a read larger than 4MiB with SHA256 checksum (32
bytes for each 4K block) will be able to trigger a order 4 allocation.

The order 4 is larger than PAGE_ALLOC_COSTLY_ORDER (3), thus without
extra flags such allocation will not retry.

And if the system has very small amount of memory (e.g. RPI4 with low
memory spec) or VMs with small vRAM, or the memory is heavily
fragmented, such allocation will fail and cause the above warning.

[FIX]
Although btrfs is handling the memory allocation failure correctly, we
do not really need the physically contiguous memory just to restore
our checksum.

In fact btrfs_csum_one_bio() is already using kvzalloc() to reduce the
memory pressure.

So follow the step to use kvcalloc() for btrfs_bio::csum.

Reported-by: Calvin Owens <calvin@wbinvd.org>
Link: https://lore.kernel.org/linux-btrfs/20251105180054.511528-1-calvin@wbinvd.org/
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

### SUMMARY

**What the bug is:**
- Large reads on btrfs (>4MiB with SHA256 checksums) require large
  contiguous memory allocations for checksum storage
- Order-4+ allocations fail on memory-constrained or fragmented systems
  without retry (larger than PAGE_ALLOC_COSTLY_ORDER)
- Causes read failures with -ENOMEM on real hardware (Raspberry Pi,
  small VMs, embedded devices)

**What the fix does:**
- Changes from `kmalloc_array()` to `kvcalloc()` which falls back to
  vmalloc when contiguous memory unavailable
- Changes corresponding `kfree()` to `kvfree()` to handle both
  allocation types
- This is already the pattern used by `btrfs_csum_one_bio()` (write
  path) at line 789 of file-item.c

**Why it's safe:**
- Checksum buffers don't require physically contiguous memory (not
  DMA'd)
- `kvcalloc/kvfree` are mature, well-tested kernel APIs
- Pattern already proven in btrfs (10+ existing kvcalloc/kvzalloc uses
  found)
- No functional/behavioral change - only allocation strategy

**Stable criteria assessment:**
| Criterion | Status |
|-----------|--------|
| Obviously correct | ✅ Simple API substitution |
| Fixes real bug | ✅ User-reported allocation failures |
| Small and contained | ✅ 3 lines across 2 files |
| No new features | ✅ No API/behavior changes |
| Tested | ✅ 2 reviews from senior maintainers |

**Risk vs Benefit:**
- **Risk:** Minimal - trivial change, well-tested APIs, consistent with
  existing code
- **Benefit:** High - fixes read failures on memory-constrained systems,
  increasingly important with large folio adoption

**Concerns:**
- No "Cc: stable" or "Fixes:" tags - maintainers didn't explicitly
  request backport
- However, the fix clearly meets all stable criteria

**Verdict:** This is a well-documented, surgical fix for a real memory
allocation failure that affects users on resource-constrained systems.
The change is minimal, uses established APIs, and follows existing btrfs
patterns. The lack of explicit stable tags appears to be an oversight
rather than intentional exclusion.

**YES**

 fs/btrfs/bio.c       | 2 +-
 fs/btrfs/file-item.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 21df48e6c4fa2..5b244a25bc611 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -286,7 +286,7 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 		offset += sectorsize;
 	}
 	if (bbio->csum != bbio->csum_inline)
-		kfree(bbio->csum);
+		kvfree(bbio->csum);
 
 	if (fbio)
 		btrfs_repair_done(fbio);
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index a42e6d54e7cd7..f5fc093436970 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -372,7 +372,7 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 		return -ENOMEM;
 
 	if (nblocks * csum_size > BTRFS_BIO_INLINE_CSUM_SIZE) {
-		bbio->csum = kmalloc_array(nblocks, csum_size, GFP_NOFS);
+		bbio->csum = kvcalloc(nblocks, csum_size, GFP_NOFS);
 		if (!bbio->csum)
 			return -ENOMEM;
 	} else {
@@ -438,7 +438,7 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 		if (count < 0) {
 			ret = count;
 			if (bbio->csum != bbio->csum_inline)
-				kfree(bbio->csum);
+				kvfree(bbio->csum);
 			bbio->csum = NULL;
 			break;
 		}
-- 
2.51.0


