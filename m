Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602B52D12F1
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgLGOAO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 09:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgLGOAN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 09:00:13 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F0AC08C5F2
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:59:27 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id p12so6480111qvj.13
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7YyqnduuKqEUVKiAG3eGPq7ah87Sv4iF9G8iHqvfpig=;
        b=WNoUFSRTEc0OYGf5GeSjvd1teDLjquyW0N8QGGkxMEU05RQwWCw5JnTiA10tryNInw
         WW0GN8g+wmN/iJ6QMW9m/X0ZPsJfkml3fyVhh+H966yP2xaKBt0wA3fU7tpy0F3wRqwe
         Z2K+hL+VyhRL3bBNs5wWELzPFkoT1bPN3tORpJxNyZ3N449Vlqf5DNE6t5K0rQ5yN9n/
         1jAbzxFIAZI4L7prMwMooBibzr6yuHLvXYGluwE4s52ZcToa7IQlBSFdathbRhOL9OiD
         jnCYVmgvYh5dNgLSN7nLrMyO2vvvfutTjQgIclsdbHoJ3mcLDy2kTEltWW5KPyv5PQu/
         rUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7YyqnduuKqEUVKiAG3eGPq7ah87Sv4iF9G8iHqvfpig=;
        b=nZMzjO95sFOc2Tc9vMREdvyLLu/XTEHfn7JcCH1Vz/3TAqgo/aPXH45gzp69JMSpmO
         zY0GnW7q3CE38/RgTZ8ZzgXB/uiX/aXYrVdRZO5xg+/ZXBad7pv2SSoMDIXAixouojRg
         rzl97cB29V21vE9prqX2pgw0VlFK69Q6CirXAV3csTIcjo1gCvwlj7xZtHEz6XMjIdnC
         keon7hyXyPl8fugCbXk2CT+u9sdkcv99LwsjXcgERHjLwXpzEl0XYxopmC073rDBSJMw
         /yCQlJ4OPvJ6aJeovp6wclGr+SKPNPHKfzHRIdvSslvi0q572iJ1MvxdRUGjlclH2UZU
         jsYQ==
X-Gm-Message-State: AOAM533McBJcI7dkV+oYVM8/E66ByYgoV8pMhDQAA2sjn2WEPaNRGQ5Q
        mVDr7ycV1DPhNGzbXPn4dquI0MrY+Qf7yw5y
X-Google-Smtp-Source: ABdhPJwwbcuG7KzzK0rbOmcOHHz3grhpFZEAubJUPcNzCJFtOt5fUCcSTInLuJ7VubhmkQr6kHMokw==
X-Received: by 2002:a05:6214:4e2:: with SMTP id cl2mr4673453qvb.27.1607349566796;
        Mon, 07 Dec 2020 05:59:26 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w9sm11787714qti.45.2020.12.07.05.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:59:25 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 52/52] btrfs: splice remaining dirty_bg's onto the transaction dirty bg list
Date:   Mon,  7 Dec 2020 08:57:44 -0500
Message-Id: <81f1374814c8b3d2df1cb2432b231e4d121f3b4b.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While doing error injection testing with my relocation patches I hit the
following ASSERT()

assertion failed: list_empty(&block_group->dirty_list), in fs/btrfs/block-group.c:3356
------------[ cut here ]------------
kernel BUG at fs/btrfs/ctree.h:3357!
invalid opcode: 0000 [#1] SMP NOPTI
CPU: 0 PID: 24351 Comm: umount Tainted: G        W         5.10.0-rc3+ #193
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
RIP: 0010:assertfail.constprop.0+0x18/0x1a
RSP: 0018:ffffa09b019c7e00 EFLAGS: 00010282
RAX: 0000000000000056 RBX: ffff8f6492c18000 RCX: 0000000000000000
RDX: ffff8f64fbc27c60 RSI: ffff8f64fbc19050 RDI: ffff8f64fbc19050
RBP: ffff8f6483bbdc00 R08: 0000000000000000 R09: 0000000000000000
R10: ffffa09b019c7c38 R11: ffffffff85d70928 R12: ffff8f6492c18100
R13: ffff8f6492c18148 R14: ffff8f6483bbdd70 R15: dead000000000100
FS:  00007fbfda4cdc40(0000) GS:ffff8f64fbc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbfda666fd0 CR3: 000000013cf66002 CR4: 0000000000370ef0
Call Trace:
 btrfs_free_block_groups.cold+0x55/0x55
 close_ctree+0x2c5/0x306
 ? fsnotify_destroy_marks+0x14/0x100
 generic_shutdown_super+0x6c/0x100
 kill_anon_super+0x14/0x30
 btrfs_kill_super+0x12/0x20
 deactivate_locked_super+0x36/0xa0
 cleanup_mnt+0x12d/0x190
 task_work_run+0x5c/0xa0
 exit_to_user_mode_prepare+0x1b1/0x1d0
 syscall_exit_to_user_mode+0x54/0x280
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

This happened because I injected an error in btrfs_cow_block() while
running the dirty block groups.  When we run the dirty block groups, we
splice the list onto a local list to process.  However if an error
occurs, we only cleanup the transactions dirty block group list, not any
pending block groups we have on our locally spliced list.  Fix this by
splicing the list back onto the transactions dirty block group list, so
any remaining block groups are cleaned up.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 0886e81e5540..5cfa52b1a3b8 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2685,6 +2685,9 @@ int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans)
 		}
 		spin_unlock(&cur_trans->dirty_bgs_lock);
 	} else if (ret < 0) {
+		spin_lock(&cur_trans->dirty_bgs_lock);
+		list_splice_init(&dirty, &cur_trans->dirty_bgs);
+		spin_unlock(&cur_trans->dirty_bgs_lock);
 		btrfs_cleanup_dirty_bgs(cur_trans, fs_info);
 	}
 
-- 
2.26.2

