Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B23EE14BC93
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2020 16:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgA1PHr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jan 2020 10:07:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgA1PHr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jan 2020 10:07:47 -0500
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C57A207FD
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jan 2020 15:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580224065;
        bh=zNXAL6fDLl7AhP7iPE3lYT54f7EWyhCfsBFNgifzV6w=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=UFIWo/HBzmZ23BU1fnj+/Tcfi/DaIjXgYxZ8akWfl8M6WpyLWyNL6lqj46cwULD1S
         ouudf4w7Gaed8brnDjyOklo0AuL1R9QeDAIIY37RA4UIXTI3tJHKyxRCA05+n4U8b0
         EUeu++10QrB22eE5zMUE/3LlyDY2z/2ULbAjY+MQ=
Received: by mail-ua1-f52.google.com with SMTP id x16so4918532uao.11
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jan 2020 07:07:45 -0800 (PST)
X-Gm-Message-State: APjAAAVkhYFqkn1fbA3nIZ8RBJgC3ER7Kcz5kVM5GCM+lQ0xUx2irAdv
        jjcf3Xov0UzY1/GKmcgHBvpRsuf/s6UkMxtm86c=
X-Google-Smtp-Source: APXvYqyis6uVuxtbKVsQFD/98MYYAFRToAehDSEonbswq96CKlIkmKn93+nfpkiIritoVH0aq8OmBkAXDfn9/Ranbc8=
X-Received: by 2002:ab0:18a1:: with SMTP id t33mr13767933uag.123.1580224064245;
 Tue, 28 Jan 2020 07:07:44 -0800 (PST)
MIME-Version: 1.0
References: <20200124115204.4086-1-fdmanana@kernel.org>
In-Reply-To: <20200124115204.4086-1-fdmanana@kernel.org>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 28 Jan 2020 15:07:32 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4b5USjefNx4NOeZkPWYcuNw8VCOQ6G-c-SRmDNH2=QoA@mail.gmail.com>
Message-ID: <CAL3q7H4b5USjefNx4NOeZkPWYcuNw8VCOQ6G-c-SRmDNH2=QoA@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: send, fix emission of invalid clone operations
 within the same file
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 24, 2020 at 11:54 AM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> When doing an incremental send and a file has extents shared with itself
> at different file offsets, it's possible for send to emit clone operations
> that will fail at the destination because the source range goes beyond the
> file's current size. This happens when the file size has increased in the
> send snapshot, there is a hole between the shared extents and both shared
> extents are at file offsets which are greater the file's size in the
> parent snapshot.
>
> Example:
>
>   $ mkfs.btrfs -f /dev/sdb
>   $ mount /dev/sdb /mnt/sdb
>
>   $ xfs_io -f -c "pwrite -S 0xf1 0 64K" /mnt/sdb/foobar
>   $ btrfs subvolume snapshot -r /mnt/sdb /mnt/sdb/base
>   $ btrfs send -f /tmp/1.snap /mnt/sdb/base
>
>   # Create a 320K extent at file offset 512K.
>   $ xfs_io -c "pwrite -S 0xab 512K 64K" /mnt/sdb/foobar
>   $ xfs_io -c "pwrite -S 0xcd 576K 64K" /mnt/sdb/foobar
>   $ xfs_io -c "pwrite -S 0xef 640K 64K" /mnt/sdb/foobar
>   $ xfs_io -c "pwrite -S 0x64 704K 64K" /mnt/sdb/foobar
>   $ xfs_io -c "pwrite -S 0x73 768K 64K" /mnt/sdb/foobar
>
>   # Clone part of that 320K extent into a lower file offset (192K).
>   # This file offset is greater than the file's size in the parent
>   # snapshot (64K). Also the clone range is a bit behind the offset of
>   # the 320K extent so that we leave a hole between the shared extents.
>   $ xfs_io -c "reflink /mnt/sdb/foobar 448K 192K 192K" /mnt/sdb/foobar
>
>   $ btrfs subvolume snapshot -r /mnt/sdb /mnt/sdb/incr
>   $ btrfs send -p /mnt/sdb/base -f /tmp/2.snap /mnt/sdb/incr
>
>   $ mkfs.btrfs -f /dev/sdc
>   $ mount /dev/sdc /mnt/sdc
>
>   $ btrfs receive -f /tmp/1.snap /mnt/sdc
>   $ btrfs receive -f /tmp/2.snap /mnt/sdc
>   ERROR: failed to clone extents to foobar: Invalid argument
>
> The problem is that after processing the extent at file offset 192K, send
> does not issue a write operation full of zeroes for the hole between that
> extent and the extent starting at file offset 520K (hole range from 384K
> to 512K), this is because the hole is at an offset larger the size of the
> file in the parent snapshot (384K > 64K). As a consequence the field
> 'cur_inode_next_write_offset' of the send context remains with a value of
> 384K when we start to process the extent at file offset 512K, which is the
> value set after processing the extent at offset 192K.
>
> This screws up the lookup of possible extents to clone because due to an
> incorrect value of 'cur_inode_next_write_offset' we can now consider
> extents for cloning, in the same inode, that lie beyond the current size
> of the file in the receiver of the send stream. Also, when checking if
> an extent in the same file can be used for cloning, we must also check
> that not only its start offset doesn't start at or beyond the current eof
> of the file in the receiver but that the source range doesn't go beyond
> current eof, that is we must check offset + length does not cross the
> current eof, as that makes clone operations fail with -EINVAL.
>
> So fix this by updating 'cur_inode_next_write_offset' whenever we start
> processing an extent and checking an extent's offset and length when
> considering it for cloning operations.
>
> A test case for fstests follows soon.
>
> Fixes: 11f2069c113e02 ("Btrfs: send, allow clone operations within the same file")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Tested-by: Craig Andrews <candrews@integralblue.com>

(on behalf of Craig, see
https://lore.kernel.org/linux-btrfs/f2ca887d98c1b5aacc4dde88cba74d98@integralblue.com/)

> ---
>  fs/btrfs/send.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 091e5bc8c7ea..0b42dac8a35f 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -1269,7 +1269,8 @@ static int __iterate_backrefs(u64 ino, u64 offset, u64 root, void *ctx_)
>                  * destination of the stream.
>                  */
>                 if (ino == bctx->cur_objectid &&
> -                   offset >= bctx->sctx->cur_inode_next_write_offset)
> +                   offset + bctx->extent_len >
> +                   bctx->sctx->cur_inode_next_write_offset)
>                         return 0;
>         }
>
> @@ -5804,6 +5805,18 @@ static int process_extent(struct send_ctx *sctx,
>                 }
>         }
>
> +       /*
> +        * There might be a hole between the end of the last processed extent
> +        * and this extent, and we may have not sent a write operation for that
> +        * hole because it was not needed (range is beyond eof in the parent
> +        * snapshot). So adjust the next write offset to the offset of this
> +        * extent, as we want to make sure we don't do mistakes when checking if
> +        * we can clone this extent from some other offset in this inode or when
> +        * detecting if we need to issue a truncate operation when finishing the
> +        * processing this inode.
> +        */
> +       sctx->cur_inode_next_write_offset = key->offset;
> +
>         ret = find_extent_clone(sctx, path, key->objectid, key->offset,
>                         sctx->cur_inode_size, &found_clone);
>         if (ret != -ENOENT && ret < 0)
> --
> 2.11.0
>
