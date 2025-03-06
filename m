Return-Path: <linux-btrfs+bounces-12066-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F973A55909
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 22:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F2E3B2F5D
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 21:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FB427604A;
	Thu,  6 Mar 2025 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gfDW8n1P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B542770B
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297465; cv=none; b=Ks6gGFO1cbeJa4U0vJTw8DP0Ffr4c3QX8+VZsVlDxMQyDmA9LtpbzK3TZOM4Us/O/uP8yGNWhG8r0ex54+y2xWUVjaLPnRcLKhzqYmkvxPajjxyjtgOVc5qAaau9bq6QEBuLB+zionqqKZCqI5ovqOYBXPVJH4mj2Mh2GrgXpKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297465; c=relaxed/simple;
	bh=gWmrN86Ah5Llh+FxrsF8LxUtJcEPJCCyepKtkGNQLVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TiUHUpoPgJqUpAnH4er0iHUP802UWxtfXoPxDYXJHYX0UfnvOfooPRXefLUXp4HPNcKxYWb6+Q9F4rp2ejwwgphoyP7teiAxhnJVlxH6eXXY/8tF+KupCWrdVf6MzE/jgKFBNVomxnaZhN7+fubhftCJHefz9RA1X0rWVIB3sfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gfDW8n1P; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1741297458; x=1741902258; i=quwenruo.btrfs@gmx.com;
	bh=3LKHfSLQ5ruLMsQHeMr8wti39mqa1m2StX9z5iUb3FM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gfDW8n1Pit37nyhsH3eYcWf4KCS2wx3KnAsS3BmHlnJ5iVKducWgJQIJeFuWifN4
	 YpQx6R9cptBU+k8exXBpX3t3n8TdX7+fFe/R7/SQDPekfN+nm/RKBoe2vkiVByT/7
	 CLnZalGlx6qcwgd0ggCm0iE6yDVF2yo37ZU6cOojU+bE9qWVdHxURMVD1jmxd1hhX
	 /XgmrU/cZAzUo/L1pWyo8hOz5qk86uFwqPsHj4KgsNPx88BvFwfytnUE7N0ZpJTmw
	 PNRXUZFIwjjyfAls60W91YOyfbvBQ0kmcdFOLYMwZsCB8jKfNHse+GdF22HJV+DSC
	 BC0h6Z/ZRRvHADJQ1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MDQiS-1tzgOs3YmM-00GYJL; Thu, 06
 Mar 2025 22:44:17 +0100
Message-ID: <2495973a-48ca-4629-a82c-361d4670a309@gmx.com>
Date: Fri, 7 Mar 2025 08:14:12 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: avoid unnecessary bio dereference at
 run_one_async_done()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <f0e1ad9fd2ed3e76e041e3f19f493de3e9771057.1741278026.git.fdmanana@suse.com>
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
In-Reply-To: <f0e1ad9fd2ed3e76e041e3f19f493de3e9771057.1741278026.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oIkcj3wXBDHvspN3kIgQmQGP9HF/dZ5N69b/2wT6OHMrBKilIHd
 YKNxROJnTuZmvtrecgV8hObojf56vILCV1WDEcYDZIRbzUuf4XFtDmjHkQr55PEtlHwxHJr
 2qZy9GHqWgQB6n9/7x2DHbjGUerjftda8u/k8uNx81FafSEqHZFcJ+53u9CgIgGL8/nPg3Y
 B8Ep2hruudmLH+87wFrSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oyZv/aO9/kQ=;UrVs6YQXIr5TvTXpqRKySelO2cB
 9e7LUDuoimVCY15FszkV7hqYiSmRd5E7bw6HZiY5EemnopP/d9T0tTmvHd/njppe4A1OAxcEM
 YOlfRt+Lsng48h5Y00Udat0TRryhJPpYqhkp4ZtFI7anbIz/+bfUPAPlHm+VtcCoP1tyHf8Ap
 SAnsd/Fblektt2IWUij088MvoMv16IwJocjSpzA01rO/rvDa9o8yJ8xIBfgCxbtCbbVPCVmW6
 RnWe3sDrJjIqfb2FLPsDERZvHorK3RE7Hv4Q65o9HA/e8EY9OkXeX1HKAvCeSxKLbSogjf60I
 k3pPCy2KFppBuAODsyrv+IEr9YqC6Kodw2hnV1AmtFrr2PUEuxwbbl9kwsoSi0iHHs40rZLwN
 KScBo0r6q5HJ0ll3xZtnxBvBnclLNSp6VLPJxCZJyojlpzU1skBmeyO/76qgjW2KBsGtXbJjU
 1pEWGdJtTWDNV6yHxFDKDGsqs16YOSqA8NGFyTBDpUdqTTm7zPw5m2vb4jWFVEbSubtFaSzE4
 C0V6SD0R1yU5vBddMJURqRfsQsyfuDBo8g7zOAfVMsC0gxSNEupw10YkzxHoQXTyppst4IqqX
 LYR6wanK7Y7UJ3ewtIfVtGDdw5mum2ArQVvQZGz9eRdL4RUa2y7NoNG4Wm+VEicQiVrurM97J
 JeTQo0G9jOnScfVN6Gal+IIAbWH0y871VPVcxBtNOdEZYjM2ddMqZsolznVifi2IvkQyvlbM7
 jCVy2uyu130iKpy0Sei8A6JZpkDe2hMBXOxCJMgg04uAtxvkQpv6Nm/J7f1P3J5EtEWlqmSQS
 Xox3ogdm4o0CJ6Wa+OZMVN/nEg97VVywcNi8dPVEVAMp+aRLMQGURlovXMl3bTmXdVowip6f4
 Xppf0/tzne+japsVRmp5EgEZhT2EddojjPULDKwI2aJAxjhF/XqkC1jRsgT8ZUs+NXQyI4lEU
 OJQ0fGRDJ9VhYOtEQt0+/iBF6DyzE5K5A4VqIfOKofEjHoH9rOyD+03BYEqE+Px1v1LJHfQY8
 HAMQb2uDMbfNlu/CCUCiMleVFJjXVTjvFP0D/6nVEYluw2Ur7pTbMguBmUgG1gg8F17IaCz00
 OevfcBRj0GTUmUvhvCLsiflWtOiY6XftP8Vq46aeTmXkSX5KuY3a+xRvEYLez/yk235wmp0kA
 nrB0J4eZAE8YqqapsvTfCDWM9Kcs/2yQGWklu0OrkVpd4Re15Vayt+QTdpySAhm7urWAXgmxj
 CqNBItucxYrFxrAk2MxR/TumQghFLNzocLmtwv8DeBfQWN7u4OkGsr6X5xEr4lbtPaOtuKdCR
 fqSfBtI2pE1YkxkPc2jj2IWskP7wZjNUKaPpgBOrv4IVfrwGrQYsaLLpNrZv/LFdR2nc4NfZJ
 rIsIF8vRGVW+/gN8BA0QTSwJ8cV5Miv583VgGx7G1Wy/QVe3u9EY/WeiL+



=E5=9C=A8 2025/3/7 02:51, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> We have dereferenced the async_submit_bio structure and extracted the bi=
o
> pointer into a local variable, so there's no need to dereference it agai=
n
> when calling btrfs_bio_end_io(). Just use "bio->bi_status" instead of th=
e
> longer expression "async->bbio->bio.bi_status".
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/bio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 375cae2fbcad..8c2eee1f1878 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -573,7 +573,7 @@ static void run_one_async_done(struct btrfs_work *wo=
rk, bool do_free)
>
>   	/* If an error occurred we just want to clean up the bio and move on.=
 */
>   	if (bio->bi_status) {
> -		btrfs_bio_end_io(async->bbio, async->bbio->bio.bi_status);
> +		btrfs_bio_end_io(async->bbio, bio->bi_status);
>   		return;
>   	}
>


