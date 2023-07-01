Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D6C744AFD
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Jul 2023 21:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjGATwi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Jul 2023 15:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjGATwh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Jul 2023 15:52:37 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155D510D0
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jul 2023 12:52:30 -0700 (PDT)
Date:   Sat, 01 Jul 2023 19:52:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=m2lhnxgyn5fzpaknxsfgjyk3qm.protonmail; t=1688241145; x=1688500345;
        bh=IaV3ungtFz1w8a04zfGdRMVyDz/I5LJ7n47Z9FHTC+E=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ggbQC7msIZ4QGaO19+hsBbzokoXs0W0cxPGkhfTZGKJx9hxK0U/NO8H2IqGST5vXG
         oO9/Os9poaip/T+8mO8B/r2w3otEYzuu41sdzOcW054piesk2q7FeZJiH/uA3tWeZv
         Y+y+7us0K7gOJbVtWpkhrRTrcHLWH1LpUFjJUxdNtvCHlhGROPAV3jAoEfJ/klqlZa
         b28gZFiE832cdee3dgfdGkWnYLwc9dADQhHNDIO8Qdp9ooLWrgvH14MUQ4G3iotlbw
         hu0gBHm8lvym+BghhIB5U6XDWtSc7o7guRBo/3GdJw/fx+KRgYtQDOJpMOVBkjY+lM
         Xt8KFCK9FPnRw==
To:     Roman Mamedov <rm@romanrm.net>
From:   yeslow <yeslow@proton.me>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Can't mount RAID-0 btrfs volume
Message-ID: <qN43D3gDnN0giDlI7WzHnprSbMXzPKgaz4f2kVqPrrv3Nf7jFIXz7TyGqCbi-9A5x4kaLtkcECcdctWE53IosIKUw0IIpTJWqL9uTlirJkE=@proton.me>
In-Reply-To: <20230701231326.632852b4@nvm>
References: <XbRHcnOusT9SgtIvEblFkrC43giGNCYfguS2_xjdCfx_NpoVzC4tHpV1hm-PF9_oxpVtM2j2imSl_1sEm3eYQRMFZy5ovi--vMQNkrab65o=@proton.me> <20230701231326.632852b4@nvm>
Feedback-ID: 79066612:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


------- Original Message -------
On Saturday, July 1st, 2023 at 8:13 PM, Roman Mamedov <rm@romanrm.net> wrot=
e:


> On Sat, 01 Jul 2023 14:59:11 +0000
> yeslow yeslow@proton.me wrote:
>=20
> > I have a dual boot system with Windows 10 Pro and Linux Kubuntu 22.04.
> >=20
> > I have created a btrfs raid-0 volume in my Linux system with 2 SSD driv=
es to
> > store not very important files, where the speed is most important. I th=
en
> > use winbtrfs in the Windows 10 system to be able to access the btrfs vo=
lume,
> > when using Windows 10.
> >=20
> > Everything worked fine for several months until recently. I deleted som=
e
> > files on the btrfs volume in Windows 10, which always worked fine, but =
this
> > time I noticed that after the file deletion the volume in Linux was not
> > showing the expected free space. When trying to have this fixed, I deci=
ded
> > to give it a try by using the command: btrfs check --clear-space-cache =
v2
>=20
>=20
> Could it be that instead of shutting down, you hibernated Windows 10 that=
 time?
No, I have hibernation disabled. The only thing I had changed was setting t=
he option
in winbtrfs nodatacow, which I also was using on the Linux mount.
These were my mount options on Linux: noatime,nosuid,nodev,nofail,ssd,nodat=
acow

=20
> As for the recovery options, look into "btrfs restore", that could fetch =
files
> from a damaged filesystem without trying to mount. If it's not damaged to=
o
> hard.
Unfortunately no success... Either I'm not doing it right, or my volume is =
too damaged:
$ sudo btrfs restore -D /dev/sda1 Music
checksum verify failed on 18266193920 wanted 0x34bed84997ecd963 found 0x9ee=
6d0c7b17903ec
checksum verify failed on 18266193920 wanted 0x0000000000000000 found 0x3e7=
6427c81028f58
checksum verify failed on 18266193920 wanted 0x34bed84997ecd963 found 0x9ee=
6d0c7b17903ec
bad tree block 18266193920, bytenr mismatch, want=3D18266193920, have=3D623=
7172951202995731
ERROR: cannot read chunk root
Could not open root, trying backup super
warning, device 2 is missing
warning, device 2 is missing
checksum verify failed on 18266193920 wanted 0x34bed84997ecd963 found 0x9ee=
6d0c7b17903ec
checksum verify failed on 18266193920 wanted 0x34bed84997ecd963 found 0x9ee=
6d0c7b17903ec
bad tree block 18266193920, bytenr mismatch, want=3D18266193920, have=3D623=
7172951202995731
ERROR: cannot read chunk root
Could not open root, trying backup super
warning, device 2 is missing
warning, device 2 is missing
checksum verify failed on 18266193920 wanted 0x34bed84997ecd963 found 0x9ee=
6d0c7b17903ec
checksum verify failed on 18266193920 wanted 0x34bed84997ecd963 found 0x9ee=
6d0c7b17903ec
bad tree block 18266193920, bytenr mismatch, want=3D18266193920, have=3D623=
7172951202995731
ERROR: cannot read chunk root
Could not open root, trying backup super

I get this device 2 is missing warning, but both devices are available. If =
I run the command
on the other device (/dev/sed1) I get the same message but saying that devi=
ce 1 is missing.

---

I also tried to run another command I found on another thread, and it seems=
 much of the details
of the volume are still correct and valid:
$ sudo btrfs inspect-internal dump-super -f /dev/sda1
superblock: bytenr=3D65536, device=3D/dev/sda1
---------------------------------------------------------
csum_type               1 (xxhash64)
csum_size               8
csum                    0x76e4b856b5f28aeb [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    833d4ef2-375b-4e9e-b2ae-8f0440a74e3e
metadata_uuid           833d4ef2-375b-4e9e-b2ae-8f0440a74e3e
label                   1_Public
generation              188499
root                    17206902784
sys_array_size          258
chunk_root_generation   188481
root_level              1
chunk_root              18266193920
chunk_root_level        1
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             1932735283200
bytes_used              1859603828736
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             2
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x361
                        ( MIXED_BACKREF |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA |
                          NO_HOLES )
cache_generation        188499
uuid_tree_generation    188479
dev_item.uuid           3ec00099-47c9-4bb3-a0c6-a6a4df8fed06
dev_item.fsid           833d4ef2-375b-4e9e-b2ae-8f0440a74e3e [match]
dev_item.type           0
dev_item.total_bytes    966367641600
dev_item.bytes_used     934187892736
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
sys_chunk_array[2048]:
        item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 18266193920)
                length 33554432 owner 2 stripe_len 65536 type SYSTEM|RAID1
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 2 sub_stripes 1
                        stripe 0 devid 1 offset 23644340224
                        dev_uuid 3ec00099-47c9-4bb3-a0c6-a6a4df8fed06
                        stripe 1 devid 2 offset 173980778496
                        dev_uuid 62fad050-53a2-4546-9bec-7ba94b8ca796
        item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 8652341641216)
                length 33554432 owner 2 stripe_len 65536 type SYSTEM|RAID1
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 2 sub_stripes 1
                        stripe 0 devid 2 offset 2148532224
                        dev_uuid 62fad050-53a2-4546-9bec-7ba94b8ca796
                        stripe 1 devid 1 offset 1048576
                        dev_uuid 3ec00099-47c9-4bb3-a0c6-a6a4df8fed06
backup_roots[4]:
        backup 0:
                backup_tree_root:       17204510720     gen: 188496     lev=
el: 1
                backup_chunk_root:      18266193920     gen: 188481     lev=
el: 1
                backup_extent_root:     17204396032     gen: 188496     lev=
el: 2
                backup_fs_root:         17204379648     gen: 188470     lev=
el: 2
                backup_dev_root:        17192943616     gen: 188481     lev=
el: 1
                backup_csum_root:       8651268734976   gen: 188479     lev=
el: 2
                backup_total_bytes:     1932735283200
                backup_bytes_used:      1859602763776
                backup_num_devices:     2

        backup 1:
                backup_tree_root:       17205215232     gen: 188497     lev=
el: 1
                backup_chunk_root:      18266193920     gen: 188481     lev=
el: 1
                backup_extent_root:     17205100544     gen: 188497     lev=
el: 2
                backup_fs_root:         17205084160     gen: 188470     lev=
el: 2
                backup_dev_root:        17192943616     gen: 188481     lev=
el: 1
                backup_csum_root:       8651268734976   gen: 188479     lev=
el: 2
                backup_total_bytes:     1932735283200
                backup_bytes_used:      1859603304448
                backup_num_devices:     2

        backup 2:
                backup_tree_root:       17206214656     gen: 188498     lev=
el: 1
                backup_chunk_root:      18266193920     gen: 188481     lev=
el: 1
                backup_extent_root:     17206132736     gen: 188498     lev=
el: 2
                backup_fs_root:         17206116352     gen: 188470     lev=
el: 2
                backup_dev_root:        17192943616     gen: 188481     lev=
el: 1
                backup_csum_root:       8651268734976   gen: 188479     lev=
el: 2
                backup_total_bytes:     1932735283200
                backup_bytes_used:      1859603828736
                backup_num_devices:     2

        backup 3:
                backup_tree_root:       17206902784     gen: 188499     lev=
el: 1
                backup_chunk_root:      18266193920     gen: 188481     lev=
el: 1
                backup_extent_root:     17206968320     gen: 188499     lev=
el: 2
                backup_fs_root:         17206116352     gen: 188470     lev=
el: 2
                backup_dev_root:        17192943616     gen: 188481     lev=
el: 1
                backup_csum_root:       8651268734976   gen: 188479     lev=
el: 2
                backup_total_bytes:     1932735283200
                backup_bytes_used:      1859603828736
                backup_num_devices:     2


Thank you very much for your support,
yeslow
