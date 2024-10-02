Return-Path: <linux-btrfs+bounces-8461-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A69F98E4A7
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 23:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219AC283FE4
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 21:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B72217321;
	Wed,  2 Oct 2024 21:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="STRUGHJL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBE41D1E60
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727903620; cv=none; b=p4yXxq0pbSoXaOn4zaGPzfKUZZHV8pFsh6TOyCwPfRQjFhZtw68G8I34wuqrc6Ac11YbtB6dyUNSnn4burMFwiXsx0bXpSPmA779YH3vm8FnuPfPjNehQADLn4X81zkDc5EPrdAnOoTX3Z6G0CnaLt2b4L8QWfygfPnxG4JBhfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727903620; c=relaxed/simple;
	bh=Zd315xcRxxeeT4wodXsztkoV9pKEyFx9FZHYWf72daQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DOnYCcuLgbmqYb38Psw86oEWzJ3mv3AdjeS+c3V/tP0SZW9AtC5qpwS/MpqqK73BTBqzcdi5H+bMjhi6P1fpEp4Gi+g0NeZa1jiIBlulo2MgUV6isbl9PDAuvfGNLYtfZmfyzAuinQ6J1Fej0bU18/D0F9YEnl6oz+XL7dxVzXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=STRUGHJL; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727903610; x=1728508410; i=quwenruo.btrfs@gmx.com;
	bh=lFWE4OyEI1t2870C/EmlF6Qq4o+dr9YMBtOCVq2fsIY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=STRUGHJLKxHYuCmQvef4+Uo1GG9Be4Dc3ACLbDpft4B5fKpAOEJboEcEioca3dhT
	 r3hovL/BnbAHQV1ONODI1hbDYQwLF7zHGSoIiU1I/ZdN/d4JnTtmuXBILeKCuASmi
	 NFN6TPh8aTWADg0Gwh56XW5wNxOHM0LcGt9dNAiqXaxdiC9h8l5HvoAcN0BH/cn+R
	 9n8Y1T+7cJ3yjM0v/UxZdngcHGCVQdygykDyNfNDHTHAZL6X9xSWPiPJ9jrqHqWVK
	 zZvLxwy/Y340Qn9GpqYPcsK/+Lv4fa8uDJ//0Ae1Qgdcy3rQm8qN/H2hTfFKO3s+v
	 ueioElWcy4N4qnSPzg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1wll-1rtwLQ3yjh-0181Tz; Wed, 02
 Oct 2024 23:13:30 +0200
Message-ID: <fceb2e3f-9af8-421a-baf8-207054c3184d@gmx.com>
Date: Thu, 3 Oct 2024 06:43:27 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: zoned: fix missing rcu locking in error message
 when loading zone info
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <446a65bde464d5a19554687ffd1944bfbf9062ae.1727878321.git.fdmanana@suse.com>
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
In-Reply-To: <446a65bde464d5a19554687ffd1944bfbf9062ae.1727878321.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rO0VJdZGscTuyPDn6/ZWd5PenbB+bcUUPk7GknzJRma8Oz4q59L
 JQkEApuM1Di6G7Ret3ArypEyAwp5HzIG0TPSxMz1p4I2olSw3maa383bmRb5ZcQfu7ThD76
 aaZvqaJBh9BYb1AvSgJhPoTSdLdND4QlkXDg+oLcTt6IIFdSPohSjVigurxGi9jyMtOg7qz
 r6QdjO1+ADvKZtmkRyhxQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bF+QOYevMng=;g1Seqdz4cgJ4IhiM9w3f55r1Kg5
 eFxqsLD6QtIloBRHFiO4GZI1HghRTYGctz5clVdVs0hjuRmVWAZ+cFpuEWZEfcFB34qz8orRp
 9+EQUgaj1GnPba5VV3hY1jbzvb468aAgIoB8z/5/8nQAWD9btTrtpOwtqHum1SEl6TEU2pQuw
 SW8bp4JRoKroDTg4Fg5wpOYmZhJBGkV+J0gM4mzY57EBN5MR89Vgc5JPAGr0IvEHJMVUpj5qg
 DvNX5NtkWHWnrEZPNy37U6/92TWEZ434Ouv9+s0jaOj6WgQPkamCwYreJ/Y2mFKBqYO6GloQ7
 XexPGlwm0/iEZ4+GWqvFpFyNPjmKb4xJew7XM3dBq3toHbtmwM68DyMtQL8yimVeV7XRltPBx
 yEnj9BqY0RGNJhqG8bdFTOAeHgHMZTIJGBYl4iEQvxJuLYSK3tEfvypx02Soxx5VKio74f5hm
 aP2fCFVBefl89gVLgh3wlDX2UIUehaKqwlwSLcVIyxWAshIshOa132ksOGML1l2wU90IVIuI5
 RXnjnFB1YYH0LCQrjpkiaE2wHDm9DRKCJS5IIyjhlIbg14BLDPpwhYqZr6MECdlG2dHq4diIO
 /gRHgM3naCHsvX4Viqwrapabk9L6NZOdfvSnLCD+TMdfiQiIr4WH/2UmOrJujwiN+18ZGyI1d
 UtHjI+tbw+ZzdcFGUlt3cEt3tv6jTXFONjbc5fUGzttKC+du4UAYisz4DSeDYE+sWJ+JeX5ZG
 tI4UtFlcsDsqMtCdv8UBIZG5Xy5m/pzq975os6Jxmt5Ilr+H1KrV5aSI0mhDblLcxTQqk2JLz
 eJgl06kx7bjNR+W7BRJx0+GRfI2iQI9tQzW9KMMnYimY8=



=E5=9C=A8 2024/10/2 23:45, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> At btrfs_load_zone_info() we have an error path that is dereferecing the
> name of a device which is a RCU string but we are not holding a RCU read
> lock, which is incorrect.
>
> Fix this by using btrfs_err_in_rcu() instead of btrfs_err().
>
> The problem is there since commit 08e11a3db098 ("btrfs: zoned: load zone=
's
> allocation offset"), back then at btrfs_load_block_group_zone_info() but
> then later on that code was factored out into the helper
> btrfs_load_zone_info() by commit 09a46725cc84 ("btrfs: zoned: factor out
> per-zone logic from btrfs_load_block_group_zone_info").
>
> Fixes: 08e11a3db098 ("btrfs: zoned: load zone's allocation offset")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/zoned.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 00a016691d8e..dbcbf754d284 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1340,7 +1340,7 @@ static int btrfs_load_zone_info(struct btrfs_fs_in=
fo *fs_info, int zone_idx,
>   	switch (zone.cond) {
>   	case BLK_ZONE_COND_OFFLINE:
>   	case BLK_ZONE_COND_READONLY:
> -		btrfs_err(fs_info,
> +		btrfs_err_in_rcu(fs_info,
>   		"zoned: offline/readonly zone %llu on device %s (devid %llu)",
>   			  (info->physical >> device->zone_info->zone_size_shift),
>   			  rcu_str_deref(device->name), device->devid);


