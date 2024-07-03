Return-Path: <linux-btrfs+bounces-6183-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 823DD926C5B
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 01:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3651C284F0B
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 23:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FD3194A63;
	Wed,  3 Jul 2024 23:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="LwgS5Q8l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156AC1DA313
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Jul 2024 23:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720048469; cv=none; b=My91WyEIOf2byE6aFCfa39nV8l6mejTxMKxeB8aGuOalD7V/4YPVE7tA/TYd3lHTT+hlvSMabOKfs5MC7zNGeF1ru8MYvNPu08zkCTSlAGRmTYdegw//P+3fEW+dHW76TJzzc7YusRzHwoC819KyZSbELTqxZOtPNXdB/NVpFas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720048469; c=relaxed/simple;
	bh=XOqUXMDmmD9zTHmbDIlZ4CozuasZjK9EMwvs9R+ljZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYRXKp8KowL1BpjPT6KmN4FJOQaQvksvdNqv3/Hvtn2fMbIteVrYEJIFPhR3vH7vr4A1k/exZFI/wBHOmrJ7Vruv7rQHL/fvJRwipztLklEKmXd+eqIZY4U3gTyXdVJZN+vX1Gr/mxo4ZQNf6ReuL9fYyy/3z+gUTaCUfoWyKVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=LwgS5Q8l; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720048462; x=1720653262; i=quwenruo.btrfs@gmx.com;
	bh=rnfPgx6u9C3criif+5IrZyu7po3v4TMc5a8hICiZIzk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LwgS5Q8lxqW7K563fPNQWowcZZmgwSDPriutMrlhM3smzJGvTAdExaZOS5nuqaTc
	 opQSuyRsPDgVgcklCHkg0v6lnwy8FJ90C7B8ErY14x2UN0WkbZnMZeqPCeHjeU7a4
	 T+pMFgE4JBc2LiARRhxC7o9bz/X5O3+Ed2jJChEfEF6ytieefP/NfS/nsUE0IyfaI
	 535uALIk2/QCrz2ToqjXUOZJA5rRe/GRDSAq5orqmSkzoJQxsrtuegbxb2h1um9uR
	 MGHrvweYG3h6Y0GjLkNeEDMpP9leSJ6m6ZaCkux8sdWY8fbDrsk5EqwKFpQ7D1Yx1
	 p+Uo+HVJzAgBPVSmCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M2f5Z-1sQVxC3SZz-00Ec0R; Thu, 04
 Jul 2024 01:14:22 +0200
Message-ID: <c3b8eb42-d557-40a9-97a4-f480dda0ac67@gmx.com>
Date: Thu, 4 Jul 2024 08:44:18 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: add rudimentary log checking
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <maharmstone@meta.com>
References: <20240703162925.493914-1-maharmstone@fb.com>
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
In-Reply-To: <20240703162925.493914-1-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+ofGeSkYf020lqVKC3aeKBYSSuZK9cue0VWQ4nBaBauxwsncGBN
 adhCX52UU5mp8UP+iQk0N4jnvc+D7pd6vtiprb6VzOEt7JLFkfJIUcHKN5+knI5t5IljFHX
 tngN84iow2Otmo4tb3wvNyV2bc/7ywWU3rZr7pqeoAMXHLAVTeCRF6Y9tsCddbMMWS/pJeo
 4ziQDS4c1fLhiGPPg1Bkw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UpV2hGoLriE=;81qAVYSV4+xL4ydZeZNaY4YVlJj
 UtsegiFb/tc2Tpcgb5szGHgxkDxyEr78708v+jbqVLqVcaO0boLadL/jDRPK0i9L2xRBfCjEM
 r2v+SWu81x2CtOrA39I+mAVd+Dadai86xiQQporZNORt1/lQHArtcuYC88aHzF27HeFyf+X5t
 1bz0Vk8caIcrhjKthP8838aMNmOY12yoTtxTZRTV2aJpos76rjWArZvZraeOcsTN4ehVOLpBp
 0pr1JNCoVVQ8vsrWJNTHgyycBjbBGTPRZddj7sHAr0JnGFEv4qGDpsFM6SXuXpdewm26M6tHw
 pl58GGgsiud23PTK0s4ceRI0cNl4dEIAVKK43pPaP3M5oOdyyEQd3eEU73N7oSkdO2SxN0pmK
 W2nIrb+lz5UcSY41RDItMLCiXZ8Zo+CsBZRSVFuu+I20hqWZ77pJdcfGhoVjx2I6fqJiRu00T
 jDxdJG4RnZEsKWVGEOmu9o5KGna74EnKZhOsVfQ+z2d8yNJI8s6lCG9DUx+YY32YeYPxkfzg9
 CRNqVRaFegIQ942LqXA+AQ45PvxqoY29+vzn48jY+NkyaTopyj2/pA1zaR2+FdbgLec6PiGL5
 cFvqgP3dJRy8MBWgV41dCCfxRlxSE5QRS3wtXDwK+IYnwFcGDkg4PG17Mp5tTKfFzU5DxG+a4
 RnUQ09pvtJiKbJSylB/RdJR6DXNKhykaN1G5j1FbEVd08PLMUeXhuMoz+M7DzzPR+ykMuX5t9
 WZjNswNN1+OCVBVsQiPyf0SnqF5xbuV2/O908Nh5JrgHqTFeImrUZdA6qEdFMB/dVhJw51/wv
 4pyKTNbDI+lq6PkWWwPAy6jM8IiE4DZ3CbFBLjU0mfQa0=



=E5=9C=A8 2024/7/4 01:58, Mark Harmstone =E5=86=99=E9=81=93:
> From: Mark Harmstone <maharmstone@meta.com>
>
> Currently the transaction log is more or less ignored by btrfs check,

By "transaction log" did you mean log tree?

> meaning that it's possible for a FS with a corrupt log to pass btrfs
> check, but be immediately corrupted by the kernel when it's mounted.

Firstly, if kernel can really corrupt the fs with such corrupted log (I
mean not just csum mismatch, but metadata level corruption), then it's a
kernel bug and we need to first fix it.

The expected behavior is, kernel itself should not generate such
corrupted log tree.
Also the kernel should reject such corrupted log tree.

Did you hit such problem (missing csum or bad inodes etc) in real world?

[...]> +		if (key.objectid =3D=3D BTRFS_TREE_LOG_OBJECTID &&
> +		    key.type =3D=3D BTRFS_ROOT_ITEM_KEY &&
> +		    fs_root_objectid(key.offset)) {
> +			struct btrfs_root tmp_root;
> +			struct extent_buffer *l;
> +			struct btrfs_tree_parent_check check =3D { 0 };
> +
> +			memset(&tmp_root, 0, sizeof(tmp_root));
> +
> +			btrfs_setup_root(&tmp_root, gfs_info, key.offset);
> +
> +			l =3D path.nodes[0];
> +			read_extent_buffer(l, &tmp_root.root_item,
> +					btrfs_item_ptr_offset(l, path.slots[0]),
> +					sizeof(tmp_root.root_item));
> +
> +			tmp_root.root_key.objectid =3D key.offset;
> +			tmp_root.root_key.type =3D BTRFS_ROOT_ITEM_KEY;
> +			tmp_root.root_key.offset =3D 0;
> +
> +			check.owner_root =3D btrfs_root_id(&tmp_root);
> +			check.transid =3D btrfs_root_generation(&tmp_root.root_item);
> +			check.level =3D btrfs_root_level(&tmp_root.root_item);
> +
> +			tmp_root.node =3D read_tree_block(gfs_info,
> +							btrfs_root_bytenr(&tmp_root.root_item),
> +							&check);

This is mostly a hard-coded btrfs_read_fs_root().

I know you did this because we do not have a good infrastructure to read
out a log tree.
But I really prefer to have a proper helper to do that.

[...]
> +	if (gfs_info->log_root_tree) {
> +		fprintf(stderr, "[8/8] checking log\n");
> +		ret =3D check_log(&root_cache);
> +
> +		if (ret)
> +			error("errors found in log");
> +		err |=3D !!ret;
> +	} else {
> +		fprintf(stderr,
> +		"[8/8] checking log skipped (none written)\n");

The timing may be problematic.

Firstly btrfs-check can do write operations, and although we have checks
to ensure we zero the log first, it only zeros the log in the super
block, not clearing the fs_info->log_root_tree.

So this means, for btrfs-check --repair runs, we can modify the base fs,
then you do the log tree check based on the modified fs, which can cause
various problems.

At least we need to make zero_log_tree() to cleanup fs_info->log_tree_root=
.


Thus I'd really prefer to do the log tree check first, as in kernel log
replay is the first thing to be done.

Thanks,
Qu

>   	}
>
>   	if (!list_empty(&gfs_info->recow_ebs)) {

