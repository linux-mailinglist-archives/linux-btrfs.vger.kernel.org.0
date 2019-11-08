Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF37F50C6
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 17:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfKHQNL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 11:13:11 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33891 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfKHQNL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Nov 2019 11:13:11 -0500
Received: by mail-vs1-f68.google.com with SMTP id y23so4157880vso.1
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Nov 2019 08:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=LcK9gTQxBn3LS6rrLmxAdj+Edv668aLvAef6SQmmW5A=;
        b=vDbShtzOSAyrhHg4sKsBXJRMPqrV+D4MevMmzTnWP2J3F+GaWVKlcgIpMgCqdogex9
         lVQYHovBlYUd6DxpMZNEoikjmHhb309Kx4SnMRS7wyKNR2UHVDW8tEKM7+e8wWGOKaCj
         BFswkIPRV/A/gRZkmXjuGUTHl/XbQJ7sc10N0Fexj4KiTUHxapjPaI4t3XlQQxew7RlW
         QaJwU83SNG84c1EWUqeBisE8fIE3eyREmJYjUSGUF8vUMeUuw290CiE5ISW8QeaNgie0
         Cyg2tBhf2nJrGDrsTcKWnDYhaAX5itytiC5hqrusWVZT+TrIiAIiZUueHBrvVR3YGeTk
         Kjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=LcK9gTQxBn3LS6rrLmxAdj+Edv668aLvAef6SQmmW5A=;
        b=fvOoQLv/+p0Sl5FWNhB20C9WH/E3Gx1fg6vTc5LPNpHyVo5KGLjma3Mf6YHvd1as+i
         uwSiqg/Qy6KhEL030vOI3lMClVPCRBuascSrRM8SnHs6xVoMvDHm6afBI5AhFpc5XzhF
         dipWfm1dOkSoq+lj6bb4HA8Ulrixu5shzlXT1DWpD6ApgWcVwmbqH9AqbZJwQlV049+2
         lWUTLTz4vC9fLkdJeheueEtwrbEcBgebGftNDdDBnF1Od476O3txYlarAtJ6M17ROAH5
         0NwthuTUyBiJ7yyRvhDkKytlSxHlb6Pi6fG2T2fpFwyxHb9CUQuOdbb7DpoKjvZKKu0C
         WShw==
X-Gm-Message-State: APjAAAXIQ2CsM2cdGugRk1hSuJQquxGe/Xvd33lkNA09rNsOjdOsozIS
        luCH+w13tpdleGIpvHuUHJtbzSB8SwhWf2y3Jtg=
X-Google-Smtp-Source: APXvYqys4BPPgkvnhEgsjt5kwD9CDPm03tttKZC+7svA2BeDo2XrSUPsEnvQ168NGYv6boFT0t/S8ktYRZQ95xTi6Qk=
X-Received: by 2002:a05:6102:7dc:: with SMTP id y28mr7484582vsg.99.1573229589263;
 Fri, 08 Nov 2019 08:13:09 -0800 (PST)
MIME-Version: 1.0
References: <dd9f22ee-e73c-7476-82d1-45a10d1f16f9@gmx.com>
In-Reply-To: <dd9f22ee-e73c-7476-82d1-45a10d1f16f9@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 8 Nov 2019 16:12:58 +0000
Message-ID: <CAL3q7H6jBfDgu-F8b=wzYsPBgmW1dOJ7tq0OYmLBv4Qsn-M=gg@mail.gmail.com>
Subject: Re: [BUG report] KASAN: null-ptr-deref in btrfs_sync_log
To:     Su Yue <Damenly_Su@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 8, 2019 at 5:25 AM Su Yue <Damenly_Su@gmx.com> wrote:
>
> Hi,
>
> While running xfstests/btrfs/004 and btrfs/067 whith KASAN enabled
> on v5.4-rc6, KASAN reports following BUG(btrfs/004):
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  681.583782] BUG: KASAN: null-ptr-deref in btrfs_sync_log+0x77c/0x1200
> [btrfs]
> [  681.585752] Write of size 8 at addr 0000000000000008 by task
> fsstress/44351
>
> [  681.588201] CPU: 6 PID: 44351 Comm: fsstress Kdump: loaded Not
> tainted 5.4.0-rc6-custom #18
> [  681.589903] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> ?-20191013_105130-anatol 04/01/2014
> [  681.592284] Call Trace:
> [  681.592904]  dump_stack+0xa4/0xfa
> [  681.593825]  ? btrfs_sync_log+0x77c/0x1200 [btrfs]
> [  681.595048]  __kasan_report.cold+0x5/0x41
> [  681.596135]  ? btrfs_sync_log+0x77c/0x1200 [btrfs]
> [  681.597139]  kasan_report+0x12/0x20
> [  681.598054]  __asan_store8+0x57/0x90
> [  681.599028]  btrfs_sync_log+0x77c/0x1200 [btrfs]
> [  681.600291]  ? btrfs_log_inode_parent+0x1440/0x1440 [btrfs]
> [  681.601662]  ? 0xffffffffa0000000
> [  681.602561]  ? mark_lock+0xaf/0xab0
> [  681.603687]  ? dput+0xdd/0x600
> [  681.604595]  ? __kasan_check_write+0x14/0x20
> [  681.605732]  ? up_write+0xe5/0x290
> [  681.606752]  btrfs_sync_file+0x56e/0x7c0 [btrfs]
> [  681.608084]  ? btrfs_file_write_iter+0x920/0x920 [btrfs]
> [  681.609482]  ? __do_sys_newstat+0xad/0x100
> [  681.610559]  ? cp_new_stat+0x310/0x310
> [  681.611614]  vfs_fsync_range+0x6d/0x110
> [  681.612714]  ? btrfs_file_write_iter+0x920/0x920 [btrfs]
> [  681.613732]  do_fsync+0x3d/0x70
> [  681.614281]  __x64_sys_fsync+0x21/0x30
> [  681.614934]  do_syscall_64+0x79/0xe0
> [  681.615554]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  681.616405] RIP: 0033:0x7fe6d8d33bd7
> [  681.617011] Code: ff ff eb bb 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44
> 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 4a 00 00 00 0f
> 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 03 f7 ff ff
> [  681.620086] RSP: 002b:00007ffe4f9a8ff8 EFLAGS: 00000246 ORIG_RAX:
> 000000000000004a
> [  681.621350] RAX: ffffffffffffffda RBX: 000055b5c5a15520 RCX:
> 00007fe6d8d33bd7
> [  681.622533] RDX: 00007ffe4f9a8f50 RSI: 00007ffe4f9a8f50 RDI:
> 0000000000000003
> [  681.623711] RBP: 0000000000000003 R08: 0000000000000001 R09:
> 00007ffe4f9a900c
> [  681.624901] R10: 0000000000000000 R11: 0000000000000246 R12:
> 0000000000000243
> [  681.626079] R13: 00007ffe4f9a9050 R14: 00007ffe4f9a90e6 R15:
> 000055b5c5a06760
> [  681.627289]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  681.628487] Disabling lock debugging due to kernel taint
> [  681.629463] BUG: kernel NULL pointer dereference, address:
> 0000000000000008
> [  681.630933] #PF: supervisor write access in kernel mode
> [  681.632013] #PF: error_code(0x0002) - not-present page
> [  681.632856] PGD 0 P4D 0
> [  681.633247] Oops: 0002 [#1] PREEMPT SMP KASAN NOPTI
> [  681.633963] CPU: 6 PID: 44351 Comm: fsstress Kdump: loaded Tainted: G
>     B             5.4.0-rc6-custom #18
> [  681.635365] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> ?-20191013_105130-anatol 04/01/2014
> [  681.636538] RIP: 0010:btrfs_sync_log+0x77c/0x1200 [btrfs]
> [  681.637182] Code: 89 fc 4d 8d 44 24 20 4c 89 4c 24 78 4c 89 c7 4c 89
> 84 24 80 00 00 00 e8 72 fa da df 4d 8b 7c 24 20 48 8d 7b 08 e8 f4 fa da
> df <4c> 89 7b 08 4c 89 ff e8 e8 fa da df 49 89 1f 4c 8b 4c 24 78 4c 89
> [  681.639367] RSP: 0018:ffff8884245ef970 EFLAGS: 00010217
> [  681.639987] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> 0000000000000000
> [  681.640910] RDX: 0000000000000001 RSI: 0000000000000004 RDI:
> ffffffffa3240820
> [  681.641993] RBP: ffff8884245efd10 R08: ffffffffa012b3c8 R09:
> fffffbfff437c161
> [  681.643054] R10: fffffbfff437c160 R11: ffffffffa1be0b03 R12:
> ffff8884245efae0
> [  681.644014] R13: ffffffffffffffe8 R14: ffff8884245efaf8 R15:
> 0000000000000000
> [  681.644953] FS:  00007fe6d8b57b80(0000) GS:ffff88843f800000(0000)
> knlGS:0000000000000000
> [  681.645998] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  681.646756] CR2: 0000000000000008 CR3: 00000004341fc000 CR4:
> 00000000003406e0
> [  681.647681] Call Trace:
> [  681.648083]  ? btrfs_log_inode_parent+0x1440/0x1440 [btrfs]
> [  681.648805]  ? 0xffffffffa0000000
> [  681.649235]  ? mark_lock+0xaf/0xab0
> [  681.649725]  ? dput+0xdd/0x600
> [  681.650125]  ? __kasan_check_write+0x14/0x20
> [  681.650671]  ? up_write+0xe5/0x290
> [  681.651170]  btrfs_sync_file+0x56e/0x7c0 [btrfs]
> [  681.651820]  ? btrfs_file_write_iter+0x920/0x920 [btrfs]
> [  681.652544]  ? __do_sys_newstat+0xad/0x100
> [  681.653111]  ? cp_new_stat+0x310/0x310
> [  681.653638]  vfs_fsync_range+0x6d/0x110
> [  681.654178]  ? btrfs_file_write_iter+0x920/0x920 [btrfs]
> [  681.654896]  do_fsync+0x3d/0x70
> [  681.655337]  __x64_sys_fsync+0x21/0x30
> [  681.655867]  do_syscall_64+0x79/0xe0
> [  681.656361]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  681.657025] RIP: 0033:0x7fe6d8d33bd7
> [  681.657511] Code: ff ff eb bb 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44
> 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 4a 00 00 00 0f
> 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 03 f7 ff ff
> [  681.660006] RSP: 002b:00007ffe4f9a8ff8 EFLAGS: 00000246 ORIG_RAX:
> 000000000000004a
> [  681.661052] RAX: ffffffffffffffda RBX: 000055b5c5a15520 RCX:
> 00007fe6d8d33bd7
> [  681.662009] RDX: 00007ffe4f9a8f50 RSI: 00007ffe4f9a8f50 RDI:
> 0000000000000003
> [  681.662962] RBP: 0000000000000003 R08: 0000000000000001 R09:
> 00007ffe4f9a900c
> [  681.663920] R10: 0000000000000000 R11: 0000000000000246 R12:
> 0000000000000243
> [  681.664888] R13: 00007ffe4f9a9050 R14: 00007ffe4f9a90e6 R15:
> 000055b5c5a06760
> [  681.665841] Modules linked in: mousedev nls_iso8859_1 nls_cp437 vfat
> fat snd_hda_codec_generic crct10dif_pclmul input_leds led_class
> crc32_pclmul ghash_clmulni_intel psmouse snd_hda_intel snd_intel_nhlt
> snd_hda_codec snd_hwdep snd_hda_core iTCO_wdt iTCO_vendor_support
> snd_pcm snd_timer snd aesni_intel glue_helper soundcore crypto_simd
> lpc_ich i2c_i801 cryptd pcspkr intel_agp intel_gtt evdev agpgart mac_hid
> rtc_cmos qemu_fw_cfg ip_tables x_tables xfs btrfs xor zstd_decompress
> zstd_compress raid6_pq sr_mod cdrom sd_mod dm_mod virtio_rng
> virtio_balloon virtio_blk virtio_console virtio_scsi rng_core virtio_net
> net_failover failover ahci libahci libata crc32c_intel scsi_mod
> serio_raw atkbd virtio_pci virtio_ring libps2 virtio i8042 serio
> [  681.674563] CR2: 0000000000000008
> [  681.675034] ---[ end trace b973ab2013a7b9e2 ]---
> [  681.675699] RIP: 0010:btrfs_sync_log+0x77c/0x1200 [btrfs]
> [  681.676438] Code: 89 fc 4d 8d 44 24 20 4c 89 4c 24 78 4c 89 c7 4c 89
> 84 24 80 00 00 00 e8 72 fa da df 4d 8b 7c 24 20 48 8d 7b 08 e8 f4 fa da
> df <4c> 89 7b 08 4c 89 ff e8 e8 fa da df 49 89 1f 4c 8b 4c 24 78 4c 89
> [  681.678931] RSP: 0018:ffff8884245ef970 EFLAGS: 00010217
> [  681.679645] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> 0000000000000000
> [  681.680622] RDX: 0000000000000001 RSI: 0000000000000004 RDI:
> ffffffffa3240820
> [  681.681588] RBP: ffff8884245efd10 R08: ffffffffa012b3c8 R09:
> fffffbfff437c161
> [  681.682554] R10: fffffbfff437c160 R11: ffffffffa1be0b03 R12:
> ffff8884245efae0
> [  681.683522] R13: ffffffffffffffe8 R14: ffff8884245efaf8 R15:
> 0000000000000000
> [  681.684475] FS:  00007fe6d8b57b80(0000) GS:ffff88843f800000(0000)
> knlGS:0000000000000000
> [  681.685583] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  681.686353] CR2: 0000000000000008 CR3: 00000004341fc000 CR4:
> 00000000003406e0
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The local.config is nothing special only with default mount option.
>
> The above BUG is easy to reproduce but not in 100%. 10 rounds is enough
> to hit this.
>
> linux 21:13#  ~/linux/scripts/faddr2line ~/linux/fs/btrfs/btrfs.ko
> btrfs_sync_log+0x77c
> btrfs_sync_log+0x77c/0x1200:
> __list_del at /root/linux/./include/linux/list.h:105
> (inlined by) __list_del_entry at /root/linux/./include/linux/list.h:134
> (inlined by) list_del_init at /root/linux/./include/linux/list.h:190
> (inlined by) btrfs_remove_all_log_ctxs at
> /root/linux/fs/btrfs/tree-log.c:3016
> (inlined by) btrfs_sync_log at /root/linux/fs/btrfs/tree-log.c:3283
>
> Here are my .config and the whole dmesg:
> https://drive.google.com/open?id=3D1DcaYg820sxWweNj7zG42_AM6ZjusPePG
> https://drive.google.com/open?id=3D1Ris7pzDsAkl6CuluZqbMwZzxgPfNOkSw

Thanks for the report.

I hit this yesterday too after rebasing fstests. We recently got
support for rename exchange in fsstress, and that's triggering a bug
there,
which causes a on-stack log context to remain in the a root's list of
log contextes, resulting in memory corruption.

I've just sent a fix for it:  https://patchwork.kernel.org/patch/11235229/





--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
