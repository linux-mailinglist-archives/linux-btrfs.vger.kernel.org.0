Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DF42DC404
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgLPQXl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgLPQXk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:23:40 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1469C06138C
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:27 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id n142so23010546qkn.2
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nu/ZBovSPI4CZSxD1YV063UqkFj5le8cUTFJ+CMVQRY=;
        b=YnoLlPdJwiQyrB7pgjuIkcBm9Y3gbJxuf+TFlBrTfBIb+vVU1XH2S/tF1hEM8JuEZw
         mxW6xLNEw57yW1o5KKl0CPNsLpEAQMs3GOQp6+nA3BonEDKE0Iglnaf7z5OIMOsMNK3z
         Wb54GJ3ag4Z/IGVJ5rC4QCAz6eh5mjZXRcplo0E7Fx0q70J5JF0zPGkzrAvXOhKca89/
         SdWvMt1TezsUZiUGCKqxiWyY1b1BVxu4oIhswgpyXA3NUpnKSi1N1bzB4myNhQH1D0lQ
         guKMhxADt8G9MHpVTb7ZYFCGgGDsIAi8BbEHnkPVENtA/XZNQIwLY193MlU5Y9qOrerX
         TBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nu/ZBovSPI4CZSxD1YV063UqkFj5le8cUTFJ+CMVQRY=;
        b=IH93af4pVD120XT1FEX0ltW958tMzMFQIN6LhDocMIDxBN2l8k/m0DD/0E1HY5ZB2z
         8D1G+KqnTJIvRrf6vB/GM0g7geMUXOqZuvh7/A1/R6++E7jNosPVM74YHxdDtrCcJFpA
         Lt07h/SnuvBK/b8WjRl79ZRJ3FLcvFN1NwWUfgkZNStrh5eldMHHddwt87tpg7uZ94NM
         qTfvL3daRVCe0lUJMR+X0CFUjORfTbq9IQL+USoaF/+g/JOc4vWYJiGyFwQbHbzSRb1A
         RU0x/bYaK3/QWE4CvrsitPjv0rwMZfpVqrNbDcKc+/TLlo5MLurJxRS6iMRyxHHfyTlB
         t38g==
X-Gm-Message-State: AOAM5331/iLuF2DswoD3P3oJCSdTvj6tjMcV/Uiplv6GeyCnRmc8kYZH
        97VLnv64S//d7GFVhtiqsFXYefYSqB099GVo
X-Google-Smtp-Source: ABdhPJyGggwn7HTzIfxPcXWA1fx6h971/xCXacI+x7EpTu3XKRO0Y+doK2TkxuubOxA7E4y24pk5eg==
X-Received: by 2002:a05:620a:410a:: with SMTP id j10mr43708447qko.171.1608135746414;
        Wed, 16 Dec 2020 08:22:26 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w192sm1407034qka.68.2020.12.16.08.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:22:25 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH 04/13] btrfs: splice remaining dirty_bg's onto the transaction dirty bg list
Date:   Wed, 16 Dec 2020 11:22:08 -0500
Message-Id: <92c0de2de1f65b71393307dba17d2cc48f183992.1608135557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135557.git.josef@toxicpanda.com>
References: <cover.1608135557.git.josef@toxicpanda.com>
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
index 52f2198d44c9..69f8a306d70d 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2684,6 +2684,9 @@ int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans)
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

