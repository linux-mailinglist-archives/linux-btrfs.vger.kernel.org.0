Return-Path: <linux-btrfs+bounces-8636-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86BE9941EF
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 10:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6262328D621
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 08:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F28420CCC5;
	Tue,  8 Oct 2024 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lQyua5sr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E201E47A7;
	Tue,  8 Oct 2024 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374186; cv=none; b=l4Rh2c7t1qCDIp1+0tUKIur8kqAw/ZMjZ4CgB3ntLMOgNdrZEGnJdBl4US4YicjzCReLqgoo3IbXPuv3bPCwkHLHhsMuA1OZ61IF2NO4AP5bacG5jsevA+jSQmBXSASagRq9YfHev7fdubp1gBT9YrgiAJrIgrgKnY7wR/vAnC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374186; c=relaxed/simple;
	bh=wkNtVrzpDapfmPXj0m5Y3cbKq6acRacSwPrVxZfOcgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Umw5PufGkKSi1tmN+akuIaGvljFt1WDgzfEETESTaZAlBxofab0zdN4v+bc5v1KPT/8gdhHrdslHwOcjSllnG9iiHK6Ng341/EuVZVHzOGwJgh8e9r2HDus+nXCzcYZVf4MXZBfetGrRZ3/99mVuapd3dnMzy0o5rpA8BwIMc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lQyua5sr; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728374164; x=1728978964; i=quwenruo.btrfs@gmx.com;
	bh=O8adsJJasvu+KcFL/LnUvXSTWjd8GWf24KuQpggU9bk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lQyua5srkoKC7C/zbX07KC+sOi/tdqA1qdqlHuBqpNm0LMcBZh01bn4Gk4hUHuIJ
	 mzTUyv3obo8q2KCFv5CBNocBTEBkUok2sSNct48KIG4Wo+r1NUQHZnJEABLANS972
	 gQFDS/CXo6baL5qDCAMEA3VFNN/enthbZ/ZxfZ+n7/eOSXl/OCDIbt2fth56WaFc3
	 u86yAzH/zvKyIF5nIR2mt2LzNPzp+l6dICUSoQnfJGIFq62MmQblJWmSpwMlsPg81
	 kVUiGjtange8/OfNvI5r2VNMKeleZG5Pf1F7LyXpnoYiecIVWx77njEe72yVC722s
	 DdH+3drail8/PD76EQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mwfac-1tvqf80mny-00uWgZ; Tue, 08
 Oct 2024 09:56:04 +0200
Message-ID: <b677188b-b41b-4a3d-8598-61e8ccdef075@gmx.com>
Date: Tue, 8 Oct 2024 18:25:58 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix the length of reserved qgroup to free
To: iamhswang@gmail.com, linux-btrfs@vger.kernel.org
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, wqu@suse.com,
 boris@bur.io, linux-kernel@vger.kernel.org,
 Haisu Wang <haisuwang@tencent.com>
References: <20241008064849.1814829-1-haisuwang@tencent.com>
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
In-Reply-To: <20241008064849.1814829-1-haisuwang@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MU2SWIHfr8X64JNRRC9dD1ZyGiux3kSloRc/laqCfUiSok5nGix
 T8SO/3C4cpb4RuGTUdxrC+TGyt2PwGBmsvtHF4mvX+BWzb5xLTin9Rd0Lf0gRAH25U6ZjLK
 znoWmU/kAwag7i6EOFEZ79upcbN0Wu48TakS/juxrZ5UBHy0KA1DURK0Ce77XLIzwgVBea/
 IkIk1bDgLecqEgctWxG7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Zv7RyFvEMgM=;ArnvRQEpBgcIWIeuL70uDYpq5vw
 lZ3DKmfcFTvQh0DIJxL6BF/O3GxsN3aCDPK7QuDgek55fDn5QdwwqREbL1Az1CNZKEtA+zU6u
 iFkjyViwwyN+6rjlLi1OJPVQzUFDjo6php20AYrof4vJQDR+CLGs4Kk+glEgKLr8ziJ9bIoZK
 1we7GgoI5qE9tSEoq4u7bEsBkk8WeRRnRt0t2blx6GxAJiJeflLOdqRdz6NpJgpnAWPuM/2ty
 e4g4UO4xavS/a1JVKVNWpfCRzdaf8zZVRgvl6t/dHCHAOADBYbmQ2sVIA79EvnUH7BCl0q9H0
 hqygnXk1PEAn/ZT44caf7lT2iaCcrer8SEdEhKjVPVlmOWURY5BFajYpq5Vxu9YB+km6geRy5
 ErycobzBMdHkhZPUFkifcAPesywbEZnOlRVZWbZdMFsxUHsuRa2tA+SHJ0L2OHI8Ym5OSc0Do
 6OeL2P+hdmYhU+KPQbt/JTzBM32IVUyT9DzCHZLREExzmTJ+tk8uoZbCGVTmf8OBfKIQnWECY
 DJqRCtjEUVd/ds6W4vJvlaZoDoPwNzv2ZcgYV6FZOZBZjs0jXaZE+ZXT3IsPoDA2MlC/rwTKw
 vOnIFhU0r7Cuj6/2FjhnfWAZ+fIjOrbzxaI2m8G4AAaaUPtI491aUXTne+uIWY8DzKZbkarWi
 zlXBSUFGe+ZwA7jZqvnFeMNs8HZnk051VoB18tp405PmhLwkJ8Aha+UW2RB/i30DiYtAWOzKj
 tpWiKjKAw/yhTS58F62fEhY1PUO4yITk+qtd26rAW4iudquMmDVeE9owSq9G7yTxNLeKMpqa0
 fN6F78PAIBplj6FodBEWOG/Q==



=E5=9C=A8 2024/10/8 17:18, iamhswang@gmail.com =E5=86=99=E9=81=93:
> From: Haisu Wang <haisuwang@tencent.com>
>
> The dealloc flag may be cleared and the extent won't reach the disk
> in cow_file_range when errors path. The reserved qgroup space is
> freed in commit 30479f31d44d ("btrfs: fix qgroup reserve leaks in
> cow_file_range"). However, the length of untouched region to free
> need to be adjusted with the region size.
>
> Fixes: 30479f31d44d ("btrfs: fix qgroup reserve leaks in cow_file_range"=
)
> Signed-off-by: Haisu Wang <haisuwang@tencent.com>

Right, just several lines before that, we increased @start by
@cur_alloc_size if @extent_reserved is true.

So we can not directly use the old range size.

You can improve that one step further by not modifying @start just for
the error handling path, although that should be another patch.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index b0ad46b734c3..5eefa2318fa8 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1592,7 +1592,7 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>   		clear_bits |=3D EXTENT_CLEAR_DATA_RESV;
>   		extent_clear_unlock_delalloc(inode, start, end, locked_folio,
>   					     &cached, clear_bits, page_ops);
> -		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
> +		btrfs_qgroup_free_data(inode, NULL, start, end - start + 1, NULL);
>   	}
>   	return ret;
>   }


