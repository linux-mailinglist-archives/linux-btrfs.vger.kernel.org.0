Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D512B881C
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 00:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgKRXGk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 18:06:40 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:35673 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726588AbgKRXGk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 18:06:40 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id C874BCB5;
        Wed, 18 Nov 2020 18:06:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 18 Nov 2020 18:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm2; bh=vhVcxxwmfjNgml4dzNX+QcGySM
        Ko/A8gDuCO0MGFTbg=; b=UMck/pJ9Fq8Fu/3nF0GgQZ3ldENtJEgK+FmR3LisN8
        NEBjiJoK3G9tC9fsa1sEX53o2rIrNI+Z9bRXQtaQcmVuIFJsEk7VO0rWdKO2/pMn
        2kH1kx030zva2dx+89jjLcmjXmHhEDWvDeSnku+WglQ0RHfVBfqU59F2Guw3TUzm
        9JWxWy4F8jFL5eiGn9pk384jDZuFRasSorTgiBCGyWECCeJViQyt6MLbgRV9OFKt
        OI3O7Wcw8WuCrYuh8k2Nwr0uJ1ZFny7BztzfoiVZWaoiVrdJsPpv+abv8s2yAeX8
        o9/JjxSlsv5WlYLWN90OsnXC1wNs2xC0EbMk9woiEN0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=vhVcxxwmfjNgml4dzNX+QcGySMKo/A8gDuCO0MGFTbg=; b=K7QkvRyj
        Jqopm+8pF1/yRBHGggG74xND83ODJB17ADmc7TNEGgKrCozH18EawfYg0WtdYW3A
        nveVeqkSw7kYO59zkibGrRs5Y1J9m8SGBs6IoiRLQbcSr0QrIQIYNndmZvzo5VMl
        CCFIpOwjAflmIFkzaV6PxNMN8t0EBTpfMeLnlWLJdueUOTPVy8KDAIshipVy97rt
        lL6FS7witvWx42p2B8jcg/b4HgXOoe4cfUicZ4WEeP93A1veEtPBMEiCGd08VCPC
        o+H4KdVp8YFmXSqFazrbeOhFTvhrLEI7yKkM1u/c5jHVoGvazkUUhat0PNiLFYYA
        fEljgzb4aScnqw==
X-ME-Sender: <xms:EKm1Xx8_W-799CBicIUG-V3gzGhloXWwNeAMM7n_ukLqxuxNQjonGQ>
    <xme:EKm1X1vWGdKPlKgbWUxTw7iRrSnkSnuF_9BqngJhiiDfg78KfXfx6gQg3nzs8gv-j
    Umdm0kYowZKcqNBx4E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefiedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrfeenucevlhhu
    shhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:EKm1X_Be2iiSNOjaCZ1ajfeysgH_C5yuWGvnV7xJviZZ394MHLtesQ>
    <xmx:EKm1X1d4aYAm917SbI-oH7AgEDysT21ujnHlZWxjQJavWHni6EW9oQ>
    <xmx:EKm1X2Mrfg3PnGzu7gOldi8mABhkgWpyCRxDyomH9JZ6X_lMeBPR3g>
    <xmx:EKm1X5ZZYhE5o4IFdtML7tJ12_PweqC-Pe05GdwRFef2B2owsmuusQ>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id EA330328006A;
        Wed, 18 Nov 2020 18:06:55 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 05/12] btrfs: clear oneshot options on mount and remount
Date:   Wed, 18 Nov 2020 15:06:20 -0800
Message-Id: <9c564def626db6d0de5ce0fc336aad4475050821.1605736355.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1605736355.git.boris@bur.io>
References: <cover.1605736355.git.boris@bur.io>
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
index d934eb80ff49..0bc7d9766f8c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2884,6 +2884,16 @@ static int btrfs_check_uuid_tree(struct btrfs_fs_info *fs_info)
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
@@ -3365,7 +3375,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	}
 
 	if (sb_rdonly(sb))
-		return 0;
+		goto clear_oneshot;
 
 	if (btrfs_test_opt(fs_info, CLEAR_CACHE) &&
 	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
@@ -3409,6 +3419,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	}
 	set_bit(BTRFS_FS_OPEN, &fs_info->flags);
 
+clear_oneshot:
+	btrfs_clear_oneshot_options(fs_info);
 	return 0;
 
 fail_qgroup:
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 945914d1747f..3bb097f22314 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -50,6 +50,7 @@ struct extent_buffer *btrfs_find_create_tree_block(
 						u64 bytenr, u64 owner_root,
 						int level);
 void btrfs_clean_tree_block(struct extent_buffer *buf);
+void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info);
 int btrfs_mount_rw(struct btrfs_fs_info *fs_info);
 int __cold open_ctree(struct super_block *sb,
 	       struct btrfs_fs_devices *fs_devices,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index ad5a78970389..cca00cc0c98c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1992,6 +1992,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 
 	wake_up_process(fs_info->transaction_kthread);
 	btrfs_remount_cleanup(fs_info, old_opts);
+	btrfs_clear_oneshot_options(fs_info);
 	clear_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
 
 	return 0;
-- 
2.24.1

