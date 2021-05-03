Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045BE37141D
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 May 2021 13:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhECLRu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 May 2021 07:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbhECLRt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 May 2021 07:17:49 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8BCC06174A;
        Mon,  3 May 2021 04:16:56 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 76so2746133qkn.13;
        Mon, 03 May 2021 04:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=vXtH5/T+cx1yIBSw3jM4bteZdlehl1w02KYu9pmCXko=;
        b=g8gT1+S1diOVUGP5BzwThpFuYBgNr/ANfF1SwB5mlviaFHwUJDSueWSPK9rhADWN/b
         sKEcZAqUeQeENFDAwqDZV9gCnPXRAIoq+bYM1i913lqsVz+TqXRLGh6DAxkExa/BdsHp
         K4bsb5s8CqT0yVb9lNFOtrrsALBGcWNHsG8D3AeD3OVngxNfUHfar6oc58R4v/yflxcd
         whfHzxy/0Ca1LSQp2fbgI9rKNvqYB/8GX2soRgfL6mOpztZLLhiSrDwpq1QJSQNMdhLb
         1nVouHtLo++l+gh1L/kvnO3jxGRkG2iy4XNQsQbNe2cVhD33raWMeTT1GQYx3ujtlyXc
         W8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=vXtH5/T+cx1yIBSw3jM4bteZdlehl1w02KYu9pmCXko=;
        b=pkrAsl9mt0d7Q6Q03aj22pCSw8zJ9V+6LaKeQIWtwCRgOYcbp3XmVTkxFl9f6gG7VP
         e6CTw4x8FtOIc+zU3RBlDl+dllKbCJply64Gn/a+28DUaoSttvDDMS7S7cYG4D6gOrB4
         EZdvvmJeXJTBr8mMQDqfBQxmXzjlao2z7yBdT1PL7hM/3X64kOXEiGuMUaILBqeaU+mW
         uSr1pXmar21ISQv6E2Kiw7ZnVbro3KpDaKzyhE+ZFCbykL14r/m8f1xBVxZ92ZnW6bef
         +OJaEtMvji6kP9G0OcSHgJpXmguOm83oPk8f/m9HRs7uChdtfpVvkIZ3Ul2ZoRw7ut+X
         XKJw==
X-Gm-Message-State: AOAM530/q6/KscDxkkrtlXJlIDn+BE5Z8GLfzJLqnPXvHJ2vT5jLGe8d
        ej6HiypadOsaJrm4vNOdG1RAuPuAyr9j4qm48o4=
X-Google-Smtp-Source: ABdhPJxvLq673LyBu593FOh1vj8d29IaSekCoq4elUKZ49Z+GsBgQg4kPIEbk7LGGXBWse6gjiO2gUfIuj64dK8Gj98=
X-Received: by 2002:a05:620a:2282:: with SMTP id o2mr14334608qkh.479.1620040614907;
 Mon, 03 May 2021 04:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <96fe1c0c8747d24ad6c45bc3f0a5551b8e1ebbde.1619793258.git.anand.jain@oracle.com>
 <2426455f382feec9352d48f5912278c30dc06210.1620039369.git.anand.jain@oracle.com>
In-Reply-To: <2426455f382feec9352d48f5912278c30dc06210.1620039369.git.anand.jain@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 3 May 2021 12:16:43 +0100
Message-ID: <CAL3q7H4HOC8tMvBZHkCtoDpBBSmEV3Zd6Z8f4A_AUTP2v1WJmg@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: add fstrim test case on the sprout device
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe David Borba Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 3, 2021 at 12:11 PM Anand Jain <anand.jain@oracle.com> wrote:
>
> Add fstrim test case on the sprout device, verify seed device
> integrity.
>
>  btrfs: fix unmountable seed device after fstrim
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> v3:
>   Drop useless write into the sprout device as we are testing the effect =
of
>      fstrim run in the sprout on the seed device.
> v2:
>   Add _require_fstrim and _require_batched_discard.
>   Use FSTRIM_PROG.
>   Use _filter_ro_mount to handle the difference in output in different
>      mount(8) version.
>   Call _scratch_dev_pool_put.
>   Add _check_btrfs_filesystem $seed to check the whole seed fs.
>   Update in-code comments.
>
>  tests/btrfs/236     | 79 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/236.out |  5 +++
>  tests/btrfs/group   |  1 +
>  3 files changed, 85 insertions(+)
>  create mode 100755 tests/btrfs/236
>  create mode 100644 tests/btrfs/236.out
>
> diff --git a/tests/btrfs/236 b/tests/btrfs/236
> new file mode 100755
> index 000000000000..1fcb3aab8c0c
> --- /dev/null
> +++ b/tests/btrfs/236
> @@ -0,0 +1,79 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Oracle. All Rights Reserved.
> +#
> +# FS QA Test 236
> +#
> +# Check seed device integrity after fstrim on the sprout device.
> +#
> +#  Kernel bug is fixed by the commit:
> +#    btrfs: fix unmountable seed device after fstrim
> +
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
> +_require_command "$BTRFS_TUNE_PROG" btrfstune
> +_require_fstrim
> +_require_scratch_dev_pool 2
> +_scratch_dev_pool_get 2
> +
> +seed=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
> +sprout=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
> +
> +_mkfs_dev $seed
> +_mount $seed $SCRATCH_MNT
> +
> +$XFS_IO_PROG -f -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foo > /dev/null
> +_scratch_unmount
> +$BTRFS_TUNE_PROG -S 1 $seed
> +
> +# Mount the seed device and add the rw device
> +_mount $seed $SCRATCH_MNT 2>&1 | _filter_ro_mount | _filter_scratch
> +md5sum $SCRATCH_MNT/foo | _filter_scratch
> +
> +$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT
> +_scratch_unmount
> +
> +# Now remount writeable sprout device, create some data and run fstrim
> +_mount $sprout $SCRATCH_MNT
> +_require_batched_discard $SCRATCH_MNT
> +
> +$FSTRIM_PROG $SCRATCH_MNT
> +
> +_scratch_unmount
> +
> +# Verify seed device is all ok
> +_mount $seed $SCRATCH_MNT 2>&1 | _filter_ro_mount | _filter_scratch
> +md5sum $SCRATCH_MNT/foo | _filter_scratch
> +_scratch_unmount
> +
> +_check_btrfs_filesystem $seed
> +
> +_scratch_dev_pool_put
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/236.out b/tests/btrfs/236.out
> new file mode 100644
> index 000000000000..01699b8fc291
> --- /dev/null
> +++ b/tests/btrfs/236.out
> @@ -0,0 +1,5 @@
> +QA output created by 236
> +mount: device write-protected, mounting read-only
> +096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
> +mount: device write-protected, mounting read-only
> +096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 331dd432fac3..5032259244e0 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -238,3 +238,4 @@
>  233 auto quick subvolume
>  234 auto quick compress rw
>  235 auto quick send
> +236 auto quick seed trim
> --
> 2.27.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
