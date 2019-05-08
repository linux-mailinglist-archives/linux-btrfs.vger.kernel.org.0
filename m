Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3879017EC4
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2019 19:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfEHRDl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 May 2019 13:03:41 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37060 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbfEHRDd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 May 2019 13:03:33 -0400
Received: by mail-ua1-f66.google.com with SMTP id l17so7640180uar.4
        for <linux-btrfs@vger.kernel.org>; Wed, 08 May 2019 10:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=9UQf4nOL6vF/dmn9tKv3GPs05tU12gLKu/Eyx8X/I18=;
        b=IZ/JNQTSmQ0+Zqcs+EI+5/BkBYZCmBuLJeNc/brI9nd73lyM7Xj4AALNIreCXf4Jre
         Onk003EIRqk78Aan/TNtgb06rsN2KeTfXpE9DqTPd6V92YUgbqm653uO84dBRXvzvWdJ
         y7dsEAi/nVQ5Qs6hPxvFe2VJ6449cdkP3choK3/EhgcP5hsE82D6so78EN4pJU/0eYT2
         gp/03yq1fGnZl35g4XPQjMOR7MWI4RIPZA8sdaOF07rPpIxkwZwUKYUzQvszG7UfGiZa
         NQf8dOkUesddGkHCetrKdQObvr6CAXs7u3dd4gW7YJBqvGIzh20qRp2dHcp0Ur0oVEEi
         hMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=9UQf4nOL6vF/dmn9tKv3GPs05tU12gLKu/Eyx8X/I18=;
        b=Y834souS0fjlBDSLZ0CRsexVZQEbgHgwIicJp6u+tz/+RybSvbELZhuFeehC+6349Y
         /WgVAeeHaxLGHNC/bLRzvuX+K9qN8bvLfFfFt1jcV5eFkHqPYsIspLEA2RgYfYtUGYef
         B3LymW4n5j0tAL72aWpt63YDrEVY5p0SKJb3lBV90kQORU+F8MV3JRdWWkKkJgr0F3Ya
         ng+os942i4GtSgwYf9pOwouADc9PiNZMaVxxwWvTBvp4N/qBF1gDFq6cezAgWkXsjtRQ
         RtWGTC2VlU6Gt7MumX9T62Ssuo7Uf+K86sNoK4NcDjPP5HxbIwBUpphMM4On4n9qNSj1
         94nQ==
X-Gm-Message-State: APjAAAXzbzwSRz+w1jNOGUbuxrGxajqrEgjdsGvur6DI/4UWdl+evXI+
        7AJF7xhnJ1fphV+JSOkwBxs/GN2g+p1SouxVV3UQ3Hqz
X-Google-Smtp-Source: APXvYqzjryaZj/jg7JzkN3BToTGaloZU7ICIc827MmWxoZFjCLGK2hyAjogfYVkbGukLCAtGpHCYbBzYOeLHkakUYYA=
X-Received: by 2002:ab0:7591:: with SMTP id q17mr404673uap.135.1557335012303;
 Wed, 08 May 2019 10:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190508104958.18363-1-wqu@suse.com>
In-Reply-To: <20190508104958.18363-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 8 May 2019 18:03:21 +0100
Message-ID: <CAL3q7H5e342Ee55O+M35jmETjpBBmV+XhX-muum861Zs+Hk7mw@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: Flush before reflinking any extent to prevent
 NOCOW write falling back to CoW without data reservation
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 8, 2019 at 1:43 PM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> The following script can cause unexpected fsync failure:
>
>   #!/bin/bash
>
>   dev=3D/dev/test/test
>   mnt=3D/mnt/btrfs
>
>   mkfs.btrfs -f $dev -b 512M > /dev/null
>   mount $dev $mnt -o nospace_cache
>
>   # Prealloc one extent
>   xfs_io -f -c "falloc 8k 64m" $mnt/file1
>   # Fill the remaining data space
>   xfs_io -f -c "pwrite 0 -b 4k 512M" $mnt/padding
>   sync
>
>   # Write into the prealloc extent
>   xfs_io -c "pwrite 1m 16m" $mnt/file1
>
>   # Reflink then fsync, fsync would fail due to ENOSPC
>   xfs_io -c "reflink $mnt/file1 8k 0 4k" -c "fsync" $mnt/file1
>   umount $dev
>
> The fsync fails with ENOSPC, and the last page of the buffered write is
> lost.
>
> [CAUSE]
> This is caused by:
> - Btrfs' back reference only has extent level granularity
>   So write into shared extent must be CoWed even only part of the extent
>   is shared.
>
> So for above script we have:
> - fallocate
>   Create a preallocated extent where we can do NOCOW write.
>
> - fill all the remaining data and unallocated space
>
> - buffered write into preallocated space
>   As we have not enough space available for data and the extent is not
>   shared (yet) we fall into NOCOW mode.
>
> - reflink
>   Now part of the large preallocated extent is shared, later write
>   into that extent must be CoWed.
>
> - fsync triggers writeback
>   But now the extent is shared and therefore we must fallback into COW
>   mode, which fails with ENOSPC since there's not enough space to
>   allocate data extents.
>
> [WORKAROUND]
> The workaround is to ensure any buffered write in the related extents
> (not just the reflink source range) get flushed before reflink/dedupe,
> so that NOCOW writes succeed that happened before reflinking succeed.
>
> The workaround is expensive, we could do it better by only flushing
> NOCOW range, but that needs extra accounting for NOCOW range.
> For now, fix the possible data loss first.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
> changelog:
> RFC->v1:
> - Use better words for commit message and comment.
> - Move the whole inode flushing to btrfs_remap_file_range_prep().
>   This also covers dedupe.
> - Update the reproducer to fail explicitly.
> - Remove false statement on transaction abort.
>
> v1->v2:
> - Extra comment and commit message refine.
> - Don't wait ordered extent, only flush (starts delalloc)
>   Single filemap_flush() should be enough. The async extent part will
>   never be NOCOWed, thus no need to worry.
> ---
>  fs/btrfs/ioctl.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 6dafa857bbb9..0e35bef2ec59 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4001,6 +4001,27 @@ static int btrfs_remap_file_range_prep(struct file=
 *file_in, loff_t pos_in,
>         if (!same_inode)
>                 inode_dio_wait(inode_out);
>
> +       /*
> +        * Workaround to make sure NOCOW buffered write reach disk as NOC=
OW.
> +        *
> +        * Btrfs' back references do not have a block level granularity, =
they
> +        * work at the whole extent level.
> +        * NOCOW buffered write without data space reserved may not be ab=
le
> +        * to fall back to CoW due to lack of data space, thus could caus=
e
> +        * data loss.
> +        *
> +        * Here we take a shortcut by flushing the whole inode, so that a=
ll
> +        * nocow write should reach disk as nocow before we increase the
> +        * reference of the extent. We could do better by only flushing N=
OCOW
> +        * data, but that needs extra accounting.
> +        *
> +        * Also we don't need to check ASYNC_EXTENT, as async extent will=
 be
> +        * CoWed anyway, not affecting nocow part.
> +        */
> +       ret =3D filemap_flush(inode_in->i_mapping);
> +       if (ret < 0)
> +               return ret;
> +
>         ret =3D btrfs_wait_ordered_range(inode_in, ALIGN_DOWN(pos_in, bs)=
,
>                                        wb_len);
>         if (ret < 0)
> --
> 2.21.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
