Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AAF55D113
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbiF0Mjq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jun 2022 08:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbiF0Mjm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jun 2022 08:39:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5787B4BD
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jun 2022 05:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656333577;
        bh=xqYuHLHItKXz1XKggWV6WFesQiGhAOFSa6xVLxkiekA=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=VrlpkfeUxQ1rtwrxihN5Lrshkj8GpYvW89aJiktkkD8+YE8V84hdeoyaheEc9QH/6
         ZPNHBQB5bNDUGRDPdpDab1kCJJFs8rANrjBAO4lwPHmSUlQ+39YgnZhSHbnMejdgZn
         Bie3hBm2FdI3k7MWLBYfcjEyoAw9M5sFJMdg6XnE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MKbkM-1oMNVM3eyy-00KwE3; Mon, 27
 Jun 2022 14:39:37 +0200
Message-ID: <6a345774-e87c-ad3f-1172-e1d59f1382a7@gmx.com>
Date:   Mon, 27 Jun 2022 20:39:34 +0800
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
 <068fdbd5-d704-c929-355b-9cf0f500807f@gmx.com>
 <d97f1c183d0babf67c888c7fb79316be0d3f5073.camel@bcom.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <d97f1c183d0babf67c888c7fb79316be0d3f5073.camel@bcom.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mv907m1bQvy2jkEzkycG0fjZvVw8/hfAP3Gtm3zZwoWA5Jkj0pq
 SIc5jWueUwfKbkZqxwkGiY+4bEE/dvxyfhLcsWkwUq0V6xL2p3025YOH+JSondGK0XDVFnA
 eX/eQRNx0lXtLt5IdJLRhe6MnnvorZRDb2A3F1aDdZ9M7/kzHXcviHKDoLO0XbkZiHOxzRN
 czIKMOr5B0dLm9T7sYKvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oYpEtVhu7SY=:UqtGiOjLXPwMPBKLl3KrAN
 C4k6bSUjiZaI/6mCm0ePHyDkX+7mHP+cP9nlB3a/pIc0W9BFJEceVrq3yKphaGC8A+pRBpufO
 foHKeKSgTAopcH/rdHIr41v6Nm8lG7Ne6eHhhyWwqvaQWXa3Iq9D7//SHRBiH9dPEZAsKZGiY
 tYjWVD7jtEeV7MHXZvD0SongIyQpAZV+h8zlq4WBczTiJFz5U24E2AH8Oso2UsCUUW25/8kDo
 UKeStJVNRxLeaAWtzoR3bc8TOe0qvzei8wzm5fsNHenqcK5ewhMRXDIBZlBi36n5Md7O82O3k
 ZB4cB9+007wMMeNuL71sAT5NkNMZGghHt68I03oqjHsfWzXUZozmchAEuJ2Dx7vrrdUCkpo1n
 XCyTvUkSiTC6Ffkhh+G7w/fhr/PrHduYddXi1PN2V7FBNNHO21OF2Nj3Dc7v2K1mNYRPXml67
 uNcXrN9tbDKD2vKKzdrRN1b5buDyfwCBrpk8itxMKvChhFmk4INtlNsNNk9wSzFNQrMRtWFs6
 KRW7iBs6IReAhWb11hEH1swqZkuNFeJiMsUGUc2h7Xbs4Zh7JWU4ytqX5d+E/6wZvcP57pJa5
 MkYFeNrUMsn1uI8qtCAZArO+Df0KyIe6bA6NRYjU8pnIwXPZ5u7Zd9r7KS41V1HJ+2klI6n4k
 tvJbpXrH8mgQ+3Xu2teIDbbAgGNWZhQZYqOtJBfC590NYpmfp4damUZPyEpfgNVua+Z+NvsXa
 JjEAGB6wF/u/YPlSnv/dHexwL2s1PvaHg6Dmr+P2JWKYl359+6DFGfLExex4I6u1lI/qqDoR6
 1r0JXEH6Q+uA+Fz8nhwnXq/Plji7RRsXc1fkeCbiOIpG8tahTvfNu5x/o8JNNkhlkJB7F1S8E
 45rYGQYAMLNyyG+ZQISr8DEtgbbOqzgroTY4d1pNQmHqG4fEO88u7ARyH8phqfCXkL5Eklohr
 sZ8Wqvrfi+Mo0QP8thuei4Lo5T5fn4kfuh+D+4nCmUvFKGvGpCDKLsS7pIMogzQuDhtsklA5R
 NeQ6mNS5P9wErA0zkWP0aCifxuZ/UUDZ5vvERXme13pjza83gh5cQeR3EE4fRFxtXV+jexdUA
 LWHu2lCkfwpNUj9klH6vq2xyMG2E6Cm1nmD8HYGZaNcYI1bxNICOhaGag==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/27 20:17, Libor Klep=C3=A1=C4=8D wrote:
> On Po, 2022-06-27 at 18:54 +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/6/27 18:23, Libor Klep=C3=A1=C4=8D wrote:
>>> On Po, 2022-06-27 at 18:10 +0800, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2022/6/27 17:02, Libor Klep=C3=A1=C4=8D wrote:
>>>>> Hi,
>>>>> we have filesystem like this
>>>>>
>>>>> Overall:
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 30.00TiB
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Device allocated:=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 24.93TiB
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Device unallocated:=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.07TiB
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Device missing:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0.00B
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Used:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 24.92TiB
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Free (estimated):=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.07TiB=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (min:
>>>>> 2.54TiB)
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Data ratio:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Metadata ratio:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 1.00
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Global reserve:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 512.00MiB=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (used: 0.00B)
>>>>>
>>>>> Data,single: Size:24.85TiB, Used:24.84TiB (99.98%)
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 /dev/sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 24.85TiB
>>>>>
>>>>> Metadata,single: Size:88.00GiB, Used:81.54GiB (92.65%)
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 /dev/sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 88.00GiB
>>>>>
>>>>> System,DUP: Size:32.00MiB, Used:3.25MiB (10.16%)
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 /dev/sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 64.00MiB
>>>>>
>>>>> Unallocated:
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 /dev/sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 5.07TiB
>>>>>
>>>>>
>>>>> Is it normal to have so much metadata? We have only 119 files
>>>>> with
>>>>> size
>>>>> of 2048 bytes or less.
>>>>
>>>> That would only take around 50KiB so no problem.
>>>>
>>>>> There is 885 files in total and 17 directories, we don't use
>>>>> snapshots.
>>>>
>>>> The other files really depends.
>>>>
>>>> Do you use compression, if so metadata usage will be greately
>>>> increased.
>>>
>>>
>>> Yes, we use zstd compression - filesystem is mounted with compress-
>>> force=3Dzstd:9
>>>
>>>>
>>>> For non-compressed files, the max file extent size is 128M, while
>>>> for
>>>> compressed files, the max file extent size is only 128K.
>>>>
>>>> This means, for a 3TiB file, if you have compress enabled, it
>>>> will
>>>> take
>>>> 24M file extents, and since each file extent takes at least 53
>>>> bytes
>>>> for
>>>
>>> That is lot of extents ;)
>>>
>>>> metadata, one such 3TiB file can already take over 1 GiB for
>>>> metadata.
>>>
>>> I guess there is no way to increase extent size?
>>
>> Currently it's hard coded. So no way to change that yet.
>>
>> But please keep in mind that, btrfs compression needs to do trade-off
>> between writes, and the decompressed size.
>>
>> E.g. if we can have an 1MiB compressed extent, but if 1020KiB are
>> overwritten, just one 4KiB is really referred, then to read that 4KiB
>> we
>> need to decompress all that 1MiB just to read that 4KiB.
>
> Yes, i get reason for this.
> I just never realised the difference in extent size and it's impact on
> metadata size/number of extents.
>
>> So personally speaking, if the main purpose of those large files are
>> just to archive, not to do frequent write on, then user space
>> compression would make more sense.
>
> Ok, these files are writen once and deleted after 14 days (every 14
> days, new full backup is created and oldest fullbackup is deleted. Full
> backup is dump of whole disk image from vmware), unless needed for some
> recovery. Then it's mounted as disk image.
>
>>
>> The default btrfs tends to lean to write support.
>>
>>> We can use internal compression of nakivo, but not without deleting
>>> all
>>> stored data and creating empty repository.
>>> Also we wanted to do compression in btrfs, we hoped it will give
>>> more
>>> power to beesd to do it's thing (for comparing data)
>>
>> Then I guess there is not much thing we can help right now, and that
>> many extents are also slowing down file deletion just as you
>> mentioned.
>
> So i will have to experiment, if user land compression allows us to do
> some reasonble deduplication with beesd.

As long as the compression algorithm/tool can reproduce the same
compressed data for the same input, then it would be fine.

> It may maybe speed up beesd, it cannot keep up with data influx, maybe
> it's (also) because the number of file extents.
> Unfortunately it will mean some serious data juggling in production
> environment.

I'm wondering can we just remount the fs to remove the compress=3Dzstd
mount option?

Since compress=3Dzstd will only affect new writes and to user-space
compression should be transparent, disabling btrfs compression at any
time point should not cause problems.

Thanks,
Qu

>
> Thanks,
> Libor
>
>
>>
>> Thanks,
>> Qu
>>
>>>
>>>>
>>>> Thanks,
>>>> Qu
>>>
>>> With regards, Libor
>>>
>>>>>
>>>>> Most of the files are multi gigabyte, some of them have around
>>>>> 3TB
>>>>> -
>>>>> all are snapshots from vmware stored using nakivo.
>>>>>
>>>>> Working with filesystem - mostly deleting files seems to be
>>>>> very
>>>>> slow -
>>>>> it took several hours to delete snapshot of one machine, which
>>>>> consisted of four or five of those 3TB files.
>>>>>
>>>>> We run beesd on those data, but i think, there was this much
>>>>> metadata
>>>>> even before we started to do so.
>>>>>
>>>>> With regards,
>>>>> Libor
