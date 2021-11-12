Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E629E44E12E
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 05:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhKLEuk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 23:50:40 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56912 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhKLEuk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 23:50:40 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2C96C1FD64;
        Fri, 12 Nov 2021 04:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636692469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tXIv8H0kionnx7n09wWgxh6YKq9zHK9C8+FFXlPPMaM=;
        b=D3cAsmiejhmIqoosKUoho/tcAGYih9tdka1HfpeC9vVidPVKvRQCdjWmEhPvZ1fL+W5+Iu
        nxSSUJc+Pc2/ZJVpxPAmP6xKYGt7GlW97ZhoJY1CPuJVKMw2VB3S7MYLnF2CXCtCgbMeLe
        uD3/hQnt0SlnhgNUHwjLgnhmEdk6V2M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28D5913E3D;
        Fri, 12 Nov 2021 04:47:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eFFaN/PxjWG4PwAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 12 Nov 2021 04:47:47 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Omar Sandoval <osandov@fb.com>
Subject: [PATCH v2] btrfs: fix a out-of-boundary access for copy_compressed_data_to_page()
Date:   Fri, 12 Nov 2021 12:47:30 +0800
Message-Id: <20211112044730.25161-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
The following script can cause btrfs to crash:

 mount -o compress-force=lzo $DEV /mnt
 dd if=/dev/urandom of=/mnt/foo bs=4k count=1
 sync

The calltrace looks like this:

 general protection fault, probably for non-canonical address 0xe04b37fccce3b000: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 5 PID: 164 Comm: kworker/u20:3 Not tainted 5.15.0-rc7-custom+ #4
 Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
 RIP: 0010:__memcpy+0x12/0x20
 Call Trace:
  lzo_compress_pages+0x236/0x540 [btrfs]
  btrfs_compress_pages+0xaa/0xf0 [btrfs]
  compress_file_range+0x431/0x8e0 [btrfs]
  async_cow_start+0x12/0x30 [btrfs]
  btrfs_work_helper+0xf6/0x3e0 [btrfs]
  process_one_work+0x294/0x5d0
  worker_thread+0x55/0x3c0
  kthread+0x140/0x170
  ret_from_fork+0x22/0x30
 ---[ end trace 63c3c0f131e61982 ]---

[CAUSE]
In lzo_compress_pages(), parameter @out_pages is not only an output
parameter (for the number of compressed pages), but also an input
parameter, as the upper limit of compressed pages we can utilize.

In commit d4088803f511 ("btrfs: subpage: make lzo_compress_pages()
compatible"), the refactor doesn't take @out_pages as an input, thus
completely ignoring the limit.

And for compress-force case, we could hit incompressible data that
compressed size would go beyond the page limit, and cause above crash.

[FIX]
Save @out_pages as @max_nr_page, and pass it to lzo_compress_pages(),
and check if we're beyond the limit before accessing the pages.

Reported-by: Omar Sandoval <osandov@fb.com>
Fixes: d4088803f511 ("btrfs: subpage: make lzo_compress_pages() compatible")
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Omar Sandoval <osandov@fb.com>

---
Changelog:
v2:
- also make @max_nr_page parameter of copy_compressed_data_to_page() const
---
 fs/btrfs/lzo.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 00cffc183ec0..6912def2c1f8 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -125,6 +125,7 @@ static inline size_t read_compress_length(const char *buf)
 static int copy_compressed_data_to_page(char *compressed_data,
 					size_t compressed_size,
 					struct page **out_pages,
+					const unsigned long max_nr_page,
 					u32 *cur_out,
 					const u32 sectorsize)
 {
@@ -132,6 +133,9 @@ static int copy_compressed_data_to_page(char *compressed_data,
 	u32 orig_out;
 	struct page *cur_page;
 
+	if ((*cur_out / PAGE_SIZE) >= max_nr_page)
+		return -E2BIG;
+
 	/*
 	 * We never allow a segment header crossing sector boundary, previous
 	 * run should ensure we have enough space left inside the sector.
@@ -158,6 +162,9 @@ static int copy_compressed_data_to_page(char *compressed_data,
 		u32 copy_len = min_t(u32, sectorsize - *cur_out % sectorsize,
 				     orig_out + compressed_size - *cur_out);
 
+		if ((*cur_out / PAGE_SIZE) >= max_nr_page)
+			return -E2BIG;
+
 		cur_page = out_pages[*cur_out / PAGE_SIZE];
 		/* Allocate a new page */
 		if (!cur_page) {
@@ -195,6 +202,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	const u32 sectorsize = btrfs_sb(mapping->host->i_sb)->sectorsize;
 	struct page *page_in = NULL;
+	const unsigned long max_nr_page = *out_pages;
 	int ret = 0;
 	/* Points to the file offset of input data */
 	u64 cur_in = start;
@@ -202,6 +210,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 	u32 cur_out = 0;
 	u32 len = *total_out;
 
+	ASSERT(max_nr_page > 0);
 	*out_pages = 0;
 	*total_out = 0;
 	*total_in = 0;
@@ -237,7 +246,8 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 		}
 
 		ret = copy_compressed_data_to_page(workspace->cbuf, out_len,
-						   pages, &cur_out, sectorsize);
+						   pages, max_nr_page,
+						   &cur_out, sectorsize);
 		if (ret < 0)
 			goto out;
 
-- 
2.33.1

