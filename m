Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CEA4CED1F
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 19:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiCFSQr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Mar 2022 13:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiCFSQq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Mar 2022 13:16:46 -0500
Received: from smtp.tiscali.it (michael.mail.tiscali.it [213.205.33.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B94065D0C
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 10:15:53 -0800 (PST)
Received: from venice.bhome ([78.12.27.75])
        by michael.mail.tiscali.it with 
        id 36El2700C1dDdji016EoHv; Sun, 06 Mar 2022 18:14:48 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 3/5] btrfs: change the device allocation_hint property via sysfs
Date:   Sun,  6 Mar 2022 19:14:41 +0100
Message-Id: <7c56077a080b9ab77d1a722cb3bdde50e83895c4.1646589622.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646589622.git.kreijack@inwind.it>
References: <cover.1646589622.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1646590488; bh=QEcrKhcmRlCqQhsUfRiL4nKoOngJPihtP7ZVa+dX7+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=VT4CkhblbbmupjVtL7Xhukl3E2p35rhUk1IFTCEiLEKoNPMUqdp1V347uZt1JOPyz
         coYNoZ1e8ujTF70bvFFZ3KSvLaDasAOJu4tdP9PEG6LS7EoSUJHvQ4XBxKtZPfy18D
         I/oshhaH4PecV0cJ71wGVN8SY4SiqKnVZg1beeU4=
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

This patch allow to change the allocation_hint property writing
a numerical value in the file.

/sysfs/fs/btrfs/<UUID>/devinfo/<devid>/allocation_hint

To update this field it is added the property "allocation_hint" in
btrfs-prog too.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 fs/btrfs/sysfs.c   | 76 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.c |  2 +-
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 59d92a385a96..c6723456c0e1 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1606,7 +1606,81 @@ static ssize_t btrfs_devinfo_allocation_hint_show(struct kobject *kobj,
 	}
 	return scnprintf(buf, PAGE_SIZE, "<UNKNOWN>\n");
 }
-BTRFS_ATTR(devid, allocation_hint, btrfs_devinfo_allocation_hint_show);
+
+static ssize_t btrfs_devinfo_allocation_hint_store(struct kobject *kobj,
+				 struct kobj_attribute *a,
+				 const char *buf, size_t len)
+{
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_root *root;
+	struct btrfs_device *device;
+	int ret;
+	struct btrfs_trans_handle *trans;
+	int i, l;
+	u64 type, prev_type;
+
+	if (len < 1)
+		return -EINVAL;
+
+	/* remove trailing newline */
+	l = len;
+	if (buf[len-1] == '\n')
+		l--;
+
+	for (i = 0 ; i < ARRAY_SIZE(allocation_hint_name) ; i++) {
+		if (l != strlen(allocation_hint_name[i].name))
+			continue;
+
+		if (strncasecmp(allocation_hint_name[i].name, buf, l))
+			continue;
+
+		type = allocation_hint_name[i].value;
+		break;
+	}
+
+	if (i >= ARRAY_SIZE(allocation_hint_name))
+		return -EINVAL;
+
+	device = container_of(kobj, struct btrfs_device, devid_kobj);
+	fs_info = device->fs_info;
+	if (!fs_info)
+		return -EPERM;
+
+	root = fs_info->chunk_root;
+	if (sb_rdonly(fs_info->sb))
+		return -EROFS;
+
+	/* check if a change is really needed */
+	if ((device->type & BTRFS_DEV_ALLOCATION_HINT_MASK) == type)
+		return len;
+
+	trans = btrfs_start_transaction(root, 1);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	prev_type = device->type;
+	device->type = (device->type & ~BTRFS_DEV_ALLOCATION_HINT_MASK) | type;
+
+	ret = btrfs_update_device(trans, device);
+
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+		goto abort;
+	}
+
+	ret = btrfs_commit_transaction(trans);
+	if (ret < 0)
+		goto abort;
+
+	return len;
+abort:
+	device->type = prev_type;
+	return  ret;
+}
+BTRFS_ATTR_RW(devid, allocation_hint, btrfs_devinfo_allocation_hint_show,
+				      btrfs_devinfo_allocation_hint_store);
+
 
 /*
  * Information about one device.
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5e3e13d4940b..d4ac90f5c949 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2846,7 +2846,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	return ret;
 }
 
-static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
+noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
 					struct btrfs_device *device)
 {
 	int ret;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index bd297f23d19e..93ac27d8097c 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -636,5 +636,7 @@ int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
+int btrfs_update_device(struct btrfs_trans_handle *trans,
+			struct btrfs_device *device);
 
 #endif
-- 
2.35.1

