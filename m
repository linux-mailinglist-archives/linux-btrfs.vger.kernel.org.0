Return-Path: <linux-btrfs+bounces-2690-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF63861D10
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 20:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064451C24CC7
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 19:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418B614535B;
	Fri, 23 Feb 2024 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ktbCiF1X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F80113DBA8
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708718270; cv=none; b=PvqGEDrOd1+czpYs8iR+TNEiTnz3knzevodQ/qCLnq2TuOe6RPOHGtzZXJ2EHtfmOaAymY5tGKQlvZh+caZ7C1TM0euovPv+tiI88+AO07yJEyzXx9J5TEkl9kLbQFs5OxWlgx2PcupnE2w23okPqYq5EAaYV0/4Ayoy1NUhm/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708718270; c=relaxed/simple;
	bh=s9h+MZAl8XFTbb+IyAJpPXQ5HyswYEkWuyjo3VttUYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dXHtRRaDbh1mmW1BPfmPBHkJzy5ShfqYtDtXhkkVjcmTPH5V/mTnkixL91yamPMepVwc+6ZzTE1zDC5Qfnu+OOvVKpnQ+IR2pgTqA75h4QFTqjt98Hvs+NU+/kRqXyJ1sDNPV3oAjnxqLt9uXQ6376K9ykUSq7AbZHpUkGqYD2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ktbCiF1X; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1708718263; x=1709323063; i=quwenruo.btrfs@gmx.com;
	bh=s9h+MZAl8XFTbb+IyAJpPXQ5HyswYEkWuyjo3VttUYo=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=ktbCiF1XJYArzyd/KDY6nQd1d1jZJBoShQhzj7m0P3NWsgir3uuiTV1lv14vnkfL
	 TIG7WYkHGFmljwCsWjikoc8WUcobK0IiVf+hEYhNNDYO1JWWibNXBFD2fOotnLg7n
	 sY/xzC+OEmajtg5XBM3IPsqOJvCHfi4br1Q+sVU9urRmGvBvGtBfyiNoq/p4Kt2ew
	 LCTSbWGRNqKxqPpHJrU8XPIT/hkqQA+5y0vj6CrkmuEJlKGNeKoP+l0RN6rTW3YMi
	 xe+N4FgVDjjorKEa13yEE04t3WHATNWvadE8E7+WEg9fEY1m8ykSHlbB5AoLB4lTf
	 n0nqU33sN2jFTx+jKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MY6Cb-1rPSWp2vi1-00YPZE; Fri, 23
 Feb 2024 20:57:43 +0100
Message-ID: <7f2d1ad7-3c5c-41e9-a797-895e2ec76ed6@gmx.com>
Date: Sat, 24 Feb 2024 06:27:40 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: include device major and minor numbers in the
 device scan notice
Content-Language: en-US
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <9b8ddccde70488086ea466b33b9cc1e52d0dee3e.1708687432.git.anand.jain@oracle.com>
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
In-Reply-To: <9b8ddccde70488086ea466b33b9cc1e52d0dee3e.1708687432.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fxlHr4oTxEoAWXW3T/ZS53H4hL2FnuPa9t0qeaUIfvAg0wV8kCt
 FmgHahyi5lDHIz4lhW+dVDwedbFpACBizxNFpMqTiI/6DdnbPrVdBSPaRw+cA3DMg/2wjHM
 nZXCIKSpcR8p9wET1G+/wGQsSQ0tCZv1/fM21Vd6zSQtfdat6ODiq1GcmWEXijX5/02gEg2
 Opg+BEPIfaUrf1JRfFGeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Df1mPqwPDKg=;bwLZaRyZjq36RvSR8aHnbJHiXmz
 Ot1SdgT1Fe2sxkl9I+uolmdBHj1/ixcHlN8jwtOMLFdFI8fLocwxAGIsh+pwLJtsH7sm0xOWx
 0MePMmuxsH1Wh+kQA2eYbjq7OSOerq6T4HC+qJ17iX3oEvBxwU5hVNHMTq0OMrTWBZ5ApwQmS
 L3+hmckBSOUJGR7VK7rxu11PuDBX0LVesizNsFTZgcdS71Cf4sw+5xKXCaYKn2YTFclfTmYYE
 HCnEXh3U6M+Kw7jd8ZYUnFTzI3wv5liRzY7nsmyCNhx8xB/5yAJ19Adn3ebgCWgGgfw1tXYRx
 Bn8301ttL8nPN05Xt74px9t1faHivnRx1QXY+JfCGOfWKHEuB0ZcJjh+QM7kflG8ETKxHf53L
 g7RbTBh2P+HARIiSoclxxUuQAl0bVcqxPV49HgrMOalHucGrSbPZJjZxfr9GTewOkY9yq6WC8
 7qXTIeC5KVqXZ/Hf3FzXbAm6d/GhQLqhkslHFETrjArR6EnmIzLVSBFgX8P+pOaVdTSJeWX3r
 QNE+M6CQymuznFUq74qOOP88TIf3QLrjsERYxnWNjc68Itqm2yY/ljW3ooK96egvrZ+/8fKGZ
 6n2dXXbkAYntNKCcGssGc8uH3q+kcRZv+Iluhtj8x9IztyBANrx+E4BH8mU+K+CyC4842DasA
 SaWGryfTwKwFAK+/nDGGEN5NZWnSgvgxVPUEq5Iad6ui+ZbKyDUoqFZiQnGuDy9DUt8X6SvII
 SS9sBmTNaz7pt89U40Zhc22bc+MwncQBicmBZREyCTbPcGgWocisQMoC86Okx5rY7lGyINVw6
 yZt9eQk0XMwNx8UQU8sRAiGLk2d5LMcUGPET/C7SxpVOA=



=E5=9C=A8 2024/2/23 21:56, Anand Jain =E5=86=99=E9=81=93:
> To better debug issues surrounding device scans, include the device's
> major and minor numbers in the device scan notice for btrfs.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Maybe you want to expand the device number to all other device name output=
?

Especially considering the recent device name problem, device
major/minor looks a much better supplement.

Thanks,
Qu
> ---
>   fs/btrfs/volumes.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 32312f0de2bb..6db37615a3e5 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -824,13 +824,15 @@ static noinline struct btrfs_device *device_list_a=
dd(const char *path,
>
>   		if (disk_super->label[0])
>   			pr_info(
> -	"BTRFS: device label %s devid %llu transid %llu %s scanned by %s (%d)\=
n",
> +"BTRFS: device label %s devid %llu transid %llu %s(%d:%d) scanned by %s=
 (%d)\n",
>   				disk_super->label, devid, found_transid, path,
> +				MAJOR(path_devt), MINOR(path_devt),
>   				current->comm, task_pid_nr(current));
>   		else
>   			pr_info(
> -	"BTRFS: device fsid %pU devid %llu transid %llu %s scanned by %s (%d)\=
n",
> +"BTRFS: device fsid %pU devid %llu transid %llu %s(%d:%d) scanned by %s=
 (%d)\n",
>   				disk_super->fsid, devid, found_transid, path,
> +				MAJOR(path_devt), MINOR(path_devt),
>   				current->comm, task_pid_nr(current));
>
>   	} else if (!device->name || strcmp(device->name->str, path)) {

