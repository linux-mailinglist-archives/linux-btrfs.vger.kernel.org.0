Return-Path: <linux-btrfs+bounces-9002-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFECD9A48D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 23:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D780B2365A
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 21:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D97820400A;
	Fri, 18 Oct 2024 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="njKXyPhS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F84317C22B
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Oct 2024 21:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286243; cv=none; b=N8qKqpdRsFjRzOlb3rPMLvXmU9BAyQmdIGd6TnYBS7CRXbhiEqG+k2/YNR1gwhaydYloULAOwSAtHHtYmkLX4vCZJ0V1zVKyGeUTbbiGV4EJOr+Ym6cuMIOHSilie/c/eIDkWqMxqarcxpeLh+d9jbDgwpAZjWfUkYUUcJ1kcpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286243; c=relaxed/simple;
	bh=xAcVhoBoNaj3yByKtmtiDxSWRbA+kOH99F9YX6aiZWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n7ZZrANnBXKL7YIP2MzuN/Wb9ZXO0mrWq+Psj+MjVyuz33X+ezsf3XmveNjUlHJ9D36sev38QYLWl3G8YiX7pHL+P4fdgJ9Bldg6NF3tng2rw9Iwy+9QZqPOosX05G4PppWqL4CAQl2U/9NKvui9mXynVOdvmi3dE7jV0RjB74g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=njKXyPhS; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1729286230; x=1729891030; i=quwenruo.btrfs@gmx.com;
	bh=NRgvnG3skYlSpKcwmiCYMQGMqRzgvToYb25/EciNe60=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=njKXyPhSqUOkK+BzsKMZnTMvRZlWdUdAW+5wdy2oLGohTiCHX61ym4ishS4qxtC2
	 hzMY2JbW+9+m2QF+Nx6HlNjatiMPkcPyy7QAoTeA8g0KT2HJJPpG04HwnLM2IY+pP
	 VpyebBBe0mmFy+66GndWM1LmtSVBS8mraCNPvlSVV2qPFkRIF4cLfdYr5Hd6xxFSq
	 l762EfeapwKcdvYCR8irFJIfTM6+wgoAzULUIrCJB03uRNkRsJh+sykQRYVLn5HeX
	 93SC9KFdFIHURSX5+8/WLn0k/WjoKE8hWoJqj/1ogcIgFY6Hj/R8SsQC6HRqIIAv4
	 U5Og5SCbRK9bHYGTdQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2mFY-1u4e3W0qCq-01377F; Fri, 18
 Oct 2024 23:17:10 +0200
Message-ID: <5695f144-4bac-4447-aa61-b82b7ed11160@gmx.com>
Date: Sat, 19 Oct 2024 07:47:06 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: hold merge refcount during extent_map merge
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <04478f1919b69f470f1c56bae80512491c97a8b1.1729277554.git.boris@bur.io>
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
In-Reply-To: <04478f1919b69f470f1c56bae80512491c97a8b1.1729277554.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5CLBEbwZUCBZSfIufKNYJhZudw6DL1ve4khZB+bR8U9/SmF8JjL
 3hm0VzTE1Oo4792bl6DOLSAF1sALO234PtgilaODWxEZJSToxrv5DJ+n2aDr9TbeA4ZEDj0
 oZDBVowH6R8RumNbN5dauibOb9Mnc9tqBYTY4RRcIKVeKHKBUTzYzlMydpKu/1Frp7hhmbE
 wn9WZnQkkN5Z9PT4Dwvug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+AdvOx03bu4=;jbTOZxUHfYkGgdmQ31Z3fLUN/H8
 lsVlh1RIGo+S5ynNFV6lgs88G5JnNG870vWM79iKeGdQBostrjDzCNMsVcVfdOnXGboPO4XSL
 jCoIbAjII+dtsRJFgmrsYAfttn/j8B935R+wUVFa/eeidr1wZuiFGXTdiVqDj5CDG/KItN8Tl
 A8UeT3rjwI0vKLQGEa0+MkR2C8UHP4HAj+38gDoW9Kik1Gvy6i6BwvN/P/I1bgF1Ob/X+Ntgp
 Vzs1E6HaVICSmEL2g4Nrrsm+J41ynNdSBCbqxM33E/ZBQ8W4piLj3cuGpQATZw/gNKtgrVbif
 D53RqoSlyYv7keOJfZxuL+Gf5F3pGkpjuld3NFQUjY1OK+IhYbRxPtXxTG3sGtB6ehxuwlWHO
 vQUzb2zd9UssoBT0a0jWb4rm+HrAwToy2yldhPYe6+hp3fuv2W3/sLhxJgGlvF9cZruD2wcMI
 W1RGsL5G0efyRvKK5H5i7fAzgeye9C7/vg4MZw+ySa9l7FgYCShF0MgPHKRtT8vrTTzvg/N+w
 QHOOzB0e1b++gjS048abQKDZCECJn2ke6J0WmGD9ZvSDqix4fGS9saK0mlcxKXkPSk8J+td2u
 yn958E6NXJclV2sSiROn/oLQ7y53H6v+Uj/8JcKPMqMJKeJjB8Ns6r8q1mZMade8rADCuB9yj
 tcnHLE7iXIbKYnKw1EDcgR2OFJ7mzPW9ZMXLlbZN7ORok/cOrugjN4Y1fpHtM4NfpcdqZazfU
 uCQPCJyEoNOGlcRKxSYyv2Qjj3LMakIA1IQpF7e6EZlrBDWLAHS//XjXKJ6ujlO0U2Jkgn1w+
 tJbc3hS/SvlivGb/aFMd0LXA==



=E5=9C=A8 2024/10/19 06:17, Boris Burkov =E5=86=99=E9=81=93:
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

Indeed, at that time @merge is read-only then removed from the rb tree.
No modification to the @merge members.

>
> However, since,
> commit 3d2ac9922465 ("btrfs: introduce new members for extent_map")
> both 'em' and 'merge' get modified, which introduced the same race and
> need for refcounting for 'merge'.

But I changed that, to make both @merge and @em to be the same,
initially I thought it's safer but it's the completely the opposite.

>
> We were able to reproduce this by looping the affected squashfs workload
> in parallel on a bunch of separate btrfs-es while also dropping caches.
>
> The fix is two-fold:
> - check the refs > 2 criterion for both 'em' and 'merge'
> - actually refcount 'merge' which we currently grab without a refcount
>    via rb_prev or rb_next.
>
> The other option we considered, but did not implement, was to stop
> modifying 'merge' as it gets deleted immediately after. However, it was
> less clear what effect that would have on the racing thread holding the
> reference, so we went with this fix.
>
> Fixes: 3d2ac9922465 ("btrfs: introduce new members for extent_map")
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks a lot for pinning down the bug and fix,
Qu

> ---
>   fs/btrfs/extent_map.c | 92 +++++++++++++++++++++++++++----------------
>   1 file changed, 57 insertions(+), 35 deletions(-)
>
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index d58d6fc40da1..108cd7573f61 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -215,6 +215,16 @@ static bool can_merge_extent_map(const struct exten=
t_map *em)
>
>   	if (em->flags & EXTENT_FLAG_LOGGING)
>   		return false;
> +	/*
> +	 * We can't modify an extent map that is in the tree and that is being
> +	 * used by another task, as it can cause that other task to see it in
> +	 * inconsistent state during the merging. We always have 1 reference f=
or
> +	 * the tree and 1 for this task (which is unpinning the extent map or
> +	 * clearing the logging flag), so anything > 2 means it's being used b=
y
> +	 * other tasks too.
> +	 */
> +	if (refcount_read(&em->refs) > 2)
> +		return false;
>
>   	/*
>   	 * We don't want to merge stuff that hasn't been written to the log y=
et
> @@ -333,57 +343,69 @@ static void validate_extent_map(struct btrfs_fs_in=
fo *fs_info, struct extent_map
>   	}
>   }
>
> -static void try_merge_map(struct btrfs_inode *inode, struct extent_map =
*em)
> +static int try_merge_one_map(struct btrfs_inode *inode, struct extent_m=
ap *em,
> +			     struct extent_map *merge, bool prev_merge)
>   {
>   	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> -	struct extent_map *merge =3D NULL;
> -	struct rb_node *rb;
> +	struct extent_map *prev;
> +	struct extent_map *next;
>
> +	if (prev_merge) {
> +		prev =3D merge;
> +		next =3D em;
> +	} else {
> +		prev =3D em;
> +		next =3D merge;
> +	}
>   	/*
> -	 * We can't modify an extent map that is in the tree and that is being
> -	 * used by another task, as it can cause that other task to see it in
> -	 * inconsistent state during the merging. We always have 1 reference f=
or
> -	 * the tree and 1 for this task (which is unpinning the extent map or
> -	 * clearing the logging flag), so anything > 2 means it's being used b=
y
> -	 * other tasks too.
> -	 */
> -	if (refcount_read(&em->refs) > 2)
> -		return;
> +	* Take a refcount for merge so we can maintain a proper
> +	* use count across threads for checking mergeability.
> +	*/
> +	refcount_inc(&merge->refs);
> +	if (!can_merge_extent_map(merge))
> +		goto no_merge;
> +
> +	if (!mergeable_maps(prev, next))
> +		goto no_merge;
> +
> +	if (prev_merge)
> +		em->start =3D merge->start;
> +	em->len +=3D merge->len;
> +	em->generation =3D max(em->generation, merge->generation);
> +	if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
> +		merge_ondisk_extents(prev, next);
> +	em->flags |=3D EXTENT_FLAG_MERGED;
> +
> +	validate_extent_map(fs_info, em);
> +	refcount_dec(&merge->refs);
> +	remove_em(inode, merge);
> +	free_extent_map(merge);
> +	return 0;
> +no_merge:
> +	refcount_dec(&merge->refs);
> +	return 1;
> +}
> +
> +static void try_merge_map(struct btrfs_inode *inode, struct extent_map =
*em)
> +{
> +	struct extent_map *merge =3D NULL;
> +	struct rb_node *rb;
>
>   	if (!can_merge_extent_map(em))
>   		return;
>
>   	if (em->start !=3D 0) {
>   		rb =3D rb_prev(&em->rb_node);
> -		if (rb)
> +		if (rb) {
>   			merge =3D rb_entry(rb, struct extent_map, rb_node);
> -		if (rb && can_merge_extent_map(merge) && mergeable_maps(merge, em)) {
> -			em->start =3D merge->start;
> -			em->len +=3D merge->len;
> -			em->generation =3D max(em->generation, merge->generation);
> -
> -			if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
> -				merge_ondisk_extents(merge, em);
> -			em->flags |=3D EXTENT_FLAG_MERGED;
> -
> -			validate_extent_map(fs_info, em);
> -			remove_em(inode, merge);
> -			free_extent_map(merge);
> +			try_merge_one_map(inode, em, merge, true);
>   		}
>   	}
>
>   	rb =3D rb_next(&em->rb_node);
> -	if (rb)
> +	if (rb) {
>   		merge =3D rb_entry(rb, struct extent_map, rb_node);
> -	if (rb && can_merge_extent_map(merge) && mergeable_maps(em, merge)) {
> -		em->len +=3D merge->len;
> -		if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
> -			merge_ondisk_extents(em, merge);
> -		validate_extent_map(fs_info, em);
> -		em->generation =3D max(em->generation, merge->generation);
> -		em->flags |=3D EXTENT_FLAG_MERGED;
> -		remove_em(inode, merge);
> -		free_extent_map(merge);
> +		try_merge_one_map(inode, em, merge, false);
>   	}
>   }
>


