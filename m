Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA263E2DEB
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 17:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243317AbhHFPsu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Aug 2021 11:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242813AbhHFPst (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Aug 2021 11:48:49 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4717C0613CF;
        Fri,  6 Aug 2021 08:48:32 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id e14so10364820qkg.3;
        Fri, 06 Aug 2021 08:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=OtZt8qM9sbwy1i6+/2/hCgWKYLHClyQEK23+gxuhs4M=;
        b=Q7Z8V6aN53MFXZVFYifk8wUr77qdgQgeX1UAmZ1rs/M4swcmUkBT4cIWTmWtJR+Vlt
         iUKKGSDi2OecEf1RWVlVLg6o6JqpZEECAxjAEhAMM/kd4B7MvBycG5hMx8uEsBqrYixo
         IpUMJju/7xuAZkSsR5zk+5W+RZIw2whcLiA6bgksni68OKTDbJb/HqXnW+/cgOtN96qm
         YELYQEveksZQ8EuiTIi45bOv3aZy6M/4KfxHOvxLWeBa1kC5eYcTg5DAizDGMHcbVQaF
         vOkq+ABc5T8VgdyraLL+ek9ICqCR9dpaVBNRHnAX8kjH2nkO0/UcDNwcBKy5dtp/u7fV
         DnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=OtZt8qM9sbwy1i6+/2/hCgWKYLHClyQEK23+gxuhs4M=;
        b=hYXCZX/UVEiuTgS74+lXhpv/s9f7d1pS7cwcz6n0bnvQpzKTDemKPeZVzvHnP3laL5
         oBhWe0TNbjDt+9iVOGrsHxKYKwS/UHBjAjdn1WJhkpGcA0FHFPuWAjp4F+Tr/rpl09cX
         FWi9PxQtjRmo3P09j9BnL9xrDHcn5kqcHZbbIZYg7YnojFar9QWBTgCMCAxEeHrMCN9o
         k8GbNod9LjRTV9TCHb6g8jQHSLV2rZIIQtypKq+4tYCvMAIiTjcDRtAwreM0C/8CxuSc
         aR9/rbbHd/opuFln9AiSy8yL0LYaWq9ph5AVNUCFvev0WR5VJFu3BDis/pOlZ7XnANe4
         koJA==
X-Gm-Message-State: AOAM5315zEufqVAxuuDO1pqmV01qHhTToMii7o2SuSOUtn3Xo90nWCOa
        7ojbcLQGZ6lT/KriZAzoQx7SUl+l2peMcKAeqMw=
X-Google-Smtp-Source: ABdhPJxCz7sKabHVy/8nTkiBii6cI7a3qVdFTWpyBQtthEQU2AQ+Tk1MczC/O66MtLio1Hy6eQN5SPitEkxHPAgh9+Q=
X-Received: by 2002:a05:620a:22b5:: with SMTP id p21mr10792711qkh.0.1628264912071;
 Fri, 06 Aug 2021 08:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210806113333.328261-1-wqu@suse.com>
In-Reply-To: <20210806113333.328261-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Aug 2021 16:48:21 +0100
Message-ID: <CAL3q7H7-SQS3--oijfty8SRnqqbwCi8S0dGrymKc1_NVe1Mq3w@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs/244: add test case to verify the
 behavior of deleting non-existing device
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 6, 2021 at 4:44 PM Qu Wenruo <wqu@suse.com> wrote:
>
> There is a kernel regression for btrfs, that when passing non-existing
> devid to "btrfs device remove" command, kernel will crash due to NULL
> pointer dereference.
>
> The test case is for such regression, it will:
>
> - Create and mount an empty single-device btrfs
> - Try to remove devid 3, which doesn't exist for above fs
> - Make sure the command exits properly with expected error message
>
> The kernel fix is titled "btrfs: fix NULL pointer dereference when
> deleting device by invalid id".
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Change the subject to also verify the error behavior
> - Include the error message into golden output
> - Also verify the return value of btrfs command
> ---
>  tests/btrfs/244     | 47 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/244.out |  2 ++
>  2 files changed, 49 insertions(+)
>  create mode 100755 tests/btrfs/244
>  create mode 100644 tests/btrfs/244.out
>
> diff --git a/tests/btrfs/244 b/tests/btrfs/244
> new file mode 100755
> index 00000000..fbefeedf
> --- /dev/null
> +++ b/tests/btrfs/244
> @@ -0,0 +1,47 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 244
> +#
> +# Make sure "btrfs device remove" won't crash when non-existing devid
> +# is provided
> +#
> +. ./common/preamble
> +_begin_fstest auto quick volume dangerous
> +
> +# Override the default cleanup function.
> +# _cleanup()
> +# {
> +#      cd /
> +#      rm -r -f $tmp.*
> +# }
> +
> +# Import common functions.
> +# . ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +# Above created fs only contains one device with devid 1, device remove =
3
> +# should just fail with proper error message showing devid 3 can't be fo=
und.
> +# Although on unpatched kernel, this will trigger a NULL pointer derefer=
ence.
> +$BTRFS_UTIL_PROG device remove 3 $SCRATCH_MNT
> +ret=3D$?
> +
> +if [ $ret -ne 1 ]; then
> +       echo "Unexpected return value from btrfs command, has $ret expect=
ed 1"
> +fi

I think I would just do "-eq 0" instead, but it's more about a
preferred style than anything else, and can always be changed later if
needed.

Looks good, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> +
> +# Fstests will automatically check the filesystem to make sure metadata =
is not
> +# corrupted.
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/244.out b/tests/btrfs/244.out
> new file mode 100644
> index 00000000..629adf2a
> --- /dev/null
> +++ b/tests/btrfs/244.out
> @@ -0,0 +1,2 @@
> +QA output created by 244
> +ERROR: error removing devid 3: No such file or directory
> --
> 2.31.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
