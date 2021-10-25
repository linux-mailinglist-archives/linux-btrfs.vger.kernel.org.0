Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A78439307
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 11:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhJYJwd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 05:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhJYJwa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 05:52:30 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC75C061745
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 02:50:08 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id n2so9749241qta.2
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 02:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=AFLakMkJoDqZ7tI1BfF5FNXzDxAqZSynfTKiqKnzLGA=;
        b=KtkZTK9XESKIRZgmIAREyQbqd5xFvnhscf/9y2GHx3pM4UL04nqWDoPLHicp0Ec2Ds
         YNA89CjVGRNhoMflNLYTYjNp0lNMmAbxiQv0uGR4uep1n0wyEPw1KxEbubpqAbAjpVMt
         /irGiom/0/EpsL6/SpaGIoDfk8PkvCb0PCA0kXTeutK8jyrHGVUtpyF6PPu8EzLeixAv
         2voPGkLSd6sRHhOTD9cIeLdeVju9fLvezaGLKE96wIhWyAn/yt+mLGEYWSXWGlko+MSv
         txt/94TwMC4OnQL2+2qtWSYgbM5z0V2TERW3lxqFGkfdUUKTF/SU6sPsRAgn63DZfgh8
         6pQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=AFLakMkJoDqZ7tI1BfF5FNXzDxAqZSynfTKiqKnzLGA=;
        b=OUfT7PycZ/0SnSmxsk2XMQMe4F/CoiMKwPP2SH4fnTvx5MOdhIZ4O9w5tgulE4Otf5
         E5jRP3x0qshTM7umvfeaIbHkW5mbZ6X8V8A5tImMkM38wfqN+AxJ3eLNWnmrLd7Kjlqz
         6vn4iiu1LvEvUExgFmHIHZiDvQE+L6AYM5L7B6+IMC3u0mrmAfn8a5RAfpbQMry0mFpU
         oMubW/GCgTxCVxBcdf1eIAVns4XirBEoWdRdrjiNiBvgqW/q9ngCVa47bF1O6ENInKat
         i+/NL4hMM6L/6IGpSDSowyh4YJyVYdyXf46X4SRQXsNmWj416G4+ZxK/A6pMdIEio4L3
         GCng==
X-Gm-Message-State: AOAM531VSi/q3x1pstrRr036IKeYkk7HuyJi6moUQeSsLwh0fxFfaZa6
        Q+b13IvCTTz2szKlcPkih6kHztCscUHRfvq9YCiHhe1s
X-Google-Smtp-Source: ABdhPJzQSKckgcPybppzHLwASnAs+Fs5awVD4aaOe8T5Y0bmJNzbww01bxg3Q67j/BQNCfVZH26FcfgWYGm+9FXnLZg=
X-Received: by 2002:ac8:5895:: with SMTP id t21mr16469450qta.329.1635155408144;
 Mon, 25 Oct 2021 02:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211024033237.23662-1-wangyugui@e16-tech.com>
In-Reply-To: <20211024033237.23662-1-wangyugui@e16-tech.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 25 Oct 2021 10:49:32 +0100
Message-ID: <CAL3q7H6kNG+x=khgKvphNM5xMX4sC9re2YM3ZNPx78FDGyhAAQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix a check-integrity warning on write caching
 disabled disk
To:     wangyugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 24, 2021 at 4:40 AM wangyugui <wangyugui@e16-tech.com> wrote:
>
> xfstest/btrfs/220 tigger a check-integrity warning
>   btrfs: attempt to write superblock which references block which is not =
flushed
>     out of disk's write cache (block flush_gen=3D1, dev->flush_gen=3D0)!
>   WARNING: at fs/btrfs/check-integrity.c:2196
>     btrfsic_process_written_superblock+0x22a/0x2a0 [btrfs]

For stack traces it's best to paste the full version, not just the
first line or two, and
for readability you can skip the reformatting to make it fit within 75
character wide columns.
This is on the borderline of subjectivity / personal preference, so
take it only as a note for
future submissions.

Also a blank line before and after the stack trace helps with readability.

> when
> 1) CONFIG_BTRFS_FS_CHECK_INTEGRITY=3Dy
> 2) on a disk with WCE=3D0
>
> When a disk has write caching disabled, we skip submission of a bio
> with flush and sync requests before writing the superblock, since
> it's not needed. However when the integrity checker is enabled,
> this results in reports that there are metadata blocks referred
> by a superblock that were not properly flushed. So don't skip the
> bio submission only when the integrity checker is enabled
> for the sake of simplicity, since this is a debug tool and
> not meant for use in non-debug builds.
>
> Signed-off-by: wangyugui <wangyugui@e16-tech.com>

Looks good, thanks for doing it.

Reviewed-by: Filipe Manana <fdmanana@suse.com>



> ---
> Changes since v1:
> - update the changlog/code comment. (Filipe Manana)
> - var(struct request_queue *q) is only needed when
>    !CONFIG_BTRFS_FS_CHECK_INTEGRITY
> ---
>  fs/btrfs/disk-io.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 355ea88d5c5f..4ef06d0555b0 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3968,11 +3968,23 @@ static void btrfs_end_empty_barrier(struct bio *b=
io)
>   */
>  static void write_dev_flush(struct btrfs_device *device)
>  {
> -       struct request_queue *q =3D bdev_get_queue(device->bdev);
>         struct bio *bio =3D device->flush_bio;
>
> +       #ifndef CONFIG_BTRFS_FS_CHECK_INTEGRITY
> +       /*
> +       * When a disk has write caching disabled, we skip submission of a=
 bio
> +       * with flush and sync requests before writing the superblock, sin=
ce
> +       * it's not needed. However when the integrity checker is enabled,
> +       * this results in reports that there are metadata blocks referred
> +       * by a superblock that were not properly flushed. So don't skip t=
he
> +       * bio submission only when the integrity checker is enabled
> +       * for the sake of simplicity, since this is a debug tool and
> +       * not meant for use in non-debug builds.
> +       */
> +       struct request_queue *q =3D bdev_get_queue(device->bdev);
>         if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags))
>                 return;
> +       #endif
>
>         bio_reset(bio);
>         bio->bi_end_io =3D btrfs_end_empty_barrier;
> --
> 2.32.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
