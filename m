Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FEB3F4DC1
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 17:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhHWPuy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 11:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhHWPux (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 11:50:53 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F68C061575;
        Mon, 23 Aug 2021 08:50:10 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id v1so9908156qva.7;
        Mon, 23 Aug 2021 08:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=JedtgEvNKCJoz66nmZsiPaqgelV9E6V0ABmuh1kxb1s=;
        b=YwJaraYgz8qrHViiQKkazAk4yECf0YtHBlGSjoLG4DiYbWu2S4aZeW2JtzKO9P/CwK
         O3+hUwwr1juV2t7WzaY5OX3oVxO41Zx29JTyZKGCnSw/3PewyVzA3c0N8HFOfBzpN+Tb
         e9b5JyAtngkYwhNG9mjQiKm1HVmxAL9pAQrSZfuqf5thoNZMD1v54DCFW/qroL16rWb7
         CrQ06zUQdeVo3QJIIvdUZ7xZE4vl6KwUH4JWJOxk073QuBnb4c06yvXsLqI/mcBz1apB
         ENiv0oZU+CA4gDADgmRh6Si7+Tz97/Gf8DPSu19TGyvCYi6p7ttkjqGMcZK8YRpfrIRd
         z48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=JedtgEvNKCJoz66nmZsiPaqgelV9E6V0ABmuh1kxb1s=;
        b=Q8J1v/3MmvnkZsJmsNXhGKYE7knEusTrdq0wM3DGvhgRTFbOZf735km3H48LF6POSU
         bhiGZ6nZK7uXopIAh/d2dfpBqEXZNzL5DyyimHNBdB/zT/3ybDobasUXm7RkDFS4s1yK
         fF0atwtjQIeYCB+UAqi6jAg+Dyv58I75ZdCIQRchCzhqDe6oCjiznf5U+QuO+skYWrDH
         8cFdaBkss4JLlwzEJWHErymKlsE2svcRVKcwT3tIKniiTmqXBolw8RnaYnyyadK2QK91
         t1WcK11097XD/hKZ8SCRA/0I+Yd3yCC6YbD4uayKvXdRCQt88eTZ0HTVd/AaHMpoM3P3
         I/qw==
X-Gm-Message-State: AOAM532pcjtdHXFw5LgNLZABcLtNUvbEIKP/9870xHAG6FT3IzZkA5ZR
        GbuHCds/zz63Vq7XogXXRFpj/oKmRXCXi5tOCMw=
X-Google-Smtp-Source: ABdhPJzybZFyThB3ilr43aHCs3SweCjhX697rbyopLwQeQ6dSI+x8NjNoM6/XuumNYzbfLffD55YKiiJ9W3lByfjp1U=
X-Received: by 2002:a05:6214:c69:: with SMTP id t9mr34170355qvj.28.1629733809596;
 Mon, 23 Aug 2021 08:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210819131456.304721-1-nborisov@suse.com>
In-Reply-To: <20210819131456.304721-1-nborisov@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 23 Aug 2021 16:49:58 +0100
Message-ID: <CAL3q7H57NsQ2WhdsC3=gYftFp_JUKHVxNgCAQuXPwvFzux9CaA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Add test for rename exchange behavior between subvolumes
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 19, 2021 at 2:17 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

At the very least the change log could mention which patch / commit
motivated this test.

> ---
>  tests/btrfs/246     | 46 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/246.out | 27 ++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+)
>  create mode 100755 tests/btrfs/246
>  create mode 100644 tests/btrfs/246.out
>
> diff --git a/tests/btrfs/246 b/tests/btrfs/246
> new file mode 100755
> index 000000000000..0934932d1f22
> --- /dev/null
> +++ b/tests/btrfs/246
> @@ -0,0 +1,46 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 246
> +#
> +# Tests rename exchange behavior across subvolumes
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rename
> +
> +# Import common functions.
> + . ./common/renameat2
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_renameat2 exchange
> +_require_scratch
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +# Create 2 subvols to use as parents for the rename ops
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1 1>/dev/null
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol2 1>/dev/null
> +
> +# _rename_tests_source_dest internally expects the flags variable to con=
tain
> +# specific options to rename syscall. Ensure cross subvol ops are forbid=
den
> +flags=3D"-x"
> +_rename_tests_source_dest $SCRATCH_MNT/subvol1/src $SCRATCH_MNT/subvol2/=
dst "cross-subvol"
> +
> +# Prepare a subvolume and a directory whose parents are different subvol=
umes
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1/sub-subvol 1>/dev=
/null
> +mkdir $SCRATCH_MNT/subvol2/dir
> +
> +# Ensure exchanging a subvol with a dir when both parents are different =
fails
> +$here/src/renameat2 -x $SCRATCH_MNT/subvol1/sub-subvol $SCRATCH_MNT/subv=
ol2/dir
> +
> +# force transaction commit which runs the tree checker
> +sync

There's no need to invoke sync, when the test unmounts the device, the
tree checker runs and fstests notices and complains about the error
message from the tree checker.
Plus the mismatch between the produced output and the golden output,
is enough to make the test fail on an unpatched kernel.

Finally, this would also be a good opportunity to test regular renames
with subvolumes too, as we had bugs and regressions in the past like
in commit 4871c1588f92c6c13f4713a7009f25f217055807 ("Btrfs: use right
root when checking for hash collision
"), and never got any test cases for them.

Thanks.

> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/246.out b/tests/btrfs/246.out
> new file mode 100644
> index 000000000000..d50dc28b1b40
> --- /dev/null
> +++ b/tests/btrfs/246.out
> @@ -0,0 +1,27 @@
> +QA output created by 246
> +cross-subvol none/none -> No such file or directory
> +cross-subvol none/regu -> No such file or directory
> +cross-subvol none/symb -> No such file or directory
> +cross-subvol none/dire -> No such file or directory
> +cross-subvol none/tree -> No such file or directory
> +cross-subvol regu/none -> No such file or directory
> +cross-subvol regu/regu -> Invalid cross-device link
> +cross-subvol regu/symb -> Invalid cross-device link
> +cross-subvol regu/dire -> Invalid cross-device link
> +cross-subvol regu/tree -> Invalid cross-device link
> +cross-subvol symb/none -> No such file or directory
> +cross-subvol symb/regu -> Invalid cross-device link
> +cross-subvol symb/symb -> Invalid cross-device link
> +cross-subvol symb/dire -> Invalid cross-device link
> +cross-subvol symb/tree -> Invalid cross-device link
> +cross-subvol dire/none -> No such file or directory
> +cross-subvol dire/regu -> Invalid cross-device link
> +cross-subvol dire/symb -> Invalid cross-device link
> +cross-subvol dire/dire -> Invalid cross-device link
> +cross-subvol dire/tree -> Invalid cross-device link
> +cross-subvol tree/none -> No such file or directory
> +cross-subvol tree/regu -> Invalid cross-device link
> +cross-subvol tree/symb -> Invalid cross-device link
> +cross-subvol tree/dire -> Invalid cross-device link
> +cross-subvol tree/tree -> Invalid cross-device link
> +Invalid cross-device link
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
