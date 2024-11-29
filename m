Return-Path: <linux-btrfs+bounces-9975-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C96EB9DECBB
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 21:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB5428272A
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 20:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885B115B547;
	Fri, 29 Nov 2024 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="JsTP3Foy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645B11465BA
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732912675; cv=none; b=Cot+8emnJgyJb8izP8YW+qtD3rZvqd7F9w9F4NG1u3+ZRLemSoTJGYfx2XK0DanpvaOu9rO5ebRm066Qg+caXBkZ36ZTQ4EhykHZd2QWTwR2CxZuWym5zyLF6VBTU+Xiv5Lobt/u+D+OS2bLKEEO/eqctMdDaE1kMEHvpdAnah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732912675; c=relaxed/simple;
	bh=U6MZe6Ya6KjAGTn/vsXJ53SlFX1gtU6f8sWuiamKq/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLhqs5eWLuWdls0FXE/1qwrSJm6c7s3D9YNVbvFWjlNdD75IJJwER8KnQv2NZPMV/2/QiTUOycVcgVbEzYsRXdq1KRJSBAsTiA1Gv2r4aJKz+6iKONGYE1oFR0CnUyICZnBsvDYwabG+QEV90uo6jS0BcqtODb/nRLTtiOq+mLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=JsTP3Foy; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1732912664; x=1733517464; i=quwenruo.btrfs@gmx.com;
	bh=Ti9NqVRpRGA5f6YVwLqPIDqId1wIA3RqFpBHDBuJddM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JsTP3FoyeBNZaPJ39DINtMYtBqcLXY0pY367OOoGK/gxmn4rQ/DOYbQMDOS/DmH2
	 qeN7al7ZtJPyv69ZXT+wXiXHgkVKKBegXmm7Jd5N287HSbgojw6gpYo/ZZtppw0/5
	 NvX/dgdy9XsZ4MtGVisNieQYQF59+0J8v2tjTw0QthDePgjf7L6ZdWuoHKWLcxNPG
	 uA5VRmBy1EOEGk0VWLB+wc8IDR0hfxGi0wCwd6+iPFYdVaZ0eR6QjzcgIqcHqFL97
	 CSidOUlqkyRC+ZU7o3mpsrkvGV3sTEdmx5tYDi9Q4okO6ijXmMM1X0TUu4jj2Nw+5
	 aam6G97ajUS0UPQniQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ml6m4-1ty84p2pSe-00a7c1; Fri, 29
 Nov 2024 21:37:44 +0100
Message-ID: <8cbf6d19-4969-4a60-88d7-30842db789c7@gmx.com>
Date: Sat, 30 Nov 2024 07:07:40 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: don't BUG_ON() in btrfs_drop_extents()
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <be18a9fcfa768add6a23e3dee5dfcce55b0814f5.1732812639.git.jth@kernel.org>
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
In-Reply-To: <be18a9fcfa768add6a23e3dee5dfcce55b0814f5.1732812639.git.jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fb0lkJ4oYqtZ96ychKsOaxlXMwEftayGYGqUJ8q1V9YTycxR2/3
 +I9FfPM/plAmQrY4h5vf58bJKTaBVyhDlTH8F+uZ5ZBxcllXoC0E20squUvm6PaSe6SNNfn
 mih5wa0xLBef88pZjiJInpSU/2LlHIblE6ghxIu2If0i7pVKRAbwdsj86RZVk2T0mWz86PB
 V85Y3gxvHyrss7h2QLedQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2m/qs1Uq5lA=;22OVB0Rn/u5UJy4lZ2/PFpaiTbR
 gcE8KmjF/NtGVsiCfKSU9WkMQGDq4/2X+r8ARuSwoCTN+fGQX4eK2YBHVMl0cZS3HA0Vpsxe9
 SEpo1K3bmm6f5avttvcnGnYBGGDPw8hNq+1NP7RwXebliBkbwLgpzYkG59Kdq7tJPIyaCWxsI
 nbjOCIOtIVx1PUYHmzPicgoTz/jTT609vowYqo9Q6HnFW5Id+gY1gB+oKWV4uNMt9NtlGkLo9
 WkuJ9uUhYCkbZFD1gTqpd6SVY9nw++WsdeH1Rs9dyTyjoJsJPqcLdvvdg9S7zp+qGQm+WhUPe
 eH8ZIC+Le2WMYTUGxMzRGPbVxTEtovfGdZrHChxuzK/9aCUgn+IUH+/wYVITjbJkN2qMmbW7Q
 KO0J0kqRugYup0fbldECqqSs8XAbtvqdtY9BfSd5Q3V7PEwiyHLo/0qH9aZqwEoMVPKIvTSEK
 4KDnex1HDOQnqpiGguFp0gseqRLAvX0073VG56bYDXVV9cm9x5/IgQBbxY7gLFZI3ZOnoelKD
 1lBPaBt8+TUvh7ji2fXTZ/xelyIo/ATqETeJ9rjVpdPwI9RsuqxdNmwZdTyFN1rPMaUgz6ha5
 hznkB9LPKuwNi/Wki46O/cwFAfyVb1HMG2mI7VbJceBHlpJRCz1ByKITQGcZ3rKqLU8lp5KaL
 HbL0lCZDYt5ce0oNQK+N80OpZlhXuxWm9M2yRTBQEouArG4QqWsMka9u413x2R8dewtMWlxu4
 wYMkJJZ2dpS14aVDCtBK342zyA+zshk4/sBLLotHAuNiR64Y1WQiAWD9Y+2vzemV5/SwPXwVM
 wX2hp/+YdF/Wo+XsaOdCS+YEZJQL5ujYJL+eQ++v0MQxX9h83pHQqcRodmxUo8bVQzcB3Cb2K
 GutvAFRrmWaMWwGHnWNHn76pLn9yCB9hy7Qwt/3wrw8re62IK4KxlqlmZeS871pU57Qsl+329
 PM4pMGLF9gYdVZfjHEBWH+BtbdWNm1BVTJ6u5iVmtmmOPsJi+2lssQZaddRphgqjN4uWO6Nz+
 Ozl1740R4pya2Nm0eYNxNj4PZ85OS+sRDfjjpmHAChREuaA9kEhJg2FQHIIsUw4AqmWV5ehL8
 DXJGL3k5PheecsNS2z7zhLnOJ4XW3g



=E5=9C=A8 2024/11/29 23:41, Johannes Thumshirn =E5=86=99=E9=81=93:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> btrfs_drop_extents() calls BUG_ON() in case the counter of to be deleted
> extents is greater than 0. But all of these code paths can handle errors=
,
> so there's no need to crash the kernel. Instead WARN() that the conditio=
n
> has been met and gracefully bail out.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> Changes to v1:
> - Fix spelling error in commit message
> - Change ASSERT() to WARN_ON()
> - Take care of the other BUG_ON() cases as well
>
> Link to v1:
> - https://lore.kernel.org/linux-btrfs/20241128093428.21485-1-jth@kernel.=
org
> ---
>   fs/btrfs/file.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index fbb753300071..f70ce6c65d12 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -245,7 +245,10 @@ int btrfs_drop_extents(struct btrfs_trans_handle *t=
rans,
>   next_slot:
>   		leaf =3D path->nodes[0];
>   		if (path->slots[0] >=3D btrfs_header_nritems(leaf)) {
> -			BUG_ON(del_nr > 0);
> +			if (WARN_ON(del_nr > 0)) {
> +				ret =3D -EINVAL;
> +				break;
> +			}
>   			ret =3D btrfs_next_leaf(root, path);
>   			if (ret < 0)
>   				break;
> @@ -321,7 +324,10 @@ int btrfs_drop_extents(struct btrfs_trans_handle *t=
rans,
>   		 *  | -------- extent -------- |
>   		 */
>   		if (args->start > key.offset && args->end < extent_end) {
> -			BUG_ON(del_nr > 0);
> +			if (WARN_ON(del_nr > 0)) {
> +				ret =3D -EINVAL;

Do we also want to dump the leaf and output a more readable error message?

Just like what we did inside
lookup_inlin_extent_backref()/update_inline_extent_backref()/insert_inline=
_extent_backref()/__btrfs_free_extent()/...?

Thanks,
Qu

> +				break;
> +			}
>   			if (extent_type =3D=3D BTRFS_FILE_EXTENT_INLINE) {
>   				ret =3D -EOPNOTSUPP;
>   				break;
> @@ -409,7 +415,10 @@ int btrfs_drop_extents(struct btrfs_trans_handle *t=
rans,
>   		 *  | -------- extent -------- |
>   		 */
>   		if (args->start > key.offset && args->end >=3D extent_end) {
> -			BUG_ON(del_nr > 0);
> +			if (WARN_ON(del_nr > 0)) {
> +				ret =3D -EINVAL;
> +				break;
> +			}
>   			if (extent_type =3D=3D BTRFS_FILE_EXTENT_INLINE) {
>   				ret =3D -EOPNOTSUPP;
>   				break;
> @@ -437,7 +446,10 @@ int btrfs_drop_extents(struct btrfs_trans_handle *t=
rans,
>   				del_slot =3D path->slots[0];
>   				del_nr =3D 1;
>   			} else {
> -				BUG_ON(del_slot + del_nr !=3D path->slots[0]);
> +				if (WARN_ON(del_slot + del_nr !=3D path->slots[0])) {
> +					ret =3D -EINVAL;
> +					break;
> +				}
>   				del_nr++;
>   			}
>


