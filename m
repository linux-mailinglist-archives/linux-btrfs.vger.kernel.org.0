Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D676D40CF
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Apr 2023 11:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjDCJj1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Apr 2023 05:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjDCJjC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Apr 2023 05:39:02 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E9991;
        Mon,  3 Apr 2023 02:38:02 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so29906019pjb.0;
        Mon, 03 Apr 2023 02:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680514682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNAgXqMmj56TaLm7xmgAGOCNUvI8dzfr8oOTTCo0p0s=;
        b=KxvyHxa4Y7VboMe4EHFPnTpbm/llcBdMwjHsck/VRiCsMU6vqDRqForTS81AfJxqHm
         4nEnF8Wn1rQgG/nG4DkkFdulwOPbcrRHNf/r06SoYZZrpnnEriFKkCFoHg8LhROvRDyO
         kzTuSWuVi0kA4WkRKYWuRXs+w8tCQMM9lcDMAz5dQLSnM2W2EK5/EIQMzZ3JiPZXtuAZ
         oskLcV2Txz+1qzjvss1BRw+2FvzOIRtNlqvCp9+CKqA2U577pzmLsLbjKyllYorCdDV5
         oB1458FAskNeWipWzGAOgHgz+BVdpV9jynoXCGUjkRVnaGcEH5YhOLo+4W5L0B/n9Kb9
         Uh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680514682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNAgXqMmj56TaLm7xmgAGOCNUvI8dzfr8oOTTCo0p0s=;
        b=HtXQb7CCqzSoBLPxeoeSScWqfIFEc6jJJ58TiOi/w7QwEOEYnjbPCdLblhlqTuLlat
         2HM0NP3PntsZnoUiSvRi6hqbS2e1Kw3Kxz7dQJDqKvBBAemyZRuSX/CctJtFzIKRbv6Z
         PhRcUKpgLBs9gs+Q/4rbAy7ShexYSb0bX78Eqz4mLoY6QeSb41TbZCDRxDVs8bJvxNWB
         eTMRdvB7sKg8pGVxDytFTjr2EIDDAuTKBcSksoz+PS1oWbVy6Sf1qtE08NmEF6QQb7cw
         GyF6+LWL7wXJ1Tvzvb8sztXswZBk2y2YJw1cUtSC6eMZBfzAwhTpwzHRqBM7eSvnLtSV
         /NLw==
X-Gm-Message-State: AAQBX9dAMezoo6Nt3PIn83LMRG1G9pYNH9WHYLKDNBUkYKPiuCXNY6yx
        D0EPKjab0h/Xi8vvfeJraYI=
X-Google-Smtp-Source: AKy350bPHFZepON/4iwCvD2X4qe3hUKg2IXqhyjipfIXti+sroYMfJozpJpzvM7RdWmUhu/VPwBdDw==
X-Received: by 2002:a17:90b:4a51:b0:23b:3939:9c50 with SMTP id lb17-20020a17090b4a5100b0023b39399c50mr37821322pjb.8.1680514681552;
        Mon, 03 Apr 2023 02:38:01 -0700 (PDT)
Received: from localhost.localdomain ([218.66.91.195])
        by smtp.gmail.com with ESMTPSA id jc17-20020a17090325d100b001a229e52c1asm6168230plb.231.2023.04.03.02.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 02:38:01 -0700 (PDT)
From:   xiaoshoukui <xiaoshoukui@gmail.com>
To:     dsterba@suse.cz
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoshoukui@ruijie.com.cn
Subject: Re: [PATCH] btrfs: ioctl: fix inaccurate determination of exclusive_operation
Date:   Mon,  3 Apr 2023 05:37:57 -0400
Message-Id: <20230403093757.120178-1-xiaoshoukui@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230331174533.GZ10580 () twin ! jikos ! cz>
References: <20230331174533.GZ10580 () twin ! jikos ! cz>
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

> Yeah I think the assertion should also check for NONE status. The paused
> balance makes the state tracking harder but in user-started (manual or
> scripted) commands it's typically not racing.

An assertion failure means that the code may not have taken careful consideration.
After I patched the BTRFS_EXCLOP_NONE to the assertion, regression tests shows that
another scenario I missed.

With started state == BTRFS_EXCLOP_BALANCE_PAUSED, cocurrently adding multiple devices
to the same mount point and btrfs_exclop_balance executed finish before the latter
thread execute assertion in btrfs_exclop_balance, exclusive_operation will changed to 
BTRFS_EXCLOP_BALANCE_PAUSED state. 

I also added btrfs_info before ASSERT to help troubleshooting:
> btrfs_info(fs_info, "fs_info exclusive_operation: %d",
>        fs_info->exclusive_operation);
> ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE ||
>        fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD ||
>        fs_info->exclusive_operation == BTRFS_EXCLOP_NONE);

Regression test log as follow:
The enum value of 1 correspond to BTRFS_EXCLOP_BALANCE_PAUSED:
root@syzkaller:/home/xsk# ./repro 
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
Failed to add de[  416.611428][ T7970] BTRFS info (device loop0): fs_info exclusive_operation: 0
vice /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
[  416.613973][ T7971] BTRFS info (device loop0): fs_info exclusive_operation: 3
Failed to add device /dev/vda, errno 14
[  416.615456][ T7972] BTRFS info (device loop0): fs_info exclusive_operation: 3
Failed to add device /dev/vda, errno 14
[  416.617528][ T7973] BTRFS info (device loop0): fs_info exclusive_operation: 3
Failed to add de[  416.618359][ T7974] BTRFS info (device loop0): fs_info exclusive_operation: 3
vice /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
[  416.622589][ T7975] BTRFS info (device loop0): fs_info exclusive_operation: 3
Failed to add device /dev/vda, e[  416.624034][ T7976] BTRFS info (device loop0): fs_info exclusive_operation: 3
rrno 14
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
Failed to add de[  416.637759][ T7984] assertion failed: fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE || fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD || fs_info->exclusive_operation == BTRFS_EXCLOP_NONE, in fs/btrfs/ioctl.c:458
vice /dev/vda, [e  416.639845][ T7984] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
rrno [1 4 416.640485][ T7984] CPU: 0 PID: 7984 Comm: repro Not tainted 6.2.0 #7
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


I think the assertion should also check for BTRFS_EXCLOP_BALANCE_PAUSED status.

