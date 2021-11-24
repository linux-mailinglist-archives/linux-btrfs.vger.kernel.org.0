Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335F845B905
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 12:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241059AbhKXL0H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 06:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240520AbhKXL0H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 06:26:07 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA26CC061574;
        Wed, 24 Nov 2021 03:22:57 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id de30so2462407qkb.0;
        Wed, 24 Nov 2021 03:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=x2Z91EdiXWKjA4M1Ep1WXj8AaFy5wYqD+F/gIZ9cazw=;
        b=SvP/sCnWKCqrgB3LtkKrWVFVTwdHLhN3kAEs4MtUXSQCiDou3Bif9TUTRSfjPdJb/h
         I0m2prI35iDYDbOl+XfzOIIVzTwbjVgciJcM0g146bDyoqC7ZpqbNyZnnM0imSt4p+pn
         o6hwHbxt0mxAaHCP5U4msTg4p7mMBUifie457TKNOCKQJ2+r+50apwMBbHHWl17P/92D
         k3ZV0Atg2WKHV+AXMoDRMA5HHgc5tqDvyaCplFPxVOyFy+XKy4W7DeyWhbIrQcWhJsWg
         EWKy/QP7xOQO+UtLuVF4c0hPbS8dC1megmNb0oqD16cn+6BcZQZXASLM9SaXBKEugt1F
         IsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=x2Z91EdiXWKjA4M1Ep1WXj8AaFy5wYqD+F/gIZ9cazw=;
        b=lrRvv5cdKCcIM55WtyqaBdHhXK/r+SJ3tL8ONUKYmNjamzhC8ouOGPt1sCQ8PzZa/s
         uWJxh02E1T+5zQPYVyHRRAyopjxTcC2i444DTWwcw6ydoTP49rzTwChrb9KaRpfDhsYU
         xY/DJA4RGuNcObf7S2NOtd+RvjH4z6iqJwlEHgv8DAeT/O6NE+ez0YyNF8u10/JrZSoa
         ZlJULLPj7c82khk79eyZ7XwUdfvi8krU9f3FRN/gJk6cEzRUoa73nagAfzZFUaybAkho
         3EdPTI8tr87IbxdyKqGGFPdb9CL1hHayx69XGGeHUEleokexiCUI4C3Iq2yyxEeDDfSh
         u/0w==
X-Gm-Message-State: AOAM531xQ377cVN3OB4wtSW35L+6B7I6oDaT9uoeqJWOvZuYVFuBr4vM
        t0xfT0Z5FEy6KCfCPjFUBkazXxDPnvTit60bYJesyaispufkvg==
X-Google-Smtp-Source: ABdhPJxbPNl/oZoV728cGCA8bFxRVuxTfShZS7SkIDpjI1Spi5/nIm9ifEouJ7LsILBmacPuLzw/mgAwOFNaqqPUawk=
X-Received: by 2002:a05:620a:126e:: with SMTP id b14mr5034632qkl.415.1637752976989;
 Wed, 24 Nov 2021 03:22:56 -0800 (PST)
MIME-Version: 1.0
References: <20211124065219.33409-1-wqu@suse.com>
In-Reply-To: <20211124065219.33409-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 24 Nov 2021 11:22:21 +0000
Message-ID: <CAL3q7H7FB96c753TniOvZwqqOvvT0MFiyjg0=Ev9wHThD4z-Kw@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs/049: add regression test for
 compress-force mount options
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 24, 2021 at 9:24 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Since kernel commit d4088803f511 ("btrfs: subpage: make lzo_compress_page=
s()
> compatible"), lzo compression no longer respects the max compressed page
> limit, and can cause kernel crash.
>
> The upstream fix is 6f019c0e0193 ("btrfs: fix a out-of-bound access in
> copy_compressed_data_to_page()").
>
> This patch will add such regression test for all possible compress-force
> mount options, including lzo, zstd and zlib.
>
> And since we're here, also make sure the content of the file matches
> after a mount cycle.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Also test zlib and zstd
> - Add file content verification check
> ---
>  tests/btrfs/049     | 56 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/049.out |  6 +++++
>  2 files changed, 62 insertions(+)
>  create mode 100755 tests/btrfs/049
>
> diff --git a/tests/btrfs/049 b/tests/btrfs/049
> new file mode 100755
> index 00000000..264e576f
> --- /dev/null
> +++ b/tests/btrfs/049
> @@ -0,0 +1,56 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 049
> +#
> +# Test if btrfs will crash when using compress-force mount option agains=
t
> +# incompressible data
> +#
> +. ./common/preamble
> +_begin_fstest auto quick compress dangerous
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +       cd /
> +       rm -r -f $tmp.*
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch
> +
> +pagesize=3D$(get_page_size)
> +workload()
> +{
> +       local compression
> +       compression=3D$1

Could be shorter by doing it in one step:

local compression=3D$1

> +
> +       echo "=3D=3D=3D Testing compress-force=3D$compression =3D=3D=3D"
> +       _scratch_mkfs -s "$pagesize">> $seqres.full
> +       _scratch_mount -o compress-force=3D"$compression"
> +       $XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 $pagesize" \
> +               "$SCRATCH_MNT/file" > /dev/null
> +       md5sum "$SCRATCH_MNT/file" > "$tmp.$compression"

This doesn't really check if everything we asked to write was actually writ=
ten.
pwrite(2), write(2), etc, return the number of bytes written, which
can be less than what we asked for.

And using the checksum verification in that way, we are only checking
that what we had before unmounting is the same after mounting again.
I.e. we are not checking that what was actually written is what we
have asked for.

We could do something like:

data=3D$(dd count=3D4096 bs=3D1 if=3D/dev/urandom)
echo -n "$data" > file

_scratch_cycle_mount

check that the the md5sum of file is the same as:  echo -n "$data" | md5sum

As it is, the test is enough to trigger the original bug, but having
such additional checks is more valuable IMO for the long run, and can
help prevent other types of regressions too.

Thanks Qu.


> +
> +       # When unpatched, compress-force=3Dlzo would crash at data writeb=
ack
> +       _scratch_cycle_mount
> +
> +       # Make sure the content matches
> +       md5sum -c "$tmp.$compression" | _filter_scratch
> +       _scratch_unmount
> +}
> +
> +workload lzo
> +workload zstd
> +workload zlib
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/049.out b/tests/btrfs/049.out
> index cb0061b3..258f3c09 100644
> --- a/tests/btrfs/049.out
> +++ b/tests/btrfs/049.out
> @@ -1 +1,7 @@
>  QA output created by 049
> +=3D=3D=3D Testing compress-force=3Dlzo =3D=3D=3D
> +SCRATCH_MNT/file: OK
> +=3D=3D=3D Testing compress-force=3Dzstd =3D=3D=3D
> +SCRATCH_MNT/file: OK
> +=3D=3D=3D Testing compress-force=3Dzlib =3D=3D=3D
> +SCRATCH_MNT/file: OK
> --
> 2.34.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
