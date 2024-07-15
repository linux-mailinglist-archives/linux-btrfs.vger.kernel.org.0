Return-Path: <linux-btrfs+bounces-6476-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0385E9315A0
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 15:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF2F281CF7
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 13:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096A918EA6A;
	Mon, 15 Jul 2024 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GALUEUW9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E1818E754;
	Mon, 15 Jul 2024 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049642; cv=none; b=g5wpNR7YOoxFBDx+vNvoOFCvqK+WCM7Idmf2J6LoINC9V05FDBs003yoNAOiwFWOTcFyL2MkrLsg2x/pyjExStvR22yNWYBup6wioj5P1sM3dMSvFtKeOrBSrj45HKjlIhH0Q6rakiSGxcKnEhsx1+S++MCJ/p2DSVAexnC8jvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049642; c=relaxed/simple;
	bh=6hyYPxFUhD7I6zyQtASLR4ctfHmneimEK/DsS+cEBs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khyBbkPPmeDIL79az5hcZzAIjurhZ95VHCNZeviSpPI92BntbFrZt65NAERNJJpaMd9A1/bIYlDyof+OtkH3oN6kwNL4d2+m8QFHWqSU72d16z5a3NXhTPaIDpkX2riYtIuJhu8CYsPcBqUnI/YYpbiMlum3BlPGf4BKzYrYVKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GALUEUW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C7BC4AF11;
	Mon, 15 Jul 2024 13:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721049641;
	bh=6hyYPxFUhD7I6zyQtASLR4ctfHmneimEK/DsS+cEBs4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GALUEUW9q9h+1ku9gbbMW+doZdhUY9GOL+DpYN4PwJ4TKXQf5LLhmEneF4bWyVOrt
	 4FLBDslEtrroUTihxtg+J26UIU31sa2JHiU7psQFHJQFa5tfAybhQ16WLSWqJt7dlG
	 Yu5PkMZRnEwAlnoBBHtRgkbvEpXMST6vL7REsBbKwXmqhYIx9dHiITzx/gcbHln0P8
	 rRPwiz/dGC1MsUvMbs58OP9fUqHqdxTRj/NwP5PDWfcndlAPJcQ/k0h/e6q8znZm1d
	 ZzYM2pqE7d+pjeiHc4iyTD7EWGdJ+7yScf1cYQfef1gdbHJQtKxXaz1rgz2wWj9Oe5
	 Qdq/MxDICgWPQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77c349bb81so448332166b.3;
        Mon, 15 Jul 2024 06:20:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCValzjXn7mTu4vanF4ZB9UctW7UkIhAP7lFPt2vaB++swSskMvoTwSNJ+eOAKdwz53/nww3yxgzGguguRY5u8FZvifwdoQMJDQWUSFpD8QAf8bjcqUBBISNrvoymUb7GQ3PH1MkVbTJ3qc=
X-Gm-Message-State: AOJu0YzrtTLQZIWBUro3qaOayLswkzjpea7Qe3Jk/X5fbb6oAJBTlTyS
	BACy/tGOLihddalz8JhxTA0DKuqE3+stHL3rwXhlOqcg/x21qcsomKxjmxwb5xVvJ0cTlP+Ig5W
	HpLnz8rWaBw4gVll7rKc5Ze1xPwA=
X-Google-Smtp-Source: AGHT+IH0RwYYQ+jpcfsnA7c4Vaum6zxOH6AHJKMaCHlFjwIJd3yCpDozCc5M9HIOZ/aL63Lwu2h/NaZVXFYOrnCiTqk=
X-Received: by 2002:a17:907:7255:b0:a77:c080:1200 with SMTP id
 a640c23a62f3a-a780b6b3a91mr1441622666b.31.1721049640276; Mon, 15 Jul 2024
 06:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715130820.19907-1-jth@kernel.org>
In-Reply-To: <20240715130820.19907-1-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Jul 2024 14:20:03 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7Lhym2F82Fu=VDoD1uvvVFW2q9WVx_pM0jVf+VS=ji8A@mail.gmail.com>
Message-ID: <CAL3q7H7Lhym2F82Fu=VDoD1uvvVFW2q9WVx_pM0jVf+VS=ji8A@mail.gmail.com>
Subject: Re: [PATCH v4] btrfs: don't hold dev_replace rwsem over whole of btrfs_map_block
To: Johannes Thumshirn <jth@kernel.org>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>, Josef Bacik <josef@toxicpanda.com>, 
	Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, 
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 2:13=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Don't hold the dev_replace rwsem for the entirety of btrfs_map_block().
>
> It is only needed to protect
> a) calls to find_live_mirror() and
> b) calling into handle_ops_on_dev_replace().
>
> But there is no need to hold the rwsem for any kind of set_io_stripe()
> calls.
>
> So relax taking the dev_replace rwsem to only protect both cases and chec=
k
> if the device replace status has changed in the meantime, for which we ha=
ve
> to re-do the find_live_mirror() calls.
>
> This fixes a deadlock on raid-stripe-tree where device replace performs a
> scrub operation, which in turn calls into btrfs_map_block() to find the
> physical location of the block.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> ---
> Cc: Filipe Manana <fdmanana@suse.com>
>
> Changes in v4:
> - Free bioc in case we need to redo the mapping
> Link to v3:
> https://lore.kernel.org/linux-btrfs/20240712-b4-rst-updates-v3-1-5cf27dac=
98a7@kernel.org

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

> ---
>  fs/btrfs/volumes.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index fcedc43ef291..9437e779d020 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6650,14 +6650,9 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
>         max_len =3D btrfs_max_io_len(map, map_offset, &io_geom);
>         *length =3D min_t(u64, map->chunk_len - map_offset, max_len);
>
> +again:
>         down_read(&dev_replace->rwsem);
>         dev_replace_is_ongoing =3D btrfs_dev_replace_is_ongoing(dev_repla=
ce);
> -       /*
> -        * Hold the semaphore for read during the whole operation, write =
is
> -        * requested at commit time but must wait.
> -        */
> -       if (!dev_replace_is_ongoing)
> -               up_read(&dev_replace->rwsem);
>
>         switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
>         case BTRFS_BLOCK_GROUP_RAID0:
> @@ -6695,6 +6690,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, =
enum btrfs_map_op op,
>                            "stripe index math went horribly wrong, got st=
ripe_index=3D%u, num_stripes=3D%u",
>                            io_geom.stripe_index, map->num_stripes);
>                 ret =3D -EINVAL;
> +               up_read(&dev_replace->rwsem);
>                 goto out;
>         }
>
> @@ -6710,6 +6706,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, =
enum btrfs_map_op op,
>                  */
>                 num_alloc_stripes +=3D 2;
>
> +       up_read(&dev_replace->rwsem);
> +
>         /*
>          * If this I/O maps to a single device, try to return the device =
and
>          * physical block information on the stack instead of allocating =
an
> @@ -6782,6 +6780,19 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
>                 goto out;
>         }
>
> +       /*
> +        * Check if something changed the dev_replace state since
> +        * we've checked it for the last time and if redo the whole
> +        * mapping operation.
> +        */
> +       down_read(&dev_replace->rwsem);
> +       if (dev_replace_is_ongoing !=3D
> +           btrfs_dev_replace_is_ongoing(dev_replace)) {
> +               btrfs_put_bioc(bioc);
> +               up_read(&dev_replace->rwsem);
> +               goto again;
> +       }
> +
>         if (op !=3D BTRFS_MAP_READ)
>                 io_geom.max_errors =3D btrfs_chunk_max_errors(map);
>
> @@ -6789,6 +6800,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, =
enum btrfs_map_op op,
>             op !=3D BTRFS_MAP_READ) {
>                 handle_ops_on_dev_replace(bioc, dev_replace, logical, &io=
_geom);
>         }
> +       up_read(&dev_replace->rwsem);
>
>         *bioc_ret =3D bioc;
>         bioc->num_stripes =3D io_geom.num_stripes;
> @@ -6796,11 +6808,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
>         bioc->mirror_num =3D io_geom.mirror_num;
>
>  out:
> -       if (dev_replace_is_ongoing) {
> -               lockdep_assert_held(&dev_replace->rwsem);
> -               /* Unlock and let waiting writers proceed */
> -               up_read(&dev_replace->rwsem);
> -       }
>         btrfs_free_chunk_map(map);
>         return ret;
>  }
> --
> 2.43.0
>
>

