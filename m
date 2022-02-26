Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0441A4C56BA
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Feb 2022 16:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiBZP4P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Feb 2022 10:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiBZP4O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Feb 2022 10:56:14 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3A113DE09
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Feb 2022 07:55:39 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z22so11429817edd.1
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Feb 2022 07:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZaEZkDxQsc83BRQ7DzVYV42z+cUfE+SXy0zsQ0kODdI=;
        b=Wse2CeFNk5M5PS4DQY0TkKyzJnlPeIUzmYrnFaCOZFVwO7T//4LIGEGJ8Df0wn28tB
         rzf4qkOK9WfcVY+ngYBs1qUs0yGJVfB5cHMhEviQTepMAnPsf4bXB27S8EbnHbOnGq/U
         jWasSWDEe6iBjqdhIjauhVqPQXEMHPJUQsQw8Vv0hqpOlGD+9luFknHFCEY++YFE0U7i
         Kc3bqpdqyMkPek0OFs1vXUK+mOIOPXeyxvIMQHX85vTyP0OYOOLwa3jLVZdFSK3+ombQ
         ooB+FxYxoMinIaLMnLuNi2T4ZOSRGCnZs5toNI+hEPxTQrOUZLDXbmqfEjFLz7z3dqET
         5RbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZaEZkDxQsc83BRQ7DzVYV42z+cUfE+SXy0zsQ0kODdI=;
        b=skMjX/KkGW+ZRvHmhCCMll8SdPsR0HGKrgPKA61PCq97PUVlyVFaQ++qq1pL85GsZ/
         q47rsGM5UQjDaDXbuc4fxFpjtOsQKAkEdcmA80SXpo/MK7OAXTJVAInQSdleRnqpZNfx
         zfzPLnjGi2cBQjOuoHDMnOoMmGmOGVQbvp8F+pAd3qAdDdjEXnc6FYzWBdm8xSGb59Uv
         OsKJlJ7lFC1ciLA/uJtEuIDivYOyO89VWSvaEQr+NVelyOMXb6rYcmt23h17rKOUiDqu
         pAoqTpenzJHdJzy4AHmU3A8f0T88MaC7pVCZij2qmqexqUIWfe+Cndw8dvus8V9CoO6L
         rd0w==
X-Gm-Message-State: AOAM533i7X1bCIQHh2FZWaFnMdqGWXZvBgzfM+t+83tpfnTyg3vSKT/T
        6ZlsQC/wiKXiC7yT75hzbAlyt9Uz01+EeaWL4xM=
X-Google-Smtp-Source: ABdhPJy/rtIqo0mYqpEHD/3Ak+rzoKqY9jJYdd5IM9b+cgRDHEEOCO70mRytfHLMrvAg+ZAmqHkls+VB3TlSgTQhPjw=
X-Received: by 2002:a05:6402:270b:b0:410:d71d:3f06 with SMTP id
 y11-20020a056402270b00b00410d71d3f06mr11569143edd.10.1645890937541; Sat, 26
 Feb 2022 07:55:37 -0800 (PST)
MIME-Version: 1.0
References: <CA+8xDSpvdm_U0QLBAnrH=zqDq_cWCOH5TiV46CKmp3igr44okQ@mail.gmail.com>
 <7a8d1bb6-ac56-4c4e-98de-0d9c540052be@gmx.com>
In-Reply-To: <7a8d1bb6-ac56-4c4e-98de-0d9c540052be@gmx.com>
From:   =?UTF-8?Q?Luca_B=C3=A9la_Palkovics?= 
        <luca.bela.palkovics@gmail.com>
Date:   Sat, 26 Feb 2022 16:55:26 +0100
Message-ID: <CA+8xDSq=gs=7wjNAiE1u80KYxmXt1e_HLhwZfGPvwHRKGgZ0mg@mail.gmail.com>
Subject: Re: Can't mount btrfs, super_num_devices mismatch with num_devices..
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Fr., 25. Feb. 2022 um 10:45 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.co=
m>:
>
>
>
> On 2022/2/25 16:50, Luca B=C3=A9la Palkovics wrote:
> > Hi,
> >
> > when I try to mount btrfs (RAID1 mode)
> > I get the following error:
> >
> > BTRFS error (device sdd3): super_num_devices 3 mismatch with
> > num_devices 2 found here
>
> By somehow the chunk tree has the device removed but not the superblock.
>
> > BTRFS error (device sdd3): failed to read chunk tree: -22
> > BTRFS error (device sdd3): open_ctree failed
> >
> > Mounting with -o degraded gives the same error..
> >
> > I would be grateful for any advice on how to fix this probleme.
> >
> > How got to this state:
> >
> > device 2 was "missing"
> > btrfs replace didn't work... (mismatch with fs_devices total_rw_bytes)
> >
> > so I did (in initramfs):
> >
> > # mount -o degraded /dev/sdd3 /mnt
> > # btrfs device add /dev/sdf3 /mnt
> > # btrfs device remove 2 /mnt
> > # CTRL + ALT + DEL (reboot)
> >
> > Here some infos
> >
> > # uname -a
> > Linux ? 5.13.19-4-pve #1 SMP PVE 5.13.19-9 (Mon, 07 Feb 2022 11:01:14
> > +0100) x86_64 GNU/Linux
> >
> > # btrfs --version
> > btrfs-progs v5.10.1
> >
> > # btrfs filesystem show
> > Label: none  uuid: e3c0acd3-1411-44e9-be74-110d3937cd18
> > Total devices 3 FS bytes used 138.27GiB
> >      devid    1 size 850.00GiB used 141.07GiB path /dev/sdd3
> >      devid    3 size 850.00GiB used 139.03GiB path /dev/sdf3
> >      *** Some devices missing
> >
> > The " *** Some devices missing" is devid 2 .. btrfs device remove
> > didn't work correctly??
> > Should I have "umount"ed before "CTRL + ALT + DEL"?
> >
> > # btrfs check /dev/sdd3
> > Opening filesystem to check...
> > Checking filesystem on /dev/sdd3
> > UUID: e3c0acd3-1411-44e9-be74-110d3937cd18
> > [1/7] checking root items
> > [2/7] checking extents
> > [3/7] checking free space cache
> > [4/7] checking fs roots
> > [5/7] checking only csums items (without verifying data)
> > [6/7] checking root refs
> > [7/7] checking quota groups skipped (not enabled on this FS)
> > found 148463915008 bytes used, no error found
> > total csum bytes: 144303168
> > total tree bytes: 549797888
> > total fs tree bytes: 210288640
> > total extent tree bytes: 178585600
> > btree space waste bytes: 129766772
> > file data blocks allocated: 546983469056
> >   referenced 133358051328
>
> Fs is completely fine.
>
> So it's just to change the device number of that super block.

I overwrote the num_devices of the superblock and recalculated the CRC.
Mounting the fs works now. "btrfs scrub" had no errors.

(Here is the script if somebody needs it..
https://gist.github.com/KoKuToru/e540af02e48952bdd39413b7034b83db)

> Will craft a patch to re-calculate the device number of the super block
> for btrfs-check --repair.
>
> Thanks,
> Qu
>
> >
> > # btrfs rescue super-recover -v /dev/sdd3
> > All Devices:
> >      Device: id =3D 3, name =3D /dev/sdf3
> >      Device: id =3D 1, name =3D /dev/sdd3
> >
> > Before Recovering:
> >      [All good supers]:
> >          device name =3D /dev/sdf3
> >          superblock bytenr =3D 65536
> >
> >          device name =3D /dev/sdf3
> >          superblock bytenr =3D 67108864
> >
> >          device name =3D /dev/sdf3
> >          superblock bytenr =3D 274877906944
> >
> >          device name =3D /dev/sdd3
> >          superblock bytenr =3D 65536
> >
> >          device name =3D /dev/sdd3
> >          superblock bytenr =3D 67108864
> >
> >          device name =3D /dev/sdd3
> >          superblock bytenr =3D 274877906944
> >
> >      [All bad supers]:
> >
> > All supers are valid, no need to recover
> >
> > # btrfs-find-root /dev/sdd3
> > Superblock thinks the generation is 30491
> > Superblock thinks the level is 1
> > Found tree root at 371244793856 gen 30491 level 1
> > Well block 371244433408(gen: 30490 level: 1) seems good, but
> > generation/level doesn't match, want gen: 30491 level: 1
> > Well block 371243958272(gen: 30489 level: 1) seems good, but
> > generation/level doesn't match, want gen: 30491 level: 1
> > Well block 371243597824(gen: 30488 level: 1) seems good, but
> > generation/level doesn't match, want gen: 30491 level: 1
> > Well block 371243270144(gen: 30487 level: 1) seems good, but
> > generation/level doesn't match, want gen: 30491 level: 1
> > Well block 371242909696(gen: 30486 level: 1) seems good, but
> > generation/level doesn't match, want gen: 30491 level: 1
> > Well block 371242631168(gen: 30485 level: 1) seems good, but
> > generation/level doesn't match, want gen: 30491 level: 1
> > Well block 371242074112(gen: 30484 level: 1) seems good, but
> > generation/level doesn't match, want gen: 30491 level: 1
> > Well block 371241648128(gen: 30483 level: 1) seems good, but
> > generation/level doesn't match, want gen: 30491 level: 1
> > Well block 371241287680(gen: 30482 level: 1) seems good, but
> > generation/level doesn't match, want gen: 30491 level: 1
> > Well block 371061211136(gen: 30481 level: 1) seems good, but
> > generation/level doesn't match, want gen: 30491 level: 1
> > Well block 371059965952(gen: 30480 level: 1) seems good, but
> > generation/level doesn't match, want gen: 30491 level: 1
> > Well block 370507628544(gen: 30479 level: 1) seems good, but
> > generation/level doesn't match, want gen: 30491 level: 1
> > Well block 370504892416(gen: 30478 level: 0) seems good, but
> > generation/level doesn't match, want gen: 30491 level: 1
> > Well block 220147482624(gen: 29108 level: 1) seems good, but
> > generation/level doesn't match, want gen: 30491 level: 1
> >
> > best regards,
> > Luca B=C3=A9la Palkovics
