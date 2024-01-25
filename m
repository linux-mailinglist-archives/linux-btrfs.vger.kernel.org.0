Return-Path: <linux-btrfs+bounces-1812-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02C083D056
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 00:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8601428D121
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 23:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC91F125DC;
	Thu, 25 Jan 2024 23:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="oI3ZA9JM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C27711700
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 23:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223898; cv=none; b=Uyk3oZ/ALrhCRSGSgZj6qgZ4pE4WwWC87+MbuNiLddh4vt0TvP6IIf1YV19w2y6KSRmx0iCyyIa8Q5plBTHA9qtFsV1VxHVp5VBqyPOeGm9rjSmxwpaoixD72fz7tiVkwZQHgP2EMzN8n+ZFpS0Wzr9HQrvcLiFiABhJEeFBeHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223898; c=relaxed/simple;
	bh=NEVbP1Dit7HxkyipyZEHg7pv1JT4e160o+DLDVWV3Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXRH8kKPty2vvTXrBet3AZ5sD7LaKV3Ev9U7ImHrLtVj4POtUlZhQBLsFwq81w3Ixvi+YKZbdSi0bsUGd1AuNAjCprl5+aAzv7BFjI4xou1aZ5x6bgxDt2qTHjXf1hoeqQOqNx6VeqfqFCxfMnMQ5xSNGXB7TD6nObgeYalauMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=oI3ZA9JM; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706223882; x=1706828682; i=quwenruo.btrfs@gmx.com;
	bh=NEVbP1Dit7HxkyipyZEHg7pv1JT4e160o+DLDVWV3Cs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=oI3ZA9JM6+fy+JwmG7xKMpS0O/l6iW8l2yCOo74E6TUyewYNWcj+diYUOTSE9Lkr
	 ygTPLOeEMYikGgFm20CpAtKisZs5LDw+NUS1B0C1io/E1+K3/3Q2KaFUFqciayxbe
	 vcpxTNMfLQbFFth7TUzoBlBWXwAhXKiSVRrpruUW5Cko6Kz8BBb70f3z3bnIchygk
	 SmL519x3V/ZdvVrX7VGuBFcFlxHpjEiinaa8ECj6oJcN7pp5EjulXeRk+w4VBoCpc
	 /Ls79586/L5r4NFhYFGPlxxAePord1dDj8MXiqu8G/PhonxvBIB/5GOio8JLSgl8q
	 PC4sAtywwEHd80sy+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8ofO-1qyg0N0MRK-015qrx; Fri, 26
 Jan 2024 00:04:41 +0100
Message-ID: <e8651759-c364-424a-a2b7-ef7acd128974@gmx.com>
Date: Fri, 26 Jan 2024 09:34:36 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG in raid6_pq while running fstest btrfs/286
To: Filipe Manana <fdmanana@kernel.org>, dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, Jeff Layton <jlayton@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Song Liu <song@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <72097c8f447b02fb4ed3cb6b898d73423ca52d09.camel@kernel.org>
 <8b24dc83-1506-b5cc-1441-5233d161f5d8@suse.com>
 <20230619175443.GE16168@twin.jikos.cz>
 <CAL3q7H6bmy-a7hk216HgbbZZfS-t59bV2HZa18TJ=qHXMHJfRw@mail.gmail.com>
Content-Language: en-US
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
In-Reply-To: <CAL3q7H6bmy-a7hk216HgbbZZfS-t59bV2HZa18TJ=qHXMHJfRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:McAA47+HozfeAeij+wmCFGTFAMrroDyFCsE8aCjAr44Y99iUbr/
 pEXhChIfzXP9aLWyq4gcr5LLdBpGXII4du7HMmNhiGmMRpoBl3I7/VRCIX6GeipSSTZ6cad
 N4IF4NdNWdDiffyaFG3eFjb6ZB9nNsN9IC8gmwbIyB2HTL85qrXc3zeTLFb8We8j9w4DB9M
 ty44C22trAmf4Fe7VBvpA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PtpZWeTo/9U=;JZoVoDDpZ9e2r1kBKHnPPmdLQcs
 GhZRguEA4/wF10DVgoPQW7PLO7rKTtjEtRu6QZBtrJD9JnTCwkOs/c9qFQ84IU9HMj+uhmVNA
 8kyFfcq4HdHJJBJ8EBFkNPCs/PaXpfzYqCFyut1zTlBj8PRJBqFbQFln4RkxtvRsPqPiUT4G4
 bBO1j4rcEBYEtK1UUtpxhn10241a6WAVlMN5Ht1Vlf839Cu3qeNy96SYorkOHvFQn+j0/8InC
 nHZqjYyYkZAfJEOvDOORjFYx7LO6jayqEoXl3XDhZ9bB09W7igV0Bi6oFvedNEDQeiKQbmPGr
 8V+UpZdYNd/ejqK6zQb2pS1eIM3+iT3ZKWKX//EAO/DYvF/8ieokB7IAIhCVo68f0K5bzGU/e
 y3JCEj1zGWkOUhVYmuWZpwsjhPmxUorihA/f5vRSrRtj47IXb98j9snfK6Fd2fiRuUkjhBkTs
 xZGoDG++wB9xmJPSweXqF67mrIhR0gMd1wgai1B8wpKK4jFFau/+sJTOZwFiWoTAq/dnM4L4b
 R9KP/FLb4nLmQ17bLoXn0+B+Y2zcAb4Fzi//LI0I7bKaOQ+QMtshapHaJB3wVX1veStXKBkQf
 pFUMNcDHhCi/cO5GO7bbCmUNuKbpVI6+g9DmdLoN0b1FL7+kUr+TMWBE/jONYknaI9zXz5OeJ
 Ttqv6wAJsq/C2FOEyCfMBYRZyLV1al0PBS+/uCThFbZ7NdZIfhaUfbZSR1ubUGFcAPVSE6h2e
 krUT/JHg+lomRni2tgSfPN6q320BObfmmq8Y+lOj7xy36zKfdTLHRnNp/x3yIyEgqN6d2EoQ/
 S7zuCoEEN0ztdhvaGOORPSaAZvcg2SGIF3+rQe1fyY6ag+GJqWlwio7RDaM2YJIVpjZRi7SOB
 D8v9uOQKJlgW3NlBuIrMoyY4SvHfFkL82Nbb0oY0p7/8F9a+SQ1CS8Lhh4NICcPfAC+CevrZy
 hdxP4dbNxEO33lGqFbZzJHWc77o=



On 2024/1/25 20:43, Filipe Manana wrote:
> On Mon, Jun 19, 2023 at 7:36=E2=80=AFPM David Sterba <dsterba@suse.cz> w=
rote:
>>
>> On Fri, Jun 16, 2023 at 09:57:47AM +0800, Qu Wenruo wrote:
>>> On 2023/6/16 01:58, Jeff Layton wrote:
>>>> I hit this today, while doing some testing with kdevops. Test btrfs/2=
86
>>>> was running when it failed:
>>>>
>>>> [ 4759.230216] run fstests btrfs/286 at 2023-06-15 16:11:41
>>>> [ 4759.636322] BTRFS: device fsid 8d197804-9964-4b3f-bbea-3ef33869b56=
4 devid 1 transid 484 /dev/loop16 scanned by mount (893879)
>>>> [ 4759.641190] BTRFS info (device loop16): using crc32c (crc32c-intel=
) checksum algorithm
>>>> [ 4759.644817] BTRFS info (device loop16): using free space tree
>>>> [ 4759.650706] BTRFS info (device loop16): enabling ssd optimizations
>>>> [ 4759.652720] BTRFS info (device loop16): auto enabling async discar=
d
>>>> [ 4760.484561] BTRFS: device fsid 2a451aed-b7b6-4498-ba17-0e28a2e1a26=
b devid 1 transid 6 /dev/loop5 scanned by (udev-worker) (894101)
>>>> [ 4760.494221] BTRFS: device fsid 2a451aed-b7b6-4498-ba17-0e28a2e1a26=
b devid 2 transid 6 /dev/loop6 scanned by (udev-worker) (892207)
>>>> [ 4760.497373] BTRFS: device fsid 2a451aed-b7b6-4498-ba17-0e28a2e1a26=
b devid 3 transid 6 /dev/loop7 scanned by (udev-worker) (892535)
>>>> [ 4760.502687] BTRFS: device fsid 2a451aed-b7b6-4498-ba17-0e28a2e1a26=
b devid 4 transid 6 /dev/loop8 scanned by mkfs.btrfs (894095)
>>>> [ 4760.515672] BTRFS info (device loop5): using crc32c (crc32c-intel)=
 checksum algorithm
>>>> [ 4760.519412] BTRFS info (device loop5): setting nodatasum
>>>> [ 4760.521777] BTRFS info (device loop5): using free space tree
>>>> [ 4760.527120] BTRFS info (device loop5): enabling ssd optimizations
>>>> [ 4760.528861] BTRFS info (device loop5): auto enabling async discard
>>>> [ 4760.532184] BTRFS info (device loop5): checking UUID tree
>>>> [ 4762.658754] BTRFS info (device loop5): using crc32c (crc32c-intel)=
 checksum algorithm
>>>> [ 4762.662098] BTRFS info (device loop5): allowing degraded mounts
>>>> [ 4762.664749] BTRFS info (device loop5): setting nodatasum
>>>> [ 4762.667347] BTRFS info (device loop5): using free space tree
>>>> [ 4762.672306] BTRFS warning (device loop5): devid 2 uuid de8712ab-ca=
85-4414-93a7-213060d1831d is missing
>>>> [ 4762.676977] BTRFS info (device loop5): enabling ssd optimizations
>>>> [ 4762.679852] BTRFS info (device loop5): auto enabling async discard
>>>> [ 4763.355404] BTRFS info (device loop5): dev_replace from <missing d=
isk> (devid 2) to /dev/loop9 started
>>>> [ 4763.595633] BTRFS info (device loop5): dev_replace from <missing d=
isk> (devid 2) to /dev/loop9 finished
>>>> [ 4764.044660] 286 (893750): drop_caches: 3
>>>> [ 4765.384814] BTRFS: device fsid 7acce38c-63c2-4365-a338-e1f6c0fd484=
b devid 1 transid 6 /dev/loop5 scanned by (udev-worker) (894101)
>>>> [ 4765.392235] BTRFS: device fsid 7acce38c-63c2-4365-a338-e1f6c0fd484=
b devid 2 transid 6 /dev/loop6 scanned by (udev-worker) (892207)
>>>> [ 4765.404469] BTRFS: device fsid 7acce38c-63c2-4365-a338-e1f6c0fd484=
b devid 3 transid 6 /dev/loop7 scanned by (udev-worker) (894101)
>>>> [ 4765.412107] BTRFS: device fsid 7acce38c-63c2-4365-a338-e1f6c0fd484=
b devid 4 transid 6 /dev/loop8 scanned by mkfs.btrfs (894169)
>>>> [ 4765.429084] BTRFS info (device loop5): using crc32c (crc32c-intel)=
 checksum algorithm
>>>> [ 4765.433332] BTRFS info (device loop5): setting nodatasum
>>>> [ 4765.435506] BTRFS info (device loop5): using free space tree
>>>> [ 4765.440808] BTRFS info (device loop5): enabling ssd optimizations
>>>> [ 4765.442402] BTRFS info (device loop5): auto enabling async discard
>>>> [ 4765.444752] BTRFS info (device loop5): checking UUID tree
>>>> [ 4767.634901] BTRFS info (device loop5): using crc32c (crc32c-intel)=
 checksum algorithm
>>>> [ 4767.637985] BTRFS info (device loop5): allowing degraded mounts
>>>> [ 4767.640216] BTRFS info (device loop5): setting nodatasum
>>>> [ 4767.642221] BTRFS info (device loop5): using free space tree
>>>> [ 4767.646646] BTRFS warning (device loop5): devid 2 uuid 6240c286-89=
3c-4d19-bbf5-f1d2fecc6b96 is missing
>>>> [ 4767.650311] BTRFS warning (device loop5): devid 2 uuid 6240c286-89=
3c-4d19-bbf5-f1d2fecc6b96 is missing
>>>> [ 4767.655256] BTRFS info (device loop5): enabling ssd optimizations
>>>> [ 4767.658073] BTRFS info (device loop5): auto enabling async discard
>>>> [ 4768.343633] BTRFS info (device loop5): dev_replace from <missing d=
isk> (devid 2) to /dev/loop9 started
>>>> [ 4768.608799] BTRFS info (device loop5): dev_replace from <missing d=
isk> (devid 2) to /dev/loop9 finished
>>>> [ 4768.750345] 286 (893750): drop_caches: 3
>>>> [ 4769.993871] BTRFS: device fsid 965cdb50-095a-4fd9-bcda-2c17bd80c3a=
d devid 1 transid 6 /dev/loop5 scanned by (udev-worker) (894101)
>>>> [ 4770.002879] BTRFS: device fsid 965cdb50-095a-4fd9-bcda-2c17bd80c3a=
d devid 2 transid 6 /dev/loop6 scanned by (udev-worker) (892207)
>>>> [ 4770.015617] BTRFS: device fsid 965cdb50-095a-4fd9-bcda-2c17bd80c3a=
d devid 3 transid 6 /dev/loop7 scanned by (udev-worker) (894101)
>>>> [ 4770.021936] BTRFS: device fsid 965cdb50-095a-4fd9-bcda-2c17bd80c3a=
d devid 4 transid 6 /dev/loop8 scanned by mkfs.btrfs (894243)
>>>> [ 4770.041357] BTRFS info (device loop5): using crc32c (crc32c-intel)=
 checksum algorithm
>>>> [ 4770.043426] BTRFS info (device loop5): setting nodatasum
>>>> [ 4770.045340] BTRFS info (device loop5): using free space tree
>>>> [ 4770.050615] BTRFS info (device loop5): enabling ssd optimizations
>>>> [ 4770.053473] BTRFS info (device loop5): auto enabling async discard
>>>> [ 4770.056311] BTRFS info (device loop5): checking UUID tree
>>>> [ 4772.692223] BTRFS info (device loop5): using crc32c (crc32c-intel)=
 checksum algorithm
>>>> [ 4772.695043] BTRFS info (device loop5): allowing degraded mounts
>>>> [ 4772.697901] BTRFS info (device loop5): setting nodatasum
>>>> [ 4772.700355] BTRFS info (device loop5): using free space tree
>>>> [ 4772.704900] BTRFS warning (device loop5): devid 2 uuid 5fa35bdf-8f=
54-4652-ba28-7c302a265f8d is missing
>>>> [ 4772.708151] BTRFS warning (device loop5): devid 2 uuid 5fa35bdf-8f=
54-4652-ba28-7c302a265f8d is missing
>>>> [ 4772.713703] BTRFS info (device loop5): enabling ssd optimizations
>>>> [ 4772.716270] BTRFS info (device loop5): auto enabling async discard
>>>> [ 4773.735253] BTRFS info (device loop5): dev_replace from <missing d=
isk> (devid 2) to /dev/loop9 started
>>>> [ 4774.089640] BTRFS info (device loop5): dev_replace from <missing d=
isk> (devid 2) to /dev/loop9 finished
>>>> [ 4774.269606] 286 (893750): drop_caches: 3
>>>> [ 4775.897236] BTRFS: device fsid 0552fbf6-2877-4ab3-b5a2-da5db268e1c=
3 devid 1 transid 6 /dev/loop5 scanned by (udev-worker) (894101)
>>>> [ 4775.905939] BTRFS: device fsid 0552fbf6-2877-4ab3-b5a2-da5db268e1c=
3 devid 2 transid 6 /dev/loop6 scanned by mkfs.btrfs (894317)
>>>> [ 4775.909603] BTRFS: device fsid 0552fbf6-2877-4ab3-b5a2-da5db268e1c=
3 devid 3 transid 6 /dev/loop7 scanned by mkfs.btrfs (894317)
>>>> [ 4775.913080] BTRFS: device fsid 0552fbf6-2877-4ab3-b5a2-da5db268e1c=
3 devid 4 transid 6 /dev/loop8 scanned by mkfs.btrfs (894317)
>>>> [ 4775.928177] BTRFS info (device loop5): using crc32c (crc32c-intel)=
 checksum algorithm
>>>> [ 4775.930566] BTRFS info (device loop5): setting nodatasum
>>>> [ 4775.932930] BTRFS info (device loop5): using free space tree
>>>> [ 4775.937296] BTRFS info (device loop5): enabling ssd optimizations
>>>> [ 4775.938306] BTRFS info (device loop5): auto enabling async discard
>>>> [ 4775.940084] BTRFS info (device loop5): checking UUID tree
>>>> [ 4779.204728] BTRFS info (device loop5): using crc32c (crc32c-intel)=
 checksum algorithm
>>>> [ 4779.207351] BTRFS info (device loop5): allowing degraded mounts
>>>> [ 4779.210284] BTRFS info (device loop5): setting nodatasum
>>>> [ 4779.212740] BTRFS info (device loop5): using free space tree
>>>> [ 4779.218547] BTRFS warning (device loop5): devid 2 uuid 9a9f7178-0c=
aa-4c5f-8f92-034e72257005 is missing
>>>> [ 4779.221982] BTRFS warning (device loop5): devid 2 uuid 9a9f7178-0c=
aa-4c5f-8f92-034e72257005 is missing
>>>> [ 4779.227912] BTRFS info (device loop5): enabling ssd optimizations
>>>> [ 4779.230483] BTRFS info (device loop5): auto enabling async discard
>>>> [ 4780.128223] BTRFS info (device loop5): dev_replace from <missing d=
isk> (devid 2) to /dev/loop9 started
>>>> [ 4780.422390] BUG: kernel NULL pointer dereference, address: 0000000=
000000000
>>>> [ 4780.423934] #PF: supervisor read access in kernel mode
>>>> [ 4780.425584] #PF: error_code(0x0000) - not-present page
>>>> [ 4780.427234] PGD 0 P4D 0
>>>> [ 4780.428293] Oops: 0000 [#1] PREEMPT SMP PTI
>>>> [ 4780.429722] CPU: 3 PID: 761699 Comm: kworker/u16:4 Not tainted 6.4=
.0-rc6+ #6
>>>> [ 4780.431582] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BI=
OS 1.16.2-1.fc38 04/01/2014
>>>> [ 4780.433897] Workqueue: btrfs-rmw rmw_rbio_work [btrfs]
>>>> [ 4780.435655] RIP: 0010:raid6_sse21_gen_syndrome+0x9e/0x130 [raid6_p=
q]
>>>> [ 4780.437518] Code: 4d 8d 54 05 00 44 89 c0 48 c1 e0 03 48 29 c6 49 =
8b 03 48 01 d0 0f 18 00 66 0f 6f 10 49 8b 01 0f 18 04 10 66 0f 6f e2 49 8b=
 01 <66> 0f 6f 34 10 4c 89 d0 45 85 c0 78 34 48 8b 08 0f 18 04 11 66 0f
>>>> [ 4780.442488] RSP: 0018:ffffb66f0296fdc8 EFLAGS: 00010286
>>>> [ 4780.444147] RAX: 0000000000000000 RBX: 0000000000001000 RCX: ffffa=
0ff4cfa3248
>>>> [ 4780.446192] RDX: 0000000000000000 RSI: ffffa0f74cfa3238 RDI: 00000=
00000000000
>>>> [ 4780.448278] RBP: ffffa0ff4e72a000 R08: 00000000fffffffe R09: ffffa=
0ff4cfa3238
>>>> [ 4780.450387] R10: ffffa0ff4cfa3230 R11: ffffa0ff4cfa3240 R12: ffffa=
0fe8bdf3000
>>>> [ 4780.452515] R13: ffffa0ff4cfa3240 R14: 0000000000000003 R15: 00000=
00000000000
>>>> [ 4780.454638] FS:  0000000000000000(0000) GS:ffffa0ff77cc0000(0000) =
knlGS:0000000000000000
>>>> [ 4780.456956] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [ 4780.458778] CR2: 0000000000000000 CR3: 000000015eb0a001 CR4: 00000=
00000060ee0
>>>> [ 4780.460789] Call Trace:
>>>> [ 4780.461832]  <TASK>
>>>> [ 4780.462804]  ? __die+0x1f/0x70
>>>> [ 4780.463915]  ? page_fault_oops+0x159/0x450
>>>> [ 4780.465207]  ? fixup_exception+0x22/0x310
>>>> [ 4780.466484]  ? exc_page_fault+0x7a/0x180
>>>> [ 4780.467666]  ? asm_exc_page_fault+0x22/0x30
>>>> [ 4780.468879]  ? raid6_sse21_gen_syndrome+0x9e/0x130 [raid6_pq]
>>>> [ 4780.470372]  ? raid6_sse21_gen_syndrome+0x38/0x130 [raid6_pq]
>>>> [ 4780.471801]  rmw_rbio+0x5c8/0xa80 [btrfs]
>>>> [ 4780.472987]  ? preempt_count_add+0x6a/0xa0
>>>> [ 4780.474061]  ? lock_stripe_add+0xe1/0x290 [btrfs]
>>>> [ 4780.475288]  process_one_work+0x1c7/0x3d0
>>>> [ 4780.476304]  worker_thread+0x4d/0x380
>>>> [ 4780.477232]  ? __pfx_worker_thread+0x10/0x10
>>>> [ 4780.478241]  kthread+0xf3/0x120
>>>> [ 4780.479071]  ? __pfx_kthread+0x10/0x10
>>>> [ 4780.479982]  ret_from_fork+0x2c/0x50
>>>> [ 4780.480843]  </TASK>
>>>> [ 4780.481488] Modules linked in: dm_thin_pool dm_persistent_data dm_=
bio_prison dm_bufio dm_log_writes dm_flakey nls_iso8859_1 nls_cp437 vfat f=
at ext4 9p crc16 joydev kvm_intel netfs virtio_net mbcache cirrus kvm psmo=
use pcspkr net_failover failover xfs irqbypass drm_shmem_helper virtio_bal=
loon jbd2 evdev button 9pnet_virtio drm_kms_helper loop drm dm_mod zram zs=
malloc crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sha512_ssse3 sha5=
12_generic aesni_intel nvme virtio_blk crypto_simd nvme_core virtio_pci cr=
yptd t10_pi virtio i6300esb virtio_pci_legacy_dev crc64_rocksoft_generic v=
irtio_pci_modern_dev crc64_rocksoft crc64 virtio_ring serio_raw btrfs blak=
e2b_generic libcrc32c crc32c_generic crc32c_intel xor raid6_pq autofs4
>>>> [ 4780.492421] CR2: 0000000000000000
>>>> [ 4780.493185] ---[ end trace 0000000000000000 ]---
>>>> [ 4780.494099] RIP: 0010:raid6_sse21_gen_syndrome+0x9e/0x130 [raid6_p=
q]
>>>> [ 4780.495217] Code: 4d 8d 54 05 00 44 89 c0 48 c1 e0 03 48 29 c6 49 =
8b 03 48 01 d0 0f 18 00 66 0f 6f 10 49 8b 01 0f 18 04 10 66 0f 6f e2 49 8b=
 01 <66> 0f 6f 34 10 4c 89 d0 45 85 c0 78 34 48 8b 08 0f 18 04 11 66 0f
>>>> [ 4780.498186] RSP: 0018:ffffb66f0296fdc8 EFLAGS: 00010286
>>>> [ 4780.499138] RAX: 0000000000000000 RBX: 0000000000001000 RCX: ffffa=
0ff4cfa3248
>>>> [ 4780.500327] RDX: 0000000000000000 RSI: ffffa0f74cfa3238 RDI: 00000=
00000000000
>>>> [ 4780.501533] RBP: ffffa0ff4e72a000 R08: 00000000fffffffe R09: ffffa=
0ff4cfa3238
>>>> [ 4780.502683] R10: ffffa0ff4cfa3230 R11: ffffa0ff4cfa3240 R12: ffffa=
0fe8bdf3000
>>>> [ 4780.503827] R13: ffffa0ff4cfa3240 R14: 0000000000000003 R15: 00000=
00000000000
>>>> [ 4780.504971] FS:  0000000000000000(0000) GS:ffffa0ff77cc0000(0000) =
knlGS:0000000000000000
>>>> [ 4780.506207] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [ 4780.507143] CR2: 0000000000000000 CR3: 000000015eb0a001 CR4: 00000=
00000060ee0
>>>> [ 4780.508242] note: kworker/u16:4[761699] exited with irqs disabled
>>>> [ 4780.509242] note: kworker/u16:4[761699] exited with preempt_count =
1
>>>>
>>>>
>>>> Looks like a quadword move failed? I'm not well-versed in SSE asm, I'=
m afraid:
>>>>
>>>> $ ./scripts/faddr2line --list ./lib/raid6/raid6_pq.ko raid6_sse21_gen=
_syndrome+0x9e/0x130
>>>> raid6_sse21_gen_syndrome+0x9e/0x130:
>>>>
>>>> raid6_sse21_gen_syndrome at /home/jlayton/git/kdevops/linux/lib/raid6=
/sse2.c:56
>>>>    51                for ( d =3D 0 ; d < bytes ; d +=3D 16 ) {
>>>>    52                        asm volatile("prefetchnta %0" : : "m" (d=
ptr[z0][d]));
>>>>    53                        asm volatile("movdqa %0,%%xmm2" : : "m" =
(dptr[z0][d])); /* P[0] */
>>>>    54                        asm volatile("prefetchnta %0" : : "m" (d=
ptr[z0-1][d]));
>>>>    55                        asm volatile("movdqa %xmm2,%xmm4"); /* Q=
[0] */
>>>>> 56<                        asm volatile("movdqa %0,%%xmm6" : : "m" (=
dptr[z0-1][d]));
>>>>    57                        for ( z =3D z0-2 ; z >=3D 0 ; z-- ) {
>>>>    58                                asm volatile("prefetchnta %0" : =
: "m" (dptr[z][d]));
>>>>    59                                asm volatile("pcmpgtb %xmm4,%xmm=
5");
>>>>    60                                asm volatile("paddb %xmm4,%xmm4"=
);
>>>>    61                                asm volatile("pand %xmm0,%xmm5")=
;
>>>>
>>>>
>>>> This machine is running v6.4.0-rc5 with some ctime handling patches o=
n
>>>> top (nothing that should affect anything at this level). The Kconfig =
is
>>>> config-next-20230530 from the kdevops tree:
>>>>
>>>> https://github.com/linux-kdevops/kdevops/blob/master/playbooks/roles/=
bootlinux/templates/config-next-20230530)
>>>>
>>>> Let me know if you need other info!
>>>
>>> Unfortunately there are similar reports but I failed to reproduce anyw=
here.
>>>
>>> In the past, I have added extra debugging for the reporter, and the
>>> result is, at least every pointer is valid, until the control is passe=
d
>>> to the optimization routine...
>>>
>>> You can try to disable SSE for the vCPU, or even pass AVX feature to t=
he
>>> vCPU, and normally you would see the error gone.
>>>
>>> The last time I see such problem is from David, but we did not got any
>>> progress any further.
>>
>> I haven't seen the crash for a long time, IIRC it's related to SSE2,
>> no acceleration or anything AVX+ works.
>
> Well, I don't think it's related to SSE2 at all.
>
> I sporadically get the same crash with AVX2, for raid56 tests, so I
> would say it's very likely btrfs' fault.
> For example this crash on 6.2 when running btrfs/027:
>
> [10425.262835] general protection fault, probably for non-canonical
> address 0xcccccccccccccccc: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC PTI
> [10425.265179] CPU: 0 PID: 11267 Comm: kworker/u16:2 Not tainted
> 6.2.0-rc7-btrfs-next-145+ #1
> [10425.266196] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [10425.267570] Workqueue: btrfs-rmw rmw_rbio_work [btrfs]
> [10425.268247] RIP: 0010:raid6_avx21_gen_syndrome+0x9e/0x130 [raid6_pq]

In fact, my previous run of that 5.15 backport also hit a crash, but for
avx512 path.
(And 5.15 is even before my RAID56 rework)

Although in my case, it may be related to the special big/little cores
of intel CPUs. (I assigned 8 vCPU to the VM, while there are only 6 big
cores, 8 small cores may not support AVX512)
Furthermore, on my AMD cpus powered VMs, they never hit such crash.
(Both AMD and Intel machines are using host-passingthrough for vCPU
features)

Furthermore, my crash is very random, it crashed in btrfs/297, with all
previous RAID56 test cases passed.

So I'm still not sure what's really going on here.

> [10425.268986] Code: 4d 8d 54 05 00 44 89 c0 48 c1 e0 03 48 29 c6 49
> 8b 03 48 01 d0 0f 18 00 c5 fd 6f 10 49 8b 01 0f 18 04 10 c5 fd 6f e2
> 49 8b 01 <c5> fd 6f 34 10 4c 89 d0 45 85 c0 78 30 48 8b 08 0f 18 04 11
> c>
> [10425.271183] RSP: 0018:ffffb370c722fd80 EFLAGS: 00010286
> [10425.271892] RAX: cccccccccccccccc RBX: 0000000000001000 RCX: ffff9b08=
a87e9800

The RAX is the first parameter, aka rbio->real_stripes, while RBX is
sectorsize (0x1000 =3D 4K).

So there is definitely something wrong here.

Can you reproduce the problem reliably?

Thanks,
Qu

> [10425.273176] RDX: 0000000000000000 RSI: ffff9b00a87e98d8 RDI: 00000000=
00000000
> [10425.274074] RBP: ffff9b08e7e31000 R08: 00000000fffffffe R09: ffff9b08=
a87e98d8
> [10425.274886] R10: ffff9b08a87e98d0 R11: ffff9b08a87e98e0 R12: ffff9b08=
e5c00000
> [10425.275742] R13: ffff9b08a87e98e0 R14: 0000000000000003 R15: 00000000=
00000000
> [10425.276562] FS:  0000000000000000(0000) GS:ffff9b0bace00000(0000)
> knlGS:0000000000000000
> [10425.277515] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [10425.278172] CR2: 00007f7e1a04f421 CR3: 000000017b9b8001 CR4: 00000000=
00370ef0
> [10425.278982] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
> [10425.279809] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
> [10425.280574] Call Trace:
> [10425.280849]  <TASK>
> [10425.281064]  rmw_rbio.part.0+0x384/0x890 [btrfs]
> [10425.281709]  rmw_rbio_work+0x64/0x80 [btrfs]
> [10425.282245]  process_one_work+0x24f/0x5a0
> [10425.282672]  worker_thread+0x52/0x3b0
> [10425.283059]  ? __pfx_worker_thread+0x10/0x10
> [10425.283573]  kthread+0xf0/0x120
> [10425.283906]  ? __pfx_kthread+0x10/0x10
> [10425.284308]  ret_from_fork+0x29/0x50
> [10425.284696]  </TASK>
> [10425.284989] Modules linked in: loop btrfs blake2b_generic xor
> raid6_pq libcrc32c overlay intel_rapl_msr intel_rapl_common
> crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 sha512_generic bochs
> aesni_intel dr>
> [10425.295936] ---[ end trace 0000000000000000 ]---
>
> Qu also got the same crash on AVX recently.
>

