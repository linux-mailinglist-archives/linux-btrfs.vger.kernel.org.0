Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9395B295503
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Oct 2020 01:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507019AbgJUXHI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 19:07:08 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:40299 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2507008AbgJUXHH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 19:07:07 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 94A8D1271;
        Wed, 21 Oct 2020 19:07:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 21 Oct 2020 19:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=NwF33qAkYY5Jg
        9aMFkZt1nVLSAqpXE9HhMnBgW6gFJg=; b=SDs7g5ccWG/f2+BuiWO9rmxoNCvRO
        1g6KdityGE1yY0WhqHeVvNg6pjk3vKyMeruBpnh0lgu6XligFjCxuLpLpRMzfIl1
        XoIDbbOQK0Y3n8DM9b6s152ab+wXfo19G+rLm3Y91AIqB2HGP4/HYaJmh0MX3aIN
        piYKSekLtChyR/DTOn3BJXlrra/5A3k39Z7bL3EcM8aQ8xNrH/Xd9mB8tpZ8ewtB
        lv8uetZxoGzywM7JIJz1o/8WALNaBOUsIhkVcdOEPY02Z9IkGHmccUZ3M+SU0YFl
        JhroW1ymCKe6g4Gv1IVlNUS0BMIcx0KYSAV887Rj8OEB1mpElLZtbrvLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=NwF33qAkYY5Jg9aMFkZt1nVLSAqpXE9HhMnBgW6gFJg=; b=JDxjFxOW
        t7qzHVahhcvlAh9gqB+UVvV/8Wb7nVvoRjfMCSDhyc6J3xY3EHwKzlLTMS0guEeD
        kMlu5mChuI1f2kivpG9R3zglROaHRuhlzZ7x/x6OY59SLLP+DJBjt+ohWb8iGGcU
        ape8/ewNeQOqZl+1sYzQAYJfVnKTp0sjtbMn7cNCTdtGwR46vdTqiIV85VrkpWN9
        NJ/QyBP82R56a6wZ8amrOH91soqQFun5EwOSLx4fBcILmJ/oqpcwzdxJHs13j+so
        0y68ii97BMqUsrlpXkAmY1k88uwZ17F8J2WdFPsMkUuomwphAEEh/6kU8halgUvb
        ABpGq9IRNeP93Q==
X-ME-Sender: <xms:Gr-QX0b9KA9a6NkvXP1CNusN33hJzXtOJx1uQOUZdDsboT_Otku-jg>
    <xme:Gr-QX_bWfsB05bCk1HuoiRd_hLHW6oyMvmdf78oJZS8DwOHEZLJx1mHKDCQknJ42z
    Mv_461Bguglwj3QAsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeeigdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecukfhppeduieefrdduudegrddufedvrdefnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihho
X-ME-Proxy: <xmx:Gr-QX-_iSmFrONKbyby_iGI1vRrS_Dbx1WE5UZK0WgDxNAL4UoGfXg>
    <xmx:Gr-QX-rF_G-EE72VDalb6eSk4IdRWJdumGOtMBeLMW_d6iEcQduj5w>
    <xmx:Gr-QX_pEbGRpaqdqZz7NhUrMOVuNpEEaivydUQ0B-dXt1PeLpF4dRQ>
    <xmx:Gr-QX-TOcXPT0Gic1g02wDO3ZZLoYn4eVy4pG6H0QFvSE9RoU2vkVA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id CFE963064674;
        Wed, 21 Oct 2020 19:07:05 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v4 2/8] btrfs: cleanup all orphan inodes on ro->rw remount
Date:   Wed, 21 Oct 2020 16:06:30 -0700
Message-Id: <56e0a8c18483c395d20fc6c69a42740d19742eb1.1603318242.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1603318242.git.boris@bur.io>
References: <cover.1603318242.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we mount a rw file system, we clean the orphan inodes in the
filesystem trees, and also on the tree_root and fs_root. However, when
we remount a ro file system rw, we only clean the former. Move the calls
to btrfs_orphan_cleanup() on tree_root and fs_root to the shared rw
mount routine to effectively add them on ro->rw remount.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/disk-io.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index bff7a3a7be18..95b9cc5db397 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2826,6 +2826,14 @@ int btrfs_mount_rw(struct btrfs_fs_info *fs_info)
 	if (ret)
 		goto out;
 
+	down_read(&fs_info->cleanup_work_sem);
+	if ((ret = btrfs_orphan_cleanup(fs_info->fs_root)) ||
+	    (ret = btrfs_orphan_cleanup(fs_info->tree_root))) {
+		up_read(&fs_info->cleanup_work_sem);
+		goto out;
+	}
+	up_read(&fs_info->cleanup_work_sem);
+
 	mutex_lock(&fs_info->cleaner_mutex);
 	ret = btrfs_recover_relocation(fs_info->tree_root);
 	mutex_unlock(&fs_info->cleaner_mutex);
@@ -3308,15 +3316,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		}
 	}
 
-	down_read(&fs_info->cleanup_work_sem);
-	if ((ret = btrfs_orphan_cleanup(fs_info->fs_root)) ||
-	    (ret = btrfs_orphan_cleanup(fs_info->tree_root))) {
-		up_read(&fs_info->cleanup_work_sem);
-		close_ctree(fs_info);
-		return ret;
-	}
-	up_read(&fs_info->cleanup_work_sem);
-
 	btrfs_discard_resume(fs_info);
 	ret = btrfs_mount_rw(fs_info);
 	if (ret) {
-- 
2.24.1

