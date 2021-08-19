Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6979A3F130F
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 08:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhHSGGe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 02:06:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:43575 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhHSGGe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 02:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629353156;
        bh=yh2LBHzz7AzrUc+YNn5j4EI1ScHRBhe+Z8OH9tfFyd0=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=FINDr+XRifuK/TbuvcBAFwwpqFB3IPc9jh7gVbO+eKUAbpHX8TTeUWAJKN3HbP/wc
         TNEyV5YrbVlLe2mkComkZjxz9Hve5qgqb/hGCKkNyjxRpxsa0O87JJgS170dgUHRAu
         MdNUoskbMigcPHXllrMXIaxiRyBVF+yY2/qlKzlE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRmjq-1mfFqz2jus-00THZJ; Thu, 19
 Aug 2021 08:05:56 +0200
Subject: Re: [PATCH v4 2/2] btrfs-progs: cmds: Add subcommand that dumps file
 extents
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Sidong Yang <realwakka@gmail.com>, dsterba@suse.cz,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210718064601.3435-1-realwakka@gmail.com>
 <20210718064601.3435-3-realwakka@gmail.com>
 <20210817133022.GM5047@twin.jikos.cz> <20210818003819.GA2365@realwakka>
 <792d01d9-97f0-6a80-15e9-f6cd6356984d@gmx.com>
Message-ID: <2f355551-3216-cc4c-5522-fab8ed6928e3@gmx.com>
Date:   Thu, 19 Aug 2021 14:05:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <792d01d9-97f0-6a80-15e9-f6cd6356984d@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dg+pJHLlzr6CvCEJstWdo4yJ6fuPHZ8s8R6r9f11s9+TgK8Kii5
 NY/v6Uq9+IgyvyiC2oaYZycSnfYehfgtDyrwOhfqkkKKpv7oAYL+LGFZAMZkPJIgS1dqpxx
 G4UBsaTr+2+27Y3z9jgIZxGFKiP/nH3OIILK4agPdCdb+mkg2nUHPgorJbDAhliifX2/qTQ
 kKD0+XmwrlVsEYo3oCUeQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2FdtE/4O9Ic=:DN9Yz8LooREmIKmLVnBE4+
 VvTEg2yxyKIqPdA5XPWe+FvYd64TK6g030W3N0bbBOywz63wTE2Y6bnfHPwUUiE++PONnqLOS
 Z+ClVF1szFcUmvMRzTMTzNGRoDLgdPzpDr6OY0/G2+5breJ6ByA20c1137MmRU4GEF/a2mujG
 Mo1ftfDsyvN3uzzPZNb1P5fEFTjxomj//LI0vkCAeumSQJTx5ZK6s2zEi9XCirFZl4zCKc2e1
 6vB+lLB+nV6Xx8yqrQ5u6NvTrXmuGQRXw6tLOixuAo7+Z9pxFtMmfhlTWxzTRRM8Sma5waYmz
 lZawWhM1vghXFrdZJ+sLPSkvnE5O7xP0b93kQQAJVBPz8kbNgyFwnu5E7NIOLSMBDE7rkPLEi
 411DOeOJVVMK6JBwVdyFUcvhVK7bI061fmdDrCCewAXB6P7sh/iG4QlfeYkICkCGDLmmRunvK
 6pT8ri/FE+jiYOs9mGRg4g3k/M1TPiim70S7EibHkaNdNzXb072zj8ew3JRjmgneIQmCLil3D
 0CtJ0qfDFvxxmbu3rOWPvUFrzcvaLvs4k3ylfZ44e+BAhD0Ym9Rm0ZEP/5RYPkgzIy4vVi8LC
 9VnfLTlAneRpNwRAyvrqqDzxAlvq41UBIoWNTdbjlr5ExmL2fvrU6LI5G7rvJc8fvHr/3xu4e
 4npQofOvGc8XrW9PeEfkx7SPieVM2byw31WRhhr1Oy8pY09DvZkzG2cNB/24Y52URL6uhF1ZR
 aMfdKFqjlUIB+3vV9U7lPfnd71Kg4/pyrEIdXaC90OurHth3BraeBx9xy3WtTKRm+A3l3WdhH
 hRHzy5HEzyJLfmMFrKGY1aQ54e5o7f5GpE+9fp8hHNUEpDGob+XKWJkJgBXSSdQPUnPMpJ2Xu
 qu1nhES4dskv1kJnXHL9S1vhHxD+KadSPZUOYXauVMLcKkoLSYTzNmi8Q5bkojJGLnP63X8zd
 8xzZbGBchFb77oIacIcAJ+S1kGRuJwFVfz970lG1+/TO55uR+EeI0X3mSIzfxJti4FuSrx+T7
 IatFS1p3GPNdec4xHeyzr0niOeOT8fyJcbnrOeSjYDIlg6z/OHQL0j9lmPSiUGLO5T9ho743b
 dOMvOLF07+GrYydHTyTGqgHZXLBOGCyd+XH5HsIChce/oUfd72NMT56+Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/19 =E4=B8=8B=E5=8D=882:03, Qu Wenruo wrote:
>
>
> On 2021/8/18 =E4=B8=8A=E5=8D=888:38, Sidong Yang wrote:
>> On Tue, Aug 17, 2021 at 03:30:22PM +0200, David Sterba wrote:
>>> On Sun, Jul 18, 2021 at 06:46:01AM +0000, Sidong Yang wrote:
>>>> This patch adds an subcommand in inspect-internal. It dumps file
>>>> extents of
>>>> the file that user provided. It helps to show the internal informatio=
n
>>>> about file extents comprise the file.
>>>
>>> Do you have an example of the output? That's the most interesting part=
.
>>> Thanks.
>>
>> Thanks for reply.
>> This is an example of the output below.
>>
>> # ./btrfs inspect-internal dump-file-extent /mnt/test1
>> type =3D regular, start =3D 2097152, len =3D 3227648, disk_bytenr =3D 0=
,
>> disk_num_bytes =3D 0, offset =3D 0, compression =3D none
>> type =3D regular, start =3D 5324800, len =3D 16728064, disk_bytenr =3D =
0,
>> disk_num_bytes =3D 0, offset =3D 0, compression =3D none
>> type =3D regular, start =3D 22052864, len =3D 8486912, disk_bytenr =3D =
0,
>> disk_num_bytes =3D 0, offset =3D 0, compression =3D none
>> type =3D regular, start =3D 30572544, len =3D 36540416, disk_bytenr =3D=
 0,
>> disk_num_bytes =3D 0, offset =3D 0, compression =3D none
>> type =3D regular, start =3D 67112960, len =3D 5299630080, disk_bytenr =
=3D 0,
>> disk_num_bytes =3D 0, offset =3D 0, compression =3D none
>
> Could you give an example which includes both real (non-hole) extents
> and real extents (better to include regular, compressed, preallocated
> and inline).

Tons of typos... I mean to include both holes (like the existing
example) and non-holes extents...

>
> Currently the output only contains holes, and for holes, a lot of
> members makes no sense, like disk_bytenr/disk_num_bytes/offset (even it
> can be non-zero) and compression.
>
> Thanks,
> Qu
>
>>
>> Thanks,
>> Sidong
>>
