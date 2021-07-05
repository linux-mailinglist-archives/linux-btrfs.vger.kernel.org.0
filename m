Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577ED3BB99D
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 10:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhGEIxJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jul 2021 04:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhGEIxJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jul 2021 04:53:09 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74363C061574;
        Mon,  5 Jul 2021 01:50:32 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id q16so16304845qke.10;
        Mon, 05 Jul 2021 01:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=PplRZd5dlVUzPhARv/8SuCABXVhNZbVaAcrURo+1N/o=;
        b=pDG2GARa6+kA71AAd/dlouUo5Qnn02EHYaBFYAva49jGUKr6CCWNV3C/Vjkcj0vUDy
         oiN2FH7YEzrcU3j0rv72ef2Ahpx0QUAlNmq7OEnqYdiWOPg+3ofsIJ4xoRnBXgtRXPDa
         0+kU/gH+OqeanMxQg8T0qQ9fwTYsJOu7WW2K0kWmkMMGTHKa9T4GK/Y8ZWbrGThAlL0X
         GLv8/Jxja67rDeH8IM1k3T6lZltZbvo1Vo27EeHoOciIDjaPOJQ7nvWJjbYx0JxLVnRq
         cQ7GOBgF3B09D7zPSIUn8IguIIU2OeCkiVk5ChHtjteE+VuVguqiS3EaVxSvcp1tJibc
         nngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=PplRZd5dlVUzPhARv/8SuCABXVhNZbVaAcrURo+1N/o=;
        b=Z9JRFY4JlL2QnwHTD9bWa+G395rFI4dklkreA2OihCIJ1iuU84VLcskG+1etzHCHUQ
         IJHB5sgiH40jnppowitQzSAYQunLMzNiYKOjbHTznXn8XC+Q4yu3azVslprAIqARiZlB
         1nH+lK+unJ4Y/+LRiyfyDNByN9IzNwINfODt8Ub1iisljmVEGlRzYsuzbcQxGWx7x/S8
         IOUQ62qsTZ8HDXjuvC0cID6ypjE8XSKCY7xCzKpRu/8gglLRhouJQHY/Qxj8mJeMpSHA
         eruBv/OlV6MOy0i/lSboB0ZXyLXWGGGlo95/xxb5I6kFLickc3OiVipsDw9HVifaXPl1
         h6sw==
X-Gm-Message-State: AOAM530QCrABcAHDK1t3q5x2KjgsHCkR7VJr5paQVrCuUBZsTODnKGro
        TLnlXNjmKSCdmU7IV8KpzbByyUUw4cQ8WKRmzo0=
X-Google-Smtp-Source: ABdhPJwc9S3xCMOsmsYpRNPIzo+sjwHNusf8+aCEYY+1igfx93qm8bFE+6pfgCSoHY9JYqwXd+mj+fcAsA+AhQbMsdo=
X-Received: by 2002:ae9:ec11:: with SMTP id h17mr12939064qkg.438.1625475031750;
 Mon, 05 Jul 2021 01:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <a70c9f6b4e45d9bcdc5c2f19182f89ef8e22c074.1625237782.git.anand.jain@oracle.com>
In-Reply-To: <a70c9f6b4e45d9bcdc5c2f19182f89ef8e22c074.1625237782.git.anand.jain@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 5 Jul 2021 09:50:20 +0100
Message-ID: <CAL3q7H5xdS5EXCN2QP0DXQr1_uxCGqK719J5c0EBFH28hYKj+A@mail.gmail.com>
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

Also, this does not belong to the 'replace' group (again copied from
btrfs/223 it seems).

Thanks.

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
