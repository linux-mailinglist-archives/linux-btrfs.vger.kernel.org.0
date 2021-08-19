Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D033F22DD
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 00:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbhHSWRE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 18:17:04 -0400
Received: from mout.gmx.net ([212.227.17.21]:36911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235676AbhHSWRD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 18:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629411382;
        bh=4IJqkTWtAXg8nQxIcrYJNr2Y4mjsGX8uy4YrmB7XFqs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=a8zNGxl7zf/igE8xaj0LxFOpuXTpwQxlKEqgqD/eB5P2l+yGAzXhp6GsweLQZnNqc
         y+zmB12LqlxyuFLKempwfWgJoMtuP17EOXgWVPVIaDVXNp1IjeoJ/42OkIFOieBUDB
         6RNqgUoFGtNBdq2Ri3AZc0cmsNLtwWf+2D9Y5rr8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUXpQ-1mhCuD48MC-00QPZr; Fri, 20
 Aug 2021 00:16:22 +0200
Subject: Re: [PATCH v4 2/2] btrfs-progs: cmds: Add subcommand that dumps file
 extents
To:     Sidong Yang <realwakka@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210718064601.3435-1-realwakka@gmail.com>
 <20210718064601.3435-3-realwakka@gmail.com>
 <20210817133022.GM5047@twin.jikos.cz> <20210818003819.GA2365@realwakka>
 <792d01d9-97f0-6a80-15e9-f6cd6356984d@gmx.com>
 <2f355551-3216-cc4c-5522-fab8ed6928e3@gmx.com>
 <20210819152714.GC1987@realwakka>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <a874228c-3b00-e0d2-9702-2bfcba171fa2@gmx.com>
Date:   Fri, 20 Aug 2021 06:16:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210819152714.GC1987@realwakka>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gHcsY7uRF2TevP03ZjLh6ZcKT5l8qJtqA1qTso+u+Rvty+HUmXD
 TbjvnvWcuKnhAg3ZA3AZl8HZuOpbPqSGoWHgWAot1xdaGO0pj9RHcCocoV8uv8uay9IRF0E
 1o6bKJ5dAUEXEBxI5XbrCUAO3C2/QfMfu9fBEh9u1FI0paj9DPBI4TFMV+9B/cutflzvaOd
 8Ecq5MPX7ylnv+glHskZQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TTScOH1SjKk=:3qPQNgmmXRl/PTixrGTpZT
 I4qdqLTtOKUABWb1Gt3hcYy9DA1m1Le1iRXyE3U0SOdZvDffeHyTerjYn7UnyJLqUUOP6MpGb
 hLrGRSdSc9Je+WJlaDysnyOD4kBJ+uUEnhZ/8ZAefuROZQrrswyZh++L6C8q7r0Pc9c3g4FcT
 8g6/3puULwlg0A5zJcLWTa/DwJIXgMU0hI4KuIXWxFhjGVuvoFguvZh7j9nwiFuf/ccPYPj4o
 AesSIDorJzdJaE3aus4fsRw+eZzMM/KRjpe9OHULQbuU2pICtHRqZ7WLexZYPWFTj60Va2sAL
 QNfQylxMqubnBtwSRZyiBzS3oNR4tg5yjctWX/XBRGAdkt/PzfNwllCqqFZ9zCFI1e+6ARw1k
 TcwJGvqg1E8aqj7Y6zjmb6aJlPWmsNOU68x1HXMQGuoVsMsLI47ueiHpTmWP9VEnuZyua8FIn
 toR661ympArl3fvdEZA8DwijoembTFkhEjkHckQ+lwmzB4bUekmVBHjeWkHkzmOeqplEe9VXf
 OMdvGUpvyIeg9mYne/JtUtBoEIDnKqaTuI/zQTdLym/AGlid/XtNTxCGJ73sXn77AuKRdmW9T
 hArinlPsE6H/pOZdbwsLJjPwHD6I2DO0z/3K0c90nZusalk4vmnCHSkBB4aUsJzmC4W9CHrdC
 xygVXnq0jX8GFv2FLacrd9wJIJN9eZTlnAAT2VXSq30MSIASTWCxk7s2T6V6eYFIE6Q2VCutr
 Vj1YNvup7kBMbJFuibm3Z9mSVoe7zT+fm2MYq7H4YGBwkI5eC+kct5aGokRuxGtcho9C0rowM
 MaeNAuKIfoRTvjPpiv5YgTLw1pig3H3MMzJUaV9TN/6Xaoz4IsbJS44yky/65nPi9iGM4zyDq
 812Ypb5TfQhKgpP8wQsbDTzFL3TB/oKGq8Wz4iMlnq0giHDlVB7vFQWVsb4PKU7bg54V32WW6
 QMEzyMY8kPmwj8SN8mt9N24EBvpHDlrkRu6AS0Be0d9w6B8o8Lm2tW6eQ+EI0my17xEGmt6el
 Bk1f4cwQWj0NcB5w9DiCaegwS7hjCfc1dCSEhqvciAKpv96u//65NswyJUgGedWbVQbLfA4ow
 UeiGDu7GqA6lRUuEfWZLEXTvKYjxZNaUcfEG5HBvYG3A72QqMjZytgkUA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/19 =E4=B8=8B=E5=8D=8811:27, Sidong Yang wrote:
> On Thu, Aug 19, 2021 at 02:05:52PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/8/19 =E4=B8=8B=E5=8D=882:03, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/8/18 =E4=B8=8A=E5=8D=888:38, Sidong Yang wrote:
>>>> On Tue, Aug 17, 2021 at 03:30:22PM +0200, David Sterba wrote:
>>>>> On Sun, Jul 18, 2021 at 06:46:01AM +0000, Sidong Yang wrote:
>>>>>> This patch adds an subcommand in inspect-internal. It dumps file
>>>>>> extents of
>>>>>> the file that user provided. It helps to show the internal informat=
ion
>>>>>> about file extents comprise the file.
>>>>>
>>>>> Do you have an example of the output? That's the most interesting pa=
rt.
>>>>> Thanks.
>>>>
>>>> Thanks for reply.
>>>> This is an example of the output below.
>>>>
>>>> # ./btrfs inspect-internal dump-file-extent /mnt/test1
>>>> type =3D regular, start =3D 2097152, len =3D 3227648, disk_bytenr =3D=
 0,
>>>> disk_num_bytes =3D 0, offset =3D 0, compression =3D none
>>>> type =3D regular, start =3D 5324800, len =3D 16728064, disk_bytenr =
=3D 0,
>>>> disk_num_bytes =3D 0, offset =3D 0, compression =3D none
>>>> type =3D regular, start =3D 22052864, len =3D 8486912, disk_bytenr =
=3D 0,
>>>> disk_num_bytes =3D 0, offset =3D 0, compression =3D none
>>>> type =3D regular, start =3D 30572544, len =3D 36540416, disk_bytenr =
=3D 0,
>>>> disk_num_bytes =3D 0, offset =3D 0, compression =3D none
>>>> type =3D regular, start =3D 67112960, len =3D 5299630080, disk_bytenr=
 =3D 0,
>>>> disk_num_bytes =3D 0, offset =3D 0, compression =3D none
>>>
>>> Could you give an example which includes both real (non-hole) extents
>>> and real extents (better to include regular, compressed, preallocated
>>> and inline).
>>
>> Tons of typos... I mean to include both holes (like the existing
>> example) and non-holes extents...
>
> Sorry, I had no idea about holes. But I found some test code in
> xfstests. It helpes me to make hole in file.
>
> xfs_io -c "fpunch 96K 32K" /mnt/a/foobar
> xfs_io -c "fpunch 64K 128K" /mnt/a/foobar
>
> and the example is below.
>
> # ./btrfs inspect dump-file-extent /mnt/a/foobar
> type =3D regular, start =3D 0, len =3D 98304, disk_bytenr =3D 21651456,
> disk_num_bytes =3D 4096, offset =3D 0, compression =3D zstd
> type =3D regular, start =3D 98304, len =3D 32768, disk_bytenr =3D 0,
> disk_num_bytes =3D 0, offset =3D 0, compression =3D none
>
> I'm afaid that I understand your request correctly. Is it what you want?

This example is much better.

But still, for holes, things like
disk_bytenr/disk_num_bytes/offset/compression makes no sense and can be
skipped.

Furthermore, for hole/prealloc they need extra type other than "regular"

Thanks,
Qu
>>
>>>
>>> Currently the output only contains holes, and for holes, a lot of
>>> members makes no sense, like disk_bytenr/disk_num_bytes/offset (even i=
t
>>> can be non-zero) and compression.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Thanks,
>>>> Sidong
>>>>
