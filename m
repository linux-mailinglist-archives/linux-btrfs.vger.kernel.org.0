Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5252B8821
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 00:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgKRXGx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 18:06:53 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:41881 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726588AbgKRXGx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 18:06:53 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id D04ECC14;
        Wed, 18 Nov 2020 18:07:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 18 Nov 2020 18:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm2; bh=MzggpLdY8RnPEsI+gBYMirfU1Z
        u3DTsymQjSMD4EBZ8=; b=WmMzrg+sDBP3P1j3pUj0P6SYKLhRFj7BUSr8ankf/q
        uDmxX1+bez3wKvzOOoi2qqURfpN1eEVFUH5XWfjE1eLqndfMYiagPrVC8DQBp20t
        Vrwppz3SwROW0yYSjb+RRejmwKU9QZyohDvSEM9srQCpUyubvY2KDgtcOi4qeu4o
        fz2bSgRWuphk8bxRfNYxPdPee+fWHkt3Oj+H+b7DLmn3l1H/Pai7pUvHu2xhqvzd
        Z4GojqXQ5M/+Lz+KjkO9RUjdUcDNXcOwhpmQ4baMFUMPh5AF6l1gIgCh7KWYPz8E
        XI1/CMLzQ/aaXEVZfsmtOpQ2GZcN/PYz1DZfzTACQYqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=MzggpLdY8RnPEsI+gBYMirfU1Zu3DTsymQjSMD4EBZ8=; b=Grmx5KY9
        svVuIlPohVbZd7jy5jTi6RX9j7uOUsyLrNZnCu/SlsCrnCQ/wBPCbNWddudiZQJg
        5Ft9TTUK/MgDOzGhHOWrAc3iOyqR8NUyRmNqCtCM9ukQeUaRZsHjEkuEpExgntrg
        vyY/UPiGhlLbSRv3rVbWqLOMpHasI+N8t5oaluahBc5SmXzHiSbhEphvVzHl+gNW
        HsyXoiRXgjG6OCgtP0+d1o52mHx8ch6c3Na1d+bkubhLkWXCJZlfCU4TxG481/Xu
        x27UIEXnMbSZtu/c7VzdryzOuEmO0/zs9xb816cHUd8Fj1R4AcoTHhfh3tKmTSmI
        LPfNO03Po2xhmg==
X-ME-Sender: <xms:Ham1Xy9x4gZRFUf4QZ88-Msk0YpOb2yOezkgiI3gi7KFBUg52bVOTA>
    <xme:Ham1XyuHZMGKKRXDRAxqJPZ8xZWZLNgZlNEJbJ9J2sX4CewOljVJDWiROHqb424BG
    8812jf6ghNJT-cOql0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefiedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrfeenucevlhhu
    shhtvghrufhiiigvpeejnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:Ham1X4CHQoYKVCbuc749l7u12vXhuaZ3xFsT0jRIJ8U_dVso7ZnbcA>
    <xmx:Ham1X6cd9B60fmLkKCXITJ3TuGGEfXs1zfqmx-eBMLHD10y2Gb1iMg>
    <xmx:Ham1X3NuzOTCRV4iOWn8j31ncAaCLKsikjailiM8OES1OGSPks86PA>
    <xmx:Ham1X2ZU5Avc-hVKOB18Mz-PpGO8LZy7SegLXpf6T00isUEptn9rPQ>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 039463280064;
        Wed, 18 Nov 2020 18:07:09 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 09/12] btrfs: warn when remount will not change the free space tree
Date:   Wed, 18 Nov 2020 15:06:24 -0800
Message-Id: <582a98333502e807faa9a899082e6e960e4cc0f3.1605736355.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1605736355.git.boris@bur.io>
References: <cover.1605736355.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If the remount is ro->ro, rw->ro, or rw->rw, we will not create or
clear the free space tree. This can be surprising, so print a warning
to dmesg to make the failure more visible. It is also important to
ensure that the space cache options (SPACE_CACHE, FREE_SPACE_TREE) are
consistent, so ensure those are set to properly match the current on
disk state (which won't be changing).

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/super.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index e2a186d254c5..5e88ae69e2e6 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1912,6 +1912,24 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	btrfs_resize_thread_pool(fs_info,
 		fs_info->thread_pool_size, old_thread_pool_size);
 
+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE) !=
+	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
+	    ((!sb_rdonly(sb) || *flags & SB_RDONLY))) {
+		btrfs_warn(fs_info,
+	   "remount supports changing free space tree only from ro to rw");
+		/*
+		 * Make sure free space cache options match the state on disk
+		 */
+		if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
+			btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+			btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
+		}
+		if (btrfs_free_space_cache_v1_active(fs_info)) {
+			btrfs_clear_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+			btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
+		}
+	}
+
 	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
 		goto out;
 
-- 
2.24.1

