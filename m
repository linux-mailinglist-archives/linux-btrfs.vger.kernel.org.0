Return-Path: <linux-btrfs+bounces-11960-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A03FA4B724
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 05:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F4916B2AC
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 04:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3901D8DEE;
	Mon,  3 Mar 2025 04:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="eYC/iLoq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DE41BBBF7;
	Mon,  3 Mar 2025 04:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740975879; cv=none; b=PGiBKTYYqZr8yusxucARJ6Ga6VQLzGAoMtV/oyituekCm5b7mZaSYWImUyhO4INCD2Thjd4EGccFg3m11fhaUwuNneZELE1RkXRh6NU/yNVTOHwc5IYRSbPxwbJkuULtvaT8doMfYZex1WCyqX3gEo0VPRmoverFeB1FGQQ4cBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740975879; c=relaxed/simple;
	bh=xZEHXYYvck4yuE2xVssqwKGCBzwJFoefcARJpkqhtvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OacwIdWUp3D+OxwtGuFzXar3MR4C/alt/cJfIg6xEdODYP9FF3gszjbbGc0GgzDLdONYzJmkcrFaTuLJYIiFuuT4PvbgkyMjN2tHcJLFjQ6zblcoNidgweG/cOAzjZnLJoS9aNQeOsNfGwMl6lu3wqpXbVbu7g9gbokB64f90rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=eYC/iLoq; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1740975864; x=1741580664; i=quwenruo.btrfs@gmx.com;
	bh=wh7ojeZLhbi469+4Guyv0n3piZHEYpQkVwl7Bw2iar0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eYC/iLoqiDLVENJP5NMT0DmVZGZpwvBmtpEKnW4LR+FMNlDuSb/apa2/aeTVIln2
	 7GgHnFt2l9rXbEUSzzAERio8FF3RAI2gH0DZsyE9usiYJDDXa/EnnuR+ymB+i+9LF
	 l419cNbpFgEclO06coxS2f1xeer538OIKe/OltNAysByaFhWJz6Cwl3cqEmZFHRwZ
	 F6UlvThnu0JsuT+oYY25HVagemnDsE0rr7qRV7swnya4MVRrEAdf8qZd0Kjy/96lf
	 0kVB6GaoRkZbf3goWouRKj2F/hERmho/mDfOeP5cc5S/3MZoIuA1OZwgp9imEK9Yq
	 AhvWhL84zxp/HcYWMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwQTF-1swzFi1b53-015VFt; Mon, 03
 Mar 2025 05:24:23 +0100
Message-ID: <31e5c235-4e59-4b37-ab3e-db05012d7119@gmx.com>
Date: Mon, 3 Mar 2025 14:54:17 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix a memory leak issue in read_one_chunk()
To: Haoxiang Li <haoxiang_li2024@163.com>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, fdmanana@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250303024233.3865292-1-haoxiang_li2024@163.com>
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
In-Reply-To: <20250303024233.3865292-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kHvpv533MgH/yvPuv9Yarmg/NoJRktAYzYOi/oaIZwt7cgCKWqy
 1hP5mbvUCp8jrfS3gbo0ZjJfKrM/RQD5qIITWlOf1epUXNuBwnSZDfKZTXaqysZ6Yb6RVJK
 k4rnUNKxqUQjJT74BeQT0/FUGMWFYjH2ktB8S6h3uDz4AtzQ6X2dSo2WWdCBcO8q1y9G9go
 0HjEJueZRZXPu42KJUzcw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ih1cCx4mvQs=;YUZ32KxwuX2/VI1IRWIFzO3MTbc
 By3MfDCzoQqzLVBu9uTze7Z9CH+RmxuN+jMqr+/tHaufbNTCFt0NT/moKAq8H37ye3UU12WVT
 YWpyKrV787FZpBuzQ5AgKLhFpXkB290xjBT91dn3HWTRXCXR+m/74IUBj9uO1hblKWHAVTDso
 ax5r9ibo1PXOm0H8zEx+48xMaUtXGsaADdUz7bXxEoEowEDfmTS6UhI9l4iAwkfadrVs+veP0
 B57L1Cevc//pRWxNYuQ9+AmkeNcNk9HHNpa0D/dJfos5zVbDzbiA3qkHGmBK0Mm50/6QcgOyq
 iFw+7wrWAQU14iKQmhSYp2TauVKdFxdoEdfu4hY+hQjLFVSESdCWYJelzGYuxKsugwYKX/nSU
 q61kuugQvIOer/Q9EmBqBd304I2ml2G8NYgP8jXOmegGMr3NfsJvv6kGyj3o9P5xaRwFZrH11
 JbIbDE8sCcS6LTpBB2kKxJRO193aTobAmp9v8lh67JIrx4F21jNHe+9L4ou5pMr93HfhjdEJN
 OkDYal/3+BnYNrm/0CoE+nrqHgGZ0fIeVestfkpLIbSPy4fknmBmlMg2LwzL/1oRLQfRKuTYY
 lMTnz7Tm9p2MI+ABpP3m3VbMZcVPPGNXx8sI4huPPQrv4dCPTymeAArOQTZ8t3YnOSgpV1eWg
 O11N1Ab+fF7YdDWgAkpfbbsG2V2RTZnxrxTnBe53y5u4l9CtSl7ZVCsNNZdysRK9ibZgv9C++
 2rxo7aUoWwsKEOFTgHej2rDUAdz4FV4RowUxu4/tj4aa1+er68EKIWB8k9WEa7mGGanS87rSr
 Lpy7Kq0RXD67yvbhZ86UCagN9w1XC1CI2TQyL2KovvWWaavYKee1xacx0uf9zzHH6cvz9WeaP
 UeFIz/gjJJcaowkPP2h9fP6tgN563dBJCMsc9tQ0xqFSZsod/ZEkWYRKghH5IPHN0FboBXO30
 fHmhz7g8pBe3m6BFDhOB9Rk8CXTVV0CwKg6a/uoNX7C4DmfHXSMVCNL2HHz2fvYj8Wd9u7tc2
 tqk/vSJTjJIdg22Gt+eMxqUfJSOyQts5IeFABjqnlXG0qq+Xdnzni0mA17Ko8pdw07cR7vDN1
 D3u9DIRYuJmg/Z590iATz7/N1i8MY7PKSlTDwDYujF6//QlE7q4pEDaxR6K3m6X6i+JL+RYKo
 Pco9PFsuMyyy5cbe+/bKy8KZrAq1JICk/Znbj6TKWJRJsu71mKYYWPItIvro2HNHadh8QGa8W
 EyuAPEcTikUCiSO8M+9Mtcl9ASjvUEFHewVOtGYzz97LnyqdOWmfposdEKvZ1jxdpWyuX9Qoo
 0yJNY7l6/sJhuXfQyfqIQ7EkFErHkiW3mGSFkrK0Ayi0rAae7dTrw7dNerYAv5ZYW3oPZQwvb
 N/BAcxTx16+cNsZqx6EKLHUZIx5wE11oSmmkFtExDM0Agyn+9AP9zlyuC2



=E5=9C=A8 2025/3/3 13:12, Haoxiang Li =E5=86=99=E9=81=93:
> Add btrfs_free_chunk_map() to free the memory allocated
> by btrfs_alloc_chunk_map() if btrfs_add_chunk_map() fails.
>
> Fixes: 7dc66abb5a47 ("btrfs: use a dedicated data structure for chunk ma=
ps")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

And the fixes tag is also correct, before that commit, add_extent_map()
will increase the ref if tree_insert() succeeded, thus if it failed the
unconditional free_extent_map() will just free the no longer utilized em.

But at that commit, we no longer has that feature, thus has to manually
cleanup the map.

Thanks,
Qu

> ---
>   fs/btrfs/volumes.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index fb22d4425cb0..3f8afbd1ebb5 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7155,6 +7155,7 @@ static int read_one_chunk(struct btrfs_key *key, s=
truct extent_buffer *leaf,
>   		btrfs_err(fs_info,
>   			  "failed to add chunk map, start=3D%llu len=3D%llu: %d",
>   			  map->start, map->chunk_len, ret);
> +		btrfs_free_chunk_map(map);
>   	}
>
>   	return ret;


