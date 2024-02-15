Return-Path: <linux-btrfs+bounces-2443-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A9C85712C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 00:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573EA285D89
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 23:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3E8145337;
	Thu, 15 Feb 2024 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QsIbnrII"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD8D41C61;
	Thu, 15 Feb 2024 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038630; cv=none; b=MgLRzOSQZK6j4wZLSnNaW+5jhDf/f/eT+A6dWqX1bE6bvwnA0DbfIrxSFod42G1+fE8LMNxDU0MiB8bTVMG21FfcICQKTW4YzLrIvjqhzR24c+NveyLmW47Z7K+cgl/I6X/Ygp89nK9vBGG1tS75n82jwI9RkMfKoL2+ZrdwkVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038630; c=relaxed/simple;
	bh=SnTN3OnmtC+RDD2neRXVW/CMrueTh8CjUAe6Fj30LVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPinP52tlkngfDWro+DL1Mg+MFRdgVP8nWxjor5X6xViEKnGdjfj48I7u5HGqAxW4GMN3UkzEphLYKb79dXQz9K01SgboRCA8TwU3C0Mtd7Moilwela6LkkFKDwTVQpPL2laCxpE9eP/B00LoBNyKPVSZLoxHYCQ/5t5nmiOmWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QsIbnrII; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1708038605; x=1708643405; i=quwenruo.btrfs@gmx.com;
	bh=SnTN3OnmtC+RDD2neRXVW/CMrueTh8CjUAe6Fj30LVI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=QsIbnrIIuL9JrobVjip/zGphcVwLi3/MGPpCqh0hlw+BjR4O1t6CoBBdYoz4WoL3
	 xKhTL8X9vbSAY9KinZJFCl6b9ZCCHGRRhT2zLQgDRapDMUeixWrl9/RP5kmFOilu+
	 gO9nyibmumwr2KwNDWBwzGGXEEQIHyT6xDEznCbGgaNurEr5xBfRJ2cTdG/OeGDuP
	 qhvs6Yxt/QGoSlW929pZFCgRzC7QpEzgkgZ3TH/+V7yQvMjadaiQ1NgqwxLBK71+A
	 SEnNvApBjBQZwR2YcQYbU5OyC7RCoggZyvI3D49m5ZK9i8BYSMhex5mdCfvbABpve
	 4/hO5Vb8qZcNsuBZsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MpDJd-1rB3dT3gwZ-00qgpl; Fri, 16
 Feb 2024 00:10:05 +0100
Message-ID: <47af15e7-3945-4563-afed-c779d393dd08@gmx.com>
Date: Fri, 16 Feb 2024 09:40:01 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/172,206: call _log_writes_cleanup in _cleanup
Content-Language: en-US
To: Su Yue <glass.su@suse.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, l@damenly.org
References: <20240215140236.29171-1-l@damenly.org>
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
In-Reply-To: <20240215140236.29171-1-l@damenly.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9IUoEhCsZGqGuGHWNCbS52+I8/zEfbVmTvUDxDrS5x4DDL6+Ff/
 JNUm6Jlzf2qzmC1hHkL9lp+ufNX/LVCz2xX03iQfi2Nyfu+HMWZunuT86itjuOQgokmlGjN
 uHtztlvQVmC4ANiR9qs3D1QG332BNw6bU5MbloAJOJ9xzYmE5vXObJ5CgQHDDtnUpEMFEke
 3ziLZEe0kacUNT+IpQGQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+yUByT9BlEQ=;MO9yhGURVb97fyqM4Qcjwe6Jzw5
 +9IdTJxGOq5PSu2FgR0HrJBe4kyDDffTxNXzc5CYWbtWJAFQcqXp6/zWb+GmD5WrLzzh8i/Rz
 P+p3zjrKSquqQBzWjaFv78q43KVGvIDOVwaN2BTZD5PD6WPTic56w3X6G7cd36rAMDgwl/VkY
 rgpnhrPLlUPbEA1nZ/0BCkomnQnA+6o0fmvrGH+tiXDmo+wz3KZtBy4ZEoI8iCWJh6OcH8v/5
 wT3ecgrxtQ3bZ9Tj5kSJWMlyHdS56WLmZZj6meSdRQH6JSBNFVlb2DmxJO5QSsA8xKTwKolbk
 dDgZcGeWKwpCQATLc0f7XenqsvBghdQyoGHxnmfLn+z5esnUCez1bGkhCw/dDOcm+bvmgUNJG
 VnJEeOlTtywQPUiS8hwC6Quhta7wTaw4Pmd17HL1s3lG1nXKi+Wb6D5//WIlnOb70kS5MvF+F
 56lME4RgUxujyIlAiwqqxYxhKKt0OLOBx0bMU6i3WIcBPYey9HaKHTRlbF34tCm63fhV2q3qJ
 QyqjKwRqTv7z2EefHI2wevEeWPpfqE9aLzU8UWECnLjeLKie/nSexcc4H8zOI/HoZIujaxMAu
 DAM/dob5pu/j9gStFj7rfIkUy3BCJpnixwMeMaUBPiO64zWcL2JekxJNEPf+32B8pHCSPcL4S
 G6F0e29/6I2XXg5AZJa+Wn8cxnFYlJFcTGWJJ9zIucu6woJWo84vGA5Qno/SHnHvHmcLriOjw
 rykoGumjcdO/hCOgOdl6Tm2b9cjjv4FyeLDrMza8q4GTU5d9tYchJGpMfyfbGZegKLDEbrruZ
 +KxAsaYecCH3JUYOX4EQgbKA0pU4NgwVBxHF1D4jIsiH4=



=E5=9C=A8 2024/2/16 00:32, Su Yue =E5=86=99=E9=81=93:
> From: Su Yue <glass.su@suse.com>
>
> Because block group tree requires require no-holes feature,
> _log_writes_mkfs "-O ^no-holes" fails when "-O block-group-tree" is
> given in MKFS_OPTION.
> Without explicit _log_writes_cleanup, the two tests fail with
> logwrites-test device left. And all next tests will fail due to
> SCRATCH DEVICE EBUSY.
>
> Fix it by overriding _cleanup to call _log_writes_cleanup.
>
> Signed-off-by: Su Yue <glass.su@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   tests/btrfs/172 | 6 ++++++
>   tests/btrfs/206 | 6 ++++++
>   2 files changed, 12 insertions(+)
>
> diff --git a/tests/btrfs/172 b/tests/btrfs/172
> index f5acc6982cd7..fceff56c9d37 100755
> --- a/tests/btrfs/172
> +++ b/tests/btrfs/172
> @@ -13,6 +13,12 @@
>   . ./common/preamble
>   _begin_fstest auto quick log replay recoveryloop
>
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	_log_writes_cleanup &> /dev/null
> +}
> +
>   # Import common functions.
>   . ./common/filter
>   . ./common/dmlogwrites
> diff --git a/tests/btrfs/206 b/tests/btrfs/206
> index f6571649076f..e05adf75b67e 100755
> --- a/tests/btrfs/206
> +++ b/tests/btrfs/206
> @@ -14,6 +14,12 @@
>   . ./common/preamble
>   _begin_fstest auto quick log replay recoveryloop punch prealloc
>
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	_log_writes_cleanup &> /dev/null
> +}
> +
>   # Import common functions.
>   . ./common/filter
>   . ./common/dmlogwrites

