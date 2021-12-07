Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9478A46BA47
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 12:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhLGLra (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 06:47:30 -0500
Received: from mout.gmx.net ([212.227.15.18]:47495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231338AbhLGLr3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Dec 2021 06:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638877434;
        bh=9MGvFehM2cs3iSGDdNZuSszgbfw4j3q9OYIEctXyC6g=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=Dt65o30mYCf28/PFQc7v6FzR08AFPW7AnDVuL/L75kQl1hSuk2ULjW26EUFArvp10
         ODbn4vJ6DQS4f/qal9BPOcSmXK4Lf8aA6cWi8Ig342qTWmV7H+5wKUSgyw+2UE9UyT
         Wu4SA9Tk+5rzi5s3Jsl7aFuhPvZZq+7Uc3revljk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mqs4Z-1mGsXJ3b0r-00mry7; Tue, 07
 Dec 2021 12:43:54 +0100
Message-ID: <e019c8d6-4d59-4559-b56a-73dd2276903c@gmx.com>
Date:   Tue, 7 Dec 2021 19:43:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20211207074400.63352-1-wqu@suse.com>
 <Ya8/NpvxmCCouKqg@debian9.Home>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC 0/2] btrfs: remove the metadata readahead mechanism
In-Reply-To: <Ya8/NpvxmCCouKqg@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lR07ND141FKgm3oH+1nO5Rgs4C5Y5cY7jayUBdu5TOnMV+iQW+Y
 qnkkgWPudFTgRB8MYpxSl7Ejk28p1xcy7mEnzjGpgih+5oHmOMHtf4eAOYv+oPWThs7/93g
 czqtwFSZTqlVYh1afBiRkjARMmmPr++7vnMROmbY/9/EAVWPoiSe9bmSsZWKeqq86FJ8lAc
 5rBjTYSB2Qq7v0sZrwEug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7SHLWlsU0jc=:7H4nlKyztQNhmcaFBd5Y6s
 nqE5UNJqlXiWq6gY+UkuDOHDW8u0jIsOto68lWlLRozjL7r6k1y78mqZITZZyV2waSoFe1SiY
 /3lBHvDXzYbRwYgmHghio1cbXM8cutuaQreySwSWeXtKGY+Wfcbilpj076r8W5bHFcLSKSzCz
 Go9d6VfjrR+J9vTiJpz89Lqj1wcdUdQJCfA96qNsIJIGNzfq6Kg/T2Ej9XeyIyXvc/KaIUVs/
 w2Z+1R1SS6dHPluMyQdl6KJi2Rg+j/ddu6plYvvbwy35yYB+3Yx/xEb1/To3l1CpTgjA8aU9G
 L12chPeRfs4dJe5JpIGJ5q/hvk/nfNDoXgkev24On4jGK571BkSTjKB8hvYVkNK/hs0S46PZH
 0O/ikQ/GcNMTDVv8JU5FAMQzxVaEhPnJc3/QnilkHK2vu5f01NLF+bfH2+pieRkIxZ+aNPch6
 5n/7XtO64c2ZPnY2BRqpF0kOmrcibSA17Wt2wQK3PlpZGpFSW/U67FHzhrplM3ctoQE4dWjPB
 O+gU95qBIThHDEA5TYacykn84iPpVhQadDcr178VIgBPGnhbQwoLzSreY0ltB/drnmgavmsE8
 Mx2gsjjg8fsw1pW+Q7ihzFF1xwvAWcEhD1ClBVuxC3Gh9w2a6gmOJIWdi3chGROY26746vGGg
 seitYKQ1KcQwjUdR5EACobPRpevl5gBoc2mx6uRGTkYISEzLQpcEtQVBzKqUfPxy6gh3qcEOw
 ZgeejZ2iVp3l6+259dfXUl32Xp2zzRmlOwv35JBMBjDxbUOH/J0H/hoFINf4s++Ap0AgWCjnD
 BGINdM3tlOkx4n0vgq/JeD8Ttl0GGolXAYjHifATRHi/xHKAMH31+RTcUeUf6YM3oEAXKJhl2
 hK55hDB217RTb+YDdn84SomdU8/LGGsTGodHrvv113H+WARVsnRUpZ3TH/4YbcE+ArZ6P6yTr
 HSMjkPKzqy3oLviaYguMdC+r5Ttw2JnvFvq3ctX+9yrwH0Z+v9lCw96lUkeDNuV2QmqB1GZJT
 tKCWURdlh09mVEbZFRA/nj+nHEPot4RRZXkm386FZ2Vu8vAxyAmZthC8NuWAL1TK3Iue7VB7q
 kKLkcGbblLksKs=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/7 19:02, Filipe Manana wrote:
> On Tue, Dec 07, 2021 at 03:43:58PM +0800, Qu Wenruo wrote:
>> This is originally just my preparation for scrub refactors, but when th=
e
>> readahead is involved, it won't just be a small cleanup.
>>
>> The metadata readahead code is introduced in 2011 (surprisingly, the
>> commit message even contains changelog), but now only one user for it,
>> and even for the only one user, the readahead mechanism can't provide
>> much help in fact.
>>
>> Scrub needs readahead for commit root, but the existing one can only do
>> current root readahead.
>
> If support for the commit root is added, is there a noticeable speedup?
> Have you tested that?
>

Will craft a benchmark for that.

Although I don't have any HDD available for benchmark, thus would only
have result from SATA SSD.

>>
>> And the code is at a very bad layer inside btrfs, all metadata are at
>> btrfs logical address space, but the readahead is kinda working at
>> device layer (to manage the in-flight readahead).
>>
>> Personally speaking, I don't think such "optimization" is really even
>> needed, since we have better way like setting IO priority.
>
> Have you done any benchmarks?
> How? On physical machines or VMs?
>
> Please include such details in the changelogs.
>
>>
>> I really prefer to let the professional block layer guys do whatever
>> they are good at (and in fact, those block layer guys rock!).
>> Immature optimization is the cause of bugs, and it has already caused
>> several bugs recently.
>>
>> Nowadays we have btrfs_path::reada to do the readahead, I doubt if we
>> really need such facility.
>
> btrfs_path:reada is important and it makes a difference.
> I recently changed send to use it, and benchmarks can be found in the
> changelogs.

For the "such facility" I mean the btrfs_reada_add() facility, not the
btrfs_path::reada one.

>
> There are also other places where it makes a difference, such as when
> reading a large chunk tree during mount or when reading a large director=
y.
>
> It's all about reading other leaves/nodes in the background that will be
> needed in the near future while the task is doing something else. Even i=
f
> the nodes/leaves are not physically contiguous on disk (that's the main
> reason why the mechanism exists).

Unfortunately, not really in the background.

For scrub usage, it kicks readahead and wait for it, not really doing it
in the background.

(Nor btrfs_path::reada either though, btrfs_path reada also happens at
tree search time, and it's synchronous).

Another reason why the existing btrfs_reada_add() facility is not
suitable for scrub is, our default tree block size is way larger than
the scrub data length.

The current data length is 16 pages (64K), while even one 16K leaf can
contain at least csum for 8M (CRC32) or 1M (SHA256).
This means for most readahead, it doesn't make much sense as it won't
cross leaf boundaries that frequently.

(BTW, in this particular case, btrfs_path::reada may perform better than
the start/end based reada, as that would really do some readahead)

Anyway, only benchmark can prove whether I'm correct or wrong.

Thanks,
Qu
>
>>
>> So here I purpose to completely remove the old and under utilized
>> metadata readahead system.
>>
>> Qu Wenruo (2):
>>    btrfs: remove the unnecessary path parameter for scrub_raid56_parity=
()
>>    btrfs: remove reada mechanism
>>
>>   fs/btrfs/Makefile      |    2 +-
>>   fs/btrfs/ctree.h       |   25 -
>>   fs/btrfs/dev-replace.c |    5 -
>>   fs/btrfs/disk-io.c     |   20 +-
>>   fs/btrfs/extent_io.c   |    3 -
>>   fs/btrfs/reada.c       | 1086 ---------------------------------------=
-
>>   fs/btrfs/scrub.c       |   64 +--
>>   fs/btrfs/super.c       |    1 -
>>   fs/btrfs/volumes.c     |    7 -
>>   fs/btrfs/volumes.h     |    7 -
>>   10 files changed, 17 insertions(+), 1203 deletions(-)
>>   delete mode 100644 fs/btrfs/reada.c
>>
>> --
>> 2.34.1
>>
