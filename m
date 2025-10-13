Return-Path: <linux-btrfs+bounces-17739-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2719BD649F
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 22:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F074318A21C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 20:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE40D2EFD88;
	Mon, 13 Oct 2025 20:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jhVjx+er"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33FB2EF654
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 20:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388778; cv=none; b=SeXtZnpEN4kJZ14Ial3F/nsxZGxVVAQWZLpIp316R2dP18MZf6fFAwvAgumyc1vo3r3oTwJ+vQ80BJbZbUY9rWkFlLjDkByB2BfUyCZ6S1iMpkIBhKFhkBGVZH2i0rM4hXd9Euisa0PhJ2n+NoOE3tEwGPH8kY+Ob/0lYEfgqAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388778; c=relaxed/simple;
	bh=N/xxmu7c1p53aLRKDk4LqlBOaztbXJiK3M2bh61jmm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NepT40e8ZJLBw8F7/n+fTVbvY21LqwghdEq+r9Mv7e2ZrYUgZOw0pvor1ZxC+14UZgBwKzM5r1mVbDBxspAgkIN5yNt1HWmAt8xosbR3vuDCSCLDhqLJ9FVn+9f0XsJa0lBRTobznhX8XU2L7DslQPZMTV0JmlOm0ey4klTI2H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jhVjx+er; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760388771; x=1760993571; i=quwenruo.btrfs@gmx.com;
	bh=wrB3unFJnUc0iBCIJEQN/wOk73WPsvsVVTWRuaZd1k0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jhVjx+erlkru/PDYKuSSgCAUTfC8CJ+sytFXX0Hl5XzcdW+K3Hl6mIusxqFFHiGQ
	 a1Z/93mS4da0M4WtgCxkP5ZQx2BjKs3PaFeqd63Ugpydnj7WJncSCuoZGAhzXZRCc
	 88Arpt6QqHbFYwSifYjLFQJZJ1hU+IuXVkmD0nb3GXnkj6jLrFAoTbUX/Bw5qj/XH
	 +zPXIGofjZZ+/POzNJ8x5Gg+zHAI3TQENo+87cBCGAdPfFTKLd+63VlSs8E3Alujc
	 jOazVYl9shVvd0dwB7kCwAqGfSx23hztI4CqAa62qoQgBN1+7ZBuGgHDxn2SxnpVw
	 D0eUdnFr3P+QIOKFog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNKhm-1utW7U2DsY-00RzKl; Mon, 13
 Oct 2025 22:52:51 +0200
Message-ID: <f23cdbee-295e-4e17-8311-fb875309def6@gmx.com>
Date: Tue, 14 Oct 2025 07:22:48 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] btrfs: consistently round up or down i_size in
 btrfs_truncate()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1760356778.git.fdmanana@suse.com>
 <04e60398648115da47d20f9741c1a3668a18092a.1760356778.git.fdmanana@suse.com>
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
In-Reply-To: <04e60398648115da47d20f9741c1a3668a18092a.1760356778.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M06UJxHe8qetnexNFvVBFzg0P2KfiDDjt2kBvXaH21CHDfxFEIe
 wzLQWyHGMwIqDKDvqsrp+7ZNxGUNYy0yWnLEeZRHoy8E0LfAeGj4qvEGv8EDX2hG/13nTnu
 SUrlawxNBxneyCzyaJoMLKYpvcx4IPhChtaGH/rIhqNfkH7gCJBrKZYUwjzyR9nlMKukEkI
 anq4Zv7+ISAV22LX2Kq0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uyMLaDKqTzA=;PSVpcS5Q2ZFF5vh4p1Ojv77F7Ei
 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
 Tp6FmOPWSuiXN46IxDYg4P1sIk=



=E5=9C=A8 2025/10/13 22:35, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> We're using different ways to round down the i_size by sector size, one
> with a bitwise and with a negated mask and another with ALIGN_DOWN(), an=
d
> using ALIGN() to round up.
>=20
> Replace these uses with the round_down() and round_up() macros which hav=
e
> have names that make it clear the direction of the rounding (unlike the
> ALIGN() macro) and getting rid of the bitwise and, negated mask and loca=
l
> variable for the mask.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ac2fd589697d..4a4cb91b7586 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7649,12 +7649,12 @@ static int btrfs_truncate(struct btrfs_inode *in=
ode, bool skip_writeback)
>   	struct btrfs_block_rsv rsv;
>   	int ret;
>   	struct btrfs_trans_handle *trans;
> -	u64 mask =3D fs_info->sectorsize - 1;
>   	const u64 min_size =3D btrfs_calc_metadata_size(fs_info, 1);
>  =20
>   	if (!skip_writeback) {
>   		ret =3D btrfs_wait_ordered_range(inode,
> -					       inode->vfs_inode.i_size & (~mask),
> +					       round_down(inode->vfs_inode.i_size,
> +							  fs_info->sectorsize),
>   					       (u64)-1);
>   		if (ret)
>   			return ret;
> @@ -7720,7 +7720,7 @@ static int btrfs_truncate(struct btrfs_inode *inod=
e, bool skip_writeback)
>   	while (1) {
>   		struct extent_state *cached_state =3D NULL;
>   		const u64 new_size =3D inode->vfs_inode.i_size;
> -		const u64 lock_start =3D ALIGN_DOWN(new_size, fs_info->sectorsize);
> +		const u64 lock_start =3D round_down(new_size, fs_info->sectorsize);
>  =20
>   		control.new_size =3D new_size;
>   		btrfs_lock_extent(&inode->io_tree, lock_start, (u64)-1, &cached_stat=
e);
> @@ -7730,7 +7730,7 @@ static int btrfs_truncate(struct btrfs_inode *inod=
e, bool skip_writeback)
>   		 * block of the extent just the way it is.
>   		 */
>   		btrfs_drop_extent_map_range(inode,
> -					    ALIGN(new_size, fs_info->sectorsize),
> +					    round_up(new_size, fs_info->sectorsize),
>   					    (u64)-1, false);
>  =20
>   		ret =3D btrfs_truncate_inode_items(trans, root, &control);


