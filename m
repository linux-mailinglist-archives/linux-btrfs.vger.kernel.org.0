Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3F777E0B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Aug 2023 13:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244738AbjHPLqu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Aug 2023 07:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244798AbjHPLqt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Aug 2023 07:46:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9C11FC3;
        Wed, 16 Aug 2023 04:46:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 944CF61644;
        Wed, 16 Aug 2023 11:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BCDC433C8;
        Wed, 16 Aug 2023 11:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692186407;
        bh=0k8u7oV6Uy3kseiVTDeFjUUPTj/LV2UxLgMy/m8tGIg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y3IngzYciTlrUQ48Ng7e/QkQ2I3vP5efdqAvIHvQyrQp5LN0oii8ep5jxAVsoW6ym
         hpxs4qRa8FOoQOvUc0btXX8sUaF2Wwi74x83Xc8NEPA/yo9bSeRGX/9KsMibXd+8g0
         8gi8iOjZ/hbIc9WDbxi+u2HsnIEjtsv0T7kP8l0Kkiownkybrco5SGOvdjj9w+v+VX
         eyn2Y+LcLyAvGQp+1Rl44NLy43oeabHE+NotivJLnyKY7GjvTBwgLZ/4ik422bmK1p
         v3iMURZHwycEJ/y1lVznIZh6wkO3eEplDKGU1W4+PE0qvr5hvb3rfHySol0oWpDcSw
         3vFy73VCUznjQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-56c85b723cfso4112751eaf.3;
        Wed, 16 Aug 2023 04:46:46 -0700 (PDT)
X-Gm-Message-State: AOJu0YxVVd5sUMOJnCpH/94je/WYL9oHPLVJ3NGXj6bmbsA27cA240Ye
        XV1Tqs8drq02qCsc/44Mw0HS5Su4PpoFz+fNHQA=
X-Google-Smtp-Source: AGHT+IGfnIRvFopkHSwIfJLJovdHvlegNqkxGif0c9zYGwc7kOytaH2Nb8B/yJzXS0KU55BdPvnshStj+rvld+F6yxE=
X-Received: by 2002:a05:6870:169a:b0:1b0:25b4:4b77 with SMTP id
 j26-20020a056870169a00b001b025b44b77mr2017443oae.14.1692186406077; Wed, 16
 Aug 2023 04:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230814203759.3555213-1-lee@trager.us>
In-Reply-To: <20230814203759.3555213-1-lee@trager.us>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 16 Aug 2023 12:46:10 +0100
X-Gmail-Original-Message-ID: <CAL3q7H67_k0tRQm_ujbep15R5jCR3GEFk57Fnkqnmc_8538utw@mail.gmail.com>
Message-ID: <CAL3q7H67_k0tRQm_ujbep15R5jCR3GEFk57Fnkqnmc_8538utw@mail.gmail.com>
Subject: Re: [PATCH v3] fstests: Vertify dir permissions when creating a stub subvolume
To:     Lee Trager <lee@trager.us>
Cc:     fstests@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 14, 2023 at 10:04=E2=80=AFPM Lee Trager <lee@trager.us> wrote:
>
> btrfs supports creating nesting subvolumes however snapshots are not
> recurive. When a snapshot is taken of a volume which contains a subvolume
> the subvolume is replaced with a stub subvolume which has the same name a=
nd
> uses inode number 2. This test validates that the stub volume copies
> permissions of the original volume.
> Signed-off-by: Lee Trager <lee@trager.us>
> ---
> v3
> - Fixed whitepsace in 300.out due to find command not using './' before %=
P
> v2:
> - Migrated _require_unshare from overlay/020 into common_rc. Updated the =
error
>   message as most Linux systems should have unshare from util-linux.
> - Added note about why the test must be done in one subshell process.
> - chown command now uses $qa_user:$qa_group instead of hard coded values.
> common/rc           |  6 ++++++
>  tests/btrfs/300     | 46 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/300.out | 18 ++++++++++++++++++
>  tests/overlay/020   |  7 +------
>  4 files changed, 71 insertions(+), 6 deletions(-)
>  create mode 100755 tests/btrfs/300
>  create mode 100644 tests/btrfs/300.out
>
> diff --git a/common/rc b/common/rc
> index 5c4429ed..ca7c5c14 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5224,6 +5224,12 @@ _soak_loop_running() {
>         return 0
>  }
>
> +
> +_require_unshare() {
> +       unshare -f -r -m -p -U  true &>/dev/null || \
> +               _notrun "unshare $@: not found, should be in util-linux"
> +}
> +
>  init_rc
>
>  ########################################################################=
########
> diff --git a/tests/btrfs/300 b/tests/btrfs/300
> new file mode 100755
> index 00000000..fb9cd49f
> --- /dev/null
> +++ b/tests/btrfs/300
> @@ -0,0 +1,46 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Meta Platforms, Inc.  All Rights Reserved.

2023

> +#
> +# FS QA Test 300
> +#
> +# Validate that snapshots taken while in a remapped namespace preserve
> +# the permissions of the user.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick subvol snapshot
> +
> +_supported_fs btrfs
> +
> +_require_test
> +_require_user
> +_require_group
> +_require_unix_perm_checking
> +_require_unshare
> +_register_cleanup "cleanup"

So this is a test for the bug fix recently submitted:

https://lore.kernel.org/linux-btrfs/20230811004657.1661696-1-lee@trager.us/

Which is in misc-next now:
https://github.com/kdave/btrfs-devel/commit/ea6aa58a92299294b83a75defa46743=
7a00011fe

Please add a:

_fixed_by_kernel_commit xxxxxxxxxxxx \
       "btrfs: copy dir permission and time when creating a stub subvolume"

The xxxxxxxxx should be replaced with the git commit id once it lands
in Linus' tree, in the meanwhile you can leave the xxxxxxxxxx.

Also please CC the linux-btrfs mailing list when you send btrfs tests
or changes, so that it isn't missed by developers and nowadays it's
even documented to do so in the MAINTAINERS file.

There's also a typo in the subject:  Vertify -> Verify

Thanks.


> +
> +test_dir=3D"${TEST_DIR}/$(basename $0)"
> +cleanup() {
> +    [ -d "$test_dir" ] && rm -rf $test_dir
> +}
> +
> +mkdir $test_dir
> +chown $qa_user:$qa_group $test_dir
> +
> +# _user_do executes each command as $qa_user in its own subshell. unshar=
e
> +# sets the namespace for the running shell. The test must run in one use=
r
> +# subshell to preserve the namespace over multiple commands.
> +_user_do "
> +cd ${test_dir};
> +unshare --user --keep-caps --map-auto --map-root-user;
> +$BTRFS_UTIL_PROG subvolume create subvol;
> +touch subvol/{1,2,3};
> +$BTRFS_UTIL_PROG subvolume create subvol/subsubvol;
> +touch subvol/subsubvol/{4,5,6};
> +$BTRFS_UTIL_PROG subvolume snapshot subvol snapshot;
> +"
> +
> +find $test_dir/. -printf "%M %u %g ./%P\n"
> +
> +status=3D0
> +exit
> diff --git a/tests/btrfs/300.out b/tests/btrfs/300.out
> new file mode 100644
> index 00000000..6e94447e
> --- /dev/null
> +++ b/tests/btrfs/300.out
> @@ -0,0 +1,18 @@
> +QA output created by 300
> +Create subvolume './subvol'
> +Create subvolume 'subvol/subsubvol'
> +Create a snapshot of 'subvol' in './snapshot'
> +drwxr-xr-x fsgqa fsgqa ./
> +drwxr-xr-x fsgqa fsgqa ./subvol
> +-rw-r--r-- fsgqa fsgqa ./subvol/1
> +-rw-r--r-- fsgqa fsgqa ./subvol/2
> +-rw-r--r-- fsgqa fsgqa ./subvol/3
> +drwxr-xr-x fsgqa fsgqa ./subvol/subsubvol
> +-rw-r--r-- fsgqa fsgqa ./subvol/subsubvol/4
> +-rw-r--r-- fsgqa fsgqa ./subvol/subsubvol/5
> +-rw-r--r-- fsgqa fsgqa ./subvol/subsubvol/6
> +drwxr-xr-x fsgqa fsgqa ./snapshot
> +-rw-r--r-- fsgqa fsgqa ./snapshot/1
> +-rw-r--r-- fsgqa fsgqa ./snapshot/2
> +-rw-r--r-- fsgqa fsgqa ./snapshot/3
> +drwxr-xr-x fsgqa fsgqa ./snapshot/subsubvol
> diff --git a/tests/overlay/020 b/tests/overlay/020
> index 98a33aec..9f82da34 100755
> --- a/tests/overlay/020
> +++ b/tests/overlay/020
> @@ -16,18 +16,13 @@ _begin_fstest auto quick copyup perms
>
>  # real QA test starts here
>
> -require_unshare() {
> -       unshare -f -r "$@" true &>/dev/null || \
> -               _notrun "unshare $@: not supported"
> -}
> -
>  # Modify as appropriate.
>  _supported_fs overlay
>  _fixed_by_kernel_commit 3fe6e52f0626 \
>         "ovl: override creds with the ones from the superblock mounter"
>
>  _require_scratch
> -require_unshare -m -p -U
> +_require_unshare
>
>  # Remove all files from previous tests
>  _scratch_mkfs
> --
> 2.34.1
>
