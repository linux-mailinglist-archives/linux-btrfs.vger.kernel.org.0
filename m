Return-Path: <linux-btrfs+bounces-19028-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E35C5F286
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 21:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AFD8334287B
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 20:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24DE33B960;
	Fri, 14 Nov 2025 19:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="j4JVI+I8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB7B7261B
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763150137; cv=none; b=iGw4gdTOZs8Iot3PYyimfvir2TRGlJ8L1ubjz6T2m4UsN5EtSa1QbupfkuTiL8/Q8bzmZfu26TOTuqA9LfCsvFgOoBDmsTzNtod0h81SkK97FnSV4SIJPvCQduS2UkS017sPj2V89WtEANcM9Rr45DXqi6MNSomm36ci5hcRANQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763150137; c=relaxed/simple;
	bh=QMWq1nG6BS72940KgLH8kYGEGMjmZOCNVdt+P78JfUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Lzz3BPSeanah3qIxMcTSnVeyMlrvOyzCWsV+J+aF9paKDEWFMYxdxEDgmTZd4CII4Br87GJ69aAIPDAPN+EIdd3qNAKtPQsh6AzWaG+sAnVcK4uvCMSuj4KR32Os+qTx+S+E1p0AxOVfH+tCdv8pwkE6G57JKY6M/jbGpAg98NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=j4JVI+I8; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763150132; x=1763754932; i=quwenruo.btrfs@gmx.com;
	bh=QMWq1nG6BS72940KgLH8kYGEGMjmZOCNVdt+P78JfUQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=j4JVI+I8MDiwfJW3CK2OHPhr6JQuN64VeWXZr+l8MEaeiZBrsr/6IoZrwS4jDX3j
	 43cTvFc7WwV1HPO7KKNN5d1ADCBHiN+tp+93ojxj/dGkOcw7oEn/+Kw/9J0dVz4Ml
	 NW8cfcF+PGUxTJTXafpk17es14HEA3vXP5ovqQMKq3yQY8te+swN8aCF74yTUcInd
	 dylEe+nFzj/kneL+Cqu9OQyPl0qtOONYR6QbbpfwId0rkdtCKRQkgbP+mXB8oNTId
	 OG3sLiFRmclVi2lJwSVYxHt6IhsUmXgI2g8exuJfr132Oo+w1ktLLP2XA75EnqG2v
	 JGWJ7j8BMX6f2GoK/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqJmF-1vwgXw2Skl-00dqnl; Fri, 14
 Nov 2025 20:55:32 +0100
Message-ID: <0ed6fdf0-842a-4641-90e4-5239b5049e4b@gmx.com>
Date: Sat, 15 Nov 2025 06:25:29 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stuck subvolume removal:
To: Paul Graff <pj.world@gmx.com>, linux-btrfs@vger.kernel.org
References: <1c371732-db4f-49ad-bc00-876b3be0fe98@gmx.com>
 <4b4fc981-912d-40cd-945b-d4acf14198e1@gmx.com>
 <01f8b560-fb57-4861-8382-141c39655478@gmx.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <01f8b560-fb57-4861-8382-141c39655478@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/F879qTsEuMj5zJa6dGoondrdsPJCR5LDWcstIx/C/tuvGfds49
 qeH3S7TAAmxRaQ53kI2xzPKDJHJGo9mcUvohJ89DiAr3q1A+8oZAipzD564ExhmQ5Yuh5GT
 rzt09tN3GzgQtaoqKLomCBHyklHjDOrU4Ztd4zpFR2exRrbmUARep9KuHoQh4ara7YjxOoe
 5k/2w0YVwJ4Rqb8InJgMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bJgaRyABG7A=;+T1ntDdtjl/dgxMXYGvZSTQsaCg
 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
 wE5kA5lS74azUc5Lo=



=E5=9C=A8 2025/11/15 06:08, Paul Graff =E5=86=99=E9=81=93:
>=20
>=20
> On 11/13/25 4:54 PM, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/11/14 09:10, Paul Graff =E5=86=99=E9=81=93:
>>> Hi, currently there is a dropped subvolume error when running a full=
=20
>>> balance on a single SSD.
>>>
>>> |:~> sudo btrfs balance start / WARNING: Full balance without filters=
=20
>>> requested. This operation is very intense and takes potentially very=
=20
>>> long. It is recommended to use the balance filters to narrow down the=
=20
>>> scope of balance. Use 'btrfs balance start --full-balance' option to=
=20
>>> skip this warning. The operation will start in 10 seconds. Use Ctrl-C=
=20
>>> to stop it. 10 9 8 7 6 5 4 3 2 1 Starting balance without any=20
>>> filters. ERROR: error during balancing '/': Structure needs cleaning=
=20
>>> There may be more info in syslog - try dmesg | tail hightower-=20
>>> i5-6600k:~> dmesg | tail [38576.407681] [ T29728] BTRFS info (device=
=20
>>> dm-2): found 37170 extents, stage: update data pointers=20
>>> [38584.873805] [ T29728] BTRFS info (device dm-2): relocating block=20
>>> group 64891125760 flags data [38607.693519] [ T29728] BTRFS info=20
>>> (device dm-2): found 33194 extents, stage: move data extents=20
>>> [38641.574032] [ T29728] BTRFS info (device dm-2): found 33194=20
>>> extents, stage: update data pointers [38649.812477] [ T29728] BTRFS=20
>>> info (device dm-2): relocating block group 62710087680 flags data=20
>>> [38662.710999] [ T29728] BTRFS info (device dm-2): found 43884=20
>>> extents, stage: move data extents [38696.292982] [ T29728] BTRFS info=
=20
>>> (device dm-2): found 43884 extents, stage: update data pointers=20
>>> [38708.587669] [ T29728] BTRFS info (device dm-2): relocating block=20
>>> group 60294168576 flags metadata|dup [38714.889735] [ T29728] BTRFS=20
>>> error (device dm-2): cannot relocate partially dropped subvolume 490,=
=20
>>> drop progress key (853588 108 0) [38723.736887] [ T29728] BTRFS info=
=20
>>> (device dm-2): balance: ended with status: -117 hightower-i5-6600k:~>|
>>
>> The format is a mess.
> My apologies for the disastrous output format above.
>> Please provide a proper formatted dmesg instead.
>=20
> :~> sudo dmesg | tail
>=20
> [sudo] password for root:
>=20
> [44928.672213] [ T96240] BTRFS info (device dm-2): found 55680 extents,=
=20
> stage: update data pointers
>=20
> [44937.810972] [ T96240] BTRFS info (device dm-2): found 4 extents,=20
> stage: update data pointers
>=20
> [44938.590658] [ T96240] BTRFS info (device dm-2): relocating block=20
> group 60294168576 flags metadata|dup
>=20
> [44945.516661] [ T96240] BTRFS error (device dm-2): cannot relocate=20
> partially dropped subvolume 490, drop progress key (853588 108 0)
>=20
> [44955.995468] [ T96240] BTRFS info (device dm-2): balance: ended with=
=20
> status: -117
>=20
> :~>
>=20
>=20
>>
>> Along with the kernel version.
> Most current openSUSE Rescue system CD used for btrfs check, uname -a >=
=20
> 6.17.7-1
>>
>> The relocation is rejected because there is a half-dropped subvolume,=
=20
>> which is not that common.
>> It maybe a problem with the fs that there are some ghost subvolumes=20
>> that are never dropped.
>>
>> There used to be kernel bug that can lead to such ghost subvolumes,=20
>> IIRC the latest btrfs check can detect it.
>>
>> So please also provide the output of "btrfs check --readonly" of the=20
>> unmounted fs.
>=20
> :~ # btrfs check --readonly --progress /dev/mapper/system-root
>=20
> Opening filesystem to check...
>=20
> Checking filesystem on /dev/mapper/system-root
>=20
> UUID: 605560ad-fe93-4d09-8760-df0725b43ee1
>=20
> [1/8] checking log skipped (none written)
>=20
> [1/7] checking root items (0:00:14 elapsed, 5328460 items checked)
>=20
> [2/7] checking extents (0:01:01 elapsed, 984830 items checked)
>=20
> [3/7] checking free space cache (0:00:12 elapsed, 471 items checked)
>=20
> [4/7] checking fs roots (0:04:32 elapsed, 910644 items checked)
>=20
> [5/7] checking csums (without verifying data) (0:00:12 elapsed, 895024=
=20
> items checked)
>=20
> fs tree 490 missing orphan item (0:00:00 elapsed, 94 items checked)

So indeed your fs has a half dropped ghost subvolume, most likely caused=
=20
by some older kernels.

Unfortunately btrfs-progs doesn't have the ability to repair it yet,=20
I'll craft a branch of btrfs-progs with the repair ability soon.

Meanwhile please prepare an environment to compile btrfs-progs.

Thanks,
Qu

>=20
> [6/7] checking root refs (0:00:01 elapsed, 94 items checked)
>=20
> ERROR: errors found in root refs
>=20
> found 496776130741 bytes used, error(s) found
>=20
> total csum bytes: 465839608
>=20
> total tree bytes: 16133832704
>=20
> total fs tree bytes: 14983905280
>=20
> total extent tree bytes: 624771072
>=20
> btree space waste bytes: 3613129770
>=20
> file data blocks allocated: 1062495817728
>=20
> referenced 976540409856
>=20
> :~ #
>=20
>=20
>>
>> Thanks,
>> Qu
>>
> -Greatest Hopes
> Paul
>>>
>>> After passing,
>>>
>>> |:~> sudo btrfs subvolume sync / [sudo] password for root: hightower-=
=20
>>> i5-6600k:~> |
>>>
>>> the command returned to prompt very, very quickly.
>>>
>>> A second balance attempt results with the following output:
>>>
>>> |:~> sudo btrfs balance start / WARNING: Full balance without filters=
=20
>>> requested. This operation is very intense and takes potentially very=
=20
>>> long. It is recommended to use the balance filters to narrow down the=
=20
>>> scope of balance. Use 'btrfs balance start --full-balance' option to=
=20
>>> skip this warning. The operation will start in 10 seconds. Use Ctrl-C=
=20
>>> to stop it. 10 9 8 7 6 5 4 3 2 1 Starting balance without any=20
>>> filters. ERROR: error during balancing '/': Structure needs cleaning=
=20
>>> There may be more info in syslog - try dmesg | tail hightower-=20
>>> i5-6600k:~> |
>>>
>>> |:~> dmesg | tail [93689.781162] [ T69656] BTRFS info (device dm-2):=
=20
>>> found 16 extents, stage: update data pointers [93690.667290]=20
>>> [ T69656] BTRFS info (device dm-2): relocating block group=20
>>> 1495819878400 flags data [93703.323923] [ T69656] BTRFS info (device=
=20
>>> dm-2): found 33 extents, stage: move data extents [93705.575991]=20
>>> [ T69656] BTRFS info (device dm-2): found 33 extents, stage: update=20
>>> data pointers [93706.769453] [ T69656] BTRFS info (device dm-2):=20
>>> relocating block group 1494746136576 flags data [93725.570642]=20
>>> [ T69656] BTRFS info (device dm-2): found 39 extents, stage: move=20
>>> data extents [93727.449779] [ T69656] BTRFS info (device dm-2): found=
=20
>>> 39 extents, stage: update data pointers [93728.465650] [ T69656]=20
>>> BTRFS info (device dm-2): relocating block group 60294168576 flags=20
>>> metadata|dup [93736.722689] [ T69656] BTRFS error (device dm-2):=20
>>> cannot relocate partially dropped subvolume 490, drop progress key=20
>>> (853588 108 0) [93750.594559] [ T69656] BTRFS info (device dm-2):=20
>>> balance: ended with status: -117 hightower- i5-6600k:~> |
>>>
>>> Please see the following referenced, prior posting for stuck=20
>>> subvolume removal similarity. https://lore.kernel.org/linux-=20
>>> btrfs/9f936d59- d782-1f48-bbb7-dd1c8dae2615@gmail.com/
>>>
>>> Is there a patch for btrfsprogs? If so can the patch be merged?|
>>> |
>>>
>>> What are your thoughts on this?
>>>
>>>
>>>
>>>
>>>
>>
>=20


