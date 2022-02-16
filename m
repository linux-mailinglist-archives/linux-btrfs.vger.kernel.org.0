Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2A54B90FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 20:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbiBPTHO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 14:07:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbiBPTHN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 14:07:13 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFAE1C119
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 11:07:00 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id d7so3771111qvk.2
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 11:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=msz1I9DM/YlgYXXhJzqF2jxk9iS+ZjZjP6il6A/utD4=;
        b=6YXplzQ23dWdLF67JINkRQ5uUHLM84t3bPav5NNJuFN5wzkEZuP8lFx5p5TCEv8/cu
         Zo2t7tCgCLW0BPxF3jl6DZxTgVh7Gm3CdnRzh2RB4S+FHQIZj+JAran5hJcnWJXxVZY9
         FMk5Hi8UyYg8qQ6FjEAWdQkHrC1S/8X2pBFQ48foW76FyX/U2/tYtxYYQAEIQd/VGJPs
         E8/07Y/FwJ7ke7QLiuStEvJCIisaLujU+QKuwPFSr9yftToiX16d2kkVMtLz+yaQLDgq
         Z+n03EKUF+HRh7Mb8DfjPK7o45kX7gkwOdtNl/a2Wxhn9ZgKliv6ZWGEU8G5PclbrcXL
         twXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=msz1I9DM/YlgYXXhJzqF2jxk9iS+ZjZjP6il6A/utD4=;
        b=WBmlhu+rwDI+/zxdxbc47868xxagyaaI0jLK2v9K6/FOqjUO3RfaoUBoo0zWkmgsdF
         P4zlaYAeFWISmZ9iNXhHQ3aPEJ4WVT9hjIAbe6CM9GHN5ogyPeTFY2rP+kQ/L+HMi9ki
         J3KLSbUXOSLBD5kxSMI86KCF25Ig+uiJG8XHfmPm4uTnt/rlMDhdNwUivyFAitW/bHf6
         SakxjcDbHHXRhgCUD6y1c3rtfbS75qbNFF1LrD/cH51NZYwRsjnc1jqnDrKQe+GFzYoj
         4E8QsfvQGjW8ItcUag5UHPNzrFSGj5CBwlDNlYPMAnD+m+QAmWxkzVz3BPYg+r0pjMD4
         0L8Q==
X-Gm-Message-State: AOAM532bZLTTCJQrcbMpWmH9mzvMIZ/9tFbOvt22inq+vdro2iXZlbXO
        cxEr193yFXBGHptO/NE1DEN6vJK3H12cmwWs
X-Google-Smtp-Source: ABdhPJz/xVFd1PY+xyzZvkIgLOXEVtT9zPMoEKq2N5QkwALSIqW5RelFjPZfPfuW+Zflwx7WdhZ6/Q==
X-Received: by 2002:a05:6214:1442:b0:42d:757:b902 with SMTP id b2-20020a056214144200b0042d0757b902mr2927448qvy.54.1645038418922;
        Wed, 16 Feb 2022 11:06:58 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x13sm20129376qko.114.2022.02.16.11.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 11:06:58 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/3] btrfs: clean deleted snapshots on mount
Date:   Wed, 16 Feb 2022 14:06:53 -0500
Message-Id: <12c9eec886e4544b71389770a069c90fac0401b9.1645038250.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645038250.git.josef@toxicpanda.com>
References: <cover.1645038250.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We hit a bug with a recovering relocation on mount for one of our file
systems in production.  I reproduced this locally by injecting errors
into snapshot delete with balance running at the same time.  This
presented as an error while looking up an extent item

------------[ cut here ]------------
WARNING: CPU: 5 PID: 1501 at fs/btrfs/extent-tree.c:866 lookup_inline_extent_backref+0x647/0x680
CPU: 5 PID: 1501 Comm: btrfs-balance Not tainted 5.16.0-rc8+ #8
RIP: 0010:lookup_inline_extent_backref+0x647/0x680
RSP: 0018:ffffae0a023ab960 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 000000000000000c RDI: 0000000000000000
RBP: ffff943fd2a39b60 R08: 0000000000000000 R09: 0000000000000001
R10: 0001434088152de0 R11: 0000000000000000 R12: 0000000001d05000
R13: ffff943fd2a39b60 R14: ffff943fdb96f2a0 R15: ffff9442fc923000
FS:  0000000000000000(0000) GS:ffff944e9eb40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1157b1fca8 CR3: 000000010f092000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 insert_inline_extent_backref+0x46/0xd0
 __btrfs_inc_extent_ref.isra.0+0x5f/0x200
 ? btrfs_merge_delayed_refs+0x164/0x190
 __btrfs_run_delayed_refs+0x561/0xfa0
 ? btrfs_search_slot+0x7b4/0xb30
 ? btrfs_update_root+0x1a9/0x2c0
 btrfs_run_delayed_refs+0x73/0x1f0
 ? btrfs_update_root+0x1a9/0x2c0
 btrfs_commit_transaction+0x50/0xa50
 ? btrfs_update_reloc_root+0x122/0x220
 prepare_to_merge+0x29f/0x320
 relocate_block_group+0x2b8/0x550
 btrfs_relocate_block_group+0x1a6/0x350
 btrfs_relocate_chunk+0x27/0xe0
 btrfs_balance+0x777/0xe60
 balance_kthread+0x35/0x50
 ? btrfs_balance+0xe60/0xe60
 kthread+0x16b/0x190
 ? set_kthread_struct+0x40/0x40
 ret_from_fork+0x22/0x30
 </TASK>
---[ end trace 7ebc95131709d2b0 ]---

Normally snapshot deletion and relocation are excluded from running at
the same time by the fs_info->cleaner_mutex.  However if we had a
pending balance waiting to get the ->cleaner_mutex, and a snapshot
deletion was running, and then the box crashed, we would come up in a
state where we have a half deleted snapshot.

Again, in the normal case the snapshot deletion needs to complete before
relocation can start, but in this case relocation could very well start
before the snapshot deletion completes, as we simply add the root to the
dead roots list and wait for the next time the cleaner runs to clean up
the snapshot.

Fix this by simply cleaning all of the deleted snapshots at mount time,
before we start messing with relocation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b6a81c39d5f4..ae8c201070f2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3380,6 +3380,19 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 	up_read(&fs_info->cleanup_work_sem);
 
 	mutex_lock(&fs_info->cleaner_mutex);
+	/*
+	 * If there are any DEAD_TREE's we must recover them here, otherwise we
+	 * could re-start relocation and attempt to relocate blocks that are
+	 * within a half-deleted snapshot.  Under normal operations we can't run
+	 * relocation and snapshot delete at the same time, however if we had a
+	 * snapshot deletion happening prior to this mount there's no way to
+	 * guarantee that the deletion will start before we re-start (or a user
+	 * starts) the relocation.  So do the cleanup here in order to prevent
+	 * problems.
+	 */
+	while (btrfs_clean_one_deleted_snapshot(fs_info->tree_root))
+		cond_resched();
+
 	ret = btrfs_recover_relocation(fs_info->tree_root);
 	mutex_unlock(&fs_info->cleaner_mutex);
 	if (ret < 0) {
-- 
2.26.3

