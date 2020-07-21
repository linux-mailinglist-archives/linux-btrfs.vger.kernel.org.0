Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92011228261
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgGUOil (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgGUOik (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:38:40 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC42C061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:38:40 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id s23so3160485qtq.12
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kh107cAs/CtccuvjeKRU3VUkJ27fza/NRvNZExW1fpI=;
        b=CQ6mDLREnMw/ZLlcUPex2ifSuSLjCTubz7gQCwy4mLw6vbmVGjOWF8Hc7rddW9cKx1
         baumhr4M34kiyT9AmhG58zBCXdEnNt7KnbBFWCNgj2WUEmG+z9gRwlTDuV7l6OqVixjH
         k+r0F6xLwFvpTgAoNFBbyYbkFGU9dbL4bbGi8iFezX7JWkWK22vEpuOHwsy8Gs+eL5Jh
         ZolfHUhZlp9e5xuoCq5xJaGMvE4tZ7bWrQlUG963QYuH0JEM4oajHAtmD/4WXWMhk8HT
         KGD1H0jp+HyeXVUAA1nonFryhojbjJ/49z7CSHtFg9ex5LU9LxEUXww7W7aQB7grTXVS
         6eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kh107cAs/CtccuvjeKRU3VUkJ27fza/NRvNZExW1fpI=;
        b=oFvjSYKuR2sXprH4CZ0DFZEd0QS0IbmwIc5TXXrmnWAKaQvDuDJ6okKGbbzdad0+wT
         wAdXfJMIJFUiTWtjsqiPXUp5tKfSELjIikPw9OQ+MYNzs3PB2AmQpfceuRV1+vipBsBT
         m9L1Veb4xszsx6fZyCeuf5J3C9fKkw+2sWNz4wthO7W7x98oQCwuLzchUWsvmNrJ8Eq3
         WsqbiYKIaDEh4si3Ojd70wn7y0dXiMUAGa7ag4dAqFfaPiBXvm7D2aMB8PBQkJ3sS+HB
         uw1bHji/itm7oOB11EKbfet+VW5EeDfnIY4MmkErYwMmXr/Ih7Ex5xWO72zFcYiJmVVe
         qQqg==
X-Gm-Message-State: AOAM531y5KXe8dzy2mUhpsBM95yHCRazV6ziWPAuhJ6C+8aF071G920s
        QO3kQJ7aWvXTtPPKiHVFjrt2reHjdWXfVg==
X-Google-Smtp-Source: ABdhPJwxm4SHdG83vevmEpHjae4SoZbur5ijyhO2EN1JIm9wnMeaTx5CVxnuKrJ5/pyTf5tqisxWOg==
X-Received: by 2002:ac8:3765:: with SMTP id p34mr29977278qtb.251.1595342319229;
        Tue, 21 Jul 2020 07:38:39 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x23sm2455363qki.6.2020.07.21.07.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:38:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Eric Sandeen <esandeen@redhat.com>
Subject: [PATCH][v2] btrfs: return -EROFS for BTRFS_FS_STATE_ERROR cases
Date:   Tue, 21 Jul 2020 10:38:37 -0400
Message-Id: <20200721143837.3535-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Eric reported seeing this message while running generic/475

BTRFS: error (device dm-3) in btrfs_sync_log:3084: errno=-117 Filesystem corrupted

This ret came from btrfs_write_marked_extents().  If we get an aborted
transaction via an -EIO somewhere, we'll see it in
btree_write_cache_pages() and return -EUCLEAN, which we spit out as
"Filesystem corrupted".  Except we shouldn't be returning -EUCLEAN here,
we need to be returning -EROFS.  -EUCLEAN is reserved for actual
corruption, not IO errors.

We are inconsistent about our handling of BTRFS_FS_STATE_ERROR
elsewhere, but we want to use -EROFS for this particular case.  The
original transaction abort has the real error code for why we ended up
with an aborted transaction, all subsequent actions just need to return
-EROFS because they may not have a trans handle and have no idea about
the original cause of the abort.

Reported-by: Eric Sandeen <esandeen@redhat.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- Fixed this to be -EROFS, fixed other handlers of BTRFS_FS_STATE_ERROR.

 fs/btrfs/extent_io.c   | 2 +-
 fs/btrfs/scrub.c       | 2 +-
 fs/btrfs/transaction.c | 5 ++++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 73c9c59cd535..3fbc37692592 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4119,7 +4119,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 	if (!test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
 		ret = flush_write_bio(&epd);
 	} else {
-		ret = -EUCLEAN;
+		ret = -EROFS;
 		end_write_bio(&epd, ret);
 	}
 	return ret;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d935ac06323f..5a6cb9db512e 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3691,7 +3691,7 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 
 	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
-		return -EIO;
+		return -EROFS;
 
 	/* Seed devices of a new filesystem has their own generation. */
 	if (scrub_dev->fs_devices != fs_info->fs_devices)
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index efafc286323c..20c6ac1a5de7 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -937,7 +937,10 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 	if (TRANS_ABORTED(trans) ||
 	    test_bit(BTRFS_FS_STATE_ERROR, &info->fs_state)) {
 		wake_up_process(info->transaction_kthread);
-		err = -EIO;
+		if (TRANS_ABORTED(trans))
+			err = trans->aborted;
+		else
+			err = -EROFS;
 	}
 
 	kmem_cache_free(btrfs_trans_handle_cachep, trans);
-- 
2.24.1

