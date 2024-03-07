Return-Path: <linux-btrfs+bounces-3076-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8047C87575A
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 20:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBDFB1F21EBC
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 19:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326E5137C37;
	Thu,  7 Mar 2024 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ALbIX27y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F342312DDB6;
	Thu,  7 Mar 2024 19:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840285; cv=none; b=eo4zO1y2PNugUOlfXEARqIV6Gz4pBkB+wQ6TX6/MONDoc1yVRPyyJJk1lRANFBYdZa1do2ViV/tf3cIVkXtQXZ9/kktSFRSLOqZG/eLCM59z6ici88gxxCWF7UIzPZpdwcrb2C3L7LAzWlKgsc4kg8za9aUYLb35LhJuSRdgRQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840285; c=relaxed/simple;
	bh=bVPcBUPBHCjUtBXqcYNbk2Q5PpQ3yErbg+ojpQd8pKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wu+KCYvTqjamYW12Y87pZXgiPxsOM61y8om4w97o4t/hangeK7+SmpC4lri2TwGwF3Ej2oR0yraS7yDtFWAZVsf8xeguLSvjNbF0LnMVTuF/JujZ1u/s9oDa3gZ9fs+fElwhj977j7xODkEfFZNX+nvAHpfBmR0iGvxrTwrVAxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ALbIX27y; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1709840272; x=1710445072; i=quwenruo.btrfs@gmx.com;
	bh=bVPcBUPBHCjUtBXqcYNbk2Q5PpQ3yErbg+ojpQd8pKM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=ALbIX27yhLhyUe1D8hZC+dF/+yxSHxZpgYXYh66wnHdaDuGqqADc8PE/lhb+XQhO
	 36yUWgX8BnvMA+jmqnkNQgOfd4dnPfi0B4A4IXvajbWMtZkxnAAf2nXsBMcsodaSG
	 zNiY8uJakVPlP6XyNVZQ9yQZIYRWMdWIXOmABbYSPnB+E/k496E9oPG8tsg04xYDd
	 456Sb3U2kNuOVri2iV39iGuetyH3vr4pR/kPh6uQ84oFgbY3nFTiXESXeRcAagSug
	 aqrF1axVvMJHAU0sl/2LcFc9ZXMIjAJ7Hfk6E7INEcNERsJlvKBWVQPRQqxYcSWbq
	 TWEGUGdG7PCIkgV4RQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MY68T-1rLa3W22dJ-00YT1n; Thu, 07
 Mar 2024 20:37:52 +0100
Message-ID: <ce12587b-0321-413f-86a8-f362be198a8c@gmx.com>
Date: Fri, 8 Mar 2024 06:07:46 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: qgroup: delete unnecessary check in
 btrfs_qgroup_check_inherit()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, Chris Mason <clm@fb.com>,
 Qu Wenruo <wqu@suse.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <cb21ce67-e9d8-4844-8c70-eb42f6ac4aee@moroto.mountain>
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
In-Reply-To: <cb21ce67-e9d8-4844-8c70-eb42f6ac4aee@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iJ0PgVN0rG890saSpFETQZWYVzbLjzYjzsUzw4Z4me4iY9CHu7M
 hEomCZpauiDgIZBJAXMr6dbF3uMXphA2RykIHt6j41Dh+WLI2bTXpz+8oa6v65IRGzqzutP
 KJNo9u2UsCYVRvrwdEdfrQS+1WzVaByOxPMeJaAacGb7ESGtiCdSC8ZwLzKNdJeBoKuA8d1
 odXY8jjlDaJLx8nY/LGgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C88LjGW30To=;TZCR9syfEDnjp/aJk+SXGMIGY2Z
 lP/g706Yy4gT2EllKUvnUnThtRc/aCru9e8KHBDYdmGj1pYKQN6p3aXqc51b6EF/Vid4CGSeG
 bbDkDnvrfXg8iMQXq7gEEWdRUsy8PT5XzrBV0TH6AQ4CQtx+kF4cOV5fpNlzUENpPPryiVTHp
 Z3dJhU7vY8xY5Q/ldCqjNYIPIvUBkl2vQYj/7eHHYhntBdjPvuCifhFbCwPC/MijU7DRo4SSl
 OnehEBQW4/od6wL/jfr5BJcg2bkZ4hKWTiILeDlRVcwzgXRXLAnoKxkC5mEXSQZc3vuguShzX
 utbHx694ZZ7CRIvZP56XCNK9HMu0TLVpfJ5cxd9nEOk7/NCEjqBKl8oS+9J0kGSrNMAeF6LXq
 wDpFBA2KaMRBArHpA8alCCnPKX7kEtJtN1sDc1/pIJ7/YJ5ZvNPwHyNIc5ol7gBtgu8jKYS6w
 B/1FEZZFC7m/8R897snTGpwq1zZ3UYEXtj7iVxNR07e4fCIyksiSdL5719KcsPmj/p49bSJY+
 o39+hLG2VZxzXF63oXVCK8TpEbtWE8fP7f5XkYfp1zKKTT9TYsGFGgrmSWt43fCukgHcML3Il
 zsD1h3HjEeHEWYXnUbm1qmNky+hTTXPPiXHpHn+Zfok4zTTIsLSkSTVH9ZfLHnwf/mMjxWkyH
 RYfbdOgmW1+jYO3OVhjupnZ5fE9r/nU1K0kxphIJl+vM43Lja4d+mTNT/8FRSONVm4cVSIKSi
 B8Mq6/LX4tTQAbcHrp3lWKoUzW07BEBUc4uGidLz/Fv0i71bvWI98C1FudO9BWzaYRqraSXW/
 GviwC2cNmrH15MkJ6/ZyySu7hRvf3DEun4UordzdrPRY0=



=E5=9C=A8 2024/3/8 01:23, Dan Carpenter =E5=86=99=E9=81=93:
> This check "if (inherit->num_qgroups > PAGE_SIZE)" is confusing and
> unnecessary.
>
> The problem with the check is that static checkers flag it as a
> potential mixup of between units of bytes vs number of elements.
> Fortunately, the check can safely be deleted because the next check is
> correct and applies an even stricter limit:
>
> 	if (size !=3D struct_size(inherit, qgroups, inherit->num_qgroups))
> 		return -EINVAL;
>
> The "inherit" struct ends in a variable array of __u64 and
> "inherit->num_qgroups" is the number of elements in the array.  At the
> start of the function we check that:
>
> 	if (size < sizeof(*inherit) || size > PAGE_SIZE)
> 		return -EINVAL;
>
> Thus, since we verify that the whole struct fits within one page, that
> means that the number of elements in the inherit->qgroups[] array must
> be less than PAGE_SIZE.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Qu Wenruo <wqu@suse.com>

I'm not 100% sure about the original code either, thanks for confirming
the existing one has no effect and can be removed.

Thanks,
Qu
> ---
>   fs/btrfs/qgroup.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 5f90f0605b12..a8197e25192c 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3067,9 +3067,6 @@ int btrfs_qgroup_check_inherit(struct btrfs_fs_inf=
o *fs_info,
>   	if (inherit->num_ref_copies > 0 || inherit->num_excl_copies > 0)
>   		return -EINVAL;
>
> -	if (inherit->num_qgroups > PAGE_SIZE)
> -		return -EINVAL;
> -
>   	if (size !=3D struct_size(inherit, qgroups, inherit->num_qgroups))
>   		return -EINVAL;
>

