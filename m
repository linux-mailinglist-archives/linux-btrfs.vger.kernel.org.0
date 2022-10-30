Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CC2612B98
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Oct 2022 17:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJ3QWz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Oct 2022 12:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJ3QWy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Oct 2022 12:22:54 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FF5A462;
        Sun, 30 Oct 2022 09:22:53 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so8424228pjl.3;
        Sun, 30 Oct 2022 09:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BQn3ZUpbdgmJP28m8KFPs8Ve0nMUfYmCJ+MhZVJSwXU=;
        b=WbOxiS5OS/PT1ygZRFlxBeA9ehxYmudDAnwUyppNGaFZx1br+xbMU0222rwjR/201U
         DEJ+9MM1HrgLyT7cwDRIN/8nKU04AYQgLGqrYy3nd1OSR++6uB6PUTW83B8rOu2DK9wC
         T+JG67U5jGxwgL11N/aVRXUqeccZjXtGJY3iCw/+QpIHDVIUC1JRMWoJX/wWYx6JcVs8
         1ahKneGHbSqfIcNXr1VnPUashePEsr97Eq9kITkGRXjTDGuABHisNfyYuBYkHcpwXxu/
         9uaHiFVlr9vz8XdwL/eexORIWynKISXxXByHErHqpzhNidPhzQXukDMiiW7MxcK8ILHb
         F3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQn3ZUpbdgmJP28m8KFPs8Ve0nMUfYmCJ+MhZVJSwXU=;
        b=Y1Hchf+WFeIfPJbVyKsZ7HNcS54NQ1dU84jZVgMhaKQhKCkPl4P7Aq8N7VtEdx1CDT
         c/owYW/NVJ7NFFZt5bGGqW3MthIIlaxZpdOF+CWaxmnNbXVYTGDPDOJZ58euJ0LEWa5H
         PGwAD2DyModORwpF5kLAsj/oq69HukV4D6JlfWDGCBPi/MXWskLArSMxPsTBDSKzpV72
         GU9ayqBNN2gkUAmGJHZG8XsIFWgq8LRKyB7T4HzG7Q6ryIq/jq5Lw4CsKSjPjhIEgOW7
         zFOlQIXKMelmBDDaW9XvGiXXXSBtiv6NvNanItYrKGdOy+Fs2Npr+uL7dKxf4q3pgEY5
         GsxA==
X-Gm-Message-State: ACrzQf2EVFe2Jwi/Hx3r/CvYbyKNhVUli5eymvPRRi0q1tjPKb/N6Te+
        96JPKcG5nUNUbshOTbm8pto=
X-Google-Smtp-Source: AMsMyM5Y6JirfSHIVaga90wK49q1LDWrq7sLydks8turZETasEqJZcUfjHZeq0VfyXniS62wF6RM4g==
X-Received: by 2002:a17:90a:5517:b0:213:b122:41b3 with SMTP id b23-20020a17090a551700b00213b12241b3mr8070540pji.121.1667146972473;
        Sun, 30 Oct 2022 09:22:52 -0700 (PDT)
Received: from localhost ([183.242.254.175])
        by smtp.gmail.com with ESMTPSA id c2-20020a631c02000000b0045ff216a0casm2576491pgc.3.2022.10.30.09.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 09:22:51 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     yin31149@gmail.com, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     18801353760@163.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzbot+dde7e853812ed57835ea@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: [PATCH] btrfs: update bytes_may_use in btrfs_free_reserved_bytes()
Date:   Mon, 31 Oct 2022 00:22:24 +0800
Message-Id: <20221030162223.25970-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Syzkaller reports warning as follows:
=====================================
WARNING: CPU: 0 PID: 3612 at fs/btrfs/space-info.h:122
  btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:154 [inline]
WARNING: CPU: 0 PID: 3612 at fs/btrfs/space-info.h:122
  block_rsv_release_bytes fs/btrfs/block-rsv.c:151 [inline]
WARNING: CPU: 0 PID: 3612 at fs/btrfs/space-info.h:122
  btrfs_block_rsv_release+0x5d1/0x730 fs/btrfs/block-rsv.c:295
Modules linked in:
[...]
RIP: 0010:btrfs_space_info_update_bytes_may_use
  fs/btrfs/space-info.h:122 [inline]
RIP: 0010:btrfs_space_info_free_bytes_may_use
  fs/btrfs/space-info.h:154 [inline]
RIP: 0010:block_rsv_release_bytes
  fs/btrfs/block-rsv.c:151 [inline]
RIP: 0010:btrfs_block_rsv_release+0x5d1/0x730
  fs/btrfs/block-rsv.c:295
[...]
Call Trace:
 <TASK>
 btrfs_release_global_block_rsv+0x2f/0x250 fs/btrfs/block-rsv.c:463
 btrfs_free_block_groups+0xb67/0xfd0 fs/btrfs/block-group.c:4053
 close_ctree+0x6c5/0xbde fs/btrfs/disk-io.c:4710
 generic_shutdown_super+0x130/0x310 fs/super.c:491
 kill_anon_super+0x36/0x60 fs/super.c:1085
 btrfs_kill_super+0x3d/0x50 fs/btrfs/super.c:2441
 deactivate_locked_super+0xa7/0xf0 fs/super.c:331
 cleanup_mnt+0x4ce/0x560 fs/namespace.c:1186
 task_work_run+0x146/0x1c0 kernel/task_work.c:177
 ptrace_notify+0x29a/0x340 kernel/signal.c:2354
 ptrace_report_syscall include/linux/ptrace.h:420 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:482 [inline]
 syscall_exit_work+0x8c/0xe0 kernel/entry/common.c:249
 syscall_exit_to_user_mode_prepare+0x63/0xc0 kernel/entry/common.c:276
 __syscall_exit_to_user_mode_work kernel/entry/common.c:281 [inline]
 syscall_exit_to_user_mode+0xa/0x60 kernel/entry/common.c:294
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
 [...]
 </TASK>
=====================================

In btrfs_new_extent_direct(), kernel will reserves space for extent
by btrfs_reserve_extent(), and frees those space by
btrfs_free_reserved_extent() if btrfs_create_dio_extent() fails.

Yet the problem is that, it may not update the space
info correctly. To be more specific, kernel will
converts space from ->bytes_may_use to ->bytes_reserved, in
btrfs_add_reserved_bytes() when reserving space.
But when freeing those space in btrfs_free_reserved_bytes(),
kernel does not convert space from ->bytes_reserved back to
->bytes_may_use, which triggers the above warning.

This patch solves it by converting space from ->bytes_reserved
back to ->bytes_may_use in btrfs_free_reserved_bytes().

Link: https://lore.kernel.org/all/0000000000002a909705eb841dda@google.com
Reported-by: syzbot+dde7e853812ed57835ea@syzkaller.appspotmail.com
Tested-by: syzbot+dde7e853812ed57835ea@syzkaller.appspotmail.com
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 fs/btrfs/block-group.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index deebc8ddbd93..1b573ab5514b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3414,6 +3414,10 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
 	cache->reserved -= num_bytes;
 	space_info->bytes_reserved -= num_bytes;
 	space_info->max_extent_size = 0;
+	trace_btrfs_space_reservation(cache->fs_info, "space_info",
+				      space_info->flags, -num_bytes, 1);
+	btrfs_space_info_update_bytes_may_use(cache->fs_info,
+					      space_info, num_bytes);
 
 	if (delalloc)
 		cache->delalloc_bytes -= num_bytes;
-- 
2.25.1

