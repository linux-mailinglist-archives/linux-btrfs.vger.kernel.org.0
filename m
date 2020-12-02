Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F172CC73D
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389870AbgLBTxn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389862AbgLBTxm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:42 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D83C061A4E
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:53 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id ek7so1308104qvb.6
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mpzw1Hlljdl9wJfmKJhG85XKsureCOTUxShwr0elV94=;
        b=bXSfZV0hBO7OUvpNx3IAA//8USM56jDeng3/S2OwFyU2KMfCPiQuQiaPKdvtU5Q08C
         SaEIvzUX9BavdurHiA7vEJLce2kOIxZPWX2WZJQyixIBdgus2JwgXDKoXwWoWqJRS8I0
         HiqOUBFTN/i7q4VGFMo54L6QQF8cb6Hu551lAIcVtc0bxrJ9W3osgX43XauqQ67SgVOR
         pT9Za6nPtxmegeTZOQrB6cCwKYyYT3W9FXGfSwh0WGEhrkq+Ef0puA8tHCgpOLNy+5eo
         Ka+dIO9xtyRwvV8zSSIPewcb4aX4eLunfEdvaXxAWZIUw6HN0RL3NMRzFwouiuIr0AW7
         9kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mpzw1Hlljdl9wJfmKJhG85XKsureCOTUxShwr0elV94=;
        b=ssrKSu/bhVUJ98bfaAGZ8Mo+Fw+do5ppCI2WgveU+MHvlx4pDc5mz3ZG0QuBpokVN8
         e/U4K50c+R6g1P+AecpWllvs0AkKQCrYL0chi9E8OXuxW7d9GhzYP5XeAtxawEW48eG1
         hEJLAM+F/p0vMIHYdWKKDD2kF3ZobdvVmdqzyrfJ+GwpPLFg/wFi/i9yFtmc46VdO4v1
         XL3Rq+3w5OcdntPa6asnMYKA69hfKHCOL2zS4lw8gt/GI/RfyEfVzn8fYn4ttUKVH/+W
         sWykiwvri0JEtzpGL/bgOvVtfzsIQsDBaP8d1dCDyxR7BYPjyPpO5vF8hcRr64CvOFsL
         vzjA==
X-Gm-Message-State: AOAM533zYvQgfhKvQrfh9DhKQYyRYiFM+zqRvShMFB9QKQ7HVORFnGjT
        wZyBBGwPH4KnieMm8/oBBvVOfNNQq6/iGA==
X-Google-Smtp-Source: ABdhPJw5XtIEuweISoSu52qqmXTP2NbjM8LmmjWL4NC2nrKPIJc425zkD71lojk1OpbtmTsOoRdYYg==
X-Received: by 2002:ad4:54cd:: with SMTP id j13mr4128026qvx.8.1606938771807;
        Wed, 02 Dec 2020 11:52:51 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o21sm3023223qko.9.2020.12.02.11.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:51 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 54/54] btrfs: splice remaining dirty_bg's onto the transaction dirty bg list
Date:   Wed,  2 Dec 2020 14:51:12 -0500
Message-Id: <9d97cc69e823574da0c7586cdfbd49d210b8a246.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
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

