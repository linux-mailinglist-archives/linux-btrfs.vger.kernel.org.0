Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DE435DC03
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Apr 2021 11:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhDMJ6p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Apr 2021 05:58:45 -0400
Received: from out20-1.mail.aliyun.com ([115.124.20.1]:51684 "EHLO
        out20-1.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhDMJ6o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Apr 2021 05:58:44 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436304|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0211252-5.62016e-05-0.978819;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.JzJHa9J_1618307903;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JzJHa9J_1618307903)
          by smtp.aliyun-inc.com(10.147.40.233);
          Tue, 13 Apr 2021 17:58:23 +0800
Date:   Tue, 13 Apr 2021 17:58:27 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Martin Raiber <martin@urbackup.org>
Subject: Re: xfstests generic/476 failed on btrfs(errno=-12 Out of memory, kernel 5.11.10)
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
In-Reply-To: <01020178ca819778-2f1e97a4-1775-4b97-81f0-caa7ba006691-000000@eu-west-1.amazonses.com>
References: <20210330151601.7E69.409509F4@e16-tech.com> <01020178ca819778-2f1e97a4-1775-4b97-81f0-caa7ba006691-000000@eu-west-1.amazonses.com>
Message-Id: <20210413175826.7D71.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

This patch works.

 From:    Dennis Zhou <dennis@kernel.org>
 To:      Wang Yugui <wangyugui@e16-tech.com>
 Cc:      Vlastimil Babka <vbabka@suse.cz>,
          linux-mm@kvack.org,
          linux-btrfs@vger.kernel.org
 Date:    Thu, 8 Apr 2021 13:48:33 +0000
 Subject: Re: unexpected -ENOMEM from percpu_counter_init()
----

Ah. Can you try the following patch?
https://lore.kernel.org/lkml/20210408035736.883861-4-guro@fb.com/


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/04/13

> On 30.03.2021 09:16 Wang Yugui wrote:
> > H,
> >
> >> On 30.03.21 §Ô. 9:24, Wang Yugui wrote:
> >>> Hi, Nikolay Borisov
> >>>
> >>> With a lot of dump_stack()/printk inserted around ENOMEM in btrfs code,
> >>> we find out the call stack for ENOMEM.
> >>> see the file 0000-btrfs-dump_stack-when-ENOMEM.patch
> >>>
> >>>
> >>> #cat /usr/hpc-bio/xfstests/results//generic/476.dmesg
> >>> ...
> >>> [ 5759.102929] ENOMEM btrfs_drew_lock_init
> >>> [ 5759.102943] ENOMEM btrfs_init_fs_root
> >>> [ 5759.102947] ------------[ cut here ]------------
> >>> [ 5759.102950] BTRFS: Transaction aborted (error -12)
> >>> [ 5759.103052] WARNING: CPU: 14 PID: 2741468 at /ssd/hpc-bio/linux-5.10.27/fs/btrfs/transaction.c:1705 create_pending_snapshot+0xb8c/0xd50 [btrfs]
> >>> ...
> >>>
> >>>
> >>> btrfs_drew_lock_init() return -ENOMEM,
> >>> this is the source:
> >>>
> >>>      /*
> >>>       * We might be called under a transaction (e.g. indirect backref
> >>>       * resolution) which could deadlock if it triggers memory reclaim
> >>>       */
> >>>      nofs_flag = memalloc_nofs_save();
> >>>      ret = btrfs_drew_lock_init(&root->snapshot_lock);
> >>>      memalloc_nofs_restore(nofs_flag);
> >>>      if (ret == -ENOMEM) printk("ENOMEM btrfs_drew_lock_init\n");
> >>>      if (ret)
> >>>          goto fail;
> >>>
> >>> And the souce come from:
> >>>
> >>> commit dcc3eb9638c3c927f1597075e851d0a16300a876
> >>> Author: Nikolay Borisov <nborisov@suse.com>
> >>> Date:   Thu Jan 30 14:59:45 2020 +0200
> >>>
> >>>      btrfs: convert snapshot/nocow exlcusion to drew lock
> >>>
> >>>
> >>> Any advice to fix this ENOMEM problem?
> >> This is likely coming from changed behavior in MM, doesn't seem related
> >> to btrfs. We have multiple places where nofs_save() is called. By the
> >> same token the failure might have occurred in any other place, in any
> >> other piece of code which uses memalloc_nofs_save, there is no
> >> indication that this is directly related to btrfs.
> >>
> >>> top command show that this server have engough memory.
> >>>
> >>> The hardware of this server:
> >>> CPU:  Xeon(R) CPU E5-2660 v2(10 core)  *2
> >>> memory:  192G, no swap
> >> You are showing that the server has 192G of installed memory, you have
> >> not shown any stats which prove at the time of failure what is the state
> >> of the MM subsystem. At the very least at the time of failure inspect
> >> the output of :
> >>
> >> cat /proc/meminfo
> >>
> >> and "free -m" commands.
> >>
> >> <snip>
> > Only one xfstest job is running in this server.
> 
> Had what looks like the same issue happinging on a server:
> 
> [19146.391015] ------------[ cut here ]------------
> [19146.391017] BTRFS: Transaction aborted (error -12)
> [19146.391035] WARNING: CPU: 13 PID: 1825871 at fs/btrfs/transaction.c:1684 create_pending_snapshot+0x912/0xd10
> [19146.391036] Modules linked in: bcache crc64 loop dm_crypt bfq xfs dm_mod st sr_mod cdrom intel_powerclamp coretemp dcdbas kvm_intel snd_pcm snd_timer kvm snd irqbypass soundcore mgag200 serio_raw pcspkr drm_kms_helper evdev joydev iTCO_wdt iTCO_vendor_support i2c_algo_bit i7core_edac sg ipmi_si ipmi_devintf ipmi_msghandler wmi acpi_power_meter button ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi drm configfs ip_tables x_tables autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx raid1 raid0 multipath linear md_mod sd_mod hid_generic usbhid hid crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd ahci cryptd glue_helper mpt3sas libahci uhci_hcd ehci_pci psmouse ehci_hcd lpc_ich raid_class libata nvme scsi_transport_sas mfd_core usbcore nvme_core scsi_mod t10_pi bnx2
> [19146.391092] CPU: 13 PID: 1825871 Comm: btrfs Tainted: G W I?????? 5.10.26 #1
> [19146.391093] Hardware name: Dell Inc. PowerEdge R510/0DPRKF, BIOS 1.14.0 05/30/2018
> [19146.391095] RIP: 0010:create_pending_snapshot+0x912/0xd10
> [19146.391097] Code: 48 0f ba aa 40 0a 00 00 02 72 28 83 f8 fb 74 48 83 f8 e2 74 43 89 c6 48 c7 c7 70 2d 10 82 48 89 85 78 ff ff ff e8 d5 65 55 00 <0f> 0b 48 8b 85 78 ff ff ff 89 c1 ba 94 06 00 00 48 c7 c6 70 46 e4
> [19146.391098] RSP: 0018:ffffc900201c3b00 EFLAGS: 00010286
> [19146.391099] RAX: 0000000000000000 RBX: ffff8881ba393200 RCX: ffff88880fb98b88
> [19146.391100] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff88880fb98b80
> [19146.391101] RBP: ffffc900201c3bd0 R08: ffffffff825e2148 R09: 0000000000027ffb
> [19146.391101] R10: 00000000ffff8000 R11: 3fffffffffffffff R12: ffff888119dd39c0
> [19146.391102] R13: ffff888248c36800 R14: ffff888a1bf69800 R15: 00000000fffffff4
> [19146.391103] FS:? 00007f1d7c9488c0(0000) GS:ffff88880fb80000(0000) knlGS:0000000000000000
> [19146.391104] CS:? 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [19146.391105] CR2: 00007fffef58d000 CR3: 000000028c988004 CR4: 00000000000206e0
> [19146.391106] Call Trace:
> [19146.391111]? ? create_pending_snapshots+0xa2/0xc0
> [19146.391112]? create_pending_snapshots+0xa2/0xc0
> [19146.391114]? btrfs_commit_transaction+0x4b9/0xb40
> [19146.391116]? ? start_transaction+0xd2/0x580
> [19146.391119]? btrfs_mksubvol+0x29e/0x450
> [19146.391122]? btrfs_mksnapshot+0x7b/0xb0
> [19146.391124]? __btrfs_ioctl_snap_create+0x16f/0x180
> [19146.391126]? btrfs_ioctl_snap_create_v2+0xb3/0x130
> [19146.391128]? btrfs_ioctl+0x15f/0x3040
> [19146.391131]? ? __x64_sys_ioctl+0x83/0xb0
> [19146.391132]? __x64_sys_ioctl+0x83/0xb0
> [19146.391136]? do_syscall_64+0x33/0x80
> [19146.391140]? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [19146.391142] RIP: 0033:0x7f1d7ca3fcc7
> [19146.391144] Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 64 89 01 48
> [19146.391145] RSP: 002b:00007fffef5919b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [19146.391146] RAX: ffffffffffffffda RBX: 00007fffef5a4c78 RCX: 00007f1d7ca3fcc7
> [19146.391147] RDX: 00007fffef5919d0 RSI: 0000000050009417 RDI: 0000000000000004
> [19146.391148] RBP: 0000565259b4d910 R08: ffffffffffffffff R09: 0000565259b4d9e0
> [19146.391148] R10: 0000000000000000 R11: 0000000000000246 R12: 0000565259b4b8d0
> [19146.391149] R13: 000000000000000e R14: 0000565259b4d9e0 R15: 00007fffef5919d0
> [19146.391151] ---[ end trace 3d3ae6fb9d3c0b49 ]---
> [19146.391153] BTRFS: error (device sdo2) in create_pending_snapshot:1684: errno=-12 Out of memory
> [19146.391187] BTRFS info (device sdo2): forced readonly
> [19146.391190] BTRFS warning (device sdo2): Skipping commit of aborted transaction.
> [19146.391191] BTRFS: error (device sdo2) in cleanup_transaction:1942: errno=-12 Out of memory
> [44395.445834] BTRFS error (device sdo2): parent transid verify failed on 280438898688 wanted 1423523 found 1423519
> [44395.448248] BTRFS error (device sdo2): parent transid verify failed on 280438898688 wanted 1423523 found 1423519
> [44395.448512] BTRFS error (device sdo2): parent transid verify failed on 280438898688 wanted 1423523 found 1423519
> [44395.455324] BTRFS error (device sdo2): parent transid verify failed on 280438898688 wanted 1423523 found 1423519
> 


