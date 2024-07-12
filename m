Return-Path: <linux-btrfs+bounces-6410-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F0F92F333
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 02:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E15BAB21CCE
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 00:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FD02900;
	Fri, 12 Jul 2024 00:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Kbx7af2u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1752B646;
	Fri, 12 Jul 2024 00:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720745453; cv=none; b=QFWKAzDbe6VqF4oiy3AaAKpvHwniTyHaD6PBoDecZWXamTkczDuaF7iO5APDbwIYDtufSz/LuhmNlS84YpzVjXVrIyWFTyRkg1MeUoeR8X4VKtNearLWgjDf1473jny0+VXzezHOAETMnFvKoK5omq8F1H592uknqYkrnG2IRSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720745453; c=relaxed/simple;
	bh=ebxAVpPLBDDEW394icOzolCpxuyRy68tIdN3DxTWaQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzWWKUqiWZmF87/iiIyCKZfNO+i62vxH1X4s1hNxedUd0g45da2n3lxNFmqLzXda8FUqPuoK9gL+SLQjlRzsHbcFy3f1cSdu1N3YCE9DTYm/dGsi97lfDsYHV0flCJE5gXLhljIFjr6AdkhKzgY4p/TpUYN9ETaLlfRIMF7gLrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Kbx7af2u; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720745444; x=1721350244; i=quwenruo.btrfs@gmx.com;
	bh=sZDT7kejZQvNs9L3w8j5CCz7rhEH+8KOSIYkTYmWKrY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Kbx7af2uxGAW0PO+/rQytnj8+Oy8J36zoeIY7Xv3HJRMN+uMv9TZtvu8QicEJKnd
	 Rc9LwJe49InC1bzQ4I1iipwSOf1Q9C9Q2+IGam98nH9Rx5a7pXJ2VhrMfY5a3W6NB
	 v08STcWYmcoiqlN8YX0SaeZXc1Pf1yQ1GzfgmClCamQL/74uf49JTokdGPEFeEmKv
	 kftRne9+wl73PCvIepyCsfo+KRLnDSFSOpeoAQiPJKT6Vqtq/XzCIpdb++25mbmx6
	 8p+0mRcI/4x/gRlINLEQKlwtl0YgE/g9mMTjBHT3xTpdAgh/mZgRCY9odJIAYuNmN
	 0Dw/5WMqxuviMzKbtA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtwUm-1sDpMt31G0-012XZt; Fri, 12
 Jul 2024 02:50:44 +0200
Message-ID: <83ac7690-57f8-4312-85f3-a8bbbe129fbe@gmx.com>
Date: Fri, 12 Jul 2024 10:20:40 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix _require_btrfs_send_version to detect
 btrfs-progs support
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <fbc8f96ec69397ce358e759b9a8df25f3e64c6ce.1720742612.git.fdmanana@suse.com>
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
In-Reply-To: <fbc8f96ec69397ce358e759b9a8df25f3e64c6ce.1720742612.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3adBrL0ucAdEHCca3ot0xmOqMF58wzpBXiOq2zf2ZKNAYZeZYlZ
 bUEemKSwFj4tWZ8n6zpIqAuSojfwKiqnkUhKQrvEC3OHbL7FCkq2QQeNkJ5WY3YSvzboHLC
 X84JOWJvAMAu2vu42P/DHDT4EdWRZsQ/fYXDow5uWmIfSYTfjkMacrcrqmb45tCP4GDV9Jk
 diwCD5TmW+xFgDrPNYNgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Z3FN8G+mVQo=;B8m/i9wpISBWw2jgr6493ASMH69
 RRqTiYhtmKFRNXFYBuJgHFgwNwNqJsZL24UKcEljEV+Y7OJHYGsAkde4720Mb5E5EeSGBRDDX
 eMBNRs6bWiWwJIJhoUyICPd4J8Lu7eI+okI1TZMtWSTER8ilBiXx+xpB/ylCR4jWW9ssSV6Gy
 I1wE9gKZ2YaJDfUjMezkBNLbmkBYgExhc+YBZNq36gVzhAI4Otca/uMSjI2/UrlyAZZ8HiAxg
 Miun+2OEeJ1jEZcSVaeZherYiEm5OS1OoiEEzmFvhVqIBz07iDVnOiS+Z6mlIMysLqtIjnCTG
 k6gXNMxKwP5P+G+ZPbznIKUdP5CQUVYs6HsNhhuP9IFM1PzLeXsrl1SyoeXTbXzA6nq5FlMCu
 pNPHP9nkpOGAL3E1FqzmFF7BlU0NLXgSdbjhjaJprJYjRj0IRBzlyL60Def5bfKoO21HXvXn6
 FViLshks0hWvghxsCYEqcPTjqrewmnBtIWnMadpdKjZEqKAUQVXv3AvZai4OZEiPgbesxZSRM
 6uB5OKC2CVXPrh4kzaaIqreC6nPJlOUTYHLP+8Decv69S1IgPn8GrpCUmNc4AxLhDwRzR5//G
 rkHRYQC2v0qHy4JTVjfb/0OLIFJ9Ymc58XCifaqI762INLGA0KqsPd283kARdZGeiKMI6I9XD
 XvIn9WpMmm5xM4rBYtyw9xV/+HOeP5OgxWpUq1hlzLi1yEN5HUKobP/up1KgMm0n+WpdjfQcE
 mTYA6HhDwY9aph5Y5kjyI6QBYylF79x5iFCSugZtptcAR6jIjNxyGDQEFP7BLCe2+7Hq8B8D0
 4FmvkWF95w96WlSiWh4wE6+w==



=E5=9C=A8 2024/7/12 09:35, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Commit 199d0a992536df3702a0c4843d2a449d54f399c2 ("common/btrfs: introduc=
e
> _require_btrfs_send_version") turned _require_btrfs_send_v2 into a gener=
ic
> helper to detect support for any send stream version, however it's only
> working for detecting kernel support, it misses detecting the support fr=
om
> btrfs-progs - it always checks only that it supports v2 (the send comman=
d
> supports the --compressed-data option).
>
> Fix that by verifying that btrfs-progs supports the requested version.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   common/btrfs | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/common/btrfs b/common/btrfs
> index be5948db..953dc2a0 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -777,17 +777,30 @@ _require_btrfs_corrupt_block()
>   _require_btrfs_send_version()
>   {
>   	local version=3D$1
> +	local ret
>
> -	# Check first if btrfs-progs supports the v2 stream.
> -	_require_btrfs_command send --compressed-data
> -
> -	# Now check the kernel support. If send_stream_version does not exists=
,
> +	# Check the kernel support. If send_stream_version does not exists,
>   	# then it's a kernel that only supports v1.
>   	[ -f /sys/fs/btrfs/features/send_stream_version ] || \
>   		_notrun "kernel does not support send stream $version"
>
>   	[ $(cat /sys/fs/btrfs/features/send_stream_version) -ge $version ] ||=
 \
>   		_notrun "kernel does not support send stream $version"
> +
> +	# Now check that btrfs-progs supports the requested stream version.
> +	_scratch_mkfs &> /dev/null || \
> +		_fail "mkfs failed at _require_btrfs_send_version"
> +	_scratch_mount
> +	$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
> +			 $SCRATCH_MNT/snap &> /dev/null
> +	$BTRFS_UTIL_PROG send --proto $version -f /dev/null \
> +			 $SCRATCH_MNT/snap 2> /dev/null

IHMO we can just skip the -f option and redirect both stderr and stdout
into /dev/null.

Otherwise looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> +	ret=3D$?
> +	_scratch_unmount
> +
> +	if [ $ret -ne 0 ]; then
> +		_notrun "btrfs-progs does not support send stream version $version"
> +	fi
>   }
>
>   # Get the bytenr associated to a file extent item at a given file offs=
et.

