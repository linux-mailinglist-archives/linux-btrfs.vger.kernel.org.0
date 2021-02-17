Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42AD31D7BA
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 11:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhBQKxn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 05:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhBQKxm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 05:53:42 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2655C061756;
        Wed, 17 Feb 2021 02:53:01 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id w5so3771657qts.12;
        Wed, 17 Feb 2021 02:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=NItlTIPpqCDT5onjtk3qqDdmowNGhrYXobYQ0BrkB1w=;
        b=FDqOcyGKE3xaxyMy+1TPfdE/pup7aMN1qe5H9vKGB3ZbY+bQqVjR6GNTfsinU42bVm
         WeLEuoHvGuFfrxpwkAxsRsjnX42E7P7HTTPmKsmAgRUSg7ITfIp1Gtt+zySYryTge8Qb
         ePNC6TOkk22ptFZ0cYgfu8npA2SakbfTp1UGtcRqXfefuFrUhy8qHFg3sZxXz/Sd16tY
         s4Otlwd1SYWuvWT79awV5c0reHYDenfGtN3DLXQRIPIhauQ2Uw4W1ouo+x6Af1T40zBD
         vL8oLPKWGOSOBvmX+hlABliKagVRgyubJI1QUnxJfQydrwrEJl4YgwX0Gt9IGb0HLfSO
         UPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=NItlTIPpqCDT5onjtk3qqDdmowNGhrYXobYQ0BrkB1w=;
        b=oZhZHUSKJhZu0BeCm2P1Lum3MyBs6QinU5lZn37GrvPHFIzzKSScjlvuVC1T3E1PRn
         3LjfbdjtuB7cvuWr2+dx0lOM0RrG76w4n83LMZwPWiD2xqvPIcoF4Bqi/Sr8bIEyxahb
         afW290k+yyCLTVWeVHa6erMVWCy/7SHVQuGoxh7gT2noeraxJINWDZeXhov0MJht89FL
         zswvRhMjGVRye8PZ9A5E/ugamvVbtCNGUW+n11pjSGBZxpokT45LmCQNOq9QpxbIy3sk
         sAfniNO6T3kuMl8rIe1vbjEN3bDlFiBbEP0u0RJKskg2V7TcasV+2BUUw+My30miRn2r
         GDEQ==
X-Gm-Message-State: AOAM533m1NXndMeZr5onwT+45M1/u+asMml/sp6IJIfZSLaunfdEZmNW
        h00icSVZKXDGcS++ncBxSYYPFeb6umPRe2c1rLqTRPq0sR4=
X-Google-Smtp-Source: ABdhPJwzJ18nIb9CFGWOZXqnnhIpkheJxhLsRxBG2Swn+aTF/egHC9UeiPL1EBRCr0I46/QeQBws2zY1nIgzjve7zCM=
X-Received: by 2002:ac8:72c6:: with SMTP id o6mr22455766qtp.259.1613559181010;
 Wed, 17 Feb 2021 02:53:01 -0800 (PST)
MIME-Version: 1.0
References: <5e341bd2e900b2ba6e42109ca20e2ababc6f0873.1613508208.git.josef@toxicpanda.com>
In-Reply-To: <5e341bd2e900b2ba6e42109ca20e2ababc6f0873.1613508208.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 17 Feb 2021 10:52:50 +0000
Message-ID: <CAL3q7H6E08sTRDUcGpYAqb9=HEKub2Sit2p-U0nhDH_d7qmcng@mail.gmail.com>
Subject: Re: [PATCH] fstests: test a regression with btrfs extent reference collisions
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 16, 2021 at 8:45 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> This is a regression test for a problem where we would flip read only if
> we reflink'ed enough extents to generate key'ed references, and then got
> a hash collision with those references.  This is a test for the fix
>
>         btrfs: do not error out if the extent ref hash doesn't match
>
> and is relatively straightforward, simply generate such a file and
> watch for fireworks.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  tests/btrfs/231     | 81 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/231.out | 11 ++++++
>  tests/btrfs/group   |  1 +
>  3 files changed, 93 insertions(+)
>  create mode 100755 tests/btrfs/231
>  create mode 100644 tests/btrfs/231.out
>
> diff --git a/tests/btrfs/231 b/tests/btrfs/231
> new file mode 100755
> index 00000000..b4787f9f
> --- /dev/null
> +++ b/tests/btrfs/231
> @@ -0,0 +1,81 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Josef Bacik.  All Rights Reserved.
> +#
> +# FS QA Test 231
> +#
> +# This is a regression test for a problem fixed by
> +#
> +#    btrfs: do not error out if the extent ref hash doesn't match
> +#
> +# Simply generate a file with a lot of extent references, then reflink i=
n a few
> +# offsets that will generate hash collisions, sync and validate we can s=
till
> +# write to the file system.
> +
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
> +. ./common/reflink
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_test
> +_require_scratch_reflink
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +FILE=3D$SCRATCH_MNT/file
> +
> +# Create a 1m extent to reflink
> +$XFS_IO_PROG -f -c "pwrite 0 1M" -c "fsync" $FILE | _filter_xfs_io
> +
> +# Generate a bunch of extent references so we're forced to use key'ed ex=
tent
> +# references.
> +offset=3D2
> +for i in {0..10000}

100 iterations is more than enough to reproduce the bug, and reduces
the test runtime from about 50 seconds down to 3 seconds here.
Even 50 iterations is enough.

> +do
> +       $XFS_IO_PROG -c "reflink ${FILE} 0 ${offset}M 1M" $FILE \
> +               > /dev/null 2>&1

We can remove 2>&1, so we end up failing if for some unexpected reason
a reflink fails.
Might help one day uncover some bug.

> +       offset=3D$(( offset + 2 ))
> +done
> +
> +# Our key is
> +#
> +# key.objectid =3D bytenr
> +# key.type =3D BTRFS_EXTENT_DATA_REF_KEY
> +# key.offset =3D hash(tree, inode, offset)
> +#
> +# The tree id is 5, the inode is 257, and the reflink'ed offset is 0, th=
e below
> +# offsets generate a hash collision with that offset.  We only need two =
to
> +# collide, but if it's worth doing it's worth overdoing.
> +$XFS_IO_PROG -c "reflink ${FILE} 0 17999258914816 1M" $FILE | _filter_xf=
s_io
> +$XFS_IO_PROG -c "reflink ${FILE} 0 35998517829632 1M" $FILE | _filter_xf=
s_io
> +$XFS_IO_PROG -c "reflink ${FILE} 0 53752752058368 1M" $FILE | _filter_xf=
s_io
> +
> +# Sync to make sure this works, it'll error out if we abort the transact=
ion, but
> +# write a file just to make sure
> +$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
> +$XFS_IO_PROG -f -c "pwrite 0 1M" $SCRATCH_MNT/write | _filter_xfs_io
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/231.out b/tests/btrfs/231.out
> new file mode 100644
> index 00000000..f52c71ac
> --- /dev/null
> +++ b/tests/btrfs/231.out
> @@ -0,0 +1,11 @@
> +QA output created by 231
> +wrote 1048576/1048576 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +linked 1048576/1048576 bytes at offset 17999258914816
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +linked 1048576/1048576 bytes at offset 35998517829632
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +linked 1048576/1048576 bytes at offset 53752752058368
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 1048576/1048576 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index a7c65983..65cedf7f 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -233,3 +233,4 @@
>  228 auto quick volume
>  229 auto quick send clone
>  230 auto quick qgroup limit
> +231 auto

We can also have it in the group "clone", and with 100 or 50
iterations the 'quick' group as well.

Other than that it looks good.

Thanks.

> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
