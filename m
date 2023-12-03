Return-Path: <linux-btrfs+bounces-541-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B873780222C
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Dec 2023 10:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A46280E8F
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Dec 2023 09:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FBD8C18;
	Sun,  3 Dec 2023 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sNjHgkpK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444B6CD
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Dec 2023 01:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701594687; x=1702199487; i=quwenruo.btrfs@gmx.com;
	bh=tbSgx8TIv5b2+1heCpyHHykEe8FQHqB6QyqZ7HhtlTw=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=sNjHgkpKjvzt0SR33X6rSIWoQxcyu308MC5E/WVudofdQHPk2pi2iHSOWrKykmoy
	 8o+uJQ7cD4Ou+gKcbIcanavVafp4fL2/jQOaPEDZ5TABeyNEBIoReYbUT/ZVqKRol
	 t0BmrdiihzmIze+9tGzJHI4nuOOk1j7Agye2Eke2eUn38Naw+AFXz7abMHAWN8+E3
	 qZiUiV6bPX1iJrQ5bqip+m8S2e5pyH3z/pGiDtLd1Uxzd0CM57T8pysXeQtkoOrxx
	 mesYh4Hjlargu6UNddNwEVk7d+Nh8438JQ1tbcD1P5QyQMKVTMZtU7GYCTpJmuHXa
	 dtBZhkwfi1V5ioLtIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1My32L-1rTKYC0tGZ-00zTe0; Sun, 03
 Dec 2023 10:11:27 +0100
Message-ID: <6c2424bb-9c91-4ac0-970b-613ca97b3e01@gmx.com>
Date: Sun, 3 Dec 2023 19:41:23 +1030
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
In-Reply-To: <a9fafe9c-27c8-4465-aafa-a4af6987c031@wiesinger.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WvQvLuvauZ1IwxI+ln2bcN7hB7V6pXPXWB9scWsc7NG/hyUgUJV
 b1ipe8xay6fFCljOxWRVUZWP26EXufKVn5KuvajEaxm+EVHcwm60n6aSnZFRfjvrjLHXmwv
 hErnNTn9W8S5vSp6X1hUFQ8PDVpWLgzSk6ZYDTHxT6ejnlxp+yKOa7JAC7GL/FJikLlHZTQ
 T1XbT9YgzaYiqgxEcXx5Q==
UI-OutboundReport: notjunk:1;M01:P0:PLVVUElSysQ=;JBl8kMvRb8PP4iPjaDsb2q+3xFH
 n0RSZ7Bij+GZEpR1vrb1r33WDxpolFm9ByBbHA48+l3fjpElNhH1uas7EuJV/LgKFwR5Uj20n
 l/f3tLxiX9Jdb3CxMFNBiyPskbBOd4kwvTnZKW5/e1OHAEcn/5BaGW5UOQFSAAvBB8UKZOY5Q
 Qy6yMc3EN7cerr6u9NZ/9BPCj/0H2eBtt/XZ2waXff6NIlJAxW//1TYE0daiYyqel3xz6T4tQ
 6HAex7ioAtyWoWTdrvJJHicEoFaZ/rlTzbzmZuUjEvQEQRfzymAycTdnkoyBZbaVyWCf71VmU
 ihlyFfXh5GZhAUuDbsGkT0A58EvUW09dMw5mYSqRDnATzN0skK0MY7xGgw4+58zpR8aGAVxfC
 m+9sdjSl72QmHK43b/82buMrEm2Z0Pyn2T0eVIJ4z3czv8aHcTFFG7Fb+rvYERjEq9vPmBeRz
 af1U9VRvMNdmnL336GC9yvshun2Nt9ze26owwOBPps2Dex73wbSTXmCG09iNrnM8GUjFJ30NP
 gf9qAe7eX1bVRgILwzPh1MZTnVhhJW4piCjgYEekc4CZ5LgiCFVbgTabbuf/yLw3kOJzf9h7m
 DyrVYHJ6QpkWdvMY/KpTrwvK6FD1q2DO0go3goYwiahMDj4RjfOs3GqM/3vsCdMt4mx5ljbYW
 se8p3sgNlcXWI0oyahlKYKIAo6hw85hIFUL07SCnl5+ISE+yveAkRcKKOnxqcglexxCciUkTn
 t6onGIpUBD/uIP2iOs4y3GDuo4eSf5wydpQF4GMrNYeEAPfUfVmJvxF52BaALCMdaBqkFGb5o
 wckuoU+wgfcYQDvu9c1mOQOxbK0VaQaXOlcYm61D5yC7XsRm29BYO+7z5QZp0Ro2U5GMn1y4C
 1ogwPbSHVWvsfhXAdh0kV7DNofJgzStfoeyJoQMiv7Fbp1y2+WU2zGib8itu3U/U5ozBXxS9g
 l+dB7Dz4vZgaoZMqHSUH8NrCMW0=



On 2023/12/3 18:54, Gerhard Wiesinger wrote:
> On 02.12.2023 22:56, Qu Wenruo wrote:
>>>
>>>>
>>>> How can I find something about preallocation out?
>>>
>>> Above compsize is already showing there is some preallocated space.
>>>
>>> Thus I'm wondering if the preallocation is the cause.
>>>
>>> As should_nocow() would also check the PREALLOC inode flag, and tries
>>> NOCOW path first (then falls to COW if needed)
>>
>> Yep, I just reproduced it, for any INODE with PREALLOC flag (aka, the
>> file has some preallocated range), even we're writing into the range
>> that needs COW anyway (e.g. new writes which would enlarge the file),
>> the compression would not work anyway.
>>
>> =C2=A0# mkfs.btrfs test.img
>> =C2=A0# mount test.img -o compress-force=3Dzstd /mnt/btrfs
>> =C2=A0# fallocate -l 128k /mnt/btrfs/file1
>> =C2=A0# xfs_io -f -c "pwrite 128k 128k" /mnt/btrfs/file1
>> =C2=A0# xfs_io -f -c "pwrite 128k 128k" /mnt/btrfs/file2
>> =C2=A0# sync
>>
>> Since file1 has 128K preallocated range, thus the inode has PREALLOC
>> flag, and would lead to no compression:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0item 6 key (257 INODE_ITEM 0) itemoff 15811 ite=
msize 160
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation 8 transid 8 size =
262144 nbytes 262144
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block group 0 mode 100644 li=
nks 1 uid 0 gid 0 rdev 0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sequence 33 flags 0x10(PREAL=
LOC) <<<<
>> =C2=A0=C2=A0=C2=A0=C2=A0item 7 key (257 INODE_REF 256) itemoff 15796 it=
emsize 15
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 index 2 namelen 5 name: file=
1
>> =C2=A0=C2=A0=C2=A0=C2=A0item 8 key (257 EXTENT_DATA 0) itemoff 15743 it=
emsize 53
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation 8 type 2 (preallo=
c)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prealloc data disk byte 1363=
1488 nr 131072
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prealloc data offset 0 nr 13=
1072
>> =C2=A0=C2=A0=C2=A0=C2=A0item 9 key (257 EXTENT_DATA 131072) itemoff 156=
90 itemsize 53
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation 8 type 1 (regular=
)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent data disk byte 137625=
60 nr 131072
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent data offset 0 nr 1310=
72 ram 131072
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent compression 0 (none) =
<<<
>>
>> Meanwhile for the other file, which has no prealloc, would go regular
>> compression path.
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0item 10 key (258 INODE_ITEM 0) itemoff 15530 it=
emsize 160
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation 8 transid 8 size =
262144 nbytes 131072
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block group 0 mode 100600 li=
nks 1 uid 0 gid 0 rdev 0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sequence 32 flags 0x0(none)
>> =C2=A0=C2=A0=C2=A0=C2=A0item 11 key (258 INODE_REF 256) itemoff 15515 i=
temsize 15
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 index 3 namelen 5 name: file=
2
>> =C2=A0=C2=A0=C2=A0=C2=A0item 12 key (258 EXTENT_DATA 131072) itemoff 15=
462 itemsize 53
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation 8 type 1 (regular=
)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent data disk byte 138936=
32 nr 4096
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent data offset 0 nr 1310=
72 ram 131072
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent compression 3 (zstd)
>>
>> To me, this looks a bug, and the reason is exactly what I explained
>> before.
>>
>> The worst thing is, as long as the inode has PREALLOC flag, even if all
>> preallocated extents are used, it would prevent compression from
>> happening, forever for that inode.
>>
>> Let me try to fix the fallback to COW path to include compression.
>
>
> Thank you for reproducting it. Think we nailed it down.
>
> Is there a way to get the output of the file of the chunks/items?

You can always dump the full subvolume (`btrfs ins dump-tree -t
<subvolid> <device>`), then try to grep the inode which has PREALLOC
alloc (`| grep -C 5 "flags.*PREALLOC"), which would include the inode
number, then you can ping down the inodes which has PREALLOC flags and
not undergoing compression.

I won't be surprised most (if not all) files of postgresql would have
that flag.

Thanks,
Qu
>
> Thnx.
>
> Ciao,
>
> Gerhard
>

