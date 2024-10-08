Return-Path: <linux-btrfs+bounces-8664-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBF09958E2
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 23:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12A6CB22F69
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 21:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AFA215F48;
	Tue,  8 Oct 2024 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="noiUwAcM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A81E1DED65
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728421305; cv=none; b=C752SsaZoDJea0cSjLXDD75Ktudbg0pPP7S3SrRTpTCu+HoxY5JDb4X3rx1GvcCt+31NC7Qv7YLwg99lLFk83Cs1SC3t0nhl3Owv+UoEDPjrM5Q3OjKx8Q2UoW5kZndWGDhmsPpoGr0UYaq0tkKRbpjUznX1l5+FkCZdEGpVd2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728421305; c=relaxed/simple;
	bh=ToP6wtyMAgLbYjdA84ay+l3uoU0wHwijWJtmSCt8+bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecA3a6rr5zMI1UmSpWnb8WqZx/bUqyF73MNUDSxz4LifCpJW2aPcIpArpboV+JbfTOOLT3T0WAT3b/1vV70PsX0ak7YdTKiIIC8BL9Ogcww4ZvTEVB95ssP3sxs41prFHwAQJPFS/jR4oogYxCtPelnIXWWbm2r/BfHAHgySIn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=noiUwAcM; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728421300; x=1729026100; i=quwenruo.btrfs@gmx.com;
	bh=7gxNel5mAG75137NqheDf0QTg3gKH49ok0c/9NboGr4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=noiUwAcMSl8TmGHEGI8DqqvouIv5+e2L3GkEElr75dhT0iVQst6VMg5dkq+LjypO
	 mBnC1ZFicB9ZBz/oCCUXkqZawvSCXV056/P32dA6+r74rLney+1oJtZ/mxR3Xv2Bk
	 3wV/fGph8Nmz5rd1J2/G8InupieLFvLEwmwAudhXy99pQupZaGGsoMq5BmULlrkpP
	 gCO55YtPsg4qesYL9t3ec9ctyDRnR4XE203PYGuec4yGRKnSuuYgBEvIcOJfb8xnt
	 0jLCTn6uncQXDAfs2WScHAXCgxqiakwM4cHxkLVLcok9iFyHhIrbFAnzmFeLOxLCj
	 2yHANxHHW4GbtYnfoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZCfJ-1tSt1u1ydN-00RBOi; Tue, 08
 Oct 2024 23:01:39 +0200
Message-ID: <6a11b718-4d72-4422-ae08-7af7598a9403@gmx.com>
Date: Wed, 9 Oct 2024 07:31:36 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mount: can't read superblock on - corrupt leaf - read time tree
 block corruption detected
To: Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc: "cwalou@gmail.com" <cwalou@gmail.com>, linux-btrfs@vger.kernel.org
References: <492c06c3-5e37-4026-96a8-cacc8eb28f51@gmail.com>
 <e040f6b8-6775-4b87-a345-6f6fb56aab26@gmx.com>
 <cuab5thyorquonghaxpqwxkfhog7lgrxzv3a5kdjs2zfw4ulaj@gutzirf5ipiv>
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
In-Reply-To: <cuab5thyorquonghaxpqwxkfhog7lgrxzv3a5kdjs2zfw4ulaj@gutzirf5ipiv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CxBOJLtj/ACiV3uWKK/Bv9QcF3Vv9IG8Zdxo26PtQnQoZGRjuH3
 bTMqKaaJ/Ya70UvLJNZ5CsVF0nRoMGmTNF3qm/JhpxijtmM4FXauPZTrGFf25bqAr8BWNRZ
 u9BHPSMnBWS/TPYwLYgTAkNfPeX0pULcd0BjHe2JtGCzyVywvENLCmiY2lQ/YgfwGaz0gf1
 nzGoaAd6zMK+HFp1C+pxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7z4oSxuaIIg=;20e8vzZTcB4XAaTskzkZIi/z3n6
 WNfx0AoTVArWPo0YEMw9r5rCeXQ/Z0as0AOZlHMqCwATwRFjZGFCv6PDdJuxhhVWBLRXfiG1L
 od9jHpuhn43VcTWTIG56OAvsBOppDfsgdYViF1Taxya9uyLokNTzKV+GuKmBKqvzP6v07aGKU
 gV8T3YhH2EKZ0WqeCY1FlEqdeu/vzYXthVv/dNgDoagv2ZGw/hWBszie+uh2xOkzD+xuhoc9Y
 AHfLQxm1UqvhOyb0SNhLuuUht+d0tUnAPVrWLjm/nLlQt+x78Ubp8Re41r7w/VPAnn3wHoHdX
 HtdIoaYDvwelK2NwvaDUMxLj6S9zHV7mqxqDDaGnJTEYRoJeyIqN8B5EkyoL0GA7cai//zhK8
 /PZdPiJ+klzhzgOHrPvJ31XzNblIBW9jQd9+RDp+gRccdGS7AKNSUaF3dP5vC3BHxZNuOM1eb
 JBFQeAExJlkgcX/xCY0KVTRmsa6IBx5ik+NuIpTMSV+Da2qNXgDdGu9CN7iVhLuscfzSzjH3x
 FcJuvc0TYDVYL3wcarMm96TKMvo4jmCoBGxoct/H2DfnDmgpY1pj6Lxd068f9PukXDjnMWUFy
 C9th4dvivUFLtQsuazoEh3fnZF94HFv9I9IosmqSOcDxLGc3ttjiXftXdHchJyz/ujhjpyFxW
 TD3XNr1EF2gbGrOGHUmdAGG9m8MjtXGEZ7DOnV2578RNVuBEFdZbUDcdwMkjU0DHX+bdzq9nD
 SCDJ1d39nkf/l3EjIRLScKUJ7WoPWP/fUnj718RIpQqpNAonve67Sri6Fgwb098umxktuSd57
 /StRc2idv2yR25yr2Nuw/91QTTw07KREc24f4WXAuHsxM=



=E5=9C=A8 2024/10/9 06:02, Johannes Hirte =E5=86=99=E9=81=93:
> On 2024 Okt 03, Qu Wenruo wrote:
>>
>> =E5=9C=A8 2024/10/3 17:02, cwalou@gmail.com =E5=86=99=E9=81=93:
>>> Hello.
>>>
>>> A 4TB drive taken out of a synology NAS. When I try to mount it, it
>>> won't. This is what I did :
>>
>> Synology has out-of-tree features that upstream kernel doesn't support.
>>
>
> Hello,
>
> I've noticed similar errors on my server too. It's a gentoo box with
> vanilla kernel. It happend first with linux-6.10.9 and happens with 6.11
> too:

This is a different one from the original report.

>
> [   67.310316] BTRFS: device label bigraid1 devid 1 transid 98985 /dev/s=
dd1 (8:49) scanned by mount (4069)
> [   67.313109] BTRFS info (device sdd1): first mount of filesystem 83a02=
224-c807-4e70-a2cd-8b7156bfbbd2
> [   67.313137] BTRFS info (device sdd1): using crc32c (crc32c-generic) c=
hecksum algorithm
> [   67.313156] BTRFS info (device sdd1): using free-space-tree
> [   67.527088] page: refcount:4 mapcount:0 mapping:000000004bf8c7c2 inde=
x:0x2ffb1be8 pfn:0x11b55c
> [   67.527114] memcg:ffff8881174ab800
> [   67.527120] aops:0xffffffff8206c960 ino:1
> [   67.527129] flags: 0x2000000000004000(private|node=3D0|zone=3D2)
> [   67.527144] raw: 2000000000004000 0000000000000000 dead000000000122 f=
fff8881022c9678
> [   67.527152] raw: 000000002ffb1be8 ffff88811b5304b0 00000004ffffffff f=
fff8881174ab800
> [   67.527157] page dumped because: eb page dump
> [   67.527162] BTRFS critical (device sdd1): corrupt leaf: block=3D32972=
21967872 slot=3D47 extent bytenr=3D2176663552 len=3D36864 invalid data ref=
 objectid value 259

This is caused by the long deprecated inode_cache feature.

Newer btrfs-check can report it as an error.

You can fix it by "btrfs rescue clear-ino-cache <device>" on the
unmounted fs, using btrfs-progs v6.11 (the command is there for a long
time, but has some small bugs).

Thanks,
Qu
> [   67.527179] BTRFS error (device sdd1): read time tree block corruptio=
n detected on logical 3297221967872 mirror 1
> [   67.535814] page: refcount:4 mapcount:0 mapping:000000004bf8c7c2 inde=
x:0x2ffb1be8 pfn:0x11b55c
> [   67.535872] memcg:ffff8881174ab800
> [   67.535877] aops:0xffffffff8206c960 ino:1
> [   67.535886] flags: 0x2000000000004000(private|node=3D0|zone=3D2)
> [   67.535900] raw: 2000000000004000 0000000000000000 dead000000000122 f=
fff8881022c9678
> [   67.535907] raw: 000000002ffb1be8 ffff88811b5304b0 00000004ffffffff f=
fff8881174ab800
> [   67.535912] page dumped because: eb page dump
> [   67.535917] BTRFS critical (device sdd1): corrupt leaf: block=3D32972=
21967872 slot=3D47 extent bytenr=3D2176663552 len=3D36864 invalid data ref=
 objectid value 259
> [   67.535931] BTRFS error (device sdd1): read time tree block corruptio=
n detected on logical 3297221967872 mirror 2
> [   67.535996] BTRFS error (device sdd1): failed to read block groups: -=
5
> [   67.539666] BTRFS error (device sdd1): open_ctree failed
> [   70.026232] BTRFS info (device sdb1): first mount of filesystem cae06=
473-5f45-4cd4-a822-733c036e36d9
> [   70.026270] BTRFS info (device sdb1): using crc32c (crc32c-generic) c=
hecksum algorithm
> [   70.026300] BTRFS info (device sdb1): disk space caching is enabled
> [   70.026306] BTRFS warning (device sdb1): space cache v1 is being depr=
ecated and will be removed in a future release, please use -o space_cache=
=3Dv2
> [   70.130069] page: refcount:3 mapcount:0 mapping:00000000a884d48d inde=
x:0x5abd618 pfn:0x11b665
> [   70.130094] memcg:ffff8881174ab800
> [   70.130100] aops:0xffffffff8206c960 ino:1
> [   70.130110] flags: 0x2400000000004020(lru|private|node=3D0|zone=3D2)
> [   70.130126] raw: 2400000000004020 ffffea00046d9908 ffffea00046d9988 f=
fff888102262618
> [   70.130134] raw: 0000000005abd618 ffff88811b63a4b0 00000003ffffffff f=
fff8881174ab800
> [   70.130139] page dumped because: eb page dump
> [   70.130144] BTRFS critical (device sdb1): corrupt leaf: block=3D38972=
4340224 slot=3D7 extent bytenr=3D12652544 len=3D36864 invalid data ref obj=
ectid value 258
> [   70.130160] BTRFS error (device sdb1): read time tree block corruptio=
n detected on logical 389724340224 mirror 2
> [   70.136382] page: refcount:3 mapcount:0 mapping:00000000a884d48d inde=
x:0x5abd618 pfn:0x11b665
> [   70.136404] memcg:ffff8881174ab800
> [   70.136409] aops:0xffffffff8206c960 ino:1
> [   70.136418] flags: 0x2400000000004020(lru|private|node=3D0|zone=3D2)
> [   70.136431] raw: 2400000000004020 ffffea00046d9908 ffffea00046d9988 f=
fff888102262618
> [   70.136439] raw: 0000000005abd618 ffff88811b63a4b0 00000003ffffffff f=
fff8881174ab800
> [   70.136443] page dumped because: eb page dump
> [   70.136448] BTRFS critical (device sdb1): corrupt leaf: block=3D38972=
4340224 slot=3D7 extent bytenr=3D12652544 len=3D36864 invalid data ref obj=
ectid value 258
> [   70.136462] BTRFS error (device sdb1): read time tree block corruptio=
n detected on logical 389724340224 mirror 1
> [   70.136555] BTRFS error (device sdb1): failed to read block groups: -=
5
> [   70.138216] BTRFS error (device sdb1): open_ctree failed
> [   71.825004] BTRFS: device label BIGBIGRAID devid 1 transid 4121 /dev/=
sde1 (8:65) scanned by mount (4102)
> [   71.826496] BTRFS info (device sde1): first mount of filesystem c9fa0=
269-733e-4e76-88c9-68c8247c81e5
> [   71.826532] BTRFS info (device sde1): using crc32c (crc32c-generic) c=
hecksum algorithm
> [   71.826561] BTRFS info (device sde1): using free-space-tree
> [  140.718646] BTRFS info (device sdb1): first mount of filesystem cae06=
473-5f45-4cd4-a822-733c036e36d9
> [  140.718683] BTRFS info (device sdb1): using crc32c (crc32c-generic) c=
hecksum algorithm
> [  140.718711] BTRFS info (device sdb1): disk space caching is enabled
> [  140.718717] BTRFS warning (device sdb1): space cache v1 is being depr=
ecated and will be removed in a future release, please use -o space_cache=
=3Dv2
> [  140.845547] page: refcount:4 mapcount:0 mapping:0000000049bde2be inde=
x:0x5abd618 pfn:0x11d9a3
> [  140.845571] memcg:ffff8881174ab800
> [  140.845578] aops:0xffffffff8206c960 ino:1
> [  140.845587] flags: 0x2000000000004000(private|node=3D0|zone=3D2)
> [  140.845602] raw: 2000000000004000 0000000000000000 dead000000000122 f=
fff888102262de8
> [  140.845611] raw: 0000000005abd618 ffff88811d96f5a0 00000004ffffffff f=
fff8881174ab800
> [  140.845615] page dumped because: eb page dump
> [  140.845621] BTRFS critical (device sdb1): corrupt leaf: block=3D38972=
4340224 slot=3D7 extent bytenr=3D12652544 len=3D36864 invalid data ref obj=
ectid value 258
> [  140.845636] BTRFS error (device sdb1): read time tree block corruptio=
n detected on logical 389724340224 mirror 1
> [  140.846180] page: refcount:4 mapcount:0 mapping:0000000049bde2be inde=
x:0x5abd618 pfn:0x11d9a3
> [  140.846202] memcg:ffff8881174ab800
> [  140.846208] aops:0xffffffff8206c960 ino:1
> [  140.846216] flags: 0x2000000000004000(private|node=3D0|zone=3D2)
> [  140.846229] raw: 2000000000004000 0000000000000000 dead000000000122 f=
fff888102262de8
> [  140.846236] raw: 0000000005abd618 ffff88811d96f5a0 00000004ffffffff f=
fff8881174ab800
> [  140.846240] page dumped because: eb page dump
> [  140.846245] BTRFS critical (device sdb1): corrupt leaf: block=3D38972=
4340224 slot=3D7 extent bytenr=3D12652544 len=3D36864 invalid data ref obj=
ectid value 258
> [  140.846259] BTRFS error (device sdb1): read time tree block corruptio=
n detected on logical 389724340224 mirror 2
> [  140.846329] BTRFS error (device sdb1): failed to read block groups: -=
5
> [  140.848015] BTRFS error (device sdb1): open_ctree failed
>
>
> It seems following commit is responsible:
>
> commit f333a3c7e8323499aa65038e77fe8f3199d4e283
> Author: Qu Wenruo <wqu@suse.com>
> Date:   Mon Jul 15 16:07:07 2024 +0930
>
>      btrfs: tree-checker: validate dref root and objectid
>
>
> After reverting this, I'm able to mount the filesystems again. There are
> three filesystems on this server that are affected, two single disk and
> one with two disk in RAID1/0. I was able to copy all data from all
> filesytems via rsync without noticing any error when running without
> this commit. Also btrfscheck doesn't notice any error. It's just this
> commit that prevents these three filesystem from mounting. As I was able
> to get all data this is not critical to me. But I think this should be
> addressed in some way.
>
> regards,
>    Johannes


