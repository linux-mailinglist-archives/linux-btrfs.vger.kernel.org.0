Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FDC7B2181
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 17:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjI1Pkb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 11:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjI1Pk2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 11:40:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6987CE5;
        Thu, 28 Sep 2023 08:40:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0A2C433C7;
        Thu, 28 Sep 2023 15:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695915625;
        bh=/ez+QSNJCXZ8HdMbgWdtOljbePPAhuNHT8lqvDoLu/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H1lJtQx25F9qbVgO624jJUOv7oKDOFEiBy6o8VBxhhVW21/x4J6geV0gn1V4h+fy/
         hWfjtg7eykQjbl856IrQGYFj6MHn1Y5LsyuWvNBTcEeyok7E2OmMh6IxfTvNGICRGg
         lhgXkYSzMK3ivQ+0YFwQG58tEoz4xaaWFBl4sSd91rLiW5AUwiy56ZfLCIXsPLBq1Z
         jIyk8LWHAg+oxGFzKpmKKjA6SA7ED5eikKFlkhgjen6ZxS7ohTsemxDmS+jhzrkese
         kcdqnqHMTUda8ygFiUx29pl1VA7X9MXS1PUU/RsztTy2kHcEr2N2IiYVPWenjFxFjf
         ZmhfiR3LX7OhQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1dcf357deedso5212915fac.0;
        Thu, 28 Sep 2023 08:40:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YxgTY8Ou7A1wWWdDne14/hGBxqszrXjKNXwvGxQ2aFUBgvF0eJF
        EzmMazTqG0yqCaGVrw+wxv3O2rlzJgTxIpbtCqc=
X-Google-Smtp-Source: AGHT+IEBB7kORpmFeBF/T9eoaWlNIhX01vHTcgpLkrlh95HCQo4YVAQtHLP+e2Fp9bN89yuYZdQOPj+TLYG9zx2yLoY=
X-Received: by 2002:a05:6870:d69f:b0:1e1:371:c2c5 with SMTP id
 z31-20020a056870d69f00b001e10371c2c5mr1810558oap.33.1695915624212; Thu, 28
 Sep 2023 08:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695856385.git.boris@bur.io> <a1887b9e67676ed2b46f664126aa3ebf6864f9d6.1695856385.git.boris@bur.io>
In-Reply-To: <a1887b9e67676ed2b46f664126aa3ebf6864f9d6.1695856385.git.boris@bur.io>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 28 Sep 2023 16:39:47 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6nKYeCisgmtOXr-gp8apitd-B7G8tGPVaTEHA=7Jy0Hg@mail.gmail.com>
Message-ID: <CAL3q7H6nKYeCisgmtOXr-gp8apitd-B7G8tGPVaTEHA=7Jy0Hg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] btrfs/301: new test for simple quotas
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 28, 2023 at 2:41=E2=80=AFAM Boris Burkov <boris@bur.io> wrote:
>
> Test some interesting basic and edge cases of simple quotas.
>
> To some extent, this is redundant with the alternate testing strategy of
> using MKFS_OPTIONS to enable simple quotas, running the full suite and
> relying on kernel warnings and fsck to surface issues.
>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  tests/btrfs/301     | 418 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/301.out |   2 +
>  2 files changed, 420 insertions(+)
>  create mode 100755 tests/btrfs/301
>  create mode 100644 tests/btrfs/301.out
>
> diff --git a/tests/btrfs/301 b/tests/btrfs/301
> new file mode 100755
> index 000000000..527c25230
> --- /dev/null
> +++ b/tests/btrfs/301
> @@ -0,0 +1,418 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 301
> +#
> +# Test common btrfs simple quotas scenarios involving sharing extents an=
d
> +# removing them in various orders.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick qgroup copy_range snapshot

Why the copy_range group? The test doesn't exercise copy_range.

It does exercise reflinking, so it should be in the "clone" group.
Also the following groups are missing:  subvol  prealloc

> +
> +# Import common functions.
> +# . ./common/filter

Here a:

. ./common/reflink

> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch

Should be:   _require_scratch_reflink

> +_require_scratch_enable_simple_quota

Here missing:

_require_cp_reflink
_require_btrfs_command inspect-internal dump-tree
_require_xfs_io_command "falloc"

> +
> +subv=3D$SCRATCH_MNT/subv
> +nested=3D$SCRATCH_MNT/subv/nested
> +snap=3D$SCRATCH_MNT/snap
> +k=3D1024
> +m=3D$(($k * $k))

Do we really need to define variables with the size of a KiB and a MiB?
Are there any programmers who don't know what those are? :)

> +nr_fill=3D1024
> +fill_sz=3D$((8 * $k))

Just doing  ...=3D$((8 * 1024 ))
Everyone would be aware it's 8 KiB...

> +total_fill=3D$(($nr_fill * $fill_sz))
> +eb_sz=3D$((16 * $k))

Same here.

> +ext_sz=3D$((128 * m))

And here 128 * 1024 * 1024

> +limit_nr=3D8
> +limit=3D$(($ext_sz * $limit_nr))
> +
> +get_qgroup_usage()
> +{
> +       local qgroupid=3D$1
> +
> +       $BTRFS_UTIL_PROG qgroup show --sync --raw $SCRATCH_MNT | grep "$q=
groupid" | $AWK_PROG '{print $3}'
> +}
> +
> +get_subvol_usage()
> +{
> +       local subvolid=3D$1
> +       get_qgroup_usage "0/$subvolid"
> +}
> +
> +count_subvol_owned_metadata()
> +{
> +       local subvolid=3D$1
> +       # find nodes and leaves owned by the subvol, then get unique offs=
ets
> +       # to account for snapshots sharing metadata.
> +       count=3D$($BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DE=
V | \
> +               grep "owner $subvolid" | awk '{print $2}' | sort | uniq |=
 wc -l)

awk -> $AWK_PROG

> +       # output bytes rather than number of metadata blocks
> +       echo $(($count * $eb_sz))

So $eb_sz is the extent buffer, leaf/node, size. This is expecting the
default of 16K on x86 (4K pages systems).
Will the test fail if one runs with MKFS_OPTIONS=3D"--nodesize 4K" for
example, or some other different node size?

What about on a 64K pages system, where by default the node size is
64K? Will the test fail?

I would rather make the test flexible to run with any node size, or if
not doable or impractical,
make it require a 4K page size and explicitly pass --nodesize 16K to
mkfs. We have tests where we do this.

> +}
> +
> +check_qgroup_usage()
> +{
> +       local qgroupid=3D$1
> +       local expected=3D$2
> +       local actual=3D$(get_qgroup_usage $qgroupid)
> +
> +       [ $expected -eq $actual ] || _fail "qgroup $qgroupid mismatched u=
sage $actual vs $expected"
> +}
> +
> +check_subvol_usage()
> +{
> +       local subvolid=3D$1
> +       local expected_data=3D$2
> +       # need to sync to see updated usage numbers.
> +       # could probably improve by placing syncs only where they are str=
ictly
> +       # needed after actual operations, but it is more error prone.

Can we get proper sentences?
Some are ending with punctuation, others are not. First word should
also be capitalized.
Same applies to everywhere else in the test.

> +       sync

I would rather move the sync to the helpers called below, and comment
that it's because they use
the btrfs inspect-internal command, which reads from disk and
therefore everything needs to be
flushed.

> +
> +       local expected_meta=3D$(count_subvol_owned_metadata $subvolid)
> +       local actual=3D$(get_subvol_usage $subvolid)
> +       local expected=3D$(($expected_data + $expected_meta))
> +
> +       [ $expected -eq $actual ] || _fail "subvol $subvolid mismatched u=
sage $actual vs $expected (expected data $expected_data expected meta $expe=
cted_meta diff $(($actual - $expected)))"
> +       echo "OK $subvolid $expected_data $expected_meta $actual" >> $seq=
res.full
> +}
> +
> +set_subvol_limit()
> +{
> +       local subvolid=3D$1
> +       local limit=3D$2
> +
> +       $BTRFS_UTIL_PROG qgroup limit $2 0/$1 $SCRATCH_MNT
> +}
> +
> +sync_check_subvol_usage()
> +{
> +       sync
> +       check_subvol_usage $@
> +}

Does this helper make any sense? Because check_subvol_usage() is doing
a sync call already.
And it's not called anywhere... so it can be deleted.

> +
> +trigger_cleaner()
> +{
> +       $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
> +       sleep 1
> +       $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT

This may be too timing sensitive.
We have other tests that do something like this:

_scratch_remount commit=3D1
sleep 1.5

At the very least add comments explaining why that guarantees the
cleaner is triggered and
it completes before the function returns, just like we have in
btrfs/276 for example.

> +}
> +
> +cycle_mount_check_subvol_usage()
> +{
> +       _scratch_cycle_mount
> +       check_subvol_usage $@
> +}
> +
> +
> +do_write()
> +{
> +       local file=3D$1
> +       local sz=3D$2
> +
> +       $XFS_IO_PROG -fc "pwrite -q 0 $sz" $file
> +       local ret=3D$?
> +       return $ret

Do we need this? Can't the function end just with the $XFS_IO_PROG call?
Wouldn't that be the same?

> +}
> +
> +do_enospc_write()
> +{
> +       local file=3D$1
> +       local sz=3D$2
> +
> +       do_write $file $sz 2>/dev/null && _fail "write expected enospc"

So this pattern of calling _fail everywhere, is a bit against what is
generally done in fstests.
Just don't redirect stderr - make it part of the golden output - this
is even better because we can confirm the write failed with -ENOSPC
and not some other error.

> +}
> +
> +do_falloc()
> +{
> +       local file=3D$1
> +       local sz=3D$2
> +
> +       $XFS_IO_PROG -fc "falloc 0 $sz" $file
> +}
> +
> +do_enospc_falloc()
> +{
> +       local file=3D$1
> +       local sz=3D$2
> +
> +       do_falloc $file $sz 2>/dev/null && _fail "falloc expected enospc"

Same here as before.

> +}
> +
> +enable_quota()
> +{
> +       local mode=3D$1
> +
> +       [ $mode =3D=3D "n" ] && return
> +       arg=3D$([ $mode =3D=3D "s" ] && echo "--simple")
> +
> +       $BTRFS_UTIL_PROG quota enable $arg $SCRATCH_MNT
> +}
> +
> +prepare()
> +{
> +       _scratch_mkfs >> $seqres.full
> +       _scratch_mount
> +       enable_quota "s"
> +       $BTRFS_UTIL_PROG subvolume create $subv >> $seqres.full
> +       set_subvol_limit 256 $limit
> +       check_subvol_usage 256 0
> +
> +       # Create a bunch of little filler files to generate several level=
s in
> +       # the btree, to make snapshotting sharing scenarios complex enoug=
h.
> +       $FIO_PROG --name=3Dfiller --directory=3D$subv --rw=3Drandwrite --=
nrfiles=3D$nr_fill --filesize=3D$fill_sz >/dev/null 2>&1

Using fio, we need a _require_fio somewhere. See other tests like
generic/299 for example.

> +       check_subvol_usage 256 $total_fill
> +
> +       # Create a single file whose extents we will explicitly share/uns=
hare.
> +       do_write $subv/f $ext_sz
> +       check_subvol_usage 256 $(($total_fill + $ext_sz))
> +}
> +
> +prepare_snapshotted()
> +{
> +       prepare
> +       $BTRFS_UTIL_PROG subvolume snapshot $subv $snap >> $seqres.full
> +       echo "snapshot" >> $seqres.full
> +       check_subvol_usage 256 $(($total_fill + $ext_sz))
> +       check_subvol_usage 257 0
> +}
> +
> +prepare_nested()
> +{
> +       prepare
> +       $BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
> +       $BTRFS_UTIL_PROG qgroup assign 0/256 1/100 $SCRATCH_MNT >> $seqre=
s.full
> +       $BTRFS_UTIL_PROG subvolume create $nested >> $seqres.full
> +       do_write $nested/f $ext_sz
> +       check_subvol_usage 257 $ext_sz
> +       check_subvol_usage 256 $(($total_fill + $ext_sz))
> +       local subv_usage=3D$(get_subvol_usage 256)
> +       local nested_usage=3D$(get_subvol_usage 257)
> +       check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
> +}
> +
> +basic_accounting()
> +{
> +       prepare
> +       echo "basic" >> $seqres.full
> +       echo "delete file" >> $seqres.full
> +       rm $subv/f
> +       check_subvol_usage 256 $total_fill
> +       cycle_mount_check_subvol_usage 256 $total_fill
> +       do_write $subv/tmp 512M
> +       rm $subv/tmp
> +       do_write $subv/tmp 512M
> +       rm $subv/tmp
> +       do_enospc_falloc $subv/large_falloc 2G
> +       do_enospc_write $subv/large 2G
> +       _scratch_unmount
> +}
> +
> +reservation_accounting()
> +{
> +       prepare
> +       for i in $(seq 10); do
> +               do_write $subv/tmp 512M
> +               rm $subv/tmp
> +       done
> +       do_enospc_write $subv/large 2G
> +       _scratch_unmount
> +}
> +
> +snapshot_accounting()
> +{
> +       prepare_snapshotted
> +       echo "unshare snapshot metadata" >> $seqres.full
> +       touch $snap/f
> +       check_subvol_usage 256 $(($total_fill + $ext_sz))
> +       check_subvol_usage 257 0
> +       echo "unshare snapshot data" >> $seqres.full
> +       do_write $snap/f $ext_sz
> +       check_subvol_usage 256 $(($total_fill + $ext_sz))
> +       check_subvol_usage 257 $ext_sz
> +       echo "delete snapshot file" >> $seqres.full
> +       rm $snap/f
> +       check_subvol_usage 256 $(($total_fill + $ext_sz))
> +       check_subvol_usage 257 0
> +       echo "delete original file" >> $seqres.full
> +       rm $subv/f
> +       check_subvol_usage 256 $total_fill
> +       check_subvol_usage 257 0
> +       cycle_mount_check_subvol_usage 256 $total_fill
> +       check_subvol_usage 257 0
> +       _scratch_unmount
> +}
> +
> +delete_subvol_file()
> +{
> +       prepare_snapshotted
> +       echo "delete subvol file first" >> $seqres.full
> +       rm $subv/f
> +       check_subvol_usage 256 $(($total_fill + $ext_sz))
> +       check_subvol_usage 257 0
> +       rm $snap/f
> +       trigger_cleaner
> +       check_subvol_usage 256 $total_fill
> +       check_subvol_usage 257 0
> +       cycle_mount_check_subvol_usage 256 $total_fill
> +       check_subvol_usage 257 0
> +       _scratch_unmount
> +}
> +
> +delete_snapshot_file()
> +{
> +       prepare_snapshotted
> +       echo "delete snapshot file first" >> $seqres.full
> +       rm $snap/f
> +       check_subvol_usage 256 $(($total_fill + $ext_sz))
> +       check_subvol_usage 257 0
> +       rm $subv/f
> +       check_subvol_usage 256 $total_fill
> +       check_subvol_usage 257 0
> +       cycle_mount_check_subvol_usage 256 $total_fill
> +       check_subvol_usage 257 0
> +       _scratch_unmount
> +}
> +
> +delete_subvol()
> +{
> +       echo "del sv" > /dev/ksmg

Missing a >> $seqres.full here instead of > /dev/ksmg - which is also
misspelled, should be kmsg.


> +       prepare_snapshotted
> +       echo "delete subvol first" >> $seqres.full
> +       $BTRFS_UTIL_PROG subvolume delete $subv >> $seqres.full
> +       check_subvol_usage 256 $(($total_fill + $ext_sz))
> +       check_subvol_usage 257 0
> +       rm $snap/f
> +       trigger_cleaner
> +       check_subvol_usage 256 $total_fill
> +       check_subvol_usage 257 0
> +       $BTRFS_UTIL_PROG subvolume delete $snap >> $seqres.full
> +       trigger_cleaner
> +       check_subvol_usage 256 0
> +       check_subvol_usage 257 0
> +       cycle_mount_check_subvol_usage 256 0
> +       check_subvol_usage 257 0
> +       _scratch_unmount
> +}
> +
> +delete_snapshot()
> +{
> +       echo "del snap" > /dev/ksmg
> +       prepare_snapshotted
> +       echo "delete snapshot first" >> $seqres.full
> +       $BTRFS_UTIL_PROG subvolume delete $snap >> $seqres.full
> +       check_subvol_usage 256 $(($total_fill + $ext_sz))
> +       check_subvol_usage 257 0
> +       $BTRFS_UTIL_PROG subvolume delete $subv >> $seqres.full
> +       trigger_cleaner
> +       check_subvol_usage 256 0
> +       check_subvol_usage 257 0
> +       _scratch_unmount
> +}
> +
> +nested_accounting()
> +{
> +       echo "nested" > /dev/ksmg

Same here.

> +       prepare_nested
> +       echo "nested" >> $seqres.full
> +       echo "delete file" >> $seqres.full
> +       rm $subv/f
> +       check_subvol_usage 256 $total_fill
> +       check_subvol_usage 257 $ext_sz
> +       local subv_usage=3D$(get_subvol_usage 256)
> +       local nested_usage=3D$(get_subvol_usage 257)
> +       check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
> +       rm $nested/f
> +       check_subvol_usage 256 $total_fill
> +       check_subvol_usage 257 0
> +       subv_usage=3D$(get_subvol_usage 256)
> +       nested_usage=3D$(get_subvol_usage 257)
> +       check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
> +       _scratch_unmount
> +}
> +
> +enable_mature()
> +{
> +       echo "mature" > /dev/ksmg

Same here.

> +       _scratch_mkfs >> $seqres.full
> +       _scratch_mount
> +       $BTRFS_UTIL_PROG subvolume create $subv >> $seqres.full
> +       do_write $subv/f $ext_sz
> +       sync

Why is the sync needed? At least add a comment.

> +       enable_quota "s"

If enabling quotas requires flushing all delalloc, the kernel should
do it, no need for user space to call sync or anything equivalent.
Would be odd to get incorrect quotas when enabling because there's
pending delalloc.

> +       set_subvol_limit 256 $limit
> +       _scratch_cycle_mount
> +       usage=3D$(get_subvol_usage 256)
> +       [ $usage -lt $ext_sz ] || _fail "captured usage from before enabl=
e $usage"
> +       do_write $subv/g $ext_sz
> +       usage=3D$(get_subvol_usage 256)
> +       [ $usage -lt $ext_sz ] && "failed to capture usage after enable $=
usage"
> +       check_subvol_usage 256 $ext_sz
> +       rm $subv/f
> +       check_subvol_usage 256 $ext_sz
> +       _scratch_cycle_mount
> +       rm $subv/g
> +       check_subvol_usage 256 0
> +       _scratch_unmount
> +}
> +
> +reflink_accounting()
> +{
> +       prepare
> +       # do more reflinks than would fit
> +       for i in $(seq $(($limit_nr * 2))); do
> +               cp --reflink=3Dalways $subv/f $subv/f.i

Use the helper _cp_reflink instead.

> +       done
> +       # no additional data usage from reflinks
> +       check_subvol_usage 256 $(($total_fill + $ext_sz))
> +       _scratch_unmount
> +}
> +
> +delete_link()
> +{
> +       prepare
> +       cp --reflink=3Dalways $subv/f $subv/f.link

Same here.

> +       check_subvol_usage 256 $(($total_fill + $ext_sz))
> +       rm $subv/f.link
> +       check_subvol_usage 256 $(($total_fill + $ext_sz))
> +       rm $subv/f
> +       check_subvol_usage 256 $(($total_fill))
> +       _scratch_unmount
> +}
> +
> +delete_linked()
> +{
> +       prepare
> +       cp --reflink=3Dalways $subv/f $subv/f.link

Same here.

Thanks.

> +       check_subvol_usage 256 $(($total_fill + $ext_sz))
> +       rm $subv/f
> +       check_subvol_usage 256 $(($total_fill + $ext_sz))
> +       rm $subv/f.link
> +       check_subvol_usage 256 $(($total_fill))
> +       _scratch_unmount
> +}
> +
> +basic_accounting
> +reservation_accounting
> +snapshot_accounting
> +delete_subvol_file
> +delete_snapshot_file
> +delete_subvol
> +delete_snapshot
> +nested_accounting
> +enable_mature
> +reflink_accounting
> +delete_link
> +delete_linked
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/301.out b/tests/btrfs/301.out
> new file mode 100644
> index 000000000..4025504e4
> --- /dev/null
> +++ b/tests/btrfs/301.out
> @@ -0,0 +1,2 @@
> +QA output created by 301
> +Silence is golden
> --
> 2.42.0
>
