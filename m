Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC4E3BBC51
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 13:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhGELlL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jul 2021 07:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhGELlK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jul 2021 07:41:10 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E377BC061574;
        Mon,  5 Jul 2021 04:38:33 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id z12so6952062qtj.3;
        Mon, 05 Jul 2021 04:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=jle5XGhwk007GM50q3hVvqAaCNNQ4hrGqxMgqOzL+yA=;
        b=C5fWNfiVEaRD6cwplUvGHBnN50tVaoihfJdjMC/0gbbTMQZwGDhYgfoIns7ylSuOod
         i3CC5ttPszG2WitDD3zPGHLGplpboQSfy8OF4xP0rI1/LYNmNuF0pSAzB/8oF9jFY0nB
         u8NCO5JpRZ05yxfuzgmft4PVMDUHcaJM41k10+ypLUWvfdQxTumY6wGDDIeQNxTNHjzU
         ImcUBqHOCPBYHUtJ2fsdyQwkdfYl2JiJvF67NzjSUy2Ras4lOVLtIGC7hDj6OyU062hR
         ZKtI0cFxhB1e2henpRdJ9JCEsLVKyFIiCPo/cTVAWUnybx643mB+aGz5wuKUVdOH6dXA
         rObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=jle5XGhwk007GM50q3hVvqAaCNNQ4hrGqxMgqOzL+yA=;
        b=F1yQ1kH/5A3VkME36LlH5VY9HXoC0DsR91B6cxvtJfiwJRj8nABLz+XNXmpSciHOWX
         f/Ut99Pr6c3sjKV0jSOTw93AT/O8qrDCGmlnqXlv/ZNrq65ltW2xZcYprwom2kOpRLw/
         CbMZNo3mDpxlBItyBrxkFMPNaWXw675HXnD/CP8SEroYFEalxW37w4xlIt9mfLWv7JEK
         v/7d+nT+XersuwJ52YMW4kv28dsOc6ukaKWoxlrRszHN0lo7FcHaEbzEcN2XcchO9saN
         ybG1BudeRy8EaE5jCMbzIpek4PU8jT564NJs3I5ziEtLKVzSHUEn+UO9LMTAHtKpwrPl
         exWA==
X-Gm-Message-State: AOAM532NOhA9imytPN+EUbVj7sPUFyXJQ0KFy5e/8kFR9T2CCSyqwfzH
        dZxLim/Njqvv08YESgJ5y1VsA9aSkftLDUsMelk=
X-Google-Smtp-Source: ABdhPJwgDcErqPy9my6tK68kYocfyc4aPtBPCcU21mQvHMDC5CU5IysQrFNnYoyxZuEPYp4GFSbclVFBclxF//WAyME=
X-Received: by 2002:ac8:7742:: with SMTP id g2mr5314082qtu.21.1625485112925;
 Mon, 05 Jul 2021 04:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <a70c9f6b4e45d9bcdc5c2f19182f89ef8e22c074.1625237782.git.anand.jain@oracle.com>
 <cae6a7e7836949a0407cf6859d7f9102636bab8f.1625481473.git.anand.jain@oracle.com>
In-Reply-To: <cae6a7e7836949a0407cf6859d7f9102636bab8f.1625481473.git.anand.jain@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 5 Jul 2021 12:38:21 +0100
Message-ID: <CAL3q7H6qXMuLuKquTaYurfZb89YieZQv0p6B7avRNi4f40pPJQ@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs/242: test case to fstrim on a degraded filesystem
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 5, 2021 at 11:43 AM Anand Jain <anand.jain@oracle.com> wrote:
>
> Create a degraded btrfs filesystem and run fstrim on it.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
> v3: Remove from replace-group.
>     Add to the volume-group.
>     Check for the data integrity.
> v2: Remove the commented #_require_command "$WIPEFS_PROG" wipefs
>     which I forgot to remove earlier.
>  tests/btrfs/242     | 49 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/242.out |  7 +++++++
>  2 files changed, 56 insertions(+)
>  create mode 100755 tests/btrfs/242
>  create mode 100644 tests/btrfs/242.out
>
> diff --git a/tests/btrfs/242 b/tests/btrfs/242
> new file mode 100755
> index 000000000000..da787c1ef91f
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
> +. ./common/preamble
> +_begin_fstest auto quick volume trim
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_btrfs_forget_or_module_loadable
> +_require_scratch_dev_pool 2
> +
> +_scratch_dev_pool_get 2
> +dev1=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $1 }')
> +
> +_scratch_pool_mkfs "-m raid1 -d raid1"
> +_scratch_mount
> +_require_batched_discard $SCRATCH_MNT
> +
> +# Add a test file with some data.
> +$XFS_IO_PROG -f -c "pwrite -S 0xab 0 10M" $SCRATCH_MNT/foo | _filter_xfs=
_io
> +
> +# Unmount the filesystem.
> +_scratch_unmount
> +
> +# Mount the filesystem in degraded mode
> +_btrfs_forget_or_module_reload
> +_mount -o degraded $dev1 $SCRATCH_MNT
> +
> +# Run fstrim, it should skip on the missing device.
> +$FSTRIM_PROG $SCRATCH_MNT
> +
> +# Verify data integrity as in the golden output.
> +echo "File foo data:"
> +od -A d -t x1 $SCRATCH_MNT/foo
> +
> +_scratch_dev_pool_put
> +
> +status=3D0
> +exit
> diff --git a/tests/btrfs/242.out b/tests/btrfs/242.out
> new file mode 100644
> index 000000000000..0f478fc93db7
> --- /dev/null
> +++ b/tests/btrfs/242.out
> @@ -0,0 +1,7 @@
> +QA output created by 242
> +wrote 10485760/10485760 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +File foo data:
> +0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
> +*
> +10485760
> --
> 2.27.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
