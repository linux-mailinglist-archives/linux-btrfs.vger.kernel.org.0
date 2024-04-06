Return-Path: <linux-btrfs+bounces-4002-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA2689A9CD
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 11:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD4628368F
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 09:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13642225D0;
	Sat,  6 Apr 2024 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="rw0OXdli"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95501862A
	for <linux-btrfs@vger.kernel.org>; Sat,  6 Apr 2024 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712394163; cv=none; b=oFrype0ei88xiG2bagsrVKq5Zb65b1g1kBcMLlvS4ZfnLFAOsuXjWVI+Hl3I4KsyJs26x+WwJLWAY+KCGmk2WUeG8icc7XtaKANm5c+fqoU6DYXmmsa/6J1d8ZrXRDZfDga0uwi4niP25vAn90BnWp4Bv5Gz2KA/cxZCPKFh6aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712394163; c=relaxed/simple;
	bh=C4HIs2iK1nfSEmJoI/GmsXTCFnO25bH6x+fpPVd0pJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYME1qqVRyAxpXcHrIhVmOqRRW0ZVySVjtd1nFe1jPcQ7HkgnVV0Ha++iBXZlxcl1TAiZCftj52UIjgS+vyTbYOqKbEdi/3PSc8nHKDNEHnrtvtpWSE7mZry26KaFPRHQaJrGBySjvdFdqesgIO3k3cgwOWWPbjGfIDRhIW5EeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=rw0OXdli; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712394148; x=1712998948; i=quwenruo.btrfs@gmx.com;
	bh=P1zIRekwXqKkAZgYVEv83S3oiHGSQ05wiQgrJcuKqOU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=rw0OXdlidDFfEIxB2xQq/rq06lUI3RC5Xbywn9J3seS8V70MO6kia6QkqgYtYraJ
	 mBOnHVuSad7cBalvHUrtG+Esxthe4noewBavcCzRN3N2s3dOeSFc3453BBdA8VzWQ
	 0aMCaLd7/VZmVH+6TnLqxQs6DFjV65UDCTmUmQkusK/AqgSNJ61c1X7teHKgaAm+g
	 spOmCN1Ev1IYzirAJXKWbtXNNzPehIQnIs3hgC5Atoepum3/L6HEurkgYAYpUrctP
	 M8hqkrlk4NE05EkxpsUzpTbNqtSawGDkxV6lpeg+DDI5I1ul1XvBubYnOoB7p4ute
	 nFl038ENhKLfXjx3Pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbRm-1s1Jfh3ndW-00H9MW; Sat, 06
 Apr 2024 11:02:28 +0200
Message-ID: <cb4bb488-f73c-44fa-a457-293cfc23f490@gmx.com>
Date: Sat, 6 Apr 2024 19:32:22 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fallback if compressed IO fails for ENOSPC
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, kernel-team@meta.com
Cc: Neal Gompa <neal@gompa.dev>
References: <4607d44ee4cf72a302d3adeba5d0ae99518a5f36.1712391866.git.sweettea-kernel@dorminy.me>
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
In-Reply-To: <4607d44ee4cf72a302d3adeba5d0ae99518a5f36.1712391866.git.sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kBO8lyt95uQ78xdCletEpE3MPDROtmPzvrdQ8WUju6LiIp0ByoX
 9JkdPloYw+8Jw/DxNB8CixvShFroLoOlqbndH5Q/z+CvJ1bVOsMctKNdEzxeNYO9L0DNcPd
 pw9wdh23zmvqd7eH5501DCetLD/kfz+/5Sxewq72WotsTizFAnCXxV8KDXWVR05+hnu/QNZ
 kudmXkTic6lH17luQziaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KFYsQWM8zh0=;BlWqKzfobK6nDbJeEIH7bdK1tE3
 MYgEpxC+B3cKJ0SZymNUHXs5yauy+3hnB2PbkNzkXQmteOIAXowCxBHbyWJQqKGKSwasnAQtO
 Ulm7ObKoijkcj+qNNDLLYyu39J/jGImH0mfReoPKI7rMFyF9E2XHgpFu4VrxuUCtHg6gg6fgW
 BneXdR4/jnTtiD/iEgb8YhkjwszW/5MTeJFPyHYwjiw7bEV8ZqrdCLnevGdgCrFWhlXmFNuTn
 zw2RokRZPptiYtEtOyS3ytEBIkaSfPkPdTo55QF+JvnRyINgOWmgea+7s+EJqEuoO4OTSYEW/
 bn00RMNBsOCYTtPQECSejFOwLJbVD/sr+S7At7U2A6ep6Ki7PP+inVDwzEtNU3j89SZWFuFST
 IRPcFgqRakjrBYu2w2TCaPhH2CaBl21VhHeuMvjLziSH+4faWK9WmQ/kUL/NluTXmTluHpok0
 kl+6pMZcyglShpWzI/OSlqGf27t2RZiATRal4mMwabM4flbjGdCsFcfA821Eip2TjgLKPqec1
 3LVS39bCZMGqD74MJDWv85/EUtCUyMZK5ashleVsDsegBoUrB7jfH+nOoG8k7rSVif/IyLEHt
 W6uU8wJTHCaw+ayH9dstcTur8sBpuDgk6qghvnCxZkdIp1t45J/4iTJEg5G/5nPNvEN12daB6
 xvxjHy0UufRWmGl72iTNY2D/eLOtJ3MM1qNzPNgydehN2x47EhlhycsYNK+BOEXzhUDqp9Ghp
 GOzISjbEbKHRoH6m2FwYY4aCE3rcdQoiciZ4Z1B5vhYvP7XHCW9l0AmO8oRHkxSfwiQBRys3K
 e7aeO23dV37K8Bp9lmCDNb0rFnnJekDee2Uww+I0A3B0k=



=E5=9C=A8 2024/4/6 19:15, Sweet Tea Dorminy =E5=86=99=E9=81=93:
> In commit b4ccace878f4 ("btrfs: refactor submit_compressed_extents()"), =
if
> an async extent compressed but failed to find enough space, we changed
> from falling back to an uncompressed write to just failing the write
> altogether. The principle was that if there's not enough space to write
> the compressed version of the data, there can't possibly be enough space
> to write the larger, uncompressed version of the data.
>
> However, this isn't necessarily true: due to fragmentation, there could
> be enough discontiguous free blocks to write the uncompressed version,
> but not enough contiguous free blocks to write the smaller but
> unsplittable compressed version.

You indeed got me, since for reserved writes we reserve the whole
compressed size, meanwhile for uncompressed fallback we can afford
minimal size of just a single sector, it indeed has its own chance.

>
> This has occurred to an internal workload which relied on write()'s
> return value indicating there was space. While rare, it has happened a
> few times.

Just curious, how rare is such case?

>
> Thus, in order to prevent early ENOSPC, re-add a fallback to
> uncompressed writing.
>
> Fixes: b4ccace878f4 ("btrfs: refactor submit_compressed_extents()")
> Co-developed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

And the fix is really small and doesn't fallback to the old hellish
code, looks pretty good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 3442dedff53d..15a13e191ee7 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1148,13 +1148,13 @@ static void submit_one_async_extent(struct async=
_chunk *async_chunk,
>   				   0, *alloc_hint, &ins, 1, 1);
>   	if (ret) {
>   		/*
> -		 * Here we used to try again by going back to non-compressed
> -		 * path for ENOSPC.  But we can't reserve space even for
> -		 * compressed size, how could it work for uncompressed size
> -		 * which requires larger size?  So here we directly go error
> -		 * path.
> +		 * We can't reserve contiguous space for the compressed size.
> +		 * Unlikely, but it's possible that we could have enough
> +		 * non-contiguous space for the uncompressed size instead.  So
> +		 * fall back to uncompressed.
>   		 */
> -		goto out_free;
> +		submit_uncompressed_range(inode, async_extent, locked_page);
> +		goto done;
>   	}
>
>   	/* Here we're doing allocation and writeback of the compressed pages =
*/
> @@ -1206,7 +1206,6 @@ static void submit_one_async_extent(struct async_c=
hunk *async_chunk,
>   out_free_reserve:
>   	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
>   	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
> -out_free:
>   	mapping_set_error(inode->vfs_inode.i_mapping, -EIO);
>   	extent_clear_unlock_delalloc(inode, start, end,
>   				     NULL, EXTENT_LOCKED | EXTENT_DELALLOC |

