Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE863233737
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jul 2020 18:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgG3Qz4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 12:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG3Qz4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 12:55:56 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E161AC061574;
        Thu, 30 Jul 2020 09:55:55 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id w22so9760179vsi.3;
        Thu, 30 Jul 2020 09:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=1Sfqt9Ft1QJUHQcXEyVs+bvdtsUfMkZOoIJ9YIr0/rQ=;
        b=Hgu2ke/cmyxYtzzcpIQuQX7lHgA6Ih6sd9Ca1QGIo6mX4esc0cTtgKXoS8EQtsMGSD
         ZoXYqoLk/sk6bkFtwRuBgrSkXOkVhOR53TkTPV15rqFC3uUllhqLKAPRKSFw26541UXA
         YYK/s4K4uwM/Ys8bjQFCLrA5GjFkJ+keVyItm8N+EtbEirwgOdO4COzZhro+vm/saIYy
         62Z1NkhhwqdhOU1fJnEBT/jcN+WePjadb8Q8fLreb/P2B9PrIxGBF2dcQqXxOukaOJdJ
         nBtDEp91EcR3mQ6sfzvk8ET7QNMRxMK4ujovcLKlu6fpelAkhq15cZzqnlkzvunBqPiR
         xqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=1Sfqt9Ft1QJUHQcXEyVs+bvdtsUfMkZOoIJ9YIr0/rQ=;
        b=ZPppzriu3xSQ1V90LcylvB5mjmwprPGJoI5ftqGXhQR8dsoH/cM3OxCFyF7H95xNjP
         LrrJC5Zot42mRzxcJoCXk9BpCnClccF8EH03mM9z2BuHPgOxE+bTTi3VqoZ8Pe08Q+bN
         UuRryIVvjprR8QmGEHbKXh2MLqWBI10lxCG+7HfjPKYJOZ+49vN2QDTt5wQL5L4Dff6/
         ajgPd6m2maO9EsqcEp6S7lWkiZyOdhc+xEYf/NMII0reyvei0JKOVT80OMye+aBWKGZO
         jLEr0/S5MbGLKw9RsFmUsGgh+0AgfGAtpOxogoPEsFrCYUdHZyadE5Yadsvb5WOYYuia
         nBlg==
X-Gm-Message-State: AOAM532jtxuZoRdnt8twJJyo5tgF1OrAhzaERewcoXyZpXkHHRHSedO6
        FX28KCv55h4p9rSU17X/ic/2KWUW5FS/jOfDaRI=
X-Google-Smtp-Source: ABdhPJysCm8sQslgnoSOg8dh++WntzIJN+nMO70A+gNJE9Q8yR3jT30oGf2oiVwl+sTdwWGUoeBRhHu02I5RPxQA1cQ=
X-Received: by 2002:a67:c997:: with SMTP id y23mr233861vsk.90.1596128155067;
 Thu, 30 Jul 2020 09:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200730121735.55389-1-wqu@suse.com>
In-Reply-To: <20200730121735.55389-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 30 Jul 2020 17:55:44 +0100
Message-ID: <CAL3q7H4ScXpmzarHgjDHkPFn-WB=PWvHAyH=aWd4FxDmZvsWkA@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/214: Add test to check if shrink works
 well with fstrim
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 30, 2020 at 1:18 PM Qu Wenruo <wqu@suse.com> wrote:
>
> There is a bug in trim code which leads to fstrim accessing beyond
> device boundary.
>
> The test case will check if fstrim, then shrink, then fstrim, all of
> them works without problem.
>
> The fix is titled "btrfs: trim: fix underflow in trim length to prevent
> access beyond device boundary".
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  tests/btrfs/214     | 62 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/214.out |  2 ++
>  tests/btrfs/group   |  1 +
>  3 files changed, 65 insertions(+)
>  create mode 100755 tests/btrfs/214
>  create mode 100644 tests/btrfs/214.out
>
> diff --git a/tests/btrfs/214 b/tests/btrfs/214
> new file mode 100755
> index 00000000..6cd9f444
> --- /dev/null
> +++ b/tests/btrfs/214
> @@ -0,0 +1,62 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 214
> +#
> +# Test if the following workload would cause problem:
> +# - fstrim
> +# - shrink device
> +# - fstrim
> +#
> +seq=3D`basename $0`
> +seqres=3D$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`
> +tmp=3D/tmp/$$
> +status=3D1       # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +       cd /
> +       rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch_size $((5 * 1024 * 1024)) #kB
> +_require_fstrim
> +
> +# Create a 5G fs
> +_scratch_mkfs_sized $((5 * 1024 * 1024 * 1024)) >> $seqres.full
> +_scratch_mount
> +
> +# Fstrim to populate the device->alloc_status CHUNK_TRIMMED bits
> +$FSTRIM_PROG -v $SCRATCH_MNT >> $seqres.full 2>&1 || \
> +       _notrun "FSTRIM not supported"
> +
> +
> +# Shrink the fs to 4G, so the existing CHUNK_TRIMMED bits are beyond
> +# device boundary
> +$BTRFS_UTIL_PROG filesystem resize 1:-1G "$SCRATCH_MNT" >> $seqres.full
> +
> +# Do fstrim again to trigger the bug
> +$FSTRIM_PROG -v $SCRATCH_MNT >> $seqres.full
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/214.out b/tests/btrfs/214.out
> new file mode 100644
> index 00000000..dafb6086
> --- /dev/null
> +++ b/tests/btrfs/214.out
> @@ -0,0 +1,2 @@
> +QA output created by 214
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 59e8ecce..e306fea5 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -216,3 +216,4 @@
>  211 auto quick log prealloc
>  212 auto balance dangerous
>  213 auto quick balance dangerous
> +214 auto quick trim dangerous
> --
> 2.27.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
