Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24AA295504
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Oct 2020 01:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507022AbgJUXHL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 19:07:11 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:45907 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2507008AbgJUXHL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 19:07:11 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id D8E2212A9;
        Wed, 21 Oct 2020 19:07:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 21 Oct 2020 19:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=pbEEpRRMeVfr/
        JLu2Y9mitizi6bfqPhgMj7PIg4UQss=; b=brBKznmuyoOXgbQ7wlq7K71yDnnGS
        uDy4D2KCygNSFgNxacuQLFxLxv1ndEcrac6pijK4Kr+AShVLPPrLu8D4BisLdBFB
        afCM1r7oLcy3aT5SXvgHR3FAOaRZSyIfkjHvzBdAeXVpE+HuFU5c9JgrkTpbUOle
        DpVMQiOfZx4NexcH4REpMbbrOcoP2o+Pe12XOwsegRbraTrTXGET7cLzxONd6pKl
        3wkMUkFxOIWI8Y+3U9TcP/M3qyQul0wQARFh0nXo9CGE8xwP/+QNyohJZ7nkhdLy
        f/DMw4ikIbDD6e/D0fhmVEPNw3xTppuFbmQ210g6OM2ys+Jb1ilx0ISQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=pbEEpRRMeVfr/JLu2Y9mitizi6bfqPhgMj7PIg4UQss=; b=HmW4Ande
        UHq8zvVUfxIvQlLHGuxh7VlTjZ5qcN0iL+HksNReWvA3yw+r0OyJ6KuiYvLmL2TJ
        AEryOvkPV0mcC6By4iTKPbMhsUi5nwbg8d+uCXlT872BmtkU5H9CqovEyMNSDi/P
        mSHeUEWYBg1ltmcxkmUpcvW3IeJUGpesNZxt9hirfVj5GLlL8NV5qJ+lzO1jpVRn
        P1kJzQfdAO2Z0E4XLcuiYwrZlftGbW3wWH9B35UpJ4CdyxvLZt9Q0lCtF+gkZ/+7
        a2vd9JU1BSqpRDqHSiZI6j0/yJraEYyhoZtYNstSJn4RfGp1PgeO0NaJn7JskqHK
        Ee8Su5zkZafHkQ==
X-ME-Sender: <xms:Hb-QX-VVkJHrBwgabyhNMrDw1PgMkm8Qo-tlt_fG4cfC_FY3lzrtsQ>
    <xme:Hb-QX6lssrSo_KlgjiXWPwHbnGq_bZE7HVo5Dhq3h4MZuyE6AnOpX8Uf0uZwmQ5j4
    vV2RSqkTbeYNeZvvcY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeeigdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecukfhppeduieefrdduudegrddufedvrdefnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihho
X-ME-Proxy: <xmx:Hb-QXyZyxO7Zp87l-CR-vBiT87yBcUPn2LdQaXKaEPPO4bWVPULMCA>
    <xmx:Hb-QX1UqHpxt3Ocduv_s7st4zoieraAgZMblw0VD20KRwlzqgmnUIQ>
    <xmx:Hb-QX4kogIumfhGsxkX1lbD1n1MSRfKJumM894f-aEXUvf_Sq2-vnw>
    <xmx:Hb-QX_ttAwyAGn8v-J2ylTJd5_JA378kaUra-5Um9ncC4SkyWrY_4w>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1864D3064674;
        Wed, 21 Oct 2020 19:07:09 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v4 3/8] btrfs: create free space tree on ro->rw remount
Date:   Wed, 21 Oct 2020 16:06:31 -0700
Message-Id: <c54b8b303c2b029e2125582d4d80a350dab8d94e.1603318242.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1603318242.git.boris@bur.io>
References: <cover.1603318242.git.boris@bur.io>
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

