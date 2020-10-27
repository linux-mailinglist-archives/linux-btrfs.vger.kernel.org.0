Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A423129CAF1
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 22:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832066AbgJ0VIh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 17:08:37 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57579 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1832061AbgJ0VIh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 17:08:37 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 278675C00CC;
        Tue, 27 Oct 2020 17:08:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 27 Oct 2020 17:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=pbEEpRRMeVfr/
        JLu2Y9mitizi6bfqPhgMj7PIg4UQss=; b=NUKRwpUs0caKSSDrWa1pA4of3VRBq
        I/dXKUucialyA1fdpxHVX3zPnIj7iuYIZtLOg/Pjq/PMGwt9bHl3WXqEDBYKwfRU
        Ol/pP39COsspYDjq6zO9bP1IQk0TUWom+C3C/gfwyM+88EqDyd3NM7hz1kk/yQpB
        k4CQmc5A12z/wDSZJyPDUPsYCbllqjyYbPPJqMufx/XGWbEIlRnI2sBJSbbVZk03
        X3xkoQ0I4EbevQQ7+wb2sY+u7Kad6vmP/aMIWAmf1PI9NfbOACE/9TTdlQnBmh4y
        mfSXpNFWHPTp1uC441Ixp0c6NGCE3SWXBUSfaDVRjbXJyCx9JfYagQREw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=pbEEpRRMeVfr/JLu2Y9mitizi6bfqPhgMj7PIg4UQss=; b=NvIH+dUw
        fAoBPY1SUa+lQaHHVaMDv+4gXSPnAU4LLU2wygdrxWmWxyBA6YMkWaaunNwdold7
        SQL09pnRsY46PIpYJRpspNHBzmqsWbmlD+9nqnI2TmXQarjmHH2cE6o7Hf3Qh/1g
        GJ+04bOuv7MnHzBFIgxqQOBokvgAOw8lEpdtW0rMiujlx0Xf+fXRxe+XR7h6Umfy
        P934pH4sh66SjoFBIqpFxm8QV44kZSJUVIIP29aB5CKFhSHo7ZomPyjmA6PHG7w3
        x43ja5XLqwzTwrWf1Y0CIx2OIkSl54AJq85WUgbRv2Hp+mHIPddXW6iDLfZjItkG
        HL3kufEG9q51dg==
X-ME-Sender: <xms:VIyYX45bqg04pvU_Jp6TqnknlWJXP4B0rQOUYFXzrzYqRQ7FIJV7Vg>
    <xme:VIyYX56rqLKObQmO2r9HRO9siHKYjJ7TyD-MERGVC8Oy_RFtCaqHJBq5vD835LPMW
    0pwtsCmlrSZhPco-v8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrieenucevlhhu
    shhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:VIyYX3deCc0DYTm2ZS4vHMwIDiCzzjgoAkMRCDpEPK9-dQzbup6s-Q>
    <xmx:VIyYX9KOc0Q5NwluEpmjmgnDJpT2cIDxSgTE82zCJ0Z1mX4EiUPo5g>
    <xmx:VIyYX8I_YPnBrLc_V0VXR9fH5_a3RkRiFylFj7WlEHLWIL5tu6Gwog>
    <xmx:VIyYX2wzYfhhvHiLXz_QVb0Bqmps1Ibf4KoCw5VLqReAdz2IBFheeQ>
Received: from localhost (unknown [163.114.132.6])
        by mail.messagingengine.com (Postfix) with ESMTPA id 778803280059;
        Tue, 27 Oct 2020 17:08:35 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v5 03/10] btrfs: create free space tree on ro->rw remount
Date:   Tue, 27 Oct 2020 14:07:57 -0700
Message-Id: <c54b8b303c2b029e2125582d4d80a350dab8d94e.1603828718.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1603828718.git.boris@bur.io>
References: <cover.1603828718.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When a user attempts to remount a btrfs filesystem with
'mount -o remount,space_cache=v2', that operation silently succeeds.
Unfortunately, this is misleading, because the remount does not create
the free space tree. /proc/mounts will incorrectly show space_cache=v2,
but on the next mount, the file system will revert to the old
space_cache.

For now, we handle only the easier case, where the existing mount is
read-only and the new mount is read-write. In that case, we can create
the free space tree without contending with the block groups changing
as we go.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/disk-io.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 95b9cc5db397..5fe0a2640c8a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2842,6 +2842,17 @@ int btrfs_mount_rw(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE) &&
+	    !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
+		btrfs_info(fs_info, "creating free space tree");
+		ret = btrfs_create_free_space_tree(fs_info);
+		if (ret) {
+			btrfs_warn(fs_info,
+				"failed to create free space tree: %d", ret);
+			goto out;
+		}
+	}
+
 	ret = btrfs_resume_balance_async(fs_info);
 	if (ret)
 		goto out;
@@ -3304,18 +3315,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		}
 	}
 
-	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE) &&
-	    !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
-		btrfs_info(fs_info, "creating free space tree");
-		ret = btrfs_create_free_space_tree(fs_info);
-		if (ret) {
-			btrfs_warn(fs_info,
-				"failed to create free space tree: %d", ret);
-			close_ctree(fs_info);
-			return ret;
-		}
-	}
-
 	btrfs_discard_resume(fs_info);
 	ret = btrfs_mount_rw(fs_info);
 	if (ret) {
-- 
2.24.1

