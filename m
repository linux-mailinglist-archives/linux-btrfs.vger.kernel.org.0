Return-Path: <linux-btrfs+bounces-3053-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D9887491B
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 08:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6611C20D81
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 07:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9DF6312E;
	Thu,  7 Mar 2024 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="igrOrrBM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919A86310B;
	Thu,  7 Mar 2024 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709798033; cv=none; b=T+XgUOUqMCyQ3Afq9gqNculd4LKz03Boo2NYHgipFTGtwIJzFdsEKnjFBaIA1+MxknxPWHVgTPRhF5WXW5YHPQRwPaUwkIYBLfO1VeqpXJH1LAKm33KYVWEPfgrqs+9NsXj+bFbncrukVfpXPgheN3G3N5l7mxLD+9WfgdAMr3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709798033; c=relaxed/simple;
	bh=/r9nglCTC2FJFPdLO1PJ8IUnVPMHZHCS6fzCi+JqmGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYJWrF28MhHp9ExqRkw6er7wesyZcFGcczkjJ5Ar9tjXgk8kRlx/Os445KpnOEW4yEZL6xyk93Rr8fS6t+q1bRWBSatFv2WR/kUTF9x397zHPSqgHcXlT0415UttRZoe5B38Z/V/xOoI8ytzZo+lODAc8J36koBJmeXqK3oxymg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=igrOrrBM; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1709798020; x=1710402820; i=quwenruo.btrfs@gmx.com;
	bh=/r9nglCTC2FJFPdLO1PJ8IUnVPMHZHCS6fzCi+JqmGo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=igrOrrBMZj065dbt0VOyW9q8qgNnqoi0Ec6T1WmmJOQQWs5ExELzVkgWiYnGZclP
	 u+Sbx4rUg2F9dNCQKcvqVKQY9w3laQHqs9kZ7Jbz4/fkLZqVmiQqeUznFm38jRsPv
	 8pQZvE072kppSGX0/lybjPMRgcYK0zwmShGLahxGs5HMZMcPn+xLC9weeA1FGO7ml
	 ztOOJCfCgCel24sRBajZzKPsmxZ4llA+G+xHARIrMn0uyEuqByJKdBk3fN7+8vFdM
	 9xBfWnaKP/wNJdtuHgHD+BrXJqyrpeFMjWlacPWuQ0iNYhjXbTP20EtlBxBejlaV+
	 R9FXuOXbAgBy7uU+kQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTAFb-1rGp5w3HPr-00UXyj; Thu, 07
 Mar 2024 08:53:40 +0100
Message-ID: <40b4f295-5539-406e-ba63-384685cb482c@gmx.com>
Date: Thu, 7 Mar 2024 18:23:34 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: clean up some inconsistent indenting
Content-Language: en-US
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, clm@fb.com
Cc: josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20240307064753.36780-1-jiapeng.chong@linux.alibaba.com>
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
In-Reply-To: <20240307064753.36780-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mFeAy2gujGp0g2bAr+6kqawQava7lQ4s/qQSG9IqWJxZBxmx+c+
 wPNF/xMPmkfWcCO480raZxGqNAF66rhEO5lOrM+JghnHdBoJXcCvM9T05GayzGvqThUQJnS
 NSbYrJAWu643GUPTYRKI6TD59laWkIovM1IFKNsJ5xzDkbKJ9GhM5F7r2pLBU78+xO5FcFG
 BodvWF8vo9ys/8rCxAnJg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8R6GA3XgJYM=;D/yAHbTuhcunwevULF/I0M85Jo2
 QILqqdFUhOYo8U1cIdPgPKbk+jFXEKq34ZZFWIyXa7gXSQotoU0PGADGu94FBLCiSiFEcHtur
 nNeP5P7HGV0Jd5d/PDP8VHjQt+hCZgBId/LLJS65aaENT5wo4chHczrkucMtYooPgEbLNVQ7Y
 zMuRITvD/dd9uGmWlIEnZmYwhGLy0+QYHltcyzl/jXB7bP5JCa05AAgoyroHvxhi28DFCiTYp
 nai7AOb6oL5hOcx7kPVj0x/7dynR/pyLboOjpg7f7Qf92muIlzrQrMajKTGV14we+XzJrIj+c
 dq4KLgiqtzdJDx5WxVw8qdaGoc6V24B7mk4D254ZgoDTSlBEe6sUCBsYegsOPx3OO1FARS3BU
 kPVh70xCCz2YF3ZCNitYlBUct9LnBb1UbwvtnvXy5DNwJhmphvSDJVKsuHpSXwh8r83eaxdj7
 0pqJa3JGUhj7FjRQ7/5++jGTH1l03ac8B/l/VvCjnUZJzVHggPX47VXKwtUpTYRukiMXINI6f
 aEQdC4G15faYJmlQ2GLpQ46BYR/CttPF8MwNU+RIrYVe7ZfcbOOc8cVVFaMs5MwwuR539eEwo
 0AgwdhkT3zVBuUv0GYfo/y9fGKCk8OsVTtO8PmuAxLiZMk8582yzQFdvqN+kOJXdk0BBzXpUv
 jV57Ud5+nsN9btb3Ty56hTa507/2RjSm4J5ymXg7enMMksuRF3IaVrZTvoVXEDu+g17ITXzhA
 hCEoEYe0yq9FFqDJtwrK75o3kVw0vPHSkTSniYKrElkX4xUgioMTkUyyR+iAydBVqQC51hEzr
 uy5E3he/oKYq41mgeJvKUBNYB9B0Usgf9ZdjBiHoYnjaQ=



=E5=9C=A8 2024/3/7 17:17, Jiapeng Chong =E5=86=99=E9=81=93:
> No functional modification involved.
>
> fs/btrfs/volumes.c:770 device_list_add() warn: inconsistent indenting.
> fs/btrfs/volumes.c:1373 btrfs_scan_one_device() warn: inconsistent inden=
ting.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D8453
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Can the bot be taught to watch the btrfs development branch
(https://github.com/btrfs/linux.git for-next) and send feedback directly
to the btrfs mailing list?
So that we can catch the problem immediately before reaching mainline.

I strongly doubt sending out such patches would leave any positive
impression on the bot.

Thanks,
Qu
> ---
>   fs/btrfs/volumes.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a2d07fa3cfdf..caa3e83b0d6c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -767,7 +767,7 @@ static noinline struct btrfs_device *device_list_add=
(const char *path,
>   		if (same_fsid_diff_dev) {
>   			generate_random_uuid(fs_devices->fsid);
>   			fs_devices->temp_fsid =3D true;
> -		pr_info("BTRFS: device %s (%d:%d) using temp-fsid %pU\n",
> +			pr_info("BTRFS: device %s (%d:%d) using temp-fsid %pU\n",
>   				path, MAJOR(path_devt), MINOR(path_devt),
>   				fs_devices->fsid);
>   		}
> @@ -1370,8 +1370,9 @@ struct btrfs_device *btrfs_scan_one_device(const c=
har *path, blk_mode_t flags,
>   		else
>   			btrfs_free_stale_devices(devt, NULL);
>
> -	pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n"=
,
> -			path, MAJOR(devt), MINOR(devt));
> +		pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n=
",
> +			 path, MAJOR(devt), MINOR(devt));
> +
>   		device =3D NULL;
>   		goto free_disk_super;
>   	}

