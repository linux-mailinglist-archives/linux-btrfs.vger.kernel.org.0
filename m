Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFAF2CDD8E
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502082AbgLCSZ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502077AbgLCSZ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:26 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE38C08E861
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:24:34 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id y197so3009498qkb.7
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7YyqnduuKqEUVKiAG3eGPq7ah87Sv4iF9G8iHqvfpig=;
        b=2BGNW/4OxS+zX+tjUwBXvKBfW1kNWv681mFOhEEQ2iasQ3xAZVcQojTMB3r8VHQDaD
         C5pbHGS5SB4fDZzVLXAKojhIPEtwvJkwF/ROXevRDg+KqJBYWPXD8c8G3UuOVWELoLnw
         99pCtpaxOo6yitrCtoLKFQvG7FAepjNfKVscUcohpFzpiy9/PDwradEW/6DSXMrnRsZh
         WotoQ+gK9KSeZwfgv0DgbXmqZA2wn+dLx5NzXTtF8wR62983+r4xBjawa6Hn0fQg+WNL
         FUqZ21jvWtYdA3S/licF+4OYyOxUEULytf1MwTQa6QyfIRTvU6JPeU4oKVNo1d2eltYh
         IsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7YyqnduuKqEUVKiAG3eGPq7ah87Sv4iF9G8iHqvfpig=;
        b=BflmufIpgOZ12gzGp1OclLDUwU6DdHggsrSgFQzz5VzkmEoUNPfWsX+uOFmMfsPUVQ
         5/R03QiysnySgEh0BQOFis2rhZdfMTvvpSAGzl44DsQgErNZICRBOfBx6JYgj0gTI4E2
         Mj5MXoGYNCZe5TSRUBWJixj3ssEo47KDzvO49RzZ9MmKFqgLF9qX6EP8o3dwAOwSpqFl
         vgizpi6Vmy+vcqnoYKZY3SFf3l1awP2updNkCACAHhzBFn2MT0JBAzcqmkUn/yDryMzB
         WqyB4O53JogvbZdtghDRdfZwh5b5CXYW7FInpoVm+U9vvk43DHdeexmWpB0LXd7h7JfD
         FnEA==
X-Gm-Message-State: AOAM532Vt7Fredy/aBu+Kyl5j3QNn17n8qxZyMac79fWAh+E0O+Twg1q
        N3o9nulvbG8oW190ggOUjOgkVJA7+JirNBDz
X-Google-Smtp-Source: ABdhPJyH8yDiYr1UvNgucPRh0Dy84uFVBOJOEgkzh+RD27rF7vys/UEkrAVK6szX8Y+gU19t6EPaZw==
X-Received: by 2002:a05:620a:22e7:: with SMTP id p7mr4213472qki.333.1607019873454;
        Thu, 03 Dec 2020 10:24:33 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x21sm2147569qtb.14.2020.12.03.10.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:24:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 53/53] btrfs: splice remaining dirty_bg's onto the transaction dirty bg list
Date:   Thu,  3 Dec 2020 13:22:59 -0500
Message-Id: <1bcdd646be881f16be39bc597e6f273c1ccb5a60.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
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

