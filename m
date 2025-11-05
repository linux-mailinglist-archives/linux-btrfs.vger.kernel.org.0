Return-Path: <linux-btrfs+bounces-18746-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E11ABC3819C
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 22:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E7E3A8C78
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 21:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8625D2701CC;
	Wed,  5 Nov 2025 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oM4BHVo7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eicf7ujQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082821FDA89
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 21:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379129; cv=none; b=eqScTQ8PTAOOTtTCeIPU7EQwz0J/klvOQnC032f5TwaA7I5Zl+DCJNCzicCERh3JCUUWJGDccJ4YaE6JFGKR67BJRj57DjOcAUhdWCbtJgDq+Gusn4jlNhoAMDqkBKuVuM9nw06oe25ReprWb/mAewWs2Z49gTHhbhGSpmqE+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379129; c=relaxed/simple;
	bh=/OR2uGOjzyAR9r9XodPARAjkUeYTvfFE9AM4f4S4YU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pa6c79BhUtbED3Ha2pCCD5xqSRx4RzzSnX0xwQSndsjuyf0iNC3J/nagMUPLrKZKU1WpObrm5JHf5Lludc285CE7rO1m/lhODF/+pz58n+Yc9suEeoJf9DmRibqaY27XC1vyJs9TgdQv2IcVn+7i1LpFzk/n0TPHZhSxkEzRN4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oM4BHVo7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eicf7ujQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C5AD61F394;
	Wed,  5 Nov 2025 21:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762379124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=L3JiZ249GK0l8bYe/dOMxDCSeT/CWwC3U5i48CL4UNw=;
	b=oM4BHVo7M5aF+Lgt++UCb14JGVd1jmMEJ+O6eIbYTVAy/jF9z3uxy9PoC8/W6tCmjKFMrS
	QGR0CUzxlwGT2/v46BZmoOhZcGwIVRvGoMztl+tw9Ho/DSlyVN099ZpV9QFlvy96tT55xn
	WslXoRoXF8o8UoWD8hBQ6j6DHWy2gXk=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=eicf7ujQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762379123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=L3JiZ249GK0l8bYe/dOMxDCSeT/CWwC3U5i48CL4UNw=;
	b=eicf7ujQfMD5M8qGKBX4/D0I//Hw9eHUK569pVYCjAlziEcAB/ezDpbmNVyjOUGYWPjoDo
	617b4FGlx2suwf1heBViZLUBKLFn9UC84zkGgMI0gk1Y2165QtaXWG9DcvmY6FyImsYDTx
	pUdNil11xZaQads4RzAKWCVvnFI1iPY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62D3E132DD;
	Wed,  5 Nov 2025 21:45:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pm+YA3LFC2madwAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 05 Nov 2025 21:45:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Calvin Owens <calvin@wbinvd.org>
Subject: [PATCH] btrfs: use kvmalloc for btrfs_bio::csum allocation
Date: Thu,  6 Nov 2025 08:15:03 +1030
Message-ID: <22b5e7a4dad73b2c97069f34910a56fcf58d5f6c.1762379016.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C5AD61F394
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

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
do not really need those physically contiguous memory just to restore
our checksum.

In fact btrfs_csum_one_bio() is already using kvzallocated memory to
reduce the memory pressure.

So follow the step to use kvmalloc() for btrfs_bio::csum.

Reported-by: Calvin Owens <calvin@wbinvd.org>
Link: https://lore.kernel.org/linux-btrfs/20251105180054.511528-1-calvin@wbinvd.org/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c       | 2 +-
 fs/btrfs/file-item.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 8af2b68c2d53..bb7ef4c67911 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -293,7 +293,7 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 		offset += sectorsize;
 	}
 	if (bbio->csum != bbio->csum_inline)
-		kfree(bbio->csum);
+		kvfree(bbio->csum);
 
 	if (fbio)
 		btrfs_repair_done(fbio);
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 4b7c40f05e8f..bb8eb43334f6 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -373,7 +373,7 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 		return -ENOMEM;
 
 	if (nblocks * csum_size > BTRFS_BIO_INLINE_CSUM_SIZE) {
-		bbio->csum = kmalloc_array(nblocks, csum_size, GFP_NOFS);
+		bbio->csum = kvmalloc(nblocks * csum_size, GFP_NOFS);
 		if (!bbio->csum)
 			return -ENOMEM;
 	} else {
@@ -439,7 +439,7 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 		if (count < 0) {
 			ret = count;
 			if (bbio->csum != bbio->csum_inline)
-				kfree(bbio->csum);
+				kvfree(bbio->csum);
 			bbio->csum = NULL;
 			break;
 		}
-- 
2.51.2


