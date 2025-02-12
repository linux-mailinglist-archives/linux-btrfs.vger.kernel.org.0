Return-Path: <linux-btrfs+bounces-11398-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC547A31FB1
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 08:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D364188BA3E
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 07:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0507F201271;
	Wed, 12 Feb 2025 07:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ig7U2MD4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC68201264
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739344505; cv=none; b=eRxnkMtJjGhYatysSGeq81Qonz37Lpv2O9j48V1Q+V/ojdPawuOn8xSICg0LprwXREQtT8suZleuQyAkTQK5iq/OxkGwdwWAxTk3GwMiEkgTM/tKDkBVAX7k3a4Dz+kNoBpZfHhXILYFGKZOSDb0Ld7KAAXCPqnJEsPeDJLwvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739344505; c=relaxed/simple;
	bh=qZKFw1t6YAWJPRi7SkIYVohYUr4Ijw7LOE9uuK0PtA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PWZmGzzpp1XRNivHiwpJWH62HPrhnxJM5rlVTzIrVGYCt+SOTWPrIvl/Q7K10E56xsIjeHDeZmTe/gzBP1hRUwPYMs1sVRLjDTf9k/WEhyLX85fGlNruvu3KrVm9FHD/0rlDbfGCEd+z372+UXmAppa6q8ckKqgKDmyg+/T1DxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ig7U2MD4; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1739344500; x=1739949300; i=quwenruo.btrfs@gmx.com;
	bh=XottnKGhEcNqsz91YGyQ1hp7O8VR4ulGZrmwWHaEChw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ig7U2MD43QZ8fFvUpQHJ6QTXWJqevA/sMd44Ah1cXG/wIq8K8Z0kZVqQbAEr6d7Z
	 5zFxwudmRSC5PwmPBamGgzF1h4Hgq9+W/IQ03ORiWM6E245z9Yhl0mNEFWytfvNVW
	 ZbSOy9UHAIq6ebP6UZzd+mckX9S3Yzgfv48GXSQ4MavnTlclWz9NAwekWKGSg19ym
	 Avwspj9VG+aSDJjH+hMib6aIqy5h9AQVyCEVn/r+8Qs3HHxkdCZZbCw6J7SK9wp9X
	 ybZJEpO21tUQjQYASw3HQiEaQrfaXcRlLqnatFTg9SIfrB1F9mKRIk0gm+iP+9Ctm
	 C7ygcPvtZTcrMDbcTw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MIdiZ-1tcwXx1Nn3-008tU4; Wed, 12
 Feb 2025 08:15:00 +0100
Message-ID: <cac8d40a-b631-4c58-b8b8-70db3ab58443@gmx.com>
Date: Wed, 12 Feb 2025 17:44:57 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: Preserve first error in loop of
 check_extent_refs()
To: tchou <tchou@synology.com>, linux-btrfs@vger.kernel.org
References: <20250212064501.314097-1-tchou@synology.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20250212064501.314097-1-tchou@synology.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DBNtmpFrw6nvGCDWN+UILFSwX/2YkqQ63QsNS48gwwj4Ld5nETZ
 MRqcHndKXpwJCRwr0+AArzLlU6f6j+O6GcR7Fey0E+mQ8l1wH4dgnMJF6mS1QPGt+pLwRTt
 3CB4l6eL0xWw4eXKThMdrzSZN1xCnVJB3D+XXizfOWxaQxpA8mSgEjYBsCg7k4YOEbjNPbI
 EBkkT/477u+fJIDVnmmBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:19JXstZLTeU=;YmstHW5j2/DgApKnUhC1AFJrGWO
 dvaNaR0gLhPzo5GERBR10TElR+LtUVh6XkeX2G4y1Wgyz/aukArk8WkvzBXP7u7s6m+rJ3oOl
 9d3JnopMyIAWjCl3410/CRiGcfCR0wqjDYmy1HwDIOMFRwD9vRmHeIbi2oXtbySiQDBAZC/qW
 xe/gWhLHHXOIezfkYprYBBJSIP/Edbyuu9kk9UTtTf9MsHDw2ZJ1iEuNoSjL+KQmDUNXQdvTV
 TT96Qcy6S1XW0mp4Q3qbAX/w9DVn2ibvJOs8/cr3NN7Ttp7DTSY8+XjwazcnoabiHCDfMKPXi
 bIc3dsV58s4rTI4S+yD2ki88v1nn4O5H8arycq+V2/XxesA1JvPRMMQk48NTfQPFw4/ogYb9f
 PucD6h4tEoXBRfhVB2sSdc9BfcYr9kx07/sr28zzZGPIhTCG6ZdMztG+D8TkOek1nxC8Ps/4z
 ak7uES3jbH3PiBFTz5KYB4kSLkyTkKi4WFrf7Ig3m297FN2uZVoKmIwiguK7gthKiiNtofv6M
 qPPOG1zbMNKu6Hxisjoc2+a/6MbYWT14Rj58Wekcri02afAzM7BoqXsd/doxE3dRsXmqGt83Y
 6rCr+42GNgORuw0kNa0NLsaOZsT1jVSRgTcaN4vswoAtYqQP9rRR5BJ/tizfPKkxVjgwXqOGq
 R9Ttlu9PC+AShjxS3ou3U2+5q6arYh3dy6WyG64Z/O0kmzSOx8OhSgzyO5tC++QEOawA6SQhE
 JE+nIt7Lq88hfaTgB2+kVRsl+RM/dgXdvjXEEiG4p1eVOvh61cNkXYBOM1Zm/qfG/pUgD9W6R
 H8EJ5oqcXe1thuDBqSt+Ya7sHi9+DU6QDu02UwwoorHTpQgbTyY0SuFQBMaeB/tI+lUVoYPX+
 pXilOTcXRMtHd7NHhJ6X0tdL9bxICr3csqhuvcfOf69D2sNqVh24GiFkBbom0FPWDP4Bia6PY
 JYk094byUt7wpY+hbTTiiaKBFwZhwTOiwhCrY4WYvC8zg1HnolSsbCc3vddLTFHqnD3C/fanW
 +P6IpphKtetzkLL6gKl1WXvau5C/BLdboMM5XoS2yHqvpRwe6fgunlyTCmCivAkeCxtQr/CWe
 xS1UtOaGYa8Nt/TPFvUAMP1IQB1/+Zer5Sl1CnI5ShjhdcjFepKFh7S27nZPSZlV2lFkrJnw1
 4BHq1N17YjC7WLAcDBklnMccfn+1sqd0C0UQsK/sQhEHEu6VgS3Hrfdb4x59gsx8m6SDMKchA
 ziIKbsFXxjwQ2cwAUzh6JkuIWl3FcrNvOEzvayxKC4KciCitbNPhjNHJkGneJrLTcVTYmomKH
 qbn0TNEutMffA1mx1+ELRAo4o1QiNumRQ9ArvTFKo3QTjmzcq2TEQeT0kxw+8w9HOFSEDRP3B
 estD8057+F6OzJjSf0okhHJ7CbAuGFXJtYmannUeKtVP8asO1Pqs1WN3j1



=E5=9C=A8 2025/2/12 17:15, tchou =E5=86=99=E9=81=93:
> Previously, the `err` variable inside the loop was updated with
> `cur_err` on every iteration, regardless of whether `cur_err` indicated
> an error. This caused a bug where an earlier error could be overwritten
> by a later successful iteration, losing the original failure.
>
> This fix ensures that `err` retains the first encountered error and is
> not reset by subsequent successful iterations.

SoB line please, otherwise looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

And if it's a case you hit in real world, mind to extract or craft a
minimal image as a test case?

Thanks,
Qu
> ---
>   check/main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/check/main.c b/check/main.c
> index 6290c6d4..974ff685 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -8322,7 +8322,8 @@ static int check_extent_refs(struct btrfs_root *ro=
ot,
>   			cur_err =3D 1;
>   		}
>   next:
> -		err =3D cur_err;
> +		if (cur_err)
> +			err =3D cur_err;
>   		remove_cache_extent(extent_cache, cache);
>   		free_all_extent_backrefs(rec);
>   		if (!init_extent_tree && opt_check_repair && (!cur_err || fix))


