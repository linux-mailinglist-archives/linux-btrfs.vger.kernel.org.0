Return-Path: <linux-btrfs+bounces-16003-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E0AB218FD
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 01:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACC127AA369
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 23:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E527223C51D;
	Mon, 11 Aug 2025 23:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ne0LkGHA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F9C238174
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 23:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754953905; cv=none; b=mhS+N5LAc4Ef+py8RSD4FdU71XN/qHgXJ6uvu3EoUu3dQpoGL6LPTAdI1VMlmQlHmDg6VkOKan0GQ9IaseAsFouCGMJqsQppFlw/oOA1PKVyBaVYNHcyOyN/26DH2DiP5tx9rjxWrZtcbJsXIV4CJuBzYrgEr9RYr0LZv+Q8sJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754953905; c=relaxed/simple;
	bh=EGQsg++Y+0Csfqpl0I5Xfn3CLvnwRj+4iwroeu5ZwqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cvaqkPJCnd4kTMm87sKGSDoMtHk/g8H/vS/2yMYXV/b2bc4KQqDClCq0+tkixiwWsqpMml8TkveW/fOKpcn5702Q8VpVPmJF5irGGuj1YeFKedb08zCSB1oxDe5ARH6khGsXm9V4bIaQNxlMD9zIVqMzzG6FAz2TYDsvDRM8Q9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ne0LkGHA; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754953900; x=1755558700; i=quwenruo.btrfs@gmx.com;
	bh=zSN6QFYjl73S61qiNtETtWi03NHLA2/8g3CNPyJF9TI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ne0LkGHA3httpp04XwR//f3+GBg7cDndMfkuDx5DrbzkZT6+AXJlS3RXbnar3EpR
	 CVqRNvKYaBEVU2BFxhoxSkyKmPIaUHEUaGhPRFIS46iP77JMLZFbO/8THFwI+4UAb
	 g/Q0KpiBYTLplTBieFPcFi8rD+vrKe6+tn96nCcP7kB7qbC0Zq9E+cZkUmnntjLc9
	 NUnDxvkVgOSdYCiXEK19uAwHjvzO0VQE3mz+xNbSyyMd+o3DSFy7qvm3qGFl0cZ4u
	 8nPcz3e0Efa6qA0ZGVtfa91QwZl/1Ec2thQIIAdh3LkpRusAM21mIKn7Zg7XZsZgE
	 Uh6HGeME5XW3y6qV3g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MirjY-1u9EWe1H9g-00pAQB; Tue, 12
 Aug 2025 01:11:40 +0200
Message-ID: <0c46b12b-3e2d-4822-8148-b9cf5b12b112@gmx.com>
Date: Tue, 12 Aug 2025 08:41:37 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix buffer index in wait_eb_writebacks()
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc: dlemoal@kernel.org
References: <20250811225840.501895-1-naohiro.aota@wdc.com>
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
In-Reply-To: <20250811225840.501895-1-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6bQ71RlzmpOlroK0Njxaypbw1wK7Xl+uwtOUENbd9w1B0T9XTTi
 kIWt3gnnDnzvAf9UAjZJdC+TFCkhXJX30/EXnOWB7LmVAPf6vBApm8/HuTHjfpSKzvVRQFz
 Pjz9e3ahPPlPB9WMdg/GK2jQglJ4eMIHMctENuHuwhQ3MoN4OfyvZx3iEy+NtB9U06aJKk6
 25IFs8tMsZCx2RU3l2OzA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Pl5iDchvEIg=;3lk1Cg7RAZEhDSi4poUZsI8W36s
 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
 tzAgUS1aQGA==



=E5=9C=A8 2025/8/12 08:28, Naohiro Aota =E5=86=99=E9=81=93:
> The commit f2cb97ee964a ("btrfs: index buffer_tree using node size")
> changed the index of buffer_tree from "start >> sectorsize_bits" to "sta=
rt
>>> nodesize_bits". However, the change is not applied for
> wait_eb_writebacks() and caused IO failures by writing in a full zone. U=
se
> the index properly.
>=20
> Fixes: f2cb97ee964a ("btrfs: index buffer_tree using node size")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/zoned.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index d9b26a48cb48..e264310b8d6b 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2260,7 +2260,7 @@ static void wait_eb_writebacks(struct btrfs_block_=
group *block_group)
>   	struct btrfs_fs_info *fs_info =3D block_group->fs_info;
>   	const u64 end =3D block_group->start + block_group->length;
>   	struct extent_buffer *eb;
> -	unsigned long index, start =3D (block_group->start >> fs_info->sectors=
ize_bits);
> +	unsigned long index, start =3D (block_group->start >> fs_info->nodesiz=
e_bits);
>  =20
>   	rcu_read_lock();
>   	xa_for_each_start(&fs_info->buffer_tree, index, eb, start) {


