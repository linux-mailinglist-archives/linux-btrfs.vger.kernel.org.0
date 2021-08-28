Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8123FA3F8
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Aug 2021 08:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhH1GRL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Aug 2021 02:17:11 -0400
Received: from mout.gmx.net ([212.227.15.15]:39583 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhH1GRK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Aug 2021 02:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630131379;
        bh=pDxa2H7uWB1VwxRgm93qcKuE9e+ItwqkwFa6a+tr38k=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KSfeNUNSaEI0vrQgnU1n8DzQyTkLMBdY6HKDDilHHDV1/UTJS1oOYO2Dqy92P0Q94
         3JFgDSIJyqrXi0BzNkfy7bMph4WlyIdcBtG49ld398Byqgfw0zuL2Su3fbLGGHgB46
         lgcRqjwUBMmxBuiB8LsUhTYCK8gueYOemq1pDu8M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MSt8W-1mS5Ns0ieE-00UKrJ; Sat, 28
 Aug 2021 08:16:19 +0200
Subject: Re: Trying to recover data from SSD
To:     Konstantin Svist <fry.kun@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
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
 <2684f59f-679d-5ee7-2591-f0a4ea4e9fbe@gmx.com>
 <238d1f6c-20a9-f002-e03a-722175c63bd6@gmail.com>
 <4bd90f4a-7ced-3477-f113-eee72bc05cbb@gmx.com>
 <fab2dab5-41bb-43f2-5396-451d66df3917@gmail.com>
 <60a21bca-d133-26c0-4768-7d9a70f9d102@gmx.com>
 <7e8394c9-9eb3-c593-9473-5c40d80428a5@gmail.com>
 <1785017b-e23b-e93d-5b78-2aa40170fe62@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <14a9a98c-50fc-eb7b-804b-2fe36775b5fa@gmx.com>
Date:   Sat, 28 Aug 2021 14:16:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1785017b-e23b-e93d-5b78-2aa40170fe62@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pJqj29H5+rBylnTia6hXBr8M4fZ7nd4rI3JlZvJmxpqqzSauTVS
 nZ6mNA7zI3yU5GokggBVlkd0e1Gx4bqz/Gi+q/EB16e5MokRpbT9ClAqRHn5VbJSAMIwAWE
 xiZY91umIYYRAEcSB5EhBc0Zl2yhLykHp3kzGWBZnHH9vc1ZLdYSfJWAmZAL5bbqX5jR4kb
 B8cQy9zR0KPzG6XX0Er7Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aXaJl7nh5Zg=:SuJpFek4w7ZkUQ6Cn70G3X
 LyJUpzZcwZDXNyAACUDmRk/7Vk4uk6TvX2eZrwuXyFrFlmnuWTFSAesp1G3ih9KtngTePcaBp
 kd81aqD3vmxFsB3dweFxmSkLrdE+gjlQstogfOKvm5hEBnLH0RxzIAXAv3/6H7lb+YK3+FtQ8
 pyiSvNXIG9H9lNK0PtJ5aO26lmxwEH1cxcJD6+OIJQLxCxSkx63jSzoH8/Fd8qH8Sqa2E0MeT
 DEK4FTuf2tNPUEWlbywAswcYdYmrMYS67JoaLswoKJQn4pjWMFSCFXH+U5madqMR+GukCDV1Y
 9Qt7hSsnk6TxIzJyVn5IUDLGsGEHQkthJh1q8Zm7BSVeE5zYP7RgCef1hRfuEYcJqyaBNyI39
 Oa4bBWtqyofUDO5xuxg4Wv/3/JeyrNWqa5Ov5o9UDe7pvYgb/s8BSoicrvNZ6DiktRwUIO9kF
 PUyhMXR5ickNzXe7m188QN5raSLbsRhjMe5LFMo8vW5N7bICHsVZn0GXooJPqnS7Pa6pHeh2b
 yJc/5tUB6XVsrIo2zd4URxixEV4lSRYte46fwkTildG2IPns7A9wZbvJxc0AsQONwvwo5pmwG
 KdT3aLUhM9OSkPL2WOlr1lXdnKST1e6/aqxSUkjB+skB6R1r7mFeC6Fkx4XKJV+F50Z0U09Tc
 T+IAFf1CPAQnXJRZFkMom/R7aGtsE1j69dPazn/iLgkLuNEY1FWJW97i83qQsOC9vW9xkJZLi
 c8FOXpMo5yLYHRdxeA+L4cpzttjVOn1uqkr90+J5I5z/cmcuZBbYkEs483wngo6sG2GE+o754
 ZAkoBxYKjTFfN1u2N5RWl50Ovb3vII4DBlLrEDAVDjsro8GAAZPKNLgZRIUQQ3x4t/f4tui11
 TxTja2HfiUWppb+DXcQjjKcMgVSKppmJVPRefJMdU/Pek6z9R64SHJRm6I4dlEudXEz6kYvuO
 AWgPX0NcWrVn/NAOICU41Xs0l3j0cIj2xoPWDIyS7wkRj2IDKxSvtpYm3RM/BPp2k706Apksg
 GKJv3vXCaLIuIfyFe5ZWwxFwV1G4+DCffBUoJJAO8UegUggrG4awondT6YHeP+iHiI9FGLmco
 x8X9LUMJctwLPyDOhHbR92vo+PhOrnq5N5L+QR5B6+jmWqBBxqA9mBsfQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/28 =E4=B8=8B=E5=8D=881:57, Konstantin Svist wrote:
> On 8/20/21 19:56, Konstantin Svist wrote:
>> On 8/11/21 18:18, Qu Wenruo wrote:
>>>
>>> On 2021/8/12 =E4=B8=8A=E5=8D=886:34, Konstantin Svist wrote:
>>>> Shouldn't there be an earlier generation of this subvolume's tree blo=
ck
>>>> somewhere on the disk? Would all of them have gotten overwritten
>>>> already?
>>> Then it will be more complex and I can't ensure any good result.
>>
>> It was already pretty complex and results were never guaranteed :)
>>
>>
>>> Firstly you need to find an older root tree:
>>>
>>> # btrfs ins dump-super -f /dev/sdb3 | grep backup_tree_root
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 30687232=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen: 2317
>>>  =C2=A0level: 0
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 30834688=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen: 2318
>>>  =C2=A0level: 0
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 30408704=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen: 2319
>>>  =C2=A0level: 0
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 31031296=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen: 2316
>>>  =C2=A0level: 0
>>>
>>> Then try the bytenr in their reverse generation order in btrfs ins
>>> dump-tree:
>>> (The latest one should be the current root, thus you can skip it)
>>>
>>> # btrfs ins dump-tree -b 30834688 /dev/sdb3 | grep "(257 ROOT_ITEM" -A=
 5
>>>
>>> Then grab the bytenr of the subvolume 257, then pass the bytenr to
>>> btrfs-restore:
>>>
>>> # btrfs-restore -f <bytenr> /dev/sdb3 <restore_path>
>>>
>>> The chance is already pretty low, good luck.
>>>
>>> Thanks,
>>> Qu
>>
>>
>> When I run dump-tree, I get this:
>>
>> # btrfs ins dump-tree -b 787070976 /dev/sdb3 | grep "(257 ROOT_ITEM" -A=
 5
>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>> Csum didn't match
>> WARNING: could not setup extent tree, skipping it
>>
>> The same exact offset fails checksum for all 4 backup roots, any way
>> around this?

When without the grep, is there any output?

Thanks,
Qu

>
>
> *ping*
>
> Any hope left here?
>
