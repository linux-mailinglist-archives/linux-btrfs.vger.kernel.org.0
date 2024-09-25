Return-Path: <linux-btrfs+bounces-8213-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D549D984F74
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 02:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7DE1F246E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 00:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61AF8C13;
	Wed, 25 Sep 2024 00:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="NeBG8vTN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5302DDF5B
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 00:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727224050; cv=none; b=aPqtm2LbZOV4LZebEyVcRjNb2f3sjR25qutNFSTAgnYCiVsm405RvjwOcHVrjTZzJvr1F2NwZePohHoQ3PyRpeqrHiCQMbeERZZNz7e86axMfY4prHVa/mTWu0crXWTi6d/s+VYX3PvyZ0NGPMU8WhgVnA9i+laSVnFPgcCcx2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727224050; c=relaxed/simple;
	bh=N9pGk9CAKtrkgAWicok2OSfQfFZwrxiOZMwfS/ozdT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iR1RPSyf/UgPODIOpP/nhHRNWfOIYub/tG9Tllc8+ry/TyGGBnrn+U5qy8HybMvHpWW84w72mg8IxTRLdc3OCTCZs7USaW19H13HUQ8A1aFPvIrJlcLenH5fqwkzLD2OOZ4DWvj4L6hDmviZxYoV+AFAQ0/VNwV0PlrnjRZQ9zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=NeBG8vTN; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727224042; x=1727828842; i=quwenruo.btrfs@gmx.com;
	bh=alLAKgw6DG4qxqEcJowmifdiq8M1ou3wCBjaqZEvnd8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NeBG8vTNygxCt2j4DYOzwr8GlsiPzb7udmTw7hApBk4qT2wrO0/F6RcDRQLDVuOC
	 28jANZSG9+QCC+Ty9nNnK45qQfGW1ignC+7IzCs/ysWTQiQWWzklx+74QWzYrs3WG
	 zSSA14DmeS3JplO7Z889xfv4+5uSeW52FnIvy2h0eO4IxECmlAoYD9urGmjVnX7D8
	 geDb2SSL7ptPdeEZoJ5mdmhvjZyw89TaEIDXQCxVfWZIn75dALswINcq1qApaV+S3
	 jVNOtX5m0zo3afKnRt+EtppWfS4IwsDKU5CVpP9PBNrB22fCu4tAqRgLwq9sd52ca
	 NxN1Zk/FErXIZlc6zA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mf0BG-1sHQ9b4078-00oNMt; Wed, 25
 Sep 2024 02:27:22 +0200
Message-ID: <3932ce42-10f0-4491-8c19-f120fd8d87fe@gmx.com>
Date: Wed, 25 Sep 2024 09:57:18 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: disable rate limiting when debug enabled
To: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <a0c406abae81f2824ed822ef7f5e85650d8424b1.1727219806.git.loemra.dev@gmail.com>
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
In-Reply-To: <a0c406abae81f2824ed822ef7f5e85650d8424b1.1727219806.git.loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2jXdfcJuXEcRj93vkw7Kk2siELeMVAS6eNuwwPZI1nbj0Uv4Nhs
 ZYWDxwmB7gQgMn+ikQ4V5g1cX0y6som46juXk7jo00W3WUA7JikisyqTzxo4ZqcG9Q28/Vw
 MX12l+NrLAwtv1cTGeLo62XMYAM+V7xyTAg/p7O7aS/UMKVIF97ERudXTYNeAvKgUPqLq3s
 KchVgMYgGocB3o3x7qA6g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MV/4vHO09to=;1flr32qqNm/8tAGOE/A4ucoVwX3
 +NHmEKuupP4aic6IYqt6DGoFxgW8Tq7Cbm2TY+VIn1BwoHQXUKPbVEv6rxjpkFp6cNapa2y88
 zah1iBHZf3MCN6L2YWm+U0zcumcrJpzJ6ivU6IQZBAEyuAoenEhonBXeRYYBhwb/NiTAWckyv
 DcuiTwdY1Yc6mGxFjorhz5mr2gieDzgfzAthjNMVrW7xMml+lAROZb2dnV8P1UEwHDXAQe5VE
 LJ1tJlxBXTvXBXKVDybtZbKblVxoxA8PABhTXBI6ku106+QBkFjmd8U59jS96G+r5ETFlN1kX
 KblwCcB+PRkFbAiz+b9qPKuYpS9P+gttGpS2o0YCe4uRsDeD02u1+VIbKZGcE1hgcMAc3YFuB
 oV4cTBK8jIhj7XaKliP0oGfsO9D5eJi+VpMMZGteAtwyiyOERuaR/+zsqTjCDXGVgfwqoaTwU
 25Mg7iDOaIpBcIv4O7CY8rgY3GGtU1PkuRh0fVUeyK1EGGjUfyKzg1Rkp2evM/i2nc55uNK4y
 YR3Y/S2RS7kaVbfx8u8y9BlYU60nMxCLzZJ/uyfX1+yxbjdIDTJO5jWsCJj3UetSVycKLj9Ro
 CJsOLJFN76fjYMJTWvZB+xPRfI/JrPIf2U1D6N4a+9nAob5LydTjYX4U7IlusJTZ+RI0tvKUV
 ZFIvcCQecTGKqOz8BJyKVB8iU/oVLtpso7kEGkWDOgg1/7iJ626r/BdBC3URL0310vYFPsKBh
 c29k0LT4uEM1MCAo55RN+J8YzJBRvD3HcA3FrRNrNmMS2EoJ1vAQiFNsTKKHZ1aLGw3j0Tf/I
 FexFF+19FpxEnQCHkd/WcYKQ==



=E5=9C=A8 2024/9/25 09:12, Leo Martins =E5=86=99=E9=81=93:
> Disable ratelimiting for btrfs_printk when CONFIG_BTRFS_DEBUG is
> enabled. This allows for more verbose output which is often needed by
> functions like btrfs_dump_space_info().
>
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/messages.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
> index 77752eec125d9..363fd28c02688 100644
> --- a/fs/btrfs/messages.c
> +++ b/fs/btrfs/messages.c
> @@ -239,7 +239,8 @@ void __cold _btrfs_printk(const struct btrfs_fs_info=
 *fs_info, const char *fmt,
>   	vaf.fmt =3D fmt;
>   	vaf.va =3D &args;
>
> -	if (__ratelimit(ratelimit)) {
> +	/* Do not ratelimit if CONFIG_BTRFS_DEBUG is enabled. */
> +	if (IS_ENABLED(CONFIG_BTRFS_DEBUG) || __ratelimit(ratelimit)) {
>   		if (fs_info) {
>   			char statestr[STATE_STRING_BUF_LEN];
>


