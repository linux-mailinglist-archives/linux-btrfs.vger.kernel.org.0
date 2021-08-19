Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DE93F1307
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 08:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhHSGE0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 02:04:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:35393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhHSGEZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 02:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629353027;
        bh=7hle+ZUD+ne+CZv0hdDsLcpBSqfLZk22/Pnpy9VbZrQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=FQZLD55E7WcL5UoAOOqFeGYvcyhbgU3z3lVwiu70rU57kHDebzRi144y1uT3fXkGN
         R35Y7Ba+RlCrnYi33hlbkcPVG/BR8YYZOTpPqPUJz1mNoVt3LqeljrqXkqGr6Uj1r3
         OLiL2N4IQIs40a5KIiwXnwY0xZhERAMzJiIY5WjE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOA3F-1mRFJy0SWf-00OW5u; Thu, 19
 Aug 2021 08:03:47 +0200
Subject: Re: [PATCH v4 2/2] btrfs-progs: cmds: Add subcommand that dumps file
 extents
To:     Sidong Yang <realwakka@gmail.com>, dsterba@suse.cz,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210718064601.3435-1-realwakka@gmail.com>
 <20210718064601.3435-3-realwakka@gmail.com>
 <20210817133022.GM5047@twin.jikos.cz> <20210818003819.GA2365@realwakka>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <792d01d9-97f0-6a80-15e9-f6cd6356984d@gmx.com>
Date:   Thu, 19 Aug 2021 14:03:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818003819.GA2365@realwakka>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kuaIZLMtwLJXJW0HozGDKGObxYM7C9WfjsD7M8DFK/BR3TLybKl
 W4H5F4cH/qqEGi6xlHrKo7KaFppgineXsKmHXs9nQcCknH2CgIT6cXQoo1M+mv9TVXDEY1M
 6IfyyoTj6z1aPYX4BGrFiIiX4tOJpKiIJ4yr6il4ADEACI/wPy4zRk9fAlRscQ3/zT+TPE3
 yo+lsy0y/fx0iAG65poVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:A+/xMC5wYHE=:dTJhJzik4qydUm7jApRcim
 mLPvJCbQ2fipqiMOMHKxh1aIpZAjE9u5wEUpDlZTIdSPt/a1ZMAqw0TAgd9l/YsfDRkf7LZrq
 ZNJ7NWLmrAplodQwn53Ia9zQXCgoPAtLpICPy+2jH9tOyItw9MmyAkNQvnPg2x26d8F0+MjSj
 AuKAN9kX4vy2w18yOLy9KNBkrAAdt1TDwXUVz3vwCIxUDm794JIzeEHDUDFURXau3RW6YZh0p
 8QaIIZq729o5YBz8xqVEjY7BtNx5ZWnlJuM6X4VnAmalkB1A7lqvuXk9miBJmNG0wzZSw1+i6
 FZPnX3VMOvqS33fs0aMAOulGTuU8Dz+Rj+B1qjaflyB/8bYAMBRqZt+RfitE5Iaxlup7UPTUi
 2DOTj/oEdYIOGI1OFXXH29hmRwYflUuqwcEL3S5SAlYcdKEx1Fg9EZR+R2CICIf8aZW6q10xq
 EVosY4D9paDZz8j6QkheszM6U+1VB+2EyMnCPxwnfz5CYkPPa4Gy0+FcMHzY0Km37eO1JEUfE
 xFk/IjiiimdR7HN2DJJ1VzYGYx/nOGWT3Up6/xOI7OnZ/9u4dhUkScPnVydvRhvOGV3lzFAJv
 ZjuikwM0DjvJ2qaWmPHSB12MQwP2UhReexPiCAFaYvIHyUE49VtIOiVsxZY1qTo2A2tSyTS4Y
 kriQt2kez6jjS6s7UzMLdCfbaqVFIFJ+4KJyxCGon8qaUV642G29+YzDCg30lgouh+T1Ms1kx
 DAcog7pxieSB/XvjsDaNZsg5CtIa6mUiACCmi+vdmhyK8JT2ECOfi79abz52gz7Cqrxmlj3uD
 VHT0304XkF08FcT3jZnezzwcyq6uvMzi/7bBlAS2o60vM3r7dIRscp004qpoMJqu08VRvthkq
 /UYhOMlvFGMP3j9cBo3FrfIPxs4DXVhwFMwA4Xs7XVGaV/MlbSxazGz6Yo8vFIyIUUuIM1A7t
 IAv0ZHWp9x5NgwnPm36EOuZZ2UrA2P07jl4EYcdmdTzGIkBvz7RoLyM987ZpeDgxckl+i3zDt
 5jdznY7letZDjbrI0kiUaC06/arkIrCuLYB/IlFdzE36VGAin/cxLq7rW4Fb4aPyP9SMpKlVs
 YCGr6eqd7Z+ze5pYx1UOSDD2/apqMxs1bC+Mb6vhE4f3j7vSpHOFIb1Mw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/18 =E4=B8=8A=E5=8D=888:38, Sidong Yang wrote:
> On Tue, Aug 17, 2021 at 03:30:22PM +0200, David Sterba wrote:
>> On Sun, Jul 18, 2021 at 06:46:01AM +0000, Sidong Yang wrote:
>>> This patch adds an subcommand in inspect-internal. It dumps file exten=
ts of
>>> the file that user provided. It helps to show the internal information
>>> about file extents comprise the file.
>>
>> Do you have an example of the output? That's the most interesting part.
>> Thanks.
>
> Thanks for reply.
> This is an example of the output below.
>
> # ./btrfs inspect-internal dump-file-extent /mnt/test1
> type =3D regular, start =3D 2097152, len =3D 3227648, disk_bytenr =3D 0,=
 disk_num_bytes =3D 0, offset =3D 0, compression =3D none
> type =3D regular, start =3D 5324800, len =3D 16728064, disk_bytenr =3D 0=
, disk_num_bytes =3D 0, offset =3D 0, compression =3D none
> type =3D regular, start =3D 22052864, len =3D 8486912, disk_bytenr =3D 0=
, disk_num_bytes =3D 0, offset =3D 0, compression =3D none
> type =3D regular, start =3D 30572544, len =3D 36540416, disk_bytenr =3D =
0, disk_num_bytes =3D 0, offset =3D 0, compression =3D none
> type =3D regular, start =3D 67112960, len =3D 5299630080, disk_bytenr =
=3D 0, disk_num_bytes =3D 0, offset =3D 0, compression =3D none

Could you give an example which includes both real (non-hole) extents
and real extents (better to include regular, compressed, preallocated
and inline).

Currently the output only contains holes, and for holes, a lot of
members makes no sense, like disk_bytenr/disk_num_bytes/offset (even it
can be non-zero) and compression.

Thanks,
Qu

>
> Thanks,
> Sidong
>
