Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118E81DAEBF
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 11:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgETJaK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 05:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETJaK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 05:30:10 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A02C061A0E;
        Wed, 20 May 2020 02:30:09 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id w188so602332vkf.0;
        Wed, 20 May 2020 02:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=DcADbJk05NlljNdRrBKV87ArWmdqg3uw43jTEtPrJWg=;
        b=JneZREQ9IK6lrdXjya7lmj5YZXTZX1UYnp7gE22XMgAna6YGmtQ7tdjkqKvV5tcIvv
         hZxDxFc1kpAx4q4P88WAmPZneHr4XNDMblO9W/5wjd0V3nhP3FPMaQKyAyfQpXfGtYcn
         HUi2u4d07fWffg2hC2onEx/oDDfipGqmSV8mtvZ9k6X893HOnlFFSPYLyaWzwyB1eAuc
         VxguKI3vosA0luicDDXUbM9dgJe/TchJFfIb/+nikrElCyqJAR4xDJJ+lo1RpFEilwG/
         hXMctD0kGaNGZJl8452JfWm+1D9JsImPook5dnyqWmfVnu7W0UmIpMuLweF52+QqVEPA
         GRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=DcADbJk05NlljNdRrBKV87ArWmdqg3uw43jTEtPrJWg=;
        b=tX6SkJu7ytoO07GtolrLz4prJa4iwFZSvUVZIyIUavrDwZpPXixPDRnOVx5mr986f5
         rQ0WxzjNTGm+ebjK9/YXui4uXxpWz9izffRymy2zReCoojw3YZ3PEFLbzt5S96hcdP9V
         sMJptVSvaYHEEi8Hxw/BlvQh73VyWLiwntQal0x958cn6924+JVL+xeZ8FkNwu4h2JjH
         32UBqiaNY3ZlFLiGsGvPdd6CBMXDXRbXm7AbLUQSl18KhejUYpinTOcNNs1bOIBFZJu+
         SDC47Xu5Wb8riBwEQLr3uIrarQO4ljawb+q9tMhKTf+fL2pvkiP8Fi97i3toepYwFbLO
         HOfA==
X-Gm-Message-State: AOAM531XiGhQd5gri6srk7v/yVNoJR56H8FBjfbYpL3bUd9dkgfGuv2A
        UZ7aWwEdNCpOwL1+P3CPwn4Y3yNfYgGqxXF1g8U=
X-Google-Smtp-Source: ABdhPJy9W0s/LlReV4hFBxhvICNlo/bvDy0/pMvX1SP8W9wGviR47Pgi9DNjoSnYTlP0gPiJDdfo4nrRy8FA8waUgZg=
X-Received: by 2002:a1f:294c:: with SMTP id p73mr861755vkp.24.1589967008728;
 Wed, 20 May 2020 02:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200520075746.16245-1-wqu@suse.com>
In-Reply-To: <20200520075746.16245-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 20 May 2020 10:29:57 +0100
Message-ID: <CAL3q7H7fY0fyiPS=LiFYDxHBAXqQF_WuZu7z=jKQv8DTkPadMA@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: Add a test for dead looping balance after
 balance cancel
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 20, 2020 at 8:59 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Test if canceling a running balance can cause later balance to dead
> loop.
>
> The ifx is titled "btrfs: relocation: Clear the DEAD_RELOC_TREE bit for
>  orphan roots to prevent runaway balance".
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Remove lsof debug output
> v3:
> - Remove ps debug output
> ---
>  tests/btrfs/213     | 64 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/213.out |  2 ++
>  tests/btrfs/group   |  1 +
>  3 files changed, 67 insertions(+)
>  create mode 100755 tests/btrfs/213
>  create mode 100644 tests/btrfs/213.out
>
> diff --git a/tests/btrfs/213 b/tests/btrfs/213
> new file mode 100755
> index 00000000..f56b0279
> --- /dev/null
> +++ b/tests/btrfs/213
> @@ -0,0 +1,64 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 213
> +#
> +# Test if canceling a running balance can lead to dead looping balance
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
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch
> +_require_command "$KILLALL_PROG" killall
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +
> +runtime=3D4
> +
> +# Create enough IO so that we need around $runtime seconds to relocate i=
t
> +dd if=3D/dev/zero bs=3D1M of=3D"$SCRATCH_MNT/file" oflag=3Dsync status=
=3Dnone \
> +       &> /dev/null &
> +dd_pid=3D$!
> +sleep $runtime
> +"$KILLALL_PROG" -q dd &> /dev/null

Do we really need the killall program? There's only one dd process.

We should also kill the dd process at _cleanup(), as killing the test
during the sleep above will result in the dd process not being killed.

> +wait $dd_pid
> +
> +# Now balance should take at least $runtime seconds, we can cancel it at
> +# $runtime/2 to ensure a success cancel.
> +$BTRFS_UTIL_PROG balance start -d --bg "$SCRATCH_MNT"
> +sleep $(($runtime / 2))
> +$BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT"
> +
> +# Now check if we can finish relocating metadata, which should finish ve=
ry
> +# quickly
> +$BTRFS_UTIL_PROG balance start -m "$SCRATCH_MNT" >> $seqres.full

Why redirect this one to $seqres.full and not the other balance? What
kind of useful information it provides?

> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/213.out b/tests/btrfs/213.out
> new file mode 100644
> index 00000000..bd8f2430
> --- /dev/null
> +++ b/tests/btrfs/213.out
> @@ -0,0 +1,2 @@
> +QA output created by 213
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 8d65bddd..fe4d5bb3 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -215,3 +215,4 @@
>  210 auto quick qgroup snapshot
>  211 auto quick log prealloc
>  212 auto balance dangerous
> +213 auto fast balance dangerous

fast -> quick

Thanks.

> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
