Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE21161E283
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Nov 2022 15:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiKFOKV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Nov 2022 09:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiKFOKU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Nov 2022 09:10:20 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307E5B1DA;
        Sun,  6 Nov 2022 06:10:19 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u24so13839573edd.13;
        Sun, 06 Nov 2022 06:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9e1fyhXvm0pk13BkZMiIDIZC+79uUYOhS5Nj5QHWCZE=;
        b=oq2uKZpwOu8cSevnse/Vb5ZJeBw6WZLGbVwHov+1lJDuxTIPYgnNOG4uGAyVJLIjWt
         OD1JiQXOAMW+y55QAw15rWuQWZT2E0VDsy42GeH+XbJeFFWLETJpAa0ovdY7u1t11nYX
         Zgc0kGY1rEdf4pT9SEffMTaUYBRKfnz7h6HIfVg/oMvEbmPioMWlALMtWOpupskCtw+U
         IDSrerm3I7QxeRbSeF1kRFQ60JxUfchdOUB7RrgDWY4M/Uu/ROnZeIuUGFHrh5EcI229
         +2KEMVbmVz2ApBw2fs7VonqwZYM8Rn49BP86OXs3civrsLUYBHd6uZ5lmSdwhbttHqNr
         pR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9e1fyhXvm0pk13BkZMiIDIZC+79uUYOhS5Nj5QHWCZE=;
        b=W81L8eLMKBu20louV/Icb+lbYy9bUmMMvAFdHRz6NbAM7bnBjF6hC6a9oqc4aao8MC
         6N/1lhn4nFSo1ynUumCJ7nNxG5hJjqgAeERgoZhK+jpMfiul8xI11IRHGBOuhmRjXsaz
         4/r+dklazx/Gkwepjdkc3Xbj4CmBprWi7YYZCRm1gMG4Sz+zbsgVD09W6Xs5CddCTrap
         5Pb/Y/RD39Fej01A6ts0PdnXraZADTpdhIEPhbmPOnpNGcg+59cY2vm7Fr4PWsTQp1Vw
         pDgxBZPzYj1hqBmCcOXXxpA+NFOWpLYlkqd7o7FXCCPbC78HPKnIAjnn0Yas+bD7c8N/
         s05Q==
X-Gm-Message-State: ACrzQf0c0rWRywuE+6+uLock0P5GnrB5ZpyQvIIDW/R5fn/vZLBIjesM
        VtS5J46HaD7Z+ILc9KPyenFnZWrLU5g0hfnYEmPED3VZ0P8=
X-Google-Smtp-Source: AMsMyM4a3GvLuaEEXEmb4GlI1yi/NoEOrPVX8Q5KIEK6JwzTVMuYv+mSxGKeVoVY43TsrsUb7Z9Cc96RiM1Z0h8sQXE=
X-Received: by 2002:aa7:d341:0:b0:464:778:c3fe with SMTP id
 m1-20020aa7d341000000b004640778c3femr24063717edr.251.1667743817432; Sun, 06
 Nov 2022 06:10:17 -0800 (PST)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 6 Nov 2022 22:09:42 +0800
Message-ID: <CAO4mrfe5feJxTErVXHO0T5oikckxEx8JOw-qQFefKp55Bh_4iw@mail.gmail.com>
Subject: WARNING in btrfs_quota_enable
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was
triggered. The bug persists in Linux 6.0.

HEAD commit: 4f5365f77018 Linux 5.15.76
git tree: stable
compiler: gcc 7.5.0
console output:
https://drive.google.com/file/d/1jbEJTcn-e-hkrpVGYqA0168AEYHGMFYR/view?usp=share_link
kernel config: https://drive.google.com/file/d/1flhc33savDkmYN6PRU5C2vXDX0LAKMvM/view?usp=share_link
C reproducer: https://drive.google.com/file/d/1VKO-bIWJcfkq1U5R_-YjwAz6uytPCUsw/view?usp=share_link
Syz reproducer:
https://drive.google.com/file/d/1C3DveQax7PoJ4rJ67tHddVYUbWSvTm7m/view?usp=share_link

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

[  196.112397][ T8633] WARNING: CPU: 0 PID: 8633 at
fs/btrfs/qgroup.c:1026 btrfs_quota_enable+0x1bfb/0x2320
[  196.116525][ T8633] Modules linked in:
[  196.118128][ T8633] CPU: 0 PID: 8633 Comm: a.out Not tainted 6.0.0 #38
[  196.118608][ T8633] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  196.121470][ T8633] RIP: 0010:btrfs_quota_enable+0x1bfb/0x2320
[  196.121899][ T8633] Code: e7 8a 48 8b 54 24 20 31 c0 e8 06 78 9a 06
4c 8b 7c 24 58 eb 17 e8 e5 5c f8 fd 48 c7 c7 e0 3d e7 8a 89 de 31 c0
e8 65 d7 c1 fd <0f> 0b 48 8b 7c 24 18 48 c7 c6 80 3e e7 8a ba 02 04 00
00 4c 8b 74
[  196.127785][ T8633] RSP: 0018:ffffc9000b00f620 EFLAGS: 00010246
[  196.128190][ T8633] RAX: e82232a3d1ff4300 RBX: fffffffffffffff4
RCX: ffff88801bf5a440
[  196.128710][ T8633] RDX: 0000000000000000 RSI: 0000000080000000
RDI: 0000000000000000
[  196.132528][ T8633] RBP: ffffc9000b00f830 R08: ffffffff816b75fc
R09: ffffed100c784f14
[  196.133074][ T8633] R10: ffffed100c784f14 R11: 0000000000000000
R12: ffff88802c5457d8
[  196.135472][ T8633] R13: ffff88802ca17980 R14: 1ffff11005942f30
R15: 1ffff92001601edc
[  196.138552][ T8633] FS:  00007fda5da0b700(0000)
GS:ffff888063c00000(0000) knlGS:0000000000000000
[  196.139137][ T8633] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  196.141095][ T8633] CR2: 00007f84f55d0000 CR3: 000000002b93c000
CR4: 0000000000750ef0
[  196.141614][ T8633] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[  196.143261][ T8633] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[  196.143797][ T8633] PKRU: 55555554
[  196.144035][ T8633] Call Trace:
[  196.144262][ T8633]  <TASK>
[  196.144751][ T8633]  ? read_lock_is_recursive+0x10/0x10
[  196.145152][ T8633]  ? __del_qgroup_rb+0x600/0x600
[  196.145487][ T8633]  ? __might_fault+0xb6/0x110
[  196.149333][ T8633]  ? rcu_read_lock_sched_held+0x87/0x110
[  196.149729][ T8633]  ? __lock_acquire+0x6080/0x6080
[  196.150066][ T8633]  ? rcu_read_lock_any_held+0xb1/0x130
[  196.151589][ T8633]  ? down_write+0x10d/0x170
[  196.151890][ T8633]  ? down_read_killable+0x80/0x80
[  196.152226][ T8633]  ? __might_fault+0xb2/0x110
[  196.152544][ T8633]  ? _copy_from_user+0x106/0x160
[  196.155487][ T8633]  btrfs_ioctl+0x6077/0x9db0
[  196.155798][ T8633]  ? kfree+0xda/0x350
[  196.156075][ T8633]  ? kasan_set_track+0x4f/0x60
[  196.156399][ T8633]  ? kasan_set_track+0x3d/0x60
[  196.160352][ T8633]  ? kasan_set_free_info+0x1f/0x40
[  196.160740][ T8633]  ? ____kasan_slab_free+0xd8/0x120
[  196.161087][ T8633]  ? slab_free_freelist_hook+0x12e/0x1a0
[  196.162586][ T8633]  ? kfree+0xda/0x350
[  196.162918][ T8633]  ? tomoyo_path_number_perm+0x5be/0x790
[  196.163296][ T8633]  ? security_file_ioctl+0x55/0xb0
[  196.164763][ T8633]  ? __se_sys_ioctl+0x48/0x170
[  196.165093][ T8633]  ? do_syscall_64+0x3d/0x90
[  196.165402][ T8633]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  196.169938][ T8633]  ? btrfs_ioctl_get_supported_features+0x40/0x40
[  196.170398][ T8633]  ? lockdep_hardirqs_on_prepare+0x428/0x790
[  196.170806][ T8633]  ? rcu_read_lock_sched_held+0x87/0x110
[  196.172301][ T8633]  ? __bpf_trace_rcu_stall_warning+0x10/0x10
[  196.172722][ T8633]  ? lockdep_hardirqs_on_prepare+0x428/0x790
[  196.173125][ T8633]  ? do_vfs_ioctl+0xc35/0x29e0
[  196.174572][ T8633]  ? __ia32_compat_sys_ioctl+0xb90/0xb90
[  196.174965][ T8633]  ? __lock_acquire+0x6080/0x6080
[  196.175301][ T8633]  ? slab_free_freelist_hook+0x12e/0x1a0
[  196.178710][ T8633]  ? tomoyo_path_number_perm+0x5be/0x790
[  196.179122][ T8633]  ? kfree+0xda/0x350
[  196.179392][ T8633]  ? tomoyo_path_number_perm+0x627/0x790
[  196.180886][ T8633]  ? tomoyo_check_path_acl+0x1c0/0x1c0
[  196.181263][ T8633]  ? rcu_read_lock_sched_held+0x87/0x110
[  196.181647][ T8633]  ? lockdep_hardirqs_on_prepare+0x428/0x790
[  196.183052][ T8633]  ? print_irqtrace_events+0x220/0x220
[  196.184574][ T8633]  ? vtime_user_exit+0x2b2/0x3e0
[  196.184916][ T8633]  ? __ct_user_exit+0xd9/0x160
[  196.185239][ T8633]  ? bpf_lsm_file_ioctl+0x5/0x10
[  196.185570][ T8633]  ? security_file_ioctl+0x9d/0xb0
[  196.190343][ T8633]  ? btrfs_ioctl_get_supported_features+0x40/0x40
[  196.190782][ T8633]  __se_sys_ioctl+0xfb/0x170
[  196.191099][ T8633]  do_syscall_64+0x3d/0x90
[  196.192509][ T8633]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  196.192904][ T8633] RIP: 0033:0x7fda5cee4469
[  196.193209][ T8633] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f
1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8
64 89 01 48
[  196.195738][ T8633] RSP: 002b:00007ffd27fd1dc8 EFLAGS: 00000206
ORIG_RAX: 0000000000000010
[  196.196277][ T8633] RAX: ffffffffffffffda RBX: 0000000000000000
RCX: 00007fda5cee4469
[  196.198914][ T8633] RDX: 0000000020000180 RSI: 00000000c0109428
RDI: 0000000000000006
[  196.199425][ T8633] RBP: 00007ffd27fd1de0 R08: 0000000000000002
R09: 00007ffd27fd1de0
[  196.199985][ T8633] R10: 0000000000000001 R11: 0000000000000206
R12: 0000559da6401170
[  196.200504][ T8633] R13: 00007ffd27fd1f20 R14: 0000000000000000
R15: 0000000000000000
[  196.201068][ T8633]  </TASK>
[  196.201291][ T8633] Kernel panic - not syncing: panic_on_warn set ...
[  196.201722][ T8633] CPU: 0 PID: 8633 Comm: a.out Not tainted 6.0.0 #38
[  196.202159][ T8633] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  196.202813][ T8633] Call Trace:
[  196.203044][ T8633]  <TASK>
[  196.203240][ T8633]  dump_stack_lvl+0x1b1/0x28e
[  196.203550][ T8633]  ? io_alloc_page_table+0xfe/0xfe
[  196.203882][ T8633]  ? panic+0x81b/0x81b
[  196.204153][ T8633]  ? btrfs_quota_enable+0x1bb0/0x2320
[  196.204501][ T8633]  panic+0x2c2/0x81b
[  196.204762][ T8633]  ? __warn+0x131/0x220
[  196.205036][ T8633]  ? asan.module_ctor+0x4/0x4
[  196.205350][ T8633]  ? btrfs_quota_enable+0x1bfb/0x2320
[  196.205780][ T8633]  __warn+0x1fc/0x220
[  196.206137][ T8633]  ? btrfs_quota_enable+0x1bfb/0x2320
[  196.206610][ T8633]  report_bug+0x1b3/0x2d0
[  196.207013][ T8633]  handle_bug+0x3d/0x70
[  196.207384][ T8633]  exc_invalid_op+0x16/0x40
[  196.207782][ T8633]  asm_exc_invalid_op+0x16/0x20
[  196.208214][ T8633] RIP: 0010:btrfs_quota_enable+0x1bfb/0x2320
[  196.208727][ T8633] Code: e7 8a 48 8b 54 24 20 31 c0 e8 06 78 9a 06
4c 8b 7c 24 58 eb 17 e8 e5 5c f8 fd 48 c7 c7 e0 3d e7 8a 89 de 31 c0
e8 65 d7 c1 fd <0f> 0b 48 8b 7c 24 18 48 c7 c6 80 3e e7 8a ba 02 04 00
00 4c 8b 74
[  196.210340][ T8633] RSP: 0018:ffffc9000b00f620 EFLAGS: 00010246
[  196.210874][ T8633] RAX: e82232a3d1ff4300 RBX: fffffffffffffff4
RCX: ffff88801bf5a440
[  196.211550][ T8633] RDX: 0000000000000000 RSI: 0000000080000000
RDI: 0000000000000000
[  196.212225][ T8633] RBP: ffffc9000b00f830 R08: ffffffff816b75fc
R09: ffffed100c784f14
[  196.212906][ T8633] R10: ffffed100c784f14 R11: 0000000000000000
R12: ffff88802c5457d8
[  196.213582][ T8633] R13: ffff88802ca17980 R14: 1ffff11005942f30
R15: 1ffff92001601edc
[  196.214167][ T8633]  ? __wake_up_klogd+0xcc/0x100
[  196.214491][ T8633]  ? read_lock_is_recursive+0x10/0x10
[  196.214843][ T8633]  ? __del_qgroup_rb+0x600/0x600
[  196.215181][ T8633]  ? __might_fault+0xb6/0x110
[  196.215484][ T8633]  ? rcu_read_lock_sched_held+0x87/0x110
[  196.215847][ T8633]  ? __lock_acquire+0x6080/0x6080
[  196.216180][ T8633]  ? rcu_read_lock_any_held+0xb1/0x130
[  196.216533][ T8633]  ? down_write+0x10d/0x170
[  196.216831][ T8633]  ? down_read_killable+0x80/0x80
[  196.217155][ T8633]  ? __might_fault+0xb2/0x110
[  196.217462][ T8633]  ? _copy_from_user+0x106/0x160
[  196.217783][ T8633]  btrfs_ioctl+0x6077/0x9db0
[  196.218117][ T8633]  ? kfree+0xda/0x350
[  196.218489][ T8633]  ? kasan_set_track+0x4f/0x60
[  196.218827][ T8633]  ? kasan_set_track+0x3d/0x60
[  196.219127][ T8633]  ? kasan_set_free_info+0x1f/0x40
[  196.219446][ T8633]  ? ____kasan_slab_free+0xd8/0x120
[  196.219830][ T8633]  ? slab_free_freelist_hook+0x12e/0x1a0
[  196.220258][ T8633]  ? kfree+0xda/0x350
[  196.220585][ T8633]  ? tomoyo_path_number_perm+0x5be/0x790
[  196.220934][ T8633]  ? security_file_ioctl+0x55/0xb0
[  196.221251][ T8633]  ? __se_sys_ioctl+0x48/0x170
[  196.221548][ T8633]  ? do_syscall_64+0x3d/0x90
[  196.221835][ T8633]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  196.222224][ T8633]  ? btrfs_ioctl_get_supported_features+0x40/0x40
[  196.222619][ T8633]  ? lockdep_hardirqs_on_prepare+0x428/0x790
[  196.223004][ T8633]  ? rcu_read_lock_sched_held+0x87/0x110
[  196.223353][ T8633]  ? __bpf_trace_rcu_stall_warning+0x10/0x10
[  196.223724][ T8633]  ? lockdep_hardirqs_on_prepare+0x428/0x790
[  196.224099][ T8633]  ? do_vfs_ioctl+0xc35/0x29e0
[  196.224395][ T8633]  ? __ia32_compat_sys_ioctl+0xb90/0xb90
[  196.224746][ T8633]  ? __lock_acquire+0x6080/0x6080
[  196.225060][ T8633]  ? slab_free_freelist_hook+0x12e/0x1a0
[  196.225406][ T8633]  ? tomoyo_path_number_perm+0x5be/0x790
[  196.225752][ T8633]  ? kfree+0xda/0x350
[  196.226002][ T8633]  ? tomoyo_path_number_perm+0x627/0x790
[  196.226352][ T8633]  ? tomoyo_check_path_acl+0x1c0/0x1c0
[  196.226690][ T8633]  ? rcu_read_lock_sched_held+0x87/0x110
[  196.227067][ T8633]  ? lockdep_hardirqs_on_prepare+0x428/0x790
[  196.227438][ T8633]  ? print_irqtrace_events+0x220/0x220
[  196.227775][ T8633]  ? vtime_user_exit+0x2b2/0x3e0
[  196.228084][ T8633]  ? __ct_user_exit+0xd9/0x160
[  196.228385][ T8633]  ? bpf_lsm_file_ioctl+0x5/0x10
[  196.228700][ T8633]  ? security_file_ioctl+0x9d/0xb0
[  196.229011][ T8633]  ? btrfs_ioctl_get_supported_features+0x40/0x40
[  196.229395][ T8633]  __se_sys_ioctl+0xfb/0x170
[  196.229693][ T8633]  do_syscall_64+0x3d/0x90
[  196.229970][ T8633]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  196.230326][ T8633] RIP: 0033:0x7fda5cee4469
[  196.230609][ T8633] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f
1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8
64 89 01 48
[  196.231750][ T8633] RSP: 002b:00007ffd27fd1dc8 EFLAGS: 00000206
ORIG_RAX: 0000000000000010
[  196.232248][ T8633] RAX: ffffffffffffffda RBX: 0000000000000000
RCX: 00007fda5cee4469
[  196.232721][ T8633] RDX: 0000000020000180 RSI: 00000000c0109428
RDI: 0000000000000006
[  196.233189][ T8633] RBP: 00007ffd27fd1de0 R08: 0000000000000002
R09: 00007ffd27fd1de0
[  196.233654][ T8633] R10: 0000000000000001 R11: 0000000000000206
R12: 0000559da6401170
[  196.234124][ T8633] R13: 00007ffd27fd1f20 R14: 0000000000000000
R15: 0000000000000000
[  196.234601][ T8633]  </TASK>
[  196.235107][ T8633] Kernel Offset: disabled
[  196.235468][ T8633] Rebooting in 86400 seconds..

Best,
Wei
