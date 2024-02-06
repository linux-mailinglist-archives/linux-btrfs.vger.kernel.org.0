Return-Path: <linux-btrfs+bounces-2164-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 588DB84BADE
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 17:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53546B294FB
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E1B134CE6;
	Tue,  6 Feb 2024 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz+1H1na"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDBE12D150
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236630; cv=none; b=lYG9qX/neuEUSZfEDj5E//gaggSiDHG3lqXjIoRMnFlAgoESYO1MhAMIlM55z1ofmSJSfiPIuN3FGSe/wKSZfah+/BZVzNkOKjPEysiqBEYzehwDDAKIrKNRiIW8OQ3plqRyy55WkY9bC7e3zcBIPDx2XVIwYQyRDjCYxisCSeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236630; c=relaxed/simple;
	bh=p+QXC0XOEmpx6EvsneNcf+cBASoxMrW+eQ7ftaNhunk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjRffzDXAWuMro9Rfev4/v8Cr6foypD110hzIllesRmQQJSfELi42K6uHVww0dcnDKVn/6P2CO7ZM20tOnNvGSEIlrq9tU4mOzBPDOujQUtZzezhH/vKnD2U4VhLBUf8oHpCdmVwHsnHqaTo3B1phQBA4Cvv2eO0eCHdnXqby5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz+1H1na; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF98C433C7
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 16:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707236629;
	bh=p+QXC0XOEmpx6EvsneNcf+cBASoxMrW+eQ7ftaNhunk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Sz+1H1na+02xO1kUL/f6FY9e2oYm0JZ1ysrBPl7NPv6jbhlg0OSRWP1tx3tK9hwbb
	 S616Wzc6W1WMQU59QbqaCcN7aIugfWooKL7CKCC6x5y6P1/fHjhKL77nVdm0Dol+7K
	 KuhBYhrHkoOdsone/UNe0vw6rYovr71fqjAhazLle9Tien23bFUt/eQvKz5DkcT+/Z
	 M60hcCi7tL3QdMe75eRqY0Lu0QdC3kr3X3ZW2rEYPMLxjJ+BYDyVeS609Y6BTGU+vm
	 jc/2o426Xornc3D6w5ASLCpIevHpY+Lk4rf7eZNqjWcUBT5xx2lX5c/k+7js0pwpZx
	 TNkcFlZ1ZAw4Q==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51117bfd452so9735558e87.3
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Feb 2024 08:23:49 -0800 (PST)
X-Gm-Message-State: AOJu0YxV60jVIoE13AJDeAs0QrGlvpnMTswBmkJSLWgKB04kkjG1hjS3
	6BPZ2DxcU5px63qFJHxRQvvYfnB3+KFqKASfFFCVOnMTz57q31lQSlOQlxKr1GVICv7CpvGS8lA
	4gZ4kv6lgzxSj+yV9Wvz2Ei3pHbw=
X-Google-Smtp-Source: AGHT+IE3LXbxcCZlIaL287CSyy0KcMKsu0gnZ0mKeK8AB+4tyRfk8BXoIYPt0WSLK05KZRbpvbaQGTMrEkr42EpdQBg=
X-Received: by 2002:ac2:5317:0:b0:510:146a:a122 with SMTP id
 c23-20020ac25317000000b00510146aa122mr1872339lfh.46.1707236627683; Tue, 06
 Feb 2024 08:23:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707172743.git.wqu@suse.com> <2188d9521696a2c5f9bbb81479c6c94ea827a0aa.1707172743.git.wqu@suse.com>
In-Reply-To: <2188d9521696a2c5f9bbb81479c6c94ea827a0aa.1707172743.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 6 Feb 2024 16:23:10 +0000
X-Gmail-Original-Message-ID: <CAL3q7H72pQ=3wPZpN9zow8+G4xnhSP5UKH1ev808Y5GYYB2BQw@mail.gmail.com>
Message-ID: <CAL3q7H72pQ=3wPZpN9zow8+G4xnhSP5UKH1ev808Y5GYYB2BQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: defrag: add under utilized extent to defrag
 target list
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, 
	Christoph Anton Mitterer <calestyo@scientia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 11:46=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> The following script can lead to a very under utilized extent and we
> have no way to use defrag to properly reclaim its wasted space:
>
>   # mkfs.btrfs -f $dev
>   # mount $dev $mnt
>   # xfs_io -f -c "pwrite 0 128M" $mnt/foobar
>   # sync
>   # truncate -s 4k $mnt/foobar
>   # btrfs filesystem defrag $mnt/foobar
>   # sync
>
> After the above operations, the file "foobar" is still utilizing the
> whole 128M:
>
>         item 4 key (257 INODE_ITEM 0) itemoff 15883 itemsize 160
>                 generation 7 transid 8 size 4096 nbytes 4096
>                 block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
>                 sequence 32770 flags 0x0(none)
>         item 5 key (257 INODE_REF 256) itemoff 15869 itemsize 14
>                 index 2 namelen 4 name: file
>         item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
>                 generation 7 type 1 (regular)
>                 extent data disk byte 298844160 nr 134217728 <<<
>                 extent data offset 0 nr 4096 ram 134217728
>                 extent compression 0 (none)
>
> This is the common btrfs bookend behavior, that 128M extent would only
> be freed if the last referencer of the extent is freed.
>
> The problem is, normally we would go defrag to free that 128M extent,
> but defrag would not touch the extent at all.
>
> [CAUSE]
> The file extent has no adjacent extent at all, thus all existing defrag
> code consider it a perfectly good file extent, even if it's only
> utilizing a very tiny amount of space.
>
> [FIX]
> For a file extent without any adjacent file extent, we should still
> consider to defrag such under utilized extent, base on the following
> conditions:
>
> - utilization ratio
>   If the extent is utilizing less than 1/16 of the on-disk extent size,
>   then it would be a defrag target.
>
> - wasted space
>   If we defrag the extent and can free at least 16MiB, then it would be
>   a defrag target.
>
> Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

As I said in my previous review, please include the lore link to the
report, it's always useful.

> ---
>  fs/btrfs/defrag.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 8fc8118c3225..85c6e45d0cd4 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -950,6 +950,38 @@ struct defrag_target_range {
>         u64 len;
>  };
>
> +/*
> + * Special entry for extents that do not have any adjacent extents.
> + *
> + * This is for cases like the only and truncated extent of a file.
> + * Normally they won't be defraged at all (as they won't be merged with
> + * any adjacent ones), but we may still want to defrag them, to free up
> + * some space if possible.
> + */
> +static bool should_defrag_under_utilized(struct extent_map *em)

Can be made const.

> +{
> +       /*
> +        * Ratio based check.
> +        *
> +        * If the current extent is only utilizing 1/16 of its on-disk si=
ze,
> +        * it's definitely under-utilized, and defragging it may free up
> +        * the whole extent.
> +        */
> +       if (em->len < em->orig_block_len / 16)
> +               return true;
> +
> +       /*
> +        * Wasted space based check.
> +        *
> +        * If we can free up at least 16MiB, then it may be a good idea
> +        * to defrag.
> +        */
> +       if (em->len < em->orig_block_len &&
> +           em->orig_block_len - em->len > SZ_16M)

The first check, len < orig_block_len, is redundant, isn't it?
em->len can only be less than or equals to em->orig_block_len.
The second condition is enough to have.

> +               return true;
> +       return false;
> +}
> +
>  /*
>   * Collect all valid target extents.
>   *
> @@ -1070,6 +1102,16 @@ static int defrag_collect_targets(struct btrfs_ino=
de *inode,
>                 if (!next_mergeable) {
>                         struct defrag_target_range *last;
>
> +                       /*
> +                        * This is a single extent without any chance to =
merge
> +                        * with any adjacent extent.
> +                        *
> +                        * But if we may free up some space, it is still =
worth
> +                        * defragging.
> +                        */
> +                       if (should_defrag_under_utilized(em))
> +                               goto add;
> +

So this logic is making some cases worse actually, making us use more
disk space.
For example:

DEV=3D/dev/sdi
MNT=3D/mnt/sdi

mkfs.btrfs -f $DEV
mount $DEV $MNT

xfs_io -f -c "pwrite 0 128M" $MNT/foobar
sync
xfs_io -c "truncate 40M" $MNT/foobar
btrfs filesystem defrag $MNT/foobar

After this patch, we get:

item 6 key (257 EXTENT_DATA 0) itemoff 15810 itemsize 53
generation 7 type 1 (regular)
extent data disk byte 1104150528 nr 134217728
extent data offset 0 nr 8650752 ram 134217728
extent compression 0 (none)
item 7 key (257 EXTENT_DATA 8650752) itemoff 15757 itemsize 53
generation 8 type 1 (regular)
extent data disk byte 1238368256 nr 33292288
extent data offset 0 nr 33292288 ram 33292288
extent compression 0 (none)

So we're now using 128M + 32M of disk space where before defrag we used 128=
M.
Before the defrag we had:

item 6 key (257 EXTENT_DATA 0) itemoff 15810 itemsize 53
generation 7 type 1 (regular)
extent data disk byte 1104150528 nr 134217728
extent data offset 0 nr 41943040 ram 134217728
extent compression 0 (none)

So something's not good in this logic.

Also, there's something else worth considering here, which is extent shared=
ness.
If an extent is shared we don't want to always dirty the respective
range and rewrite it, as that may result in using more disk space...

Example:

xfs_io -f -c "pwrite 0 128M" $MNT/foobar
btrfs subvolume snapshot $MNT $MNT/snap
xfs_io -c "truncate 16M" $MNT/foobar
btrfs filesystem defrag $MNT/foobar

We end up consuming an additional 16M of data without any benefits.
Without this patch, this wouldn't happen.

Thanks.


>                         /* Empty target list, no way to merge with last e=
ntry */
>                         if (list_empty(target_list))
>                                 goto next;
> --
> 2.43.0
>
>

