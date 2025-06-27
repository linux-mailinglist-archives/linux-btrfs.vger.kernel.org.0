Return-Path: <linux-btrfs+bounces-15038-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92842AEB566
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 12:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C361E3A7098
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 10:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B8A2980DA;
	Fri, 27 Jun 2025 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="rUkvluBT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB3C2980A5
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021482; cv=none; b=dAvBK7TiE8i0geQiMyBpfmoKRfGxNKQ89A0k28PSUwjt3SXoy0Jc+fysJEDHv75sJYKoLa87nTAXvwTy0v7UbbHWeD2ypDdsdYwyO65u157FceJRIKXJvviqgHr3sV60how/n4aNfD2Gc5VeKYxfSiz3tJ7rUbCHCBArdnz8vQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021482; c=relaxed/simple;
	bh=GoQXmGQPCYIIqs1NMH7mwhC/0I7s0Xc6tpCJGUhOOS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SBrShU+RqMVfPZemMD+lFpiALDkrciMf40UsjZ17qPpRfo1MirS3CLBSphiyvcCaVzRCbQprZ+K996KYTt1Jz+yXys37tyMN80uhspmB4zGjLSoIrrrF6cNaZU0DUcnPyR9wLcftCJbJU7izPA5zgNAAwrBXuk8r7P573bmWg5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=rUkvluBT; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751021472; x=1751626272; i=quwenruo.btrfs@gmx.com;
	bh=Z19rh6X/JiBfE3UHMge5ag64hvDRyMUsK574XzkW2O4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rUkvluBT/eQDXx9g/rHyVzyIJQFhdxC1n5giCkatkhCZnvwHKEpgGTG5rJP5e+pZ
	 Bfyp04YLaZGpw1pNv36bsllMYNNDVcgYEZJBmmQ7cpoIvONVGBt+qPnsBYMSsA/TZ
	 PKBz3HtKNL0b3UnEjmfhH6SMhJi5LkQf0LvuiKbH3XIaIti32SPDhkRQh8bYoeOt4
	 KyVlSWnD2gkPSR9VEVF0XfNGs7vshVASIUZzB1jB/g8wxSvnlAv9h+oCzGeYl0fc4
	 H40kHX4UZE2ci3GYOI0+U7jLbQMX7PDLcAVsXHsiXHvRThWOtYDanbL//dYHOsvzJ
	 8vv87lKowRuRvZNO0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0X8u-1uhFjX22ei-0147t6; Fri, 27
 Jun 2025 12:51:12 +0200
Message-ID: <2342e2ff-916c-45f8-9ac0-cb7b701e588e@gmx.com>
Date: Fri, 27 Jun 2025 20:21:08 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] btrfs: fix iteration of extrefs during log replay
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1750709410.git.fdmanana@suse.com>
 <894622cd2bfaf3d1871f2d88ba0a212e7661e136.1750709410.git.fdmanana@suse.com>
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
In-Reply-To: <894622cd2bfaf3d1871f2d88ba0a212e7661e136.1750709410.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AaJnyTIxDUSnsms1F3KolAAXw3dNPI+0PW99YjHhSWfwbaJSYQx
 q2yA1I22/EqZ5uCM2Q4Cc/AvPavOX4XNZTDIcCo04+4ikN9lG68gO2iGM4AoEy8PuQD7hXM
 QtXOsixCamaUBiv4D1Q6wPDZA3jdMSFEhvj/Xt3+F8a5WaixpPdEYPYSa8NnN1a1dXBKh1G
 mC5lVfZ8ZVpB7ozjaxooQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GpUJirWzp84=;GWWGn3AENk/nmowyH3u+G6q29oM
 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



=E5=9C=A8 2025/6/25 00:12, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> At __inode_add_ref() when processing extrefs, if we jump into the next
> label he have an undefined value of victim_name.len, since we haven't

         ^^ he?

Otherwise looks good to me.

I'll give a reviewed-by to the cover-letter to avoid bombarding the=20
mailing list.

Thanks,
Qu

> initialized it before we did the goto. This results in an invalid memory
> access in the next iteration of the loop since victim_name.len was not
> initialized to the length of the name of the current extref.
>=20
> Fix this by initializing victim_name.len with the current extref's name
> length.
>=20
> Fixes: e43eec81c516 ("btrfs: use struct qstr instead of name and namelen=
 pairs")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/tree-log.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 08948803c857..e862deaf27da 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -1146,13 +1146,13 @@ static inline int __add_inode_ref(struct btrfs_t=
rans_handle *trans,
>   			struct fscrypt_str victim_name;
>  =20
>   			extref =3D (struct btrfs_inode_extref *)(base + cur_offset);
> +			victim_name.len =3D btrfs_inode_extref_name_len(leaf, extref);
>  =20
>   			if (btrfs_inode_extref_parent(leaf, extref) !=3D parent_objectid)
>   				goto next;
>  =20
>   			ret =3D read_alloc_one_name(leaf, &extref->name,
> -				 btrfs_inode_extref_name_len(leaf, extref),
> -				 &victim_name);
> +						  victim_name.len, &victim_name);
>   			if (ret)
>   				return ret;
>  =20


