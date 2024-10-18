Return-Path: <linux-btrfs+bounces-9006-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1399A4A1B
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Oct 2024 01:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F49B21BC5
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 23:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F16A18FC75;
	Fri, 18 Oct 2024 23:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ZeU9bEMe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52BD14F9D9
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Oct 2024 23:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729294644; cv=none; b=cimunD7VOhe4+X0A6WQQiA6HhuTW3wMlOxz5c1ZOtpwHvecRM2Vz9Jskn3TKLHDWTlyhVZRVwzLmR1ASi59QuxzTY4EsUd+fVMolPLGjrvFrcg5OG7cyJyA06rcArZAt1y+yoZMZGk83qMELaCI8RnGDCo+J56fpAwk6UVe8gCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729294644; c=relaxed/simple;
	bh=d4hF9LHW76HoBUTcnXj+QxpBwCRNWXp3axYVzHwQY/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=odbhG4gMguIcT5ZdXEnt6QnHLsf7JLuBVfSsQ8tHYQqrstT/b0Z/n9fFlQie3Nl9IHWv+JPUPgyCdvKdU3+zSOovwFtXhTSOF2KlzRsXkJ09uyNm+2w1+jAS76vBA0icgXe1PXK3g1Sv4L9SjFwE4jJA6+4XhgLQ754bHCJJXgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ZeU9bEMe; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1729294633; x=1729899433; i=quwenruo.btrfs@gmx.com;
	bh=u50m67r9tTXJyogqQyoZBiu5pHDtSNbgCbRfKe8rpN8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZeU9bEMevB0KLyYGEcrPo3gLoGQlWQRqebVNDBnzSk1CnVnBtKgtm0ngwbnJ5K21
	 E8gR12aH1vDZMRCcTGZtkZs9T/HN7D68zu6CvhKWMfZyJOp3dGE647xI+C9IvEbaU
	 9mbAcrJYP8CpiuHml5y4kZiCrQ2lEfJnH1UJoL/5stpfZwN0eu6YxpLh2YwQZwGVc
	 t+AmVYMpp3HW8ncXAd7CuX9yiGda7biqc65KJxmkQNJraxV/MbC43mB17ajtbOBus
	 N1Hh47uPSQ+ET8QTECVd9CcvJ+uNC3UznHdTMgeMhtorJ2Hb4ylDt2NJbPEBAX/QV
	 sBM7Y9gLFTqksRBuAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTiPl-1tVpCv2h3N-00U3CB; Sat, 19
 Oct 2024 01:37:13 +0200
Message-ID: <01b1cb0e-4642-452d-894d-bc14607c94c5@gmx.com>
Date: Sat, 19 Oct 2024 10:07:06 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: make dropped merge extent_map immutable
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <76ba30ab42dc77209f9cc1274b06619c7d474303.1729294376.git.boris@bur.io>
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
In-Reply-To: <76ba30ab42dc77209f9cc1274b06619c7d474303.1729294376.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YEk3zRZnuL6bCmf2SAhkZzHhyYBp4FiHeKLmyANGIPR17V95WW5
 cbxvoxxnCbPpSOJl5ETgPILpiRGZML58BKJ4BpZDft/L3RgKPXPcE5HgM+9ZGxLMdhmN6nZ
 L2D+o7b7BFuAoiK7zijmqfv5CuawS+O46RNoqQY2tyrWjZhhdKT+Gfsqb6JZrxGdQI1qFs3
 C615FQpWBQyAD1K+3vF0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8fJXiUd+Mes=;FaZs/Qe971Li+Ucp0y2er/9JwFK
 VIfjzbQ2AolRt2ytapsFZY0hNzCqf1iFud1JzSMlNjuvcHLDG4apVCz3rCdo2EjdZvQDAIYtt
 Pkw+IEfZh+9e2t9asyiLPqwggV/LhOB9keqnPWLq4A50/IY/ZmBqVlCAkghR9PpU+SydVhyym
 RmIAOrYUkTk0PtVmEh2jWnO6xPnGN3IdQ3HrhLs3T9RS9IX/YYbz81jiOEwHRdB35vsFKzfNG
 EgC92XpCD7XQ4PzeCtl3laktz4ItJE1d/YOtY0wrO2kT1aVLz8cIT4+Avu2ZkOPIWtyWN8u0Z
 f+LZKbxWXIp1dtY9QO72CBtEstz4IhJ7eES1NEdly4JIpPKyt44FRuluozDNlkj7Q51fGHFkd
 YTI8+xjRmez5FfD82+L3OB3mfWD7K5ocVBDuqmj5hRr+GKz963JUNziEE+Cvm86aSjPJZxcfb
 4e0Q4cmlfIR1K984gkbYM4pRMcXkcGdcZED94RwsHCxT4EevliQJOiR1fUVOy+q+rpMLE1Uxj
 UkIuadI4VxJLmF7/Q27qUcD61f78cMiKAa3ri4fRkB5OmWVyrHcMS0QeFGQiDbMsTuGGzaYIQ
 LM4RblOoZ89IoYMVcf0A3PZR/3gNYefoMNobexJRJHQZvEQTP0tE0sLPTaxWs1HHQFReKy/Rt
 xszYz5fbG6IX/zxUNZbt1wHAWdCVaHBy0NQhSqGvIkPytaFz4L/DEbasVNsw1AQbV9U7928xN
 xlLhdrVTW2SGfBJPROlbGBs9jhwBeni8WQYU7inNui2JHMRem8gOE8IQIbBKx2ht3LG1lhroh
 +4SXkYii/puP0vw3BdbLkBUg==



=E5=9C=A8 2024/10/19 10:04, Boris Burkov =E5=86=99=E9=81=93:
> In debugging some corrupt squashfs files, we observed symptoms of
> corrupt page cache pages but correct on-disk contents. Further
> investigation revealed that the exact symptom was a correct page
> followed by an incorrect, duplicate, page. This got us thinking about
> extent maps.
>
> commit ac05ca913e9f ("Btrfs: fix race between using extent maps and merg=
ing them")
> enforces a reference count on the primary `em` extent_map being merged,
> as that one gets modified.
>
> However, since,
> commit 3d2ac9922465 ("btrfs: introduce new members for extent_map")
> both 'em' and 'merge' get modified, which started modifying 'merge'
> and thus introduced the same race.
>
> We were able to reproduce this by looping the affected squashfs workload
> in parallel on a bunch of separate btrfs-es while also dropping caches.
> We are still working on a simple enough reproducer to make into an fstes=
t.
>
> The simplest fix is to stop modifying 'merge', which is not essential,
> as it is dropped immediately after the merge. This behavior is simply
> a consequence of the order of the two extent maps being important in
> computing the new values. Modify merge_ondisk_extents to take prev and
> next by const* and also take a third merged parameter that it puts the
> results in. Note that this introduces the rather odd behavior of passing
> 'em' to merge_ondisk_extents as a const * and as a regular ptr.
>
> Fixes: 3d2ac9922465 ("btrfs: introduce new members for extent_map")
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just some small nitpicks inlined below, which can be done at merge time.

> ---
> Changelog:
> v2:
> - make 'merge' immutable instead of refcounting it
> ---
>   fs/btrfs/extent_map.c | 20 ++++++++------------
>   1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index d58d6fc40da1..a8290724475a 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -252,7 +252,8 @@ static bool mergeable_maps(const struct extent_map *=
prev, const struct extent_ma
>    * @prev and @next will be both updated to point to the new merged ran=
ge.

This comment needs to be updated.

Thanks,
Qu

>    * Thus one of them should be removed by the caller.
>    */
> -static void merge_ondisk_extents(struct extent_map *prev, struct extent=
_map *next)
> +static void merge_ondisk_extents(struct extent_map const *prev, struct =
extent_map const *next,
> +				 struct extent_map *merged)
>   {
>   	u64 new_disk_bytenr;
>   	u64 new_disk_num_bytes;
> @@ -287,15 +288,10 @@ static void merge_ondisk_extents(struct extent_map=
 *prev, struct extent_map *nex
>   			     new_disk_bytenr;
>   	new_offset =3D prev->disk_bytenr + prev->offset - new_disk_bytenr;
>
> -	prev->disk_bytenr =3D new_disk_bytenr;
> -	prev->disk_num_bytes =3D new_disk_num_bytes;
> -	prev->ram_bytes =3D new_disk_num_bytes;
> -	prev->offset =3D new_offset;
> -
> -	next->disk_bytenr =3D new_disk_bytenr;
> -	next->disk_num_bytes =3D new_disk_num_bytes;
> -	next->ram_bytes =3D new_disk_num_bytes;
> -	next->offset =3D new_offset;
> +	merged->disk_bytenr =3D new_disk_bytenr;
> +	merged->disk_num_bytes =3D new_disk_num_bytes;
> +	merged->ram_bytes =3D new_disk_num_bytes;
> +	merged->offset =3D new_offset;
>   }
>
>   static void dump_extent_map(struct btrfs_fs_info *fs_info, const char =
*prefix,
> @@ -363,7 +359,7 @@ static void try_merge_map(struct btrfs_inode *inode,=
 struct extent_map *em)
>   			em->generation =3D max(em->generation, merge->generation);
>
>   			if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
> -				merge_ondisk_extents(merge, em);
> +				merge_ondisk_extents(merge, em, em);
>   			em->flags |=3D EXTENT_FLAG_MERGED;
>
>   			validate_extent_map(fs_info, em);
> @@ -378,7 +374,7 @@ static void try_merge_map(struct btrfs_inode *inode,=
 struct extent_map *em)
>   	if (rb && can_merge_extent_map(merge) && mergeable_maps(em, merge)) {
>   		em->len +=3D merge->len;
>   		if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
> -			merge_ondisk_extents(em, merge);
> +			merge_ondisk_extents(em, merge, em);
>   		validate_extent_map(fs_info, em);
>   		em->generation =3D max(em->generation, merge->generation);
>   		em->flags |=3D EXTENT_FLAG_MERGED;


