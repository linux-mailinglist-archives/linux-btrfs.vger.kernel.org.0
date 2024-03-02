Return-Path: <linux-btrfs+bounces-2980-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F391B86ED7B
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Mar 2024 01:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF041C210C3
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Mar 2024 00:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BB51878;
	Sat,  2 Mar 2024 00:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hvGSG2RQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD52637
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Mar 2024 00:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709339745; cv=none; b=qvBQHYMGJCrAhW1gNWxLb/rXxlPXJRAhMcgicY9jTNPO+jv8FwwmDbqlHgibGYLCA0gZw9cvxfYDItf5cyio/zt7TK2mOX8UCI2wNtGHuEoOK3YC6WwQTeA7lUIIEvUnwCePE4z4W+7Gfb0RP0mOEz9P87aIR2S96MMVFWxfNIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709339745; c=relaxed/simple;
	bh=xBuSFPF9CsZynvPwoLixo/ZHb0S0m4NXBySOD2gOEEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MHoTPi9aQvh1zUoEvEiSosT5xfec7HY2TWSC1QXhwShYFuOD4w7jmc1H48g887FtRl0hBnmWA/dWSFyWlvUaoYkXniHC2/oDsDOUcNGERnzGulShgspfsTedqvzA6WgM6S/1fEHpknY57E5eQkLtPsSI7voI9vF4vltDOGxb+sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hvGSG2RQ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1709339736; x=1709944536; i=quwenruo.btrfs@gmx.com;
	bh=xBuSFPF9CsZynvPwoLixo/ZHb0S0m4NXBySOD2gOEEA=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=hvGSG2RQK1RXjRGlg/VpPr1rEzgsSCfJ0E8vUP6nxsIM0rQ5r3c8Y4cExllrO+7q
	 pPGSMHm4LMTxVVVMTJGBmEtLCiRU/DC7JoVfF2bjZv+7eksunoXgP9kUP5DDtJbil
	 UMGg9zUzGbsUOyx7pvy2DSFWo9sA0goNPNDwdOGpQlPR3WSVzlMMarfI+BJiiIxrc
	 TelOKOp6Ryi7nXmnf1lIEl4YcAh1/vXoGbcssrsw4bkgViC4DYox7gV9X8dTq3Huw
	 OWvFV/TMb3liEdvU6kBRPl+AXsE+Ci9/EP9hhQHPF86C+6CjOpo6vTcTwQP8kIWX0
	 HL/zqCCh+lqlC3vnyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MryTF-1r44ib13Zt-00nvv5; Sat, 02
 Mar 2024 01:35:36 +0100
Message-ID: <9c51fc5f-0151-4444-92f1-3922d749c936@gmx.com>
Date: Sat, 2 Mar 2024 11:05:33 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix off-by-one chunk length calculation at
 contains_pending_extent()
Content-Language: en-US
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <daee5e8b14d706fe4dd96bd910fd46038512861b.1709203710.git.fdmanana@suse.com>
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
In-Reply-To: <daee5e8b14d706fe4dd96bd910fd46038512861b.1709203710.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T5kHiHONITJ2BM3KjPqfSJ0RgbRdY9HfDuAx9S/aYpmsVsq4aWZ
 GeBYZY7ulj7fA+dUMufwApglTcCbp26adyN7MmYtV15q6kRjVpfc30eJP3u8l4W28USGmmH
 Deb3P/3ZUBqbKRCIRCOip+i1qBGIxR2n69DhSQnKphdnCm3d1Ma65SrFEw7q83X6LaXV54m
 Si3sSiwNpbceFqApRwx0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0KErGj7fMqo=;EpO/XXWgp43BwAclX7W9t99Evpk
 92z414k9UpB8Y0qiQJfk5SxnnN2R21myu0uC8Y1V2bTYEa703biIT4KMMAO+O4ErWayB8xBJe
 UPlB8PS+tGrl4OxADe9ZqYaDX+EuIMwBB+uOVK3ciFYd/Th1s6nLn7Oj8+5XkZhrJ9VCuY3AA
 w85jQBaX2EV1FrEdaDXn7TCUA6sHyg6Ug/EUNwy3Oa67sFRObgocl1Bc7LQIO162HN2lIEZDK
 wiYHaf89OsXJc+0Bfz74gvYr7GmxnIDbWNcx6G29ojqSJyShNUyz00Chf2sY0RVoNvpTrHudR
 1LPDvEWOyt2oaFXaFXUDXLNFfylYdZGmrNsQ4VhQdTpL3K1oR9ghCCXIOWjlZOWjHtKCxoI4W
 Gbx+QIYy9rqYPbWLaNo5/Vy5ruNOo0ud5EKvgsCEvcwJxe4ovXuFL517KqGJ/0u2IQrNmU2DZ
 EPt1HYD2fWU3cL3E5n3xvtDzW8SMUzz3u39xrmKb4A4a7w+R8+ihl3Y1xLQf7wBRt7X9YwtnM
 S+cCeJvOi2/jZ2RtUmzFnwAdk5bq9F3UeOsc9jwTcfTG3N1+WOJk1HVJqyHLXW8qStzzLZyfR
 j5FlCImNcCKBE3zaBZWhON/tTW8QbsDz9WUStf2dAQ7ujsom5XX/k4/D+Iz9caXGPGf7Wd0fh
 MlgR1NoDuACNkF8ItuIA+m1W6uO871tV7u9v1ziqVW1kWnOX40xLd0mMKXLln/Gkn/WQka1Uj
 eEbXjq8OdaLwJJJ4+tEF8hR01I7NUV0vCKsLM8othIccIPmRrw0bC+exI/R962/Ps3JcIZWKY
 SXgNfJ0phlBtrkNBdkUMQOns1tqEBVjEyRysfzFFCUdtE=



=E5=9C=A8 2024/2/29 21:20, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> At contains_pending_extent() the value of the end offset of a chunk we
> found in the device's allocation state io tree is inclusive, so when
> we calculate the length we pass to the in_range() macro, we must sum
> 1 to the expression "physical_end - physical_offset".
>
> In practice the wrong calculation should be harmless as chunks sizes
> are never 1 byte and we should never have 1 byte ranges of unallocated
> space. Nevertheless fix the wrong calculation.
>
> Fixes: 1c11b63eff2a ("btrfs: replace pending/pinned chunks lists with io=
 tree")
> Reported-by: Alex Lyakas <alex.lyakas@zadara.com>
> Link: https://lore.kernel.org/linux-btrfs/CAOcd+r30e-f4R-5x-S7sV22RJPe7+=
pgwherA6xqN2_qe7o4XTg@mail.gmail.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thankfully it's mostly harmless.

Thanks,
Qu
> ---
>   fs/btrfs/volumes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 3cc947a42116..473fe92274d9 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1401,7 +1401,7 @@ static bool contains_pending_extent(struct btrfs_d=
evice *device, u64 *start,
>
>   		if (in_range(physical_start, *start, len) ||
>   		    in_range(*start, physical_start,
> -			     physical_end - physical_start)) {
> +			     physical_end + 1 - physical_start)) {
>   			*start =3D physical_end + 1;
>   			return true;
>   		}

