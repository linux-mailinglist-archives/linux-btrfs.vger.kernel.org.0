Return-Path: <linux-btrfs+bounces-4664-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 307AB8B951F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 09:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D7FB21785
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 07:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC5321A1C;
	Thu,  2 May 2024 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="obmQdvlQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC032032D
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714634270; cv=none; b=ADX4AomjFSCiRXVnFhEuqRkoOh25eVRHZk+eB+tWd8yWmcJH/rbkgQ7kBS0ial1TC+sy1Ln4xD8B51dPMDEY/P2ROVgldy5yLnarPPXI8JdgxDzJKbYtVzV1M69tLMSM1FCm0rP58W6enweDNsC8Z+oY/gi8XOqu9BlH6fiuiTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714634270; c=relaxed/simple;
	bh=NtPkOHOQJ9PrTpN4cPGHrCx6K6LLipj2m95KEZG4NyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=py+wUtD0YWBjVDDdqwjC2XXLsD2FGG3NOde0tazevBpmuLr5G2O2JhkqGee2bdU0MAhxWlILledHRI36jC1CSpWPYxzVD8W275JWSvzoNsfWfjKkYnfn99dCuVmSVaZsv4enCH1WXo5FP9BmnqRHckEC8zFx5OAHzhJxp4/5Zg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=obmQdvlQ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1714634258; x=1715239058; i=quwenruo.btrfs@gmx.com;
	bh=O5qbZGPl19ec9twh9P3SNdWEQrUaZdj5ovubappaPH4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=obmQdvlQGO1H+mOVeYuSVs8zTXPNXdHhdYvfKiQ53u81YynOh305tSUzp/+CLgrv
	 dmSFqNKIAYlGPb45GbHchCDx94H34/iqT2WYUX/E2iYiA7oKa9Emkotr9bd4GNwXo
	 HSYQHyumwYA1QT2GVXxfnMfD1PGpPmW88RdM6c1yyeWFsXWn+PwmKLw+nyoYWXDQl
	 ZmDwbJQx3P/I09CdrJFKGBpTbfIX7VR1lYCQqQH8LRHhNs7xRjwXF4iJW5wJDAAbx
	 sGyvl3bxdd2jOcT+jSptmwmTvMfF4c4Xz0AoV5YVkXnnhJSLUhawrkFPDtBTmNNyu
	 IyEnBPG5FINVpst9Ng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel81-1scaSi2iOL-00a1Vk; Thu, 02
 May 2024 09:17:38 +0200
Message-ID: <3b8eed12-0fb0-4bcd-9b32-1d04d89cc780@gmx.com>
Date: Thu, 2 May 2024 16:47:32 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Help with ROFS on Cache Folder Deletion
To: Eliza May <eliza@riseup.net>, linux-btrfs@vger.kernel.org
References: <2236adc5-3520-4ceb-ad88-5bcc6afd18d0@riseup.net>
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
In-Reply-To: <2236adc5-3520-4ceb-ad88-5bcc6afd18d0@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hYDDszsYo+Gy1GEF2IFLfMimCZgvP+We6DJ439luTKBYkLRs7/D
 bqxCWdPM8eIU87m1J3EjmMuo6XRQoGooO8m4N+vnruo9P5SZ/1dYZuGBr8+VYlWllZOgiRn
 gemgLDyHQ7Lx7OE4yhtQiv2w2KUhl8o5o4GXf8uE772uWe1hPsK9YEin4kdYI8rSPDqy7md
 kQJlTTtKF6PSLLR4lbzbg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PH/mszweMvY=;9aVklU5W68Pmtg4uQ+gaRC9m8FW
 MTXQPRh47QTAEY74m8kgOqG53IfttYbJZGtV6TWA5geMPkcnkMxfAQQQ32bfM569tLG04KaL+
 b8hPrKJsyzMGUO9J+GoXVyuNc6yf3Ecsd9MgiN+hX22WIADXYU4l5G/WmMtyLIfNgxCUbFCQc
 cjuv1PaJ3vj329DHLRYyA3dWTyx2Afa2ZIyI/zarXszb4qH+z2ktCXHqCkDq+sQ5dwTScqgfB
 vZOlBrleAQ3tDZt7y/zHWotOCoFjJNDeOjDVcBiIH3i3dcwFB3yRF3QaomABGB8m6UipSX/HM
 /volUlfR7yq5DSzuE0MkexExW6Cca96qShebPR8LNG7mZ9t5fjX0W2iytsar0epNhaa+PsWn4
 yP3UNhEPBPKbvfTYI7faSoJjjwpvKhr/tlxdO9sz5IHnaV/jLJzCBHmj06wLSxLJ15eDz79Ru
 /pU+3sTkBKszh3qLWg+spQMOnqjxix4jslSTIRYLgacPjr0bo6phuWfNTglLi6/YUbWye0+Mg
 GdTdoPu50D7r577duSOuSdSPiLjCpXn0bhVGM6r+HgQ2YmkTz1Y/KF33MCJQtmbGceFdlEE6y
 erTUi+vSfnuluWagybdBJ1bdwHIFMQwvgpINgD7Sf1zH/Hnc+e6IzeD5VkzJXAzeXyPj2TaOe
 P6AVZ1W0vbVmo7wIjkItQjdPTiWwGkoFNNS2QtEfwKfgsk9dNp7QkW/Av1OPwSskWF682Rbpj
 qEb/oRp25xq64JpH2xJVdiadhfo8NJyhsLf6f5W8wPRKQ1daFfH1TRNSyQ37MQgbA9CvXk+/b
 MMuHWd1mSVbssctzQejOMZDjjvqQMcqlpiZHCfZOu4IGI=



=E5=9C=A8 2024/5/2 15:59, Eliza May =E5=86=99=E9=81=93:
> Hi,
>
>
> I am trying to remove the paru .cache folder from my computer, but every
> time I do my btrfs filesystem goes read-only. Here is the dmesg output:
> https://termbin.com/f4sw
>
> A scrub found no errors, and I have not yet ran a check -- I will be
> doing so and reporting back when I figure out how to do so.
>
>
> My filesystem is a main partition, a separate home subvolume, a var/log
> subvolume, and a /var/cache/pacman/pkg subfolder, but I am attempting to
> delete the paru one; not the pacman one.
>
>
> If there are any other logs or details I should include, let me know.

The dump tree shows:

[ 1623.783513] 	item 97 key (3069062266880 169 0) itemoff 13049 itemsize 3=
3
[ 1623.783514] 		extent refs 1 gen 1396868 flags 2
[ 1623.783515] 		ref#0: tree block backref root 16391
...
[ 1623.783683] BTRFS critical (device nvme0n1p2: state EA): unable to
find ref byte nr 3069062266880 parent 0 root 7 owner 0 offset 0 slot 98

This means the bytenr 3069062266880 should have a tree backref for root 7.
But the dump tree shows it belongs to root 16391.

Furthermore this looks like a memory biflip:

hex(7)     =3D 0x0007
hex(16391) =3D 0x4007

So please unmount all your fs and run a memtest first to make sure your
hardware memory is working correctly.
And do necessary memory replacement (if possible).

Then finally run "btrfs check --readonly" for the unmounted fs, to make
sure that is the only error (please paste the output).

Then we can determine if it's safe to run "btrfs check --repair" or
there are too many corruption and can only do a data salvage.
(I bet a repair can be done, but still want to be sure)

Thanks,
Qu
>
>
> Thank you,
>
> Eliza
>
>

