Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9444A3581C0
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Apr 2021 13:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhDHL3X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Apr 2021 07:29:23 -0400
Received: from mout.gmx.net ([212.227.15.15]:41087 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230411AbhDHL3X (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Apr 2021 07:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617881348;
        bh=P6ZRuYOCOhQKChKxlMM25/b3r7o/R+S4dqRR4485goE=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=LTRldk68BQSq7oqOmR/B5acrdmts2OABtNT1uZYEIZ4cXiY5jMO/sAcSLdOLE5oOk
         aMTnEBMG4V4U+kQNZHuGizCkiShkzEk0+Uuc0D9rFnt0QFER82J5TYsuOZaanMPlgz
         8hAMyqnrjzW2EYSIQ+htiUyJwp3bcHjT3ZBz2B08=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M42nS-1lUSqR2xCy-0004ai; Thu, 08
 Apr 2021 13:29:08 +0200
To:     riteshh <riteshh@linux.ibm.com>
Cc:     Joe Hermaszewski <joe@monoid.al>, linux-btrfs@vger.kernel.org
References: <CA+4cVr95GJvSPuMDmACe6kiZEBvArWcBFkLL8Q1HsOV8DRkUHQ@mail.gmail.com>
 <1f5cf01f-0f5e-8691-541d-efb763919577@gmx.com>
 <CA+4cVr8XEJwyccvAhfgJUZyTcjubkava_1h+9+3BggN6XpH3iA@mail.gmail.com>
 <c8e82fcd-de9d-d46f-e455-1d0542fda706@gmx.com>
 <CA+4cVr-gg89KovFG+Yso0iYjhPjnx3eMNK8qG6W1SLY2WkozdA@mail.gmail.com>
 <8315aaf6-26e9-ad0a-cc49-1a1269266485@gmx.com>
 <CA+4cVr9nWjnNbWNctd4vZaoeyqFTyG1DCSTYbrbC4A27XtDG2Q@mail.gmail.com>
 <f8a63ef3-9eaa-f5ea-e403-be81ffcf7c85@gmx.com>
 <CA+4cVr82ujZrdsmjpUPBg3W2xL4gQJwjGwvA2LTy-yj73BhGfg@mail.gmail.com>
 <d7b26dfa-d40b-43e5-07e3-67d5377f84c2@gmx.com>
 <20210408111552.tyevdsqlxhsmnt3g@riteshh-domain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: btrfs crash on armv7
Message-ID: <425e3531-3dd2-fb53-0b19-7e4be90b4fc3@gmx.com>
Date:   Thu, 8 Apr 2021 19:29:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210408111552.tyevdsqlxhsmnt3g@riteshh-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DerqhyBBQoth65qhgSteckwM0SAR5a4ObdS1hMfbafdzM92XX3S
 ipC7lpsvTB5pVrc4yTA/yxa5Fpy1RoVXKDXE2CQ7lcvcFkFtGJsWPOvuxKn9aMJcJy0oORF
 WD8TFNGz/BORIB366Cp+DJ2UBjb72X4I+krDRP88Mcs4liWfKBBti2S7L9tvz456e2ykcd+
 6ObwoZaafv9IyWBUnwPvw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rCChCQsscQ8=:UGNGERJIhUcKZ4mI7EC8mn
 ST6szA2FRZGcFq8jk7lG0+015OI/MGHZlkSgOOhLzYPKlwlRyYuOjNMsr+TCQJqCFo+olnVh3
 lCobOzvErugQhd7pallvbMTUmbBVFdyDtAhHMxg1KirG7zUb7jcaRvP8W9f6Ycu84iZnuIn9f
 e/3BA6gzjHGX89ZgwgGYM/qN0eUp4RY1s8lLPvTX0tOwRKV9txTQVoTqeA2KCt66/r4+MsFh0
 m7woHckDzwWjNsPBJD7WmiGuJu1MkzOG/LEMoDGlNYGQruOWf65HAFTcc6/owdEB7fHILQyqD
 edFaPrvuVVeYEiOUrWNU72xR2ZDqsKDNOe74g/gTtQHgbQqCv1U3CWfv8GgGOlxisnws5eg/Y
 +wa4WGx1pzMvcl234LkhhrbySDEr0MfUA2XS8CTM3Vu0q8EKY/eIwurpKZse/dlyYeu1GqoPb
 mXT4OOpMDI6wvd2pa/kkCidjBLP3GnDcZTq3FQlMekro/a/EcIJmtOiYnCJo5zrcudNzC+Su2
 UC8+/j3xTcG9Cjs2VhatrsqmrNTeFMsU6ODAMFyyOY/ADQOlykyh/nLxl/MH3ZagGxcRmFTu7
 ZVQJtwRfzkd/8AbdcPbgGQ0/62Exm38amBqhM/ybvOXeifSbn5KsG3ZLQk+0ytADbjKmcab5s
 KT3Sv+EVSEvtKSi1PFlSfMqSGCa5G+qHGbRiO7T/H23IWACYh3q6Nkt4kJtMgPRUgoiVLFvbD
 Gq2lVeUM86YA4WbWcoCrzYEcNlR8sK7Bwa8ShuEn987FI79AUhAje5PBW9g32IXAZoe54Hia2
 hVgyfWQkC2Hn4PaHZG6CMADA0ccNc3gwXRCYc9frHI6BOeg7pr8PdPhyYl3ETM4PXqSEW5b1Y
 fMGUZ0mf1KMxRuOV6bp8qLPCsl2zOQKWF2P+97ZKOn+UJK7e3xkyV53gtkvuRXh4XIhVsSYhx
 aPhRVhbgOWgEkm9EAhRiVoWZykn7HkNV2Wh5GeMI4gk0MxZ0SlQvVCawcLj75MfpjHGYqQNss
 Bw6FLLBKbSQiychCIo0zv3/C7xziW56797KawQKDiBDH1nXhx0qTHWhT+MTb1m7VG4RBs4amO
 dn7R/wqFw5eH+RQthG9WavqK0/UgP60mgpbrVd27eGlSTaUDkt5quAJAJxxfGpU5rhCdinkLC
 48Nd9v8YmHPicJbqLehxJ7uevEs2bN6bn/zJikXbE17Pd4rY5rD8tTvaTzsyU6sSgezWQb9SP
 WxJqIWz0w2oiN6CJH
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/8 =E4=B8=8B=E5=8D=887:15, riteshh wrote:
>
> Please excuse my silly queries here.
>
> On 21/04/08 04:38PM, Qu Wenruo wrote:
>>
>>
>> On 2021/4/8 =E4=B8=8B=E5=8D=884:16, Joe Hermaszewski wrote:
>>> It took a while but I managed to get hold of another one of these
>>> arm32 boards. Very disappointingly this exact "bitflip" is still
>>> present (log enclosed).
>>
>> Yeah, we got to the conclusion it's not bitflip, but completely 32bit
>> limit on armv7.
>>
>> For ARMv7, it's a 32bit system, where unsigned long is only 32bit.
>>
>> This means, things like page->index is only 32bit long, and for 4K page
>> size, it also means all filesystems (not only btrfs) can only utilize a=
t
>> most 16T bytes.
>>
>> But there is pitfall for btrfs, btrfs uses its internal address space
>> for its meatadata, and the address space is U64.
>
> Can you pls point me to the code you are referring here?
> So IIUC, you mean since page->index can hold a value which can be upto 3=
2bit in
> size so the maximum FS address range which can be accessed is 16T.
> This should be true in general for any FS no?


The code is in definition of "struct page",from "include/linux/mm_types.h"

Yes, for all fs.

But no other fs has another internal address space, unlike btrfs.

Btrfs uses its internal space to implement multi-device support.

>
>>
>> And furthermore, for btrfs it can have metadata at bytenr way larger
>> than the total device size.
>
> Is this because of multi-device support?

Yes.

>
>> This is possible because btrfs maps part of its address space to real
>> disks, thus it can have bytenr way larger than device size.
>
> Please a code pointing to that will help me understand this better.
> Thanks.

You need to understand btrfs chunk tree first.

Each btrfs chunk item is a mapping from btrfs logical address to each
real device.

The easiest way to understand it is not code, but "btrfs ins dump-tree
-t chunk <device>" to experience it by yourself.

>
>>
>> But this brings to a problem, 32bit Linux can only handle 16T, but in
>> your case, some of your metadata is already beyond 16T in btrfs address
>> space.
>
> Sorry I am not much aware of the history. Was this disk mkfs on 64-bit s=
ystem
> and then connected to a 32bit board?

Possible.

But there are other cases to go beyond that limit, especially with balance=
.

So I'm not confident enough to say what's the exact event to make the fs
cross the line.

>
> This also brings me to check with you about other filesystems.
> See the capacity section from below wiki[1]. Depending upon the host OS
> limitation on the max size of the filesystem may vary right?
>
> [1] https://en.wikipedia.org/wiki/XFS

The last time Dave Chineer said, for xfs larger than 16T, 32bit kernel
will just refuse to mount.

Thanks,
Qu

>
> -ritesh
>
>>
>> Then a lot of things are going to be wrong.
>>
>> I have submitted a patch to do extra check, at least allowing user to
>> know this is the limit of 32bit:
>> https://patchwork.kernel.org/project/linux-btrfs/patch/20210225011814.2=
4009-1-wqu@suse.com/
>>
>> Unfortunately, this will not help existing fs though.
>>
