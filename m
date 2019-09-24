Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5754CBD3CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 22:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbfIXUut (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 16:50:49 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41045 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfIXUus (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 16:50:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id x4so3884300qtq.8
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 13:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pYG9tHVTBzRT0V80MeUINJkZehbuS8dbRF42/XmhSDo=;
        b=EwELSTZH/+3EPj1e/N+MwkV47P2Y9vRzc82DZLkWaldflLBIaqEgR0mZCr4SNy0JJZ
         B3apvSId6UOZMjBrwVOyzQdDLUq6LGl/vT2PjG5gYb/eeitmwGQtrfVG83C5q6+Pj6k0
         mdObrYzSBKSKTrB8bqLIe9etvONuiD0DvTtwIgBbEBs3+KgqAMz9DKirnpeW4C0SY3cb
         9wOaKKHcsEcrMY8pR2CfbjjVNDbgOpD9tmmET5HiG50+comVLOPI2ypFq+sNtm4KnvJQ
         THKgp29TPrxjrP/tdFK+kc8OBOLto8ihNW4vSXaYMiDXpdXdRHQkjNad/JNMnf10bYt+
         PyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pYG9tHVTBzRT0V80MeUINJkZehbuS8dbRF42/XmhSDo=;
        b=orG8bB9kE93imbmi8p+xcyGgqS3NwLrXy9iq3m64kKZt4w2mgHaMDhYW35MSDEhrCq
         JHOR6DD5bigFAYbEvoJ4utmjPB8SPTdKXxDWE+UYd26csGYFmy2oWK+j+3iQaLMf6stv
         Niq/W+RuwDyzpZPTc5MO7nan24O7V2pimEy49Sv9VewN/MqW3YNNRqytOhaPSlEFG8EW
         m6R/NMI2dwBmDQGu2QgZo9s14rm8rSQEyfTwUqQbiV+yaKzY/rxv1aQPOMiHF7z1UCm5
         ZDCV9h77ot3XlqYxyE+US4e6UiKR0p9aTnwWWb6OL+MDqUxBa6DBR2dzV4Zs4GcVbpFs
         4dJQ==
X-Gm-Message-State: APjAAAXd5PotPJb9dcVg6oUL4JCitxK/U72YGl5QYpdBsm4lMmMnBlsB
        e/1xs7Z14UgpqCpwQ9GTlia3Vgm8WjxR4Q==
X-Google-Smtp-Source: APXvYqz6v99GwpeuLYPugoAaDDyvpKzwJhKgdTl/74R9WRsFxhRrY0ii6ssbB7Eo3r7bcl9PrAINAA==
X-Received: by 2002:aed:3103:: with SMTP id 3mr4929495qtg.76.1569358246146;
        Tue, 24 Sep 2019 13:50:46 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u39sm1831390qtj.34.2019.09.24.13.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 13:50:45 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: check page->mapping when loading free space cache
Date:   Tue, 24 Sep 2019 16:50:43 -0400
Message-Id: <20190924205044.31830-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While testing 5.2 we ran into the following panic

[52238.017028] BUG: kernel NULL pointer dereference, address: 0000000000000001
[52238.105608] RIP: 0010:drop_buffers+0x3d/0x150
[52238.304051] Call Trace:
[52238.308958]  try_to_free_buffers+0x15b/0x1b0
[52238.317503]  shrink_page_list+0x1164/0x1780
[52238.325877]  shrink_inactive_list+0x18f/0x3b0
[52238.334596]  shrink_node_memcg+0x23e/0x7d0
[52238.342790]  ? do_shrink_slab+0x4f/0x290
[52238.350648]  shrink_node+0xce/0x4a0
[52238.357628]  balance_pgdat+0x2c7/0x510
[52238.365135]  kswapd+0x216/0x3e0
[52238.371425]  ? wait_woken+0x80/0x80
[52238.378412]  ? balance_pgdat+0x510/0x510
[52238.386265]  kthread+0x111/0x130
[52238.392727]  ? kthread_create_on_node+0x60/0x60
[52238.401782]  ret_from_fork+0x1f/0x30

The page we were trying to drop had a page->private, but had no
page->mapping and so called drop_buffers, assuming that we had a
buffer_head on the page, and then panic'ed trying to deref 1, which is
our page->private for data pages.

This is happening because we're truncating the free space cache while
we're trying to load the free space cache.  This isn't supposed to
happen, and I'll fix that in a followup patch.  However we still
shouldn't allow those sort of mistakes to result in messing with pages
that do not belong to us.  So add the page->mapping check to verify that
we still own this page after dropping and re-acquiring the page lock.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/free-space-cache.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index d54dcd0ab230..d86ada9c3c54 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -385,6 +385,12 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, struct inode *inode
 		if (uptodate && !PageUptodate(page)) {
 			btrfs_readpage(NULL, page);
 			lock_page(page);
+			if (page->mapping != inode->i_mapping) {
+				btrfs_err(BTRFS_I(inode)->root->fs_info,
+					  "free space cache page truncated");
+				io_ctl_drop_pages(io_ctl);
+				return -EIO;
+			}
 			if (!PageUptodate(page)) {
 				btrfs_err(BTRFS_I(inode)->root->fs_info,
 					   "error reading free space cache");
-- 
2.21.0

