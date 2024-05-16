Return-Path: <linux-btrfs+bounces-5034-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5948C72D5
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 10:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E53284604
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 08:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3804D12EBFE;
	Thu, 16 May 2024 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="LWnQr18r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E034876C76
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848126; cv=none; b=PjNIaO5RXPAALhRenk/ufq1t+rM1gGgpAGcGqvNJWUlNt8hvWJlsbBO4kAkeznUftjkn2wqMmoNnrdTOyHJU6X6K8VOddWmuv9ewD+tAW8unwuofZ34MjxEJiBzLn0qn+6NOOrdAdh6KtZH4D7nPS491+N/MOLx/c++TRaHRziY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848126; c=relaxed/simple;
	bh=M4Gv4EsSIh8gN5lxXFQvoUp1eCRIvBEYYPWsZPc1zvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UGygADDjkaqUCMxSDjI3/DeiWXkKkmAYW8XzJQTvPLqglqZtsWLlliNC4rhQ7pXPS5WlBDvqiIb0CO+BUhx8kE9BUdHD6t1/9lT12agvWEzC2B44csZH3wvhAkkx7VZucgKdzaN5Y2QJSPMcK4bGIxq7XHLbJpVBVZIADIVf5co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=LWnQr18r; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715848119; x=1716452919; i=quwenruo.btrfs@gmx.com;
	bh=Fw600tvPk7Swnzch1xih3twdZXMddJUsbWyAUVw5oJc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LWnQr18rIBf3uystq+iJa/tB8asOeA4/07BqlRRsbMulqKoHdRUiWvWE+Yqm1h2b
	 bENfr9euEu62KvxhjUT1d8Qod2vmG9XYU8NcOssx7VEhYHUrGWaeivj1TfI0YotOs
	 AVDUYvFuGfv8ESokwwFcB/lv7F855LXpLRKb+wazIdpTJpK0+0kTmRy+ecO9u7sB8
	 wjWzKUoT5WT0c4o75+PIeDpSlQi7JO6lGi7FVtDbJo4xn8dAkAEC6uDWD+Fmz3rtt
	 lJVddycus1rYO7tyiBppcfdn8unc1v0U12wlN2Tzf4+jztEMsApfGgxban2DqKz4G
	 zao737NYVYGXy3pc1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MkHMP-1srLg72WgD-00kcNG; Thu, 16
 May 2024 10:28:39 +0200
Message-ID: <5297bf5f-3b30-4a87-8dc7-e1f9e3b51b86@gmx.com>
Date: Thu, 16 May 2024 17:58:34 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: tune: fix btrfstune --help for -m -M option
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <4fba8ba903d32bba3f8f92db50823fd7aea38bc4.1715831939.git.anand.jain@oracle.com>
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
In-Reply-To: <4fba8ba903d32bba3f8f92db50823fd7aea38bc4.1715831939.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EKxl165q5ouSsTGrRtrmrxxnagbaaCpwxr8PwEJ9g6uy70UClFl
 ZkXXpJR+5U8KaKef1Vfo/Q3Un7frtjw+bDaddeTwHrsjMy6oqNjBtDJp09nX1++oOBootx7
 DoovvJm2LC2WdxFu8+ntk3I+g13hSgYx/1b83ICIWFDRYtHKGbXNKd5bLaacin7BzmL0Occ
 BIVhFafF5+t48/TL0LygA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jeHUUzZIib0=;DHluJUvRjHGS9/2Xme35zzT8VE8
 zw0jPdk5l9SdRD41Gh3OUF6GhFCA4UFC71jcjdyEo0pgPIC1SaIKEh3p3augW5GDjFiJNVOat
 vWVwSQzu1s/A74NCqsN52qL14Dt4lC7ixwKWKG4EzwToL6c4knHsCAUkjXvSwiQLphLsRPQu7
 GOMTQaVznJ15+xC0xXbx/Pqg+AHrCTOY+lXpOJXGB/P2ydSp0ry92zABTwIm/D85llRrvnYTv
 5+XwAXwEdw59qgshk/EUjUMiKtvXzHTWMGTVBkRobOYoTZo00I6NGgZSNqF115GXBjxexcIBB
 yaLaIKHHjDrX8LTZVMte32qkSghEtOuths+BqLzpIF6131dW9xHDs8e6HXKYVlo6eARuhQhBu
 qPFs1RYCxXbfRD0CmJLZMFlgQhiBX5rVDckJrJAyj6JFP8lATH8/nQSR+zvxPPFUlSXP3qhPm
 sA6jii4Xs6ZcRx9F+lDcnpygm4EE0sVkNskwfOcLoLWxxz0CwY8sVgq3cafs6iKcVhBRZ1Pia
 E1FgSl2LCoDp/CIdizYOcBf0eAvMXmHQg6Y2Ur0Gnk1c3hYti/8s0r9zyPaznOJN1Pe177zAe
 KDEPPb57htxUMEcKTt4053KYsAZ52urMPSpHF9RGC0rONGSCKmQfVmBXMI28q6eISPevLKK+w
 iBiUV7IJzMMKInxw+464meByomLhNNlOPQSXzZVGXGAJc4y1O+fSqMTu7jzE95bid+X/64PFK
 fIqTOml2KdA89eTCOy/PYLjrKAdZwAsdNtQznqSM1ZzJo10jY6ZC+shqnXIqQZ1Qvoud4yBRN
 UJG0NuRXiQg0w5z7tI8bJgajyh3nXE/Yrh4z/2EW9sapQ=



=E5=9C=A8 2024/5/16 13:49, Anand Jain =E5=86=99=E9=81=93:
> The -m | -M option for the btrfstune, sounds like metadata_uuid is being
> changed which is wrong, the fsid is being changed the original fsid is
> being copied into the metadata_uuid. So update the help.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   tune/main.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tune/main.c b/tune/main.c
> index cfb5b5d6e323..7ae48fe6e80b 100644
> --- a/tune/main.c
> +++ b/tune/main.c
> @@ -113,8 +113,12 @@ static const char * const tune_usage[] =3D {
>   	"UUID changes:",
>   	OPTLINE("-u", "rewrite fsid, use a random one"),
>   	OPTLINE("-U UUID", "rewrite fsid to UUID"),
> -	OPTLINE("-m", "change fsid in metadata_uuid to a random UUID incompat =
change, more lightweight than -u|-U)"),
> -	OPTLINE("-M UUID", "change fsid in metadata_uuid to UUID"),
> +	OPTLINE("-m", "change fsid to a random UUID, copy original fsid into "
> +		      "metadata_uuid if it's not NULL. Incompat change "
> +		      "(more lightweight than -u|-U)"),
> +	OPTLINE("-M UUID", "change fsid to UUID, copy original fsid into "
> +		      "metadata_uuid if it's not NULL. Incompat change "
> +		      "(more lightweight than -u|-U)"),
>   	"",
>   	"General:",
>   	OPTLINE("-f", "allow dangerous operations, make sure that you are awa=
re of the dangers"),

