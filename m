Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A3679CA79
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 10:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjILIow (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 04:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjILIob (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 04:44:31 -0400
X-Greylist: delayed 457 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Sep 2023 01:44:28 PDT
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7B910D0
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 01:44:27 -0700 (PDT)
Received: from tux.applied-asynchrony.com (p5b2e81a4.dip0.t-ipconnect.de [91.46.129.164])
        by mail.itouring.de (Postfix) with ESMTPSA id 61A25C556;
        Tue, 12 Sep 2023 10:36:44 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 16C36F01611;
        Tue, 12 Sep 2023 10:36:44 +0200 (CEST)
Subject: Re: delayed dir index insertion failure
To:     ken <ken@bllue.org>, linux-btrfs@vger.kernel.org
References: <CAE6xmH+Lp=Q=E61bU+v9eWX8gYfLvu6jLYxjxjFpo3zHVPR0EQ@mail.gmail.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <d3c64142-043e-a795-9855-38ab889776b1@applied-asynchrony.com>
Date:   Tue, 12 Sep 2023 10:36:44 +0200
MIME-Version: 1.0
In-Reply-To: <CAE6xmH+Lp=Q=E61bU+v9eWX8gYfLvu6jLYxjxjFpo3zHVPR0EQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2023-09-12 05:14, ken wrote:
> I've been getting these reliably, so I switched to stock fedora 38
> kernel, and I recreated the filesystem and repopulated the data from
> backups (the filesystem failed btrfs check, didn't save the output of
> that).  But with a fresh filesystem and all data recovered it's still
> triggering.  Filesystem is   created "-O no-holes -d single -m raid1"
> ontop two dm-crypt block devices.
> mount options are "defaults,noatime,space_cache=v2"
> 
> I've seen some recent patches for this, not sure if that's a fix or
> just improved diagnostics.  Happy to try something out to try to get
> to the root cause.  The machine is under extremely heavy load during
> bootup, which is mostly services putting in io requests which I
> suspect could be involved.
> 
> details below,
> 
> ken
> 
> Sep 11 22:33:09 myhostname kernel: Linux version
> 6.4.15-200.fc38.x86_64 (mockbuild@2e6cd98d8465441c8330a02794035256)
> (gcc (GCC) 13.2.1 20230728 (Red Hat 13.2.1-1), GNU ld version
> 2.39-9.fc38) #1 SMP PREEMPT_DYNAMIC Thu Sep  7 00:25:01 UTC 2023
> Sep 11 22:33:09 myhostname kernel: Command line:
> BOOT_IMAGE=(hd0,msdos1)/vmlinuz-6.4.15-200.fc38.x86_64
> root=LABEL=r3-root ro slub_debug=- usbcore.autosuspend=-1 rd.md=0
> rd.lvm=0 rd.dm=0 libata.allow_tpm=1 vconsole.keymap=us rd.luks=0
> vconsole.font
> =latarcyrheb-sun16 quiet systemd.show_status=1 selinux=0 mitigations=off
> 
> 
> 
> 
> Sep 11 22:34:59 myhostname kernel: BTRFS error (device dm-3): err add
> delayed dir index item(name: cockroach-stderr.log) into the insertion
> tree of the delayed node(root id: 5, inode id: 4539217, errno: -17)
> Sep 11 22:34:59 myhostname kernel: ------------[ cut here ]------------
> Sep 11 22:34:59 myhostname kernel: kernel BUG at fs/btrfs/delayed-inode.c:1504!
> Sep 11 22:34:59 myhostname kernel: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> Sep 11 22:34:59 myhostname kernel: CPU: 0 PID: 7159 Comm: cockroach
> Not tainted 6.4.15-200.fc38.x86_64 #1
> Sep 11 22:34:59 myhostname kernel: Hardware name: ASUS ESC500 G3/P9D
> WS, BIOS 2402 06/27/2018
> Sep 11 22:34:59 myhostname kernel: RIP:
> 0010:btrfs_insert_delayed_dir_index+0x1da/0x260
> Sep 11 22:34:59 myhostname kernel: Code: eb dd 48 8b 43 10 4c 8b 0b 44
> 89 e2 48 c7 c6 00 3a 91 85 48 8b 7d 50 4c 8b 80 f7 01 00 00 41 57 48
> 8b 4c 24 08 e8 56 67 04 00 <0f> 0b 65 8b 05 b9 e9 9c 7b 89 c0 48 0f a3
> 05 c3 f0 cb 01 0f 83 2f
> Sep 11 22:34:59 myhostname kernel: RSP: 0000:ffffa9980e0fbb28 EFLAGS: 00010282
> Sep 11 22:34:59 myhostname kernel: RAX: 0000000000000000 RBX:
> ffff8b10b8f4a3c0 RCX: 0000000000000000
> Sep 11 22:34:59 myhostname kernel: RDX: 0000000000000000 RSI:
> ffff8b177ec21540 RDI: ffff8b177ec21540
> Sep 11 22:34:59 myhostname kernel: RBP: ffff8b110cf80888 R08:
> 0000000000000000 R09: ffffa9980e0fb938
> Sep 11 22:34:59 myhostname kernel: R10: 0000000000000003 R11:
> ffffffff86146508 R12: 0000000000000014
> Sep 11 22:34:59 myhostname kernel: R13: ffff8b1131ae5b40 R14:
> ffff8b10b8f4a418 R15: 00000000ffffffef
> Sep 11 22:34:59 myhostname kernel: FS:  00007fb14a7fe6c0(0000)
> GS:ffff8b177ec00000(0000) knlGS:0000000000000000
> Sep 11 22:34:59 myhostname kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Sep 11 22:34:59 myhostname kernel: CR2: 000000c00143d000 CR3:
> 00000001b3b4e002 CR4: 00000000001706f0
> Sep 11 22:34:59 myhostname kernel: Call Trace:
> Sep 11 22:34:59 myhostname kernel:  <TASK>
> Sep 11 22:34:59 myhostname kernel:  ? die+0x36/0x90
> Sep 11 22:34:59 myhostname kernel:  ? do_trap+0xda/0x100
> Sep 11 22:34:59 myhostname kernel:  ? btrfs_insert_delayed_dir_index+0x1da/0x260
> Sep 11 22:34:59 myhostname kernel:  ? do_error_trap+0x6a/0x90
> Sep 11 22:34:59 myhostname kernel:  ? btrfs_insert_delayed_dir_index+0x1da/0x260
> Sep 11 22:34:59 myhostname kernel:  ? exc_invalid_op+0x50/0x70
> Sep 11 22:34:59 myhostname kernel:  ? btrfs_insert_delayed_dir_index+0x1da/0x260
> Sep 11 22:34:59 myhostname kernel:  ? asm_exc_invalid_op+0x1a/0x20
> Sep 11 22:34:59 myhostname kernel:  ? btrfs_insert_delayed_dir_index+0x1da/0x260
> Sep 11 22:34:59 myhostname kernel:  ? btrfs_insert_delayed_dir_index+0x1da/0x260
> Sep 11 22:34:59 myhostname kernel:  btrfs_insert_dir_item+0x200/0x280
> Sep 11 22:34:59 myhostname kernel:  btrfs_add_link+0xab/0x4f0
> Sep 11 22:34:59 myhostname kernel:  ? ktime_get_real_ts64+0x47/0xe0
> Sep 11 22:34:59 myhostname kernel:  btrfs_create_new_inode+0x7cd/0xa80
> Sep 11 22:34:59 myhostname kernel:  btrfs_symlink+0x190/0x4d0
> Sep 11 22:34:59 myhostname kernel:  ? schedule+0x5e/0xd0
> Sep 11 22:34:59 myhostname kernel:  ? __d_lookup+0x7e/0xc0
> Sep 11 22:34:59 myhostname kernel:  vfs_symlink+0x148/0x1e0
> Sep 11 22:34:59 myhostname kernel:  do_symlinkat+0x130/0x140
> Sep 11 22:34:59 myhostname kernel:  __x64_sys_symlinkat+0x3d/0x50
> Sep 11 22:34:59 myhostname kernel:  do_syscall_64+0x5d/0x90
> Sep 11 22:34:59 myhostname kernel:  ? syscall_exit_to_user_mode+0x2b/0x40
> Sep 11 22:34:59 myhostname kernel:  ? do_syscall_64+0x6c/0x90
> Sep 11 22:34:59 myhostname kernel:  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> Sep 11 22:34:59 myhostname kernel: RIP: 0033:0x83d8d0

There's a decent chance that this is actually caused by
https://bugzilla.kernel.org/show_bug.cgi?id=216646 and btrfs is just the victim.

The fix is planned for the current -stable candidates, at least 6.4.16
and 6.5.3, currently both in -rc1. Can you try 6.4.16-rc1 and see if it
still reproduces?

cheers
Holger
