Return-Path: <linux-btrfs+bounces-543-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE849802277
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Dec 2023 11:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 296D0B20ABE
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Dec 2023 10:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAC98F69;
	Sun,  3 Dec 2023 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ZMcnQ9pI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D824F3
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Dec 2023 02:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701598796; x=1702203596; i=quwenruo.btrfs@gmx.com;
	bh=TZdCB1K4i4JHymoqSNNNSpDRZ52q9xjwKoklG5ySl2U=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=ZMcnQ9pIteLT06b5Dwy5/q97V1asJpWMUWAgmgkMlAruCCSIrMjXaFFKTHkM+RPY
	 Gc/DtSgWJn1M+JLQVYeoxB+sdwSNrRxV9jmlWYqXS7Wsi0Vcv8S4rm2yyuKgaGCJV
	 5mto5YHBpHHO0Z6LU+g7WrJYJaMZ7RSMBkyFGJpxoU7Uu56Gw0SDaOWX+4eFn2Dom
	 GfS2ZTceBr2FSGTonRB+IPGJvC4VwaRfdtjlJSMoTRXG6tbHYQQ+GK7wd7Tsu1Wrd
	 M1AOgT/QZ5nRxl7J8Rbtu+FhBZ3dbBo5Vx5XmcOxjuFj0KRh2rmgAyynKTvgrH6tn
	 gROangrPagbebkcrsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MlNtP-1rXHlO2YDF-00lnnd; Sun, 03
 Dec 2023 11:19:56 +0100
Message-ID: <9f4ad251-7af7-4f02-b388-64dd6c8257ac@gmx.com>
Date: Sun, 3 Dec 2023 20:49:51 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS doesn't compress on the fly
Content-Language: en-US
To: Gerhard Wiesinger <lists@wiesinger.com>, linux-btrfs@vger.kernel.org
References: <ac521d3f-6575-4a72-a911-1991a2ca5f67@wiesinger.com>
 <ccec2d73-98a7-4e73-a9ee-9be0fc2e1c92@gmx.com>
 <b7995589-35a4-4595-baea-1dcdf1011d68@wiesinger.com>
 <d30abb90-4ab2-4f66-88b0-7d0992b41527@gmx.com>
 <6ae85272-3967-417e-bc9a-e2141a4c688a@gmx.com>
 <a9fafe9c-27c8-4465-aafa-a4af6987c031@wiesinger.com>
 <6c2424bb-9c91-4ac0-970b-613ca97b3e01@gmx.com>
 <771df9a9-c7c3-40a7-a426-0126118d3af0@wiesinger.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <771df9a9-c7c3-40a7-a426-0126118d3af0@wiesinger.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MpsV0iNGq26RWflYVZ25VnTz2PdEYnxnnsD9e7bMHJg3wOzci0T
 2Cypp++u/Pv7q4nEPZUpdU56NOD2p66RcxOuQVz+D6aWsHKGMyfOHCw4rr68HEaHjqxKnO4
 Fy5HQlPTLuydJDPU9VnpuBhnVanKcgOYiS8j4mmt9JP4WiFEeptmhjrXSCjI35hbMNkZEJf
 PjFU8M2ITEOYTkkcm/E5Q==
UI-OutboundReport: notjunk:1;M01:P0:Xvf+ShnjSzs=;Sf0m4arYbzJ2WweZaPozWMDIHEM
 kP7uzxviPUb1ozCRqsaTqUaAU0jioKh6lS8fyn9+36RsOnN+/jwsCRLk7b8WbpYgd6PtyyEc3
 eBe/sxKUAql9Qke8z9g+OAWl+iiUFILBJigFQnJBcz0k6Yp9xegPWoHobF1thsDDjNh4BTLjQ
 1GAd9odP4k2vHW8IVmZisY/yOmi88eW1oi2lqG+SUiPp67E1p10/Lqwim1e26XSVYY2PiHDKl
 Ort4HdJ+i2UIX1MN2YvkCQHkFswDidrl+ETWSBHzAK2lB58UXDW25LlnNl414ADVXVJzQPAaw
 vBh7/zBG1RLi5xwypSZk2qeMqf/Dza2wBDw1XeQMGl8pburtYqP1qhR6+ihwkYsF5MFr+OC5M
 zog6BIqNOyO7bJVbQUTIK7sodu1StgZ9rdlEK9FGsQqtkvE6nlOeg6YxNxuJ8n+ezSS8JPFJ/
 LCyUoH1DQVAGvnjjo4CPnMZFZbcRkymop+kLlYkmsB/znPQQUJE39Cv3nX636Ed//dGvZvFhK
 sgbL4qXJKBVjEBMGw8u5oHy2BnKfKUKCtVyAYeMO0LKkrtPM3PUQuFlyYajg/IFF14/N8C0Lp
 K0QNJTqZEXbUpCIgG25mFNW4Bj0s91eGkYL7zeV7RukEbUuStwGwSClh6WpTKqlbNOURXfiUg
 oeMpub1l83YGADWSI9FFXtQ6meJbWV1A517HJmT0Nt6vMJgMBPSdQX6x6cTkAdl2MmUJ4QOrv
 oMlqwNq132simHoxNFiJJiZkgWlqU8iw3tERgX3XOLNbCfVmdqP2VPQcE9z3qvPa6u7kGcFMh
 iXU+FD0aSfH/nbz8LrousG3sen3UNxY0DMOD4J27N/l1wEkc65kdbs6Q8OWVrRPUPCqYV2YJi
 QzZ7n/q+BHXkPKKP6EUMC/5fESRjVo2j0ASEZwSc8V6SNnC8nHaSdaBaZEQQphCNP6jkActOo
 U24cv5YFAJLTpMRaPRRzQ9vaOho=



On 2023/12/3 20:15, Gerhard Wiesinger wrote:
> On 03.12.2023 10:11, Qu Wenruo wrote:
>>
>>>
>>> Thank you for reproducting it. Think we nailed it down.
>>>
>>> Is there a way to get the output of the file of the chunks/items?
>>
>> You can always dump the full subvolume (`btrfs ins dump-tree -t
>> <subvolid> <device>`), then try to grep the inode which has PREALLOC
>> alloc (`| grep -C 5 "flags.*PREALLOC"), which would include the inode
>> number, then you can ping down the inodes which has PREALLOC flags and
>> not undergoing compression.
>>
>> I won't be surprised most (if not all) files of postgresql would have
>> that flag.
>
> Looks like only a small part has PREALLOC:
>
> find /var/lib/pgsql -type f | wc -l
> 5569
>
> btrfs inspect-internal dump-tree /dev/mapper/datab | grep -i PREALLOC |
> wc -l
> 95
>
> For reference:
>
> How to find the file at a certain btrfs inode
> https://serverfault.com/questions/746938/how-to-find-the-file-at-a-certa=
in-btrfs-inode
>
> btrfs inspect-internal inode-resolve 13269 /var/lib/pgsql
> /var/lib/pgsql/16/data/base/16400/16419
>
> find /var/lib/pgsql -xdev -inum 13269
> /var/lib/pgsql/16/data/base/16400/16419
>
> # Get=C2=A0 files from inodes
>
> btrfs inspect-internal dump-tree /dev/mapper/datab | grep -C 5
> "flags.*PREALLOC" | grep -i INODE | perl -pe 's/.*?\((.*?) .*/$1/' |
> sort | uniq | while read INODE; do echo -n "$INODE: ";btrfs
> inspect-internal inode-resolve ${INODE} /var/lib/pgsql; done
>
> # Number of inodes, count is consistent
>
> btrfs inspect-internal dump-tree /dev/mapper/datab | grep -C 5
> "flags.*PREALLOC" | grep -i INODE | perl -pe 's/.*?\((.*?) .*/$1/' |
> sort | uniq | while read INODE; do echo -n "$INODE: ";btrfs
> inspect-internal inode-resolve ${INODE} /var/lib/pgsql; done | wc -l
>
> 95
>
> All files are in subdirectories: /var/lib/pgsql/16/data/base/
>
> Already an idea for the fix?

We can copy the files (without using reflink) to a temporary location
(better out of btrfs), then copy the temporary copy back to overwrite
all the existing files.

The problem is still inside pgsql, as long as they do preallocation, the
same problem would still happen.

>
> BTW:
>
> if compression is forced, should be then just any "block" be compressed?

There is a long existing problem with compression with preallocation.

One easy example is, if we go compression for the preallocated range,
what we do with the gap (compressed size is always smaller than the real
size).

If we leave the gap, then the read performance can be even worse, as now
we have to read several small extents with gaps between them, vs a large
contig read.

IIRC years ago when I was a btrfs newbie, that's the direction I tried
to go, but never reached upstream.

Thus you can see some of the reason why we do not go compression for
preallocated range.

But I still don't believe we should go as the current behavior.
We should still try to go compression as long as we know the write still
needs COW, thus we should fix it.

Thanks,
Qu

>
> Or, what's the problem of the logic?
>
> Thnx.
>
> Ciao,
>
> Gerhard
>

