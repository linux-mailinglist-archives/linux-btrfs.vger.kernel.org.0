Return-Path: <linux-btrfs+bounces-19068-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83651C636B0
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 11:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD0344E45F5
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 10:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82048275AE3;
	Mon, 17 Nov 2025 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jm20452K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1635259CA9
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763373709; cv=none; b=crelgr97jyMzdmimMB/jl9pmQn1YMu5Dnqth5OmgZa6ZhXCcNXl/ZUlpE6CVmWDhLjUgMMAfInZtTIaT+aAZv0nZpLTa0JbKeFax170eeff0aLYjLcEtNmhoRqE5EtYL0v98OcHb9vpF4iNoKWwgwoc/L2908o8mHRE0OOU30ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763373709; c=relaxed/simple;
	bh=PoNt8G12M055lWvfORyjmZFvJhf7WJrhbGSbTziNU/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=APzTfEfmrI71e2QNVecdr9xHoXshNCdll75vfLmhjQdUKBV93I0Q6Aq/gKgbuS/RGFQDcvgEvVUbFTcdlZb8LOxTmAvILRaA2Wkw+6z8p6dSFTFNzSpxSrwqtWlGkEF/atxwqCFxf2Z3WyYBEVhglQrNiWXf+YmYA4ekcFdxwOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jm20452K; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763373705; x=1763978505; i=quwenruo.btrfs@gmx.com;
	bh=Wn4gjOjEchJ0VmUW9jdzC0odDgD7FNbJyztVfZRyxKw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jm20452KSv6ZRRw7aUZzqRs/WgvU11VIZCWGjK/XdemiZV56HbfOD3fCzuWC/A5S
	 sjS7wh5i87QTVxSxblE9Q4iKpvD9l5yfRJqodEBZzv8SzwhQMo/edb81ezZt6jWMF
	 Xrzwry+lgbPXzYRUZgYpZh+lwhpNb5pjnlk30hMFOmxImbLxGYtKe/zA4k0DIexFF
	 lcFACOJWFLv920MeMXQtkH83f3FZvz6YNIS0t3INxRlAFr0ndDM06IOfaY9lANyJW
	 v7FRWPEH40Pm3EWRSuC+3lyCtZKgmHqNLvRg5KbZfNeivrEWMT4CSfeZCrFrpQQE9
	 ixQdHoyiDmm+Hw3mnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6DWi-1vEKLg1kgy-001sBz; Mon, 17
 Nov 2025 11:01:44 +0100
Message-ID: <b5bce92a-f1e8-4137-ae9c-df6980702095@gmx.com>
Date: Mon, 17 Nov 2025 20:31:41 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Troubles translating root tree's logical to physical address
To: Robin Seidl <robin.seidl@fau.de>, linux-btrfs@vger.kernel.org
References: <7e9c5666-645d-4b4f-9608-a521353c54b0@fau.de>
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
In-Reply-To: <7e9c5666-645d-4b4f-9608-a521353c54b0@fau.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qKudXTasYuPWqeVml62ESRHAIjpRUkqkRHsQVyJcbIWUrXQMHH5
 KFxCEUqClTG94nxf1a1XppMLbHTXU3v5Ve3/3x76W2KpCAzmWueYN3zu9sLzEzymxjjUuzu
 dPNU1me4PBcBmhtv7/VS7hHIlEq4mcW7qGJ8jjTYe5UZuoMuNdIsnD6ikNkwPRopXljW3mh
 snc9JX3Nqb3mejx98126g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q1l5hqGoXQ4=;Wb7B4vSf/AdhgyqElFY1fsdRWfZ
 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



=E5=9C=A8 2025/11/17 20:05, Robin Seidl =E5=86=99=E9=81=93:
> Hello,
> I'm currently working on reading the BTRFS structures without mounting=
=20
> the filesystem. I am now having troubles translating the root tree root=
=20
> address to a physical address:
>=20
> I did the tests on a freshly created filesystem.
> At 0x10000 the superblock begins.
> At 0x10050 the u64 logical address of the root tree root begins. It is=
=20
> 0x1d4c000.
> At 0x100a0 the u32 size of the chunk array begins. It is 0x81.
> At 0x1032b the sys_chunk_array starts.
>  =C2=A0 =C2=A0 0x1032b to 0x1033c is the btrfs_key. The chunks logical s=
tart (u64=20
> at 0x10334) is 0x1500000
>  =C2=A0 =C2=A0 0x1033c to 0x1036c is the btrfs_chunk. The chunks length =
(u64 at=20
> 0x1033c) is 0x800000.
>  =C2=A0 =C2=A0 0x1036c to 0x1037d is the btrfs_stripe.

This can be done using `btrfs ins dump-super -f` to print a more human=20
readable output of the system chunk array.

>=20
> When the logical start of the chunk is 0x1500000 and the length is=20
> 0x800000, then the logical end of the chunk is 0x1d00000. This implies=
=20
> that the root tree root adddress 0x1d4c000 is outside of the first and=
=20
> only chunk.

Just like the name, system chunk array, it only contains system chunks.

System chunks only store the chunk tree, which stores the remaining chunks=
.
> What am I missing here, how do I translate the logical=20
> address of the root tree root into its physical counterpart?

Tree root is in metadata chunks, not in system chunks.

You need super block system chunk array -> chunk tree -> the remaining=20
chunks to do the bootstrap.

If you are not yet able to understand the full kernel bootstrap code=20
(it's more complex and have a lot of other things), you can check=20
open_ctree() from btrfs-progs.

The overall involved functions are (all from btrfs-progs):

- btrfs_setup_chunk_tree_and_device_map()

- btrfs_read_sys_array()

- btrfs_read_chunk_tree()

Thanks,
Qu


>=20
> Best regards
> Robin
>=20
> PS: In the wiki (https://btrfs.readthedocs.io/en/latest/dev/On-disk-=20
> format.html#superblock) there is a typo regarding the start of the=20
> sys_chunk_array as it claims it starts at 0x1002b.
>=20


