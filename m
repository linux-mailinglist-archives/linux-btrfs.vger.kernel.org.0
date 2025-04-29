Return-Path: <linux-btrfs+bounces-13532-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 078ACAA3B87
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 00:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF07E986A77
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 22:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592272749D8;
	Tue, 29 Apr 2025 22:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Ss1AQUsv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C4B219E93;
	Tue, 29 Apr 2025 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745966088; cv=none; b=qaiu8V2076EZl1hLmrTvCPX9X7eVR/fP6rIy7DO/Tk40j/0WqHt+sHCwdZR3cY5EZRickNXlq3nzEGzTZlqPy3KDYXJoh2Po2Bo2Rr7djPAEE+Huy4XsMS2BlU9Yc/7mppFIv1mW2Urp91Lrqhlufo+ti1ubwGjz/8mhu0PmAj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745966088; c=relaxed/simple;
	bh=EFmO02w6vdW0Kg5PY46ZochQu3BrxSiAhujrNC+0WmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xt9VpZdCeB4Cvpqk6W8cbKdCKO1fJ+4vONAEo0tdRxUxBl6ESU9RP3+vqyrSiPf2Pzw2QuZ9XLE4OatBBM6Ie5Jto61IPqbLdl8ll3Kt6bm0x3Itfz+eIKnw7BPbEJwPhbTSwPNOkOvzo+/EEn5qlOA6448r9xlMyXawV6Cua8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Ss1AQUsv; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745966084; x=1746570884; i=quwenruo.btrfs@gmx.com;
	bh=mM8TT6athLb0IZKuXhboEpz31OG4aHTsTc4AlDv/iPI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ss1AQUsvI9Ij6S4Ite2+ZWPqpKAD7X58g+jzMAHwc0SIXG1pgOIHaJ0wp6iG/R8B
	 j8vfw04kMyN/AKmUdZ06Qjj2N7MSW6/l5KKec3tsh+0LZqT+zjsh7woG2xOMawp7a
	 edQG/v1JyamdM6fdN9ZmTHykqIJvSqsPeYrSup30alsSWr2+ZhOHonLRUIfzPsmr5
	 kaTypgcrgYI+y1CV6j9XNu9O8XdvXU7lby//14UZ3B3FnzVm7LFYoo/lqDj/CJGH8
	 6OUwmbban4RsFKrUwClstokpcL1HCARnGSY7gogbSSZokikZ3h6GQbIrR8QCsrcAz
	 /XwnQ0iukAHP5+G9Nw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N6KUd-1v772g3HBZ-014g62; Wed, 30
 Apr 2025 00:34:44 +0200
Message-ID: <ceaa0748-4190-4f0f-aca9-688ae1c7bfc3@gmx.com>
Date: Wed, 30 Apr 2025 08:04:39 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove extent buffer's redundant `len` member
 field
To: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250429151800.649010-1-neelx@suse.com>
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
In-Reply-To: <20250429151800.649010-1-neelx@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KaXKRZ4315EJix6yUbupnkEBkxd1Y5Yqqncu/hYmM3F6FCDoGNA
 BdDiUFPNfQiSfI19wIFUwFqyr47nf4XBa/zW5PMh7SGSFVa/d8rsCXeicUSS4rVx+CecO0k
 +4wu3miTl4jdM3dm6eoFMwTgubWstelFaSMXcjO6tszcbqBq5CzYRZjgGjdq2Mn8G7XQIwW
 uhJyOGeNQRbS5ikGni8wQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fHgA3X5t2EI=;bMOARE3HQ1m2O2MZCLBUOr3hjiO
 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



=E5=9C=A8 2025/4/30 00:47, Daniel Vacek =E5=86=99=E9=81=93:
> Even super block nowadays uses nodesize for eb->len. This is since commi=
ts
>=20
> 551561c34663 ("btrfs: don't pass nodesize to __alloc_extent_buffer()")
> da17066c4047 ("btrfs: pull node/sector/stripe sizes out of root and into=
 fs_info")
> ce3e69847e3e ("btrfs: sink parameter len to alloc_extent_buffer")
> a83fffb75d09 ("btrfs: sink blocksize parameter to btrfs_find_create_tree=
_block")
>=20
> With these the eb->len is not really useful anymore. Let's use the nodes=
ize
> directly where applicable.

The idea looks great to me, and all the call sites look good too.

>=20
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
> [RFC]
>   * Shall the eb_len() helper better be called eb_nodesize()? Or even ra=
ther
>     opencoded and not used at all?

However the name eb_len() is a little too generic.

Nodesize is a little easier to understand.

>=20
>   fs/btrfs/accessors.c             |  4 +--
>   fs/btrfs/disk-io.c               | 11 ++++---
>   fs/btrfs/extent-tree.c           | 28 +++++++++--------
>   fs/btrfs/extent_io.c             | 54 ++++++++++++++------------------
>   fs/btrfs/extent_io.h             | 11 +++++--
>   fs/btrfs/ioctl.c                 |  2 +-
>   fs/btrfs/relocation.c            |  2 +-
>   fs/btrfs/subpage.c               |  8 ++---
>   fs/btrfs/tests/extent-io-tests.c | 12 +++----
>   fs/btrfs/zoned.c                 |  2 +-
>   10 files changed, 67 insertions(+), 67 deletions(-)
>=20
> diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
> index e3716516ca387..a2bdbc7990906 100644
> --- a/fs/btrfs/accessors.c
> +++ b/fs/btrfs/accessors.c
> @@ -14,10 +14,10 @@ static bool check_setget_bounds(const struct extent_=
buffer *eb,
>   {
>   	const unsigned long member_offset =3D (unsigned long)ptr + off;
>  =20
> -	if (unlikely(member_offset + size > eb->len)) {
> +	if (unlikely(member_offset + size > eb_len(eb))) {
>   		btrfs_warn(eb->fs_info,
>   		"bad eb member %s: ptr 0x%lx start %llu member offset %lu size %d",
> -			(member_offset > eb->len ? "start" : "end"),
> +			(member_offset > eb_len(eb) ? "start" : "end"),
>   			(unsigned long)ptr, eb->start, member_offset, size);
>   		return false;
>   	}
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 3592300ae3e2e..31eb7419fe11f 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -190,7 +190,7 @@ static int btrfs_repair_eb_io_failure(const struct e=
xtent_buffer *eb,
>   	for (int i =3D 0; i < num_extent_folios(eb); i++) {
>   		struct folio *folio =3D eb->folios[i];
>   		u64 start =3D max_t(u64, eb->start, folio_pos(folio));
> -		u64 end =3D min_t(u64, eb->start + eb->len,
> +		u64 end =3D min_t(u64, eb->start + fs_info->nodesize,
>   				folio_pos(folio) + eb->folio_size);
>   		u32 len =3D end - start;
>   		phys_addr_t paddr =3D PFN_PHYS(folio_pfn(folio)) +
> @@ -230,7 +230,7 @@ int btrfs_read_extent_buffer(struct extent_buffer *e=
b,
>   			break;
>  =20
>   		num_copies =3D btrfs_num_copies(fs_info,
> -					      eb->start, eb->len);
> +					      eb->start, fs_info->nodesize);
>   		if (num_copies =3D=3D 1)
>   			break;
>  =20
> @@ -260,6 +260,7 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bb=
io)
>   {
>   	struct extent_buffer *eb =3D bbio->private;
>   	struct btrfs_fs_info *fs_info =3D eb->fs_info;
> +	u32 nodesize =3D fs_info->nodesize;

Minor nitpick, @nodesize can be made const.

Otherwise looks good to me.

Thanks,
Qu

