Return-Path: <linux-btrfs+bounces-1321-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C39828890
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 15:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427561C245BB
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688A539AE7;
	Tue,  9 Jan 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRM7dpUY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEEE1E532
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Jan 2024 14:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7614DC43390
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Jan 2024 14:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704812163;
	bh=gLc4NewIRz1268K31ua6hNx7XMiDhaGlf35JIZRU++I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NRM7dpUY1KCb4CJfZ2cBKgQgs7CofNRmn6VE5Sp3rDTIuWaUp/0dy2jfBMMYe9cVP
	 tnJZwFeupx2Xau6HTWiDjjzskUiQD88+FYXGtmrd3zlg8h1+Wovq7BmdUtjzmCtJeo
	 kcd9ysgWR+qbaIlBEXcf+1g49oL76uA07N8ooXtznGjoGgreuQdURANzIY4k7DLJAB
	 C7sUN1Sp2g1xj8167Vm8PSvWihJZE5J5guwjx8Bjw2oIv9LOUB6gRSZYWbBcIJAKZG
	 iptkFgBQAZq1PX3BVPSnxOvT6LnQKobUwt1ovqT/fYNCi264i864T9lqQE3JpW35r8
	 iAubmgiiN3Bvg==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2ac304e526so208445966b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Jan 2024 06:56:03 -0800 (PST)
X-Gm-Message-State: AOJu0YxFAntjlpRdIz+lL8kZjjEoYIjG6Pn2277OyjsPRn1tUQX+Kz6r
	nq+1alI/KtdP/sXsGhSnibVQQAo+pij8Uhk2wJE=
X-Google-Smtp-Source: AGHT+IFnbVnQlLg+t1fPrH8uXOhzU5hdyKhcrLC6YIubFljYAGK5TVcAYeIyqJKdNzmmrvhZVrlSTH+l98xz8+mSKGI=
X-Received: by 2002:a17:906:7c13:b0:a28:fe29:c27f with SMTP id
 t19-20020a1709067c1300b00a28fe29c27fmr604473ejo.104.1704812161902; Tue, 09
 Jan 2024 06:56:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
In-Reply-To: <2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 9 Jan 2024 14:55:24 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5LEjZCkhTwgYJLSeQkG6NsY5AhE__na-2hCa7UuXuCzw@mail.gmail.com>
Message-ID: <CAL3q7H5LEjZCkhTwgYJLSeQkG6NsY5AhE__na-2hCa7UuXuCzw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: defrag: add under utilized extent to defrag target list
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, 
	Christoph Anton Mitterer <calestyo@scientia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 7:34=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> The following script can lead to a very under utilized extent and we
> have no way to use defrag to properly reclaim its wasted space:
>
>   # mkfs.btrfs -f $dev
>   # mount $dev $mnt
>   # xfs_io -f -c "pwrite 0 128M" $mnt/foobar
>   # sync
>   # btrfs filesystem defrag $mnt/foobar
>   # sync

There's a missing truncate in the example.

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
> Meaning the expected defrag way to reclaim the space is not working.
>
> [CAUSE]
> The file extent has no adjacent extent at all, thus all existing defrag
> code consider it a perfectly good file extent, even if it's only
> utilizing a very tiny amount of space.
>
> [FIX]
> Add a special handling for under utilized extents, currently the ratio
> is 6.25% (1/16).
>
> This would allow us to add such extent to our defrag target list,
> resulting it to be properly defragged.
>
> Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/defrag.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index c276b136ab63..cc319190b6fb 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -1070,6 +1070,17 @@ static int defrag_collect_targets(struct btrfs_ino=
de *inode,
>                 if (!next_mergeable) {
>                         struct defrag_target_range *last;
>
> +                       /*
> +                        * Special entry point utilization ratio under 1/=
16 (only
> +                        * referring 1/16 of an on-disk extent).
> +                        * This can happen for a truncated large extent.
> +                        * If we don't add them, then for a truncated fil=
e
> +                        * (may be the last 4K of a 128M extent) it will =
never

may be -> maybe

> +                        * be defraged.

defraged -> defragged

> +                        */
> +                       if (em->ram_bytes < em->orig_block_len / 16)

Why 1 / 16?
For a 128M extent for example, even 1 / 2 (64M) is a lot of wasted space.
So I think a better condition is needed, probably to consider the
absolute value of wasted/unused space too.

And this should use em->len and not em->ram_bytes. The latter is
preserved when spitting an extent map.
You can even notice this in the tree dump example from the change log
- the file extent's items ram bytes is 128M, not 4K.

Thanks.

> +                               goto add;
> +
>                         /* Empty target list, no way to merge with last e=
ntry */
>                         if (list_empty(target_list))
>                                 goto next;
> --
> 2.43.0
>
>

