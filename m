Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20863380C57
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 16:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhENO5b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 10:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhENO5a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 10:57:30 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64517C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 14 May 2021 07:56:19 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id q6so15583037qvb.2
        for <linux-btrfs@vger.kernel.org>; Fri, 14 May 2021 07:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iWKjNG5+o2Wpm6A0J2+MKFBvE3M5kNo8AGN1s3alv2I=;
        b=YGrcdL+zH0PQ5KqLWmMqJr/RjoQCbUfdluLuMau/KDNmdK7k192fSxpUoOb6MS3k8t
         4K7C5HdQLE3qir+mC5mo+H5CwFlusoVoWL1mekVLGI8TS5Y/ecXcUY4QWYJ2x2ZtyDJy
         lPm45A11W6XdJ/WUBWq+Oaiq0y9dI9Ckyb073FasnmXqlFkE9cnwyjc836AlBG9lz9U5
         +Vgzch4wDs+fOqIIoMtW+8UaX6f4aMqWwPnWHFaArwtfkHm7Yn3b/wdWNZSeyrc38xwu
         +rCE9RKaUhVENxFFsbjtyv67s2k2BnbSd3EACNFHv3+EFTJqrSlAFaSSPJBCHU1LZk2B
         eZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iWKjNG5+o2Wpm6A0J2+MKFBvE3M5kNo8AGN1s3alv2I=;
        b=SSomEauJ+cGMxRf9UrAawcUSSlVgXdchGTRo7jrlOBUpLaiD01XIYI/WdjFMvBYYnu
         V7rTLanDuzyUgzjtb/imme8lIc/oIYebhk/GaG6bkvC931Jx8zqyLrLjBlQD+y3c3D0k
         /KOYclTXiT0FpNLeQu7SZjU0hciGWMgdpI9zrcRjL0gIgap2IAs30tJ31ugakOt0UVDf
         OtFUt6jG9rWy6ofSkLU9HNbaj0ZysSBzCEo+QWOETttV8JshVS1ZUj2F3qnJpb67semv
         W2zjd5eo9nO4IQ13Bxy7a6yg6yykWWp0G9ImZXNgOvpadIvBedqZhtLz6OJ/U88+5iPX
         WCBA==
X-Gm-Message-State: AOAM5336bpZlkAmpTqK2JDsMlDvH4SUZ1juW3drU+K7hsz/NBaUFOSgQ
        UnaQFWOvYN3F/NWEo/k8yK/Tllf+XKgxfw==
X-Google-Smtp-Source: ABdhPJxizJvNVJZIs86i+e0Q5L1wGS/gULJf2b9At8pxo/mMvCWgPjFkp/SK4MCSefQdtbW4TRt/IA==
X-Received: by 2002:a05:6214:373:: with SMTP id t19mr13547858qvu.45.1621004178137;
        Fri, 14 May 2021 07:56:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x142sm4862157qkb.136.2021.05.14.07.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 07:56:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: do not BUG_ON(ret) in link_to_fixup_dir
Date:   Fri, 14 May 2021 10:56:16 -0400
Message-Id: <b181013f36147fa92801c0073fe307df44272f2f.1621004165.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While doing error injection testing I got the following panic

------------[ cut here ]------------
kernel BUG at fs/btrfs/tree-log.c:1862!
invalid opcode: 0000 [#1] SMP NOPTI
CPU: 1 PID: 7836 Comm: mount Not tainted 5.13.0-rc1+ #305
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
RIP: 0010:link_to_fixup_dir+0xd5/0xe0
RSP: 0018:ffffb5800180fa30 EFLAGS: 00010216
RAX: fffffffffffffffb RBX: 00000000fffffffb RCX: ffff8f595287faf0
RDX: ffffb5800180fa37 RSI: ffff8f5954978800 RDI: 0000000000000000
RBP: ffff8f5953af9450 R08: 0000000000000019 R09: 0000000000000001
R10: 000151f408682970 R11: 0000000120021001 R12: ffff8f5954978800
R13: ffff8f595287faf0 R14: ffff8f5953c77dd0 R15: 0000000000000065
FS:  00007fc5284c8c40(0000) GS:ffff8f59bbd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc5287f47c0 CR3: 000000011275e002 CR4: 0000000000370ee0
Call Trace:
 replay_one_buffer+0x409/0x470
 ? btree_read_extent_buffer_pages+0xd0/0x110
 walk_up_log_tree+0x157/0x1e0
 walk_log_tree+0xa6/0x1d0
 btrfs_recover_log_trees+0x1da/0x360
 ? replay_one_extent+0x7b0/0x7b0
 open_ctree+0x1486/0x1720
 btrfs_mount_root.cold+0x12/0xea
 ? __kmalloc_track_caller+0x12f/0x240
 legacy_get_tree+0x24/0x40
 vfs_get_tree+0x22/0xb0
 vfs_kern_mount.part.0+0x71/0xb0
 btrfs_mount+0x10d/0x380
 ? vfs_parse_fs_string+0x4d/0x90
 legacy_get_tree+0x24/0x40
 vfs_get_tree+0x22/0xb0
 path_mount+0x433/0xa10
 __x64_sys_mount+0xe3/0x120
 do_syscall_64+0x3d/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

We can get -EIO or any number of legitimate errors from
btrfs_search_slot(), panicing here is not the appropriate response.  The
error path for this code handles errors properly, simply return the
error.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 14ec61048483..326be57f2828 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1858,8 +1858,6 @@ static noinline int link_to_fixup_dir(struct btrfs_trans_handle *trans,
 		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	} else if (ret == -EEXIST) {
 		ret = 0;
-	} else {
-		BUG(); /* Logic Error */
 	}
 	iput(inode);
 
-- 
2.26.3

