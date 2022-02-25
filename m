Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8DC4C41B8
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Feb 2022 10:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239233AbiBYJqU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Feb 2022 04:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbiBYJqS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Feb 2022 04:46:18 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1893E239D53
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Feb 2022 01:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645782343;
        bh=eJC8bbdc5WMC9fz0hqD9chLHCZ33XvzB+zePZb/Zkqc=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=RCgLE5Xt2U3RqsQVBeiu8OuyD8e/VfP3BRMvHCY4I3UrDCMq+Yaiqtqo2+ue8b1bg
         UwUlhF84UzOkUXoQKdOL5ks/rNCF0Wsd3BoY7tUYFZe0v8NiTsZyC5uHoEZbuZwzOE
         3XgUJro2EdBymXE+sPHhWVmN0OjOP1CgL42BQoLw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MwQXH-1oFdDu0QUP-00sMQ7; Fri, 25
 Feb 2022 10:45:43 +0100
Message-ID: <7a8d1bb6-ac56-4c4e-98de-0d9c540052be@gmx.com>
Date:   Fri, 25 Feb 2022 17:45:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Can't mount btrfs, super_num_devices mismatch with num_devices..
Content-Language: en-US
To:     =?UTF-8?Q?Luca_B=c3=a9la_Palkovics?= 
        <luca.bela.palkovics@gmail.com>, linux-btrfs@vger.kernel.org
References: <CA+8xDSpvdm_U0QLBAnrH=zqDq_cWCOH5TiV46CKmp3igr44okQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CA+8xDSpvdm_U0QLBAnrH=zqDq_cWCOH5TiV46CKmp3igr44okQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/WQ02hHW/P7Vz4XSAZaqHIL1xthy9NbYb92nBnC0j8Tk9v9hpMU
 BytBh5srtsuYmdV1BaIwpDXDj/78gwNoR8m7Xn21ZuPqi7D3LYkRcwmjHuM48Nb3C4GIxmx
 giBbLU0kcsyehsL6KG1JjERMvHkOzvvn9NyW8cFqEOD4JOuyOjbxThUGNiSOPV+h+GlIkbF
 dFrG/FutTjrz+2km+oG9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GE5RbpDM3ok=:bHbnaCGKjUNFk7teeF61fp
 V95jENdY0i7qCWBipXaqyOie/gLDaVoVX39pr4jltwMqP3Cf08CnhgR0a2tULC4p2SR951e0L
 CN0ZE6vLrAGKX+DAyX4m29mEWPTudOrYpNcszbWqU7Xc8eB23BjrbsSoE2gpSrwcSA86oPAnk
 ELWZNsjRZD90/iFhW7n7/bIsTY6d0nFKuTN0qoi84a86eo4QcIaNDgocp0WH7AEap21FuOWK6
 e6ULMT1kFtbrIMfmGuZCaV307DP/LKrqhF8BgI1p5wgnqNRdSLmHf/s/j7UuJ4jYmuOljWd2F
 rtBf7qolWFhl58tfLM9uGHYn8MgTz6pEYXnnXKXdOfBH2IWbG1RVcUzZwv6K/Nl1yZ1o9HCIx
 1EVGw4onrj+NWG/OOST1zpdO/yjSYkPvHuOW/xJxHlTjZGnijK0ej/ipzr1n7n2PnUtuthbdY
 qX/45yoWyyShQqxgoRUuO9SoD5RZpSNTyrsZv4HFxLD+RMVyyDzEJcmKrIFUjYztIKjNqeuur
 Pa00aQjU6ckpb/Svpwpoyx88YulHSjNPU/bSNccnXrxYoYYMvWLeGdcoEAYMX14e8sIPO8Jke
 L1FWS1Y5CXxLyQTBucMRjH8/Vjrkln1U9tsw0OpZqOWvogFwMZy10RHlhMYXV5KtM9OYFL0YG
 MWjIY0lqWSt6PQKXedjk1dEj/9A1fyjX6NdhkKo4hYVG8nYHUhltA8ILknyhX4DtTIsGHEj0v
 8zmUlFoC/F2Rq7YxAcv2EtqL65c1tfNgtXkgmixJaGR6eM9H0OKWzuJM9pTvB0AvrtwS6Z4Rj
 mdPcvY3edgAj5Gr2JW99+MyU/9TL7pXKUOR48a5qDUOr0Rp+8MaqeHDDyWHNvaukpN0g3XRnP
 EhZPdr6vGge+o40e85TqtrmUio7QMh8N9Aj1M0ibXRQqH1XS0tugIY9IUaktaRSxekOoZfzDc
 JEz8yEgkCW9r9q9t2XRj5ObSrtkMNi7C56gH9xmZ6FkdIfRJcLauYGJcU376C7OgbiNz8bSHy
 GFsTIo6gmHn4OnGmPNs7n+v+abNspt5zGWHQAvrNAfbNr5pUKaVl/WhiUChyJSQuDAJ4eZwVe
 3Lmc1qeUyMyR5E=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/25 16:50, Luca B=C3=A9la Palkovics wrote:
> Hi,
>
> when I try to mount btrfs (RAID1 mode)
> I get the following error:
>
> BTRFS error (device sdd3): super_num_devices 3 mismatch with
> num_devices 2 found here

By somehow the chunk tree has the device removed but not the superblock.

> BTRFS error (device sdd3): failed to read chunk tree: -22
> BTRFS error (device sdd3): open_ctree failed
>
> Mounting with -o degraded gives the same error..
>
> I would be grateful for any advice on how to fix this probleme.
>
> How got to this state:
>
> device 2 was "missing"
> btrfs replace didn't work... (mismatch with fs_devices total_rw_bytes)
>
> so I did (in initramfs):
>
> # mount -o degraded /dev/sdd3 /mnt
> # btrfs device add /dev/sdf3 /mnt
> # btrfs device remove 2 /mnt
> # CTRL + ALT + DEL (reboot)
>
> Here some infos
>
> # uname -a
> Linux ? 5.13.19-4-pve #1 SMP PVE 5.13.19-9 (Mon, 07 Feb 2022 11:01:14
> +0100) x86_64 GNU/Linux
>
> # btrfs --version
> btrfs-progs v5.10.1
>
> # btrfs filesystem show
> Label: none  uuid: e3c0acd3-1411-44e9-be74-110d3937cd18
> Total devices 3 FS bytes used 138.27GiB
>      devid    1 size 850.00GiB used 141.07GiB path /dev/sdd3
>      devid    3 size 850.00GiB used 139.03GiB path /dev/sdf3
>      *** Some devices missing
>
> The " *** Some devices missing" is devid 2 .. btrfs device remove
> didn't work correctly??
> Should I have "umount"ed before "CTRL + ALT + DEL"?
>
> # btrfs check /dev/sdd3
> Opening filesystem to check...
> Checking filesystem on /dev/sdd3
> UUID: e3c0acd3-1411-44e9-be74-110d3937cd18
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 148463915008 bytes used, no error found
> total csum bytes: 144303168
> total tree bytes: 549797888
> total fs tree bytes: 210288640
> total extent tree bytes: 178585600
> btree space waste bytes: 129766772
> file data blocks allocated: 546983469056
>   referenced 133358051328

Fs is completely fine.

So it's just to change the device number of that super block.

Will craft a patch to re-calculate the device number of the super block
for btrfs-check --repair.

Thanks,
Qu

>
> # btrfs rescue super-recover -v /dev/sdd3
> All Devices:
>      Device: id =3D 3, name =3D /dev/sdf3
>      Device: id =3D 1, name =3D /dev/sdd3
>
> Before Recovering:
>      [All good supers]:
>          device name =3D /dev/sdf3
>          superblock bytenr =3D 65536
>
>          device name =3D /dev/sdf3
>          superblock bytenr =3D 67108864
>
>          device name =3D /dev/sdf3
>          superblock bytenr =3D 274877906944
>
>          device name =3D /dev/sdd3
>          superblock bytenr =3D 65536
>
>          device name =3D /dev/sdd3
>          superblock bytenr =3D 67108864
>
>          device name =3D /dev/sdd3
>          superblock bytenr =3D 274877906944
>
>      [All bad supers]:
>
> All supers are valid, no need to recover
>
> # btrfs-find-root /dev/sdd3
> Superblock thinks the generation is 30491
> Superblock thinks the level is 1
> Found tree root at 371244793856 gen 30491 level 1
> Well block 371244433408(gen: 30490 level: 1) seems good, but
> generation/level doesn't match, want gen: 30491 level: 1
> Well block 371243958272(gen: 30489 level: 1) seems good, but
> generation/level doesn't match, want gen: 30491 level: 1
> Well block 371243597824(gen: 30488 level: 1) seems good, but
> generation/level doesn't match, want gen: 30491 level: 1
> Well block 371243270144(gen: 30487 level: 1) seems good, but
> generation/level doesn't match, want gen: 30491 level: 1
> Well block 371242909696(gen: 30486 level: 1) seems good, but
> generation/level doesn't match, want gen: 30491 level: 1
> Well block 371242631168(gen: 30485 level: 1) seems good, but
> generation/level doesn't match, want gen: 30491 level: 1
> Well block 371242074112(gen: 30484 level: 1) seems good, but
> generation/level doesn't match, want gen: 30491 level: 1
> Well block 371241648128(gen: 30483 level: 1) seems good, but
> generation/level doesn't match, want gen: 30491 level: 1
> Well block 371241287680(gen: 30482 level: 1) seems good, but
> generation/level doesn't match, want gen: 30491 level: 1
> Well block 371061211136(gen: 30481 level: 1) seems good, but
> generation/level doesn't match, want gen: 30491 level: 1
> Well block 371059965952(gen: 30480 level: 1) seems good, but
> generation/level doesn't match, want gen: 30491 level: 1
> Well block 370507628544(gen: 30479 level: 1) seems good, but
> generation/level doesn't match, want gen: 30491 level: 1
> Well block 370504892416(gen: 30478 level: 0) seems good, but
> generation/level doesn't match, want gen: 30491 level: 1
> Well block 220147482624(gen: 29108 level: 1) seems good, but
> generation/level doesn't match, want gen: 30491 level: 1
>
> best regards,
> Luca B=C3=A9la Palkovics
