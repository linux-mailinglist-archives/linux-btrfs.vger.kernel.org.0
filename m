Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709C83D532D
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 08:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhGZFyv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 01:54:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57292 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhGZFyu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 01:54:50 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 382F021F10
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jul 2021 06:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627281314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TmhYwdOcbLFN8H/zXLM7/P7jmXS6J6xrYYVJHXZUAbs=;
        b=t5OEKgl/vYf9taUIRqhnGut6KiJf1/SPuy69znh6EH5fF4TMUbwFjZ5j0VL0BDl8Envgqf
        o10rgCRV/4kJmAajPXnKxphwYH//dzga2QUESqWmMwc+/k1LLLK4zkxydKLJ7B0jpYR6EQ
        H0amko0l8U/IZDDSy5s07a3g/EIFUCk=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6D7641365C
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jul 2021 06:35:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id OFy1C6FX/mCXBQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jul 2021 06:35:13 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v8 02/18] btrfs: fix NULL pointer dereference when reading two compressed extent inside the same page
Date:   Mon, 26 Jul 2021 14:34:51 +0800
Message-Id: <20210726063507.160396-3-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210726063507.160396-1-wqu@suse.com>
References: <20210726063507.160396-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When testing experimental subpage compressed write support, it hits a
NULL pointer dereference inside read path:

 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000018
 pc : __pi_memcmp+0x28/0x1ec
 lr : check_data_csum+0xd0/0x274 [btrfs]
 Call trace:
  __pi_memcmp+0x28/0x1ec
  btrfs_verify_data_csum+0xf4/0x244 [btrfs]
  end_bio_extent_readpage+0x1d0/0x6b0 [btrfs]
  bio_endio+0x15c/0x1dc
  end_workqueue_fn+0x44/0x64 [btrfs]
  btrfs_work_helper+0x74/0x250 [btrfs]
  process_one_work+0x1d4/0x47c
  worker_thread+0x180/0x400
  kthread+0x11c/0x120
  ret_from_fork+0x10/0x30
 Code: 54000261 d100044c d343fd8c f8408403 (f8408424)
 ---[ end trace 9e2c59f33ea40866 ]---

[CAUSE]
When reading two compressed extents inside the same page, like the
following layout, we trigger above crash:

	0	32K	64K
	|-------|\\\\\\\|
	     |	     \- Compressed extent (A)
	     \--------- Compressed extent (B)

For compressed read, we don't need to populate its io_bio->csum, as we
rely on compressed_bio->csum to verify the compressed data, and then
copy the decompressed to inode pages.

Normally btrfs_verify_data_csum() skip such page by checking and
clearing its PageChecked flag

But since that flag is still for the full page, when endio for inode
page range [0, 32K) get executed, it clear PageChecked flag for the
full page.

Then when endio for inode page range [32K, 64K) get executed, since
the page no longer has PageChecked flag, it just continue checking, even
io_bio->csum is NULL.

[FIX]
Thankfully there are only two users of PageChecked flag in btrfs:

- Cow fixup
  Since subpage has its own way to trace page dirty (dirty_bitmap) and
  ordered bit (ordered_bitmap), it should never trigger cow fixup.

- Compressed read
  We can distinguish such read by just checking io_bio->csum.

So just check io_bio->csum before doing the verification to avoid such
NULL pointer dereference.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6089c5e7763c..ffc81ca678e5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3256,6 +3256,20 @@ unsigned int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
 		return 0;
 	}
 
+	/*
+	 * For subpage case, above PageChecked is not safe as it's not subpage
+	 * compatible.
+	 * But for now only cow fixup and compressed read utilize PageChecked
+	 * flag, while in this context we can easily use io_bio->csum to
+	 * determine if we really need to do csum verification.
+	 *
+	 * So for now, just exit if io_bio->csum is NULL, as it means it's
+	 * compressed read, and its compressed data csum has already been
+	 * verified.
+	 */
+	if (io_bio->csum == NULL)
+		return 0;
+
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
 		return 0;
 
-- 
2.32.0

