Return-Path: <linux-btrfs+bounces-9671-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14959C9301
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 21:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75ABF2812C1
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 20:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398621AB50B;
	Thu, 14 Nov 2024 20:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="h9nzfzso"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D41AA7B4
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615158; cv=none; b=EMuieLTjHlhdkjRxis4OGWzdvV6ywDwazPyDIQjaasmYCVHKkdzuHBPNnu8L8u/KICVBlr/RqMuLqojUCscFQVUGRSGJ8COZkXqdFFf2nCCCJxnDwunu4h8t9UtYMu81Dl5JvqTDJcPAVEHmYGWFyoDPCLJslWwj3jCzxM3E8rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615158; c=relaxed/simple;
	bh=kKuBUUcJ7iQv0C465vm1Y+sJ78Q2YYOurx8izpJHZng=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rbgUP9kWfbGdGNm6ogcvjm/pGo9oPKNuaOXQujChEATZABwNIgm2gRPXeSc79Vl3FMmC4VXGgKyXHXJnzj8HYYdEtAKx4z1ix8i3ZIu8twiHnuIDPysuyAWocNUJJYbm7IOaDA5WzNzeLPSeGj9Du2eVBPb0HdHouXfZY/fHqUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=h9nzfzso; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1731615150; x=1732219950; i=quwenruo.btrfs@gmx.com;
	bh=A7YWKP7QmYeoeG1vrnxV7EwgjtkrHMDpLAA98ZEeMMY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=h9nzfzsoMv2kamSNoFSvEonN2ZF872BPe3OGn05N1TY7IvSSyM21RzDKq8vhevkJ
	 +r6Qq4sLph1xEO+VqkK3L4PfAbF2ZT5Wgt4GqEvVXJGfHvlAqlzjw7JJODFyCPGgC
	 /Z3uchpbdyLSVpw1WlWDrFaWeBONMmunwnvoF0zsuSr0a9QBiZXsGx458ZMbPa8q+
	 vInrjYs7cbFYCkSLb/FS0eWAzIHgx3SZv4VT/+hVpMNuwf0KPgfy3XcXNFL+rrn7/
	 koBWL9WCdt69t1DJXy3cRazWbmcDlX2zlvuXxzav0DhuZv9YiUMhZTQPplStoCdtf
	 WXBFLFqrOogUf1xxww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTRMi-1tLXZR1gWC-00RsYH; Thu, 14
 Nov 2024 21:12:29 +0100
Message-ID: <8233efd8-43be-4f69-b7aa-2c06e3468ac1@gmx.com>
Date: Fri, 15 Nov 2024 06:42:27 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: sysfs: advertise experimental features only if
 CONFIG_BTRFS_EXPERIMENTAL=y
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <c7b550091f427a79ec5a9aa6c5ac6b5efbdb4e8f.1731605782.git.fdmanana@suse.com>
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
In-Reply-To: <c7b550091f427a79ec5a9aa6c5ac6b5efbdb4e8f.1731605782.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LfH1+VvOF0tqXuD4McKIGpFqqtofqKRocNEaoN/rKtG+LMX/V6y
 hA4q5oGz2r40xriECuSsjonSfFpJCoDaHXxoaPq9k66hbYYjzin3LcqKTHpvWyYuLlqSwil
 oab/3RXTjOL9hvE6fw863hW8uyQz5nGG++kjZbmWOSE+yEh81UOyAdM16PlYeielhQux9uz
 DXZeSBBhxhkHKQ/QKupzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RTwm01IR6Js=;LdMES68PIGk63MHr874K4SRWFCr
 wl4Xu6sX8JaqGa9WmG/KhIuh28/2KzvsBMr98rgvBU46iI7d/Rmnn4aQQAq9aEx+VlpbxiWzk
 mglYb/zTzuXxlxhLwImMkHd216r5Wk5adOu/1XwIdFjlkCN6giZwfVjnkIrFpRfReO6ize9EH
 KdOe4XRbSCgHM+RRyhhJdCsE8eUc0aDljfeL4weir+P5UwpKbxeIEEdleNrEwpNqvDIsBZ/es
 epAPlGMEeW/g0Lbc+6sDZuUx0TDzSwa9N1esNdM+tWDnWKPp2LXMm8T1wR7KmKL1fqb02kpet
 2AeeLTYu1q/NRWL4gWHydmnka52CmzKKYT54LNJsMylUaZAwQYYAMO2kjZK5Kt7QZCEHx2C42
 5Kzdb3oGipuW5ToFudbsdC+m9yg79fthrp7MJ3Cp7aVnoDOyx6P3WkAgb1HRxc7HHTUDnz60c
 ncSmWdvTs0vPh4b9ZIy5xgfqkp40xLmbvCrcwigbX3xXW9IL9//KCGkFUkLDkfx8PRDHotgPw
 ekXF73vLmyoD7cWvhcSx7bZFsKIIpAsijguM+Xdl7AVJySYQTqtpfBE7yb8SuzBF1jAG+foRv
 W/wz4dgxv3vJBZ57usSMJ4amsagg1GB14hAMcE3vZVLQpOneGvffffrEEkxIcgdnpDT+4ChnQ
 3CIqyyVBlT+yhAY4AHEDnRhKi+Hr4nvnJk/qPhRJEzwM2zCKWNMmYxFTrwiADzcL2k4gVctMZ
 QNey57VaCZULMwpupcUC5+XO5497BeS7B1CxZcRXwvyFd/mo+ByGep8RXEic3qN33p+RPpSj1
 QQR0E74gkfqPoHfOdcTbTPdjypCP+Ze7BgvNPpES7l/4aXSDaJsFDecLvuRWBHSl6L/tl1olK
 8XOOSUMCQYrQMj2V+wdc2xtYDjOHd3Z1vcePtQ+i3adOnFLw8+YTzNcFD



=E5=9C=A8 2024/11/15 04:07, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> We are advertising experimental features through sysfs if
> CONFIG_BTRFS_DEBUG is set, without looking if CONFIG_BTRFS_EXPERIMENTAL
> is set. This is wrong as it will result in reporting experimental
> features as supported when CONFIG_BTRFS_EXPERIMENTAL is not set but
> CONFIG_BTRFS_DEBUG is set.
>
> Fix this by checking for CONFIG_BTRFS_EXPERIMENTAL instead of
> CONFIG_BTRFS_DEBUG.
>
> Fixes: 67cd3f221769 ("btrfs: split out CONFIG_BTRFS_EXPERIMENTAL from CO=
NFIG_BTRFS_DEBUG")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

My bad, thanks for fixing it.
Qu

> ---
>   fs/btrfs/sysfs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index b843308e2bc6..fdcbf650ac31 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -295,7 +295,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(simple_quota, SIMPLE_QUOTA)=
;
>   #ifdef CONFIG_BLK_DEV_ZONED
>   BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
>   #endif
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>   /* Remove once support for extent tree v2 is feature complete */
>   BTRFS_FEAT_ATTR_INCOMPAT(extent_tree_v2, EXTENT_TREE_V2);
>   /* Remove once support for raid stripe tree is feature complete. */
> @@ -329,7 +329,7 @@ static struct attribute *btrfs_supported_feature_att=
rs[] =3D {
>   #ifdef CONFIG_BLK_DEV_ZONED
>   	BTRFS_FEAT_ATTR_PTR(zoned),
>   #endif
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>   	BTRFS_FEAT_ATTR_PTR(extent_tree_v2),
>   	BTRFS_FEAT_ATTR_PTR(raid_stripe_tree),
>   #endif


