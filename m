Return-Path: <linux-btrfs+bounces-9376-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE639BF87F
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 22:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051981F2352E
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 21:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D1920CCC8;
	Wed,  6 Nov 2024 21:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Yr3JuHU2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC3313A26F
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 21:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730928529; cv=none; b=jMAvO9I58Dzz4Oueo5qXVh+ajubkiXwpBbBmGwrwBPwp3SDZjUDS4IrXZquAiOxjCmwvGX935STUnq60eGHjiyDOU4Ik11HgwYWfZIT1+mVyyDKHP02YOZLN4KkuHaq+uoWfFJjCy3x/by6o4dAb1QEYPWQMghVJoYtVJZML3Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730928529; c=relaxed/simple;
	bh=qefi6k6S4deqHDw0HKU6NSgDFp25y5YlP+2HQVcSRy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=an+SUElWwEkgK6XZLmntOiTVQbbVd1zCTEm6ccul99B4wroiszecZrL1hPDg9Kw4rgIv76PLMomHL1GSu/LW9t93Xr2z7vjeWr1IbsGZyX1CMyY08BLjBWuS5qdDuzO6SkOJIpK8a2VDC6quDTwBQo91Hnob6O4lc5r6rs7PsRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Yr3JuHU2; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1730928520; x=1731533320; i=quwenruo.btrfs@gmx.com;
	bh=quWlWYv9FjKqyTOHoM7upLhK5hxtgpxmrpxptR4p7zQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Yr3JuHU2/isZsFqzkKluubG6GYcAAlBVS4jH1ludL2YW/SKeRRlyTt7wePxFnJld
	 70gPBxcgn+c7ZMO6L7wwHkKp6J8nJYQIMm5lhCqpeYqfxK8fwUrYdeYC7ekpF4ShD
	 x/PT/bOfLaMx5e/ust4GwincY58fYDwBOvuTONMFcWVan4/AoizIuUOY6jAh0Wj4G
	 hyFp7KkNAP8iBSTjnDpTB7YP+gF7t9izF7b9wvVj0qE2+Su0PUMVu+A4T7t0+mtIZ
	 I6VP+HCqhf0F5e8JJhGg3cbDAbVLBP0BdoZkDtKDkiRzcjO072zYduLbDhVpyzWY0
	 ITXJIojpDmoGQHrwAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvsEn-1tzekZ0FdP-00yGkh; Wed, 06
 Nov 2024 22:28:40 +0100
Message-ID: <b9bb4737-bd4f-4ac1-92cc-b7f82e047d8e@gmx.com>
Date: Thu, 7 Nov 2024 07:58:37 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove check for NULL fs_info at
 btrfs_folio_end_lock_bitmap()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <9e430348860c37c68f7db326df933c0d3ae8bcc0.1730898720.git.fdmanana@suse.com>
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
In-Reply-To: <9e430348860c37c68f7db326df933c0d3ae8bcc0.1730898720.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tnL58QSMekpMcOG8UJJ5RoHuHdm+4dCD47RTYNelSjjVZ+UHKNq
 GGCipIe9LFUSC1NwOR/u92kQPwcqMRLVsbeUbYBtIW9+q/aeYQrOU/xVZoBm91qa2iV9aYl
 WVhHegQw2Rjg9NNvQ6VW0pAgEdZtC0Y7YLu3h338agZBnr2p4APo9vffLBA+y8483szm1up
 dIqSvmvQUqdyz5sdg59Rw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dlK9Xtd4bgU=;/1EsDJn2iSBLGdgJ7QlC2zs0olS
 T4Qw/CrUCfDYTeiphdmjyd1YhYwvunCrmsqlpEVpnOMaov2WDZLHzVL+TUpa5RXATFrjKdVh3
 t2KhsXpPhc/JJLl8WJTr9N5mlaHiecJeeyc6/wsgX7b8YQWfdiKOLgtGw6pXuns0J2NFvIlCE
 s7/l+hLHKCB8dxo7UrREsWp/2YY8pBtm85V/MvamAGTBer6v8Vk3t32ZIJ3eWt6o0dDr5dWie
 2mvp6IVEWULQLLdWati20N0ogePtpixEQnd7AIWMk5VSJJkkzZB3mXDTDeYxQ3MN1uynIdurq
 m04+rPw0h6ZnpCHq7hkY9G08/F6xtLt08SDnkjE46q0PjkHNrHDWEQ4LU0tnpKu0zEWgBJ6gF
 DCDGz6lmzmH7RyWIR2rUV0F6ZrLFHmYeR1KkSou1z/HcEfOIt10veYw3966OZZUnJW0yDaZK1
 MfAzrvjLe/1Qm4UrqajcaberLfvuTK8b9gF94Mzh+mmBtHO+YK1Y/DHnkgrsHojLYbsQ6MhLR
 HJbWngjK/Xby25poIYb2oVJNljbpNtPisDW0GScEbE865TPojT5E3L3QPiV+7MZjejumsIev/
 6e6fqWkdp9r/wKL7UPjrd1Sqx/4L0FxlX/rFBcNFD14uSi4DZJOu0IQIUlA5FjugyEOJv/5xl
 7hJ7kvm7hHLhAqg/UR++F3TWqMSbjpER9Jfe/3ZurSEwv1hGKCuJh5hzP2gyn2fBRf5v8M/4j
 5EY7PRiOulI/Nr0qHK/bvj25o7b3c3nqjDIl/ce20WpQyvg64gFC8qVUzQgRWwOcUya5inYNm
 NvvABP5hxA5gl2bqDqRko9mQ==



=E5=9C=A8 2024/11/6 23:43, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Smatch complains about possibly dereferecing a NULL fs_info at
> btrfs_folio_end_lock_bitmap():
>
>    fs/btrfs/subpage.c:332 btrfs_folio_end_lock_bitmap() warn: variable d=
ereferenced before check 'fs_info' (see line 326)
>
> because we access fs_info to set the 'start_bit' variable before doing t=
he
> check for a NULL fs_info.
>
> However fs_info is never NULL, since in the only caller of
> btrfs_folio_end_lock_bitmap() is extent_writepage(), where we have an
> inode which always as a non-NULL fs_info.
>
> So remove the check for a NULL fs_info at btrfs_folio_end_lock_bitmap().
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/subpage.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index d4cab3c55742..8c68059ac1b0 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -329,7 +329,7 @@ void btrfs_folio_end_lock_bitmap(const struct btrfs_=
fs_info *fs_info,
>   	int cleared =3D 0;
>   	int bit;
>
> -	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio->mapping)) =
{
> +	if (!btrfs_is_subpage(fs_info, folio->mapping)) {
>   		folio_unlock(folio);
>   		return;
>   	}


