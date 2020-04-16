Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723A41ABFC7
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 13:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506526AbgDPLjh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 07:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505933AbgDPK7s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 06:59:48 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AA6C061BD3;
        Thu, 16 Apr 2020 03:52:15 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id z1so2085672vsn.11;
        Thu, 16 Apr 2020 03:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=R999l9LMEfWOXIrr5j0qOkSLT5yFE9m+5jm7Ilic1U8=;
        b=lWiY20D/1VSh8sWY3yKQDGAvErw9nBKKouE2c4N36u1RnVKhrK++MEhiSOn/fmX0En
         xhMiKT4ix5gqFgSkk8MI1m54sU6waHD/WICK5oaSNH0m1ToUqB8W70PRByr7QBjTmQoT
         clPpIFwBPIbtcbrGngUyMYaJLoJZWhN0JKS+xitf2ohq5tfiLbzlpxmnm8srwb5x27Z6
         e16LxpRo4Udx6HiT0EOKifWKwF921wHxaw077+Vu/5WX7a05yVWscC0soVIgGwYpRIBl
         gk8ofZOK6jFS+vg0aQt3pTn+5kpzV94BaUDXXLdcpiJd3NksGvsesZqpOP29w/HFv/zN
         P4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=R999l9LMEfWOXIrr5j0qOkSLT5yFE9m+5jm7Ilic1U8=;
        b=MhJCZ93ZYkYfNzbfsFk6oY3/8yKy/gGOnZwRwm/qUcc85mIOFOszYZ1+EpdDW9EljA
         iAqUcZk4iC6EyzCN9e0ViGs7KClB2oIqMZ6s8pQk1Kb2BygYsP53hOelH+r3B9ls3IP8
         bLynnPWsqP3MIesQFuaRLnhVrkpCDodkjNj3S97jBbID61EJU2HWsRSfZvWAR6+N45Hb
         INQXaHH/kZBbxqQAk+69b3Plk0LLTqC0NPqh0pYO4k+/++4ItsRp0x8A9PexTr2+pMCP
         eZxe+y5wmAR6tpQd/1a6JMvo7ucONQ85ITKTpfPOt25OfdZMyNukTC29lDTCO6jXumpB
         kFYA==
X-Gm-Message-State: AGi0PubZp/I5hHSGLeodGj0D+e9L/qWsT/0HyI9XUOQ0IR4XzzxCS4cB
        cqrTxFfiUuFz4P6Gt/sdBK2CSWsAoZeBU9rhYrRuUQ==
X-Google-Smtp-Source: APiQypLm5EuLKI6Xqign9n0mJpOh8o3VNKYbMWKN94pIx32VJuUzFu2I7tNDJAuJhJ5vk9PzPSSo2qBJjXSEFczEUWM=
X-Received: by 2002:a67:f4ce:: with SMTP id s14mr7453985vsn.99.1587034334665;
 Thu, 16 Apr 2020 03:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200415064916.49958-1-wqu@suse.com>
In-Reply-To: <20200415064916.49958-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 16 Apr 2020 11:52:03 +0100
Message-ID: <CAL3q7H5Z7t20jpuz40qDTjFEFmmR0Oa-92B27FPQ1KfZJoKo=A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Test snapshot creation with qgroup inherit would
 mark qgroup inconsistent
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 15, 2020 at 11:12 PM Qu Wenruo <wqu@suse.com> wrote:
>
> Test that a new snapshot created with qgroup inherit passed should mark
> qgroup numbers inconsistent.
>
> Such inconsistent flag is required to show that we need a qgroup rescan
> to make qgroup numbers correct again.
>
> This is unavoidable since snapshot creation with qgroup inherit acts as
> snapshot creation + qgroup relationship assign.
> See btrfs(5) for why such operation needs qgroup rescan.
>
> This test failed on current kernel, the fix is submitted to the btrfs
> mail list titled:
>   "btrfs: qgroup: Mark qgroup inconsistent if we're inherting snapshot to=
 a new qgroup"
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  tests/btrfs/210     | 62 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/210.out |  2 ++
>  tests/btrfs/group   |  1 +
>  3 files changed, 65 insertions(+)
>  create mode 100755 tests/btrfs/210
>  create mode 100644 tests/btrfs/210.out
>
> diff --git a/tests/btrfs/210 b/tests/btrfs/210
> new file mode 100755
> index 00000000..daa76a87
> --- /dev/null
> +++ b/tests/btrfs/210
> @@ -0,0 +1,62 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 210
> +#
> +# Test that a new snapshot created with qgroup inherit passed should mar=
k
> +# qgroup numbers inconsistent.
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
> +_require_scratch
> +
> +_scratch_mkfs >/dev/null
> +_scratch_mount
> +
> +$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/src" > /dev/null
> +_pwrite_byte 0xcd 0 16M "$SCRATCH_MNT/src/file" > /dev/null
> +
> +# Sync the fs to ensure data written to disk so that they can be account=
ed
> +# by qgroup
> +sync
> +$BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT"
> +$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT"
> +$BTRFS_UTIL_PROG qgroup create 1/0 "$SCRATCH_MNT"
> +
> +# Create a snapshot with qgroup inherit
> +$BTRFS_UTIL_PROG subvolume snapshot -i 1/0 "$SCRATCH_MNT/src" \
> +       "$SCRATCH_MNT/snapshot" > /dev/null
> +
> +echo "Silence is golden"
> +# If qgroup is not marked inconsistent automatically, btrfs check would
> +# report error.
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/210.out b/tests/btrfs/210.out
> new file mode 100644
> index 00000000..0d9f3fa0
> --- /dev/null
> +++ b/tests/btrfs/210.out
> @@ -0,0 +1,2 @@
> +QA output created by 210
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 657ec548..e7255c46 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -212,3 +212,4 @@
>  207 auto rw raid
>  208 auto quick subvol
>  209 auto quick log
> +210 auto quick qgroup snapshot
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
