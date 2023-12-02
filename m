Return-Path: <linux-btrfs+bounces-532-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F233801AA3
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Dec 2023 05:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B288D1C20B7E
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Dec 2023 04:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27480BA26;
	Sat,  2 Dec 2023 04:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GGOGoOoL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DB6F4
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 20:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701491105; x=1702095905; i=quwenruo.btrfs@gmx.com;
	bh=talMzOEufV7LyRZL9k5DfElGE1t3H6Ai1iE2TPxH8Mg=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=GGOGoOoL2BkfwmcaiMg0eQ/zP0i17sxP8vX2z/D8QcpOgXyCHE4ykMotsgVxzoBE
	 MaHv2KJuepZBOVAKtNZQxnxSuURSW89BAQV/HwELkZnAe9ywG8j60Lxpce7aExim/
	 fX1hucV7/9WUKvn/70EA4WbZrv55KVGti76kFsU2TuG35YK/dJPpNruBOvk3vNW6h
	 CMjeTrU6WK5ZWRQUBaLWI2GMeFWBDsOIvWvyTcKviLWTNIPNwgyJVZzZOvp2vXv6t
	 xafxPYN6uzbsM/RJZx/Wvzuoc6902EB6h7vEVUWEeBggzVUxKFTABoLsw6DeMvlnP
	 W4BV3IONdtup+AaaFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQ5vc-1qw8Qr0Wie-00M1El; Sat, 02
 Dec 2023 05:25:05 +0100
Message-ID: <3b55e499-791b-4f98-9ca3-0ff0a218c0bf@gmx.com>
Date: Sat, 2 Dec 2023 14:55:02 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS corruption after conversion to block group tree
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Russell Haley <yumpusamongus@gmail.com>, linux-btrfs@vger.kernel.org
References: <eca4d15e-3ac7-4403-ba5b-a3148eb6b443@gmail.com>
 <e20c7d59-c460-4236-9771-9cb4a3f9dfb2@gmx.com>
 <1b32a750-d464-49f1-a288-577ee2fd473e@gmail.com>
 <bf4ee7ec-ab90-496c-9117-b13a096994a6@gmx.com>
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
In-Reply-To: <bf4ee7ec-ab90-496c-9117-b13a096994a6@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j0wgOsbRFYDaSBnNortZDaE/ffVdofdBwkEfSnmKBN3HpTvf03W
 OYd+2D4tmU7Ti90S3A9KkZ/sdDpvDTRyJ6jzjG6LDzTNvl185rgv1xikihC/tcHkKFGqCiS
 8Qh40Cia+bunxw6N3X32i0d46vdMpNhE/Uw1a7NpI4eKaBR4p03KkIIjn8LdF8yAVQZO0BK
 8ibYLzJ+8frxb/b1L9M4Q==
UI-OutboundReport: notjunk:1;M01:P0:VAq25NlyG8Y=;CocVmopHYYJD7gPpk4+JrmkPev8
 AZzg8x85s3ULPoKq2+vnPsZHMECTZTj7NV9LPap60eLRwhMIE8OUxXxgMQe1wexceFYjZ0O+k
 ldHntQLApmYIDSC9uin36/ga1u1abTKCDJH1gm4AqKV9zwc4brd8/k87zIuI53CvGlkkzd4o+
 Ch4CoFW1sVEo0+9s2ofu9X8ydAl420A1v/nJ4h+f1nmB3WAD14h9rkrjrlbSQDP9UwhHuyKWQ
 Bx6k0/NoemG4AFmNTCrVo6Pu1IBSdGUjW150R29oZiiZY6QzEGuTQPt5qQJahlHY/1SpJT1hK
 xxgOdctLv3FWbF1hPsgo051A+hLCHFwtjvMyn1hGpq9WRytxQ0FB9/W1WSpx4GJyzX+3eL4s6
 1pPyRn9LKNUG68pQ/dvPjwbPm8jQyLL92VqmZwXdUcDMu9gnP7pyWTxMjrd2s9KhbQiUf9ySI
 El1zv8R/eEb8j7pZ6dfnfRjV0gBed/VVvbABPTIL0UdCGCVU1otYvzQzlUH3ZMd8c+Okbj+Od
 OYFhXfZ89dxtmBSYb7L2K2naUT9rwoXOhg6PfEiUhJd7gI2bepPzVTw3ObdRNIx8j905Wz6WJ
 KNTyj3Ic/X6pEHKKp4k8CwrhZr6aSaxNgjO/m/4REzWgnqKPcy9Km057cvgXKC4GsIiyhcSbM
 1Sd0eExQ29a4h6TUWfMXVTtXCc+3Q2XbRgG3eAqrAG07XBYnn6EoG2/4ophFnjPq0Q1N70Hqe
 NuqHz6Si7a8pTHPV7Z5vY7A9A7ksoOyHi22KMBvbIu2uEZfxxeOdUKdu1UjscTu5R6tznVCtX
 BNUf/m9SdxXgyyspPKGJ4VpwePvKIRv/6pj/YEAX0NA4/gXuGkx4A95twoL+fhE8YbWrGEGZN
 LXfQ5mEAZkM2TZ82eofKg4hwYLjmkC8F6mpC+UT2SAdCJ24QDbZNpApEVpqNOOrLeinlbWUAL
 WaaU3z76Pk1XGRzMJbZfN8/ioeo=



On 2023/12/2 14:43, Qu Wenruo wrote:
>
>
> On 2023/12/2 13:15, Russell Haley wrote:
>> On 12/1/23 14:09, Qu Wenruo wrote:
>>>
>>>
>>> On 2023/12/1 22:16, Russell Haley wrote:
>>>> Distro: Fedora 39
>>>> kernel: 6.5.12
>>>> btrfs-progs: v6.5.1.
>>>>
>>>> To put everyone at ease, the data seems mostly okay. The disk is
>>>> mountable with ro,rescue=3Dingorebadroots:nologreplay, and I'm pullin=
g
>>>> off
>>>> what I can.=C2=A0 Furthermore, there's a good chance this is the resu=
lt of a
>>>> marginally-unstable overclock. However, the symptoms are very
>>>> similar to
>>>> a recent report from Alexander Duscheleit [1], so there may be a deep=
er
>>>> problem. I can provide requested metadata dumps if it would be useful=
,
>>>> and I also have a few questions.
>>>>
>>>> A few days ago I used btrfstune to convert two btrfs filesystems to
>>>> block-group-tree, after reading that it would reduce mount time. Afte=
r
>>>> about 10 hours, while I was using Steam, the more heavily-used of the
>>>> two disks, which holds (among other things) the Steam game library,
>>>> experienced a transaction abort and went read-only.
>>>
>>> Any dmesg of that transaction abort? That's the most critical info her=
e.
>>
>> [80343.530191] BTRFS error (device dm-1): parent transid verify failed
>> on logical 31850496 mirror 1 wanted 123883 found 123907
>> [80343.587776] BTRFS error (device dm-1): parent transid verify failed
>> on logical 31850496 mirror 2 wanted 123883 found 123907
>> [80343.587836] BTRFS error (device dm-1): failed to run delayed ref for
>> logical 916815872 num_bytes 16384 type 176 action 1 ref_mod 1: -5
>
> This is weird, the corruption looks like to be inside extent tree, not
> the new block group tree, but it still shows the same meaning, metadata
> COW is already broken at that time.
>
> Anyway considering there are already two reports here, I'm going to add
> mandatory btrfs checks before and after the conversion just to be extra
> safe.
>
>> [80343.587844] BTRFS error (device dm-1: state A): Transaction aborted
>> (error -5)
>> [80343.587846] BTRFS: error (device dm-1: state A) in
>> btrfs_run_delayed_refs:2182: errno=3D-5 IO failure
>>
>>>> 2. There's something extremely weird with the primary superblock.
>>>> "btrfs
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 inspect-internal dump-super" says that super=
block 0 doesn't
>>>> have the
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 BLOCK_GROUP_TREE or NO_HOLES flags set, unli=
ke superblocks 1
>>>> and 2,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 which are identical in every field except cs=
um ("[match]", for
>>>> 0, 1,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 and 2) and bytenr.
>>>
>>> This is not good at all, if csum of super blocks doesn't match, there
>>> must be something especially wrong.
>>
>> Comparing to other btrfs disks I have access to, different checksum for
>> the backup superblocks seems normal?
>> It does say [match] after the
>> checksum value. Just the value itself is different.
>
> Oh, as long as there is the "[match]" suffix, it's fine.
>
> Backup and primary csums are different due to the bytenr differences,
> thus those super blocks are indeed different in their contents.
>
>>
>> I dumped the 3 superblocks with btrfs inspect-internal dump-super -f an=
d
>> attached them to this message. "Meld" for 3-way diff worked well for me=
.
>
> Indeed the backup super blocks are newer than the primary, which is not
> correct at all, and several generations apart.
>
> It can be a sign or bad write order/cache.
>
> If you want to be extra safe, I'd recommend to disable the write cache
> for those involved disks in the future.
> (Or it can be something with LUKS? I'm not sure, but one more layer just
> means one more point of failure)
>
> Unless you're using nobarrier mount option, there should never be a case
> where the primary super blocks are written before the primary one, not
> to mention a tree block is already overwritten before it's corresponding
> super block.
>
> I'd say for now, the only good way to continue is mount with
> rescue=3Dall,ro and grab any important data.
>
> Converting back to old extent tree is not possible, since the fs is
> already broken.

Just one more question, is there any hibernation/suspension involved in
this particular corruption?

I have seen exactly such unexplainable writes-from-future cases, which a
lot of them have hibernation/suspension involved.
(Thus personally speaking, I never go hibernation/suspension on my own
devices)

Thanks,
Qu
>
> Thanks,
> Qu
>>
>> Thanks for your help,
>>
>> =C2=A0=C2=A0 Russell Haley
>

