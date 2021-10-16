Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B9942FFAE
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Oct 2021 04:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239544AbhJPByw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Oct 2021 21:54:52 -0400
Received: from mout.gmx.net ([212.227.17.21]:58895 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232812AbhJPByv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Oct 2021 21:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634349162;
        bh=4ftesZfNm/eRfoK9w4ks7N7528Hh98pL1Hx4EPDIprs=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=O8nn7NJ7D2/Jp8xLImbHmBQ1fiynHU55vNhbsKknQKMBroi6ObZHMTD+Bq5Oapcuj
         dAmfx3NBeBNCuM1jQL7WtZuD/Eo5U3u26m1LgSIITjrP2rbdxvsX63PgIEnij3ZGWF
         3DPFcEYUuY3lPFXh89bDvWDLhwsVXPowB1G60FBE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuUjC-1msoqO02a2-00radA; Sat, 16
 Oct 2021 03:52:42 +0200
Message-ID: <637a43e5-4d6f-f69a-74e4-ae240880aa1b@gmx.com>
Date:   Sat, 16 Oct 2021 09:52:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: csum failed, bad tree, block, IO failures. Is my drive dead or
 has my BTRFS broke itself?
Content-Language: en-US
To:     James Harvey <jmsharvey771@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAHB2pq_Dhp7X0zRQhzbtMxKP8rC=Z8DvAaB33EF56jZHg0=+rA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAHB2pq_Dhp7X0zRQhzbtMxKP8rC=Z8DvAaB33EF56jZHg0=+rA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Icw/v3M3X7n8aT8GMTzwLOHIp1t5L6u49s7ovDLW/cDzWuLDvGX
 rNh9HEF1nNASXv0W0JluPxs5Pz1SsvOdIrRVFUQSCoOYUvEYXgHSkGtdgaLXEZusGVDOfgR
 ajpZxMjSNzdhGfeGrrUE2JteSmxcuy6AjLCrbgrd38BKnpkHNr45No2jymKcmfFzN+r4mE7
 l1Y1LjQKqddkqrsYxy6rA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RQUhoabD5GY=:TGJ78IBMsnBaOkievkE5Gc
 +woxrwr2hlam3Qy5FFCwq/vEYOeGPvQj7Kl7f5DkPBsK3gqRn0foVawxh9quiFnsrpIEa18c0
 /MC3XPYlHxFMaTwKtTx8CNAU4h9jW5EkAQLz2hdYJaa1WMxRru7ZiV/d1p7s24ZFe2m8b7rZE
 MRUSfI3UGaXwX+XM+Wd+UqMs6FRG/3r1rJexOfwp/fVTNCPaUZbuc3LgykLC63Bt449Nkv05R
 poSFtIlGLfI1daPcr5KZjkPcR1+Ql2n0l0Km2rSGs2PYWpBnCpXTl9YNjKRkJzooZLCpEi05f
 69cgsZGdtTwPnKp1B4ujP/NHbJPX5IkcM2uKXclnz7zlxAJwLoT1GpvTpcZfNX9laMYD5YEX8
 kyNit3TdKTVNxDRtP+jCgVpuS5N3hFGbJipirfwRtkBNOUFKqj+LAhReg7GEURuk/XEb7UNRo
 mrxtr6sWkxW3vpw+L7sNvJmCWpZssEZ/AYR136PPe27nbNOjByRKFizrKdqQ387VYz4QrxnbD
 Uk5r30Z2jX1xHYur+AZsPMws4xQUu0hAEljRFv/IKkCiU6Vw9F3HJ/KsiJDVRuKwalShHrf6M
 vuzVwhIwcKM7SMkGAnyuHOx3m2ptMEjGU8sZQz9iMRg71AL8odcTt19P66sVc2OcoBb1QSLuC
 T2O8zt/Euwj2280YC6Cdb4t9+seSZn+K7FMEcCTPXzepmjNptyCPvLc0xzYBt8yn0EcB08pSD
 rZJvxcy1TATLqgLz3ezTK/fYppjLm/NW2UcOwOsuaGtdI0TMRvpDkGXoQZ32qJLWwpxN9dswD
 K96abL/zxX+HG76Kj5FTl78GbEY3Yv7864JOpJNkc/rkxE069+k0E+nEOvwIVTUgTQyyxiCaY
 WqZ3mypJ7OOQayLA8etNg9V/+0tjU0R0/qQeqYBrkizO+xDeuDT1T8D0CF+hj6XZYCOx5vvmA
 9bx9fRih1fC/8+22Qxa/yAJgpLtQGJiDk9O6PbBrM4XKUe6BMCzjg8ivwEzEEGrHQtQ668utV
 nQihHBpHgPqUjji4iY748JzlwlcP8uiggDaOvWVtooqb6rsU1+F7ckx5j0GNo+L4SKn7pznsB
 2C+Ft3NdgMInPg=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/16 08:14, James Harvey wrote:
> My server consists of a single 16TB external drive (I have backups,
> and I was planning to make a proper server at some point) and I used
> BTRFS for the drive's filesystem. Recently, the file system would go
> into read only and put a load of errors into the system logs. Running
> a BTRFS scrub returned no errors, a readonly BTRFS check returned no
> errors, and a SMART check showed no issues/bad sectors.

This is very strange, as normally if there is really on-disk corruption,
especially in metadata, btrfs check should detect it.

> Has BTRFS
> broke itself or is this a drive issue:
>
> Here are the errors:

Could you please provide the full dmesg?

We want the context to see get a whole picture of the problem, not only
just error messages from btrfs.

If the problem only happens at write time, maybe you want to do a memory
test to verify it's not some bitflip in your memory in the mean time.

Thanks,
Qu
>
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> failed root 5 ino 97395 off 14105460736 csum 0x75ab540e expected csum
> 0xaeb99694 mirror 1
> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> failed root 5 ino 97395 off 14105464832 csum 0xe83b4c2a expected csum
> 0xb9a65172 mirror 1
> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> failed root 5 ino 97395 off 14105468928 csum 0x4769b37a expected csum
> 0x3598cf9e mirror 1
> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> failed root 5 ino 97395 off 14105473024 csum 0x7c39a990 expected csum
> 0x9c523a6c mirror 1
> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> failed root 5 ino 97395 off 14105477120 csum 0xfedc09f1 expected csum
> 0x68386e9a mirror 1
> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> failed root 5 ino 97395 off 14105481216 csum 0xf9f25835 expected csum
> 0x96d2dea3 mirror 1
> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 6, gen 0
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> failed root 5 ino 97395 off 14105485312 csum 0x37643155 expected csum
> 0x6139f8a1 mirror 1
> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> failed root 5 ino 97395 off 14105489408 csum 0x13893c06 expected csum
> 0xb28c00a8 mirror 1
> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> failed root 5 ino 97395 off 14105493504 csum 0x2a89fcff expected csum
> 0x4c5758ed mirror 1
> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> failed root 5 ino 97395 off 14105497600 csum 0x7484b77c expected csum
> 0x0a9f3138 mirror 1
> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
> tree block start, want 9343812173824 have 9856732008096476660
> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
> tree block start, want 9343806013440 have 757116834938933
> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
> tree block start, want 9343812173824 have 9856732008096476660
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> hole found for disk bytenr range [9622003011584, 9622003015680)
> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
> tree block start, want 9343806013440 have 757116834938933
> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
> tree block start, want 9343812173824 have 9856732008096476660
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
> csum 0xc096fec5 mirror 1
> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
> tree block start, want 9343812173824 have 9856732008096476660
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> hole found for disk bytenr range [9622003015680, 9622003019776)
> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
> tree block start, want 9343947784192 have 17536680014548819927
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
> csum 0xc096fec5 mirror 1
> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
> tree block start, want 9343812173824 have 9856732008096476660
> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
> tree block start, want 9343947784192 have 17536680014548819927
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> hole found for disk bytenr range [9644356001792, 9644356005888)
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
> csum 0xc096fec5 mirror 1
> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
> tree block start, want 9343812173824 have 9856732008096476660
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> hole found for disk bytenr range [9622003019776, 9622003023872)
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
> csum 0xc096fec5 mirror 1
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> hole found for disk bytenr range [9644356005888, 9644356009984)
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
> csum 0xc096fec5 mirror 1
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> hole found for disk bytenr range [9622003023872, 9622003027968)
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
> csum 0xc096fec5 mirror 1
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> hole found for disk bytenr range [9633973551104, 9633973555200)
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> hole found for disk bytenr range [9644356009984, 9644356014080)
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
> csum 0xc096fec5 mirror 1
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> hole found for disk bytenr range [9622003027968, 9622003032064)
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> hole found for disk bytenr range [9633973555200, 9633973559296)
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
> csum 0xc096fec5 mirror 1
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
> csum 0xc096fec5 mirror 1
> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
> csum 0xc096fec5 mirror 1
> Oct 14 21:50:41 James-Server kernel: BTRFS: error (device sdb1) in
> btrfs_finish_ordered_io:3064: errno=3D-5 IO failure
> Oct 14 21:50:41 James-Server kernel: BTRFS info (device sdb1): forced re=
adonly
>
> uname -a: Linux James-Server 5.14.11-arch1-1 #1 SMP PREEMPT Sun, 10
> Oct 2021 00:48:26 +0000 x86_64 GNU/Linux
>
> btrfs --version: btrfs-progs v5.14.2
>
> btrfs fi show:
>
> Label: 'Seagate 16TB 1'  uuid: e183a876-95e0-4d15-a641-69f4a8e8e7e7
>         Total devices 1 FS bytes used 9.61TiB
>         devid    1 size 14.55TiB used 9.62TiB path /dev/sdb1
>
> btrfs fi df:
>
> Data, single: total=3D9.60TiB, used=3D9.60TiB
> System, DUP: total=3D8.00MiB, used=3D1.09MiB
> Metadata, DUP: total=3D11.00GiB, used=3D10.74GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
> Mount options: rw,noatime,compress=3Dzstd:3,space_cache=3Dv2,autodefrag,=
subvolid=3D5,subvol=3D/
>
