Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C7E410133
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Sep 2021 00:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344725AbhIQWUF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 18:20:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:53401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344670AbhIQWUF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 18:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631917120;
        bh=Nke2XFiA3pSTscCYSVZ0pVbI1skqUHvDs5sqgfUV8Kw=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=lycV8wO+DdWJmXOXRL8QEcZF4VirY8yVHTOxVK50zzcgZF+4ua8yScYHZUMZJo5G4
         Clgkl5D9p7PtEFIOh0LNXgZuX2G+w0In/bl3ihJn7SLkh2ZXo+J99Ya4uG9nf+nyXw
         c5aDBvvx36pGfv9koaXFllN9a4+CPhWeGb4Yuwws=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5mGB-1myrjA3hIB-017Ahx; Sat, 18
 Sep 2021 00:18:40 +0200
Message-ID: <baf97f70-9592-1a8f-972b-e77c4ef01a8c@gmx.com>
Date:   Sat, 18 Sep 2021 06:18:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Unable to mount btrfs subvol with a new kernel
Content-Language: en-US
To:     mailcimbi <mailcimbi@gmail.com>, linux-btrfs@vger.kernel.org
References: <9c56dfca-2551-22a8-e6eb-86f0614bc5a8@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <9c56dfca-2551-22a8-e6eb-86f0614bc5a8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UHqUknAarTm8fgPmzPv33PmtC230xvC5OyDDM34rfai76I+n+OB
 Yz3AVJqVh4oVFEpeLjo0q4XExY0oahDbv5VsuIktfUT1YerZi0Inv1nQFa8wTrbXTyL7Sq5
 FCvS0/vcJCs1QP5cyDxlS5tY6/Mf0OKOoF56u834YTiyjVu5qjWfhQ6YyAEmKgl6Qg+9JE9
 nRCTlQ5fJ/xafbjHNDjxQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xZxaazjSPhI=:yr3dMrHFWRwr70Ye26BvLq
 8w5DPCiLiqnSA2sWwISAD9DhfQ5u6GjhqSMcKrk58cx8iJ1gfV/8LIz1ERzuFDLVXUCodiMiE
 RTp9Aok5zoyFM1UHiXT7HeRSiCwG1mdWsin6kozfY1ggmIlz2dbVAtkGgRAcJ1k+1t9pgUA1z
 1vF8e//TAnFzULwuVkKnrh4x8L2AbGxkYfYVVa7MWBSP+lg+8CPb+NEXUUot9wZfViZQcQHHM
 aOrw4YSWEtUXPnOIUnSBhSvwVrP+DdeKEhLOiigL6RkYw+c0vusMKO+XerPJ7uqto7FYpaizk
 vqcGPIb2dcKfMlBTXNkD3K3ylsYLnumcZ6ih8JyI1bicyZPKjKPLnwD98LbvAgrlZ+uUGNmEs
 SJjzzny5dQnBz3qT0qCTjti8WxhXCedJV6DFCR48J8bU94Ts2HWXp7n8CKaVRb1ePOpFT5NpH
 AnakWIPYLrPUIWstZUhcPpAjPti/WxbULo9zd7h9DwEaaOZIYGZXanlAfRircDJs/V0kdXQiv
 82krJIZfmLIFIVdfpM1p5U2Okr30iSgkh9E/FKfrMS4pj+YqCoDVLncEO9pp9ULji7VNjLwWl
 NYGL4aQfZIVKrpTFSng00Mv1RPDCqtmct5026A6avKDTPY+aya1ovh4ibqmgV5XzogG0Rnppv
 ZXUQlPt7JO1UWHShq+Y35MXUrXH+/n999GfTsP0Lho+M71xzZaqF+yoVfPVy6TGjcey+g3LzS
 87gqxWUAvXHqaXP3JAuyzIfdtOi58KQe5z2W+c1Sqr8A4o97chba5E4MG23KL5rKoN0mUIbLU
 W6vv4g2A3N8zdzrTcBKaBvagVuoyGINHB9jGo+5W4aoIYjyFv/IKJif7QIo2FomS7Q0CNFJlj
 LlQ5/I8wOLVu4m47G4vK2CJEQjagmdk/XT8S027oqgKi8WEnYmV0eI8Ws2NlPh3vsEMUrv7v7
 uiHC0ZTbK8KqQexEUi7jBxrQaEh9HcYG9ar+40c9ZnUBS7ym/0YNGX/C/NaB7Uq/V/1B7L5HU
 fng3ZdNEev0spXEfsZJ+WnLy7xj2NZn3Mdv7N4m7XJhui4TGsawMbvdvbdM8FCie0XR6dN/bs
 ICW5rIDMcpnbAc=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/18 00:17, mailcimbi wrote:
> Dear List,
>
> I have two btrfs subvol in my fileset. I can mount it with lubuntu 18.04
> but unable to mount with a newer version. Also unable to mount it when I
> upgrade to the latest 18.04. By the way upgrading to 20.04 (using the
> older kernel after upgrading to the latest 18.04) and starting it with
> an older kernel it is working.
>
> I can reproduce it. Starting with lubuntu 21.04 live cd: unable to
> mount. Starting with lubuntu 18.04.2 live cd: I can mount it.
>
> Here are the results:
> lubuntu 18.04
> root@lubuntu:~# uname -a
> Linux lubuntu 4.18.0-15-generic #16~18.04.1-Ubuntu SMP Thu Feb 7
> 14:06:04 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
> mounted btrfs with live cd
> root@lubuntu:~# mount -t btrfs -o rw,subvol=3D@ /dev/sda3 /mnt
> /dev/sda3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 28G=C2=A0=C2=A0 14G=
=C2=A0=C2=A0 12G=C2=A0 55% /mnt
> root@lubuntu:~# mount -t btrfs -o rw,subvol=3D@home /dev/sda3 /mnt/home
> /dev/sda3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 28G=C2=A0=C2=A0 14G=
=C2=A0=C2=A0 12G=C2=A0 55% /mnt/home
> root@lubuntu:~# btrfs version
> btrfs-progs v4.15.1
>
>
> lubuntu 20.04
> root@lubuntu:~# uname -a
> Linux lubuntu 5.4.0-42-generic #46-Ubuntu SMP Fri Jul 10 00:24:02 UTC
> 2020 x86_64 x86_64 x86_64 GNU/Linux
> root@lubuntu:~# mount -t btrfs -o rw,subvol=3D@ /dev/sda3 /mnt
> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda3,
> missing codepage or helper program, or other error.
> root@lubuntu:~# btrfs version
> btrfs-progs v5.10.1
>
>  From the log it seems there is/are corrupt leaf(s)
> [ 3231.406914] BTRFS critical (device sda3): corrupt leaf:
> block=3D1045233664 slot=3D17 extent bytenr=3D20209664 len=3D8192 invalid
> generation, have 895434752 expect (0, 3790778]

Bad extent item generation, sometimes can be caused by older btrfs-check.

Please compile a newer btrfs-progs, and run "btrfs check" to make sure
that's the only problem.

If that's the only problem (some problems like missing csum or missing
holes can be ignored pretty safely), then you can use btrfs check
=2D-repair to repair it.

But please keep in mind, latest btrfs-progs is needed to do the repair.

Thanks,
Qu

> [ 3231.406922] BTRFS error (device sda3): block=3D1045233664 read time
> tree block corruption detected
> [ 3231.406971] BTRFS error (device sda3): failed to read block groups: -=
5
> [ 3231.409566] BTRFS error (device sda3): open_ctree failed
>
>
> Do you have an idea how to solve it. When I try to check the subvols
> with btrfs check all seems to be fine in 18.04.
>
> Thank you in advance.
> Miklos
