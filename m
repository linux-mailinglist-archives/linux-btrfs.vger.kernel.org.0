Return-Path: <linux-btrfs+bounces-3798-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A35F18927E1
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Mar 2024 00:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E011F22028
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 23:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B886C13DDAC;
	Fri, 29 Mar 2024 23:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="B2ttC/dU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5696A1119F
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Mar 2024 23:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711755775; cv=none; b=NHx6sKMvQsktsEcnJLjs+KewWjV57Sl7VOwPBeucSA1rq+lwhjKmixiGlx+cyS1l58ySQrHRPxnw7DhG5c5zuh6R0VBcTU9BVFD1aCn5e8bjGfADD7ZJxBT8Gkp6ydcspUenmY14999WfVs+x3KZP2mpEhs7dYmLdpXCpQFJvAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711755775; c=relaxed/simple;
	bh=E30+Vr4I6i5JeFb/Pv13GTDTwCNo5NgA6SjERraY+Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C3o7S1AGL9BrUzpQ8uxQkPmZpdfYdbye7rykuOSi3c9hL3EgenbNOMJ9yJ+s7Ynlvca4A0iErNCavrtktVmvO79+YF/70bVl8PiZtTlX5LDseI+43eeSAgAwUOhjjLUPybyb7ZhIgvM+3j8KzHOsTldtZ4TWIlE7QyBeHewpKMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=B2ttC/dU; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1711755770; x=1712360570; i=quwenruo.btrfs@gmx.com;
	bh=vPBAuh2/ssZcawUwQ7BnHUaaXiEGJPds4qZOPxlQA0Q=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=B2ttC/dUyPUt+ohPlSDX7kPKp0jP9ok4z6/UJEDvvw/n8Q1ZDR9Fr8bBbjERDV6F
	 smnlGxmdL2Nw+eTZeirJe2LXHRufXB16UUFsFFYMX3nwTDASGmFBxd2h3kJ5XV2uP
	 QWJIHpr7pvVO8wsr5g5RIkjmx0papF9AvDah66J6LjKx1pNTdMuVjwJIoyzU2rSBI
	 DQ8jcu/jFb3UsJRJv9/yh0LC69WBZwl/s2rQwNZm+hyw5FLr64KhoeyoynntNFawf
	 ioulPrkl+r3J5tlgHmSvvaCI+qzEFQJdEMUeF1GKU64QKyoET2rNIE71UOYi62+dW
	 O717LuZnGlp+PvIE2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3se8-1sq3A2077I-00znPq; Sat, 30
 Mar 2024 00:42:50 +0100
Message-ID: <32ca8678-d0fd-44e4-b0a0-9b25383dc866@gmx.com>
Date: Sat, 30 Mar 2024 10:12:46 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: system drive corruption, btrfs check failure
To: Jared Van Bortel <jared.e.vb@gmail.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CALsQ4_x-5+W_7NQR68nTiCM9aptigGf6+HD=jLftrxgXTOLyRA@mail.gmail.com>
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
In-Reply-To: <CALsQ4_x-5+W_7NQR68nTiCM9aptigGf6+HD=jLftrxgXTOLyRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y/qREVbbd0S1vM+SrCajstdMfazNmWxb1aSM1shNAXu2dsPJWYl
 pigL+t5d/brDiAcd7+aEDdg7cokzjMoQm8RowHai2fS7n6XisAP/9a1s5hLq4VDaaahAGNl
 PZ0X7sbE13NJLlc2WRWM0SiGx54pUDxf2F/0QM+Gr5ZBy5MV4hAinR8ZK1Znzk/7GFgfpkw
 7LoecfAQIYa2SHQsYPxXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wTdMknNKbLc=;7acssMYekmamDkwcXTfxwPSdVMd
 mut/xNx2Qi+BEJoa1zxGpmpb9DPCTW6FXe9tJQYeXO7SvmoBEQuzybfjLwnlP64MtfzeDVeyF
 s+09xAexGyqe33/XktsKHTsbYJAco+7SAfRuuuC6Si0FIK4UUgO0H6hostqL/oCAxLEtCv40l
 EyuK9VQYWAkNv8OMrB+UFCRS03XRldhO+cv3Dqe5s5i+T9dzWFMp2qjBHEz2tv83j/ZJXeNhy
 arNSDJ/ItFxzkFCIT/6hU2iuAo8c2ddnZQy3igv80FMLJpj0BIUKHrovwTZzLMGTe3OS8VD32
 7FmYZgUT/eutlYaeQ0h/KCWoJRHZYQAHRcxIxUAfgxguAcAM7hIDXRTQSlDAA1DCmFwiS29j8
 lCAvIEP/qriz3953D18ol6SL55dG9iqJOG4Y8XiaDflWwTFFKz4NOfEMT7qsC6hbOA0oD2QpP
 4hf6g/TsiNvLfBMka8Kwz+6sgFh4+anXh2cLVyx/RXmf7JtzOv7ZUn6mM4ORfrffDIPXWfNXU
 NFOtisnTEKcy7ygBzVkhxjxTaDDpkLONtXCVoB9xHp2TeW60RJe9Gwk/Pt4ufJANdWdLZnlIJ
 TJ9orU77gtKcwhhs0bRZbpysMHWfZGjGFjOnhejtQCiclJA9kZgghlognKzAJyY0ErFxluATW
 xad2eZbtLtLRQC9pRVcnSLomTLAVW4VFBxbNTd22i4sVzhgd4m9Qi1vkS2EbsvmIoqBQBmm2y
 wG9YVs810qP9/WnRS36kJW4PmYt/SdkEYB/Cwr85QIb7RKLlo+LRfZWc1Bv1JjXDF7ptAl/r6
 GnbJoB+Fp86H2976xbjKc85bKYvSEsVFiT87+tFyQdvNE=



=E5=9C=A8 2024/3/30 04:00, Jared Van Bortel =E5=86=99=E9=81=93:
> Hi,
>
> Yesterday I ran `pacman -Syu` to update my Arch Linux installation. I
> saw a lot of complaints from ldconfig, and programs started crashing.
> Thinking it was related to having only 7GiB of free space available, I
> tried deleting some large files and reinstalling the affected
> packages. I saw no clear improvement from this, and eventually decided
> to shut my computer down.

Do you have any dmesg of that incident?

>
> I booted memtest, and it completed a full pass without errors. I then
> booted a live USB and ran `btrfs check --readonly /dev/nvme0n1p2`, and
> saw a long list of errors, realizing my filesystem is most likely
> beyond repair.
>
> Basic information (RAID1 metadata, single data):
> ```
> Label: 'System'  uuid: 76721faa-8c32-4e70-8a9e-859dece0aec1
> Total devices 2 FS bytes used 2.18TiB
> devid    1 size 422.63GiB used 422.63GiB path /dev/nvme0n1p2
> devid    2 size 1.82TiB used 1.82TiB path /dev/nvme1n1
> ```
> The installed kernel is linux-zen 6.6.10 with a few patches. The live
> USB I'm using has the Arch Linux 6.4.7-arch1-1 kernel. Full `btrfs
> check` log and smartctl information is attached.
>
> There are three main errors. One:
> ```
> ref mismatch on [1248293634048 16384] extent item 1, found 0
> tree extent[1248293634048, 16384] parent 2368656916480 has no tree block=
 found
> incorrect global backref count on 1248293634048 found 1 wanted 0
> backpointer mismatch on [1248293634048 16384]
> owner ref check failed [1248293634048 16384]
> ```
>
> Two:
> ```
> ref mismatch on [1261902016512 4096] extent item 2, found 1
> data extent[1261902016512, 4096] bytenr mimsmatch, extent item bytenr
> 1261902016512 file item bytenr 0
> data extent[1261902016512, 4096] referencer count mismatch (parent
> 2369673248768) wanted 1 have 0
> backpointer mismatch on [1261902016512 4096]
> ```

Corrupted extent tree, this can lead to fs falling back to read-only
halfway.

>
> Three:
> ```
> block group 1342751899648 has wrong amount of free space, free space
> cache has 34193408 block group has 42893312
> failed to load free space cache for block group 1342751899648
> ```

This is not that uncommon if extent  tree is already corrupted.

But unfortunately, this may not be the direct/root cause of the corruption=
.

Thus I'd prefer to have the initial dmesg.

>
> And this warning:
> ```
> [4/7] checking fs roots
> warning line 3916
> ```
>
> I bought some replacement disks that I can install alongside the old
> ones, but I don't have a recent backup of the full FS. It seems to
> mount readonly without issue.

The fs tree is mostly fine, so you can mount it RO and grab your data.

>
> What's the best way to recover the data that's left? And is there any
> clue here as to what went wrong? I'm really not sure. If this is a
> drive failure, it seems premature.

It's hard to say. The old original mode check output is not that helpful
to locate the root cause.

Mind to run "btrfs check --mode=3Dlowmem" on that fs, and save both stderr
and stdout?

Thanks,
Qu

>
> Thanks,
> Jared

