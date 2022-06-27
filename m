Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0B955CECD
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbiF0Kyh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jun 2022 06:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbiF0Kyg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jun 2022 06:54:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0608D640E
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jun 2022 03:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656327272;
        bh=TSwjRQokinjqDOa6r+/y82NbFG2b4EGCdmX0DG4oD1c=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=OVal6mvrYHlqomGheHwVvGz4bHLYg+5G/e5qG/zxwFkEAtAjP6sVLPYWnR+8yKGuG
         HdrGm1nzx579l9RqGB+kEiaBul2Wq6N21y5C9hgmL0wrYNcVFrp0bf6kIx34WIFKX0
         SZCobIYqLGYiB40/2IK0OmaxI8TobnMG3g1y4dTw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiJZO-1nTi532WLG-00fOkA; Mon, 27
 Jun 2022 12:54:32 +0200
Message-ID: <068fdbd5-d704-c929-355b-9cf0f500807f@gmx.com>
Date:   Mon, 27 Jun 2022 18:54:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Question about metadata size
Content-Language: en-US
To:     =?UTF-8?B?TGlib3IgS2xlcMOhxI0=?= <libor.klepac@bcom.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <8415b7126cba5045d4b9d6510da302241fcfaaf0.camel@bcom.cz>
 <42e942e3-a6d9-1fcd-cd9b-5c22ee3f2e1f@gmx.com>
 <f9b7e2fea36afefaec844c385d34b280f766b10b.camel@bcom.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <f9b7e2fea36afefaec844c385d34b280f766b10b.camel@bcom.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K4k0imXB2jI1gPFm43a0QVDi0inYQKLaVDZnO9eWa3TJBDsb545
 rmwlnVxEf+iKyz9y0XJHpUQDKdWVtp3e2tRTmNPLG2L5r5ka//sN2DgpzHPrwjacc9XlSRz
 AoxOhwTEwnrS4iunGyqL0sE5BFRLfVcmf048uJocy9qB+Donb0nUfXxsksiTcF0wKEeBjhx
 gS2gNu84lRfzuiHAcEheQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4zm2/Mkky44=:INTiftcLjY3VeaiIfMIK5Z
 tHJRLktfVVqC69Ns5585wZXlyAqEEtAO7zuYH8eXFiLsWF0P+SjZ2ZNLZ+CAX4iP54SrgA5fW
 L93sorfmrMbe8HgNpraKtrr08UwKBbdtCJz4V0ly5Np6CDdKJfzAEEwos+yTmQS47UTo2jeVu
 HvCfAFtWVyqBln8O7rlfkawqPEGrjzwO937OXC+qzivRjTJ8G4/xSXIOSxBOPnwkZCsMIBQKq
 hffbzo9vJXQg0whpYmuSRLgzA0MJxJQ5WPUpX8Un7CX9+hs8FHo87wgCshJSI4MCCydcpvQYL
 BIUeMgNitluMlO7hsyXiwrvRzzkDSQXZmpomI8W99I8pHEnZX57uFLpkQU2AwCFKMwDXeHoCH
 AeaPPhKAVEA0869reSsCdM2M+HNahKLbMrsb5AIRqAhOERB72Kw+j4ubCOTjMFxmhr+D8og9O
 oCDE12AyhQ8TYNp7SkDN4JU7smV7epZKqtWI+uuhNY1SiJk38rmnswxLWBUeIA89xbf2/nTFv
 TI5ppZsULldj7u02YLQ7dOL/2mHeNsCMR3fbYnmKoKaDxecXi3Y1MksmbRMbNef+BYRCawi3S
 1lcW41t1AGKStiB+cJL35yMXTsk6/5uXLLfDtV5vMWEyBZFYkCVe9hUJLWZ0shNDtDQhjVYa8
 28h6p9F+RxK1umE+BLpRB94zkAsTdZ4OJ6+GwSHlhF5CzB0XNP9DhekdbtpRorPfu2dMhJxhD
 RL2/41zRkyauQzHGnCYyjJycpyL+cUZ2m8vsTpnuwO8PJswG6z4Hy5AA39JL1u/lKoBDQU00O
 31n1mrouWhH4TFYJ/vju8GXCNPuJZUPbaLG5p0GJVYzmKNlJxVnAnhZhcka2ixBHUZCb++sN1
 6LmytnWw+Vb1Z7Xgt9laamC8qvrIw0/cU41l0qqrWFGvE//jjpX6JfRVdHG38jrQIZuTOePio
 CoxzNCPKOzwSejjnAaj6W7MIXw213T9l0gFbXWYj8egij6AIIBEAYd64YMlq7pr9BLXkT4V55
 8cVf5a/xuJ/LMz4h6Dl7ukvu1d1y5sI4ONhjlp79n2lYf196vtcny8Hc2SOEvdAwNtUqccvti
 a3qYFN+AFAtQ+4YdFfznfuJOD5VVA9VO0LQt8H206HgLCF2NVLRcvq+dg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/27 18:23, Libor Klep=C3=A1=C4=8D wrote:
> On Po, 2022-06-27 at 18:10 +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/6/27 17:02, Libor Klep=C3=A1=C4=8D wrote:
>>> Hi,
>>> we have filesystem like this
>>>
>>> Overall:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3=
0.00TiB
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Device allocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 24.93TiB
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Device unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.07TiB
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Device missing:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0.00B
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Used:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 24.92TiB
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Free (estimated):=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.07TiB=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (min: 2.54TiB)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Data ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Metadata ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 1.00
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Global reserve:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 512.00MiB=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (used: 0.00B)
>>>
>>> Data,single: Size:24.85TiB, Used:24.84TiB (99.98%)
>>>  =C2=A0=C2=A0=C2=A0 /dev/sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 24.85=
TiB
>>>
>>> Metadata,single: Size:88.00GiB, Used:81.54GiB (92.65%)
>>>  =C2=A0=C2=A0=C2=A0 /dev/sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 88.00=
GiB
>>>
>>> System,DUP: Size:32.00MiB, Used:3.25MiB (10.16%)
>>>  =C2=A0=C2=A0=C2=A0 /dev/sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 64.00=
MiB
>>>
>>> Unallocated:
>>>  =C2=A0=C2=A0=C2=A0 /dev/sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 5.07TiB
>>>
>>>
>>> Is it normal to have so much metadata? We have only 119 files with
>>> size
>>> of 2048 bytes or less.
>>
>> That would only take around 50KiB so no problem.
>>
>>> There is 885 files in total and 17 directories, we don't use
>>> snapshots.
>>
>> The other files really depends.
>>
>> Do you use compression, if so metadata usage will be greately
>> increased.
>
>
> Yes, we use zstd compression - filesystem is mounted with compress-
> force=3Dzstd:9
>
>>
>> For non-compressed files, the max file extent size is 128M, while for
>> compressed files, the max file extent size is only 128K.
>>
>> This means, for a 3TiB file, if you have compress enabled, it will
>> take
>> 24M file extents, and since each file extent takes at least 53 bytes
>> for
>
> That is lot of extents ;)
>
>> metadata, one such 3TiB file can already take over 1 GiB for
>> metadata.
>
> I guess there is no way to increase extent size?

Currently it's hard coded. So no way to change that yet.

But please keep in mind that, btrfs compression needs to do trade-off
between writes, and the decompressed size.

E.g. if we can have an 1MiB compressed extent, but if 1020KiB are
overwritten, just one 4KiB is really referred, then to read that 4KiB we
need to decompress all that 1MiB just to read that 4KiB.

So personally speaking, if the main purpose of those large files are
just to archive, not to do frequent write on, then user space
compression would make more sense.

The default btrfs tends to lean to write support.

> We can use internal compression of nakivo, but not without deleting all
> stored data and creating empty repository.
> Also we wanted to do compression in btrfs, we hoped it will give more
> power to beesd to do it's thing (for comparing data)

Then I guess there is not much thing we can help right now, and that
many extents are also slowing down file deletion just as you mentioned.

Thanks,
Qu

>
>>
>> Thanks,
>> Qu
>
> With regards, Libor
>
>>>
>>> Most of the files are multi gigabyte, some of them have around 3TB
>>> -
>>> all are snapshots from vmware stored using nakivo.
>>>
>>> Working with filesystem - mostly deleting files seems to be very
>>> slow -
>>> it took several hours to delete snapshot of one machine, which
>>> consisted of four or five of those 3TB files.
>>>
>>> We run beesd on those data, but i think, there was this much
>>> metadata
>>> even before we started to do so.
>>>
>>> With regards,
>>> Libor
