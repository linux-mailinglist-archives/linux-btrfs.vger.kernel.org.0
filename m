Return-Path: <linux-btrfs+bounces-16741-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A285EB4A09D
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 06:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BFF21B26DA8
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 04:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968B22E1747;
	Tue,  9 Sep 2025 04:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="MVHuW2MK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93BB22CBC6
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Sep 2025 04:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757391790; cv=none; b=u2NsyMgawgN+wsi28YEV/PEYF3aNT7EQ4hSZmglcagCANLBSdWjFEZVWCeLRF7qt1V8aBDb+HpI0R9Ft7LWthR0bycsfYreaazPE+t7sSZwKCRlX3w2vEkvOfTA7cBCsvYfJBmlmRYPaihMIg6UcIlcdaXlImx2ftEqBa/AJU38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757391790; c=relaxed/simple;
	bh=VQxhQ8zy5+htV18jz9ENCts8KmnrQD2Oe9EfQ02Y3q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H4ub/HdxOFLAGScMdEmWWJfgRSZP3bsEItr591NLZqFfji6R7PEZL7pCoFBBRmnbHNkzfx6eCeigNT090VUlE2lL0/INHyLgdBvtXddb6E5OhrwmwFmBFF28GXeGEwV+O4Muul3bULSuKqmzIY186T4/PYvLCLJIyYaGC05rVoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=MVHuW2MK; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1757391782; x=1757996582; i=quwenruo.btrfs@gmx.com;
	bh=JSpt5Me8OUCo3tMka1ljhT9yBJGFVtAquYV4L6gfdJo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MVHuW2MKGCy+vH9u2GxJTSLZ7RqZVsTBhlAcu842LBT6WQI/HgGnqU14Z0q+Ly4V
	 riSo/LLHRozn106Rc7IYMC/N1PsAH1lPXqgjPR82m7hgLVX5js4BJpzZAOZa7Ua4r
	 OEbZ93WBsoUTb2vMFWISK0lhKqhe8Jukgv/PTEK+Mb9dMiceXXxDOY7N08EEUHEbH
	 iusW4wSNB8b6hW01URZVIvsY3YZy2WfPgnGb28Nsr2GUPZcCUdMG+MuvWQ2QK0Wom
	 6VEaxciLgQHVk3LRn38Phc8sa6js0gpMRfftMzW8X23N29snENO0PLT95UxXc/Y+B
	 jw4x52tHa73qmAZbAA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MGQjH-1uf2Ut0EGb-006iWQ; Tue, 09
 Sep 2025 06:23:02 +0200
Message-ID: <e7d56dc2-5963-4e44-9877-978914700a37@gmx.com>
Date: Tue, 9 Sep 2025 13:52:59 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: send: index backref cache by node number instead
 of by sector number
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <38a42e9d2d1ebd8f94f9f68385095854bc05a086.1757332226.git.fdmanana@suse.com>
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
In-Reply-To: <38a42e9d2d1ebd8f94f9f68385095854bc05a086.1757332226.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AI64zN1Kk7DFV9H6Z63bgu7MqEqPihu+ZhFR8syDc37lhrE6jVD
 w0ZsA2CvUGqGB4hHEKxIjBBXZhfjxey6irjmbAxFagRSCq7Dhs6erqJGU4Z3n4rkLib3JOB
 JD2b1mj44SdiEF7nV9HUPbwGDllfqlav5MuVLvQoI6QtV1kuuQs4NkMOu/jloC9BqsAAQJ/
 No0hvxERfb2NBhOxlcgOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:clGE6emCykk=;v+aq2/7FLvfNZbqdglvnJ81ZFts
 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
 8lu5J0crY6STZ/Bo=



=E5=9C=A8 2025/9/8 21:35, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> We now have a nodesize_bits member in fs_info so we can index an extent
> buffer in the backref cache by node number instead of by sector number.
> While this allows for a denser index space with the possibility of using
> less maple tree nodes, in practice it's unlikely to hit such benefits
> since we currently limit the maximum number of keys in the cache to 128,
> so unless all extent buffers are contiguous we are unlikely to see a
> memory usage reduction in the backing maple tree due to less nodes.
> Nevertheless it doesn't cost anything to index by node number and it's
> more logical.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/send.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index c5771df3a2c7..32653fc44a75 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -1388,7 +1388,7 @@ static bool lookup_backref_cache(u64 leaf_bytenr, =
void *ctx,
>   	struct backref_ctx *bctx =3D ctx;
>   	struct send_ctx *sctx =3D bctx->sctx;
>   	struct btrfs_fs_info *fs_info =3D sctx->send_root->fs_info;
> -	const u64 key =3D leaf_bytenr >> fs_info->sectorsize_bits;
> +	const u64 key =3D leaf_bytenr >> fs_info->nodesize_bits;
>   	struct btrfs_lru_cache_entry *raw_entry;
>   	struct backref_cache_entry *entry;
>  =20
> @@ -1443,7 +1443,7 @@ static void store_backref_cache(u64 leaf_bytenr, c=
onst struct ulist *root_ids,
>   	if (!new_entry)
>   		return;
>  =20
> -	new_entry->entry.key =3D leaf_bytenr >> fs_info->sectorsize_bits;
> +	new_entry->entry.key =3D leaf_bytenr >> fs_info->nodesize_bits;
>   	new_entry->entry.gen =3D 0;
>   	new_entry->num_roots =3D 0;
>   	ULIST_ITER_INIT(&uiter);


