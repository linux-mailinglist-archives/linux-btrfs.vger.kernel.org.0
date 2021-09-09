Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D594056BE
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Sep 2021 15:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357037AbhIINXI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Sep 2021 09:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355301AbhIINNS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Sep 2021 09:13:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BF62632D4;
        Thu,  9 Sep 2021 12:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631188910;
        bh=NylKry5ajKWG5iLODt6TsNeCn2yOTA2VkOdwQBpTYbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jSynjVLKvMatNKq9h4rx9oM7dVp4ygiAuq1Jhf1mn2btMdnt5FZ1NU14TPFKpgIYb
         JS95dRbvVIuiCgeHfZoFHZjVzHyaE8HgAtULdmGga7lUGTsGCQhow/928mp6d97qvx
         7v04Usvts/g7gnrdTvkBtNQzCElwMfu2+EvjatcAzSdBr/PumZIkz8zWvdHl1L+oD4
         zPvJ33PslL3x9J9LMkqtI4GfBFnzXmSfGRAdLacoouUUSZ4lFtu+M4fHgURij1Wcp7
         WpTvsPnN7x0lySTwZZpmnW3qA7sMRCZ9PSgs9+lniH6mgljq0Asn4FwVza+FZEakjy
         JAvUsT1J6HU8Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 27/35] btrfs: subpage: check if there are compressed extents inside one page
Date:   Thu,  9 Sep 2021 08:01:08 -0400
Message-Id: <20210909120116.150912-27-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909120116.150912-1-sashal@kernel.org>
References: <20210909120116.150912-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 3670e6451bc9c39ab3a46f1da19360219e4319f3 ]

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
page range [0, 32K) gets executed, it clears PageChecked flag for the
full page.

Then when endio for inode page range [32K, 64K) gets executed, since the
page no longer has PageChecked flag, it just continues checking, even
though io_bio->csum is NULL.

[FIX]
Thankfully there are only two users of PageChecked bit:

- Cow fixup
  Since subpage has its own way to trace page dirty (dirty_bitmap) and
  ordered bit (ordered_bitmap), it should never trigger cow fixup.

- Compressed read
  We can distinguish such read by just checking io_bio->csum.

So just check io_bio->csum before doing the verification to avoid such
NULL pointer dereference.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index da4ad006739d..8a2dc96b62b4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3146,6 +3146,20 @@ static int btrfs_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
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
2.30.2

