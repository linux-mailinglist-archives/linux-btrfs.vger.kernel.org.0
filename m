Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85C929CAF2
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 22:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832069AbgJ0VIm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 17:08:42 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33845 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1832061AbgJ0VIm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 17:08:42 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 3E6545C00B4;
        Tue, 27 Oct 2020 17:08:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 27 Oct 2020 17:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=cq0c5H3Du+D0p
        V/aMMb/8VkF09ghgdkmSv/cJcFIFtw=; b=fu7wcjB+mzS097Cfaj5rWy7a5c/Sf
        zrULDYENW0MwpkLjKOIPvnSjv+JAozKfEcO53wGqpjUqvws6d6i4lyBClMCCe0df
        1cfKGhoQcg3qnt/Heh/rloWhmaJUoL9U7cMP+0nK6j22VcpK+8kpF4D8M7wm21HJ
        8v6A9wVDWSzyqt1DZTtDjPrI+jgrOL5DXt8P3QoxypD8UXpSU35rf1XmsZx0UQRf
        CayELBOSQkuS0DS8ThwRqxVk9mxSHaYdyksrPD3uxabC4qLZ/XZ57O1yCsiRWf0E
        02vTW7xpOt7MCAM6ZgUOK29N93Y7SdxH6afkaDFD6dD2hK8XvsKK68F0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=cq0c5H3Du+D0pV/aMMb/8VkF09ghgdkmSv/cJcFIFtw=; b=EGe3IbxX
        uYKqA1w0opT0uKtwoG8LPrdjYv9FxEa1pUrmRBJjpEUNBk5zxPMNuYXI5CIBxmO0
        UJ02qDZ8BanlynnfZWubsvDo+aGuysfol1Lfhs1SMaKuKKhL24y3VJLD6ZctX6e0
        /mP9y8b2X5htOp3gRA23tT3ix92EcP9emgFxM4yu3BfrNPqE8q0VwOQhnAqwnyD0
        xCneF3uv5zB/t1cBQA8GZYKhcO304zpvA9Dr/jkxgQlLSoAilNBjHXwr1pGE/PGD
        Sh1jSIcRa6bboR9A4b7TcNskjEMMbJWhcVcAMlI/Z6W/AK/ajNbsNU/7H+NmDtXl
        VKyH0/u1V8dtdA==
X-ME-Sender: <xms:WYyYX5bP8ZHCHhDb9A4YEwaW6ZRJWgRAPGUM0WJe2t4UdUoZLDsZpg>
    <xme:WYyYXwZDtB5Mqmr8wBLNQukxM1HGpYzALQtdo2XkKWMz3TUY0MrYWTcIqxEGWyZh5
    xuQb5fKmq17JYXsJNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrfeenucevlhhu
    shhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:WYyYX79F4PsU8y7leILlDTPdUH_HXXYLg8XBgemu45cJqINSG10YZw>
    <xmx:WYyYX3q4HvAxTqob_A3XHWYiNg7UZCzdvwedJpKzX6b_VYJYTKBCMw>
    <xmx:WYyYX0rsje9Zncr11R9qEcDuVkulhUmGfIYWnljfGGw3n5Kid6lcSA>
    <xmx:WYyYX7S7IqGXPCJBfB_NFt1XMIvMyxB80Gl-7H9H1roYRbZq2Sk17w>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 88D8A3280059;
        Tue, 27 Oct 2020 17:08:40 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v5 04/10] btrfs: clear oneshot options on mount and remount
Date:   Tue, 27 Oct 2020 14:07:58 -0700
Message-Id: <7b316bb772e15d62df1553c50c8bb4c50cc63c51.1603828718.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1603828718.git.boris@bur.io>
References: <cover.1603828718.git.boris@bur.io>
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
 fs/btrfs/disk-io.c | 20 +++++++++++++-------
 fs/btrfs/disk-io.h |  1 +
 fs/btrfs/super.c   |  1 +
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5fe0a2640c8a..987e40e12bb4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2814,6 +2814,16 @@ static int btrfs_check_uuid_tree(struct btrfs_fs_info *fs_info)
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
@@ -3293,7 +3303,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	}
 
 	if (sb_rdonly(sb))
-		return 0;
+		goto clear_oneshot;
 
 	if (btrfs_test_opt(fs_info, CLEAR_CACHE) &&
 	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
@@ -3337,12 +3347,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	}
 	set_bit(BTRFS_FS_OPEN, &fs_info->flags);
 
-	/*
-	 * backuproot only affect mount behavior, and if open_ctree succeeded,
-	 * no need to keep the flag
-	 */
-	btrfs_clear_opt(fs_info->mount_opt, USEBACKUPROOT);
-
+clear_oneshot:
+	btrfs_clear_oneshot_options(fs_info);
 	return 0;
 
 fail_qgroup:
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index b3ee9c19be0c..02bee384f744 100644
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
index 56bfa23bc52f..85a0cf56cec5 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1945,6 +1945,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 
 	wake_up_process(fs_info->transaction_kthread);
 	btrfs_remount_cleanup(fs_info, old_opts);
+	btrfs_clear_oneshot_options(fs_info);
 	clear_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
 
 	return 0;
-- 
2.24.1

