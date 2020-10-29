Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AC929F950
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 00:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgJ2X6P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 19:58:15 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60989 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgJ2X6O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 19:58:14 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id F25835C008C;
        Thu, 29 Oct 2020 19:58:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 29 Oct 2020 19:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm2; bh=fwV4xy0O6qicfBFEo2f4u9h9AV
        08MvrWD+FP5tonJfQ=; b=d5gLg5quVyNs0kWlHlaMIKhXSWBckKgmQfd4ISRl9C
        BmUWwuO6gbZJ5xUPnYLyyhGtWXBxm8wX2zGSF/cdevKvlSiw1cgqJFCJlNMCxQQG
        251jxP1EbGGyjm6lylbm5oGvkF0A4C8+XuoKG2yXJpzr2A/sprg5bSF/9PONNHNG
        7hGCk2ZNxehUTZiQqMdFaWBtYaLeQyBNKZROfM0fx2g4F9Z9vqOePM9nVMeLEM0s
        R/kegv7bh6JFlblG8NoJG1AZsZ8ZP587MJdQO+t12h9ZQy1cJwWf0ekNf6B3MZ3M
        cCHuTs0X2DojjkrumwXU0V/7kH+9myKoIAWbtx61rREA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=fwV4xy0O6qicfBFEo2f4u9h9AV08MvrWD+FP5tonJfQ=; b=BXL//2Br
        2G0mA5oBScsXYUj14JJYJOhRF/psIre9o+aXNSPBNuzAVxnB59xbivTzObi7ujxA
        MtrAJadz1qqgs6w2/TcFMTeWgzQgmPPIHz6gY13i14F9JfsNgBT019bgu13jW2eQ
        V4+0J5nKxvszIwsaJzDb/8SfAV8Xdqf/Ybg4WqPmhhsBqtf32C+VQbBnQPi6r5jW
        BgteKXQY/o89yVEn1vIY7kz+rGc/MulI49vGPS03sobUZpLrFEUizyTG34GBUmII
        EjOU5SiPy+TYMJEFUFqGGBjck4jRvIUBebuscZkAaQ5g9+3z6kVNPifDyJD+qsjY
        x6DsBcnHqBjpxg==
X-ME-Sender: <xms:FVebX4V985IZZr7F5oJPmUDVz56vkN1Yno4X9G6GEk73AOkyHEIA9w>
    <xme:FVebX8kLBKmp2IGV5kHFPUXATEAFCoDoip12NQN04d84s6FjwPErIlif7T_W4ezy0
    BK6zDBuywi006nbYZk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleeggdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecukfhppeduieefrdduudegrddufedvrdefnecuvehluhhs
    thgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihho
X-ME-Proxy: <xmx:FVebX8by-7shZlrCWjzZUzhxYnbbdz4wzx3gP2_hkIG4oum0SsZR-g>
    <xmx:FVebX3Wuzy3gMedTtOPgGW0LSeJHxbrmosHTk3PNLkrm06QVUmNS_Q>
    <xmx:FVebXykqSp7fWbQZJ4yGqhjaaUQ4RPOhgdmlHFHstjSEUoKpHsJGug>
    <xmx:FVebX8SOqEcqmSPDPIxkp3oCpQsV0_HdtvT8_88mZrs9OPrB30XpAA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 810F2328005E;
        Thu, 29 Oct 2020 19:58:13 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 04/10] btrfs: clear oneshot options on mount and remount
Date:   Thu, 29 Oct 2020 16:57:51 -0700
Message-Id: <9b8b036b575599ce4a2a748263e3bd0e80288b0d.1604015464.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1604015464.git.boris@bur.io>
References: <cover.1604015464.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Some options only apply during mount time and are cleared at the end
of mount. For now, the example is USEBACKUPROOT, but CLEAR_CACHE also
fits the bill, and this is a preparation patch for also clearing that
option.

One subtlety is that the current code only resets USEBACKUPROOT on rw
mounts, but the option is meaningfully "consumed" by a ro mount, so it
feels appropriate to clear in that case as well. A subsequent read-write
remount would not go through open_ctree, which is the only place that
checks the option, so the change should be benign.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/disk-io.c | 14 +++++++++++++-
 fs/btrfs/disk-io.h |  1 +
 fs/btrfs/super.c   |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 69a878d8cc79..63f1e37f0e22 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2894,6 +2894,16 @@ static int btrfs_check_uuid_tree(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
+/*
+ * Some options only have meaning at mount time and shouldn't persist across
+ * remounts, or be displayed. Clear these at the end of mount and remount
+ * code paths.
+ */
+void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info)
+{
+	btrfs_clear_opt(fs_info->mount_opt, USEBACKUPROOT);
+}
+
 /*
  * Mounting logic specific to read-write file systems. Shared by open_ctree
  * and btrfs_remount when remounting from read-only to read-write.
@@ -3373,7 +3383,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	}
 
 	if (sb_rdonly(sb))
-		return 0;
+		goto clear_oneshot;
 
 	if (btrfs_test_opt(fs_info, CLEAR_CACHE) &&
 	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
@@ -3417,6 +3427,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	}
 	set_bit(BTRFS_FS_OPEN, &fs_info->flags);
 
+clear_oneshot:
+	btrfs_clear_oneshot_options(fs_info);
 	return 0;
 
 fail_qgroup:
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index a4e6cdbe3a48..22df6a570aaf 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -50,6 +50,7 @@ struct extent_buffer *btrfs_find_create_tree_block(
 						struct btrfs_fs_info *fs_info,
 						u64 bytenr);
 void btrfs_clean_tree_block(struct extent_buffer *buf);
+void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info);
 int btrfs_mount_rw(struct btrfs_fs_info *fs_info);
 int __cold open_ctree(struct super_block *sb,
 	       struct btrfs_fs_devices *fs_devices,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 22299fc13b6d..3d56b98e152d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1994,6 +1994,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 
 	wake_up_process(fs_info->transaction_kthread);
 	btrfs_remount_cleanup(fs_info, old_opts);
+	btrfs_clear_oneshot_options(fs_info);
 	clear_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
 
 	return 0;
-- 
2.24.1

