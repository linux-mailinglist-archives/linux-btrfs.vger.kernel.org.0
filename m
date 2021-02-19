Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F6031F41D
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 04:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhBSDEs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Feb 2021 22:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhBSDEn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Feb 2021 22:04:43 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6250BC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Feb 2021 19:04:03 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id t63so4381521qkc.1
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Feb 2021 19:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xNsE/Bbu2dvX/Ha3gyIv2jmuG0G/PodgUrz1gvCrWc0=;
        b=C+Ae32/921N3OgtV1ZtLCcrImBR9M7NfvXz+R3HZqGO3W8kseK6wiRbnFYlgeUi8PU
         HRMI1HxuiPP9e8RCPM7SuDExiih4Q/jzqwmS0HDIb3uQdjpeAmRPUigVwVop//cX8YN6
         +MJqB2L4BVP3WQ2fi/hVhZDulKK9P7656HYBuQWm61cGT555s/c9vMOrwGx4FvfvUGbI
         4+YJa/YXwqDsPsxacLHje+IL0DR6lLm8akEW8qDownIDbneCOahSTBmTwRGYf4t3IyOU
         wmqdDzN2PuPhCMt3/S2Pbyok2Wd1sqY/l7Jw7zvR1GO2vLhsoIHNRx0gt5EsOL5fSGN4
         Xxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=xNsE/Bbu2dvX/Ha3gyIv2jmuG0G/PodgUrz1gvCrWc0=;
        b=M2Dtwm8FjhzTLChqiCg1uRpHMRJEaSpnhV8gB3dD4qxh0Ap4MtBkGmTXOcBlS+Sm7E
         5pe1a8lH2/yvgEeB9cAN8cTwZNIGwdfqyo3uyhCX2Tt5m76hwfwCQo1z3nvAfu1tk53U
         2U0sYM6WHDoUHNrV+O3eydiCwcUpn2z6EWflsuPhc1030A3LERdrO5hZtziM0s2BAuhn
         VlYAjw70/u3C458y0LW/4oCrXFGkZKdBV7frs06XFlAaHox0Ls+/F+EL2u9SFtCJ+2yj
         iBCl6XqO9v8VQPdMcRSbbkB7vWj5LGcxgO3NUq4owAa5fPt0NCgLX7/0EK1XD7XIeib6
         syUw==
X-Gm-Message-State: AOAM5336pNM6F2BhB4iXlGk8vxeewydNkrhYTK+R7jo+x5phDkUDlBrQ
        gqCdC8I3HklJXj1W6yTozc+huhKF9zLjGVdi3Ai60dC17Di0VA==
X-Google-Smtp-Source: ABdhPJzR3oRq4h3J3Sg3x/yYyXtbOopZUpSumDMcINcZlwU4dCPzOQpc/Yyz7HPXo+j1UK/xhSw+ypKJKX/XvwWZdSI=
X-Received: by 2002:a37:4483:: with SMTP id r125mr7966120qka.387.1613703842127;
 Thu, 18 Feb 2021 19:04:02 -0800 (PST)
MIME-Version: 1.0
References: <CAOE4rSyacNvoACo7+CYc76=WFS6XYtKMJg9akV61qfnnR1uTGg@mail.gmail.com>
 <CAOE4rSy+u3gTvze0tbOhw7TbVEMnq65jmF8=RsdxNrYvwk5HAA@mail.gmail.com>
In-Reply-To: <CAOE4rSy+u3gTvze0tbOhw7TbVEMnq65jmF8=RsdxNrYvwk5HAA@mail.gmail.com>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Fri, 19 Feb 2021 05:03:50 +0200
Message-ID: <CAOE4rSzNTKBwL32iVDJBXtkZVZF_9w6KK55Z-5u6ZTqgXh1vnA@mail.gmail.com>
Subject: Re: ERROR: failed to read block groups: Input/output error
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

ceturtd., 2021. g. 14. janv., plkst. 01:39 =E2=80=94 lietot=C4=81js D=C4=81=
vis Mos=C4=81ns
(<davispuh@gmail.com>) rakst=C4=ABja:
>
> >
> > Hi,
> >
> > I've 6x 3TB HDD RAID1 BTRFS filesystem where HBA card failed and
> > caused some corruption.
> > When I try to mount it I get
> > $ mount /dev/sdt /mnt
> > mount: /mnt/: wrong fs type, bad option, bad superblock on /dev/sdt,
> > missing codepage or helper program, or other error
> > $ dmesg | tail -n 9
> > [  617.158962] BTRFS info (device sdt): disk space caching is enabled
> > [  617.158965] BTRFS info (device sdt): has skinny extents
> > [  617.756924] BTRFS info (device sdt): bdev /dev/sdl errs: wr 0, rd
> > 0, flush 0, corrupt 473, gen 0
> > [  617.756929] BTRFS info (device sdt): bdev /dev/sdj errs: wr 31626,
> > rd 18765, flush 178, corrupt 5841, gen 0
> > [  617.756933] BTRFS info (device sdt): bdev /dev/sdg errs: wr 6867,
> > rd 2640, flush 178, corrupt 1066, gen 0
> > [  631.353725] BTRFS warning (device sdt): sdt checksum verify failed
> > on 21057101103104 wanted 0x753cdd5f found 0x9c0ba035 level 0
> > [  631.376024] BTRFS warning (device sdt): sdt checksum verify failed
> > on 21057101103104 wanted 0x753cdd5f found 0xb908effa level 0
> > [  631.376038] BTRFS error (device sdt): failed to read block groups: -=
5
> > [  631.422811] BTRFS error (device sdt): open_ctree failed
> >
> > $ uname -r
> > 5.9.14-arch1-1
> > $ btrfs --version
> > btrfs-progs v5.9
> > $ btrfs check /dev/sdt
> > Opening filesystem to check...
> > checksum verify failed on 21057101103104 found 000000B9 wanted 00000075
> > checksum verify failed on 21057101103104 found 0000009C wanted 00000075
> > checksum verify failed on 21057101103104 found 000000B9 wanted 00000075
> > Csum didn't match
> > ERROR: failed to read block groups: Input/output error
> > ERROR: cannot open file system
> >
> > $ btrfs filesystem show
> > Label: 'RAID'  uuid: 8aef11a9-beb6-49ea-9b2d-7876611a39e5
> > Total devices 6 FS bytes used 4.69TiB
> > devid    1 size 2.73TiB used 1.71TiB path /dev/sdt
> > devid    2 size 2.73TiB used 1.70TiB path /dev/sdl
> > devid    3 size 2.73TiB used 1.71TiB path /dev/sdj
> > devid    4 size 2.73TiB used 1.70TiB path /dev/sds
> > devid    5 size 2.73TiB used 1.69TiB path /dev/sdg
> > devid    6 size 2.73TiB used 1.69TiB path /dev/sdc
> >
> >
> > My guess is that some drives dropped out while kernel was still
> > writing to rest thus causing inconsistency.
> > There should be some way to find out which drives has the most
> > up-to-date info and assume those are correct.
> > I tried to mount with
> > $ mount -o ro,degraded,rescue=3Dusebackuproot /dev/sdt /mnt
> > but that didn't make any difference
> >
> > So any idea how to fix this filesystem?
> >
> > Thanks!
> >
> > Best regards,
> > D=C4=81vis
>
> By the way
>
> $ btrfs-find-root /dev/sdt
> ERROR: failed to read block groups: Input/output error
> Superblock thinks the generation is 2262739
> Superblock thinks the level is 1
> Found tree root at 21057011679232 gen 2262739 level 1
> Well block 21056933724160(gen: 2262738 level: 1) seems good, but
> generation/level doesn't match, want gen: 2262739 level: 1
> Well block 21056867319808(gen: 2262737 level: 1) seems good, but
> generation/level doesn't match, want gen: 2262739 level: 1
> Well block 21056855900160(gen: 2262736 level: 1) seems good, but
> generation/level doesn't match, want gen: 2262739 level: 1
> Well block 21056850739200(gen: 2120504 level: 0) seems good, but
> generation/level doesn't match, want gen: 2262739 level: 1
>
> $ btrfs restore -l /dev/sdt
> tree key (EXTENT_TREE ROOT_ITEM 0) 21057008975872 level 3
> tree key (DEV_TREE ROOT_ITEM 0) 21056861863936 level 1
> tree key (FS_TREE ROOT_ITEM 0) 21063463993344 level 1
> tree key (CSUM_TREE ROOT_ITEM 0) 21057010728960 level 3
> tree key (UUID_TREE ROOT_ITEM 0) 21061425545216 level 0
> tree key (262 ROOT_ITEM 0) 21063533002752 level 0
> tree key (263 ROOT_ITEM 0) 21058890629120 level 2
> tree key (418 ROOT_ITEM 0) 21057902198784 level 2
> tree key (421 ROOT_ITEM 0) 21060222500864 level 2
> tree key (427 ROOT_ITEM 0) 21061262114816 level 2
> tree key (428 ROOT_ITEM 0) 21061278040064 level 2
> tree key (440 ROOT_ITEM 0) 21061362417664 level 2
> tree key (451 ROOT_ITEM 0) 21061017174016 level 2
> tree key (454 ROOT_ITEM 0) 21559581114368 level 1
> tree key (455 ROOT_ITEM 0) 21079314776064 level 1
> tree key (456 ROOT_ITEM 0) 21058026831872 level 2
> tree key (457 ROOT_ITEM 0) 21060907909120 level 3
> tree key (497 ROOT_ITEM 0) 21058120990720 level 2
> tree key (571 ROOT_ITEM 0) 21058195668992 level 2
> tree key (599 ROOT_ITEM 0) 21058818015232 level 2
> tree key (635 ROOT_ITEM 0) 21056973766656 level 2
> tree key (638 ROOT_ITEM 0) 21061023072256 level 0
> tree key (676 ROOT_ITEM 0) 21061314330624 level 2
> tree key (3937 ROOT_ITEM 0) 21061408686080 level 0
> tree key (3938 ROOT_ITEM 0) 21079315841024 level 1
> tree key (3957 ROOT_ITEM 0) 21061419139072 level 2
> tree key (6128 ROOT_ITEM 0) 21061400018944 level 1
> tree key (8575 ROOT_ITEM 0) 21061023055872 level 0
> tree key (18949 ROOT_ITEM 1728623) 21080421875712 level 1
> tree key (18950 ROOT_ITEM 1728624) 21080424726528 level 2
> tree key (18951 ROOT_ITEM 1728625) 21080424824832 level 2
> tree key (18952 ROOT_ITEM 1728626) 21080426004480 level 3
> tree key (18953 ROOT_ITEM 1728627) 21080422105088 level 2
> tree key (18954 ROOT_ITEM 1728628) 21080424497152 level 2
> tree key (18955 ROOT_ITEM 1728629) 21080426332160 level 2
> tree key (18956 ROOT_ITEM 1728631) 21080423645184 level 2
> tree key (18957 ROOT_ITEM 1728632) 21080425316352 level 2
> tree key (18958 ROOT_ITEM 1728633) 21080423972864 level 2
> tree key (18959 ROOT_ITEM 1728634) 21080422400000 level 2
> tree key (18960 ROOT_ITEM 1728635) 21080422662144 level 2
> tree key (18961 ROOT_ITEM 1728636) 21080423153664 level 2
> tree key (18962 ROOT_ITEM 1728637) 21080425414656 level 2
> tree key (18963 ROOT_ITEM 1728638) 21080421171200 level 1
> tree key (18964 ROOT_ITEM 1728639) 21080423481344 level 2
> tree key (19721 ROOT_ITEM 0) 21076937326592 level 2
> checksum verify failed on 21057125580800 found 00000026 wanted 00000035
> checksum verify failed on 21057108082688 found 00000074 wanted FFFFFFC5
> checksum verify failed on 21057108082688 found 000000ED wanted FFFFFFC5
> checksum verify failed on 21057108082688 found 00000074 wanted FFFFFFC5
> Csum didn't match

From what I understand it seems that some EXTENT_ITEM is corrupted and
when mount tries to read block groups it encounters csum mismatch for
it and immediatly aborts.
Is there some tool I could use to check this EXTENT_ITEM and see if it
can be fixed or maybe just removed?
Basically I guess I need to find physical location on disk from this
block number.
Also I think ignoring csum for btrfs inspect would be useful.

$ btrfs inspect dump-tree -b 21057050689536 /dev/sda
btrfs-progs v5.10.1
node 21057050689536 level 1 items 281 free space 212 generation
2262739 owner EXTENT_TREE
node 21057050689536 flags 0x1(WRITTEN) backref revision 1
fs uuid 8aef11a9-beb6-49ea-9b2d-7876611a39e5
chunk uuid 4ffec48c-28ed-419d-ba87-229c0adb2ab9
[...]
key (19264654909440 EXTENT_ITEM 524288) block 21057101103104 gen 2262739
[...]


$ btrfs inspect dump-tree -b 21057101103104 /dev/sda
btrfs-progs v5.10.1
checksum verify failed on 21057101103104 found 000000B9 wanted 00000075
checksum verify failed on 21057101103104 found 0000009C wanted 00000075
checksum verify failed on 21057101103104 found 000000B9 wanted 00000075
Csum didn't match
ERROR: failed to read tree block 21057101103104


Thanks!
