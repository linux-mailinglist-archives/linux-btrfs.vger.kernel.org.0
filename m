Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6C723474E
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 16:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbgGaOEk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jul 2020 10:04:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35562 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730170AbgGaOEj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jul 2020 10:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596204277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cps8/F9QZ13raGQ0LNt7ieXiXD83betUld/eJQwHa/g=;
        b=WVd3iP/sX93kIBtHghXneehlGCA57MA6H6Qv+FNl4CWB6BWO6FOR64b3MmnYQrZeDTj2Cs
        HY/iDjLFUORpAwWLNsnPXI7ITr3UsNBqNtJWsMErV1LAkyhQ3W3Oh+fOJE3KLqYbTaqAwx
        yjmt32yqcl0uk0mnWgyMvnzz0To74pU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-HTbagnDyMcOMp4xwrfszhQ-1; Fri, 31 Jul 2020 10:03:27 -0400
X-MC-Unique: HTbagnDyMcOMp4xwrfszhQ-1
Received: by mail-ot1-f71.google.com with SMTP id h8so8845683oth.20
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jul 2020 07:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cps8/F9QZ13raGQ0LNt7ieXiXD83betUld/eJQwHa/g=;
        b=QqVpeZph2UO/XJoSKGKNmnqYGaBf23EXR1iJwbSFoknAzXQkEAjNNbTd37yWYfLdp4
         nVjfz+9zwLp/eiyFlvLvw9bVgSaq1je+yNrsI79gvaIJ3yEVjFtc0+jdrq9VTsrYpNib
         0400e9tlbtjWP0XrTcVK2TyY3JI449qKv2xAMwXj0QzKD3zIQBPRHtRmESdO8v6wcCVi
         t8ZFn7q2SmyeuLjbqY0tGICsu4A13w5MXrXGqYPn+DVlyjOfXqXaC1fV6kSXWO71yfy8
         /xDow+nuc3wdrho8faCUqgQa81nInUisFjuKBY0xjOA5RwxP2AY86yNnGPwiL0eXQVG0
         1OWw==
X-Gm-Message-State: AOAM53138Lz7cid+O4v7MI1pk/IO3tLeMV9L6CwupbnruTzP+DneiHR9
        R0vSu1It457Jelod/iQWLBTSi0bI2O/rEE7RlI5te3Rb/OI8ZwBNLelHSLK/t0YjbR/VCYRyWPa
        A+q852LubB84Z7VW2RnFEMUWoxv1uQahkUrRRSK8=
X-Received: by 2002:aca:5cc5:: with SMTP id q188mr2875440oib.10.1596204205913;
        Fri, 31 Jul 2020 07:03:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2o1MCathljqcbxdIfvbrQ4AoMpjkC6t7vNA2UlmPa6Y8MaoCbcKN4WLZ9gni27APqI9VwD7WX0IkKlBrdOtU=
X-Received: by 2002:aca:5cc5:: with SMTP id q188mr2875387oib.10.1596204205391;
 Fri, 31 Jul 2020 07:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200721183157.202276-1-hch@lst.de> <20200721183157.202276-4-hch@lst.de>
In-Reply-To: <20200721183157.202276-4-hch@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 31 Jul 2020 16:03:13 +0200
Message-ID: <CAHc6FU4KpmW71xA1iX3rPp0evEPoYN3gjcSHt4de+K3R1ZKgEQ@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH 3/3] iomap: fall back to buffered writes
 for invalidation failures
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 21, 2020 at 8:55 PM Christoph Hellwig <hch@lst.de> wrote:
> Failing to invalid the page cache means data in incoherent, which is
> a very bad state for the system.  Always fall back to buffered I/O
> through the page cache if we can't invalidate mappings.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/ext4/file.c       |  2 ++
>  fs/gfs2/file.c       |  3 ++-
>  fs/iomap/direct-io.c | 16 +++++++++++-----
>  fs/iomap/trace.h     |  1 +
>  fs/xfs/xfs_file.c    |  4 ++--
>  fs/zonefs/super.c    |  7 +++++--
>  6 files changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 2a01e31a032c4c..129cc1dd6b7952 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -544,6 +544,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>                 iomap_ops = &ext4_iomap_overwrite_ops;
>         ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>                            is_sync_kiocb(iocb) || unaligned_io || extend);
> +       if (ret == -ENOTBLK)
> +               ret = 0;
>
>         if (extend)
>                 ret = ext4_handle_inode_extension(inode, offset, ret, count);
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index bebde537ac8cf2..b085a3bea4f0fd 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -835,7 +835,8 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
>
>         ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,
>                            is_sync_kiocb(iocb));
> -
> +       if (ret == -ENOTBLK)
> +               ret = 0;
>  out:
>         gfs2_glock_dq(&gh);
>  out_uninit:
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 190967e87b69e4..c1aafb2ab99072 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -10,6 +10,7 @@
>  #include <linux/backing-dev.h>
>  #include <linux/uio.h>
>  #include <linux/task_io_accounting_ops.h>
> +#include "trace.h"
>
>  #include "../internal.h"
>
> @@ -401,6 +402,9 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
>   * can be mapped into multiple disjoint IOs and only a subset of the IOs issued
>   * may be pure data writes. In that case, we still need to do a full data sync
>   * completion.
> + *
> + * Returns -ENOTBLK In case of a page invalidation invalidation failure for
> + * writes.  The callers needs to fall back to buffered I/O in this case.
>   */
>  ssize_t
>  iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> @@ -478,13 +482,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>         if (iov_iter_rw(iter) == WRITE) {
>                 /*
>                  * Try to invalidate cache pages for the range we are writing.
> -                * If this invalidation fails, tough, the write will still work,
> -                * but racing two incompatible write paths is a pretty crazy
> -                * thing to do, so we don't support it 100%.
> +                * If this invalidation fails, let the caller fall back to
> +                * buffered I/O.
>                  */
>                 if (invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,
> -                               end >> PAGE_SHIFT))
> -                       dio_warn_stale_pagecache(iocb->ki_filp);
> +                               end >> PAGE_SHIFT)) {
> +                       trace_iomap_dio_invalidate_fail(inode, pos, count);
> +                       ret = -ENOTBLK;
> +                       goto out_free_dio;
> +               }
>
>                 if (!wait_for_completion && !inode->i_sb->s_dio_done_wq) {
>                         ret = sb_init_dio_done_wq(inode->i_sb);
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index 5693a39d52fb63..fdc7ae388476f5 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -74,6 +74,7 @@ DEFINE_EVENT(iomap_range_class, name, \
>  DEFINE_RANGE_EVENT(iomap_writepage);
>  DEFINE_RANGE_EVENT(iomap_releasepage);
>  DEFINE_RANGE_EVENT(iomap_invalidatepage);
> +DEFINE_RANGE_EVENT(iomap_dio_invalidate_fail);
>
>  #define IOMAP_TYPE_STRINGS \
>         { IOMAP_HOLE,           "HOLE" }, \
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index a6ef90457abf97..1b4517fc55f1b9 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -553,8 +553,8 @@ xfs_file_dio_aio_write(
>         xfs_iunlock(ip, iolock);
>
>         /*
> -        * No fallback to buffered IO on errors for XFS, direct IO will either
> -        * complete fully or fail.
> +        * No fallback to buffered IO after short writes for XFS, direct I/O
> +        * will either complete fully or return an error.
>          */
>         ASSERT(ret < 0 || ret == count);
>         return ret;
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 07bc42d62673ce..d0a04528a7e18e 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -786,8 +786,11 @@ static ssize_t zonefs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>         if (iocb->ki_pos >= ZONEFS_I(inode)->i_max_size)
>                 return -EFBIG;
>
> -       if (iocb->ki_flags & IOCB_DIRECT)
> -               return zonefs_file_dio_write(iocb, from);
> +       if (iocb->ki_flags & IOCB_DIRECT) {
> +               ssize_t ret = zonefs_file_dio_write(iocb, from);
> +               if (ret != -ENOTBLK)
> +                       return ret;
> +       }
>
>         return zonefs_file_buffered_write(iocb, from);
>  }
> --
> 2.27.0
>

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com> # for gfs2

Thanks,
Andreas

