Return-Path: <linux-btrfs+bounces-15748-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3CDB15947
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 09:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3F24E7EA6
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 07:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906491F8747;
	Wed, 30 Jul 2025 07:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bVFcaKT4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F791F4C92;
	Wed, 30 Jul 2025 07:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753859192; cv=none; b=SdhGj2/ANNtJrj9yHgd8VJk8bxH3GzEkcF4lex2HkvY8oVs32UKSIsPIBR6jsRRjN0/2eHMDoVJX6nlJuEaqt26ZYzYpVCmaitfCrug0Lv/0bdgpHyDt76tHJGI77vYo25YnJyK8szS4az3gMNcJMxgKcbgINZLRBCjpZ/7M4bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753859192; c=relaxed/simple;
	bh=D5fGEERAJqeyZ4ivK3PRQ4H/0AuU4HMr6ChxiopXq7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzqnwX2a2t/rMJED8Oz8KpwGSt4FD7dl7NL2W6XT4wCmfnbAbjGlR9W/aL0KoSW0dGaoylVzp0Sg6xPgv6wqc3ZsmiWSE4mJId5xEroH6+1WhTODHkLpcI8hrXKtzUTBj1hR42DPuGOEw1/nzLVbnRwVxqY1tT63f2vuPMXj2KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bVFcaKT4; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1753859182; x=1754463982; i=quwenruo.btrfs@gmx.com;
	bh=83LbDlYvQz5EqcV06C6Up47cDss6aXsl/uqdw4DXBP0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bVFcaKT4vWP3W2Tt6TBgV0CNNRRulbziIwxu0MAGIgXkdSJL+zZumj5KpMfrA0t3
	 BxxZh+IoTywXzZWmEVLYPItSTCJRutRYpKLxKOkR6Yufq9gUhoEQABf1kEX3mXA0j
	 gVn6AYIa+H/fo+zafgqdIsmsHKt+B7cyRrrESJwFnEZJ/QaNoSK2MIseKLn0V6U49
	 uzleSreBULNQA0Gq+ItnjeaghLClVrr/QGRCFT5NBk8K4QOfRK90f1LE/OX09lUBM
	 JwDGQQ+yzGiwDjKHzNkvyHVd6Bk6EPbG7KQemleSAZSeMUB4UGAadOxgzmlZZec+o
	 d+2f4tH2uOyqdauYow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MfYPi-1u9u8D0IUC-00i55V; Wed, 30
 Jul 2025 09:06:21 +0200
Message-ID: <7d3afcb3-c5b6-4510-8d11-505c1538c786@gmx.com>
Date: Wed, 30 Jul 2025 16:36:14 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] btrfs: add integer overflow protection to
 flush_dir_items_batch allocation
To: kmpfqgdwxucqz9@gmail.com, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 KernelKraze <admin@mail.free-proletariat.dpdns.org>
References: <20250730044348.133387-1-admin@mail.free-proletariat.dpdns.org>
 <20250730044348.133387-2-admin@mail.free-proletariat.dpdns.org>
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
In-Reply-To: <20250730044348.133387-2-admin@mail.free-proletariat.dpdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SW4E7atVRxRfZzAD60WCO6yRTab6H56lOeDBXMa+zXxIyTaayi9
 AA/4NhWm82+6KTJlJK6rWMvIgTKQTlGvjRFAfbieCkUnS1f4z54oaYl+fuBAkggkYQ7wr6e
 0Z2c9UGzrFcXrrMBIaU6nwIdisw8Ma3FsUNCW5FEPPNdNx/vAog7ZCAOVdG9etSuMcYhEW6
 nnwNoUzTVU3/DW8XbXctw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oDghj/1I9eA=;n/iUI7sJhRMJQ5o1gZMHidVffu4
 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



=E5=9C=A8 2025/7/30 14:13, kmpfqgdwxucqz9@gmail.com =E5=86=99=E9=81=93:
> From: KernelKraze <admin@mail.free-proletariat.dpdns.org>
>=20
> The flush_dir_items_batch() function performs memory allocation using
> count * sizeof(u32) + count * sizeof(struct btrfs_key) without proper
> integer overflow checking. When count is large enough, this multiplicati=
on
> can overflow, resulting in an allocation smaller than expected, leading =
to
> buffer overflows during subsequent array access.
>=20
> In extreme cases with very large directory item counts, this could
> theoretically lead to undersized memory allocation, though such scenario=
s
> are unlikely in normal filesystem usage.
>=20
> Fix this by:
> 1. Adding a reasonable upper limit (195) to the batch size, consistent
>     with the limit used in log_delayed_insertion_items()
> 2. Using check_mul_overflow() and check_add_overflow() to detect integer
>     overflows before performing the allocation
> 3. Returning -EOVERFLOW when overflow is detected
> 4. Adding appropriate warning and error messages for debugging
>=20
> This ensures that memory allocations are always sized correctly and
> prevents potential issues from integer overflow conditions, improving
> overall code robustness.
>=20
> Signed-off-by: KernelKraze <admin@mail.free-proletariat.dpdns.org>
> ---
>   fs/btrfs/tree-log.c | 27 ++++++++++++++++++++++++---
>   1 file changed, 24 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 9f05d454b9df..19b443314db0 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -3655,14 +3655,35 @@ static int flush_dir_items_batch(struct btrfs_tr=
ans_handle *trans,
>   	} else {
>   		struct btrfs_key *ins_keys;
>   		u32 *ins_sizes;
> +		size_t keys_size, sizes_size, total_size;
>  =20
> -		ins_data =3D kmalloc(count * sizeof(u32) +
> -				   count * sizeof(struct btrfs_key), GFP_NOFS);
> +		/*
> +		 * Prevent integer overflow when calculating allocation size.
> +		 * We use the same reasonable limit as log_delayed_insertion_items()
> +		 * to prevent excessive memory allocation and potential DoS.
> +		 */
> +		if (count > 195) {
> +			btrfs_warn(inode->root->fs_info,
> +				   "dir items batch size %d exceeds safe limit, truncating",
> +				   count);
> +			count =3D 195;
> +		}

Just as Johannes said, explain this number.
> +
> +		/* Check for overflow in size calculations */
> +		if (check_mul_overflow(count, sizeof(u32), &sizes_size) ||
> +		    check_mul_overflow(count, sizeof(struct btrfs_key), &keys_size) |=
|
> +		    check_add_overflow(sizes_size, keys_size, &total_size)) {

And the magic number 195 won't cause any overflow anyway.

195 * (4 + 17) =3D 4095

Do you really think kmallocating a memory of 4096 bytes will cause extra=
=20
problems?

Then you must have not reviewed any btrfs code.
We're going to use kmallocated memory for btrfs super block, which is=20
exactly 4096 bytes, matching your "integer overflow" standard.

Your "integer overflow" looks completely impractical.


Further more, this 4095 magic number doesn't make sense on systems with=20
larger page size.
If the system has a page size of 64K, limiting the kmalloc size to 4k=20
make no sense.


Finally, have you checked the only caller of flush_dir_items_batch()?

The only caller is iterating all the item keys inside a leaf.

And a leaf has a very limited number of space for storing=20
BTRFS_DIR_INDEX_KEY and its items.

At most there are nodesize / (dir_item_size + key_size + item_size)=20
items inside a leaf. (this is already ignoring some extra overhead)

And using the default 16K nodesize, we can have over 200 dir items.

This means your flawed calculation is already going to cause false=20
alerts on completely valid cases.


So a huge NO-ACK.

> +			btrfs_err(inode->root->fs_info,
> +				  "integer overflow in batch allocation size calculation");
> +			return -EOVERFLOW;
> +		}
> +
> +		ins_data =3D kmalloc(total_size, GFP_NOFS);
>   		if (!ins_data)
>   			return -ENOMEM;
>  =20
>   		ins_sizes =3D (u32 *)ins_data;
> -		ins_keys =3D (struct btrfs_key *)(ins_data + count * sizeof(u32));
> +		ins_keys =3D (struct btrfs_key *)(ins_data + sizes_size);
>   		batch.keys =3D ins_keys;
>   		batch.data_sizes =3D ins_sizes;
>   		batch.total_data_size =3D 0;


