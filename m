Return-Path: <linux-btrfs+bounces-4394-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 799528A931A
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 08:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0916E1F21117
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 06:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFEC2C197;
	Thu, 18 Apr 2024 06:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ohMMliZA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B2F1D68F
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 06:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421870; cv=none; b=HSYTtngSnHRiTQDDv7r3ZdTlsEs7WiuRRVOdDZf89/+h7uBK2VHFArsnFCuN2uRV/fjrdjLLZrNzm0Pm9wqGURLx4jyGdUP2a6V5G+E+DpHLJAA79oO377uvWOMtSQcnUE7S5u+tO84vOKad2HVvs7u480ba3ndAqMUWmPCi/zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421870; c=relaxed/simple;
	bh=rs2RXKkKKnHZAB2d0VGAo9/ESugK4/rOphVdjURFJt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsMGzqyk3hmtTjq60f+GSIN7ybYJQW5+G7c+RHlgodnb18K/9XwNi7Qvnu3nPwtWiKLYQrUaH19PKl2gvETkkdoAh7to6YQ62swEcmWiWGppnygDOom7WUNEzrAesQ9hUf7JBgFYkncSUJAGfUq8iPv+KnGLNWlfXbFhuX/ctMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ohMMliZA; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1713421862; x=1714026662; i=quwenruo.btrfs@gmx.com;
	bh=pjJgtDomsFm0rHgjIj9bnx5zmXZLqiFbGSBvEjrIWbc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ohMMliZAoHMBtkDkxfCwerDwOG7YoJ7jqXMOlhKpPQ+I4dXwOr5QqRupEFp5gBuC
	 rM02r3eYINsNcDjljegrZzqTogHscRixSCySzWeiDoYTSI3Nt1gmQQRo1/uwnljvt
	 nNgyKZH18tnSJMfuLbwNU7WDPnWCivAlG7VVObBn8Hdm33pcIc0rzeORhIjWEpTMy
	 YaIabPRAQpSQSaIyPuZjj/vZberN6ID/XF0wHJ0R1wFD4w0ZnabA0b32aAnuamtDb
	 /z7GVNvAph0Z/xkm7CkYE7+dSh7Ej0gsPvUYh5+y5d33DQ4jiIhPuvZ4JETBXj7WI
	 me0U0uu7i24W5zT0wA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMXQ5-1sGviM2Wv9-00Jcwn; Thu, 18
 Apr 2024 08:31:02 +0200
Message-ID: <041bef79-743b-4726-adee-9c0ddf332e6b@gmx.com>
Date: Thu, 18 Apr 2024 16:00:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: report filemap_fdata<write|wait>_range error
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
References: <80c3c9ccb6e7ea366d88f0e5b2798f5bbd3b381c.1713234880.git.anand.jain@oracle.com>
 <1556267cd2fd5f2d560a50b4b169ec4d58c95221.1713334462.git.anand.jain@oracle.com>
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
In-Reply-To: <1556267cd2fd5f2d560a50b4b169ec4d58c95221.1713334462.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XJISYZa8MqNCw+KFAiRKMdTRE8lBdsOH81arZL7tf73N1GxZD65
 EN4Z9vfpAiRdHe7o6OK/tA07rDdNdHGBjOdQP9DRMxBStsxLucqFFRzZWEC7r7f6HbfdfMM
 Lcctu8FbAMOLNLgdLDoy3r870+JK/C5HLrG9/B/OXvFNkIMNlBfE/i9VzE/4h+/MI7K1HsE
 bCTsdhGDoOUlszovCRNIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ROBruQhHtXE=;IhTR4kZ4fpol/kGsMFOuaCyvE8Q
 b+VvhRvjhqyWZMMX7c4Uyrh7TqXjMMf8tuxv8cJB4yiMdM/lKnL+OvcdMk9HgADqrnziR/S4P
 Qt4Jz5KFeTEtXdGIsJMxuLrBQO+3zCJxlM6FKq6m+DM/vMhMQnwUEsM/cFJ3gbTFfrFQ0BJ2R
 ovP/Ap9wjTfI1bG5jxMkczdOqUCno1ov+BZDs1lNQ/AzdamDn3AWJZZ9jpvyRjc0PEP+sQBdZ
 tXQFI6QmEbAJHdmSVX95wyovmm9OdsP71WhcljjbyOgdZES5sPw7LEbI9abeXjmWThQ6WWkdz
 mjOf3OF7FpwfRsan0YgcNl1Soa6AfEP7lRYnn8ZodVh34ABPKzS4fS2KpuMB3Hej9T2g0kNTW
 n6+fgvq8kg7OHYPAEXFoA/M2AwQdjGQTFmGeD66vGlGvgp0hpPMgSQL4SBNw/W9p/AWoJxAWA
 xJhX2i7nRMdD7lO/IXbbhxn8eZf3QXU/Ys9KindqLIiy52eXFnaCGU0vh2YCHqhQTQ/ey2Ozv
 kPIUlixEAy4T4jhGh4WqXDGsgRW/aFCDsNC+ApGUL4kMgVBhkkCgOn2z0JV8qj0fz163JGuFj
 QycbptHl5AZH01hy823rbSHQ7loFcCcrzQsy2PHJ2svBSd85Jm1GWRLxgx/pacWVbsiZpjbMd
 xPsT8Y9S00de238Qh3nPb9Pni4OxmlAAGiaqaOZ1tKKEDeYCUCpeFh1w+lmew6GSbvOQMsPxS
 nXtAMcxVxu7QcOfs0QNwClbAfAIvNBwFdd+qrbXTgXsIhSTYJJV6KMHezkh29SWm4andcYxAT
 PfXJZnzSeEyMsfKRgQ6rf+dBQYHXRXxGfAf55dzmLWy9Y=



=E5=9C=A8 2024/4/18 15:44, Anand Jain =E5=86=99=E9=81=93:
> In the function btrfs_write_marked_extents() and in __btrfs_wait_marked_=
extents()
> return the actual error if when filemap_fdata<write|wait>_range() fails.
>
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Looks fine for the patch, although I have a small question.

If we failed to write some metadata extents, we break out, meaning there
would be dirty metadata still hanging there.

Would it be a problem?

Thanks,
Qu
> ---
> v2: add __btrfs_wait_marked_extents() as well.
>
>   fs/btrfs/transaction.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 3e3bcc5f64c6..8c3b3cda1390 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1156,6 +1156,8 @@ int btrfs_write_marked_extents(struct btrfs_fs_inf=
o *fs_info,
>   		else if (wait_writeback)
>   			werr =3D filemap_fdatawait_range(mapping, start, end);
>   		free_extent_state(cached_state);
> +		if (werr)
> +			break;
>   		cached_state =3D NULL;
>   		cond_resched();
>   		start =3D end + 1;
> @@ -1198,6 +1200,8 @@ static int __btrfs_wait_marked_extents(struct btrf=
s_fs_info *fs_info,
>   		if (err)
>   			werr =3D err;
>   		free_extent_state(cached_state);
> +		if (werr)
> +			break;
>   		cached_state =3D NULL;
>   		cond_resched();
>   		start =3D end + 1;

