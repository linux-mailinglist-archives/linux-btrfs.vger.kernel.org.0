Return-Path: <linux-btrfs+bounces-15012-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56EDAEA999
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 00:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54A257AB59F
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 22:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E3F26771B;
	Thu, 26 Jun 2025 22:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="IteS52sB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B151DE3DC
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 22:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976767; cv=none; b=BcqXBeP/QnP7SwMd37Z4WFlAl8nB6znbESLjUGY97wEHi495rT/vFKCd0fODt+/rt7Lo4NrFwQ96hnt1SmWOdueizVUG85reRJ3iWD9N/unxXZO/TShszs7OW+o0tKGfva9PJju2efL1MVJ9azq/L6/x4FrQr/H3/VGYXWX/i/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976767; c=relaxed/simple;
	bh=wiSSHd/M/xm1OMBPjvST0yc8Z4xGi3uKlx/yxxikTSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L7jyJwr4pjhMyPMko5bBUXBUWZ1xpU2epC/Xo/VR3JpV1lF++qZA3rInn2u5AQIBTVNsKbziuh1Z8ea4yYaL4ab5yb2HNYxBLCdSdLiOoNoWaEA+W+72anUbJ5YvA1uv+pJErj5jB0GMYOzzF/Kzta1N2tZGHls8Nflf8Cpf+4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=IteS52sB; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1750976759; x=1751581559; i=quwenruo.btrfs@gmx.com;
	bh=rghognpg6xlbKJG6YqaeUIRttwVRbafT5RPz6hvRjQo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IteS52sBPX/P2qUGdPYUweFLAOP+63qYHGM5vonyw8ckDjLkFDFnBNRKDIZN5IZN
	 GzpHh620AIySCulyZ4nhb0sfqfT/d5TplzN35uygwyciQJI/lyBsG6cNxE5aTRwGS
	 D8UPjf6Tke4R44If4gsbSSD/5iy/8Dd3Ci/he/U+9pYl3tti0ZdBt4Lw8uuLbdHY3
	 YxPn9cK7JVdJ4/hkEDZG7/A5pSpOTbtGjr1efWZJihjBAZCLNm/FgAZ0OypJx0hUP
	 s2PkixpuxubUT0JWqD4MLHmrJTgQavdSTBDakgxJ/TeqsIgzbjIzP72fjHCx/O0Gs
	 hR0uLDhbx30LLjf5AQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MryTF-1v73nX0MYX-00hvzD; Fri, 27
 Jun 2025 00:25:58 +0200
Message-ID: <40d97749-9d9d-4a9a-a033-7766e64e785e@gmx.com>
Date: Fri, 27 Jun 2025 07:55:55 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: qgroup: avoid memory allocation if qgroups are
 not enabled
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <b0e317f51f01fd88c32fd14f6bd8ea40b88943fb.1750954008.git.fdmanana@suse.com>
 <bd2bcda4d19bc931752ffa7b1730c5e5fa9d7b48.1750955238.git.fdmanana@suse.com>
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
In-Reply-To: <bd2bcda4d19bc931752ffa7b1730c5e5fa9d7b48.1750955238.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TL/9enWPVIjIxNrZDwlEC08czAZvwXrvm1P0F6LMgZNIBejV75z
 izggfrAwymAgUFC+6xzHvxdPnqix+t1mUPc9XaTPEwnihmu7Vzs37A7QxtKS8a6FStab93Q
 YERRP24El7NED5xQB0bYnidGBthVO+scWOiWGp+O8Sggcs6JYtuKDgj9ck7d9YXUjZcBJuX
 icc+lT7/pHT8R/QUb9GYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6NrJVDd1IiY=;LckzmTKCEigimUzUpfRnPEbsWrO
 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



=E5=9C=A8 2025/6/27 01:59, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> At btrfs_qgroup_inherit() we allocate a qgroup record even if qgroups ar=
e
> not enabled, which is unnecessary overhead and can result in subvolume
> and snapshot creation to fail with -ENOMEM, as create_subvol() calls thi=
s
> function.
>=20
> Improve on this by making btrfs_qgroup_inherit() check if qgroups are
> enabled earlier and return if they are not, avoiding the unnecessary
> memory allocation and taking some locks.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu


> ---
>=20
> V2: Update changelog, the problem is at the ioctl level and not at
>      snapshot creation during transaction commits.
>=20
>   fs/btrfs/qgroup.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index afc9a2707129..b83d9534adae 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3328,6 +3328,9 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle=
 *trans, u64 srcid,
>   	u32 level_size =3D 0;
>   	u64 nums;
>  =20
> +	if (!btrfs_qgroup_enabled(fs_info))
> +		return 0;
> +
>   	prealloc =3D kzalloc(sizeof(*prealloc), GFP_NOFS);
>   	if (!prealloc)
>   		return -ENOMEM;
> @@ -3351,8 +3354,6 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle=
 *trans, u64 srcid,
>  =20
>   	if (!committing)
>   		mutex_lock(&fs_info->qgroup_ioctl_lock);
> -	if (!btrfs_qgroup_enabled(fs_info))
> -		goto out;
>  =20
>   	quota_root =3D fs_info->quota_root;
>   	if (!quota_root) {


