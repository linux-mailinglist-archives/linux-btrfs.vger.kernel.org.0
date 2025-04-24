Return-Path: <linux-btrfs+bounces-13353-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C45F4A9A075
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 07:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7C15A8494
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 05:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306B11AF0CE;
	Thu, 24 Apr 2025 05:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HrOI2jma"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE4E19ABC3
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 05:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745472871; cv=none; b=SlzqsD0Wlig9+aGNisvO+fUUV6xclMnu8yi+guyirfh0S0+GH1+oAgLe9DjoGInp+heKp9WTolnvtXayjz81Z8BIR0i+01SwyugvxqO+Qi+JJIz/Cfdr9RIqM4TxZ/K4jJLeGxfPAwZ2qNbmzMbdpew6QUc8t0SPoV/f6T99yv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745472871; c=relaxed/simple;
	bh=Bq0uDvEl1JDCm+XQ1PLTCcSUfw8LJrgMCPsN+XGpVtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NsMD2nX41KvvENa71vcOxsUxX7psseVUktWjQ1KOOqE8PtYkwkTeeVFRE50tdr/dLs0h44R6Vn3soTO+rFyXaGcnqqxhUksU5uAbRgLK4hQbIqyK4qW1Mm89gUxcsAsYWsJMqAUT0lFkRuhkzWAfyXSESDl3vzJdvTNzdmg8jTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HrOI2jma; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745472865; x=1746077665; i=quwenruo.btrfs@gmx.com;
	bh=+gbpQzCvk5uU/PS3bsmaV+La1i1604WEIi/ydsb6N1M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HrOI2jmaljqzMRYTXV0iANQ+mUtLvxH81+WwIzLXoI2rGZykfC1IbQP4tNjLQ/71
	 Gv5JfElfplLA9lgEyQcP+qI9q37WhNSEz3zoa1vMN97lguiqpggUziZDPBJci+9aI
	 uChSRMRBBrqr0Fm1WZVYWxZhMpSDQ80kcyKDajJxIaBy/Ei/cSgqTiaVyUQVtq1LT
	 SR1Dtk9u6eXj7041I+X7qz6SqJqlQ8Q9YflJLe9rhYnxsKnV8vayYvjG5YmFVZ74j
	 JsEgWiy6AHOXOSlBN3q0CABFqAGd1ycQsbs/KtAb3YvDThGCfT5RYDIiM/VB2nKzu
	 ZI3jfqWKpjjJz4pODw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7sDq-1uCnJK2DvW-007s1Y; Thu, 24
 Apr 2025 07:34:25 +0200
Message-ID: <1142ff0f-4296-4877-b8b6-1be2f78ff9ad@gmx.com>
Date: Thu, 24 Apr 2025 15:04:21 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Cleanups of blk_status_t use
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1745422901.git.dsterba@suse.com>
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
In-Reply-To: <cover.1745422901.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:26NBhVfQ5po1ZgTQ8F7yqHlMovzxb0o4nA1UW1VAmC00K6oAHYD
 Za7zWb/4gEgXrMocJ93Jy4n0i0q6ee8x2t4K+MtADQBDY5a8SQVxcUIb6Fmr5N9P57QMkve
 uTnlPerzgz/puv9mqsIl5PCEUqz5kW+HSlDB3JXdECXl2TpzK18+GLFb6AyzZtMf+PBgpux
 TIdM5mrZQUETrX5RK4WPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:41azaMRcwV4=;Wq8kYdRIJeOzYWAiXrddY7ecjMd
 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
 Q4f4gG/EUkFH9MbuzyZNMEopu6HSxz0=



=E5=9C=A8 2025/4/24 01:27, David Sterba =E5=86=99=E9=81=93:
> Use the blk_status_t only for interaction with block layer API and
> remove it from our functions. Do some naming unifications and minor
> cleanups.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Although I'm wondering if it's even possible to require a forced=20
compiler warning when using blk_status_t as other types and vice verse?

Thanks,
Qu

>=20
> David Sterba (12):
>    btrfs: drop redundant local variable in raid_wait_write_end_io()
>    btrfs: change return type of btrfs_lookup_bio_sums() to int
>    btrfs: change return type of btrfs_csum_one_bio() to int
>    btrfs: change return type of btree_csum_one_bio() to int
>    btrfs: change return type of btrfs_bio_csum() to int
>    btrfs: rename ret to status in btrfs_submit_chunk()
>    btrfs: rename error to ret in btrfs_submit_chunk()
>    btrfs: simplify reading bio status in end_compressed_writeback()
>    btrfs: rename ret to status in btrfs_submit_compressed_read()
>    btrfs: rename ret2 to ret in btrfs_submit_compressed_read()
>    btrfs: change return type of btrfs_alloc_dummy_sum() to int
>    btrfs: raid56: rename parameter err to status in endio helpers
>=20
>   fs/btrfs/bio.c         | 33 ++++++++++++++++++---------------
>   fs/btrfs/compression.c | 22 +++++++++++-----------
>   fs/btrfs/disk-io.c     | 16 ++++++++--------
>   fs/btrfs/disk-io.h     |  2 +-
>   fs/btrfs/file-item.c   | 20 ++++++++++----------
>   fs/btrfs/file-item.h   |  6 +++---
>   fs/btrfs/raid56.c      | 13 ++++++-------
>   7 files changed, 57 insertions(+), 55 deletions(-)
>=20

