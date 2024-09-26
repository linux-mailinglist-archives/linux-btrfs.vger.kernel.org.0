Return-Path: <linux-btrfs+bounces-8258-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFBA987485
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 15:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75CFFB2227D
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 13:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B55482E9;
	Thu, 26 Sep 2024 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJ56hdDS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC9322B;
	Thu, 26 Sep 2024 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727357883; cv=none; b=Uoq5J/UtHR/tOfszhV+MHxYQT31tDNtIuhq3RfmSaZqNnR0zUA5OjJ4VV5Rk3oWQo6WAQsKk5dOsZRdnKq/Qga47uhibd6Wq2hEFwrSTx0pDgxmbECfm4UJ0z24xlOJ/9JkKR8FWM6KJStoD+yoFArkSXldk2dSpnOhqk9Y1G64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727357883; c=relaxed/simple;
	bh=INf4Wsw9kIU4k07p5ZXbzAn6HdnkbBEj2ln9NIVYgPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/kl2kFiyS64blp8kAocQRXUhNbCBK9+su6PySvxSoFdItyO3umAlXJYBsUtg1GyngkdJf0gNme1YkAuNiS/AT6ACdsfB9fnHdEV5cdsRuBS3lqrf5xiwbeDsS7M1twyxAAM8u2LrmZ7w//72/AyXDrhzS74L/U8WV/U5hm8TKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJ56hdDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A626DC4CECE;
	Thu, 26 Sep 2024 13:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727357882;
	bh=INf4Wsw9kIU4k07p5ZXbzAn6HdnkbBEj2ln9NIVYgPs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vJ56hdDSTfalngNbsSNkZk5plwhxw1nCrDOA+D7dO9twrH4SiVLKvpm/Yuwpo60H5
	 XrsxmDWrRB21+5MbIb554Wc+FPhWAkGV7W9RaQiBadkLjDYA+7nOlJdF7rLvQlz3Vy
	 N2flUqrDjpyyubEnoozGSBAHue+Ucwx6+oYeIYGpzrDQ6tmnTSzJbTJxXa2kP0MIBK
	 YvpgSiNN0z5YTEENwM/4p9NZdu41LqrgZ1i+BfzdCjTGa6QBqrM5N3JNr+28vXTkbE
	 MEsKEzOjn7o5wuFyQrpXk+i5RV1QUrqJW2OJ6UeNJZ3Op6OewHeih3DSMA+rQTRr5+
	 /RD1ffvUSW5gQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c42384c517so1028387a12.3;
        Thu, 26 Sep 2024 06:38:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVl0dKcPw0SoCR5ODZDjJv/CcZ0tM05DhEMzncblpGM7yPDKKy8Mr+jEKtBFGAM9GRK8/QecGh3ZwD7xvNI@vger.kernel.org, AJvYcCWEB4p1voFDYDntJWmcQgXnEQ1Xq49X6a/v0wk8774xfnTP0+ijGrv9qAp15W/LCe/20WxAXNgGo1bmdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYOKkrFYzF4S9Vkf9GxpM2d60yknWzfmWj/WJVMlnXX9eloTQi
	EiSdIpunBknmhvXfIWnGihGPvHjeHoe1VLC+u1YqH+zZkv/YWxAQ3VVCR8G/M41xoZzs6EyDZZz
	EUwgO8OLOz0LxnCRoNsi8r4BW5SI=
X-Google-Smtp-Source: AGHT+IEd1oXxQPnDgGCZL4fiofB/Dtsie6w4KrDfXQC2Nm37gq8acxWSWuVYs7AFIxr1+1qZH2lHgxsoZB7lR5PJuV8=
X-Received: by 2002:a17:907:8688:b0:a86:78fd:1df0 with SMTP id
 a640c23a62f3a-a93a03c32c2mr536927266b.34.1727357881250; Thu, 26 Sep 2024
 06:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926115935.20631-1-jth@kernel.org>
In-Reply-To: <20240926115935.20631-1-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 26 Sep 2024 14:37:23 +0100
X-Gmail-Original-Message-ID: <CAL3q7H57KKwPWH0HYVZ+Hmo7GiWULkJkR7Hc83Zu47uE5x+-zQ@mail.gmail.com>
Message-ID: <CAL3q7H57KKwPWH0HYVZ+Hmo7GiWULkJkR7Hc83Zu47uE5x+-zQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove code duplication in ordered extent finishing
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 1:27=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Remove the duplicated transaction joining, block reserve setting and raid
> extent inserting in btrfs_finish_ordered_extent().
>
> While at it, also abort the transaction in case inserting a RAID
> stripe-tree entry fails.
>
> Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/inode.c | 45 ++++++++++++++++-----------------------------
>  1 file changed, 16 insertions(+), 29 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 353fb58c83da..35a03a671fc6 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3068,34 +3068,6 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_=
extent *ordered_extent)
>                         goto out;
>         }
>
> -       if (test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags)) {
> -               BUG_ON(!list_empty(&ordered_extent->list)); /* Logic erro=
r */
> -
> -               btrfs_inode_safe_disk_i_size_write(inode, 0);
> -               if (freespace_inode)
> -                       trans =3D btrfs_join_transaction_spacecache(root)=
;
> -               else
> -                       trans =3D btrfs_join_transaction(root);
> -               if (IS_ERR(trans)) {
> -                       ret =3D PTR_ERR(trans);
> -                       trans =3D NULL;
> -                       goto out;
> -               }
> -               trans->block_rsv =3D &inode->block_rsv;
> -               ret =3D btrfs_update_inode_fallback(trans, inode);
> -               if (ret) /* -ENOMEM or corruption */
> -                       btrfs_abort_transaction(trans, ret);
> -
> -               ret =3D btrfs_insert_raid_extent(trans, ordered_extent);
> -               if (ret)
> -                       btrfs_abort_transaction(trans, ret);
> -
> -               goto out;
> -       }
> -
> -       clear_bits |=3D EXTENT_LOCKED;
> -       lock_extent(io_tree, start, end, &cached_state);
> -
>         if (freespace_inode)
>                 trans =3D btrfs_join_transaction_spacecache(root);
>         else
> @@ -3109,8 +3081,23 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_=
extent *ordered_extent)
>         trans->block_rsv =3D &inode->block_rsv;
>
>         ret =3D btrfs_insert_raid_extent(trans, ordered_extent);
> -       if (ret)
> +       if (ret) {
> +               btrfs_abort_transaction(trans, ret);
> +               goto out;
> +       }
> +
> +       if (test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags)) {
> +               BUG_ON(!list_empty(&ordered_extent->list)); /* Logic erro=
r */
> +
> +               btrfs_inode_safe_disk_i_size_write(inode, 0);
> +               ret =3D btrfs_update_inode_fallback(trans, inode);
> +               if (ret) /* -ENOMEM or corruption */

While at it we can change the comment to comply with the preferred
style, to leave it on the line above or inside the if:

if (ret) {
   /* -ENOMEM or corruption */
  btrfs_abort_transaction(trans, ret);
}

Same for the other comment after the BUG_ON() (and we could change the
BUG_ON() to ASSERT() plus abort transaction maybe, but that probably
as a separate patch).

Otherwise it looks fine, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>


> +                       btrfs_abort_transaction(trans, ret);
>                 goto out;
> +       }
> +
> +       clear_bits |=3D EXTENT_LOCKED;
> +       lock_extent(io_tree, start, end, &cached_state);
>
>         if (test_bit(BTRFS_ORDERED_COMPRESSED, &ordered_extent->flags))
>                 compress_type =3D ordered_extent->compress_type;
> --
> 2.43.0
>
>

