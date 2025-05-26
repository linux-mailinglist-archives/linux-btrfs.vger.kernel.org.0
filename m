Return-Path: <linux-btrfs+bounces-14235-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71721AC38D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 06:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3033B2FD6
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 04:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6DD1A9B3D;
	Mon, 26 May 2025 04:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="JFWh+2Th"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B53258A
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 04:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748235308; cv=none; b=Xu12Uqbb9C4A1f311E+P6jyxca5q/jO4s/cQNlvLhTzVcdvLcOr10SvqRUAVgCotGcBPhi0sJPsK+ujo/PMdiFrCLVnaiyDzcpBV54iTBut+n6yrbDKRRHwF96tsp7/ofSHa/0bB/UrVTC1vIna3Lp7dG/TazQoOERNi38/obI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748235308; c=relaxed/simple;
	bh=g5S0US6oiov5Da47ub0UgfzZ54wDhcfSQFV5SsmOJPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alqIDnTS3gc6KUaFwZqk02iDQ7VVv/pJTsdmmb2UvGqywi19Zr+fEc6f5UgPJIezYMhG7nZckYdufrkfiFXUvOT/MCsjl2dYTzTaudVD6qqDsM6via0Y2SplpKnnqKbusCn/utI/E+o3iVFXm4O/68cIpcUiuOlZes2eOImKoLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=JFWh+2Th; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1748235299; x=1748840099; i=quwenruo.btrfs@gmx.com;
	bh=oAspgPO6BuZRPlsKkovm2Oeib8fT8oflCIlBuF7yyM0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JFWh+2Thg5n+J7JpBCYOrLZeEdCsMZfAMM/YrxDf6Xcg/JcDLy/hOFfRgm07lCel
	 SGN5meABLYqWwkdrvWI0/hp9R9KIgeNVVsUx2xra6tQ5RkGjyH83ulskEZYxNyG9P
	 qLQHPN46zAysHggonBcizDavsDW4mQIXeDkE2tkxfxaQitCN4x/mUV/H9SwmtEhng
	 /ucWeeE2aIDuvDzbdhMS6ZG5X89JFCYkWPvgiwaEAIa4FQSVDM1bJvQsMD4QXNd4k
	 fAzL6GzAee1UEkvlez1Mv5DgeXdLtOctXMcjFL/IvQ9ZYm4Nfpc23pLjHhWtukVOU
	 JGwvTxRWt7WYRA35yA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.228] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYeQr-1uMsFd35tb-00V9Ou; Mon, 26
 May 2025 06:54:59 +0200
Message-ID: <3ba600aa-5a79-4fe1-9b24-a45c0a58965e@gmx.com>
Date: Mon, 26 May 2025 14:24:54 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: Raise nobarrier log level to warn
To: Kyoji Ogasawara <sawara04.o@gmail.com>, Qu Wenruo <wqu@suse.com>,
 josef Bacik <josjosef@toxicpanda.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
 linux-btrfs@vger.kernel.org
References: <20250521032713.7552-1-sawara04.o@gmail.com>
 <20250521032713.7552-2-sawara04.o@gmail.com>
 <68a7d14b-913b-48e0-be12-5bba0d17ea2b@gmx.com>
 <CAKNDObChsMqFAYK-QT8DmFEitFX+Pmi7ifGDbYe2GfnPnUr1FQ@mail.gmail.com>
 <af00227c-c301-4311-b570-47f4d404c499@suse.com>
 <CAKNDObAwjpNv1rJJ1LWis2Eh18QBi8O4Kfje45YZvsqiJa78sA@mail.gmail.com>
 <CAKNDObB25gQHWQEHQCQ1J6SOCY3KPH9VEpDdPjicvEveF8s+vA@mail.gmail.com>
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
In-Reply-To: <CAKNDObB25gQHWQEHQCQ1J6SOCY3KPH9VEpDdPjicvEveF8s+vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rUMgXN+W11JYEfzCvX4e9YZHK2fjZf0jbmoIp3Li2Zi5vDEGtsa
 IBXPyKZZQVnkZ/fyTaS8FlO+tfiYsMEI+QVqaI9CFh13KrgYD4UkEhGfVdkPYARpyqtGKQ8
 6647yiVytBViY6jgvGSwhLjEBBvmOb/JaEmfvwjIZwTSAeEa3Qqare82n0HzF07ht2MvDY6
 Os3eBfonRvF5/wV76wpAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AO9SNOg+qC4=;0Xu4r1PLXi31c9/WvXnp4rhMSb2
 pAumWmQOw3IKEYoRUOSm6SdLFczEJuO/OzbnyCMDWKxRCKhAD+Lo6iRuUEJ1ZzlRKjem8GuxG
 smcez2eFhQE4qUyxEQBz8hSVwFI5IKVV1whC9OKuQROpWPxVrGbxlbwxzxesCBVGnAYE1q5QN
 LHju9suCJL3ahfO+u7PdmPu3i/0Te/VHw71Y4/MRyB1gN1tukHhTQ7zOl5NqxL9c4XFgnTtYq
 JrIlYdFWn31wuIUF8gQ5JEsgPKJ9si6ZQwjWBX2+13yP1rteLzugz0XSfsmPX8QslJngocXGr
 +fV86VsVzVxtSVN2l3F0urHX1JxFha0yUh5ZYeiwRvwCqQo/EjqBdaE1OITjsxu+naJSAiLIs
 6cm/Q7dKk3TV8ylfreAfcTnT8nNE3D0tYzh2v7ihLKLz2EFahQliXmNYDmA/7X/CahW5NonvH
 4l1o2G5c7UrBwpHVPbCiQ7QxXS7g4B1dVKvks+p44qxP9P8xz3Xr6kqT7keGRdf4s02m38S2W
 bgbU2JQVpRYwjz4sIu1Tsp1mzgowGYjE3nDjZLq640lZR3yQjbezYll8iL+EUOkZ74e90NB4x
 OZkCb/op+QhjNu6aUTLa+TansXwvnIyb4v66gCqo4MJmRH68MiDenl8jcfku2mUZ8a//lJBeS
 +f11T3QS0UcjNoF/ttiYOkCpD0IGGZRDPvDnq9/caXARGc2FQUOZj+jvSBTiMscqa0Suk1xY0
 BKPR+m/okNgF94AXKf5UyK1SHn38xFseRRsgfhMVY9oXyczo31NDln/lQlOLnnVxkOsXTBpoX
 MA7kvSEe3A2vpVWcdr6QCDQ9cGehqWqIkCn/FPhKkPrlLgO9hXHHsjOoWJRNyaT0wb4OBEEEb
 yViqThrg31Gwmf8foyW1gDRnC8LRIXCO/jDHaejEhJ4O6SzFCOe2g8o336awb+A9sjWpqJddv
 UHvXHDSopdVTFKnrV+ACHfSBLGkYlvBkcVnbYh/PKPW/p/+tFwKE/fvN/tVSl7czyTo5xh+u7
 1XIQlQG74ZNgwBPXAIVYGBcEo92uKrnkjnBgXTvJifRy4FTLWxXkETINwDbO24aptL9NOQFuA
 BOxsnTDhHyO4Nfmt7NihmAlUrG83awdVZcU/4Nhzr4GRG1OQJpC0FNjZf0H/uWyCUw734gMsO
 GkKm4BajSvnr3bxx6pLgYgQwU4GqYOujEtyTZWhjUGt+J1DJnLqxNdvtjPkS9FV4zfzVb11Pa
 m/q7EOw7vjvQjnwhqtyjrgs50VT0FksZvSaILWmA6THfAgg90buAJfj6PB6HA9vTwJezaKmTD
 8ht67sM8lQ3eC2iuJPQlTeL1IB21qMgxcWYRVqJKSth86l/zDxL+N2325z4mZdVXzg3jc6xew
 mSS/7W6Nn2Kh/GXoU/KPb+C2Ci1mY2tLIqFCbVM4mzCMfRmdeUqhB1A5w5Xr6ZKywiBvf+SAR
 wZbfygQ==



=E5=9C=A8 2025/5/26 03:15, Kyoji Ogasawara =E5=86=99=E9=81=93:
> Sorry for sending piecemeal updates.
>=20
> I've realized that if the log goes into btrfs_emit_options(), it'll
> only show up during remount operations.
>=20
> So, I was thinking of adding the following code to open_ctree(), right
> after the btrfs_check_options() call.
>=20
>         if (btrfs_test_opt(fs_info, NOBARRIER))
>                 btrfs_info(fs_info, "turning off barriers, use with care=
");
>=20
> What do you think of this approach?
>=20
> We could also set the log level to warning if that's preferred.

It turns out to be a more deeply involved bug.

The root cause is, we no longer use btrfs_parse_options() to output the=20
mount option changes.

Before the fsconfig change, we have btrfs_parse_options() function,=20
which will output an info line for each triggered option.
That function is utilized by both mount (open_ctree()) and remount=20
(btrfs_remount())

But with the fsconfig migration, we use parse_param() helper, which now=20
only handles the feature setting, no more messaging.
And btrfs_emit_options() to emit the message line.

The btrfs_emit_options() can handle empty @old context, thus it is=20
designed to handle both mount and remount.

Unfortunately at mount time we do not call btrfs_emit_options(), this=20
means we lost all the previous mount messages.

I'm not sure if this is intended or not, the fact we didn't notice the=20
change until now means, most of the info lines are not that useful and=20
no one is really noticing them.

So @josef, is it intended to skip all the mount option related info=20
messages? Or it's just a bug?

Thanks,
Qu


