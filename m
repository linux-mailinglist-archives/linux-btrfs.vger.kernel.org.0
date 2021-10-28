Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6FA43DD63
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 11:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhJ1JEb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 05:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhJ1JEb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 05:04:31 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D8FC061570;
        Thu, 28 Oct 2021 02:02:04 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id k29so3577525qve.6;
        Thu, 28 Oct 2021 02:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=n+4tsLowBKKq4jXpS/TneOs5gHpr7omklgFJPj79D9I=;
        b=RwPO9W9SW/hynkkdjHVY3lmqnlfRiKL6WfVwvu3cdGAugopewlA/rb9hX+mIbaCMOO
         MznMISL0EaiO+/l50WebQaL7Ud/ZsmP39zgIBRfBBFbb6v5mptW5Tcuqi9I4TdX1o1BB
         XqN5k0Dk34fTbCT4wFU5jPq1gdFxBN08yIfZRyU/pDAiRGQ5M+ieERjcbkdKDTH3iUhQ
         aMwEEBYqk7dCY33wwbAHPCOFPqHE8/JN4lstlk7RHS5weBv9q++89fLsRBM85hVcPS33
         Kp7oR+PVFzk80b5aZ3x2b/XPTY8DSbJIGMm3iJXdM0+atBVTin+3CH4E5g9Mmd49u7uw
         DynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=n+4tsLowBKKq4jXpS/TneOs5gHpr7omklgFJPj79D9I=;
        b=40rff600H9Lo81tiQS4Z4pG0flCKdORPSHPVrORuZ8FNS2nO38MfBTAqgDIkq4QIn6
         blX43tTJbGZ8U/XvtIRShN6YO/KerNIfYPWAljX+pQs+di9xKT57P3mP5NjS68D/HRAD
         faZO7Knq9imT55agKbKMmAXkrV4ADKHraLL1KXxc/ZoCX5gGOz78DrgOzY1SE446jBFk
         79aebZ4wfe/kmKjpTR9jYKs3dmxlHSLgRCuaA0P/SW3r//qklMxm1WUvqBIihooRUzL8
         dP7JWUgxoo5mgZ++ElgoRFsrGxvgV44CD2HpmHHEBlVM0JbIVmjv6+Splomh9RgRL6DU
         skCg==
X-Gm-Message-State: AOAM532ohVYFVLuqZ/w6pFA0/4ATFCun6/pdZwiZvJhm4MrDfbhkxxkZ
        IXnR7ctUouJch18QD8XYZ1XtWcxZV4l/ouPrvVAy1sDjJF8=
X-Google-Smtp-Source: ABdhPJwOrTsOwBdxsVKmha37Hy6riJRBtL1OFS46s7kT3dcRqFNPaAKRCY/yYI3wX/2UJbJS0lrqJMEyEBRXPc8YAGw=
X-Received: by 2002:a05:6214:5197:: with SMTP id kl23mr2654591qvb.46.1635411723689;
 Thu, 28 Oct 2021 02:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211027135754.20101-1-nborisov@suse.com>
In-Reply-To: <20211027135754.20101-1-nborisov@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 28 Oct 2021 10:01:27 +0100
Message-ID: <CAL3q7H66tOAu0qANiwimWcDZwhgMKQpO46qz+uR1FaF61Y8A0g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Test proper interaction between skip_balance and
 paused balance
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 27, 2021 at 10:25 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
> Ensure a device can be added to a filesystem that has a paused balance
> operation and has been mounted with the 'skip_balance' mount option

Please mention which patch the test relates to.

>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  tests/btrfs/049     | 47 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/049.out |  1 +
>  2 files changed, 48 insertions(+)
>  create mode 100755 tests/btrfs/049
>
> diff --git a/tests/btrfs/049 b/tests/btrfs/049
> new file mode 100755
> index 000000000000..7f566ee112f1
> --- /dev/null
> +++ b/tests/btrfs/049
> @@ -0,0 +1,47 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 049
> +#
> +# Ensure that it's possible to add a device when we have a paused balanc=
e
> +# and the filesystem is mounted with skip_balance.
> +#
> +. ./common/preamble
> +_begin_fstest quick balance auto
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +_require_scratch_dev_pool
> +
> +_scratch_mkfs >/dev/null
> +_scratch_mount
> +
> +uuid=3D$(findmnt -n -o UUID $SCRATCH_MNT)
> +
> +if [[ ! -e /sys/fs/btrfs/$uuid/exclusive_operation ]]; then
> +       _notrun "Requires btrfs exclusive operation support"
> +fi

Why is it required to have the sysfs export file for the exclusive operatio=
ns?
The test doesn't use the file at all, and exclusive operations exist
for many years, unlike the sysfs file which is recent.

> +
> +dev1=3D"`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}'`"
> +
> +# Create some files on the so that balance doesn't complete instantly
> +args=3D`_scale_fsstress_args -z \
> +       -f write=3D10 -f creat=3D10 \
> +       -n 1000 -p 2 -d $SCRATCH_MNT/stress_dir`
> +echo "Run fsstress $args" >>$seqres.full
> +$FSSTRESS_PROG $args >/dev/null 2>&1
> +
> +# Start and pause balance to ensure it will be restored on remount
> +echo "Start balance" >>$seqres.full
> +_run_btrfs_balance_start --full-balance --bg "$SCRATCH_MNT"

There's no need to pass --full-balance, _run_btrfs_balance_start
already does that internally.
Further, explicitly passing --full-balance will make the test fail on
older versions of btrfs-progs that don't have that flag.

With those fixed, you can add:

 Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +$BTRFS_UTIL_PROG balance pause "$SCRATCH_MNT"
> +
> +_scratch_cycle_mount "skip_balance"
> +
> +$BTRFS_UTIL_PROG device add -K -f $dev1 "$SCRATCH_MNT"
> +
> +echo "Silence is golden"
> +status=3D0
> +exit
> diff --git a/tests/btrfs/049.out b/tests/btrfs/049.out
> index cb0061b33ff0..c69568ad9323 100644
> --- a/tests/btrfs/049.out
> +++ b/tests/btrfs/049.out
> @@ -1 +1,2 @@
>  QA output created by 049
> +Silence is golden
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
