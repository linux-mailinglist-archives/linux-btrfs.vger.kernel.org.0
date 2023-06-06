Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF67723DD9
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 11:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbjFFJh2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 05:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbjFFJg4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 05:36:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5BD1980;
        Tue,  6 Jun 2023 02:36:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E855462FF5;
        Tue,  6 Jun 2023 09:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DFFC433EF;
        Tue,  6 Jun 2023 09:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686044190;
        bh=FQexaHudJy01cSzetEiL5xoXnHjn3FsL1MFqmSQxJHE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ovYn4zmU7CU6FMYJlGzzL9Rw8As0s74u0e+gXxA7lpUq1wADPl668z//rs4RvJB7C
         m8SU2pG5F906yN6Ba9qkhviGDJBS5X22oTxka4Zdo4lmxD0X9SzZuo+lhM/4aqTX2V
         gFbX27wTeLQG9jS7r09zpoRhlsrB3EcWCckQ12+mszHQ/ivY/fUhJZ4UZIe6QVbdd6
         hVae99TFoXyoZ6B62l2BhhNRVSQhgIpnnV07nm7iVRvZvzto80Kbq0BmD3P1C4RF7q
         UonETk4HxO9UElQMlBjuk8Wov9kbQKQ7CfNF9xaoDbWbeUgUyaLjCGJiWAW7yHR5JY
         +nbYQFDSnp2lA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1a2c9f087f0so3439231fac.3;
        Tue, 06 Jun 2023 02:36:30 -0700 (PDT)
X-Gm-Message-State: AC+VfDztPQrK+18QQV2ZvxM8XBqNVKEgCNKM6gca+QzH8DaSG8Xnp/Bb
        42rd7Nca9dOLCdaqU2+iUlA+T8PW13j1u5jaYbs=
X-Google-Smtp-Source: ACHHUZ4bPQE0YuksYsVRkfuhRh5jzysIKWogvYlW2d0jHeI0FYDWgJcLv1V/xAr9LuDJUZHaoFeEBk4Mzm4TaZspyJ4=
X-Received: by 2002:a05:6870:c809:b0:18e:b4df:a560 with SMTP id
 ee9-20020a056870c80900b0018eb4dfa560mr1670563oab.10.1686044189431; Tue, 06
 Jun 2023 02:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230606022354.48911-1-wqu@suse.com>
In-Reply-To: <20230606022354.48911-1-wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 6 Jun 2023 10:35:53 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6teZ0MyWWO-xsYk7cP+TyQw5WKdPKE-ra0+zxp_dDMzg@mail.gmail.com>
Message-ID: <CAL3q7H6teZ0MyWWO-xsYk7cP+TyQw5WKdPKE-ra0+zxp_dDMzg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add a test case to verify read-only scrub
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 6, 2023 at 4:20=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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
> ---
>  tests/btrfs/288     | 65 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/288.out | 39 +++++++++++++++++++++++++++
>  2 files changed, 104 insertions(+)
>  create mode 100755 tests/btrfs/288
>  create mode 100644 tests/btrfs/288.out
>
> diff --git a/tests/btrfs/288 b/tests/btrfs/288
> new file mode 100755
> index 00000000..7795bdd9
> --- /dev/null
> +++ b/tests/btrfs/288
> @@ -0,0 +1,65 @@
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
> +# For filedefrag and all the filters

This comment is a bit confusing. File defrag? The test doesn't exercise def=
rag.
Probably just leaving the comment out is better, it's obvious since we
are using filters.

> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch_dev_pool 2
> +
> +_require_odirect
> +# Overwriting data is forbidden on a zoned block device
> +_require_non_zoned_device "${SCRATCH_DEV}"

Can we please get a _fixed_by_kernel_commit call to identify the patch
that fixes the regression?

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
> +       _filter_xfs_io_offset

So why do we filter offsets?
Why not just a plain _filter_xfs_io as we most commonly do?

Thanks.

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
> +
> +# Step 3, do a read-only scrub, which should not fix the corruption.
> +_scratch_mount -o ro
> +$BTRFS_UTIL_PROG scrub start -BRrd $SCRATCH_MNT >> $seqres.full 2>&1
> +_scratch_unmount
> +
> +# Step 4, make sure the corruption is still there
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical1 512" $devpath1 |\
> +       _filter_xfs_io_offset
> +
> +_scratch_dev_pool_put
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/288.out b/tests/btrfs/288.out
> new file mode 100644
> index 00000000..c6c8e886
> --- /dev/null
> +++ b/tests/btrfs/288.out
> @@ -0,0 +1,39 @@
> +QA output created by 288
> +step 1......mkfs.btrfs
> +wrote 131072/131072 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +step 2......corrupt one mirror
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ............=
....
> +read 512/512 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> --
> 2.39.0
>
