Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAE3724542
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 16:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbjFFOHb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 10:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbjFFOHJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 10:07:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A015B10C6;
        Tue,  6 Jun 2023 07:07:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34B4560A75;
        Tue,  6 Jun 2023 14:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954FEC433D2;
        Tue,  6 Jun 2023 14:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686060426;
        bh=774dvXSS5tSsBcbry/7/BvnTg7DkNcfOxfLgDSoQB6Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=klRU2Sd6b4Y+mTtqEBpUm4VL4HminM1fRPpXiK+zn15lKpgdG974KVCnCv2JkmXsT
         a+VzF2ZXzYrNd2EMPa2pwuqy+pDk2Nq4ASFvgCGFUsx020j/+WUNTKd8ix6DffIPXB
         D33dFc4idqNibMWK4GiuYtAIioEJf5Vryk3gONtg3hJVrZJxN39urJ8GNi5IQ2Wl0e
         IZl9XkuOC9TU7OFPvX7VTvimG5ofhkCXb34JLiiQFLj7DawlRDMwldF6OT8n4csZZW
         mWh1Vnp+I/GUHcZTYjp5il05YRYB/OCK8823CBa/PoAHjGBStW5xGV49iqX8A0Trwj
         UNsmaGYt9hs3Q==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-19f6211d4e1so5266607fac.1;
        Tue, 06 Jun 2023 07:07:06 -0700 (PDT)
X-Gm-Message-State: AC+VfDzWXmTAAPyAosiWIqkiSQzvS3qMyCTTdpeJNJ6Y+Oq2LVTk8N/1
        jphUfJ512J6jZChxmhrE3eQvex7S456SRr3OOE8=
X-Google-Smtp-Source: ACHHUZ5jldFBSImrR5V4/RqsLQCq877D4qe0D3065mT9DsCvhakgNQl6UPZQnvfkdR777JO+B3dI+c4gRTE0gQ9shJ0=
X-Received: by 2002:a54:4881:0:b0:398:f76:36a5 with SMTP id
 r1-20020a544881000000b003980f7636a5mr1062074oic.56.1686060425667; Tue, 06 Jun
 2023 07:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230606105200.129464-1-wqu@suse.com>
In-Reply-To: <20230606105200.129464-1-wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 6 Jun 2023 15:06:29 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7eqFYXuAK7V=1Fq8Wf-4D4svrPPnzt3oBp=qPy4sPCgQ@mail.gmail.com>
Message-ID: <CAL3q7H7eqFYXuAK7V=1Fq8Wf-4D4svrPPnzt3oBp=qPy4sPCgQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: add a test case to verify read-only scrub
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 6, 2023 at 12:03=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> There is a regression on btrfs read-only scrub behavior.
>
> The commit e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to
> scrub_stripe infrastructure") makes btrfs scrub to ignore the read-only
> flag completely, causing scrub to always fix the corruption.
>
> This test case would create an fs with repairable corruptions, then run
> a read-only scrub, and finally to make sure the corruption is not
> repaired.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> Changelog:
> v2:
> - Add _fixed_by_kernel_commit
>
> - Reduce the golden output
>   Instead of the first 512 bytes, the first 16 bytes are more than
>   enough.
>
> - Better golden output
>   Add two more steps explaining what the test is doing.
>
> - Output the offset for the file operation inside the fs
>   The offset is fixed, no need to use _filter_xfs_io_offset.
>
> - Remove the confusing comments on common/filter
> ---
>  tests/btrfs/288     | 70 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/288.out |  9 ++++++
>  2 files changed, 79 insertions(+)
>  create mode 100755 tests/btrfs/288
>  create mode 100644 tests/btrfs/288.out
>
> diff --git a/tests/btrfs/288 b/tests/btrfs/288
> new file mode 100755
> index 00000000..52245895
> --- /dev/null
> +++ b/tests/btrfs/288
> @@ -0,0 +1,70 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 288
> +#
> +# Make sure btrfs-scrub respects the read-only flag.
> +#
> +. ./common/preamble
> +_begin_fstest auto repair quick volume scrub
> +
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch_dev_pool 2
> +
> +
> +_require_odirect
> +# Overwriting data is forbidden on a zoned block device
> +_require_non_zoned_device "${SCRATCH_DEV}"
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +       "btrfs: scrub: respect the read-only flag during repair"
> +
> +_scratch_dev_pool_get 2
> +
> +# Step 1, create a raid btrfs with one 128K file
> +echo "step 1......mkfs.btrfs"
> +_scratch_pool_mkfs -d raid1 -b 1G >> $seqres.full 2>&1
> +_scratch_mount
> +
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foob=
ar" |\
> +       _filter_xfs_io
> +
> +# Step 2, corrupt one mirror so we can still repair the fs.
> +echo "step 2......corrupt one mirror"
> +# ensure btrfs-map-logical sees the tree updates
> +sync
> +
> +logical=3D$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
> +
> +physical1=3D$(_btrfs_get_physical ${logical} 1)
> +devpath1=3D$(_btrfs_get_device_path ${logical} 1)
> +
> +_scratch_unmount
> +
> +echo " corrupt stripe #1, devpath $devpath1 physical $physical1" \
> +       >> $seqres.full
> +$XFS_IO_PROG -d -c "pwrite -S 0xf1 -b 64K $physical1 64K" $devpath1 \
> +       > /dev/null
> +
> +# Step 3, do a read-only scrub, which should not fix the corruption.
> +echo "step 3......do a read-only scrub"
> +_scratch_mount -o ro
> +$BTRFS_UTIL_PROG scrub start -BRrd $SCRATCH_MNT >> $seqres.full 2>&1
> +_scratch_unmount
> +
> +# Step 4, make sure the corruption is still there
> +echo "step 4......verify the corruption is not repaired"
> +echo "  the first 16 bytes of the extent at mirror 1:"
> +$XFS_IO_PROG -c "pread -qv $physical1 16" $devpath1 |\
> +       _filter_xfs_io_offset
> +
> +_scratch_dev_pool_put
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/288.out b/tests/btrfs/288.out
> new file mode 100644
> index 00000000..452bdc67
> --- /dev/null
> +++ b/tests/btrfs/288.out
> @@ -0,0 +1,9 @@
> +QA output created by 288
> +step 1......mkfs.btrfs
> +wrote 131072/131072 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +step 2......corrupt one mirror
> +step 3......do a read-only scrub
> +step 4......verify the corruption is not repaired
> +  the first 16 bytes of the extent at mirror 1:
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> --
> 2.39.0
>
