Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FE3367F42
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Apr 2021 13:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbhDVLHp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Apr 2021 07:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbhDVLHm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Apr 2021 07:07:42 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B77FC06174A
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Apr 2021 04:07:07 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id q136so24848342qka.7
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Apr 2021 04:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=WNfoWhfJ5PLB4kEuU94Jq7GZWHZtinj3uU3pnHA5tmk=;
        b=AWHQjmwDmfHUYwCNhsepQFwT4v73MDJwvpIOfDoWa0IdTJRmrUP+Koy0umJFqIH7ys
         QTo+5H+vRLdqOv8PEtn8mfmuBSwZPkYYtzDnbFD8JK4sHrNqyVApmdSxFOv1cSauO5J1
         yjUs6VBVXBSluQuZSXGcBRousCvhytNOhhzf9yAs76tg+Mbp39FpN/0NdIfUF3GBLzOD
         9iXRIGO9cz0j/V5P7Sa7L4Dguq1qkSQCMChHZ1cCCc93LP+OSFjE7NE8rotzBqwu9FxS
         89GczjpC7uom5d0GIs0pPcc5krlTNjbKfxciHjQrvz8zZakr0cyuYFXAK9NSJi7I5YKh
         inoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=WNfoWhfJ5PLB4kEuU94Jq7GZWHZtinj3uU3pnHA5tmk=;
        b=gu36ipAGelUth8xDTlZULpmcCqS8CL/AwwxB/iP9AG/YgrRn/Rt5azmR9t7moIv0Uq
         mhDiVIs+fuCe5DTJgEjz1/Ue76RZkclYQnHJ0DWyJKmN7zA6z/eB0/KWdnekfVWklbke
         4zoS+TG2Pbl+YFbYbHSgTaY3uRs59Shk4RnqA03/uzd1kjgEJkyNJ6DvZ8wm9X5ddQC/
         gBRj5GS2GMc3S/dMp+W67brIK/IIZd+X8IZhjCyGAMV/OCK7sORe8C6tEjGAidDQc362
         YNsnlN2K+94VG9cL0cdTou5lqv1/HT4sioLTeQEDBo0EfzKOXdDXSAOVJwXJeRC+b653
         +YQQ==
X-Gm-Message-State: AOAM5326NxHz3Lu8euDaT2g7TCIjR/p478MYPLEAU739vvnfnljSu//C
        sh6SD7IRpBMa0h+2G8k2IzR4U5zdGhF5nKqS7gA=
X-Google-Smtp-Source: ABdhPJzYZ3HJPtqQ2s5s+rmB/wPzWCSXyfPkxcrdhV6vTDm9wN4Gh4ECuW/RTG8U/t0xIyr/ABFMEGg7w4C1Kq753Kk=
X-Received: by 2002:ae9:efd1:: with SMTP id d200mr3014063qkg.0.1619089626589;
 Thu, 22 Apr 2021 04:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210422083231.755B.409509F4@e16-tech.com> <aa9ffab6-02cb-16a0-794c-80a990c4f999@gmx.com>
 <20210422121608.BBAC.409509F4@e16-tech.com>
In-Reply-To: <20210422121608.BBAC.409509F4@e16-tech.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 22 Apr 2021 12:06:55 +0100
Message-ID: <CAL3q7H7dDSXr63USLs8woPiLgdyj938VOtgyZ1skVFyaRvgoHA@mail.gmail.com>
Subject: Re: 'ls /mnt/scratch/' freeze(deadlock?) when run xfstest(btrfs/232)
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 22, 2021 at 5:16 AM Wang Yugui <wangyugui@e16-tech.com> wrote:
>
> Hi,
>
> > On 2021/4/22 =E4=B8=8A=E5=8D=888:32, Wang Yugui wrote:
> > > Hi,
> > >
> > >>>>> we run xfstest on two server with this patch.
> > >>>>> one passed the tests.
> > >>>>> but one got a btrfs/232 error.
> > >>>>>
> > >>>>> btrfs/232 32s ... _check_btrfs_filesystem: filesystem on
> > >>>>> /dev/nvme0n1p1is inconsistent
> > >>>>> (see /usr/hpc-bio/xfstests/results//btrfs/232.full for details)
> > >>>>> ...
> > >>>>> [4/7] checking fs roots
> > >>>>> root 5 inode 337 errors 400, nbytes wrong
> > >>>>> ERROR: errors found in fs roots
> > >>>>
> > >>>> Ok, that's a different problem caused by something else.
> > >>>> It's possible to be due to the recent refactorings for preparation=
 to
> > >>>> subpage block size.
> > >>>
> > >>> This error looks exactly what I have seen during subpage developmen=
t.
> > >>> The subpage bug is caused by incorrect btrfs_invalidatepage() thoug=
h,
> > >>> and not yet merged into misc-next anyway.
> > >>>
> > >>> I guess it's some error path not clearing extent states correctly, =
thus
> > >>> leaving the inode nbytes accounting wrong.
> > >>>
> > >>> BTW, the new @in_reclaim_context parameter for start_delalloc_inode=
s()
> > >>> is already in misc-next:
> > >>> commit 3d45f221ce627d13e2e6ef3274f06750c84a6542
> > >>> Author: Filipe Manana <fdmanana@suse.com>
> > >>> Date:?? Wed Dec 2 11:55:58 2020 +0000
> > >>>
> > >>>   ?? btrfs: fix deadlock when cloning inline extent and low on free
> > >>> metadata space
> > >>>
> > >>> We only need to make btrfs_start_delalloc_snapshot() to accept the =
new
> > >>> parameter and pass in_reclaim_context =3D true for qgroup.
> > >>
> > >> Strangely, on my subpage branch, with new @in_reclaim_context parame=
ter
> > >> added to btrfs_start_delalloc_snapshot(), I can't reproduce the nbyt=
es
> > >> mismatch error in 32 runs loop.
> > >> I guess one of the refactor around ordered extents and invalidatepag=
e
> > >> may fix the problem by accident.
> > >>
> > >> Mind to test my subpage branch
> > >> (https://github.com/adam900710/linux/tree/subpage) with the attached=
 diff?
> > >
> > > The attached diff( more in_reclaim_context) seems a replacement for
> > > https://pastebin.com/raw/U9GUZiEf (less in_reclaim_context).
> >
> > The attached diff is for subpage branch, as misc-next already has the
> > parameter introduced for another bug.
> > Thus only a small part is needed for subpage branch.
>
> nothing is found when 'grep in_reclaim_context' in 112 patch of misc-next
> since 5.12-rc8.

Not sure what you mean, but any kernel starting with 5.11 has that paramete=
r.

>
>
> > > so I  will firstly test with the attached diff but drop
> > > https://pastebin.com/raw/U9GUZiEf.
>
> test result:
>         it passed xfstests in 2 server * 1 loop.  no error is deteced.
>
> Although the reproduce frequecy of these two problems is yet not clear,
> the patch from Qu could be considered as current fix ?

For the nbytes inconsistency, no.
I couldn't trigger it overnight, that might well be a race very hard
to hit. Running xfstests twice, is far from enough to find out all
possible issues... Might be something that happens once in a thousand
times.

Anyway, it's a different problem from the deadlock, that will have to
be addressed separately and unrelated to the deadlock fix.
What I see happening in some frequency however, is some qgroup space
leak (both with and without the deadlock fix):

[Thu Apr 22 10:49:27 2021] BTRFS: device fsid
99becc8d-77dc-4e5a-9154-5165a6c3c52c devid 1 transid 5 /dev/sdc
scanned by mkfs.btrfs (1708854)
[Thu Apr 22 10:49:27 2021] BTRFS info (device sdc): disk space caching
is enabled
[Thu Apr 22 10:49:27 2021] BTRFS info (device sdc): has skinny extents
[Thu Apr 22 10:49:27 2021] BTRFS info (device sdc): flagging fs with
big metadata feature
[Thu Apr 22 10:49:27 2021] BTRFS info (device sdc): checking UUID tree
[Thu Apr 22 10:49:32 2021] BTRFS warning (device sdc): qgroup rescan
is already in progress
[Thu Apr 22 10:49:32 2021] BTRFS info (device sdc): qgroup scan
completed (inconsistency flag cleared)
[Thu Apr 22 10:50:05 2021] BTRFS warning (device sdc): qgroup 0/5 has
unreleased space, type 0 rsv 69632
[Thu Apr 22 10:50:05 2021] ------------[ cut here ]------------
[Thu Apr 22 10:50:05 2021] WARNING: CPU: 7 PID: 1709112 at
fs/btrfs/disk-io.c:4387 close_ctree+0x1fe/0x352 [btrfs]
[Thu Apr 22 10:50:05 2021] Modules linked in: btrfs dm_snapshot
dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio dm_log_writes
dm_dust dm_flakey dm_mod loop blake2b_generic xor raid6_pq libcrc32c
intel_rapl_msr intel_rapl_common kvm_intel kvm irqbypass
crct10dif_pclmul ghash_clmulni_intel ppdev bochs_drm aesni_intel
drm_vram_helper crypto_simd parport_pc cryptd drm_ttm_helper parport
input_leds rapl joydev ttm led_class sg serio_raw evdev drm_kms_helper
pcspkr qemu_fw_cfg button drm ip_tables x_tables autofs4 ext4
crc32c_generic crc16 mbcache jbd2 sd_mod t10_pi virtio_scsi virtio_net
net_failover failover ata_generic ata_piix libata virtio_pci
virtio_pci_modern_dev crc32_pclmul virtio_ring psmouse scsi_mod virtio
crc32c_intel i2c_piix4 [last unloaded: btrfs]
[Thu Apr 22 10:50:05 2021] CPU: 7 PID: 1709112 Comm: umount Tainted: G
       W         5.12.0-rc8-btrfs-next-92 #1
[Thu Apr 22 10:50:05 2021] Hardware name: QEMU Standard PC (i440FX +
PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org
04/01/2014
[Thu Apr 22 10:50:05 2021] RIP: 0010:close_ctree+0x1fe/0x352 [btrfs]
[Thu Apr 22 10:50:05 2021] Code: be 1f 11 00 00 48 c7 c7 38 4e 93 c0
e8 5d f7 ff ff bf 02 00 00 00 48 89 ee e8 56 f7 f3 ff 48 89 df e8 8e
a4 fc ff 84 c0 74 11 <0f> 0b 48 c7 c6 60 4e 93 c0 48 89 df e8 51 c7 ff
ff 48 89 df e8 71
[Thu Apr 22 10:50:05 2021] RSP: 0018:ffffbea0842f7e38 EFLAGS: 00010202
[Thu Apr 22 10:50:05 2021] RAX: 0000000000000001 RBX: ffff978b56944000
RCX: 0000000000000000
[Thu Apr 22 10:50:05 2021] RDX: 0000000000000001 RSI: 0000000000000002
RDI: ffff978bb90c5598
[Thu Apr 22 10:50:05 2021] RBP: ffff978b56944010 R08: 0000000000000000
R09: 0000000000000000
[Thu Apr 22 10:50:05 2021] R10: 0000000000000000 R11: 0000000000000001
R12: ffff978b56946048
[Thu Apr 22 10:50:05 2021] R13: 0000000000000007 R14: 0000000000000000
R15: 0000000000000000
[Thu Apr 22 10:50:05 2021] FS:  00007fa7a1d61840(0000)
GS:ffff978c76a00000(0000) knlGS:0000000000000000
[Thu Apr 22 10:50:05 2021] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[Thu Apr 22 10:50:05 2021] CR2: 000056495e1e3ee0 CR3: 00000001002e0004
CR4: 0000000000370ee0
[Thu Apr 22 10:50:05 2021] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[Thu Apr 22 10:50:05 2021] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[Thu Apr 22 10:50:05 2021] Call Trace:
[Thu Apr 22 10:50:05 2021]  ? call_rcu+0x14c/0x250
[Thu Apr 22 10:50:05 2021]  generic_shutdown_super+0x6c/0x100
[Thu Apr 22 10:50:05 2021]  kill_anon_super+0x14/0x30
[Thu Apr 22 10:50:05 2021]  btrfs_kill_super+0x12/0x20 [btrfs]
[Thu Apr 22 10:50:05 2021]  deactivate_locked_super+0x31/0xa0
[Thu Apr 22 10:50:05 2021]  cleanup_mnt+0x141/0x1b0
[Thu Apr 22 10:50:05 2021]  task_work_run+0x5c/0xa0
[Thu Apr 22 10:50:05 2021]  exit_to_user_mode_prepare+0x1fa/0x200
[Thu Apr 22 10:50:05 2021]  syscall_exit_to_user_mode+0x27/0x60
[Thu Apr 22 10:50:05 2021]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[Thu Apr 22 10:50:05 2021] RIP: 0033:0x7fa7a1f99ee7
[Thu Apr 22 10:50:05 2021] Code: ff 0b 00 f7 d8 64 89 01 48 83 c8 ff
c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00
b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 79 ff 0b 00
f7 d8 64 89 01 48
[Thu Apr 22 10:50:05 2021] RSP: 002b:00007ffc3fe062d8 EFLAGS: 00000246
ORIG_RAX: 00000000000000a6
[Thu Apr 22 10:50:05 2021] RAX: 0000000000000000 RBX: 00007fa7a20bf264
RCX: 00007fa7a1f99ee7
[Thu Apr 22 10:50:05 2021] RDX: ffffffffffffff78 RSI: 0000000000000000
RDI: 0000556a6a9dec80
[Thu Apr 22 10:50:05 2021] RBP: 0000556a6a9da960 R08: 0000000000000000
R09: 00007ffc3fe05050
[Thu Apr 22 10:50:05 2021] R10: 0000556a6a9e0af0 R11: 0000000000000246
R12: 0000000000000000
[Thu Apr 22 10:50:05 2021] R13: 0000556a6a9dec80 R14: 0000556a6a9daa70
R15: 0000556a6a9dab90
[Thu Apr 22 10:50:06 2021] irq event stamp: 0

But again, it's a different problem caused by a different bug.

>
>
> > > The test of whole subpage branch will be done later.
> >
> > So far, I also tested the older misc-next branch, and unable to
> > reproduce the problem.
> > I guess some patch in misc-next has already solved the problem.
> >
> > If possible it would be better to provide the branch you're on so that
> > we could do more tests to pin down the bug.

Please always be clear about what branch you are testing.
You mentioned misc-next in the first post, then you later mentioned
it's 5.12-rc8 with some patches from misc-next, which is not the
same...

Thanks.

>
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/04/22
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
