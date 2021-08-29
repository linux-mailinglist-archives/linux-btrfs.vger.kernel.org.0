Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C563FAC1A
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 16:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbhH2OFq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 10:05:46 -0400
Received: from out20-99.mail.aliyun.com ([115.124.20.99]:43990 "EHLO
        out20-99.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhH2OFo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 10:05:44 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07474364|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.262352-0.00261239-0.735036;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.LCBlm6k_1630245889;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.LCBlm6k_1630245889)
          by smtp.aliyun-inc.com(10.147.40.233);
          Sun, 29 Aug 2021 22:04:50 +0800
Date:   Sun, 29 Aug 2021 22:04:49 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Add test for rename exchange behavior between
 subvolumes
Message-ID: <YSuUAT27PfryyyRq@desktop>
References: <20210819131456.304721-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819131456.304721-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 19, 2021 at 04:14:56PM +0300, Nikolay Borisov wrote:
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

I noticed that test currently fails with v5.15-rc6 kernel as

  cross-subvol tree/symb -> Invalid cross-device link
  cross-subvol tree/dire -> Invalid cross-device link
  cross-subvol tree/tree -> Invalid cross-device link
 -Invalid cross-device link---

So is there any background info about this test? Is it motivated by a
known bug? If so is there a proposed fix available?

Some descriptions would be good in commit log.

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

Trailing white space in above line

> +#
> +. ./common/preamble
> +_begin_fstest auto quick rename

Should be in 'subvol' group as well.

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

The "1" in "1>/dev/null" could be dropped.

> +
> +# _rename_tests_source_dest internally expects the flags variable to contain
> +# specific options to rename syscall. Ensure cross subvol ops are forbidden
> +flags="-x"
> +_rename_tests_source_dest $SCRATCH_MNT/subvol1/src $SCRATCH_MNT/subvol2/dst "cross-subvol"

I think _rename_tests_source_dest should be updated to take flags as
arguments instead of inheriting $flags variable from caller. That could
be done in a separate patch as preparation.

> +
> +# Prepare a subvolume and a directory whose parents are different subvolumes
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1/sub-subvol 1>/dev/null
> +mkdir $SCRATCH_MNT/subvol2/dir
> +
> +# Ensure exchanging a subvol with a dir when both parents are different fails
> +$here/src/renameat2 -x $SCRATCH_MNT/subvol1/sub-subvol $SCRATCH_MNT/subvol2/dir
> +
> +# force transaction commit which runs the tree checker 
> +sync

A global sync seems a bit heavy, does syncfs on scratch fs work? Or does
umounting scratch dev work? If so we could depend on the test harness to
umount scratch dev after each test.

Thanks,
Eryu

> +
> +# success, all done
> +status=0
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
