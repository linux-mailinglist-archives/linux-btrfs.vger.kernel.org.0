Return-Path: <linux-btrfs+bounces-531-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E14801A6C
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Dec 2023 05:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20D11C20B2B
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Dec 2023 04:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B330E8F4B;
	Sat,  2 Dec 2023 04:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Ue79paOZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FC4126
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 20:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701490424; x=1702095224; i=quwenruo.btrfs@gmx.com;
	bh=Vy8SMdP2SYLnq9KQ496/fZmdIAZDxjiLy4r1NuGABMw=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Ue79paOZdtsdjH1OCshlBVABPsttkUErqFGuTx1hrVj8Y8zvJScDcJuiHBUgFj5V
	 RS4YsY6BO/j8xz2moD223TuDEFFayej3IryAbM8e6xgyUrroh1uA3zRulxrz405iy
	 LBD1tKZQ/0/ct+NVPcR6QNN8I4zpm6BYOK6rcwdvjnt5TvVozmYM+pBKWdjXjsgPF
	 Ygj+sjtfnLhJTonvlHUbCcpaFNrz2KspRwuf9uEYGhwwYs4+RR8s4az4nfSp3/CBB
	 i+I+116wNffrOO8p6Na1ivFITMzGsUBaWaMxR8oeglA9m0yymF99/hfBV8DwkmkW8
	 d407Ik6YN5j/Ov80rQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSt8Q-1qhFZO0kFK-00UGAh; Sat, 02
 Dec 2023 05:13:44 +0100
Message-ID: <bf4ee7ec-ab90-496c-9117-b13a096994a6@gmx.com>
Date: Sat, 2 Dec 2023 14:43:40 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS corruption after conversion to block group tree
Content-Language: en-US
To: Russell Haley <yumpusamongus@gmail.com>, linux-btrfs@vger.kernel.org
References: <eca4d15e-3ac7-4403-ba5b-a3148eb6b443@gmail.com>
 <e20c7d59-c460-4236-9771-9cb4a3f9dfb2@gmx.com>
 <1b32a750-d464-49f1-a288-577ee2fd473e@gmail.com>
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
In-Reply-To: <1b32a750-d464-49f1-a288-577ee2fd473e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zJaRnxUVHXQMTK3xGbulNUqTSN4oCZPSaNJIBAKiL6VmuGquRju
 /dmqdrVhpCa9tMJ9QxBF2fZ7qrTr/gdGgAGrL82vVkO3MaN/CoueYXIYGh4vimHKAtxTOZF
 lRfkFAUboOFwX+5mrs+JnWqN5F7WAr+B1gyLc/6OluqXKSm1/hA5GI6lxj56jKgiGq1gIJf
 KykKBPDbOLPl4EBDrCcXg==
UI-OutboundReport: notjunk:1;M01:P0:JtQHygzNtzw=;rqM6Ue33ByKhcw4XQPC60sCGeW8
 rQ0YmEjTIq4+ddNTIHagll4/mblAf+q8o5zNJWQc3h1Y7ifgW6mbdkboEn7I+Zs5rnENNklkf
 e4UuAnjDJiDfF3Zk1wcWzAUA4Kl2k7SxODL37qe6JqZIIkdxK8GSgHdfE3OwwYvXG9i8Si3S4
 aknMTLxTppUZIrxDzcPpgtXPZMLtpQtAltCs39Vbq1J13T1wgqHqVGm82w3mgJ0GQZzM34kMt
 A4Mi30SculoJIb8myzfUHsiLj0Cbh13+pY8UY5Q9QfWfbJCu00ZWF2zOsLmrrQ0z48bndEh7D
 hZSg0CXs16xFuR5nm7BQ9f+Qcr7AYrKDZi3OzI/HhSp1j91Rh8bUSuIyIodD+rP5PfR5AKSUb
 +gwj3Vb5+uUSlvOewQhTUxGkBNxEwTVPLA9KlAgUyoIK6AksRAJzt75PILKBJ1UTx+Q3hF0Y6
 L2jL19Ub7C/CXgUmqFq9f5+iVt5ddErSH3tBYqdCYGmGkxJjLy+DSEPCbypikb4rGcu4RMdpC
 fk84Tch1zJH5OGmY1B0/L2PgkLfbjaM8KobNhyR2OBMKDXpk6cD6WO0G1tUU2meoCYplETQSb
 dD5KMLP3+yDX8cRZKeVwsRrRaB3oFwI2AWsRnDLegKa5lnugFjfPEsx/nubgrbJsv0QZf2qrV
 CLSANZvihinTk7592kcjNviASHw0DDdbleN1jZT1sX1v4wRCPqZpDoSJGIO2pwOVadRQnr/70
 U1g4ONzG6HqjKGi3u5dKyOs7flKB8V61ljYk3CEUAi6kHCP7IJd5bGzzRbab1M6TsDPUgQl2k
 XILuMP/jwechhKonwFVgH2NfXRwnw/JNpLEDaZizUdr7nzcKa+ObKPEQcOmBWmH9pexT8SgVW
 N+nYVrWZQBfr+cLiYHzDRc4HkgAKWeHr67S4X0rxf6/uFXnJKrkp0TvOBvdNPQ1aujLugLOGZ
 HgzqkRl+IoIDZ6pfsKH5wxYMuaw=



On 2023/12/2 13:15, Russell Haley wrote:
> On 12/1/23 14:09, Qu Wenruo wrote:
>>
>>
>> On 2023/12/1 22:16, Russell Haley wrote:
>>> Distro: Fedora 39
>>> kernel: 6.5.12
>>> btrfs-progs: v6.5.1.
>>>
>>> To put everyone at ease, the data seems mostly okay. The disk is
>>> mountable with ro,rescue=3Dingorebadroots:nologreplay, and I'm pulling=
 off
>>> what I can.=C2=A0 Furthermore, there's a good chance this is the resul=
t of a
>>> marginally-unstable overclock. However, the symptoms are very similar =
to
>>> a recent report from Alexander Duscheleit [1], so there may be a deepe=
r
>>> problem. I can provide requested metadata dumps if it would be useful,
>>> and I also have a few questions.
>>>
>>> A few days ago I used btrfstune to convert two btrfs filesystems to
>>> block-group-tree, after reading that it would reduce mount time. After
>>> about 10 hours, while I was using Steam, the more heavily-used of the
>>> two disks, which holds (among other things) the Steam game library,
>>> experienced a transaction abort and went read-only.
>>
>> Any dmesg of that transaction abort? That's the most critical info here=
.
>
> [80343.530191] BTRFS error (device dm-1): parent transid verify failed
> on logical 31850496 mirror 1 wanted 123883 found 123907
> [80343.587776] BTRFS error (device dm-1): parent transid verify failed
> on logical 31850496 mirror 2 wanted 123883 found 123907
> [80343.587836] BTRFS error (device dm-1): failed to run delayed ref for
> logical 916815872 num_bytes 16384 type 176 action 1 ref_mod 1: -5

This is weird, the corruption looks like to be inside extent tree, not
the new block group tree, but it still shows the same meaning, metadata
COW is already broken at that time.

Anyway considering there are already two reports here, I'm going to add
mandatory btrfs checks before and after the conversion just to be extra
safe.

> [80343.587844] BTRFS error (device dm-1: state A): Transaction aborted
> (error -5)
> [80343.587846] BTRFS: error (device dm-1: state A) in
> btrfs_run_delayed_refs:2182: errno=3D-5 IO failure
>
>>> 2. There's something extremely weird with the primary superblock. "btr=
fs
>>>  =C2=A0=C2=A0=C2=A0 inspect-internal dump-super" says that superblock =
0 doesn't have the
>>>  =C2=A0=C2=A0=C2=A0 BLOCK_GROUP_TREE or NO_HOLES flags set, unlike sup=
erblocks 1 and 2,
>>>  =C2=A0=C2=A0=C2=A0 which are identical in every field except csum ("[=
match]", for 0, 1,
>>>  =C2=A0=C2=A0=C2=A0 and 2) and bytenr.
>>
>> This is not good at all, if csum of super blocks doesn't match, there
>> must be something especially wrong.
>
> Comparing to other btrfs disks I have access to, different checksum for
> the backup superblocks seems normal?
> It does say [match] after the
> checksum value. Just the value itself is different.

Oh, as long as there is the "[match]" suffix, it's fine.

Backup and primary csums are different due to the bytenr differences,
thus those super blocks are indeed different in their contents.

>
> I dumped the 3 superblocks with btrfs inspect-internal dump-super -f and
> attached them to this message. "Meld" for 3-way diff worked well for me.

Indeed the backup super blocks are newer than the primary, which is not
correct at all, and several generations apart.

It can be a sign or bad write order/cache.

If you want to be extra safe, I'd recommend to disable the write cache
for those involved disks in the future.
(Or it can be something with LUKS? I'm not sure, but one more layer just
means one more point of failure)

Unless you're using nobarrier mount option, there should never be a case
where the primary super blocks are written before the primary one, not
to mention a tree block is already overwritten before it's corresponding
super block.

I'd say for now, the only good way to continue is mount with
rescue=3Dall,ro and grab any important data.

Converting back to old extent tree is not possible, since the fs is
already broken.

Thanks,
Qu
>
> Thanks for your help,
>
>    Russell Haley

