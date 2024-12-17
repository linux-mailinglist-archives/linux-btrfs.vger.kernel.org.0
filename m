Return-Path: <linux-btrfs+bounces-10511-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6B69F5827
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 21:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98955188F21D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 20:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ED71F9EC1;
	Tue, 17 Dec 2024 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="faGQ6mLM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2976D150994
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 20:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734468635; cv=none; b=eJtHIkQpasjiTX0/Tjq27DDVKKgaDCEuO4g+I2QxPXqZR4SLV5IGyQtMUvio6cjpAM5hL4no2J6JgjIS83WPAZSeoZ51CivqbKZstJiGQWFWeWN6aPdOVv5KkpcGKYqQwneynNzXvH65yNl4m31WzUNj4jRUX4YIGqJ5C1yU8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734468635; c=relaxed/simple;
	bh=Ws88+xOlN7edNxSoVXzwkPzdQeedr3nySCSpiFhmEbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Igcki4Qn5kXM1VTDH/1EEIC4JUbQ370A4lhZDzTgsoF50DsVpH4CO1blYukCRlTE8sff2wXxF1dlkathKp7uLhZUA47LufvLCdWuSrLLDrdcm2Zc/5vnyuLzyIScb50OP4HBDwqvYQyuzjMfW0x/SfOm7g5zpeiyPfJORXhdtgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=faGQ6mLM; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734468627; x=1735073427; i=quwenruo.btrfs@gmx.com;
	bh=xEOc1bCZ9sZwzTfvULozT5FpP+6wq9jV7iPnNLlkg3o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=faGQ6mLM+tlgVNxLXiAoyu85QkZdKQeDg9wy7a1tE2C3FrjpkUfqRexErVjw/Wi2
	 ppKCLtCJ1aCuh3oCkcKaqktjt8zInuxtXUJNwa6Ct7Quc3cUanaYgRKs/gkXIeYCo
	 5lCMdnZSuCzrWjRfkPLituD6AXYwtLCwz5m71mj8VatNTvFdTiGFrF4rg1vzDTanI
	 cePlrK1HP91LrUQwJ9I3GxmDZu9B2IVAtE9a7QhdDXNqBdsKCZ3K9N0/wKpfVL4ua
	 nyLCfIHFhX8FZvA+sqHXhro9n9jZwF+aygqp8IHr5r9tEqF0sRyKg0GYkxL6fIL/2
	 dlGyZPuWj9wi/wupSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mj8mb-1u1x5D23Er-00dpDr; Tue, 17
 Dec 2024 21:50:27 +0100
Message-ID: <f2b86a12-510a-484f-9e2b-48f91ef2e000@gmx.com>
Date: Wed, 18 Dec 2024 07:20:24 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use uuid_is_null() to verify if an uuid is empty
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <60c0e07d871249ed86b53087c75a1013233da355.1734437595.git.fdmanana@suse.com>
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
In-Reply-To: <60c0e07d871249ed86b53087c75a1013233da355.1734437595.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xEILstUMt+fi36DapK5Y2M4yfLRv/dUV1fHSAkYffjmGmyRmLm/
 YS8C96/h6YQR4STrb1Go+s+gTn+OL8r5iwwVc6LgZcfJ6evWTGUUZi6ocklZQRhPRqyGJBK
 BCn6bc4YZh+XDkcP9+6TqTGC/0r5tov34CYeEcs5p85mR/PZYIYJYCYHciWC897WANtIoCp
 wuSJtJmBOfgW9bk0PlDYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xo2o/+xvQMc=;ZlMEPXmG7Nd+K+1cZo6etSmB/Oj
 9rcWh0fcLR7fXO3qyUodH1BQYxtnf0+ztSdddjRmX5mjE0RmTVgEr4ZUHIz+aNxTYNBQLS6Ww
 kZ3z95R2kN0AFLQQiGPccRbNURc2pa5unESojNQI24Lvps7Dn7q+8xhgmwMpeWvS6E9WRj/bP
 ZSpMCEAgY6gSN1BK9qkmKodam8e9IPa6EbjdlFWMEtcbE1O/7G2Zihh7NGowvPppWYX2Jjdbs
 6jkbsfMv/Xetl6Z5bHabD+mGosWB7tekJsFiGusa4XBSutvBZ2HwWiUMgkxCv6eM+pxhuNyK/
 sY/uKgzhHuztJmVdZ1YQHdhw8PNivk7rnB+/MHn+fs7w2MXjhlhO8z/61lAFvu6KWF5HpY1Ld
 KPPaHDKmTk9ISY2zKVCadPCeOk1S/joqfFHVXM90DLqFb6Ltc4KqhZJOajwQti+u1ZPAAlMWb
 fnc6L/L8GhFlL7yFcNYz3Ii2ZlRtH9kSwwVkGBgJs+hW6oP8XLNLV1f7PyEoqtM7mgOnOAa9C
 eQmxyqUQpY8wlKSps7uVGzQMDHzGJRMep5jDYmKye3B3iqVIHDQfna2bA4HQ3o0wL9WsqPDqM
 RZJdGfPbrfUk3HvXij+EqjXcmKWbtl3/P27EwyQzBpLfFL9+Ie5oLBBt0BaP8KLXSIsWetxoy
 O7Pbql+WXOrgQNw1JO+GqNA7aN1EzqhkpSPaOQ4v94lTrcX+pty/UDLTPC8CNHccrRmW0WvLK
 1U5dxodvgD4sNXB11mZfiCf6cbou5G7EcZ7IuClmsw7Wi6TUYgukvl4m6ChRPXE8DJCbxsInB
 8i+6RG1TwL57V7pV5QilE4lbkA0L/urfGjkfKCPtKItOV03eM697PGgwm1veN2f/zsMFVxMPk
 L4e786ThgeEHmkPvirsZTu0TmGfTiPr+ZFFOgJphpCz6/BahiwmWz7D6FU0uttJPDRaguS+Mt
 VJ7WQCLp5O08V0o8JWIUw+dM85qoHdqX425utaoWjq0mtFTYhjPFWlR89CWRUOxkQt4RCnH57
 SlYWax2Q1Uo6uAGWbVoW/RnkU7mETQNSt7ovppg4p3fbNwUWJqHuDrIHH7zCxbr1zNvwLnX2W
 nr/8SQI/MWAZk0mmz3GT8oYU7d8QZf



=E5=9C=A8 2024/12/17 22:44, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> At btrfs_is_empty_uuid() we have our custom code to check if an uuid is
> empty, however there a kernel uuid library that has a function named
> uuid_is_null() which does the same and probably more efficient.
>
> So change btrfs_is_empty_uuid() to use uuid_is_null(), which is almost
> a directy replacement, it just wraps the necessary casting since our
> uuid types are u8 arrays while the uuid kernel library uses the uuid_t
> type, which is just a typedef of an u8 array of 16 elements as well.
>
> Also since the function is now to trivial, make it a static inline
> function in fs.h.
>
> Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/fs.c | 9 ---------
>   fs/btrfs/fs.h | 5 ++++-
>   2 files changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
> index 06a863252a85..09cfb43580cb 100644
> --- a/fs/btrfs/fs.c
> +++ b/fs/btrfs/fs.c
> @@ -55,15 +55,6 @@ size_t __attribute_const__ btrfs_get_num_csums(void)
>   	return ARRAY_SIZE(btrfs_csums);
>   }
>
> -bool __pure btrfs_is_empty_uuid(const u8 *uuid)
> -{
> -	for (int i =3D 0; i < BTRFS_UUID_SIZE; i++) {
> -		if (uuid[i] !=3D 0)
> -			return false;
> -	}
> -	return true;
> -}
> -
>   /*
>    * Start exclusive operation @type, return true on success.
>    */
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 1113646374f3..58e6b4b953f1 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -996,7 +996,10 @@ const char *btrfs_super_csum_name(u16 csum_type);
>   const char *btrfs_super_csum_driver(u16 csum_type);
>   size_t __attribute_const__ btrfs_get_num_csums(void);
>
> -bool __pure btrfs_is_empty_uuid(const u8 *uuid);
> +static inline bool btrfs_is_empty_uuid(const u8 *uuid)
> +{
> +	return uuid_is_null((const uuid_t *)uuid);
> +}
>
>   /* Compatibility and incompatibility defines */
>   void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,


