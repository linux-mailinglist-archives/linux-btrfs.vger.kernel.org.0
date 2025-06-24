Return-Path: <linux-btrfs+bounces-14898-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9253DAE5D03
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 08:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC68B1B661E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 06:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CBF2459D0;
	Tue, 24 Jun 2025 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n3Q8vY0g";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n3Q8vY0g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1A324C07A
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750747314; cv=none; b=UXE1NXm8azoGdq1CeXeUTqSeFZnvehZjZX6LEGjM8bUzUuDSFwrvbyp1szye/R14Z38atKWnG1elBTLoLR4qnbZgcBCF55lkLlAR7ebG7TO2C1s9onMQPYe2IpJdfIGy8F6NACpkX193vRtwCJZ2mwK4inNFz7OUjv7q579Hct4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750747314; c=relaxed/simple;
	bh=Chdq7Qe2LUKF6ulFiUNW+VgvbU/dRt0ZjcFajH642W4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a3eRRa8YohKA8LVPoAQO8lBHe2MMJ/svaEKnlpcQDMRg1o56TD5X4ahlTIoTJihboWw2QHXzGHyey0E51Hx0Gk1pGbw7aOWFvNjWr+SPDYRyjAVGNEVbg5eg3RdfvfS+CRcJFLXZz394CkUQvjCZoLNGY6HQmxuUnsOpNRJG5LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n3Q8vY0g; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n3Q8vY0g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B351E1F391;
	Tue, 24 Jun 2025 06:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750746948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fl/kmgzXAn3xTz47VfWKKkkk11s0Iesd3ZwYwXhglqY=;
	b=n3Q8vY0gGZA9qYbNAAqieZxOid1jaNCGlqeesorDUu7ae+V4B9qMWOBdGsDISRKCo5BJsA
	1nwLAzKiMoxcOZQPMhEmE/3NvOg1frwFwWchOswiC2x303BdCvn3mIGSN5NFN7YokgzGq3
	39QDWsTZ7Zx0O/etA9MQUiiIzve29/4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750746948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fl/kmgzXAn3xTz47VfWKKkkk11s0Iesd3ZwYwXhglqY=;
	b=n3Q8vY0gGZA9qYbNAAqieZxOid1jaNCGlqeesorDUu7ae+V4B9qMWOBdGsDISRKCo5BJsA
	1nwLAzKiMoxcOZQPMhEmE/3NvOg1frwFwWchOswiC2x303BdCvn3mIGSN5NFN7YokgzGq3
	39QDWsTZ7Zx0O/etA9MQUiiIzve29/4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9ACA813A24;
	Tue, 24 Jun 2025 06:35:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nDCCFUNHWmizZgAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 24 Jun 2025 06:35:47 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH] btrfs: fix a stupid bug masked by CONFIG_BTRFS_DEBUG
Date: Tue, 24 Jun 2025 16:05:29 +0930
Message-ID: <9b16023e2cb31b509405dd5525bbd5d19a2f384b.1750746917.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

[BUG]
Naohiro reported a weird bug that with CONFIG_BTRFS_DEBUG=n and
CONFIG_BTRFS_EXPERIMENTAL=y, test case btrfs/005 will crash with the
following call trace:

 page: refcount:5 mapcount:0 mapping:00000000a5ae9eff index:0x1c pfn:0x113658
 head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
 memcg:ffff888116d31280
 aops:btrfs_aops [btrfs] ino:101 dentry name(?):"tmp_file"
 flags: 0x2ffff800000406c(referenced|uptodate|lru|private|head|node=0|zone=2|lastcpupid=0x1ffff)
 page dumped because: VM_BUG_ON_FOLIO(!folio_test_locked(folio))
 ------------[ cut here ]------------
 kernel BUG at mm/filemap.c:1498!
 Oops: invalid opcode: 0000 [#1] SMP NOPTI
 CPU: 9 UID: 0 PID: 264 Comm: kworker/u50:3 Not tainted 6.16.0-rc1-custom+ #261 PREEMPT(full)
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
 Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
 RIP: 0010:folio_unlock+0x42/0x50
 Code: 37 01 78 05 c3 cc cc cc cc 31 f6 e9 38 fb ff ff 48 c7 c6 58 e6 45 82 e8 4c 69 05 00 0f 0b 48 c7 c6 b8 f3 47 82 e8 3e 69 05 00 <0f> 0b 90 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
 Call Trace:
  <TASK>
  end_bbio_data_read+0x10d/0x4c0 [btrfs]
  ? end_bbio_compressed_read+0x49/0x140 [btrfs]
  end_bbio_compressed_read+0x56/0x140 [btrfs]
  process_one_work+0x1ff/0x570
  worker_thread+0x1cb/0x3a0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xff/0x260
  ? ret_from_fork+0x1b/0x1b0
  ? lock_release+0xdd/0x2e0
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x161/0x1b0
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>

[CAUSE]
CONFIG_BTRFS_EXPERIMENTAL=y enables the large data folio support for
btrfs, as can be seen from the "order: 2" output.

On the other hand function btrfs_is_subpage() checks if we need to go
through the subpage routine.

Meanwhile CONFIG_BTRFS_DEBUG enables another debug-only feature, 2k
block size, making BTRFS_MIN_BLOCKSIZE to be 2K.

And at compile time if page size is larger than the minimal block size,
btrfs_is_subpage() will do the proper check.
But if page size is no larger than minimal block size,
btrfs_is_subpage() is hard coded to return false as we believe there is
no need for subpage support.

But CONFIG_BTRFS_EXPERIMENTAL enables large data folio support, and
without CONFIG_BTRFS_DEBUG, btrfs_is_subpage() will always return false,
causing bugs when hitting a large folio.

[FIX]
Remove the PAGE_SIZE > BTRFS_MIN_BLOCKSIZE checks completely.

This fix will be folded into the large data folio enablement patch.

Reported-by: Naohiro Aota <Naohiro.Aota@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 7889a97365f0..453857f6c14d 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -93,7 +93,6 @@ enum btrfs_folio_type {
 	BTRFS_SUBPAGE_DATA,
 };
 
-#if PAGE_SIZE > BTRFS_MIN_BLOCKSIZE
 /*
  * Subpage support for metadata is more complex, as we can have dummy extent
  * buffers, where folios have no mapping to determine the owning inode.
@@ -114,19 +113,6 @@ static inline bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info,
 		ASSERT(is_data_inode(BTRFS_I(folio->mapping->host)));
 	return fs_info->sectorsize < folio_size(folio);
 }
-#else
-static inline bool btrfs_meta_is_subpage(const struct btrfs_fs_info *fs_info)
-{
-	return false;
-}
-static inline bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info,
-				    struct folio *folio)
-{
-	if (folio->mapping && folio->mapping->host)
-		ASSERT(is_data_inode(BTRFS_I(folio->mapping->host)));
-	return false;
-}
-#endif
 
 int btrfs_attach_folio_state(const struct btrfs_fs_info *fs_info,
 			     struct folio *folio, enum btrfs_folio_type type);
-- 
2.49.0


