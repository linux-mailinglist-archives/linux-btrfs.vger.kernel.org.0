Return-Path: <linux-btrfs+bounces-7946-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 083AA975C12
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 22:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CD82B2312F
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 20:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC9A14B97E;
	Wed, 11 Sep 2024 20:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="X6e9BRmT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFA13D3B8
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726088098; cv=none; b=HZQ49cJaQkHBJGRiIEA/0qivgnsFNwI9ZRIVroL5B+Fkyvv+52t6Q3ubx7Rw+s/xkljmTXVln39yjQnG4LJAZsQw9GTZCeikQsrT9RhW73+MIfGqFite8UK4qrBu5CWjfYiwNWIh/hCNzTpFWL0DSxCnFxKT5OxWBQDBe4qI0p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726088098; c=relaxed/simple;
	bh=Iql6mgd0SvHVfH5kSY2+hHbFBcI32Dy3aTr6dsrc1uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C2NBFXJMSaafKXg1RnViNbMT8Na/tsBIYyOm0OeR0+RDMG3Mt/oxJNnY3zGTiJXM0agLI9E8Ab80aNqNYbXNACA45BF3Loho2kci4tEIMnHEknusonpYoYl8IVCOM8EdTuZGe5/54dro8pB2yoab9Bd9emaD9LKniOo2YkqbVx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=X6e9BRmT; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726088092; x=1726692892; i=quwenruo.btrfs@gmx.com;
	bh=hVBvs+2lqWtZcBKqotVSrStl8GGdc9gKKP25EwaljRE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=X6e9BRmT8SpHACUUbHUw2Kmx0AN9+1xrA2MzhopJf28lJBP6g0kuTSCa1GZAwvlX
	 3g9pw9AnXYfguwHxUDEEA7EqUrW/8i4WcsmU5n+XZxjxzJ9t/TVJOXzWfTWYP/XQF
	 MQD1CMwdhK5N/o0zZxpUyXNIxCZdFY8Is7KGMEZRhu1ew1jJuOV9c3vn6mcJc+5Sg
	 wZz0jczKqoPnrYxYQS+ESzei9QP0bmYknwDGLsjpNpFIv2+mQGnpMqhGJ7tmlyHRa
	 SrTcgquanu6YUfQFFDY9eXlkTuOWelzx5PyG0mFZBy3J9AIHWM84KNx7PCsmN3yes
	 ubnYWrhWjfg15BOlDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MuDc7-1s1U6o3cDd-014Pgx; Wed, 11
 Sep 2024 22:54:52 +0200
Message-ID: <914ea24d-aa0d-4f01-8c5e-96cf5544f931@gmx.com>
Date: Thu, 12 Sep 2024 06:24:49 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Critical error from Tree-checker
To: Archange <archange@archlinux.org>, linux-btrfs@vger.kernel.org
References: <9541deea-9056-406e-be16-a996b549614d@archlinux.org>
 <244f1d2b-f412-4860-af34-65f630e7f231@gmx.com>
 <3fa8f466-7da9-4333-9af7-36dabc2a2047@gmx.com>
 <4803f696-2dc5-4987-a353-fce1272e93e7@archlinux.org>
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
In-Reply-To: <4803f696-2dc5-4987-a353-fce1272e93e7@archlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:093UKl9Wqbg1mD0Z2kZGqxqK/v5DM1KdWbbOIM46NkSn+Ia8h6K
 ixhezFWEQiXvqsjqBpwS5YKEDbmD/pmjQ8wcwXJGT9bhNwx/OzwDZaAACFQdlhM0o8/ae1E
 vsU2p4dqrc+FbNnAcL+ppftDv/OTjcVpr0pMqI4Mz0aSGvEDSaSka79G5gnhfDgUvGqbLOB
 Smjo/GnZRnaWosWZnTvFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Su1gwU+2oBk=;9rkxnmJ5Io42Yq4PUE6WTgOGxqs
 uMRpSgmr7S3x6IA2SJb63mmGQdYML/YraaLJ3v3xqV53V2ptb4g7u/KYsob331huTyTxYVYHR
 teynWRPjR/v9nedkSWBxEqyFyodFcDa2vPYtda7sgaczD3JdwWrFpzo8uPs4VfXR7Gi8GW9ZA
 2kS34Nud+WRjD41UFwXdmvmiKLhKS8YY/GCIRpKj6zOwnmph3tqWC0PwtdxHZ6hntO8aoLL78
 1NSXpTWTGBa9LyvLNZRfPJK0refp7cathmlwWofsHyHLTmbgDvXqViaP9Att9jv1gEvwx/PXk
 AAekEkvKQpv9VvXgVHUCF30CUap1AtYXREnL0J1i4uuMeJMjacxnPga6ZYtZ+WqYcXoQiupAF
 9axSe+2mAW098fUqEBJXs6/CE5XdRH2ecmEEAyw5Z0Wqlm0PlJJ4G+6Z2YSdQUf+soc7YZJNg
 /eJg6mzZmFoFuplxT+ov47lfH24A3GBFhGotLJ/ywyk9+axEglDRZajhD8XDEMx1ItINmoMhs
 YPqzmz8JXNTqTdAScwpReUqim713Lvnzhi34S3aJK+6bkixpmgUzqGtERZ/XC3CmCjedHndPL
 mjBm09RULK7B7UzmllEaHNpxtoLDu+73y7TgYcDeYS4Uyxm6MrLcFWCCUO0v30p+dva6k2Nwe
 1X4Fp9kRGP+keK4+Gy4wwFp27VrQnybfuC95L+wNA1noIF83cxjLVEXmB1j1k7Ovjskad/bLa
 f6V48Xv4qy79pSAoznfQz/MyGusGBO4JWrr4jsx2vdumQ71Kf8bsWAfez+x+8g8TE+DhyNfQF
 M9vvXdDNsgkv+wkTvaKr9qHLfEnUQBCFDf+S/skdk1UlQ=



=E5=9C=A8 2024/9/12 05:25, Archange =E5=86=99=E9=81=93:
> Le 11/09/2024 =C3=A0 01:37, Qu Wenruo a =C3=A9crit=C2=A0:
>> =E5=9C=A8 2024/9/11 06:58, Qu Wenruo =E5=86=99=E9=81=93:
>>> =E5=9C=A8 2024/9/11 06:35, Archange =E5=86=99=E9=81=93:
>>>> Hi there,
>>>>
>>>> Since today, my system started randomly becoming read-only. At that
>>>> point I can still run dmesg in an open terminal, so I=E2=80=99ve seen=
 it was
>>>> related to a btrfs error, but did not try anything since I could not
>>>> open a web browser anymore. But I=E2=80=99ve seen the error to be =E2=
=80=9CBTRFS
>>>> critical=E2=80=9D and related to a =E2=80=9Ccorrupt leaf=E2=80=9D.
>>>>
>>>> I=E2=80=99ve tried to run `btrfs scrub` on the device after rebooting=
, and in
>>>> fact it aborted almost right away triggering the same error in dmesg
>>>> (but not turning the system read-only, so I can copy paste it here):
>>>>
>>>> [=C2=A0 365.268769] BTRFS info (device dm-0): scrub: started on devid=
 1
>>>> [=C2=A0 385.788000] page: refcount:3 mapcount:0 mapping:00000000d0054=
cae
>>>> index:0x9678888 pfn:0x11ce15
>>>> [=C2=A0 385.788015] memcg:ffff9fc94db8f000
>>>> [=C2=A0 385.788021] aops:btree_aops [btrfs] ino:1
>>>> [=C2=A0 385.788235] flags:
>>>> 0x2ffffa000004020(lru|private|node=3D0|zone=3D2|lastcpupid=3D0x1ffff)
>>>> [=C2=A0 385.788248] raw: 02ffffa000004020 ffffea9a8574ff88 ffffea9a84=
7385c8
>>>> ffff9fc95b8365b0
>>>> [=C2=A0 385.788255] raw: 0000000009678888 ffff9fc9ae554000 00000003ff=
ffffff
>>>> ffff9fc94db8f000
>>>> [=C2=A0 385.788259] page dumped because: eb page dump
>>>> [=C2=A0 385.788264] BTRFS critical (device dm-0): corrupt leaf:
>>>> block=3D646267305984 slot=3D92 extent bytenr=3D1182031872 len=3D10649=
6 invalid
>>>> data ref objectid value 257
>>>
>>> Full dmesg please.
>>>
>>> Normally it should dump the full content of the tree block, to help
>>> debugging the problem.
>>
>> Nevermind, the code doesn't dump the full leaf for debug anyway.
>>
>> In that case please dump that corrupted leaf by:
>>
>> =C2=A0# btrfs ins dump-tree -b 1182031872 /dev/dm-0
>
> Sorry for the delay, in the meantime my computer went unbootable: the
> initramfs went missing, then some systemd files=E2=80=A6 Last time such =
things
> happened was when my btrfs went out of free space, but there is plenty
> currently, so I guess this is related to this other kind of btrfs issue
> I=E2=80=99m facing. Now everything seems in order and I=E2=80=99m back t=
o my emails.
>
> Here is the output of the asked command:
>
> # btrfs ins dump-tree -b 1182031872 /dev/dm-0
> btrfs-progs v6.10.1
> checksum verify failed on 1182031872 wanted 0x00000000 found 0x21b9544e
> ERROR: failed to read tree block 1182031872
>
> Some additional informations:
>
> 1. I was able to save the log the next time it went read-only, it is a
> bit different:
>
> [ 4588.750188] page: refcount:4 mapcount:0 mapping:00000000d0054cae
> index:0x967c1f0 pfn:0x35077d
> [ 4588.750203] memcg:ffff9fc9400ae000
> [ 4588.750208] aops:btree_aops [btrfs] ino:1
> [ 4588.750407] flags:
> 0x2ffff8000004000(private|node=3D0|zone=3D2|lastcpupid=3D0x1ffff)
> [ 4588.750419] raw: 02ffff8000004000 0000000000000000 dead000000000122
> ffff9fc95b8365b0
> [ 4588.750425] raw: 000000000967c1f0 ffff9fcafdcc2690 00000004ffffffff
> ffff9fc9400ae000
> [ 4588.750428] page dumped because: eb page dump
> [ 4588.750433] BTRFS critical (device dm-0): corrupt leaf:
> block=3D646327500800 slot=3D105 extent bytenr=3D11287011328 len=3D114688=
 invalid
> data ref objectid value 258
> [ 4588.750451] BTRFS error (device dm-0): read time tree block
> corruption detected on logical 646327500800 mirror 1
> [ 4588.750524] BTRFS error (device dm-0): failed to run delayed ref for
> logical 11285897216 num_bytes 36864 type 178 action 1 ref_mod 1: -5
> [ 4588.750542] BTRFS error (device dm-0 state A): Transaction aborted
> (error -5)
> [ 4588.750549] BTRFS: error (device dm-0 state A) in
> btrfs_run_delayed_refs:2207: errno=3D-5 IO failure
> [ 4588.750559] BTRFS info (device dm-0 state EA): forced readonly
>
> 2. I=E2=80=99ve thus decided to run
>
> # btrfs ins dump-tree -b 11287011328 /dev/dm-0
> btrfs-progs v6.10.1
> checksum verify failed on 11287011328 wanted 0x00000000 found 0x2c7de3ac
> ERROR: failed to read tree block 11287011328
>
> and
>
> # btrfs ins dump-tree -b 11285897216 /dev/dm-0
> btrfs-progs v6.10.1
> checksum verify failed on 11285897216 wanted 0x28b52ffd found 0xa166b670
> ERROR: failed to read tree block 11285897216
>
> 3. There is some information on kernel loading
>
> [=C2=A0=C2=A0 12.793025] Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
> [=C2=A0=C2=A0 12.886212] BTRFS: device label root devid 1 transid 606502=
2
> /dev/mapper/root (254:0) scanned by mount (252)
> [=C2=A0=C2=A0 12.887845] BTRFS info (device dm-0): first mount of filesy=
stem
> e6614f01-6f56-4776-8b0a-c260089c35e7
> [=C2=A0=C2=A0 12.887874] BTRFS info (device dm-0): using crc32c (crc32c-=
intel)
> checksum algorithm
> [=C2=A0=C2=A0 12.887885] BTRFS info (device dm-0): disk space caching is=
 enabled
> [=C2=A0=C2=A0 12.907001] BTRFS warning (device dm-0): devid 1 physical 0=
 len
> 4194304 inside the reserved space
> [=C2=A0=C2=A0 12.910034] BTRFS info (device dm-0): bdev /dev/mapper/root=
 errs: wr
> 0, rd 0, flush 0, corrupt 4, gen 0
>
> (Especially the =E2=80=9Ccorrupt 4=E2=80=9D I guess, but the warning abo=
ve might also be
> relevant?)
>
> 4. I=E2=80=99ve run a full scrub while the disk was mounted on another s=
ystem,
> which returned no error.
>
> 5. I=E2=80=99ve also run a check from that system while the fs was not m=
ounted:
>
> # btrfs check /dev/mapper/rootext
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/rootext
> UUID: e6614f01-6f56-4776-8b0a-c260089c35e7
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 480039342080 bytes used, no error found
> total csum bytes: 466668868
> total tree bytes: 1618149376
> total fs tree bytes: 898007040
> total extent tree bytes: 138395648
> btree space waste bytes: 331985228
> file data blocks allocated: 517562126336
>  =C2=A0referenced 492533391360
>
> Waiting for further debugging instructions.

This looks exactly like another report that is caused by inode cache.

So in that case, mind to try the following commands?

# btrfs rescue zero-log <device>
# btrfs rescue clear-inode-cache <device>

Then try mounting the fs.

Thanks,
Qu
>
> Thanks,
> Archange
>

