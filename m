Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6750035DACF
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Apr 2021 11:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245336AbhDMJNg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Apr 2021 05:13:36 -0400
Received: from a4-15.smtp-out.eu-west-1.amazonses.com ([54.240.4.15]:36507
        "EHLO a4-15.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231511AbhDMJNf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Apr 2021 05:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=pqvuhxtqt36lwjpmqkszlz7wxaih4qwj; d=urbackup.org; t=1618305194;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=/7KYQ+u52Pk6LXKpGEmvNJrD2g8wNoy7+h4jb2lvNrE=;
        b=A6r9A4EAZ94rTJx+G6oI3LxHqKKyrHoTlCDPpUEge+Bpk8WGlLwdv7ziRwiZ2ZUi
        qGMt+7g4W6waXJbV5SmDOnELP5cS/53XgI7UFK77EaOFRwUF+tD1IamnxA0GMID01Sq
        BDalNzW19vgeM8fp4Nd4nWxmOpM/7y59E06TLFNs=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1618305194;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=/7KYQ+u52Pk6LXKpGEmvNJrD2g8wNoy7+h4jb2lvNrE=;
        b=Z4Ilp3FAD9PpVzNyNSnugvDvmXHVuV+TEjtKuHz6Wz7g5sbjUOIsnBdhg4fXtXaD
        lygI25wh2KyhgUvRnhER1ypHyD2khVNcJBFMwTMaPBicArS1HfNfB40OexV7INSMJ1V
        COlBVlpCCu/7CCpfAXN4Wwm0BVnENxumEjAMMgrU=
Subject: Re: xfstests generic/476 failed on btrfs(errno=-12 Out of memory,
 kernel 5.11.10)
To:     Wang Yugui <wangyugui@e16-tech.com>,
        Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20210330142446.AB2E.409509F4@e16-tech.com>
 <8bcfb096-8de5-2176-0bf8-c2c9049aefe5@suse.com>
 <20210330151601.7E69.409509F4@e16-tech.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <01020178ca819778-2f1e97a4-1775-4b97-81f0-caa7ba006691-000000@eu-west-1.amazonses.com>
Date:   Tue, 13 Apr 2021 09:13:13 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210330151601.7E69.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2021.04.13-54.240.4.15
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30.03.2021 09:16 Wang Yugui wrote:
> H,
>
>> On 30.03.21 г. 9:24, Wang Yugui wrote:
>>> Hi, Nikolay Borisov
>>>
>>> With a lot of dump_stack()/printk inserted around ENOMEM in btrfs code,
>>> we find out the call stack for ENOMEM.
>>> see the file 0000-btrfs-dump_stack-when-ENOMEM.patch
>>>
>>>
>>> #cat /usr/hpc-bio/xfstests/results//generic/476.dmesg
>>> ...
>>> [ 5759.102929] ENOMEM btrfs_drew_lock_init
>>> [ 5759.102943] ENOMEM btrfs_init_fs_root
>>> [ 5759.102947] ------------[ cut here ]------------
>>> [ 5759.102950] BTRFS: Transaction aborted (error -12)
>>> [ 5759.103052] WARNING: CPU: 14 PID: 2741468 at /ssd/hpc-bio/linux-5.10.27/fs/btrfs/transaction.c:1705 create_pending_snapshot+0xb8c/0xd50 [btrfs]
>>> ...
>>>
>>>
>>> btrfs_drew_lock_init() return -ENOMEM,
>>> this is the source:
>>>
>>>      /*
>>>       * We might be called under a transaction (e.g. indirect backref
>>>       * resolution) which could deadlock if it triggers memory reclaim
>>>       */
>>>      nofs_flag = memalloc_nofs_save();
>>>      ret = btrfs_drew_lock_init(&root->snapshot_lock);
>>>      memalloc_nofs_restore(nofs_flag);
>>>      if (ret == -ENOMEM) printk("ENOMEM btrfs_drew_lock_init\n");
>>>      if (ret)
>>>          goto fail;
>>>
>>> And the souce come from:
>>>
>>> commit dcc3eb9638c3c927f1597075e851d0a16300a876
>>> Author: Nikolay Borisov <nborisov@suse.com>
>>> Date:   Thu Jan 30 14:59:45 2020 +0200
>>>
>>>      btrfs: convert snapshot/nocow exlcusion to drew lock
>>>
>>>
>>> Any advice to fix this ENOMEM problem?
>> This is likely coming from changed behavior in MM, doesn't seem related
>> to btrfs. We have multiple places where nofs_save() is called. By the
>> same token the failure might have occurred in any other place, in any
>> other piece of code which uses memalloc_nofs_save, there is no
>> indication that this is directly related to btrfs.
>>
>>> top command show that this server have engough memory.
>>>
>>> The hardware of this server:
>>> CPU:  Xeon(R) CPU E5-2660 v2(10 core)  *2
>>> memory:  192G, no swap
>> You are showing that the server has 192G of installed memory, you have
>> not shown any stats which prove at the time of failure what is the state
>> of the MM subsystem. At the very least at the time of failure inspect
>> the output of :
>>
>> cat /proc/meminfo
>>
>> and "free -m" commands.
>>
>> <snip>
> Only one xfstest job is running in this server.

Had what looks like the same issue happinging on a server:

[19146.391015] ------------[ cut here ]------------
[19146.391017] BTRFS: Transaction aborted (error -12)
[19146.391035] WARNING: CPU: 13 PID: 1825871 at 
fs/btrfs/transaction.c:1684 create_pending_snapshot+0x912/0xd10
[19146.391036] Modules linked in: bcache crc64 loop dm_crypt bfq xfs 
dm_mod st sr_mod cdrom intel_powerclamp coretemp dcdbas kvm_intel 
snd_pcm snd_timer kvm snd irqbypass soundcore mgag200 serio_raw pcspkr 
drm_kms_helper evdev joydev iTCO_wdt iTCO_vendor_support i2c_algo_bit 
i7core_edac sg ipmi_si ipmi_devintf ipmi_msghandler wmi acpi_power_meter 
button ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp 
libiscsi scsi_transport_iscsi drm configfs ip_tables x_tables autofs4 
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor 
async_tx raid1 raid0 multipath linear md_mod sd_mod hid_generic usbhid 
hid crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel 
aesni_intel crypto_simd ahci cryptd glue_helper mpt3sas libahci uhci_hcd 
ehci_pci psmouse ehci_hcd lpc_ich raid_class libata nvme 
scsi_transport_sas mfd_core usbcore nvme_core scsi_mod t10_pi bnx2
[19146.391092] CPU: 13 PID: 1825871 Comm: btrfs Tainted: G W I       
5.10.26 #1
[19146.391093] Hardware name: Dell Inc. PowerEdge R510/0DPRKF, BIOS 
1.14.0 05/30/2018
[19146.391095] RIP: 0010:create_pending_snapshot+0x912/0xd10
[19146.391097] Code: 48 0f ba aa 40 0a 00 00 02 72 28 83 f8 fb 74 48 83 
f8 e2 74 43 89 c6 48 c7 c7 70 2d 10 82 48 89 85 78 ff ff ff e8 d5 65 55 
00 <0f> 0b 48 8b 85 78 ff ff ff 89 c1 ba 94 06 00 00 48 c7 c6 70 46 e4
[19146.391098] RSP: 0018:ffffc900201c3b00 EFLAGS: 00010286
[19146.391099] RAX: 0000000000000000 RBX: ffff8881ba393200 RCX: 
ffff88880fb98b88
[19146.391100] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: 
ffff88880fb98b80
[19146.391101] RBP: ffffc900201c3bd0 R08: ffffffff825e2148 R09: 
0000000000027ffb
[19146.391101] R10: 00000000ffff8000 R11: 3fffffffffffffff R12: 
ffff888119dd39c0
[19146.391102] R13: ffff888248c36800 R14: ffff888a1bf69800 R15: 
00000000fffffff4
[19146.391103] FS:  00007f1d7c9488c0(0000) GS:ffff88880fb80000(0000) 
knlGS:0000000000000000
[19146.391104] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[19146.391105] CR2: 00007fffef58d000 CR3: 000000028c988004 CR4: 
00000000000206e0
[19146.391106] Call Trace:
[19146.391111]  ? create_pending_snapshots+0xa2/0xc0
[19146.391112]  create_pending_snapshots+0xa2/0xc0
[19146.391114]  btrfs_commit_transaction+0x4b9/0xb40
[19146.391116]  ? start_transaction+0xd2/0x580
[19146.391119]  btrfs_mksubvol+0x29e/0x450
[19146.391122]  btrfs_mksnapshot+0x7b/0xb0
[19146.391124]  __btrfs_ioctl_snap_create+0x16f/0x180
[19146.391126]  btrfs_ioctl_snap_create_v2+0xb3/0x130
[19146.391128]  btrfs_ioctl+0x15f/0x3040
[19146.391131]  ? __x64_sys_ioctl+0x83/0xb0
[19146.391132]  __x64_sys_ioctl+0x83/0xb0
[19146.391136]  do_syscall_64+0x33/0x80
[19146.391140]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[19146.391142] RIP: 0033:0x7f1d7ca3fcc7
[19146.391144] Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 00 00 00 
48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 64 89 01 48
[19146.391145] RSP: 002b:00007fffef5919b8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[19146.391146] RAX: ffffffffffffffda RBX: 00007fffef5a4c78 RCX: 
00007f1d7ca3fcc7
[19146.391147] RDX: 00007fffef5919d0 RSI: 0000000050009417 RDI: 
0000000000000004
[19146.391148] RBP: 0000565259b4d910 R08: ffffffffffffffff R09: 
0000565259b4d9e0
[19146.391148] R10: 0000000000000000 R11: 0000000000000246 R12: 
0000565259b4b8d0
[19146.391149] R13: 000000000000000e R14: 0000565259b4d9e0 R15: 
00007fffef5919d0
[19146.391151] ---[ end trace 3d3ae6fb9d3c0b49 ]---
[19146.391153] BTRFS: error (device sdo2) in 
create_pending_snapshot:1684: errno=-12 Out of memory
[19146.391187] BTRFS info (device sdo2): forced readonly
[19146.391190] BTRFS warning (device sdo2): Skipping commit of aborted 
transaction.
[19146.391191] BTRFS: error (device sdo2) in cleanup_transaction:1942: 
errno=-12 Out of memory
[44395.445834] BTRFS error (device sdo2): parent transid verify failed 
on 280438898688 wanted 1423523 found 1423519
[44395.448248] BTRFS error (device sdo2): parent transid verify failed 
on 280438898688 wanted 1423523 found 1423519
[44395.448512] BTRFS error (device sdo2): parent transid verify failed 
on 280438898688 wanted 1423523 found 1423519
[44395.455324] BTRFS error (device sdo2): parent transid verify failed 
on 280438898688 wanted 1423523 found 1423519


