Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE0E01745D
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2019 10:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfEHI7Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 May 2019 04:59:16 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33640 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfEHI7Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 May 2019 04:59:16 -0400
Received: by mail-vs1-f66.google.com with SMTP id z145so12195063vsc.0
        for <linux-btrfs@vger.kernel.org>; Wed, 08 May 2019 01:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=rm1M55oGiJwJFxL6wsCFOSYqIiIjt00FZUmE5VHkFA0=;
        b=am1WP/THITwnVthBcMU1mVwYADKJ85TYmS+9WBDqhjUC8vWV2sTaavnRNBAIxMubOM
         CptBnsQ5wWy02h2dD0oXZahMaDT52cMVCeV+5FPdgHe+Yq1veaGAwY6gxAwRLo0mznuE
         GMBskDHO7EF4bRgUM35iz+iwxVkZNWgXxkhvTNKWqFo18SrNklOdyAGlRb+NnfIy26ec
         NVUmbaKI/lVThmMm6tK5PHcwA6kFTxjIogxMvH5eDBxMO5hlLM2h6DimThw27IZXB0DW
         0iHqz0LFk/5NEALORhm6pse8ok/BAHCv9lrCuXDSZ8yfWheEfDQUSvNmMcwosoVZuKx1
         R5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=rm1M55oGiJwJFxL6wsCFOSYqIiIjt00FZUmE5VHkFA0=;
        b=tfP+25CRFdFW3YJTa6p914ZTfVM5LkbmNLsd+/2JVvbrICKrn/oF4+YZR+D670DITv
         4yea5l4KlqvkTHlRQRwyrW603O9CjRZnjbtLc1Q/pomnxfxn8hIHjKAEOuacxx2JipRT
         X+u57PDa64BpUCjbMMcVoDVE+qkC38AXmBguA0nKTi/nLHUiCFO+O4UAqq7hKOhJWEMi
         qemFmRI8KKnmrfageMiYUvbJensF+5vOLkGcep0XW33pOW/sYkecYvjVIRmpmEThBr1b
         DgK79tO0uDy9OPLyEL2c3n3GW/nudA56HhcknZ6kva5gdcch2Ro0rI5jQe0UkgVJuo+G
         2N8g==
X-Gm-Message-State: APjAAAXy6vHLSv19ejoJSfnVhOGbepGMVhrEKhzN7WTij2VROU+lWQe3
        UiOQKnaGbPdLbTJa6gLUcUshrHw8edvqu9ZCWoSIOg==
X-Google-Smtp-Source: APXvYqzqbRY8fOYpCcZ7XK7PN60hrM11ulPdQ4b46CsvjguzOn5IDViOD3h4ocQK9ZmUNDe1c1elvwmsTyX4KVB8Qzw=
X-Received: by 2002:a05:6102:1c3:: with SMTP id s3mr19147253vsq.95.1557305954799;
 Wed, 08 May 2019 01:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190508074717.12731-1-wqu@suse.com>
In-Reply-To: <20190508074717.12731-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 8 May 2019 09:59:03 +0100
Message-ID: <CAL3q7H6LMe_r6+BHmbbZYo5vre+F_+UhSwWQmgkQWDpaiGTcuA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Flush before reflinking any extent to prevent
 NOCOW write falling back to CoW without data reservation
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 8, 2019 at 9:24 AM Qu Wenruo <wqu@suse.com> wrote:
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
> This is caused by two reasons:
> - Btrfs' back reference only has extent level granularity
>   So write into shared extent must be CoWed even only part of the extent
>   is shared.
>
> - Btrfs doesn't reserve data space for NOCOW buffered write if low on
>   data space

Confusing sentence. That's not the cause, if there's no available data
space and the extent is not shared we fall into NOCOW, that's fine.
The problem is caused by the first point, that part of the extent gets
shared and we have no way to know that when starting writeback. That
sentence gives the idea that NOCOW path is wrong because it doesn't
reserve space.

>
> So for above script we have:
> - fallocate
>   Create a preallocated extent where we can do NOCOW write.
>
> - padding buffered write to use up all data space

Fill all the remaining data and unallocated space.

>
> - buffered write into preallocated space
>   As we have no data space remaining, we have to do NOCOW check and
>   reserve no data space.

As we have not enough space available for data and the extent is not
shared (yet) we fall into NOCOW mode.

>
> - reflink
>   Now part of the large preallocated extent is shared, later write
>   into that extent must be CoWed.
>
> - writeback kicks in for fsync

fsync triggers writeback

>   buffered write into that preallocated space must be CoWed.

But now the extent is shared and therefore we must fallback into COW
mode, which fails with ENOSPC since there's not enough space to
allocate data extents.

>   However we have no data space left at all, we fail
>   btrfs_run_delalloc_range() with ENOSPC, causing fsync failure.
>
> [WORKAROUND]
> The workaround is to ensure any buffered write in the related extents
> (not just the reflink source range) get flushed before reflink/dedupe,
> so NOCOW write could reach disk as NOCOW before we increase the reference=
.

... so that NOCOW writes succeed that happened before reflinking succeed.

>
> The workaround is expensive, we could do it better by only flushing
> NOCOW range, but that needs extra accounting for NOCOW range.
> For now, fix the possible data loss first.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> changelog:
> RFC->v1:
> - Use better words for commit message and comment.
> - Move the whole inode flushing to btrfs_remap_file_range_prep().
>   This also covers dedupe.
> - Update the reproducer to fail explicitly.
> - Remove false statement on transaction abort.
> ---
>  fs/btrfs/ioctl.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 6dafa857bbb9..87a0ec0591cd 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4001,8 +4001,21 @@ static int btrfs_remap_file_range_prep(struct file=
 *file_in, loff_t pos_in,
>         if (!same_inode)
>                 inode_dio_wait(inode_out);
>
> -       ret =3D btrfs_wait_ordered_range(inode_in, ALIGN_DOWN(pos_in, bs)=
,
> -                                      wb_len);
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

You are doing more then flushing. You are flushing and waiting for
writeback and ordered extent completion.

Thanks.

> +        */
> +       ret =3D btrfs_wait_ordered_range(inode_in, 0, (u64)-1);
>         if (ret < 0)
>                 return ret;
>         ret =3D btrfs_wait_ordered_range(inode_out, ALIGN_DOWN(pos_out, b=
s),
> --
> 2.21.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
