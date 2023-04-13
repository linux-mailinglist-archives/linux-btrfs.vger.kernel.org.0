Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9971C6E0ACC
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 11:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjDMJ4I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Apr 2023 05:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjDMJ4G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Apr 2023 05:56:06 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE01359C3;
        Thu, 13 Apr 2023 02:55:56 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id v9so19892965pjk.0;
        Thu, 13 Apr 2023 02:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681379756; x=1683971756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JkYnwT/pcVe6i+b6BzuOisve+wqYzTNYCZZQmpRtWUw=;
        b=TRUbEE+G5eEBa4SIipvw0FAFD4FMppVgwzjtwZhM1J89s0JPY8Xp4o49YptuZWdHHM
         XZYqoivG7eWoqATHK5N1EqYute0F02qUwukBkI2hcDijgFUEcUodKpERBU8X0N3lnyhJ
         KYnP765medPL371O4Eiw8VQFj6ltw6znLumRQ+H+DMFbvAuTvbiD6vHQSyH1ANlenUqn
         7uzFn1PIZg7G2t+BAC0oHBJlvZck6R631shLpG1gpvlFpUKIajHOj73we17XJ77jgJXD
         OYz78lXq264d2OFmDvdXIkS4t762AFkaVJf8D/XJj2GJtmuAdpn1zewd5EvBPPH9ROdh
         xTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681379756; x=1683971756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JkYnwT/pcVe6i+b6BzuOisve+wqYzTNYCZZQmpRtWUw=;
        b=MdsTNFI8wtqC1Z5dBdFB4gmT72DbCGoN4UEYENs6kQSv78qV2tT1oEFq111agj8wYn
         SnhhEPXUp+4gpRvmUVpHUDVakBKFDuEEnSbfQ1jp7emO52KkVJ3P4IUJtb/OKz4sMTRK
         wTCn3Eh/uOa1QntWRNFX3ESQgbymD2vPs7NJo5G+x6v9pPK5DExOJnlOG7kzeSsOzv6E
         S68ViU3+mQZz/rfvXr0wisK57xCgFNw56YYHtUyFmTwS1AmkJQ1d9+0SGph/1HhDqjJ0
         WDqGjkvtIqLb/vJzT4fndlTThMdyTfEcuIR5mYxQXnp1mJT7kIjSLPk9cg79HXQCXAaH
         PRvA==
X-Gm-Message-State: AAQBX9crnB1HuKcbIvXY55M4AeCqMZ18Bg6FPxlRiZu+oGq5C9v9L6Hi
        N5MMdevIZap9MjRddUR3D0Zg8kgQhEI+YN0L
X-Google-Smtp-Source: AKy350a9iV8h5dAeIa71Io3uVIHmu63Bo7w5PY0EAae8QkiF2hFH1ZALlBfK50rsz9b4Vo2CIXSkUw==
X-Received: by 2002:a17:903:120d:b0:1a1:cf70:33c0 with SMTP id l13-20020a170903120d00b001a1cf7033c0mr1794747plh.33.1681379756323;
        Thu, 13 Apr 2023 02:55:56 -0700 (PDT)
Received: from localhost.localdomain ([218.66.91.195])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c20400b001a559271f12sm1091752pll.173.2023.04.13.02.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 02:55:56 -0700 (PDT)
From:   xiaoshoukui <xiaoshoukui@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoshoukui <xiaoshoukui@gmail.com>,
        xiaoshoukui <xiaoshoukui@ruijie.com.cn>
Subject: [PATCH v2] btrfs: ioctl: ASSERT in btrfs_exclop_balance should also check for NONE and BALANCE PAUSED status.
Date:   Thu, 13 Apr 2023 05:55:07 -0400
Message-Id: <20230413095507.10620-1-xiaoshoukui@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Cocurrently issue add device requests, btrfs_exclop_balance in
btrfs_ioctl_add_dev can race to btrfs_exclop_finish or itself.

Link: https://lore.kernel.org/linux-btrfs/20230324031611.98986-1-xiaoshoukui@gmail.com/

---
Changelog:
v2: Add check for NONE and btrfs_info.
> btrfs_info(fs_info, "fs_info exclusive_operation: %d",
> fs_info->exclusive_operation);
> ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE ||
> fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD ||
> fs_info->exclusive_operation == BTRFS_EXCLOP_NONE);
Stack traces: 
root@syzkaller:/home/xsk# ./repro 
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
[  416.611428][ T7970] BTRFS info (device loop0): fs_info exclusive_operation: 0
Failed to add device /dev/vda, errno 14
[  416.613973][ T7971] BTRFS info (device loop0): fs_info exclusive_operation: 3
Failed to add device /dev/vda, errno 14
[  416.615456][ T7972] BTRFS info (device loop0): fs_info exclusive_operation: 3
Failed to add device /dev/vda, errno 14
[  416.617528][ T7973] BTRFS info (device loop0): fs_info exclusive_operation: 3
Failed to add device /dev/vda, errno 14
[  416.618359][ T7974] BTRFS info (device loop0): fs_info exclusive_operation: 3
Failed to add device /dev/vda, errno 14
[  416.622589][ T7975] BTRFS info (device loop0): fs_info exclusive_operation: 3
Failed to add device /dev/vda, errno 14
[  416.624034][ T7976] BTRFS info (device loop0): fs_info exclusive_operation: 3
Failed to add device /dev/vda, errno 14
[  416.626420][ T7977] BTRFS info (device loop0): fs_info exclusive_operation: 3
Failed to add device /dev/vda, errno 14
[  416.627643][ T7978] BTRFS info (device loop0): fs_info exclusive_operation: 3
Failed to add device /dev/vda, errno 14
[  416.629006][ T7979] BTRFS info (device loop0): fs_info exclusive_operation: 3
[  416.630298][ T7980] BTRFS info (device loop0): fs_info exclusive_operation: 3
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
[  416.632787][ T7981] BTRFS info (device loop0): fs_info exclusive_operation: 3
Failed to add device /dev/vda, errno 14
[  416.634282][ T7982] BTRFS info (device loop0): fs_info exclusive_operation: 3
Failed to add device /dev/vda, errno 14
[  416.636202][ T7983] BTRFS info (device loop0): fs_info exclusive_operation: 3
[  416.637012][ T7984] BTRFS info (device loop0): fs_info exclusive_operation: 1
Failed to add device /dev/vda, errno 14
[  416.637759][ T7984] assertion failed: fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE || fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD || fs_info->exclusive_operation == BTRFS_EXCLOP_NONE, in fs/btrfs/ioctl.c:458
[  416.639845][ T7984] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
[  416.640485][ T7984] CPU: 0 PID: 7984 Comm: repro Not tainted 6.2.0 #7
[  416.641172][ T7984] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  416.642090][ T7984] RIP: 0010:btrfs_assertfail+0x2c/0x2e
[  416.642629][ T7984] Code: 1f 00 41 55 41 89 d5 41 54 49 89 f4 55 48 89 fd e8 b9 84 e8 f7 44 89 e9 4c 89 e2 48 89 ee 48 c7 c7 c0 af 54 8a e8 cb 49 f3 ff <0f> 0b 66 0f 1f 00 55 48 89 fd e8 95 84 e8 f7 48 89 ef 5d 48 c7 c6
[  416.644423][ T7984] RSP: 0018:ffffc90003ea7e28 EFLAGS: 00010282
[  416.645018][ T7984] RAX: 00000000000000cc RBX: 0000000000000000 RCX: 0000000000000000
[  416.645763][ T7984] RDX: ffff88801d030000 RSI: ffffffff81637e7c RDI: fffff520007d4fb7
[  416.646554][ T7984] RBP: ffffffff8a533de0 R08: 00000000000000cc R09: 0000000000000000
[  416.647299][ T7984] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8a533da0
[  416.648041][ T7984] R13: 00000000000001ca R14: 000000005000940a R15: 0000000000000000
[  416.648785][ T7984] FS:  00007fa2985d4640(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
[  416.649616][ T7984] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  416.650238][ T7984] CR2: 0000000000000000 CR3: 0000000018e5e000 CR4: 0000000000750ef0
[  416.650980][ T7984] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  416.651725][ T7984] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  416.652502][ T7984] PKRU: 55555554
[  416.652888][ T7984] Call Trace:
[  416.653241][ T7984]  <TASK>
[  416.653527][ T7984]  btrfs_exclop_balance+0x240/0x410
[  416.654036][ T7984]  ? memdup_user+0xab/0xc0
[  416.654465][ T7984]  ? PTR_ERR+0x17/0x20
[  416.654874][ T7984]  btrfs_ioctl_add_dev+0x2ee/0x320
[  416.655380][ T7984]  btrfs_ioctl+0x9d5/0x10d0
[  416.655822][ T7984]  ? btrfs_ioctl_encoded_write+0xb80/0xb80
[  416.656400][ T7984]  __x64_sys_ioctl+0x197/0x210
[  416.656874][ T7984]  do_syscall_64+0x3c/0xb0
[  416.657346][ T7984]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  416.657922][ T7984] RIP: 0033:0x4546af
[  416.658304][ T7984] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28 00
[  416.660170][ T7984] RSP: 002b:00007fa2985d4150 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  416.660972][ T7984] RAX: ffffffffffffffda RBX: 00007fa2985d4640 RCX: 00000000004546af
[  416.661714][ T7984] RDX: 0000000000000000 RSI: 000000005000940a RDI: 0000000000000003
[  416.662449][ T7984] RBP: 00007fa2985d41d0 R08: 0000000000000000 R09: 00007ffee37a4c4f
[  416.663195][ T7984] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa2985d4640
[  416.663951][ T7984] R13: 0000000000000009 R14: 000000000041b320 R15: 00007fa297dd4000
[  416.664703][ T7984]  </TASK>
[  416.665040][ T7984] Modules linked in:
[  416.665590][ T7984] ---[ end trace 0000000000000000 ]---
[  416.666176][ T7984] RIP: 0010:btrfs_assertfail+0x2c/0x2e
[  416.666774][ T7984] Code: 1f 00 41 55 41 89 d5 41 54 49 89 f4 55 48 89 fd e8 b9 84 e8 f7 44 89 e9 4c 89 e2 48 89 ee 48 c7 c7 c0 af 54 8a e8 cb 49 f3 ff <0f> 0b 66 0f 1f 00 55 48 89 fd e8 95 84 e8 f7 48 89 ef 5d 48 c7 c6
[  416.668775][ T7984] RSP: 0018:ffffc90003ea7e28 EFLAGS: 00010282
[  416.669425][ T7984] RAX: 00000000000000cc RBX: 0000000000000000 RCX: 0000000000000000
[  416.670235][ T7984] RDX: ffff88801d030000 RSI: ffffffff81637e7c RDI: fffff520007d4fb7
[  416.671050][ T7984] RBP: ffffffff8a533de0 R08: 00000000000000cc R09: 0000000000000000
[  416.671867][ T7984] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8a533da0
[  416.672685][ T7984] R13: 00000000000001ca R14: 000000005000940a R15: 0000000000000000
[  416.673501][ T7984] FS:  00007fa2985d4640(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
[  416.674425][ T7984] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  416.675114][ T7984] CR2: 0000000000000000 CR3: 0000000018e5e000 CR4: 0000000000750ef0
[  416.675933][ T7984] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  416.676760][ T7984] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  416.677544][ T7984] PKRU: 55555554
[  416.677885][ T7984] Kernel panic - not syncing: Fatal exception
[  416.678592][ T7984] Kernel Offset: disabled
[  416.679008][ T7984] Rebooting in 86400 seconds..


v1: Didn't check for NONE and BTRFS_EXCLOP_BALANCE_PAUSED status.
Stack traces: 
root@syzkaller:/home/xsk# ./repro 
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
[   69.838916][ T8108] assertion failed: fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE || fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD, in fs/btrfs/ioctl.c:456
[   69.840759][ T8108] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
[   69.841461][ T8108] CPU: 0 PID: 8108 Comm: repro Not tainted 6.2.0 #5
[   69.842245][ T8108] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[   69.843292][ T8108] RIP: 0010:btrfs_assertfail+0x2c/0x2e
[   69.843899][ T8108] Code: 1f 00 41 55 41 89 d5 41 54 49 89 f4 55 48 89 fd e8 b9 84 e8 f7 44 89 e9 4c 89 e2 48 89 ee 48 c7 c7 20 af 54 8a e8 cb 49 f3 ff <0f> 0b 66 0f 1f 00 55 48 89 fd e8 95 84 e8 f7 48 89 ef 5d 48 c7 c6
[   69.845934][ T8108] RSP: 0018:ffffc90005f1fe28 EFLAGS: 00010282
[   69.846588][ T8108] RAX: 0000000000000097 RBX: 0000000000000000 RCX: 0000000000000000
[   69.847426][ T8108] RDX: ffff88801e8b2440 RSI: ffffffff81637e7c RDI: fffff52000be3fb7
[   69.848267][ T8108] RBP: ffffffff8a533d80 R08: 0000000000000097 R09: 0000000000000000
[   69.849103][ T8108] R10: 0000000080000001 R11: 0000000000000001 R12: ffffffff8a533d40
[   69.849945][ T8108] R13: 00000000000001c8 R14: 000000005000940a R15: 0000000000000000
[   69.850792][ T8108] FS:  00007ff3e2004640(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
[   69.851747][ T8108] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   69.852457][ T8108] CR2: 0000000000000000 CR3: 00000000182c8000 CR4: 0000000000750ef0
[   69.853311][ T8108] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   69.854167][ T8108] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   69.854935][ T8108] PKRU: 55555554
[   69.855263][ T8108] Call Trace:
[   69.855575][ T8108]  <TASK>
[   69.855851][ T8108]  btrfs_exclop_balance+0x13c/0x310
[   69.856337][ T8108]  ? memdup_user+0xab/0xc0
[   69.856749][ T8108]  ? PTR_ERR+0x17/0x20
[   69.857138][ T8108]  btrfs_ioctl_add_dev+0x2ee/0x320
[   69.857716][ T8108]  btrfs_ioctl+0x9d5/0x10d0
[   69.858222][ T8108]  ? btrfs_ioctl_encoded_write+0xb80/0xb80
[   69.858801][ T8108]  __x64_sys_ioctl+0x197/0x210
[   69.859253][ T8108]  do_syscall_64+0x3c/0xb0
[   69.859668][ T8108]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   69.860217][ T8108] RIP: 0033:0x4546af
[   69.860582][ T8108] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28 00
[   69.862533][ T8108] RSP: 002b:00007ff3e2004150 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   69.863299][ T8108] RAX: ffffffffffffffda RBX: 00007ff3e2004640 RCX: 00000000004546af
[   69.864025][ T8108] RDX: 0000000000000000 RSI: 000000005000940a RDI: 0000000000000003
[   69.864739][ T8108] RBP: 00007ff3e20041d0 R08: 0000000000000000 R09: 00007ffd746cf81f
[   69.865528][ T8108] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff3e2004640
[   69.866375][ T8108] R13: 0000000000000009 R14: 000000000041b320 R15: 00007ff3e1804000
[   69.867115][ T8108]  </TASK>
[   69.867411][ T8108] Modules linked in:
[   69.867888][ T8108] ---[ end trace 0000000000000000 ]---
[   69.868392][ T8108] RIP: 0010:btrfs_assertfail+0x2c/0x2e
[   69.868901][ T8108] Code: 1f 00 41 55 41 89 d5 41 54 49 89 f4 55 48 89 fd e8 b9 84 e8 f7 44 89 e9 4c 89 e2 48 89 ee 48 c7 c7 20 af 54 8a e8 cb 49 f3 ff <0f> 0b 66 0f 1f 00 55 48 89 fd e8 95 84 e8 f7 48 89 ef 5d 48 c7 c6
[   69.870857][ T8108] RSP: 0018:ffffc90005f1fe28 EFLAGS: 00010282
[   69.871422][ T8108] RAX: 0000000000000097 RBX: 0000000000000000 RCX: 0000000000000000
[   69.872148][ T8108] RDX: ffff88801e8b2440 RSI: ffffffff81637e7c RDI: fffff52000be3fb7
[   69.872866][ T8108] RBP: ffffffff8a533d80 R08: 0000000000000097 R09: 0000000000000000
[   69.873681][ T8108] R10: 0000000080000001 R11: 0000000000000001 R12: ffffffff8a533d40
[   69.874530][ T8108] R13: 00000000000001c8 R14: 000000005000940a R15: 0000000000000000
[   69.875270][ T8108] FS:  00007ff3e2004640(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
[   69.876084][ T8108] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   69.876681][ T8108] CR2: 0000000000000000 CR3: 00000000182c8000 CR4: 0000000000750ef0
[   69.877464][ T8108] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   69.878317][ T8108] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   69.879062][ T8108] PKRU: 55555554
[   69.879400][ T8108] Kernel panic - not syncing: Fatal exception
[   69.880096][ T8108] Kernel Offset: disabled
[   69.880563][ T8108] Rebooting in 86400 seconds..

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
-                      fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD);
+                      fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD ||
+                      fs_info->exclusive_operation == BTRFS_EXCLOP_NONE ||
+                      fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED);
                fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE_PAUSED;
                spin_unlock(&fs_info->super_lock);
                break;
-- 
2.20.1
