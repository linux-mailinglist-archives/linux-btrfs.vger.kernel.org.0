Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639E43E89E4
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 07:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhHKFuE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 01:50:04 -0400
Received: from mout.gmx.net ([212.227.15.15]:41709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233651AbhHKFuC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 01:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628660971;
        bh=F0IVwZXy3kFQp5MI5dTuF3wDhwB/l+O4WI8C6lnTgtg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HCQTcfrFziV5QOXoyCPbS2EnAcB/kZVS7kk16laTd5nmcDtNfPxn5UBChYg36hKeF
         nDM/DBDXiLB+IKL6hoTZ75hixgSdoI70gB3EPAZczyVXCMnAdXpKM1CJBtaLZDt3nE
         nG4gSsdG7toiC3p1ME9pxSm2LdvrHDoVTXMce6uQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMXQ5-1mVUx32Abv-00Jdca; Wed, 11
 Aug 2021 07:49:31 +0200
Subject: Re: Trying to recover data from SSD
To:     Konstantin Svist <fry.kun@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
 <46f3b990-ec2d-6508-249e-8954bf356e89@gmx.com>
 <CADQtc0=GDa-v_byewDmUHqr-TrX_S734ezwhLYL9OSkX-jcNOw@mail.gmail.com>
 <04ce5d53-3028-16a3-cc1d-ee4e048acdba@gmx.com>
 <7f42b532-07b4-5833-653f-bef148be5d9a@gmail.com>
 <1c066a71-bc66-3b12-c566-bac46d740960@gmx.com>
 <d60cca92-5fe2-6059-3591-8830ca9cf35c@gmail.com>
 <c7fed97e-d034-3af1-2072-65a9bb0e49ef@gmx.com>
 <544e3e73-5490-2cae-c889-88d80e583ac4@gmail.com>
 <c03628f0-585c-cfa8-5d80-bd1f1e4fb9c1@gmx.com>
 <d7c65e1d-6f4e-484b-a52f-60084160969f@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <2684f59f-679d-5ee7-2591-f0a4ea4e9fbe@gmx.com>
Date:   Wed, 11 Aug 2021 13:49:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <d7c65e1d-6f4e-484b-a52f-60084160969f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vdw7e03Jn4vb8ZhBxG0llBHNmTK+9ApjHFkvA2npfFNej7msDIm
 y19Ru+FqDQCIQniLBg53MXVfXCCnk+nhb5qO75UPjqeSCNS4rg5+V3FNV3VfdL4i3DMd1iT
 yKpQRHleN7tdc6ba0FpwBu7vkrZxAV4k7AHC7hyAFfXcD/fmwnHT3HXVJSvFAHLmQJAV/BS
 IIC+MtB5xj+/t/APNvzuw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:w18WhfvwUO8=:7TRVrwTMDsvk2Crz9Bb+0z
 /nwMMw8Ov2SsVqyeDYa2iS/AKtI47uxgpx/subrBmaMa2+YEKVP3MQ/kR++FAeaT7bt+f0KJO
 niruqr7vYfwGcLRMHfmWL5Ne0ptonLDmZszPjn38fycXyeJIN5TqZPGi4je/nzpUp1fiR1oh9
 XxqE+iq81MJ7X8nuf86w47QoVc0x6fqJrV8F3GPBENN8UjhHw4hJn3NWAvnY5B/fMyNDe1QeO
 dZT+w3CNtPoMSoJGzUFCOOvGv68wJPClx16/an4+Mpo8orx3xqXWYoLi3NCr9yKaMGjHGfwUc
 IldKS5+HjwwCRma39dbnFJTFRfuSJPPOnWtKERraVYPpW97wKRf1WMag3yjcPJAJmoZro4umQ
 e28DkQbN+4tk4xKWN9zQ9UYVeuHdZArC7HBwplaOLOO2Sbaq0/+4MrEXQmOdE+xkzYiGdTYTL
 sSU9Ytw/nnDqf3fEV3w68IBFgplzqW5FkXr5yXEIZ4u07nEVxsXlRGf4SqFIh2PUrVOvgUXHV
 +ZYGEMSmBuP50aKE77klb+azgfDnBn8flNXG6AWEuDypYpmeO2cqHtMRkNnZlqCiRyXV3nGli
 skIkpic0gm9cWNfD0BJ2Hjz/dWFYW9JbGqosZ+dH6SUqPAuNWN6/4dhLP2AEFiC1pH3DBM7f1
 +0Zwqb4rx/MIoW1sNzVriSdOTF+uYX3aPS3VPWlwDbWP+xYpHnAe9eB+/B4S1UuDrSTkzYIyF
 /NVJjBjfX7ZyobC6eY5bzMlLvAyQqwKH09KFaOLQjIMwN675V8jhQ/eMu8iXmJJtepOCglaly
 vYWtisAkfBONeWpOHRQpDgdyxxl0StjfnL5TlE4lJu+nvot7kgtCSTgVwuLPre+LrOaoJ9Ig3
 kDqckV32w5pHJXtqRhFdgaeLQpa1NmXY10eOKyc21iNSJ8cnzTV3dgUVNBtnUHCSPnzHXeEiG
 dz5Iz79mRTRnWDcCBclMlUbe2MVZAs8n02VrK1YYUeiCf2A52IkNf9yuRHv1OzsSMRwFq2vXw
 f2duYfWEubOQrsJexTQmMnXoKf4COFhj96IRn+JchzsRL3T7+UTncaWhj3ngRXY6lw4xqrqRD
 4hNH+mtVg6CfaNybczOUAc/Z2IgnxJsrF9+QaqiaGGdZ31l1iCqzASiww==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/11 =E4=B8=8B=E5=8D=881:34, Konstantin Svist wrote:
> On 8/10/21 22:24, Qu Wenruo wrote:
>>
>>
>> On 2021/8/11 =E4=B8=8B=E5=8D=881:22, Konstantin Svist wrote:
>>> On 8/10/21 16:54, Qu Wenruo wrote:
>>>>
>>>> Oh, that btrfs-map-logical is requiring unnecessary trees to continue=
.
>>>>
>>>> Can you re-compile btrfs-progs with the attached patch?
>>>> Then the re-compiled btrfs-map-logical should work without problem.
>>>
>>>
>>>
>>> Awesome, that worked to map the sector & mount the partition.. but I
>>> still can't access subvol_root, where the recent data is:
>>
>> Is subvol_root a subvolume?
>>
>> If so, you can try to mount the subvolume using subvolume id.
>>
>> But in that case, it would be not much different than using
>> btrfs-restore with "-r" option.
>
>
> Yes it is.
>
> # mount -oro,rescue=3Dall,subvol=3Dsubvol_root /dev/sdb3 /mnt/
> mount: /mnt: can't read superblock on /dev/sdb3.

I mean using subvolid=3D<number>

Using subvol=3D will still trigger the same path lookup code and get
aborted by the IO error.

To get the number, I guess the regular tools are not helpful.

You may want to manually exam the root tree:

# btrfs ins dump-tree -t root <device>

Then look for the keys like (<number> ROOT_ITEM <0 or number>), and try
passing the first number to "subvolid=3D" option.

Thanks,
Qu

>
> dmesg has the same errors, though..
>
> Anything else I can do?
>
