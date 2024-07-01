Return-Path: <linux-btrfs+bounces-6062-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E5291DB9D
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 11:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89F42B221BE
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 09:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A7984D13;
	Mon,  1 Jul 2024 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="tRzur38g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6505C524C9
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719826699; cv=none; b=dqpe7Cy0H7l6O4hKDZ20SOBgI2Jxl6av7kbjPqsyTB72S3Sv1TMKSfG1vYA6iQ+NrzXc1H8BcARqmFKuZT1NxpYg0ZOoT8T3tmCYcUfdf5VGyzB5o+R92Fo0nTLyMFL5EPog827JAn4kK0lPghdq0ftl8ag2/l+xmHNcxdBCJcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719826699; c=relaxed/simple;
	bh=DuVeo7bdJk5k1f2dFpnVkNBuffap6TKCCJOhmKQo1kM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j/SPIq5KXAvHLGmkcEg2A/7LVPRNp+btaY8S+oJARddmrg56eWrd+ABBWFVLtiUAb8+WULOFW1caZz/g50Qj6hRa8ku1o6+PfK02ePgGuyE6FGkdKPF/mVdaB/p4VP6iNx0hA9wqrV9qkHAIlj43zq46pQSPc1+TSTmt/QI8GSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=tRzur38g; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1719826690; x=1720431490; i=quwenruo.btrfs@gmx.com;
	bh=j+6G/WM/O4lZWKKsxKdg6eflX8PMXfyCeuyetqD1Qmg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tRzur38gDwMzP5ZaJesvf4Ul8OANDGvj4TVFnZnVnTgkcTHhUh9KaHaU8t3Nx/Qb
	 viwACpvLo0WgyK5RvAxmUQwBq6RnIjFIkV53w7WhH7c1mtp/RImvtVOVE0veTuFWA
	 YuKKPwRxdakOJ7FEVoliTUjcOtqsguBt7SYzmFSzCYr5bUfTwY8Redh4dX5O4QIPc
	 p1SUgI9cJ4eRcnmrKcoMF1ZZQcMlAS0z9NSiKIYtZglg6NW/LlcqzJHDQnPDq7DUO
	 Toi+khPWZmk3fSrjWgiE3+k/3R+9j5x2flYnbUsVFejg+oYkMcpcAXc4gi7LZYtA6
	 MrKnlqVJ3opXzwZmAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MnaoZ-1rzIff0LYL-00itb2; Mon, 01
 Jul 2024 11:38:10 +0200
Message-ID: <b7c3fef5-03f9-4466-a68d-ad04284a1524@gmx.com>
Date: Mon, 1 Jul 2024 19:08:06 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: don't loop again over pinned extent maps when
 shrinking extent maps
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cb12212b9c599817507f3978c9102767267625b2.1719825714.git.fdmanana@suse.com>
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
In-Reply-To: <cb12212b9c599817507f3978c9102767267625b2.1719825714.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XhX5uFusmiuBN4kH7B0lTvjBN6U12CTq0HoPocOw4HKYZwPE6iu
 IdzmQQGREI9MMbT0EYwOo43FvGzWePe2yb4H9BNsb6BAOA+nwhA3ebd8zkna0exxF9c8B14
 hKQn1J5XyOc4iBYasvRPSrwI3yG/4vLS4g+m5Xs5jKhFnmELsI42w8XRfaWkJ6rl50fDSBJ
 +XLUtcG0ySt1eq/bGqvaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zG4yZ36pj0w=;V1YR3kxjb5e7Y4LTmetsElYTN5q
 HP2ifnqBkt7nVlV++0/Ib3IE+zGb/BV8QkF2dVLA9fLJiR8M8zO5kVwUpLKgB9DPczXEK2aba
 RLn1th4r74RDgtN8OuVI/Yjbe/rZB7x5BJ/O+p1KMvXw/V/bEfXpyeWBscLwmKtya/ey4J/0t
 M2bCQ0b9pDr2ND9eQi7d2he6FCClvpK/mJIGhsIkUeQbiIECmK4cgQuGqHbmJrepRMcU7vDPg
 wqeRwSII1gQa2g9fQKYsY14LUR/9JU66llxM+i2z/PQ/8JZp/EGp7p2vmhRijzHVA4t9z2otb
 r917vyvlLNO0kMs5Pzb8s6KiSkDTPRL0WVgor22CqRgNyPwjGUVMtrieV/XcFh4pmHHOI9CNa
 aIehPJleZAcKQh2aoROUKxyJSE0lAe9D1e1jzlmI/lbGcVnaI/0O8l6AMP+mI7YuSRw+qYCrY
 cJ3Nmi7089ak247GTyhPB5As+gvMDfn1oHQfi8jFKhLCkteeCHM+bCPnhP5Kr4QX5cKKuz/O8
 iP5YufE5hYD1CnvhGwHpfnzyvmsNYyKuXkItBpvsoxoPlZADPfeyAlLXEgsaOC/GU3/PKjgeH
 8cuGSn0NNCBnlt8BKHaaXjYlJJKdOnadJZWSVvRQNYdudd07sgIIN1Ti3eLIHGyk2Q1WrPTS2
 VIdRoouhhEZOV+4lKOe0FJsTvQcyeP61kCfIZOAU2GZybXaxO5jVqXOUsU7Bofa6B/K5/XYrV
 ODqsx1GN8Y2t3rNyqJiKAXqQsJPea2eESnrUYpWxyxZk1zdm/3jeV3+Cp8nw3jW1vgsRTE9O/
 M7X9QZq5oYiA01NKTEI0wZSweSHVr4nKVcLjmkY0fIyOk=



=E5=9C=A8 2024/7/1 18:53, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> During extent map shrinking, while iterating over the extent maps of an
> inode, if we happen to find a lot of pinned extent maps and we need to
> reschedule, we'll start iterating the extent map tree from its first
> extent map. This can result in visiting the same extent maps again, and =
if
> they are not yet unpinned, we are just wasting time and can end up
> iterating over them again if we happen to reschedule again before findin=
g
> an extent map that is not pinned - this could happen yet more times if t=
he
> unpinning doesn't happen soon (at ordered extent completion).
>
> So improve on this by starting on the next extent map everytime we need
> to reschedule. Any previously pinned extent maps we be checked again the
> next time the extent map shrinker is run (if needed).
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>
> This applies against the "for-next" branch, for a version that
> applies cleanly to 6.10-rcX:
>
> https://gist.githubusercontent.com/fdmanana/5262e608b3eecb9a3b2631f8dad4=
9863/raw/1a82fe8eafbd5f6958dddf34d3c9648d7335018e/btrfs-don-t-loop-again-o=
ver-pinned-extent-maps-when-.patch
>
>   fs/btrfs/extent_map.c | 24 ++++++++++++++++++------
>   1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index b869a0ee24d2..2d75059eedd8 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -1139,8 +1139,10 @@ static long btrfs_scan_inode(struct btrfs_inode *=
inode, long *scanned, long nr_t
>   	while (node) {
>   		struct rb_node *next =3D rb_next(node);
>   		struct extent_map *em;
> +		u64 next_min_offset;
>
>   		em =3D rb_entry(node, struct extent_map, rb_node);
> +		next_min_offset =3D extent_map_end(em);
>   		(*scanned)++;
>
>   		if (em->flags & EXTENT_FLAG_PINNED)
> @@ -1166,14 +1168,24 @@ static long btrfs_scan_inode(struct btrfs_inode =
*inode, long *scanned, long nr_t
>   			break;
>
>   		/*
> -		 * Restart if we had to reschedule, and any extent maps that were
> -		 * pinned before may have become unpinned after we released the
> -		 * lock and took it again.
> +		 * If we had to reschedule start from where we were before. We
> +		 * could start from the first extent map in the tree in case we
> +		 * passed through pinned extent maps that may have become
> +		 * unpinned in the meanwhile, but it might be the case that they
> +		 * haven't been unpinned yet, so if we have many still unpinned
> +		 * extent maps, we could be wasting a lot of time and cpu. So
> +		 * don't consider previously pinned extent maps, we'll consider
> +		 * them in future calls of the extent map shrinker.
>   		 */
> -		if (cond_resched_rwlock_write(&tree->lock))
> -			node =3D rb_first(&tree->root);
> -		else
> +		if (cond_resched_rwlock_write(&tree->lock)) {
> +			em =3D search_extent_mapping(tree, next_min_offset, 0);
> +			if (em)
> +				node =3D &em->rb_node;
> +			else
> +				node =3D NULL;
> +		} else {
>   			node =3D next;
> +		}
>   	}
>   	write_unlock(&tree->lock);
>   	up_read(&inode->i_mmap_lock);

