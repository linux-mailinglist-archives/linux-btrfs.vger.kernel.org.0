Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE6E3BB992
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 10:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhGEIsf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jul 2021 04:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhGEIsf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jul 2021 04:48:35 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6830C061574;
        Mon,  5 Jul 2021 01:45:58 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id q190so16332267qkd.2;
        Mon, 05 Jul 2021 01:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=jRpeww35YI8f/dxn2qm2ATgBcOzNiQ9//xFsr8uz168=;
        b=KVyEY+JVCE38czyKYT0UHqwOmRYrDqscxszqrVRku43zGOU+QJSkcnjza/TpW5+ksZ
         +1aO2ihAFT4h9pY0WxFm/Yt6bVd3VlM9TPfA9f4doKzP9mucrbI+Padc3VCuf/u2MPDQ
         BbwCp8vw2geR9/5d5DP57yAawY7j3hhbtV2SG49Q+0cD1vNsvKWRzfBnT/sQ5VDYUn7t
         UJRmv1M9tT1q2c9mFQXNtQRHxMFHXZpC1JswUpj3c5ESeCMjvY+v47xJo/1yK3x7axPW
         oec4knTHEKKQEjF5U7ck9vlT9H6Iub+HIRVvrqI7laU9CHwkiPel8ekgAvfWKqyTqB/T
         /0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=jRpeww35YI8f/dxn2qm2ATgBcOzNiQ9//xFsr8uz168=;
        b=VJuQul2E9eHjgIcSpp5GypvWl1zmFC2H4ndmce11hPy+LbF9N+AKwwqGVopoghrHrV
         do5e41AXQT+92wAh8T22lHNMk6mMr3lp02TgNt+39XdoTNwz4bArE7BaH1H1ArUn9bjs
         prEvYKDOx6yQtUJQKCYPDrcw25bPxzv5d1R6UOEWFjJ/1IebUBVFexNtZX6vxT3Qw/VG
         NSq91Oz6D8VNV2u93h1M8kAFFkShZDdz+3aFuBz2teC2k2MlULE8a1onyqYzUWFTG5R8
         SCmQcpYCQffC3+kf93XpUc8skFURUGJO5IvaV5HmDxTrigWpYGL0zLDP6VZ33s/15uLO
         X1LQ==
X-Gm-Message-State: AOAM530l4zJMKhGfI2/kEJSJAjh7NY49Cfi1QBktCVuDkMA27vaiZnGR
        wXo/y8qIm6zLxxsTmpEAK6DSYHl9KXoe2ToPAE8=
X-Google-Smtp-Source: ABdhPJwh+AQ56zVTIUXpg7ysVr9dwCcDXaGH0zwgyfhkDg9A8mP0WZ591eo/LL5FG7fBmVFHz+Zpv67a3ph+QKx55sE=
X-Received: by 2002:ae9:ec11:: with SMTP id h17mr12928358qkg.438.1625474757981;
 Mon, 05 Jul 2021 01:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <a70c9f6b4e45d9bcdc5c2f19182f89ef8e22c074.1625237782.git.anand.jain@oracle.com>
In-Reply-To: <a70c9f6b4e45d9bcdc5c2f19182f89ef8e22c074.1625237782.git.anand.jain@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 5 Jul 2021 09:45:47 +0100
Message-ID: <CAL3q7H6YZa6JLFhHbJB_FScD2wdm3NWEEDsE9C3EwVmoKMMkJQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs/242: test case to fstrim on a degraded filesystem
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 4, 2021 at 12:24 PM Anand Jain <anand.jain@oracle.com> wrote:
>
> Create a degraded btrfs filesystem and run fstrim on it.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/242     | 49 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/242.out |  2 ++
>  2 files changed, 51 insertions(+)
>  create mode 100755 tests/btrfs/242
>  create mode 100644 tests/btrfs/242.out
>
> diff --git a/tests/btrfs/242 b/tests/btrfs/242
> new file mode 100755
> index 000000000000..e946ee6ac7c2
> --- /dev/null
> +++ b/tests/btrfs/242
> @@ -0,0 +1,49 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021 Oracle. All Rights Reserved.
> +#
> +# FS QA Test 242
> +#
> +# Test that fstrim can run on the degraded filesystem
> +#   Kernel requires fix for the null pointer deref in btrfs_trim_fs()
> +#     [patch] btrfs: check for missing device in btrfs_trim_fs
> +
> +
> +. ./common/preamble
> +_begin_fstest auto quick replace trim
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_btrfs_forget_or_module_loadable
> +_require_scratch_dev_pool 2
> +#_require_command "$WIPEFS_PROG" wipefs
> +
> +_scratch_dev_pool_get 2
> +dev1=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $1 }')
> +
> +_scratch_pool_mkfs "-m raid1 -d raid1"
> +_scratch_mount
> +_require_batched_discard $SCRATCH_MNT
> +
> +# Add a test file with some data.
> +$XFS_IO_PROG -f -c "pwrite -S 0xab 0 10M" $SCRATCH_MNT/foo > /dev/null

What's the point of adding this file (which you copied exactly from
btrfs/223) if it's not needed to trigger the bug and it's not used
anywhere in the test?
Or at the very least, check that reading it after the fstrim returns
the correct data, as it might help prevent some regression in the
future.

Thanks.

> +
> +# Unmount the filesystem.
> +_scratch_unmount
> +
> +# Mount the filesystem in degraded mode
> +_btrfs_forget_or_module_reload
> +_mount -o degraded $dev1 $SCRATCH_MNT
> +
> +# Run fstrim
> +$FSTRIM_PROG $SCRATCH_MNT
> +
> +_scratch_dev_pool_put
> +
> +echo Silence is golden
> +
> +status=3D0
> +exit
> diff --git a/tests/btrfs/242.out b/tests/btrfs/242.out
> new file mode 100644
> index 000000000000..a46d77702f23
> --- /dev/null
> +++ b/tests/btrfs/242.out
> @@ -0,0 +1,2 @@
> +QA output created by 242
> +Silence is golden
> --
> 2.27.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
