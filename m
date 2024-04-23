Return-Path: <linux-btrfs+bounces-4504-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9E28AFB91
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 00:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C3E1C2127C
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 22:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C83143895;
	Tue, 23 Apr 2024 22:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="qZp1NQL/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0363726288
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Apr 2024 22:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713910207; cv=none; b=Xud5TjlDi/ZRRzfp/wIWCCi+U/khXzEUUn58TMok8smiaRCewMnGDhL0M0bMggzB11p1vXQV7BmLmCU8BnKyz9ShZjUtVuE3WnT+nJJttjQCqmsYhURBeX044UZuq6MDBxz/JL12eGk/nblTZw5LBGLbJvKmrbLcznEbp1Y6suA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713910207; c=relaxed/simple;
	bh=WHPqMPq3r+2kcZ8aYWuJx1izq+frZGtMYrqzHDZls+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C0V7erRja6xqzRO6TVxCKxH2ZBZ55yI/OKsVvTDsEevnuqsB/NK0mupnV2O1Xt8jH9bX4Pr2b5yZicN00/dYUqHIQIqR3OC9m8zgy8s7Fz2cfkvSyIqO1i3BWR6CPcMZ1N32WZYW1wCxJQ/05UApzdZjmfK7xafkVUkQllTrtpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=qZp1NQL/; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1713910199; x=1714514999; i=quwenruo.btrfs@gmx.com;
	bh=ScPLjZby5CEdpl1yij8xtge6dzz5+T9mmFd3oyyu7VY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qZp1NQL/v2N3lSpPU1t0omleMOdb81F3AbTC+/b1PxK0JiG6XPsRdzy4QlW1d5Ly
	 fx5NreGuZIvsIUwwtoUR0ihSLPeXRHPYgQkaBOfKzvwNL7kkSBBNrOI+Dp1xpS1gY
	 MbqKt7XhXbQbL1o5mcknAllerhzpbv7A5ZuRRznnfPjHYYwQrOEkub4cHykbEi9Vz
	 sfGGRCDftYTBnbJz/YdTD2POybQ5rh4vhL0lcaMBLZnKrO7pa+PySOvEE3wrPPfBf
	 7y1E9CoMoOU7iYsIWAxZfKMehBtxt33cCLsOa1BV+/tO8Y/MU8j4O77eDN0Dq69m9
	 jlWhJzq5VW0Wch08uQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJVDW-1sErt800ka-00LrZZ; Wed, 24
 Apr 2024 00:09:58 +0200
Message-ID: <b57a9598-b9b6-4466-8bec-536d06f780f9@gmx.com>
Date: Wed, 24 Apr 2024 07:39:53 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] btrfs: push ->owner_root check into
 btrfs_read_extent_buffer
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1713550368.git.josef@toxicpanda.com>
 <3487ee70ac2e8fd2c82027c892e91f12a4a47324.1713550368.git.josef@toxicpanda.com>
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
In-Reply-To: <3487ee70ac2e8fd2c82027c892e91f12a4a47324.1713550368.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yl5d2AlfPo8sVTVEkSHHsoS+ZgU7/cQv+49ZZ2E7E0LA1l9kny7
 8mRIY5fLUFoXurYMsJ+SAYXxi1ifKoNiM1Phwd9JPUsw9p0W3lL5tXcrtuc/ZH1SVVSs3PH
 79FrQr8TRG98qnGO6+SxSGgecHhx7Aru8bmqaazvq1RSjZwAP5suivcPeTiSLKVnCmpiHjO
 8lsnELDaDTXoTtxjslr+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pHT1PsGqqTQ=;Csh/aOR5skWmndW9z8scdTeyDSx
 HdSl58p4BivK3yS3FzvfTdRe1LflIi4YViOoQJ0RQ/t6FjW3FMZTbw1+4EEWiH0hQ8ai1zf59
 6lVn/z/kiSXIopomP/UywhfWfY+J6vc1AA3qlS8zLfyNF/2JDy37kWHh6yULA8VGEDY3XxOhH
 P9QOJjo/lXc9ZlOOVfCum8nmpcTuJvr9cIKghiDDk2hRmNvXsl/5+rFlIdST1tsEddUo6yfc0
 C2g7UikIg+0pbdc0wNji6QJQkc/aA/yziKHRxdZJb6wDZtv+8EG6PmAF5ivgrwzuEeE+NSmCk
 WX9CFZuvrAWYzBvbf4z1QCq9XSxGG6u+RUOe33nCfex4i/NraNF4vv2OtH10OfifV4Vln6SFN
 o35QS+tfZG+mAvRjGsW75ZMkXFgRPt0X/aZCFBmkRy2L1WOxQxQ+eVDWCQWrW85LclWKUnGYo
 Gxh30aE8eg+oNSCDyXtbPGTwaMvgrUEju1J416Ffbo2ZlRv2GjJtTf0MIIxxG5yhru1h1YpeD
 QD9lP8Nf1+rJh3DCJcRBTr1CIW2IV7WHuUaCISGCrz9VFUQoRd2n+uY6HgoMvZPVNNC1nuwXF
 FTWiE/JSi1b+iSN7RztqkmuDllsKEi74Ngwa2xKKNNv8IQBZpf377Ag97zQF26/OnTI/IiNG5
 6h45NaNULWZhzNQQXwpnHiuzH0NgoTYKn/uBSxs+p0+/QrstcC9WdNG4csr9QsmOhc6RzWr42
 XzUNy/GPhcR2K+Osp45mHhyeGPFr7m1wWAKa3HsH7braXBC5qAQsrqJ3FxG2sCcqpHR/Sj291
 hWXOVQNdK+w+mSXFqHG/Au9xhR8j831+EpnQLFK2J98ow=



=E5=9C=A8 2024/4/20 03:46, Josef Bacik =E5=86=99=E9=81=93:
> Currently we're only doing this in read_tree_block(), however
> btrfs_check_eb_owner() properly deals with ->owner_root being set to 0,
> and in fact we're duplicating this check in read_block_for_search().
> Push this check up into btrfs_read_extent_buffer() and fixup
> read_block_for_search() to just return the result from
> btrfs_read_extent_buffer() and drop the duplicate check.

Since end_bbio_meta_read() is already calling
btrfs_validate_extent_buffer() with bbio->parent_check copied from the
callers, can we just remove the btrfs_check_eb_owner() calls directly
from all the higher layer callers?

Even the check in btrfs_read_extent_buffer() seems unnecessary now.

Thanks,
Qu
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/ctree.c   | 7 +------
>   fs/btrfs/disk-io.c | 6 ++----
>   2 files changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 1a49b9232990..48aa14046343 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1551,12 +1551,7 @@ read_block_for_search(struct btrfs_root *root, st=
ruct btrfs_path *p,
>   		if (ret) {
>   			free_extent_buffer(tmp);
>   			btrfs_release_path(p);
> -			return -EIO;
> -		}
> -		if (btrfs_check_eb_owner(tmp, btrfs_root_id(root))) {
> -			free_extent_buffer(tmp);
> -			btrfs_release_path(p);
> -			return -EUCLEAN;
> +			return ret;
>   		}
>
>   		if (unlock_up)
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c2dc88f909b0..64523dc1060d 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -251,6 +251,8 @@ int btrfs_read_extent_buffer(struct extent_buffer *e=
b,
>   	if (failed && !ret && failed_mirror)
>   		btrfs_repair_eb_io_failure(eb, failed_mirror);
>
> +	if (!ret)
> +		ret =3D btrfs_check_eb_owner(eb, check->owner_root);
>   	return ret;
>   }
>
> @@ -635,10 +637,6 @@ struct extent_buffer *read_tree_block(struct btrfs_=
fs_info *fs_info, u64 bytenr,
>   		free_extent_buffer_stale(buf);
>   		return ERR_PTR(ret);
>   	}
> -	if (btrfs_check_eb_owner(buf, check->owner_root)) {
> -		free_extent_buffer_stale(buf);
> -		return ERR_PTR(-EUCLEAN);
> -	}
>   	return buf;
>
>   }

