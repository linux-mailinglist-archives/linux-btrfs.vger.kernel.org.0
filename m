Return-Path: <linux-btrfs+bounces-11563-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF613A3BBD5
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3F4177EE2
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 10:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4C91DE2B5;
	Wed, 19 Feb 2025 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyO0BcR7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E427C1AE005;
	Wed, 19 Feb 2025 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739961956; cv=none; b=llROrZ3B/PIbvpxEV2tX7Kxiiyq3h4vL4e3wyZdhYpe5LpJkqog8NiG/BHUca1JbNVestzI3pMDMcUYbQcVDyRxcYpjRJTmKWhUxWh4UhiVZfVf3277uUH9glKCuw0vvPMf92BIYE/qtYD4NNZg9/XP+xbvjt9BK5SHNltJLQc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739961956; c=relaxed/simple;
	bh=Jb2w6lCVr4kC3BuNMQrLa4sMzhliyKZXAM3DhHRZLP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uaIAjR/eF5Yw3Vub41HIgHu9Jdh7rTDBnbjpEFFIgx/ph4JfOXnVkjovBfbuhQpiETIFlCscrvv18Fe/8S//y35Rimqmh0o1NQFUIDaSpDTmslsEjWcejaHytf0WLeZxG7lFLx51wZga/35kn7vnWucigc4+wQXUcvR9ytwjHuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyO0BcR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72111C4CED1;
	Wed, 19 Feb 2025 10:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739961955;
	bh=Jb2w6lCVr4kC3BuNMQrLa4sMzhliyKZXAM3DhHRZLP0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SyO0BcR71Wlhv1qJ2kX4d9V80u/hlt2+TCFufbsDzNuFU9p9gl+P5tClNK+FumpaG
	 Oc0hYnPp7IIwl9Yut+IGyQiXTkgZ7i4WZ96jGEeYbnTTxWigrqA8DhS03WdyH68Iw0
	 1+DLrD/affwp6tCzLgskXhjCyT7RkKwNkuhtL+9gsL4HKGsT5eEV+BxI2FjEo38XhO
	 i5nodqZ7kVFwCqCwXWjZzgxEQddgoCjLVVrnzit9LjRO5NGVVKbepHEztzROsoUGQU
	 E5O270kQ684o0CqsFXE0iqWcSyELew3HTkrYp+a8tO8u48oAvU+BMelG4o2D98gZiL
	 IWjYn9vUmRpwg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso996521966b.1;
        Wed, 19 Feb 2025 02:45:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUzdD9btvW5NSfsvtaNm+Lc1zXXLUxBUf6l2GsfbMskpVwUJpnTSEYhx1vsbQeGW90kojKSXBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwayEgvV5Xg0f7pt6ebL/QoWm4wZQcNu8gQNS8oLR23/w9ocizN
	mt+Iu7H7J3DNZu2kjouWL+uJKjV8wMjj4p6vPUoYaJarBffz6um+Ybu1RX/FCjUJgQpUzVuFc+H
	Id11PqbanP4kVktAsF1JXp5zhVv8=
X-Google-Smtp-Source: AGHT+IEXQ94joaJvX6v+PPzAewiGWlKIkb77xmxvP737pvRdetWv1xxoasLM0NrTnZu+qJXRJ6U/awCnqCTaogmJwr8=
X-Received: by 2002:a17:907:7eaa:b0:ab3:76fb:96ab with SMTP id
 a640c23a62f3a-abbcd113d0fmr333069066b.57.1739961953971; Wed, 19 Feb 2025
 02:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a50ceebfe3155ab0f1f0018c28ef99bda264c039.1739920169.git.wqu@suse.com>
In-Reply-To: <a50ceebfe3155ab0f1f0018c28ef99bda264c039.1739920169.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 19 Feb 2025 10:45:17 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6gcebdicis6tPd3uFAZfuLYZRtEYdGc_azPaMdwOkEGQ@mail.gmail.com>
X-Gm-Features: AWEUYZngEr2on82UuKKihKxhcLYm1aqbWTpzBiXksYWAkZaAII9pceC5R_2OEkY
Message-ID: <CAL3q7H6gcebdicis6tPd3uFAZfuLYZRtEYdGc_azPaMdwOkEGQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix data overwriting bug during buffered write
 when block size < page size
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 11:10=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> When running generic/417 with a btrfs whose block size < page size

generic/417 -> generic/418

> (subpage cases), it always fails.
>
> And the following minimal reproducer is more than enough to trigger it
> reliably:
>
> workload()
> {
>         mkfs.btrfs -s 4k -f $dev > /dev/null
>         dmesg -C
>         mount $dev $mnt
>         $fsstree_dir/src/dio-invalidate-cache -r -b 4096 -n 3 -i 1 -f $mn=
t/diotest
>         ret=3D$?
>         umount $mnt
>         stop_trace
>         if [ $ret -ne 0 ]; then
>                 fail
>         fi
> }
>
> for (( i =3D 0; i < 1024; i++)); do
>         echo "=3D=3D=3D $i/$runtime =3D=3D=3D"
>         workload
> done
>
> [CAUSE]
> With extra trace printk added to the following functions:
> - btrfs_buffered_write()
>   * Which folio is touched
>   * The file offset (start) where the buffered write is at
>   * How many bytes are copied
>   * The content of the write (the first 2 bytes)
>
> - submit_one_sector()
>   * Which folio is touched
>   * The position inside the folio
>
> - pagecache_isize_extended()
>   * The parameters of the function itself
>   * The parameters of the folio_zero_range()
>
> Which are enough to show the problem:
>
>   22.158114: btrfs_buffered_write: folio pos=3D0 start=3D0 copied=3D4096 =
content=3D0x0101
>   22.158161: submit_one_sector: r/i=3D5/257 folio=3D0 pos=3D0 content=3D0=
x0101
>   22.158609: btrfs_buffered_write: folio pos=3D0 start=3D4096 copied=3D40=
96 content=3D0x0101
>   22.158634: btrfs_buffered_write: folio pos=3D0 start=3D8192 copied=3D40=
96 content=3D0x0101
>   22.158650: pagecache_isize_extended: folio=3D0 from=3D4096 to=3D8192 bs=
ize=3D4096 zero off=3D4096 len=3D8192
>   22.158682: submit_one_sector: r/i=3D5/257 folio=3D0 pos=3D4096 content=
=3D0x0000
>   22.158686: submit_one_sector: r/i=3D5/257 folio=3D0 pos=3D8192 content=
=3D0x0101
>
> The tool dio-invalidate-cache will start 3 threads, each doing a buffered
> write with 0x01 at 4096 * i (i is 0, 1 ,2), do a fsync, then do a direct =
read,
> and compare the read buffer with the write buffer.
>
> Note that all 3 btrfs_buffered_write() are writing the correct 0x01 into
> the page cache.
>
> But at submit_one_sector(), at file offset 4096, the content is zeroed
> out, mostly by pagecache_isize_extended().
>
> The race happens like this:
>  Thread A is writing into range [4K, 8K).
>  Thread B is writing into range [8K, 12k).
>
>                Thread A              |         Thread B
> -------------------------------------+-----------------------------------=
-
> btrfs_buffered_write()               | btrfs_buffered_write()
> |- old_isize =3D 4K;                   | |- old_isize =3D 4096;
> |- btrfs_inode_lock()                | |
> |- write into folio range [4K, 8K)   | |
> |- pagecache_isize_extended()        | |
> |  extend isize from 4096 to 8192    | |
> |  no folio_zero_range() called      | |
> |- btrfs_inode_lock()                | |
>                                      | |- btrfs_inode_lock()
>                                      | |- write into folio range [8K, 12K=
)
>                                      | |- pagecache_isize_extended()
>                                      | |  calling folio_zero_range(4K, 8K=
)
>                                      | |  This is caused by the old_isize=
 is
>                                      | |  grabbed too early, without any
>                                      | |  inode lock.
>                                      | |- btrfs_inode_unlock()
>
> The @old_isize is grabbed without inode lock, causing race between two
> buffered write threads and making pagecache_isize_extended() to zero
> range which is still containing cached data.
>
> And this is only affecting subpage btrfs, because for regular blocksize
> =3D=3D page size case, the function pagecache_isize_extended() will do
> nothing if the block size >=3D page size.
>
> [FIX]
> Grab the old isize with inode lock hold.

hold -> held

Or easier to understand:

Grab the old i_size while holding the inode lock.

> This means each buffered write thread will have a stable view of the
> old inode size, thus avoid the above race.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Fixes: 5e8b9ef30392 ("btrfs: move pos increment and pagecache
extension to btrfs_buffered_write")

That is the commit that introduced the race, before it we were
grabbing i_size and doing the pagecache_isize_extended() call while
holding the inode lock.

> ---
>  fs/btrfs/file.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index fd90855fe717..896dc03689d6 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1090,7 +1090,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, st=
ruct iov_iter *i)
>         u64 lockend;
>         size_t num_written =3D 0;
>         ssize_t ret;
> -       loff_t old_isize =3D i_size_read(inode);
> +       loff_t old_isize;
>         unsigned int ilock_flags =3D 0;
>         const bool nowait =3D (iocb->ki_flags & IOCB_NOWAIT);
>         unsigned int bdp_flags =3D (nowait ? BDP_ASYNC : 0);
> @@ -1103,6 +1103,13 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, s=
truct iov_iter *i)
>         if (ret < 0)
>                 return ret;
>
> +       /*
> +        * We can only trust the isize with inode lock hold, or it can ra=
ce with

Same here, hold -> held

With those things addressed:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +        * other buffered writes and cause incorrect call of
> +        * pagecache_isize_extended() to overwrite existing data.
> +        */
> +       old_isize =3D i_size_read(inode);
> +
>         ret =3D generic_write_checks(iocb, i);
>         if (ret <=3D 0)
>                 goto out;
> --
> 2.48.1
>
>

