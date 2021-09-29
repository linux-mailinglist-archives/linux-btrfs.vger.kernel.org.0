Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C0441C09F
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 10:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244863AbhI2IYw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 04:24:52 -0400
Received: from mout.gmx.net ([212.227.15.18]:32893 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244791AbhI2IYm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 04:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632903776;
        bh=+HlUAq1L8UkRWuoM3hPyCqzNNNWp7LZKnpV1eetQ280=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=a3qiBMG9if8/A/fNAGEleRr5zyLspOHqbgGSf3mCGcssedlv3UTx2DZ6DEbNfK0kj
         6dLOZKiRprPUn+JDUTFbs/gqUd/kS6RQkyzPjvcQR9fMkalKBo9aMIXdnbEsmEfSCf
         l1/MNwZvwwRFUppQ4OeukT1B/aw1x/JK7clEPws8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9FnZ-1mQqIx02bP-006L4s; Wed, 29
 Sep 2021 10:22:56 +0200
Message-ID: <a02d8f67-55fd-17f5-03ee-a8b7f1608352@gmx.com>
Date:   Wed, 29 Sep 2021 16:22:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: btrfs metadata has reserved 1T of extra space and balances don't
 reclaim it
Content-Language: en-US
To:     brandonh@wolfram.com, linux-btrfs@vger.kernel.org
References: <70668781.1658599.1632882181840.JavaMail.zimbra@wolfram.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <70668781.1658599.1632882181840.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RRXiZ+mrrDjWDKXMdlYQiN9BvKMgFTCRnMEwkNXs6jarhz2XGGa
 kV+KKNvRGVuqLESLgwQyzkhH1itqcwT4OtU4gibNsaq6PsLqhornqMt3vNycGcbMMswirpd
 I8IRfrMMrsvVsGQUzvLxaCh6wN9kxE06eBTZ39OPbH6k10h7Jv+52QrZNTQRwJ501HvK5AA
 Ozr19NDz/0zdS9+BuNSaw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NeOL6qiT2rg=:vkCqnVrQMQ0XAmVDGUjINQ
 jk+WKyLzov7Zqk/5LEl01TksLgQbrIAHLjadFto3f73C/7DY9DZmKb75OJOII2AJFLg+kRrQc
 7erjzg9EpQFtu2IGzznAqVB+vpoWlrMKpmHVfiTtDqUXPtAJa7vBdQJyc6eRV37vNDc84qXCi
 2NRZCXSsMTKjUIa0QF2OsBSmfPOicJ31OvCEUlpK57HBo+nraUx+u1hdfsG1rhe+6bFW8nlyX
 LKegmuyJJiTFaoMmBoSWLGNQdCSn+1rq0F0i51MZKt20isjDBJrxUqULlHaQ3ANXX64KeBPgL
 UaB4BK6p7ZJLxdIMGKe0dS0qArEhWp5fY6eW31RCTZFOTafAwsN9L4t635SZmZJMmCeKPo/E9
 6IH/Ru+Hb2inBIeSbR7bbMGZVXqKcPUg0INJ0bf9yIET6CW2d9zVyeaJ5PwczFDQvtP6tIrky
 o1nKPFcc3h4CoXXVREeiQ4TC5tFDA9OF90TVAycnjU2i2+PeA6roWum5JeSJlfiISBYS8m6zM
 0pysvGsHb9GmI44zC9asz46l3AxxhF0nXsageUlK0L7Xs59zoPQ4gbq3gd+/KIKIhGP8qwxwF
 W3uBC1TgApLK9xJPfQHrj9YAKuMeTn45AyFsmOZc6KWEWyHSb/w3isbSvYMTDfcAmrvV2Cr8R
 dVTDtr+uQAeopDTggtRVZo0u+5jUeTm6kmCY29DusbGLtUI4klWBp8x8pJF2rsCnR7WAmjmfm
 tUmXHzQ3cLUZeVM95Lx76Djsz/UxEdlP2zn5mjQBpSSXn/fpmKBatMormwTvsFFXCfSuOffOR
 s/6S0P8cspRtFZeiXvgTvQovr/ZdsZXxRDEAugTZYelsl98GH2MLhvaMHvTB8EUfpKL3VrOIw
 LshDme+CLyLP9zBuvwQdc0P1A/PB4gihZakMsqQDPa/zVMcFFHtgZh8Q4XJREhLo7ELOwWuMd
 ekYLMGMO7ajJzXyr95LvYsoudh6fbts4oz5uN4TdPAi9yTbfcmghdGGidopTdQhaf9UV4o+Qd
 lrDlT4H7yaQfSlY2GWGlCrqcWv3T28hr94dZKD770LJVqbrBe0Zx0+RNzkM7ON6rju6qDXR4V
 sjUOncYA7AjG4Y=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/29 10:23, Brandon Heisner wrote:
> I have a server running CentOS 7 on 4.9.5-1.el7.elrepo.x86_64 #1 SMP Fri=
 Jan 20 11:34:13 EST 2017 x86_64 x86_64 x86_64 GNU/Linux.  It is version l=
ocked to that kernel.  The metadata has reserved a full 1T of disk space, =
while only using ~38G.  I've tried to balance the metadata to reclaim that=
 so it can be used for data, but it doesn't work and gives no errors.  It =
just says it balanced the chunks but the size doesn't change.  The metadat=
a total is still growing as well, as it used to be 1.04 and now it is 1.08=
 with only about 10G more of metadata used.  I've tried doing balances up =
to 70 or 80 musage I think, and the total metadata does not decrease.  I'v=
e done so many attempts at balancing, I've probably tried to move 300 chun=
ks or more.  None have resulted in any change to the metadata total like t=
hey do on other servers running btrfs.  I first started with very low musa=
ge, like 10 and then increased it by 10 to try to see if that would balanc=
e any chunks out, but with no success.
>
> # /sbin/btrfs balance start -musage=3D60 -mlimit=3D30 /opt/zimbra
> Done, had to relocate 30 out of 2127 chunks

One question is, did -musage=3D0 resulted any change?

If there are empty metadata block groups, btrfs should be able to
reclaim without any extra commands.

And is there any dmesg during above -musage=3D0 output?

Thanks,
Qu

>
> I can do that command over and over again, or increase the mlimit, and i=
t doesn't change the metadata total ever.
>
>
> # btrfs fi show /opt/zimbra/
> Label: 'Data'  uuid: ece150db-5817-4704-9e84-80f7d8a3b1da
>          Total devices 4 FS bytes used 1.48TiB
>          devid    1 size 1.46TiB used 1.38TiB path /dev/sde
>          devid    2 size 1.46TiB used 1.38TiB path /dev/sdf
>          devid    3 size 1.46TiB used 1.38TiB path /dev/sdg
>          devid    4 size 1.46TiB used 1.38TiB path /dev/sdh
>
> # btrfs fi df /opt/zimbra/
> Data, RAID10: total=3D1.69TiB, used=3D1.45TiB
> System, RAID10: total=3D64.00MiB, used=3D640.00KiB
> Metadata, RAID10: total=3D1.08TiB, used=3D37.69GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
>
> # btrfs fi us /opt/zimbra/ -T
> Overall:
>      Device size:                   5.82TiB
>      Device allocated:              5.54TiB
>      Device unallocated:          291.54GiB
>      Device missing:                  0.00B
>      Used:                          2.96TiB
>      Free (estimated):            396.36GiB      (min: 396.36GiB)
>      Data ratio:                       2.00
>      Metadata ratio:                   2.00
>      Global reserve:              512.00MiB      (used: 0.00B)
>
>              Data      Metadata  System
> Id Path     RAID10    RAID10    RAID10    Unallocated
> -- -------- --------- --------- --------- -----------
>   1 /dev/sde 432.75GiB 276.00GiB  16.00MiB   781.65GiB
>   2 /dev/sdf 432.75GiB 276.00GiB  16.00MiB   781.65GiB
>   3 /dev/sdg 432.75GiB 276.00GiB  16.00MiB   781.65GiB
>   4 /dev/sdh 432.75GiB 276.00GiB  16.00MiB   781.65GiB
> -- -------- --------- --------- --------- -----------
>     Total      1.69TiB   1.08TiB  64.00MiB     3.05TiB
>     Used       1.45TiB  37.69GiB 640.00KiB
>
>
>
>
>
>
