Return-Path: <linux-btrfs+bounces-4502-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 965B68AFB32
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 23:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5091028191A
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 21:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5912014388C;
	Tue, 23 Apr 2024 21:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="W79avaCH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1491720B3E
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Apr 2024 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713909324; cv=none; b=hNpwtjSeX7xjckR7BrUsDdyH7NHy377dyIypaHSw1hmKWVWnpWjl6fLSiB+luw91pWAc7pFw1t4RlWndheNP4Cn+cY+hY4SYIoJ5ZyfQOJRC2dW569SFqMzs41++39xmRsUmei5GdRwvy6AxlaE7WSAB5KxJ0A3byw3QeZ4Dd8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713909324; c=relaxed/simple;
	bh=ZhOCZQ6jqKz/780JoVind3EkxSBo67j8Bo1a4ZsiK68=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q1cMPjL2E2V99ev+mUtsR0xKshWCzMHspVQQ1BvOZ6OVPB9oponz0ZZmC/zgiGXN4rnAzpKsbNhL1lNmZWikG95b5DQ6gdgjXpWFhNmzZ0N4kUDdcqLbTX2KCEzTO/aNOXlKkUbxHzu+EyMqSuJCrnenHPVMrobQimWq5dC8S/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=W79avaCH; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1713909316; x=1714514116; i=quwenruo.btrfs@gmx.com;
	bh=Bszyj7oJAUI7JgMl0l6SEm9ej2/vYLRSWy9uESLVQd4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=W79avaCHBWtgd0qhoJSun2/ALut/A+0XRdf9sJiLviTd9ublgcC1PECCDh4oJDQg
	 cuKQOf10RX4Ln8+oCRurfOuSuRzp8yhNxfxL2qyprmcXBWlBuab2XSRjvF3y/SGCp
	 jlvO6kAc+H7tqWECDFrqRl2vsz29Tpf8mcLtqsVg16DvO2h2fukcsGUkEedJc9lP1
	 XZDc30MIu/CxGRl89t2TL40t0HjhipolHfsPpuG1a6xmC1F/kRJif/e5ESffdVTrM
	 NpsdVTxYSwXzhHjeVu5wKF6ZbVoqioWKyydmpyvus7Ig27/qPm7QxEF6Zrz+IScII
	 PY8PAplrPa1vb8+2lQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MaJ3n-1sE0gw3cSj-00WGvs; Tue, 23
 Apr 2024 23:55:16 +0200
Message-ID: <79a004f4-952c-4382-ad75-e1b669df5ddc@gmx.com>
Date: Wed, 24 Apr 2024 07:25:11 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] btrfs: don't do find_extent_buffer in do_walk_down
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1713550368.git.josef@toxicpanda.com>
 <c30d22dcf2f6418a803ea2e0066545566829afa1.1713550368.git.josef@toxicpanda.com>
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
In-Reply-To: <c30d22dcf2f6418a803ea2e0066545566829afa1.1713550368.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D3sE3alI+4LoQZDbkb5NG22bD1MrcpReRD+mxUHYyzJhsN51qp8
 ZW0sZS0fJX4Bb6qrace1R3yCy0PgrNSdSkV6AP+Ta6LagHWWgZPW5iyi/f9TpJK7IltEIQn
 lHfUscK+xKBwS2OCpYwpJlBYJxx9YWxFwLuZXALbG2Il9nTJTG8mrfpHaJ4M7CbTu5b1eHJ
 3U7+7Wx8nwUPxBDEheTAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Vapp+P1pdFI=;rCsvZ/gyyzUxcumuHCAj5JAlV3p
 3nPo4qd7PvWQLZxMVYboF4IAfNH0zNI6F1+sxymPQBRO6VVJ7zJ+L8V6LA1K7yWKWUgzQc1HF
 4LZvd/XJrjuc+thhUKCSGL0kmW4hUw9fPaS9zwDnISSVshaXnJWT9C+w/th9RLAgRCxZjR426
 KFk4fjDQIlnkOlLCizxSOucVS44DjCQbpIojdlAmVNVGlETiWys1vUooX407ZQGFJTS7bIErE
 4jMt9nM+mOQftK9rJ68N2L6si6O6aZRo+MAL3yAPOqTlBJe+K3TYEIznM9hVTu34p5TnDaOFO
 alsxJuICxqCHv/p4khnrRdjuN7EFtt0GVMEnvkI/CH0QBzhyNlTuizoawPg2Lut+TqWSOO5mX
 qFR0t+1lwtccbL9N4RzPSrm7ChHB+mVgQRc2TKYdqvNk0u6UV8ddP01gRRGTV4NbfQj/ujk8i
 KlylTN6P1QlmYP09K5XiA6znuPjfhGafYTHHh1UIAPEunIdFn0qsDZcSCdAdJpuE+Dpi3YXTE
 zM04wioWvNEjQAiNVEkJJrcIeZtywfY872Ya+wc2VuK7fLNYp+qqZlsjbOB20FY3Euv/mP4ep
 /oiP/6F4479P7+57vWpwQj9X2Onxx7IKeNNn2NrEKL7vKpj/x2XmBZWy39Jl5wQ+SHDUnX9Ry
 oxsWclxaDDm7zanYbaSqJ50NIzbJlq3px2fluDhkX+esBgWB58qXW93WFfhRiJYjxp0uqsUM6
 UPrEEhx2qr9PjBQYKDdc1LkjbH7K4nhSDbQ2PctkY2UbSF17ya1w7uHClz9wYYFui9kpH2ACU
 JlanvvSoeTsZC3BsryY6Qkgz9fbOHFa3CXYO5xw+xQxLE=



=E5=9C=A8 2024/4/20 03:46, Josef Bacik =E5=86=99=E9=81=93:
> We do find_extent_buffer(), and then if we don't find the eb in cache we
> call btrfs_find_create_tree_block(), which calls find_extent_buffer()
> first and then allocates the extent buffer.
>
> The reason we're doing this is because if we don't find the extent
> buffer in cache we set reada =3D 1.  However this doesn't matter, becaus=
e
> lower down we only trigger reada if !btrfs_buffer_uptodate(eb), which is
> what the case would be if we didn't find the extent buffer in cache and
> had to allocate it.
>
> Clean this up to simply call btrfs_find_create_tree_block(), and then
> use the fact that we're having to read the extent buffer off of disk to
> go ahead and kick off readahead.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent-tree.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 023920d0d971..64bb8c69e57a 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5434,7 +5434,6 @@ static noinline int do_walk_down(struct btrfs_tran=
s_handle *trans,
>   	struct btrfs_key key;
>   	struct extent_buffer *next;
>   	int level =3D wc->level;
> -	int reada =3D 0;
>   	int ret =3D 0;
>   	bool need_account =3D false;
>
> @@ -5460,14 +5459,11 @@ static noinline int do_walk_down(struct btrfs_tr=
ans_handle *trans,
>   	btrfs_node_key_to_cpu(path->nodes[level], &check.first_key,
>   			      path->slots[level]);
>
> -	next =3D find_extent_buffer(fs_info, bytenr);
> -	if (!next) {
> -		next =3D btrfs_find_create_tree_block(fs_info, bytenr,
> -				btrfs_root_id(root), level - 1);
> -		if (IS_ERR(next))
> -			return PTR_ERR(next);
> -		reada =3D 1;
> -	}
> +	next =3D btrfs_find_create_tree_block(fs_info, bytenr,
> +					    btrfs_root_id(root), level - 1);
> +	if (IS_ERR(next))
> +		return PTR_ERR(next);
> +
>   	btrfs_tree_lock(next);
>
>   	ret =3D btrfs_lookup_extent_info(trans, fs_info, bytenr, level - 1, 1=
,
> @@ -5518,7 +5514,7 @@ static noinline int do_walk_down(struct btrfs_tran=
s_handle *trans,
>   	}
>
>   	if (!next) {
> -		if (reada && level =3D=3D 1)
> +		if (level =3D=3D 1)
>   			reada_walk_down(trans, root, wc, path);
>   		next =3D read_tree_block(fs_info, bytenr, &check);
>   		if (IS_ERR(next)) {

