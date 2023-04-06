Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD826D8F7A
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 08:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjDFGeD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Apr 2023 02:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbjDFGeC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 02:34:02 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5409B30CD;
        Wed,  5 Apr 2023 23:34:01 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id le6so36638151plb.12;
        Wed, 05 Apr 2023 23:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680762841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bXYyia8veGY8STLiF3slmavJjZFmlm+w/hngDTjzZY0=;
        b=R3afHJBQ4HnkOUoJoR35NQQA3c1NoPaMxqm7+3AtPILkORwlkuH+DE6sRjsTyhAEc3
         qzqM6Wqt28kmoQYchcEpKGGjgzimzjbbacSZMoNBnf0RkA2xnG6SDCXv7jurAllddcu4
         /VrvbZfTXpCVvw3fZ/uvAq+HCU2ypmD40cFymwABMUwwkT+oVskc2Ha0wxsjNc89wNsM
         RUb9zGC8l16pPRufdk9dz/xYsMEmH6b30B7naRNcfMBzu2i/7OzweOwRkw9jyMW21Rr8
         ExwvFS73g6p6bH/Xb79DrQ+ZQObMhMgRFvSr2nuSw9BqQx1azWgkgkhzuqbDUomgWsLF
         THVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680762841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXYyia8veGY8STLiF3slmavJjZFmlm+w/hngDTjzZY0=;
        b=q1FBmIDFkS7DnAVB77kdbVABG9ysbj4qxkHi4qKubDbtkwJCfJmef1DuLuo29uwYl+
         xhtwwg8ASzdtoc8n8C1v+JyR4EubHGXIsH+owHt1xwu3aPku1+8vtaq170erCDcAy6NF
         qxEgVuKmJsxNdytkBb9mUovFehK6eNiZX3CAxAKxrricl5XbebxdE1u1tRwZxNsgnGr9
         7HS2gwflQFuVxg/C/KXhc2DrQYWm87Ioc6j/n4dSjZ8wDqWBZm2jmi0lnqanP/CBFFvI
         fqrGYhmqhMK3F9aRnfXlvloPGwQMl4lrBQRgCgTYx1gSXCJSFQ+C7Ilbmcbx3hMrbu1/
         rQAw==
X-Gm-Message-State: AAQBX9eALFLxWBl+1qNmqbyTQJ8+THSs39aCIK/GQjqycavaFfzB8tAN
        MFae42kt7/3NYIvM6n831IQ=
X-Google-Smtp-Source: AKy350Y6jJgwLrz2fyYPXQEcJzECbnqI4olEBQaCgpQ7EdrF4tZ3/YyrtiUOSpt6L+zA9+DGxPjTcw==
X-Received: by 2002:a17:902:da86:b0:19f:31c5:1848 with SMTP id j6-20020a170902da8600b0019f31c51848mr10481523plx.27.1680762840754;
        Wed, 05 Apr 2023 23:34:00 -0700 (PDT)
Received: from localhost.localdomain ([218.66.91.195])
        by smtp.gmail.com with ESMTPSA id kp6-20020a170903280600b00192fe452e17sm595896plb.162.2023.04.05.23.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 23:34:00 -0700 (PDT)
From:   xiaoshoukui <xiaoshoukui@gmail.com>
To:     dsterba@suse.cz
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoshoukui@ruijie.com.cn, xiaoshoukui <xiaoshoukui@gmail.com>
Subject: [PATCH] btrfs: ioctl: fix assertion compatible sets when cocurrently adding multiple devices
Date:   Thu,  6 Apr 2023 02:32:55 -0400
Message-Id: <20230406063255.126375-1-xiaoshoukui@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

ASSERT in btrfs_exclop_balance should also check for NONE and
BALANCE_PAUSED status.

Scenario 1: With exclusive_operation state == BTRFS_EXCLOP_NONE.
Cocurrently adding multiple devices to the same mount point and
btrfs_exclop_finish executed finish before assertion in
btrfs_exclop_balance, exclusive_operation will changed to
BTRFS_EXCLOP_NONE state which lead to assertion failed:
fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE ||
fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD,
in fs/btrfs/ioctl.c:456
Call Trace:
 <TASK>
 btrfs_exclop_balance+0x13c/0x310
 ? memdup_user+0xab/0xc0
 ? PTR_ERR+0x17/0x20
 btrfs_ioctl_add_dev+0x2ee/0x320
 btrfs_ioctl+0x9d5/0x10d0
 ? btrfs_ioctl_encoded_write+0xb80/0xb80
 __x64_sys_ioctl+0x197/0x210
 do_syscall_64+0x3c/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Scenario 2: With exclusive_operation state == BTRFS_EXCLOP_BALANCE_PAUSED.
Cocurrently adding multiple devices to the same mount point and
btrfs_exclop_balance executed finish before the latter thread execute
assertion in btrfs_exclop_balance, exclusive_operation will changed to
BTRFS_EXCLOP_BALANCE_PAUSED state which lead to assertion failed:
fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE ||
fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD ||
fs_info->exclusive_operation == BTRFS_EXCLOP_NONE,
fs/btrfs/ioctl.c:458
Call Trace:
 <TASK>
 btrfs_exclop_balance+0x240/0x410
 ? memdup_user+0xab/0xc0
 ? PTR_ERR+0x17/0x20
 btrfs_ioctl_add_dev+0x2ee/0x320
 btrfs_ioctl+0x9d5/0x10d0
 ? btrfs_ioctl_encoded_write+0xb80/0xb80
 __x64_sys_ioctl+0x197/0x210
 do_syscall_64+0x3c/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Analyzed-by: xiaoshoukui <xiaoshoukui@ruijie.com.cn>
Link: https://lore.kernel.org/linux-btrfs/20230404191042.GE19619@suse.cz/T/#t
Signed-off-by: xiaoshoukui <xiaoshoukui@ruijie.com.cn>
---
 fs/btrfs/ioctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a0ef1a1784c7..7df80b37bc44 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -454,7 +454,9 @@ void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
 	case BTRFS_EXCLOP_BALANCE_PAUSED:
 		spin_lock(&fs_info->super_lock);
 		ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE ||
-		       fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD);
+		       fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD ||
+		       fs_info->exclusive_operation == BTRFS_EXCLOP_NONE ||
+		       fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED);
 		fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE_PAUSED;
 		spin_unlock(&fs_info->super_lock);
 		break;
-- 
2.20.1

