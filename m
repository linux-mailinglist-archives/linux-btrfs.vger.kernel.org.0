Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9C33FA7FE
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 01:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhH1XbP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Aug 2021 19:31:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:36147 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230074AbhH1XbP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Aug 2021 19:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630193422;
        bh=cYRjSdFijmB5P23E0MtV+wY9wY3bD9h1NCPFQevcTAU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Oi6pS9RCTaYVq4gUnJpDtc5Xrhdeh6vuUY+SVTmgIQoUjq5PwTme03mRbi+zr7vjL
         HvWdl27eYedkMWDSpeCr0cEn72JP+/UzXuVWRdCflEH5lmiHHqsC4XAH9Q2Uh2Z6pG
         hjXUglisLJ/qCgzKG3qbdkEkF8rJOzl0Qc/MKCDs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N49hB-1n2DzI3Ge9-0108eG; Sun, 29
 Aug 2021 01:30:22 +0200
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
 <14a9a98c-50fc-eb7b-804b-2fe36775b5fa@gmx.com>
 <36652872-850c-fe92-9fcd-c9c95dc25d65@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <cebedd98-1fe4-731f-fc54-5366c8f18a2f@gmx.com>
Date:   Sun, 29 Aug 2021 07:30:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <36652872-850c-fe92-9fcd-c9c95dc25d65@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g/xTvlTwM1oIW+Syo/sHZ4Cff2ZsGpKb8m2P0MqskxkOPUUo/ez
 pcyezDx45FtsgglS0lHvP2QNEime2Wf6gIvw1XfXPonbdEUweBA15MgMyWVNjhQBjzP5lUm
 J+uSL/1LfLSN28ci2LITdISzmFv2b9Ep8GRb6gDwvpSWboijliFsUXxgQrhrsmR+7htgRKH
 912/Ld9kiHjtqRfribjng==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4OxmtfO1whY=:sGAdeMqVktivX5uHr/7Ra2
 UGQMry0TV1RGmwvKVk+tIqbUQp3NuPMCGDUUt43PzKobvF4JZ7/q8wFutVvSsmidWG+C8jURi
 4ZgubGD6QqSTK7K6ZcUsR+ziVNUiOtQg9JfcUHDA3GoyH9GYnYLylllRDqWuxbgnmj8Xne3xQ
 lZkVu+zmHMJ60uuBHen9oV3XvUUWXzXn1Y0q2DAG1fJZTh+8cqe1Aj8yqe7LPMwkKOU7uFT60
 7oVxbYAfNr8gegE6FsvDKLd661xtAfnbGIb4ZoM8RA8wGwO3N0/qA+px7J5KVIpyzt0ncT2wB
 p92di/EPxq1fWtWq8DoPKRsr8ZZJxZj86EKuG+IKJ0pTNupydvS4w/9BCbBmWRjdrOlaIg3rF
 /w8th5LDAV8dIO1bC/k3NfNJKcITLZvvKwp1x/0NPWoZn0SD/g98HTG3pFw/n2rTANGZavaOv
 R0sMtK0pRiDeFE8ULoJ1pjX75yYIVCQfUkEyNiyl3ETeJ8zhrPm+Vopeqpo7q3FRiXzuTjT8/
 VB10mpQS6UP1XcP9P06p/nlmKXlmALZ6SHzXwggn8xOVCyWyH3xn3JZo3bKAHV5/4cLhQ7xrk
 qAgRBGxRIfyGTwaHJG+qLTCFdaLtF4X/gY9DFKWzbpR2XXqLaM3yGAZBgNcXlZRUpRLnOiRWc
 gW5Y9S+HyQkITntkW1sS+Vgo4noxehA7l++ZyMjNSMTcGp1/R861vw5TtVHrXNC6NaGe6a3i7
 E3749NQq25PMTsyAJFbdctM1nLSIGtenMpv1SJvKGq7hXVVSejsJl7BG6kIRPHEJtSnoQkuR0
 CqKUHgBeDpNy55gzAJ7KiylVoyV4Cq4EzZOOFtWLEvaXAsi9Dh3DiWZXEIwZEGUMfYdF0HkXB
 4qlWwRjXTHB2UkQgQwa8CvRtWSEFb9yf4PwIwGgdRCAVODAS88hL2gMIMqSIOPQoAmFe97dvB
 rMNcFMsYWhAz4PPkNb8GszB9euVTgx9WTPIJL65gL+vt0EuxHe5nCcZ/F7PYIYWIWGctUolw0
 nVtWTbL7mzjrFDhbMYQTLgaN3p0Gi4pl/EDOkCTDM+vuhfiSlMm6c1cylXsLAsc6Lz6Wrm+NE
 kuWDDI8XR0zInRb6s3Pzeg55EqbT0G48FTPOH3jFwqrkAYzd9ZhcRHPQQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/29 =E4=B8=8A=E5=8D=887:16, Konstantin Svist wrote:
> On 8/27/21 23:16, Qu Wenruo wrote:
>>
>>
>> On 2021/8/28 =E4=B8=8B=E5=8D=881:57, Konstantin Svist wrote:
>>> On 8/20/21 19:56, Konstantin Svist wrote:
>>>> On 8/11/21 18:18, Qu Wenruo wrote:
>>>>>
>>>>> On 2021/8/12 =E4=B8=8A=E5=8D=886:34, Konstantin Svist wrote:
>>>>>> Shouldn't there be an earlier generation of this subvolume's tree
>>>>>> block
>>>>>> somewhere on the disk? Would all of them have gotten overwritten
>>>>>> already?
>>>>> Then it will be more complex and I can't ensure any good result.
>>>>
>>>> It was already pretty complex and results were never guaranteed :)
>>>>
>>>>
>>>>> Firstly you need to find an older root tree:
>>>>>
>>>>> # btrfs ins dump-super -f /dev/sdb3 | grep backup_tree_root
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 30687232=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen: 2317
>>>>>  =C2=A0=C2=A0level: 0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 30834688=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen: 2318
>>>>>  =C2=A0=C2=A0level: 0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 30408704=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen: 2319
>>>>>  =C2=A0=C2=A0level: 0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 31031296=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen: 2316
>>>>>  =C2=A0=C2=A0level: 0
>>>>>
>>>>> Then try the bytenr in their reverse generation order in btrfs ins
>>>>> dump-tree:
>>>>> (The latest one should be the current root, thus you can skip it)
>>>>>
>>>>> # btrfs ins dump-tree -b 30834688 /dev/sdb3 | grep "(257 ROOT_ITEM"
>>>>> -A 5
>>>>>
>>>>> Then grab the bytenr of the subvolume 257, then pass the bytenr to
>>>>> btrfs-restore:
>>>>>
>>>>> # btrfs-restore -f <bytenr> /dev/sdb3 <restore_path>
>>>>>
>>>>> The chance is already pretty low, good luck.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>
>>>>
>>>> When I run dump-tree, I get this:
>>>>
>>>> # btrfs ins dump-tree -b 787070976 /dev/sdb3 | grep "(257 ROOT_ITEM"
>>>> -A 5
>>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b=
6
>>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b=
6
>>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b=
6
>>>> Csum didn't match
>>>> WARNING: could not setup extent tree, skipping it
>>>>
>>>> The same exact offset fails checksum for all 4 backup roots, any way
>>>> around this?
>>
>> When without the grep, is there any output?
>
>
> # btrfs ins dump-tree -b 787070976 /dev/sdb3
> btrfs-progs v5.13.1
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> Csum didn't match
> WARNING: could not setup extent tree, skipping it
> node 787070976 level 1 items 7 free space 486 generation 166932 owner
> ROOT_TREE
> node 787070976 flags 0x1(WRITTEN) backref revision 1
> fs uuid 44a768e0-28ba-4c6a-8eef-18ffa8c27d1b
> chunk uuid a8a06213-eebf-40d8-ab1a-914f621fbe1c
>  =C2=A0=C2=A0=C2=A0 key (EXTENT_TREE ROOT_ITEM 0) block 787087360 gen 16=
6932
>  =C2=A0=C2=A0=C2=A0 key (277 INODE_ITEM 0) block 197491195904 gen 56511
>  =C2=A0=C2=A0=C2=A0 key (305 INODE_ITEM 0) block 778174464 gen 166929
>  =C2=A0=C2=A0=C2=A0 key (366 EXTENT_DATA 0) block 197491949568 gen 56511
>  =C2=A0=C2=A0=C2=A0 key (428 INODE_ITEM 0) block 36175872 gen 166829
>  =C2=A0=C2=A0=C2=A0 key (476 INODE_ITEM 0) block 787234816 gen 166932
>  =C2=A0=C2=A0=C2=A0 key (FREE_SPACE UNTYPED 99888398336) block 780812288=
 gen 166929

My bad, I forgot to add "--follow" option for "btrfs ins dump-tree"

So the full command is:

$ btrfs ins dump-tree -b 787070976 --follow /dev/sdb3

Then you should be able to find "(257 ROOT_ITEM".

Thanks,
Qu

>
> # btrfs ins dump-tree -b 778108928 /dev/sdb3
> btrfs-progs v5.13.1
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> Csum didn't match
> WARNING: could not setup extent tree, skipping it
> node 778108928 level 1 items 7 free space 486 generation 166929 owner
> ROOT_TREE
> node 778108928 flags 0x1(WRITTEN) backref revision 1
> fs uuid 44a768e0-28ba-4c6a-8eef-18ffa8c27d1b
> chunk uuid a8a06213-eebf-40d8-ab1a-914f621fbe1c
>  =C2=A0=C2=A0=C2=A0 key (EXTENT_TREE ROOT_ITEM 0) block 778125312 gen 16=
6929
>  =C2=A0=C2=A0=C2=A0 key (277 INODE_ITEM 0) block 197491195904 gen 56511
>  =C2=A0=C2=A0=C2=A0 key (305 INODE_ITEM 0) block 778174464 gen 166929
>  =C2=A0=C2=A0=C2=A0 key (366 EXTENT_DATA 0) block 197491949568 gen 56511
>  =C2=A0=C2=A0=C2=A0 key (428 INODE_ITEM 0) block 36175872 gen 166829
>  =C2=A0=C2=A0=C2=A0 key (476 INODE_ITEM 0) block 780730368 gen 166929
>  =C2=A0=C2=A0=C2=A0 key (FREE_SPACE UNTYPED 99888398336) block 780812288=
 gen 166929
>
> ..and 2 more from other backup_tree_roots
>
>
