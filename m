Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE09116AF1
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 11:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfLIK1F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 05:27:05 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34549 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfLIK1F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Dec 2019 05:27:05 -0500
Received: by mail-ua1-f65.google.com with SMTP id w20so5363450uap.1
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2019 02:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Qo96rFprjukx4HzzBp27gO8LXac13TocQWJ2uVbfwXw=;
        b=emjLbcpYl3dFIlrOhwt6cxyWGCJMiCtTW14yzpkWDtbGG6aXWuyaA9VIEvtl5yEKwG
         18RK8/3YHwhPFm8UjWBvMQyAMiuyE+NyiWNngr14rkHvfitdlaen47Bx3nqLs43N3duR
         SJoLMAHaU0h8QgDma0TLkNKxgu8YoxUHI+iGSOyh2VslmlfWBNQ/dTakI5otGVKFI3oh
         +cZFdjR3CR2X4hO9odoArtLXgrLAR0CijFBeQJqH++LNBeMraB/CK4J/8oNAIR6rEIuu
         wo664T+skt9B48w5CQZbiupTnx8Djk3GbNx9sCyE/KvonrzZHraO0MxO/gHxzETIJ2gN
         0UVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Qo96rFprjukx4HzzBp27gO8LXac13TocQWJ2uVbfwXw=;
        b=bJv7T7WTmACaRav5+G0N1rCU5xD97q2iFoRcRmvrSK/l2atwyNBOUnmx/S/ZJy7j33
         mdEHq67M96qAXkNek8eW/EpC2H8hGqYo51FsizMezJCK6XFdV5emjrpF6eAoyHLl79sZ
         dncIrYmbTE7MuvinyrHAko4yNdKBvdVyJFPkUPNOaEM2kKj9I9eYD71Vgh02Y3Yt2g0y
         ce6iCKN8AmIEWKASr8NlrlJEHsSaOqxrGL+PNLAQpUQr1xfx2YLj2aDevv2W5ADrvSQZ
         cCYGdCSYbiroccSGGw5U9KrJH6G6HJ3mlPq5lPcRaYvbApxmgAQK0bq7wGJR4iG1c/q5
         UxbA==
X-Gm-Message-State: APjAAAW9x69u8XIQsR+lFpGXSgpGwkfAoREe8KXimooLX1J/X2QgxJmo
        eCUpLBYAJxdVKAXax6yfH7FNlFVpAmd30MoqsOCF8BQm
X-Google-Smtp-Source: APXvYqyZIxaRqaT/sQyifwHIqekxYzD2g4KCf7L53Bu8E1/0HEsYOFt1IgeMhmB/RepGgOvaCANmBEfbqEMFKLJZc3o=
X-Received: by 2002:ab0:1492:: with SMTP id d18mr23028469uae.0.1575887223375;
 Mon, 09 Dec 2019 02:27:03 -0800 (PST)
MIME-Version: 1.0
References: <20191208093045.43433-1-kyle@ambroffkao.com> <20191208093045.43433-2-kyle@ambroffkao.com>
In-Reply-To: <20191208093045.43433-2-kyle@ambroffkao.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 9 Dec 2019 10:26:52 +0000
Message-ID: <CAL3q7H60gNBC_zzU8gjZ_s=7MnN23yFzQqYxanhvzMO50qtXJg@mail.gmail.com>
Subject: Re: [PATCH 1/1] btrfs: Allow replacing device with a smaller one if possible
To:     Kyle Ambroff-Kao <kyle@ambroffkao.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 8, 2019 at 9:32 AM Kyle Ambroff-Kao <kyle@ambroffkao.com> wrote=
:
>
> As long as the target device has enough capacity for the total bytes
> of the source device, allow the replacement to occur.
>
> Just changing the size validation isn't enough though, since the
> rest of the replacement code just assumes that the source device is
> identical to the target device. The current code just blindly
> copies the total disk size from the source to the target.
>
> A btrfs resize <devid>:max could be performed, but we might as well
> just set the disk size for the new target device correctly in the
> first place before initiating a scrub, which is what this patch does.
>
> When initializing the target device, the size in bytes is calculated
> in the same way that btrfs_init_new_device does it.
>
> When the replace operation completes, btrfs_dev_replace_finishing no
> longer clobbers the target device size with the source device size.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D112741
> Signed-off-by: Kyle Ambroff-Kao <kyle@ambroffkao.com>
> ---
>  fs/btrfs/dev-replace.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index f639dde2a679..6a7a83ccab56 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -216,7 +216,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs=
_fs_info *fs_info,
>
>
>         if (i_size_read(bdev->bd_inode) <
> -           btrfs_device_get_total_bytes(srcdev)) {
> +           btrfs_device_get_bytes_used(srcdev)) {

Hi,

Unfortunately things are not that simple...

The new device may have enough space, but that's not enough to guarantee
that the replace operation will succeed.
Consider the following example:

#!/bin/bash -x

losetup -d /dev/loop1 &> /dev/null
losetup -d /dev/loop2 &> /dev/null
losetup -d /dev/loop3 &> /dev/null

rm -f /mnt/disk1 /mnt/disk2 /mnt/disk3
fallocate -l 8G /mnt/disk1
fallocate -l 8G /mnt/disk2
fallocate -l 4G /mnt/disk3
losetup /dev/loop1 /mnt/disk1
losetup /dev/loop2 /mnt/disk2
losetup /dev/loop3 /mnt/disk3

mkdir /mnt/test &> /dev/null
umount /mnt/test &> /dev/null
mkfs.btrfs -f /dev/loop1 /dev/loop2
mount /dev/loop1 /mnt/test

fallocate -l 1G /mnt/test/foo1
fallocate -l 1G /mnt/test/foo2
fallocate -l 1G /mnt/test/foo3
fallocate -l 1G /mnt/test/foo4
fallocate -l 1G /mnt/test/foo5
fallocate -l 1G /mnt/test/foo6
fallocate -l 1G /mnt/test/foo7
fallocate -l 1G /mnt/test/foo8
sync
rm -f /mnt/test/foo{2,3,4,5,6,7}

umount /mnt/test
mount /dev/loop1 /mnt/test
sync # ensure empty block groups are removed

btrfs filesystem du /mnt/test
btrfs filesystem df /mnt/test

btrfs replace start -B /dev/loop2 /dev/loop3 /mnt/test

umount /mnt/test

# end of script


This will fail, despite the new device having a size of 4Gb which is more
than enough as there's little more than 2Gb used by the filesystem:

(...)
+ btrfs filesystem du /mnt/test
     Total   Exclusive  Set shared  Filename
   1.00GiB     1.00GiB           -  /mnt/test/foo1
   1.00GiB     1.00GiB           -  /mnt/test/foo8
   2.00GiB     2.00GiB       0.00B  /mnt/test

+ btrfs filesystem df /mnt/test
Data, RAID0: total=3D4.85GiB, used=3D2.00GiB
System, RAID1: total=3D8.00MiB, used=3D16.00KiB
Metadata, RAID1: total=3D256.00MiB, used=3D112.00KiB
GlobalReserve, single: total=3D3.25MiB, used=3D0.00B

+ btrfs replace start -B /dev/loop2 /dev/loop3 /mnt/test
ERROR: ioctl(DEV_REPLACE_START) failed on "/mnt/test": Input/output error
(...)


If you look at dmesg/syslog you'll also see a lot of error messages regardi=
ng
writes beyond the target device's size, which is the replace operation fail=
s
with error -EIO (which is -5):

$ dmesg
(...)
[242142.682576] loop3: rw=3D1, want=3D8904704, limit=3D8388608
[242142.682623] attempt to access beyond end of device
[242142.682625] loop3: rw=3D1, want=3D8904832, limit=3D8388608
[242142.682671] attempt to access beyond end of device
[242142.682672] loop3: rw=3D1, want=3D8904960, limit=3D8388608
[242142.682716] attempt to access beyond end of device
[242142.682718] loop3: rw=3D1, want=3D8905088, limit=3D8388608
[242148.882448] BTRFS error (device loop1):
btrfs_scrub_dev(/dev/loop2, 2, /dev/loop3) failed -5
[242148.903248] ------------[ cut here ]------------
[242148.903375] WARNING: CPU: 1 PID: 22989 at
fs/btrfs/dev-replace.c:508 btrfs_dev_replace_by_ioctl+0x711/0x8b0
[btrfs]
[242148.903383] Modules linked in: btrfs xor raid6_pq libcrc32c loop
intel_rapl_msr intel_rapl_common kvm_intel kvm bochs_drm
drm_vram_helper ttm irqbypass drm_kms_helper crct10dif_pclmul
crc32_pclmul ghash_clmulni_intel drm aesni_intel crypto_simd cryptd
joydev glue_helper evdev sg pcspkr parport_pc serio_raw button
qemu_fw_cfg ppdev lp parport ip_tables x_tables autofs4 ext4
crc32c_generic crc16 mbcache jbd2 sd_mod virtio_scsi ata_generic
crc32c_intel virtio_pci virtio_ring psmouse virtio e1000 ata_piix
libata scsi_mod i2c_piix4
[242148.903502] CPU: 1 PID: 22989 Comm: btrfs Tainted: G        W
   5.4.0-rc8-btrfs-next-65 #1
[242148.903509] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
[242148.903618] RIP: 0010:btrfs_dev_replace_by_ioctl+0x711/0x8b0 [btrfs]
[242148.903630] Code: 89 f7 e8 82 e7 fa ff 8b 45 b8 e9 8a fe ff ff 48
c7 c2 83 ff ff ff 48 8b 4d c0 48 89 51 08 e9 25 fe ff ff 0f 0b e9 cd
fd ff ff <0f> 0b e9 68 fe ff ff 48 c7 c6 c0 31 9c c0 48 89 df e8 43 9f
02 00
[242148.903637] RSP: 0018:ffffa9c740803cb0 EFLAGS: 00010282
[242148.903648] RAX: 00000000fffffffb RBX: ffff99d87ab7c000 RCX:
0000000000000000
[242148.903655] RDX: 0000000000000000 RSI: ffff99d87ab7ee68 RDI:
0000000000000246
[242148.903663] RBP: ffffa9c740803d10 R08: 0000000000000000 R09:
0000000000000000
[242148.903669] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff99d8b35ef000
[242148.903677] R13: 0000000000000000 R14: ffff99d87b38d800 R15:
ffff99d87ab7ee88
[242148.903686] FS:  00007f1fc75cd8c0(0000) GS:ffff99d8b6a80000(0000)
knlGS:0000000000000000
[242148.903694] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[242148.903701] CR2: 00007ffe01b4bec8 CR3: 00000001fca5a005 CR4:
00000000003606e0
[242148.903717] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[242148.903724] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[242148.903730] Call Trace:
[242148.903864]  btrfs_ioctl+0x2928/0x37e0 [btrfs]
[242148.903894]  ? __lock_acquire+0x37a/0x1e10
[242148.903910]  ? __lock_acquire+0x37a/0x1e10
[242148.903961]  ? do_sigaction+0xf3/0x240
[242148.903992]  ? do_vfs_ioctl+0xa2/0x700
[242148.904003]  do_vfs_ioctl+0xa2/0x700
[242148.904017]  ? do_sigaction+0xf3/0x240
[242148.904051]  ksys_ioctl+0x70/0x80
[242148.904063]  ? trace_hardirqs_off_thunk+0x1a/0x20
[242148.904086]  __x64_sys_ioctl+0x16/0x20
[242148.904097]  do_syscall_64+0x5c/0x250
[242148.904114]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[242148.904125] RIP: 0033:0x7f1fc63d5dd7
[242148.904136] Code: 00 00 00 48 8b 05 c1 80 2b 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 91 80 2b 00 f7 d8 64 89
01 48
[242148.904145] RSP: 002b:00007fffd8716078 EFLAGS: 00000202 ORIG_RAX:
0000000000000010
[242148.904154] RAX: ffffffffffffffda RBX: 00000000ffffffff RCX:
00007f1fc63d5dd7
[242148.904162] RDX: 00007fffd8716ee0 RSI: 00000000ca289435 RDI:
0000000000000003
[242148.904167] RBP: 0000000000000004 R08: 0000000000000000 R09:
0000000000000000
[242148.904173] R10: 0000000000000008 R11: 0000000000000202 R12:
0000000000000000
[242148.904181] R13: 0000000000000003 R14: 00007fffd87186a6 R15:
00005555cb872050
[242148.904234] irq event stamp: 1705866
[242148.904246] hardirqs last  enabled at (1705865):
[<ffffffff896c65d9>] _raw_spin_unlock_irqrestore+0x59/0x70
[242148.904258] hardirqs last disabled at (1705866):
[<ffffffff88c048ea>] trace_hardirqs_off_thunk+0x1a/0x20
[242148.904317] softirqs last  enabled at (1705764):
[<ffffffff8949359e>] peernet2id+0x4e/0x70
[242148.904328] softirqs last disabled at (1705762):
[<ffffffff8949357f>] peernet2id+0x2f/0x70
[242148.904334] ---[ end trace f2fa14238388d729 ]---


So device replace fails with -EIO and lots of errors in dmesg/syslog,
something that will mislead a user into thinking there's some problem
with the hardware.
Each device is using 2880634880 bytes (it's what btrfs_device_get_bytes_use=
d()
returns) right before the replace operation, a value clearly smaller
then 4Gb (the size
of the new device).

So, why does this happens?
Because device replace simply copies extents (both data and metadata) direc=
tly,
if something is at offset 7Gb in the source device, it tries to copy that e=
xtent
also to the offset 7Gb of the target device. This is very simple, reliable =
and
predictable, it actually decreases the chances for data/metadata loss.

For extents already on disk before the device replace starts, the process
consists of iterating all chunks and then copy them from the source to
the target device. Once a chunk is processed we don't process it anymore.

If any extent (data or metadata) is written during the replace procedure,
after we processed the corresponding chunk, the respective extent is still
copied to the target device - this is because during the initialization
of device replace we set up a mechanism that results in once a write is
performed to the source device, it is automatically forwarded to the target
device as well (using the same offset as the source device) - the key place=
s
to see where this happens are: btrfs_dev_replace_start() and
__btrfs_map_block().

So, that's why we don't allow the target device to be smaller then the sour=
ce
device - a device may have only 2Gb of space allocated to chunks for exampl=
e,
but one 1Gb chunk may be at device offset 0 and the other 1Gb chunk at devi=
ce
offset 6Gb, so replacing with a 4Gb device will never work.

In order to allow a smaller device for device replace, I see two approaches=
:

1) The more complex one:  have a mechanism to remap chunk offsets. This imp=
lies
   building some mapping (in memory), so that for the above case for exampl=
e,
   if the first data chunk is at offset 1GB it can be mapped to 1GB in
the target
   device as well, but for the second data chunk, we have to remap the offs=
et
   (something > 4Gb) to something <=3D 3Gb on the target device. I think
this may actually
   be harder then it may seem. It's not only that copy part (and
dealing with incoming
   writes while replace is in progress), because when replace
finishes, you also have
   to update the mappings in the chunk tree for every chunk with the
new start offset,
   which can take a while and require a lot of metadata space to be
reserved. In other
   words, it will require significant changes to how device replace
copies extents just
   for one use case.

2) A simple solution, but often less efficient: before starting the actual
   replace operation, shrink the source device to the size of the
target device -
   just use the existing btrfs_shrink_device(), which will relocate chunks
   beyond the new size, and if there's not enough space it just returns -EN=
OSPC.
   This means no changes to the actual way replace copies data - it
does extra IO,
   due to the relocation but keeps things simple, and it should still
be significantly
   more efficient then doing a device remove + device add operation,
maybe except if
   all or most of the allocated chunks (in the device to be replaced)
cross or start
   beyond an offset matching the new device's size.

   Also, since the shrink can take some time due to relocation of
chunks, we would need
   to teach btrfs_shrink_device() to check for device replace cancel
requests as well.
   And such request is detected, restore the device's size to the
original value.

I think option 2 may actually be acceptable for an initial version. Option =
1 is
complex and increases the risk for data loss. Also, for option 2, there's t=
he
possible downside of requiring writes to the source device - one might
be replacing
it because the device is not healthy, writes into some regions are
failing, which
can prevent the shrink/relocation process from suceeding, in that case only
a device remove followed by a device add operation would work.

Either way, we will also need to have test cases in fstests to cover
all possible
scenarios we can think of, including stress tests where we replace the
device with
a smaller one and write/delete/create to files while replace is in
progress. Then
for each scenario scrub the devices, run fsck, etc, to verify
everything is fine.
If you decide to go for option 2, also compare performance against a
device remove
+ device add operation.

Thanks.


>                 btrfs_err(fs_info,
>                           "target device is smaller than source device!")=
;
>                 ret =3D -EINVAL;
> @@ -243,8 +243,10 @@ static int btrfs_init_dev_replace_tgtdev(struct btrf=
s_fs_info *fs_info,
>         device->io_width =3D fs_info->sectorsize;
>         device->io_align =3D fs_info->sectorsize;
>         device->sector_size =3D fs_info->sectorsize;
> -       device->total_bytes =3D btrfs_device_get_total_bytes(srcdev);
> -       device->disk_total_bytes =3D btrfs_device_get_disk_total_bytes(sr=
cdev);
> +       device->total_bytes =3D round_down(
> +               i_size_read(bdev->bd_inode),
> +               fs_info->sectorsize);
> +       device->disk_total_bytes =3D device->total_bytes;
>         device->bytes_used =3D btrfs_device_get_bytes_used(srcdev);
>         device->commit_total_bytes =3D srcdev->commit_total_bytes;
>         device->commit_bytes_used =3D device->bytes_used;
> @@ -671,9 +673,6 @@ static int btrfs_dev_replace_finishing(struct btrfs_f=
s_info *fs_info,
>         memcpy(uuid_tmp, tgt_device->uuid, sizeof(uuid_tmp));
>         memcpy(tgt_device->uuid, src_device->uuid, sizeof(tgt_device->uui=
d));
>         memcpy(src_device->uuid, uuid_tmp, sizeof(src_device->uuid));
> -       btrfs_device_set_total_bytes(tgt_device, src_device->total_bytes)=
;
> -       btrfs_device_set_disk_total_bytes(tgt_device,
> -                                         src_device->disk_total_bytes);
>         btrfs_device_set_bytes_used(tgt_device, src_device->bytes_used);
>         tgt_device->commit_bytes_used =3D src_device->bytes_used;
>
> --
> 2.20.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
