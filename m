Return-Path: <linux-btrfs+bounces-1436-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C5D82CED2
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 22:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C3D1C20FCD
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 21:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DF016436;
	Sat, 13 Jan 2024 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dhnfVy7U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4C62CA6
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705182008; x=1705786808; i=quwenruo.btrfs@gmx.com;
	bh=SyJbTmfWtPwVKHr/+YpobAqHuxy35Y+wEoy4JjbkQnE=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=dhnfVy7UZN7UkDU5M7g79ZUUIUYpE+TX299/caCOuGuEXQEzJ8JeBd9z9jfRavkB
	 6xdBwj93mjPupdXMkIKuGlLECsZ0yvndKz4S+9anGGQVqeDztPtCTPWs9z2w3YXYK
	 8kXk5hItziFTiVd4LPwq/LH/QMTBWeQPDUIy7khwqUXgPExqEhevvdnmq9/xtI6j/
	 3jLbsT38Dh1H84AuXX8VK/jnEi4zQmaAbucr+d4ESiA0gMlLdELEcq1oPmremEG1L
	 vFx4NJvsAWQb1aBHpEd4E+LrAOSUq7HXKGhyzBj/3l5K1F7aBj6SyFMeA2n0DGvgl
	 DplYPuWetSDQU0W9Gw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWih0-1reITH2sFE-00X6bk; Sat, 13
 Jan 2024 22:40:08 +0100
Message-ID: <3e0ba2b7-bbe6-448f-b4d2-2e7dde291735@gmx.com>
Date: Sun, 14 Jan 2024 08:10:05 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Scrub reports uncorrectable errors with correctable errors
 unrepaired, but all files are fine
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, Rongrong <i@rong.moe>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <8bd12a1ee60172f53ee0c27374f41c3ec9976be8.camel@rong.moe>
 <27fb4ed5-c3ce-4ab7-a3fd-d77dc8dd4fb2@gmx.com>
 <b10d90cc5eb4f49eabfe3cc0df92ef40b64428b0.camel@rong.moe>
 <794c3085-c5ee-417f-aeaf-d6c0ebd7d96f@gmx.com>
 <f8999f0745b2cddb42d3fbc16fdaf346b530c848.camel@outlook.com>
 <1b4f45c0-da2b-4817-8cdf-a07fd405ce9c@gmx.com>
 <50e1a0a0cf29f361426c0eb7005d389e4dd2833c.camel@rong.moe>
 <2e275902-dc1c-41b1-b1fb-998f7fd16de3@gmx.com>
 <0de1265ff914ff0fa772fad548c329c6d7f280b3.camel@rong.moe>
 <31a6c044-1540-4345-9504-2234f93aa150@suse.com>
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
In-Reply-To: <31a6c044-1540-4345-9504-2234f93aa150@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:md1aZCdEFEtvXucga4bw5KCy0kn6eJLYW5Y0pA9lOb+epGDnfFW
 ZuCAjvzBLOuJ5+9ikpsdsqms2UDjmF/O/pHNlTOUgFik5Oi7dKKsip6u323HZGmaLYQdwDS
 GUbrVQmNx9pi/y4S2y+v2FbHmog7i8FN2OIeCDRHkgmdolfpiFqUZ5+jPTbLfC7xnie6YNF
 zRxOn9gZNx6i4G0iJ4Ixw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Al+v6qkFwxI=;qVoSD6muq3w7vFNhgrmlEov4wUC
 BUomR7qWQRvkYynLhfq5qvqnz0G8R6oRrckMN2bMwm8fvmE/us1IVsDcAihlDUHH44zGnVBQH
 QnRQ0eyvXYzHZjjoFa7W8jue4vKtAS9B/7GUmOMj8fU8ZEqkU3DDhPi1M4WYWIj0D+k5NrqnC
 oOC85sHQUT8O9urIHuqoSvJ0Z0riQsBgkqPyx1nuQ1cS70mEFTLyaVMQeZkPZfJLhB5BEufp0
 SeQTVVKVdBnSHw4pcGXy5LoBayqbTo9L6dmvGSfsHu5af98665VlwsHmLPn5Vg3skWQ/bNV31
 z7UfVyRA013WPe5aAf5Cw8WxasAns+/gh3WbJBUllWtBVCcjrYtEtkHkF031gWQHxZDo4dWQE
 Ynmb+gHdT10w2LTbg/bgBJRmZ+zSHAd+9DOledY1KShRiPGbpS6idh7XGDAeU1dNW6dxwnoNx
 HqNd5HLbcsBihuOYhd2/1E+pWF8KQ6eWG9j2hxr65skufliLwGxs1UHtcCNWrY2OFHLCbysQz
 WrajDlD2nttkfXN8iVwwEJb8DOr1u2rIV5gwHraECrUXiCwc5fL1mdBs4rHOsqaFMRwe5NCPV
 ahWRO2b9NK9NINcqPosD8EfIw0OIhMvfXj2/C8Ftx6ba3637z2pNyf/+jk+Y6LtJoNUQQ/Vq/
 54VMRvVsxsQ9aosvmWPVzrjp2P9Z/BFD9mwTJ9f/7DmAXpAwVQ4wWjhj666M3TY24+YzRYRnx
 XZvNX3PpmPcqUBawcAxpd8VTLeOME+Of4zPnyHPq5umtfMVHCaGQ5/L2jRQHWx7S3P9leTG0O
 yu4oQcXkHsTY8SIlyy0xdA4hzE8YE7Sj1wNkyd1JcLJ/AQ7nokhMU6PC6pWhabk1vXuRVKaGx
 X6WZUnjOaMCo0wXOmaSptr10iOq8GL9i12lYFgcaBJlez+wa+rfLBQAC4yaY9hp7uSY4ZhAoq
 MVD8mkAg6LD3W2Dhqcim3Xh3nKc=



On 2024/1/14 07:38, Qu Wenruo wrote:
>
>
> On 2024/1/14 05:52, Rongrong wrote:
>> On Fri, 2024-01-12 at 20:23 +1030, Qu Wenruo wrote:
>>>
>>> On 2024/1/12 18:08, Rongrong wrote:
>>>> Hmm, let me recall...
>>>> Seeing the mtime of files above, I just remembered that:
>>>> The fs was converted from ext4 using btrfs-convert.
>>>
>>> This explains why the chunk bytenr are not aligned to 64K.
>>>
>>> If you dump the chunk tree (`btrfs ins dump-tree -t chunk`), you can s=
ee
>>> all the chunks and their bytenr.
>>>
>>> I believe there are quite some chunks not aligned to 64K boundary.
>>> Mind to provide the chunk tree dump of the fs (before the full balance=
).
>>
>> Sure, in attachment.
>
> Thanks a lot, the chunk dump explains why the problem happens.
>
> With the initial KASAN backtrace:
>
> [=C2=A0 171.700526] BTRFS critical (device vdb): unable to find chunk ma=
p for
> logical 2214744064 length 4096
> [=C2=A0 171.700738] BTRFS critical (device vdb): unable to find chunk ma=
p for
> logical 2214744064 length 45056
> [=C2=A0 171.700951]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [=C2=A0 171.700962] BUG: KASAN: slab-use-after-free in
> __blk_rq_map_sg+0x18f/0x7c0
>
> The first bytenr which hit not chunk map is 2214744064.
>
> And checking the chunk map, it is out of the boundary of the data chunk:
>
>  =C2=A0=C2=A0=C2=A0=C2=A0item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 2214658=
048) itemoff 16025
> itemsize 80
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 length 86016 owner 2 stripe_=
len 65536 type DATA|single
>
> This data chunk ends at bytenr 2214744064 (exclusive).
>
> My believe is, the use-after-free is caused by the fact that
> btrfs_map_bio() code is doing extra split, and by somehow the error
> cleanup is not properly done.
>
> Thus the direct cause is some bad error handling in btrfs bio layer, but
> the root cause is the new scrub code is not handling the unaligned part
> of the chunk.
>
> The fix would come in 3 parts:
>
> - Fix the btrfs bio layer error handling if part of the bio crossed
>  =C2=A0 chunk boundary
>
> - Fix the scrub code to make sure the tailing part won't go beyond chunk
>  =C2=A0 boundary

This would be merged into one patch.

It turns out that btrfs bio layer is doing its work correctly, it's our
endio function causing the problem.

Thus only one thing to fix, and the fix can be crafted pretty simply.

Thanks,
Qu

>
> - Fix btrfs-convert to create 64K aligned chunks
>  =C2=A0 It looks like the existing btrfs-convert is only creating chunks=
 that
>  =C2=A0 starts at 64K aligned address, but the end can still be unaligne=
d.
>
> Meanwhile please keep a disk image, as we may need your help again in
> verify the fixes.
>
> Thanks for all the detailed report!
> Qu

