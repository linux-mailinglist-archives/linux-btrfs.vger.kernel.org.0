Return-Path: <linux-btrfs+bounces-10454-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2C09F44DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 08:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87DB3188C04F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 07:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE74171092;
	Tue, 17 Dec 2024 07:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Bze3SqyH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE81B14F9FF;
	Tue, 17 Dec 2024 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734419680; cv=none; b=JMpV18oabA5hPEtZUPtxjjK6nuiP9rurs/1CAzzGwLv+1dBtup3OaccgCjXPpLwgqAhvQggS/c/hiDErccT8nb8Ixx97sln+RqlQIYACJD+usCCVSCop8hsLrZ79U1MjXvmSEIViP/w0qi0tJpwlrcPdeTSmF8IdfuxDYcyskLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734419680; c=relaxed/simple;
	bh=5heYNE3l5ruQitAzAwJln7I88Ff3lWZuHm6TiRUFEZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twQr0so0VjhJDBxW8X1881l75/DuPPL6LbZKgNtqS5yMS9JhfeGCsSnpt1beN/u8dC5Stl3iFg8Dp7GomuyoAN6JDrSAto2vqRmXoKMtAstLtLJ903w3qgEgQh9Y+O5WnRKf1aj8RB6/fCMvn5WUulbagKDgzBfHrzNYQhH1SjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Bze3SqyH; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734419648; x=1735024448; i=quwenruo.btrfs@gmx.com;
	bh=Q64u46a1YN8+NQU72Udb4GgvA1PW/nJkLN7NzTa3xaE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Bze3SqyHtoGS3zDYbavlEFQAY4B+6b6eojzJodKUcIJe4nBMY6+yZn64Edlh+0EK
	 7WqFQAlJSPHeejMULm+EaP7H/np8pEaTYtlsFg/J97ySxE8fwkituMuLkzshMoJp4
	 8VU+58s+nynK8BhDAM0b4+ylvpDoG77sUm5mfe11UH6p1ywEQaLFI1VxplQ/ovzxK
	 WJYAfQPt7sR8gd4GqeBgVivKsUha3M0j3sH5UaPAd9tyY0D4O1B0/Oqw+3Pxr034a
	 RJQfSKIj9SnYcaamiGoV7SHgwmAziCRKdxsi8/SBQvniGX4GwatJy5/g/7jlrJuaT
	 oqXFP02pmDC2aMMQyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzQgC-1tjfWZ2zrM-018A2V; Tue, 17
 Dec 2024 08:14:08 +0100
Message-ID: <0199c644-dfd7-43ce-b02a-459461299fb7@gmx.com>
Date: Tue, 17 Dec 2024 17:44:03 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: don't include '<linux/rwlock_types.h>' directly
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-kernel@vger.kernel.org
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20241217070542.2483-2-wsa+renesas@sang-engineering.com>
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
In-Reply-To: <20241217070542.2483-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MyIk/yR8l9tIydM+GS+CJg/hWbgy6JCFHfhg3V6CKDNHt7Jp6rP
 e9eBCDIJXdTrjWfSsZb/3/I1F5L7irrNry20SdC+GKhTNs84wCD3Tn1VfthDuFKhPisqAhQ
 ywodw0wG7NEXA7iBGotgkEjPe9YgkvQTdQ1YADREagS7xhci5+n68cW9GJqiWVliYuyzCLr
 CP2rwOdwRSXIq47hWhVSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:keEa814YlRI=;Bm/azDMbuufxEXSOOnA5pImw+q+
 6BViNHqHHTFAMwFvae4SuK/lomzzkX1oNtb0zY7lfXP5OJfefa9YqLOxAFzLkyfuE5816F+Sg
 8CgeY53oIa7re6DLNmBEvxiiZLoGSrGEzdG+aJ5q6CEVk2aFJpfOWShh8ajL8JBZy3W4ypSwj
 O+51Pm9Lbr5RszabldjMkM4tjfa9IxgyZDIEseE31viZCOn6PTenSDfcOKYB3XxrGx4Kvbe3O
 oFg2LxI+O7mlpD09vk330dDoqQiGNk3giiiSjX4xKcL5vkKQhBuoF9JfVeL3o9szsBY53oLfN
 57W7fEvfHbVUMw8KXPuwOLlzQjqqPMlXV076sIo48HSvPXe6HBlk8vREUhRCBvPECdHyg4Uj2
 B3sXnLDMJS/n0IseyqKRWqn08IUPV1n93Uc88sLHLdGWllEV2mrWY/bUky55VwgeBoEh7Oaz1
 E9h4ZP0K1fU5Ix6BFjPQXrzZtdCmufLyK77zhNxwd+n6mEAr5glOQXqXuvO7AYCnPdmJX2Bsv
 sykZsDEw+o2Zq+VIdEbeL7i+N6GhsC06yvdpehiEUcNOzX4HsmOTeyMCRc6n0ljwJU4iF9Ww1
 3PeiEBdtLHECUXwaKLo/btzKLpgIT0ri25PIvLSllV/680PxJGDBhdvNcfDP3E8L8dGlHd7kt
 jlzbLvYVwzmk8EmQN6alhKPWl8xC5qe6YQaEE9NPyZ/7QuZKhIJcBdtuGIWoF/dDaidrKiPhe
 luTenmKE0BDYkIo5mKhEuY1E1KAieGYm+BJNfkS63aEE+oD8QknzOW1E8wEclPmbc69Ss3/EQ
 /SPS4wxZV0sZDGPcuByYg4E+H6AMVQnQrRDxLYaIWJK35aw/mqnY62UPexwrzxk9Z1ZSfQgz0
 vprK3dltTmviu02k4zBkQbBcbkJ+CFYOQ5QgpgK9cUdWhcxXQ5Q5j/KAaXg9go7KC3+FBh942
 8bX0PRIhaQct9vuq7Cem9Sr7UkRTmOXEvEC67DXt0YZqTbmixkWMFAaul4Oh28mwuMAHqGrUj
 08MM57YctqE86WUGC+TxDRRFARcB7jNCYb+Nfts65VzcBV+5znlC0R5HCtYX01zfuyLcEmARH
 4AgVvN+F/8EJQEEtAfBycLgopK5ene



=E5=9C=A8 2024/12/17 17:35, Wolfram Sang =E5=86=99=E9=81=93:
> The header clearly states that it does not want to be included directly,
> only via '<linux/spinlock_types.h>'. Replace the include accordingly.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   fs/btrfs/fs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 79a1a3d6f04d..78e558652908 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -14,7 +14,7 @@
>   #include <linux/lockdep.h>
>   #include <linux/spinlock.h>
>   #include <linux/mutex.h>
> -#include <linux/rwlock_types.h>
> +#include <linux/spinlock_types.h>

I think we can just remove the *_type.h include header completely.

For non-RT build, spinlock.h will include linux/rwlock.h, and
spinlock_types.h unconditionally.

Thanks,
Qu
>   #include <linux/rwsem.h>
>   #include <linux/semaphore.h>
>   #include <linux/list.h>


