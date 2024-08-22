Return-Path: <linux-btrfs+bounces-7418-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E69895C130
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 01:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4425E1C21E79
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 23:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747861D1F4C;
	Thu, 22 Aug 2024 23:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mBz9ENcA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FA261FFC
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 23:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724367667; cv=none; b=qoz0SsP1+mn6T9ynrA0QEzwWMZrwJnpxiS1qdnk77cksFNgdbGX2Jdtv7lOVg93n4qnCcv+6AgHc0GeubApzhcl4oTGcrJWVZ7jqQwWrL4Am6vSV2g8TDQA3OVsiqjc0wpYX6CkFYvMwRtmnIKsm5mIHhlr665PZdGWUU3l1OgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724367667; c=relaxed/simple;
	bh=ztZ3FpAmlcrSSbZMkLCkGo6Q3zkhw7c6uqb2NsYO04U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PB5TOTZmok1dTEK5e+rB1zjsOa+K89V6ksJnUdEg3M9PPmt5eUNQSranHcdzC+ybAln47JmWOC/U+wKvVn9HUE/s1WklJy0FQNa+yIFeewvyEr6jPUtJTQ/FGw4NWu4Fy/0tP8R9wV0PRrXgFVdqQyM9OqVIrWssSX9UzJBvbvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mBz9ENcA; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724367656; x=1724972456; i=quwenruo.btrfs@gmx.com;
	bh=VZUHd+MzXDaGwNaZXeS2nkIsWdVfOztq6CZns0N8ql4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mBz9ENcAqseq4UWrekrQ5d5gBPhNFDuiTc0qMzO/MHgqQSroOPEDXofSNpOijLRS
	 bz9x5pqB2Ukm4xfY8seiueN5jkcM8HR7WpZQFWU1+PC4UwnuuEQHQB7rzsKeqKgLI
	 2AcSvtuYoZaLDZCxzLa43OOIl/pSb2UY/Zh5almA0pyBV/ceR1U3hTuGBQBcTXOxA
	 39HNoa+BVxsyexlTkzAhu+aKIX2l9xtyPaHQM+KYH4hNnUKNvKHuU6HYTjE/qgVoG
	 3AOOIxCA5JC+awIa87FSdA9P+p1PDUXbzsuC+PUPzE2xLoaq/ywn6o84xdB0rjvC6
	 BoNT83ub6d9a/wSXGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUosT-1sY9zl0jqL-00YDCZ; Fri, 23
 Aug 2024 01:00:56 +0200
Message-ID: <8b7b2f3d-0ef3-4587-b20b-287074ce759a@gmx.com>
Date: Fri, 23 Aug 2024 08:30:53 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: run delayed iputs when flushing delalloc
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <c718e1eef33488e3cd232a650b7c2d97701bbf24.1724341245.git.josef@toxicpanda.com>
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
In-Reply-To: <c718e1eef33488e3cd232a650b7c2d97701bbf24.1724341245.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/9waPJ+6n1Fyw+WDlJ1Y90sol0TzCKBtkMiRpu2OHIVMtVH+ZX2
 TxdVuoK3UOuADqji5z2Vxs2DKjfbZzS7ClUcZGtkLHa7ystRZbNKSKgWPoiYAZ398Wfptau
 EslnPMsGxR/O+LDGzkoRgu2Y+4QgfPJjASxDeUjtX4qYx3wQofJyoZ9rJdp1tYGh4HCt0ZK
 jbIkU1qVXHsECjjERVRyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jxNvlH1GEdc=;uVYrJNUuS0iiH2+0yPPK29y+git
 p5MUhc0v8G+STgYkyieQVAfa7GBoQpqql3cenWk28TSl0xWj9zynXPd+8UfAv7+0olDKLeUy9
 hV1lpQYqso1IBdfPafGVzQcmFDHBoI6qJaVyK3bozOtvof/1DnKW9OSZugRbQL0JSkG512D9M
 FG/xs5neCGoFCF5oeP5DbD+hdEelik0Ylc2VqNUt6Yi5/6LcEXNMh0SYdJ5gjldMXeawruh8D
 LS8qUJdaCXAEYx4P71LzKSSReJzZtaVLrKgEbSB0CYHvQQdCvXmMTn1a60x3sKf1SVXE1f3L+
 EFRTC5Kvv41piQzIOPULLTaIWDvvvS7nfAD8id8e5m8xUvkUhs3Hx6MXd3enltui2tp5O93Xz
 ZEZK4PC147OfLYM6a/kalj9/lSoWoDupRdhMhWJZGxMTNaRzLqhAdwgGKnvt+iF4i758PzJax
 EFwNOkKdKlBcwIxTdnOKlUJd5SPYQz7wPjUa2FxrRsjC2F9Z6uzM5FEhCk0EbbIK3QCJ7hej5
 sd7e1aLBz1IZCv4//rdRJy8Oprifz+8vbKfbt/zkTGuHI/iM+0bnwWw12DHGF1Ei/5bXTpasb
 ji40amBedZ/PScH2dzVXFsjaaC6COQheahHs2lJwxEsfKmP+nnDjIvIfqQ9s3AgM1us531W3s
 3UIlmI/iEuXreY7di0+DhSrpnLJ2WdJ7zwcqffXyHFnt3fTSV0HrepDkEwcl7nOkPkNWQ4zio
 hZgJOoD8m2ndU0Xi47N2HKrbET/HqiTOTnGeV3xy3UHX79d9oaLsOpVP73UjnvvVp3NgpFBJZ
 g9XyJFZTcLwvJ/xRT2KDSMYQ==



=E5=9C=A8 2024/8/23 01:10, Josef Bacik =E5=86=99=E9=81=93:
> We have transient failures with btrfs/301, specifically in the part
> where we do
>
> for i in $(seq 0 10); do
> 	write 50m to file
> 	rm -f file
> done
>
> Sometimes this will result in a transient quota error, and it's because
> sometimes we start writeback on the file which results in a delayed
> iput, and thus the rm doesn't actually clean the file up.  When we're
> flushing the quota space we need to run the delayed iputs to make sure
> all the unlinks that we think have completed have actually completed.
> This removes the small window where we could fail to find enough space
> in our quota.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks for pinning down this random failure!
Qu

> ---
>   fs/btrfs/qgroup.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index be9a56a5d298..a77d2cd9d89d 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -4185,6 +4185,8 @@ static int try_flush_qgroup(struct btrfs_root *roo=
t)
>   		return 0;
>   	}
>
> +	btrfs_run_delayed_iputs(root->fs_info);
> +	btrfs_wait_on_delayed_iputs(root->fs_info);
>   	ret =3D btrfs_start_delalloc_snapshot(root, true);
>   	if (ret < 0)
>   		goto out;

