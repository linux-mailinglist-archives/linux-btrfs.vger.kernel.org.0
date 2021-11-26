Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C783845EC67
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Nov 2021 12:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbhKZLXW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Nov 2021 06:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhKZLVV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Nov 2021 06:21:21 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C330C061A1C;
        Fri, 26 Nov 2021 02:36:18 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id n15so8629218qta.0;
        Fri, 26 Nov 2021 02:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=qOmBd5sAFMW/ESv4nE3mMjgeYcilCBjK9OEfFwHt8kk=;
        b=iqtSyHv9u+gm80IK3bhNTq/4s4Qd0XGnagZdv0QZk1VSvogSRQyTDKTEpRG2UlbTgb
         0dG4NHZbaGfquUnyogOpw3NL7zbeKyIEiwWvvk8hph7bP2CWBsshG8Rw41VsMBEleZWC
         lw5TeTn42BL9o++2syBuTklojO3litLvGxdEi/fdYpxlXtJ5OgdyTtj2Z2+IBXdWPO26
         VmofZeJnFpsgw9Hl7YoG+1FjSOB3FbvWLYKprRgBHTZsy+r2o+YaToyEhsxj0bZprQIb
         znRbqMUnaQ6NgJWQvE/Ov4YNcuWAq9uem1tCTtlCrw8tEQFGgosvwNRelWj0fIqTbFOJ
         WC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=qOmBd5sAFMW/ESv4nE3mMjgeYcilCBjK9OEfFwHt8kk=;
        b=OgOlY0tjKUheRNSF10xYvgbBS+x58Ya7oqhzPF6jYOheJOGlpkmfC7W3Q6T7mxLfqE
         FiC3wrLgZSlVyop7XSQGisogTLCF9ZDBWhqOZJpTJCvetn+0hEQXoaI1MaXJdAIWVRlo
         E1zkid2EbkcyUDxBphU7AZGGmponxaSWYPwDhHKSGdzWzFea1bkzJxIHleQnops/We1x
         p+o4gsd5BizeTUxJkrXGcUQEP1EMEphLIZ+85MaDC3bQ4U8qdci2RtdsopLYwTnhPgLk
         3b23l2I5rVuKeIzONfKnojIUM+Glbxbo1Vp/880hVch6EkPmmhQMETvhXkY1+R6z7fBs
         Za0Q==
X-Gm-Message-State: AOAM533hKfF1MJamCXZiejW9mmWThlO8fyYhuuY1yiYkX8/ILfvuI5Gx
        j8Oqd4TmmCdO3+ACZ94+ReUmUPi02QFdkYAHkKA=
X-Google-Smtp-Source: ABdhPJziCEHyqVwtF3ynWyhFAPnVMk5fHnZuKALJWa8d+LnpQpFO/aqBceS/q2rDTZ70hDYySj3TsAJFBnbXdjfk22g=
X-Received: by 2002:ac8:5796:: with SMTP id v22mr22031235qta.304.1637922977475;
 Fri, 26 Nov 2021 02:36:17 -0800 (PST)
MIME-Version: 1.0
References: <20211125060529.53289-1-wqu@suse.com>
In-Reply-To: <20211125060529.53289-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 26 Nov 2021 10:35:41 +0000
Message-ID: <CAL3q7H6__G3D9x0_5VPpoypAst-O=v_ZO_3yrB_T5UsNBCTegA@mail.gmail.com>
Subject: Re: [PATCH v3] fstests: btrfs/049: add regression test for
 compress-force mount options
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 26, 2021 at 10:26 AM Qu Wenruo <wqu@suse.com> wrote:
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
> v3:
> - Use $tmp.good as a known good file source
> - Also make sure we didn't get short read for the good copy
> ---
>  tests/btrfs/049     | 67 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/049.out |  6 ++++
>  2 files changed, 73 insertions(+)
>  create mode 100755 tests/btrfs/049
>
> diff --git a/tests/btrfs/049 b/tests/btrfs/049
> new file mode 100755
> index 00000000..c1f35dc9
> --- /dev/null
> +++ b/tests/btrfs/049
> @@ -0,0 +1,67 @@
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
> +
> +# Read the content from urandom to a known safe location
> +$XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 $pagesize" "$tmp.good" > /d=
ev/null
> +
> +# Make sure we didn't get short read

s/read/write/

> +if [ $(_get_filesize "$tmp.good") !=3D "$pagesize" ]; then
> +       _fail "Got a short read from /dev/urandom"
> +fi
> +
> +workload()
> +{
> +       local compression=3D$1
> +
> +       echo "=3D=3D=3D Testing compress-force=3D$compression =3D=3D=3D"
> +       _scratch_mkfs -s "$pagesize">> $seqres.full
> +       _scratch_mount -o compress-force=3D"$compression"
> +       cp "$tmp.good" "$SCRATCH_MNT/$compression"
> +
> +       # When unpatched, compress-force=3Dlzo would crash at data writeb=
ack
> +       _scratch_cycle_mount
> +
> +       # Make sure the content matches
> +       if [ "$(_md5_checksum $tmp.good)" !=3D \
> +            "$(_md5_checksum $SCRATCH_MNT/$compression)" ]; then
> +               _fail "Content of '$SCRATCH_MNT/file' mismatch with known=
 good copy"

We could just 'echo' instead of '_fail' and let the test continue with
the remaining compression algorithms.
That's usually the approach preferred for fstests, _fail is for cases
where the test can't proceed and must stop immediately.

Anyway, those are two minor things that maybe Eryu can fixup when he
picks the patch.
So I won't ask you to send yet another version.

Thanks!

Reviewed-by: Filipe Manana <fdmanana@suse.com>


> +       else
> +               echo "OK"
> +       fi
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
> index cb0061b3..41bffeaa 100644
> --- a/tests/btrfs/049.out
> +++ b/tests/btrfs/049.out
> @@ -1 +1,7 @@
>  QA output created by 049
> +=3D=3D=3D Testing compress-force=3Dlzo =3D=3D=3D
> +OK
> +=3D=3D=3D Testing compress-force=3Dzstd =3D=3D=3D
> +OK
> +=3D=3D=3D Testing compress-force=3Dzlib =3D=3D=3D
> +OK
> --
> 2.34.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
