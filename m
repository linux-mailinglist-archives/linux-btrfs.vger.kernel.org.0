Return-Path: <linux-btrfs+bounces-2994-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA7D86FAE9
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 08:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB941F228C3
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 07:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C960313FFF;
	Mon,  4 Mar 2024 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="iAJs83oh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624AE13AFB
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Mar 2024 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537552; cv=none; b=BYT8lZjFvmuQ40OSY3cFd51jwioJ6kp/77wnoDa3FuLSSy+kCZc6saZ3e9MKhbk8ZSY9YufpqwDtsTqj/bF15xgjBpP2goIPGl4VJ3hLmF7doeie8oHKu1VEHG4KlbMsgchykLIN3/Bz3aFXtNWwzLcweYfimU/QNlSaasdddVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537552; c=relaxed/simple;
	bh=mhP0o3wi5qJaKNhEFrKKErqGznc4moT1qhueXQEkUqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1/ZSSUU9owMaBilWq7nFLzEaqNUeRRx2lersxwkTG3W8Pj0dJKv+poPMFrfybe17CQ2zxJtFZcpECysRzxRD9K259WPaonSWY2+nRmQG9tg/tQ638dJ0rMMqzr3s5XYx1oyINQeI5v6w0hfY+e3D8ahG+VkZBZeLAXN64PbfJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=iAJs83oh; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1709537544; x=1710142344; i=quwenruo.btrfs@gmx.com;
	bh=mhP0o3wi5qJaKNhEFrKKErqGznc4moT1qhueXQEkUqU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=iAJs83ohHTYAT5OqYw0nv0pO+WPWJqRs8zzZ8jLIWvTOy0mF/a/Oy6PAuqnimJuN
	 MRJ4YJPf2o9oIX8s7Ds9DcXLA2qXK504ejMyQeUJEiqDiNndWy8T/A6EaOO9Q83Z8
	 B6b3jzU1/Q+RcQyRbG5vmJCYUywHobI4RNtNUV8QhZupd+6EoXt3J40A/LA+447ac
	 3JMG/tWcldcC8oCqigcKmoJ2zziuy22IybMeb+A22ZxkoQ8F2z32tMJfbL2D0aDXB
	 5ZIboS+y2FcprOKVUq24lb3rd0wdmQCXujgMqpaAdioeVI5rYzoMFCd3RkcWfhazp
	 x/qLYnrXn/uE6pS5EQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxDkm-1qwtJP2oPI-00xXB2; Mon, 04
 Mar 2024 08:32:24 +0100
Message-ID: <e4bd611d-1187-4f91-aee8-91a028ab11b2@gmx.com>
Date: Mon, 4 Mar 2024 18:02:20 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] btrfs: initial subpage support for zoned devices
Content-Language: en-US
To: Neal Gompa <neal@gompa.dev>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1708322044.git.wqu@suse.com>
 <f9be8d16-a1ae-4fb3-8670-c6c7a2615d36@suse.com>
 <CAEg-Je-tpYX5rikHjf3mXeqN1Rj+3Tr9arAift2j+Ycj+ma-sQ@mail.gmail.com>
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
In-Reply-To: <CAEg-Je-tpYX5rikHjf3mXeqN1Rj+3Tr9arAift2j+Ycj+ma-sQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5xlVUkyG2hVf9Ru7MyU+vNF7Z2kJ4+M2RuEZ+pcAy5Ge76iVdxf
 awPlKMNJa5XONMGXXSbClgOjea50BhljTWHG7tmJlaUhgoD2KMm12oburYLGOdz3J4R13eK
 Me22JM0OqqWwvodbM0lrCR0gl4EfWO6s0rfQk+EeDhvqaFxbF9OQ+FV77lM8xADN79KMYlK
 hIwHnR4DgdsOzYC+EDU4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lc0DO/C5vz4=;Zita5IzSfsE9en5DjG96NkZ5B/I
 XqQ0sJbYP2rh9FYM958ekPfxD1XcQHjy07VrOsYgpfR5eG86IqTEYMVemvtR6tduQUJ6hg+r+
 mcCoQxi6n3Nd6iW1661TowIYU2W8lWvLdBIKNzSYYVYR4xi2UW4oHg3h0HMDdJl2rkmRQNMN9
 57YjN1ntPj4jhDQ/PvSrEuJsW7+Mlj3TqzeYYOuZjo4bUzSzabDQ0skOKQUYiRLqXZiBSbIuq
 Ip4/LOd0n65T7mv+m8a3Pc0k/5bYH+PQRS+qi8n7w59/hA2P9SFdxCeiH+eEvvx/Ph97q063Y
 QCzN31OYOrubRt8uqG4weAK8mdtbYsfzLhIjtjU8C6wIxE77cx4cGfHzKpPF/dbrH+UpEBc5b
 XpBhpQf0J59Yu6r+JOxtAflkmrrWLD81v9X5XjbzChHXVbNEF5XTOMDdZ4LcEttYpwCNUBZlG
 ZKuj45zDLmOHfhHbQ6XsZ9qBOWT4wi/+doy26YyCEvLY/oVR1HLWlIuy6r6ZlEa2ip7+LdVK+
 I2irbzGbYcpGXLfZgC1yQJ2z6TyTNsvhHJ9FUCnDsDaqu2NzLkX2RCPJxUTff1WEDv5wcKSqw
 zTmYpzppxMVBNqmk4QUzuVxNQE2ZC+hm2tZ2EjKlB+YWcGlxwJHmqmJdXCC9QdzhxG5rOQnoX
 gzW4ddMqRLjJhVZTfQ8olxPm0DLeNcstfEd8ShAo0H0bl95Jdew19gSOHjnUE/5WLJXnV13D8
 0NyAiPqXxO09zYM9KF3YcPEgozIVI4fUwsrkgxgB1P3zjoL5CyRUcrgrPBFnDh52xQmfx+pBp
 J6UpxojbqmiWAfF6Xlphpb7i3kJC5EDWXniQr64XY/FCk=



=E5=9C=A8 2024/3/4 15:40, Neal Gompa =E5=86=99=E9=81=93:
> On Sun, Mar 3, 2024 at 10:13=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Ping?
>>
>> I know this is a very niche scenario (subpage + zoned), and the change
>> itself looks very scary, but the change should be safe for non-subpage
>> routine (as the new lock all delalloc ranges covers the page would stil=
l
>> at most lock one delalloc range for normal cases).
>>
>> Furthermore without this series, there seems be no proper way to suppor=
t
>> subpage + zoned, unless we do a much larger change to merge
>> extent_writepage_io() into run_delalloc_range() (which I believe it's
>> still needed, but can be done in the future).
>>
>
> On the contrary, I don't think this is a niche scenario at all. Quite
> the opposite: I expect this to be a *very* common scenario because we
> will see AArch64 systems increasingly rely on subpage because 16K
> AArch64 Linux is used on two very popular platforms: Apple Silicon
> Macs (Fedora Asahi Remix) and Raspberry Pi 5 (Raspbian/RPi OS).

In fact, the above 2 platforms further prove this is still a very niche
combination, at least for consumer hardware.

Apple Silicons, you know it's the usual anti-repair and anti-customer
Apple, there is no way to add a zoned device natively, and if one goes a
convertor/dongle, I strongly doubt if a SATA/SAS to USB convertor
supports APPEND operation correctly.

It's possible to go thunderbolt -> PCIE -> U.2/NVME to attach a ZNS
device, but I strongly doubt if any Asahi Linux user has such hardware
to go in the first place.

It's the same for RPI5, I really appreciate the performance improvement
since RPI4, but the IO is even worse than Apple, and not really get any
better even in RPI5.

For my environment, it's indeed aarch64, but with a better board with a
lot of more IOs (RK3588, 4x PCIE3.0 + 1x PCIE2.0 + 1x PCIE2.0), but it's
still not ideal, and I have to go tcmu-runner to emulate a zoned HDD.

Unfortunately, we're still in the wild west of subpage world.

Thanks,
Qu
>
> We *need* this series, but I do not have the hardware to stress this
> patch set, unfortunately.
>
> The code otherwise looks reasonable to me, though.
>
> Acked-by: Neal Gompa <neal@gompa.dev>
>
>

