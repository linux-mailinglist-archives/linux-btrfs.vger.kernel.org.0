Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090B04C407C
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Feb 2022 09:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbiBYIuq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Feb 2022 03:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbiBYIup (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Feb 2022 03:50:45 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21D11768D2
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Feb 2022 00:50:13 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id p15so9429696ejc.7
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Feb 2022 00:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=y8C5VpUu6XrAnLs3C7riu3VGzkYoXAri6/ITDHQ+4w4=;
        b=EmW605wTVdP7yo6qXTQlTvZgKfZGod1eQnKAKYonYl0DwKRCfOJAbmdIoobPCDFylT
         k1BYvTcDZ6Tr9BDaFQFpa+GWOL2E5xJpu+3Yha+e5M4d4pfqLubhier9cL1eH7m2rY3K
         UTFqw0apQGw/q5WucsLx8lYeqWLFoOKaKZnGnl6E+8GO538EoA38lplP5xJYYmWdPI6Z
         PBH6YOSjC907RsNH5GSgWrdrjBW+2ENwZBZJmKn6zjs9vGj+FFo5p3CaUIXJFs5zyOZ1
         ZLcFfkazZ2qaDQwJMILns4LeOoyt/UjphUYMALJgoQmGMbPeGQScE3UrjN3zRwMs7Rn3
         XQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=y8C5VpUu6XrAnLs3C7riu3VGzkYoXAri6/ITDHQ+4w4=;
        b=0Qp5BodUeRsdjJOQ8LrZkt6crk0eBzuLcMJlO5Xa2bK/tdcpCI21i70rGctOIo0Ph3
         4cbNA/AvLeiIGSqUca/R+B/54PAcxXHzdRay2wBllbws4nTmZTnhRCMH+/AzgPLg4Owh
         sreypWENqLH9L4Ay/d34tPtqLxSnqs+mXg154Wd2fuENzCj4Atyumb0c+GcEDmr/J7J9
         2tOFaz8NHmw/hJW03k/kFFEZRNLFPlu5yMSRUe+R9ZRh3mcFPa/OA8XPJuT+Q14AwW87
         1wmkb8v9Phwh6Q02SVv4w6PCt4+DFXWVHgs5ayeitodWGJg97qpdOUhocD7Qqm5XHTnf
         9e/g==
X-Gm-Message-State: AOAM531WPqUFakQohD9ASPUp/ZM0JHGqnNs5gVhkD6CKotJ6PAEhnQbW
        ATEsNLRsCi7OGpMfHVKlT00zw1+Nj0eBhd4Ib+I5CZzlEkI=
X-Google-Smtp-Source: ABdhPJzC0sx5t+0YDMBQO0XGn6CKru9HoLxQKQhDah8Sq6o/DhYKciqM1bgiNw1S3A/1Abpel6ra7gi592m9h8VZHWY=
X-Received: by 2002:a17:906:4d8d:b0:6ce:8c3d:6e81 with SMTP id
 s13-20020a1709064d8d00b006ce8c3d6e81mr5118619eju.205.1645779012436; Fri, 25
 Feb 2022 00:50:12 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Luca_B=C3=A9la_Palkovics?= 
        <luca.bela.palkovics@gmail.com>
Date:   Fri, 25 Feb 2022 09:50:01 +0100
Message-ID: <CA+8xDSpvdm_U0QLBAnrH=zqDq_cWCOH5TiV46CKmp3igr44okQ@mail.gmail.com>
Subject: Can't mount btrfs, super_num_devices mismatch with num_devices..
To:     linux-btrfs@vger.kernel.org
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

Hi,

when I try to mount btrfs (RAID1 mode)
I get the following error:

BTRFS error (device sdd3): super_num_devices 3 mismatch with
num_devices 2 found here
BTRFS error (device sdd3): failed to read chunk tree: -22
BTRFS error (device sdd3): open_ctree failed

Mounting with -o degraded gives the same error..

I would be grateful for any advice on how to fix this probleme.

How got to this state:

device 2 was "missing"
btrfs replace didn't work... (mismatch with fs_devices total_rw_bytes)

so I did (in initramfs):

# mount -o degraded /dev/sdd3 /mnt
# btrfs device add /dev/sdf3 /mnt
# btrfs device remove 2 /mnt
# CTRL + ALT + DEL (reboot)

Here some infos

# uname -a
Linux ? 5.13.19-4-pve #1 SMP PVE 5.13.19-9 (Mon, 07 Feb 2022 11:01:14
+0100) x86_64 GNU/Linux

# btrfs --version
btrfs-progs v5.10.1

# btrfs filesystem show
Label: none  uuid: e3c0acd3-1411-44e9-be74-110d3937cd18
Total devices 3 FS bytes used 138.27GiB
    devid    1 size 850.00GiB used 141.07GiB path /dev/sdd3
    devid    3 size 850.00GiB used 139.03GiB path /dev/sdf3
    *** Some devices missing

The " *** Some devices missing" is devid 2 .. btrfs device remove
didn't work correctly??
Should I have "umount"ed before "CTRL + ALT + DEL"?

# btrfs check /dev/sdd3
Opening filesystem to check...
Checking filesystem on /dev/sdd3
UUID: e3c0acd3-1411-44e9-be74-110d3937cd18
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 148463915008 bytes used, no error found
total csum bytes: 144303168
total tree bytes: 549797888
total fs tree bytes: 210288640
total extent tree bytes: 178585600
btree space waste bytes: 129766772
file data blocks allocated: 546983469056
 referenced 133358051328

# btrfs rescue super-recover -v /dev/sdd3
All Devices:
    Device: id =3D 3, name =3D /dev/sdf3
    Device: id =3D 1, name =3D /dev/sdd3

Before Recovering:
    [All good supers]:
        device name =3D /dev/sdf3
        superblock bytenr =3D 65536

        device name =3D /dev/sdf3
        superblock bytenr =3D 67108864

        device name =3D /dev/sdf3
        superblock bytenr =3D 274877906944

        device name =3D /dev/sdd3
        superblock bytenr =3D 65536

        device name =3D /dev/sdd3
        superblock bytenr =3D 67108864

        device name =3D /dev/sdd3
        superblock bytenr =3D 274877906944

    [All bad supers]:

All supers are valid, no need to recover

# btrfs-find-root /dev/sdd3
Superblock thinks the generation is 30491
Superblock thinks the level is 1
Found tree root at 371244793856 gen 30491 level 1
Well block 371244433408(gen: 30490 level: 1) seems good, but
generation/level doesn't match, want gen: 30491 level: 1
Well block 371243958272(gen: 30489 level: 1) seems good, but
generation/level doesn't match, want gen: 30491 level: 1
Well block 371243597824(gen: 30488 level: 1) seems good, but
generation/level doesn't match, want gen: 30491 level: 1
Well block 371243270144(gen: 30487 level: 1) seems good, but
generation/level doesn't match, want gen: 30491 level: 1
Well block 371242909696(gen: 30486 level: 1) seems good, but
generation/level doesn't match, want gen: 30491 level: 1
Well block 371242631168(gen: 30485 level: 1) seems good, but
generation/level doesn't match, want gen: 30491 level: 1
Well block 371242074112(gen: 30484 level: 1) seems good, but
generation/level doesn't match, want gen: 30491 level: 1
Well block 371241648128(gen: 30483 level: 1) seems good, but
generation/level doesn't match, want gen: 30491 level: 1
Well block 371241287680(gen: 30482 level: 1) seems good, but
generation/level doesn't match, want gen: 30491 level: 1
Well block 371061211136(gen: 30481 level: 1) seems good, but
generation/level doesn't match, want gen: 30491 level: 1
Well block 371059965952(gen: 30480 level: 1) seems good, but
generation/level doesn't match, want gen: 30491 level: 1
Well block 370507628544(gen: 30479 level: 1) seems good, but
generation/level doesn't match, want gen: 30491 level: 1
Well block 370504892416(gen: 30478 level: 0) seems good, but
generation/level doesn't match, want gen: 30491 level: 1
Well block 220147482624(gen: 29108 level: 1) seems good, but
generation/level doesn't match, want gen: 30491 level: 1

best regards,
Luca B=C3=A9la Palkovics
