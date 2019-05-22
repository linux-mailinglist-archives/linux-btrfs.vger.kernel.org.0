Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 807BF2608A
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2019 11:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfEVJdE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 May 2019 05:33:04 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38123 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbfEVJdD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 May 2019 05:33:03 -0400
Received: by mail-vs1-f68.google.com with SMTP id x184so996219vsb.5;
        Wed, 22 May 2019 02:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=1fqgZGDL5R7JOoEIwTHM+z12zqOnH6s5gIhoh9lOGds=;
        b=AkF3y0I7hE3HNR6ENC36HnS97A8iBMchngAH/FM6SjYzw+3GBAuklRiJDvPpT4zxuw
         SZ7fS66TFBB8y73qXdfWei6RQ3i67Q2b2LP2AP9Yjr3EKxjJ3RQB3E+w0FVeuM4owwgc
         6rCfVCyIBC1pOTaOOWXoi1GNS0rldRru5ErzzBKVP9QiztGc/d7n62IpJQwzUZtokmKc
         0P2VdxUzsqLkR/RD8wqiR5/qSgAPqP2q/XM/Nn/VdAGN9h9wzCXAJAqiU8BT0Oz3K+aP
         YuWHUHFvAoye9e7JjyubSbb2exm4gL/jyySt0UJ+g1vUsPd2WSjnNK12ice/E/ZfN0Mx
         rLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=1fqgZGDL5R7JOoEIwTHM+z12zqOnH6s5gIhoh9lOGds=;
        b=XR7zbECnqdBu4kar4FnWaWgftvu5EL46q1FiRv9zQM813zIpgpbLxll1isuvSrpDGm
         PFyxa0Gq1PHi0MfTUyhgzcQ47u+KWzfQ8XkD2GgfBo0IZEe5HI7CWHt8ibOHH2Yq6t8K
         NZkAJpVVFbIxCJvRE/L8qZaemsH+zrsDWW/8VuA1d3tB8E2OVrpV7IMlIecTStwroDN5
         XamrKrO5zrzG8tCHXuWf8z+5tvDvPlG+KHSa/UNFgA/p9/biLdx1STQocGUfCS1rTkXz
         +ZEpKnI5bMyJp3TnoRNtU+LQwgkoW15IBzsFp1KzKorTiWtIyTYTf2ir/5rilb3rlGnC
         NQqg==
X-Gm-Message-State: APjAAAWjt95cEbafqKjhU8Lh5Ms8vzb2MZWtBA23y1M6k0y12yZ5LBST
        t07gpio7tM4omLqg04bSVAFSXP1HsFmDhY2/wfI=
X-Google-Smtp-Source: APXvYqwxUtxj8svlhPz8RzoHWkU/QrP2kU4OVwtwKvX5PRTi1XLe3uPWAoiYEVAbY2B2KOkuIOuBoKYrTb6L8wrBLQE=
X-Received: by 2002:a67:e891:: with SMTP id x17mr30508498vsn.206.1558517582225;
 Wed, 22 May 2019 02:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190522083944.32365-1-wqu@suse.com>
In-Reply-To: <20190522083944.32365-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 22 May 2019 10:32:51 +0100
Message-ID: <CAL3q7H48_ouBvEsuximFOjAxOSdu5FFfP0Dn8QAsM73xRG8PMg@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: Test if btrfs will panic when mounting a
 partially balanced fs
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 22, 2019 at 9:40 AM Qu Wenruo <wqu@suse.com> wrote:
>
> There are two regressions that when mounting a partially balance btrfs
> after v5.1 kernel:
> - Kernel NULL pointer dereference at mount time
> - Kernel BUG_ON() just after mount
>
> The kernel fixes are:
> "btrfs: qgroup: Check if @bg is NULL to avoid NULL pointer
>  dereference"
> "btrfs: reloc: Also queue orphan reloc tree for cleanup to
>  avoid BUG_ON()"
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/188     | 94 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/188.out |  2 +
>  tests/btrfs/group   |  1 +
>  3 files changed, 97 insertions(+)
>  create mode 100755 tests/btrfs/188
>  create mode 100644 tests/btrfs/188.out
>
> diff --git a/tests/btrfs/188 b/tests/btrfs/188
> new file mode 100755
> index 00000000..f43be007
> --- /dev/null
> +++ b/tests/btrfs/188
> @@ -0,0 +1,94 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 188
> +#
> +# Test if btrfs mount will hit the following bugs when mounting
> +# a fs going through partial balance:
> +# - NULL pointer dereference
> +# - Kernel BUG_ON()

I would make the description be closer to what the test is - a general
test to validate that balance and qgroups work correctly when balance
needs to be resumed on mount.
You can leave those specific problems in the change log.

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
> +. ./common/dmlogwrites
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch
> +# and we need extra device as log device
> +_require_log_writes
> +
> +nr_files=3D512                           # enough metadata to bump tree =
height
> +file_size=3D2048                         # small enough to be inlined
> +
> +_log_writes_init $SCRATCH_DEV
> +_log_writes_mkfs >> $seqres.full 2>&1
> +
> +_log_writes_mount
> +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT >> $seqres.full
> +$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
> +
> +# Create enough metadata for later balance
> +for ((i =3D 0; i < $nr_files; i++)); do
> +       _pwrite_byte 0xcd 0 $file_size $SCRATCH_MNT/file_$i > /dev/null
> +done
> +
> +# Ensure we write all data/metadata back to disk so that later
> +# balance will do real I/O

I don't understand this. Real I/O? Do we have any fake I/O? What is it?

> +sync
> +
> +# Balance metadata so we will have at least one transaction committed wi=
th
> +# valid reloc tree, and hopefully an orphan reloc tree.
> +$BTRFS_UTIL_PROG balance start -f -m $SCRATCH_MNT >> $seqres.full
> +_log_writes_unmount
> +_log_writes_remove
> +
> +cur=3D$(_log_writes_find_next_fua 0)
> +echo "cur=3D$cur" >> $seqres.full
> +while [ ! -z "$cur" ]; do
> +       _log_writes_replay_log_range $cur $SCRATCH_DEV >> $seqref.full
> +
> +       # If the fs contains valid reloc tree and kernel is not patched,
> +       # we'll hit a NULL pointer dereference
> +       # Or if it contains orphan reloc tree and kernel is unpatched,
> +       # we'll hit a BUG_ON()

# Test that no crashes happen or any other kind of failure.

> +       _scratch_mount
> +       _scratch_unmount
> +
> +       # Don't trigger fsck here, as relocation get paused,
> +       # at that transistent state, qgroup number may differ
> +       # and cause false alert.
> +
> +       prev=3D$cur
> +       cur=3D$(_log_writes_find_next_fua $(($cur + 1)))
> +       [ -z "$cur" ] && break
> +done

After the balance finishes, can we verify that qgroup values are correct?

> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/188.out b/tests/btrfs/188.out
> new file mode 100644
> index 00000000..6f23fda0
> --- /dev/null
> +++ b/tests/btrfs/188.out
> @@ -0,0 +1,2 @@
> +QA output created by 188
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 44ee0dd9..16a7c31e 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -190,3 +190,4 @@
>  185 volume
>  186 auto quick send volume
>  187 auto send dedupe clone balance
> +188 auto quick replay

"balance" and "qgroup" groups as well

Thanks.
> --
> 2.21.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
