Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFE244E4DA
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 11:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhKLKym (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Nov 2021 05:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhKLKyl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Nov 2021 05:54:41 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E8DC061766;
        Fri, 12 Nov 2021 02:51:51 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id t11so8025757qtw.3;
        Fri, 12 Nov 2021 02:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=r6rJBHe71XE5w7imLvdsd4xv4QBDyfHXq/pw8mdGVRE=;
        b=AxwsfTckzTAjgaLbFKP1Qzd3+Wdp+xEknyBI3JuFSMSVNWmWkuUDyvRUE4NYcURv7B
         FH8LvCJeFZtqTXA8QEbdqe6Ag9x8pxIGID64/7QD0KnuwdH7Rxs/+ZcVg8enjcNabzuP
         K6gtltFmikc4fvXMt3/3Z2V2WUIF8+KbkQ4MFFFsADZSE28ARxtT+AQbLpz6AWTiYG0N
         7HvdZ7Q0H0rHvG/BsbBX6b8QndJzkLXndy8a7432EhZkDYnHv0i2OYWMG7N/OTzIijnW
         0z0jVSRssdjLyfhosdAWgPoOaSG65eVf5L47TniklCajQy/gV7SOXIgto5wJHC1x6x+L
         izxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=r6rJBHe71XE5w7imLvdsd4xv4QBDyfHXq/pw8mdGVRE=;
        b=QqnL6YGG2pJocq2wHYWx3wxqOmNK6hDnxxuCbMXpttSNcRuRUYqAmD3Xo81ZkprXtl
         9n2f96uDyhw1QwxTV/jIJGw08tqc7f/H8pfJvJslBupbNznN9hEEHJsKhvrrBjOwjaNg
         O/B5/rWgjIFxleZF+FhwyQzreiNGLlWUEYEvqfPgvKICxsu0d9R6/B35wgxkxRQ5V6IK
         FED5sxVa701PT/bJXY4Wx4OVu3HuS0LQV4zYd/+v21pPFO9lCmVhZ9FUK7ZIYm3IXEKT
         ZuTZ+LQl/+bk4ObB5zDBEZr3uFuUdsIdggpWAKoPIQtgFK1+N9sJYwGjQnVBMAYpr8Uh
         ov6A==
X-Gm-Message-State: AOAM530rIbAmtvyYFbuGGQ8MOPETGX1DHpJPv8nYWyp4qszvvK6lSjE/
        nrT5iTJKFoDuebs/yxemfycfS3DnDJsqIxVaaiVoK1MC
X-Google-Smtp-Source: ABdhPJy4dLlSH6+c1+/xWZxDI5APCD1HrJXSeWk1/BJItFSWUnn2JaY/LJmZDVHvTC5gySU2FWQGcyJcT7uTcBhHv94=
X-Received: by 2002:a05:622a:3d3:: with SMTP id k19mr15195635qtx.140.1636714310422;
 Fri, 12 Nov 2021 02:51:50 -0800 (PST)
MIME-Version: 1.0
References: <20211112023535.21370-1-wqu@suse.com>
In-Reply-To: <20211112023535.21370-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 12 Nov 2021 10:51:14 +0000
Message-ID: <CAL3q7H4s=KqcwstvzV5GXCbfcyXASvtY5FbNYyEFoxW=ZtfeEA@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/049: add regression test for
 compress-force=lzo mount option
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 12, 2021 at 2:36 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Since kernel commit d4088803f511 ("btrfs: subpage: make lzo_compress_page=
s()
> compatible"), lzo compression no longer respects the max compressed page
> limit, and can cause kernel crash.
>
> The fix is titled "btrfs: fix a out-of-boundary access for
> copy_compressed_data_to_page()".
>
> This patch will add such regression test for compress-force=3Dlzo mount
> option against incompressible data.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/049     | 41 +++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/049.out |  1 +
>  2 files changed, 42 insertions(+)
>  create mode 100755 tests/btrfs/049
>
> diff --git a/tests/btrfs/049 b/tests/btrfs/049
> new file mode 100755
> index 00000000..5a73f738
> --- /dev/null
> +++ b/tests/btrfs/049
> @@ -0,0 +1,41 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 049
> +#
> +# Test if btrfs will crash when compress-force=3Dlzo hits incompressible=
 data
> +#
> +. ./common/preamble
> +_begin_fstest auto quick compress dangerous
> +
> +# Override the default cleanup function.
> +# _cleanup()
> +# {
> +#      cd /
> +#      rm -r -f $tmp.*
> +# }
> +
> +# Import common functions.
> +# . ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount -o compress-force=3Dlzo
> +
> +$XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 4k" $SCRATCH_MNT/file > /de=
v/null

While at it, instead of just having the minimum to trigger that
specific bug, it would also be good to:

1) Try with zlib and zstd, instead of only lzo. This way it will help
more easily catch any future regression with those algorithms;

2) Instead of redirecting to /dev/null and ignoring if we are actually
writing what we are supposed to do, can we verify that we write all
the bytes - i.e. that there's no short write?

3) After unmount, we could also mount the fs again and check if we are
able to read exactly what we tried to write - that the write was
persisted and we're not reading from the page cache.

Thanks.


> +
> +# With kernel commit d4088803f511 ("btrfs: subpage: make lzo_compress_pa=
ges()
> +# compatible"), the kernel would crash when writing back above data.
> +_scratch_unmount
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/049.out b/tests/btrfs/049.out
> index cb0061b3..c69568ad 100644
> --- a/tests/btrfs/049.out
> +++ b/tests/btrfs/049.out
> @@ -1 +1,2 @@
>  QA output created by 049
> +Silence is golden
> --
> 2.33.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
