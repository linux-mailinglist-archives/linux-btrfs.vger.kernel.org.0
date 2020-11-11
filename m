Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556F12AF3D1
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 15:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgKKOjZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Nov 2020 09:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbgKKOjM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Nov 2020 09:39:12 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E4EC0613D1;
        Wed, 11 Nov 2020 06:39:10 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q22so1816207qkq.6;
        Wed, 11 Nov 2020 06:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=6TO9CfEqolHgUK2uesIaCOjRkBORiDuRu6CLeyBpUkI=;
        b=bfHUfrgfcYFp7YXoku/PZZtJFZp2Y9K4Kdl/8+KLbxv4blzcrV6lIVhrdnn5s3HEyv
         IJj98qa+4QyoLeA9M3+tUia0CwMpN8lZv+0RwwMSWZnW+PnaJPieOX7/sDdPyJGE/cRw
         fipnT+1hU+/lsH4WjvesCu+7/9NlXp0S2U07IZa1xtSf7JOp3+7Xj2rpKTXiVaxSz7wq
         kuNbck2JFf908J3Va4MKzdgbGVmvj9ytBs5HVAL3tETT7Aor6pphQb73NPSg8bK0QqT8
         6We+C865PPTlgBSC08sM3TJurG8bRA+GjDib1h4mzv1LiYdwr9BRfbBvCg+hkAo/fOrn
         hhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=6TO9CfEqolHgUK2uesIaCOjRkBORiDuRu6CLeyBpUkI=;
        b=IPNzFfuHJja6CLfjVP6kZR6k486dOvCk47DM/MEySqlNzAtgTwy6xjo6AXNTOxtn4K
         kDTcgCCsKpKxHoxCdgfGIV+GGAbet7f5XP/pCioyk2DRL4nZ3nCZL3y0A93IcepU0yOS
         HkGc17fb/HFoEqIboq6jK4EkYl0lpPxbfTlTyU0TCKVp0gZ6r5YnVoPrI5gek+/n8u0A
         R0F29u37FT1I7XRYZBAsOECc5KWm9hKwEyz87ChnMdSW4e+sxNMfq/+dZI57dqBK7hUE
         KQz9DQ4xYFP5XUFL5eFArdzkfAxXGsHdmajAXeDxWtxI8gdPTfrYmLEMCEdVchteLoKJ
         KkNQ==
X-Gm-Message-State: AOAM5337Bn4Cb5Q9y463z/w1HJqA+g5asG7hITE1oZvyFKrrlAAe3gDj
        f2+ClbezrhM82EJHvGO4fglfMjpGTElE30B895s=
X-Google-Smtp-Source: ABdhPJyA23VHWL+Me7X31XiTXozUuVou2x/xFE7R4zfcYLL70XhPGtYPhTIHorYQ979T7XYCMXNUdD+4Hb8pauR/g4A=
X-Received: by 2002:a05:620a:1426:: with SMTP id k6mr25657441qkj.438.1605105550144;
 Wed, 11 Nov 2020 06:39:10 -0800 (PST)
MIME-Version: 1.0
References: <20201111113152.136729-1-wqu@suse.com>
In-Reply-To: <20201111113152.136729-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 11 Nov 2020 14:38:58 +0000
Message-ID: <CAL3q7H5W6U4jYGBszQF59RLi-aehO9vBTNU_HMTi8hRfK7gjGg@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: check qgroup doesn't crash when beyond limit
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 11, 2020 at 11:32 AM Qu Wenruo <wqu@suse.com> wrote:
>
> There is a bug that, when btrfs is beyond qgroup limit, touching a file
> could crash btrfs.
>
> Such beyond limit situation needs to be intentionally created, e.g.
> writing 1GiB file, then limit the subvolume to 512 MiB.
> As current qgroup works pretty well at preventing us from reaching the
> limit.
>
> This makes existing qgroup test cases unable to detect it.
>
> The regression is introduced by commit c53e9653605d ("btrfs: qgroup: try
> to flush qgroup space when we get -EDQUOT"), and the fix is titled
> "btrfs: qgroup: don't commit transaction when we have already
>  hold a transaction handler"
>
> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1178634
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, just one comment below.

> ---
>  tests/btrfs/154     | 62 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/154.out |  2 ++
>  tests/btrfs/group   |  1 +
>  3 files changed, 65 insertions(+)
>  create mode 100755 tests/btrfs/154
>  create mode 100644 tests/btrfs/154.out
>
> diff --git a/tests/btrfs/154 b/tests/btrfs/154
> new file mode 100755
> index 00000000..2a65d182
> --- /dev/null
> +++ b/tests/btrfs/154
> @@ -0,0 +1,62 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 154
> +#
> +# Test if btrfs qgroup would crash if we're modifying the fs
> +# after exceeding the limit
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
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +
> +# Need at least 2GiB
> +_require_scratch_size $((2 * 1024 * 1024))
> +_scratch_mkfs > /dev/null 2>&1
> +
> +_scratch_mount
> +
> +_pwrite_byte 0xcd 0 1G $SCRATCH_MNT/file >> $seqres.full
> +
> +# Make sure the data reach disk so later qgroup scan can see it
> +sync
> +
> +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> +$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
> +
> +# Set the limit to just 512MiB, which is way below the existing usage
> +$BTRFS_UTIL_PROG qgroup limit  512M $SCRATCH_MNT $SCRATCH_MNT

$SCRATCH_MNT twice by mistake, though the command still works and the
test still reproduces the issue.

Eryu can probably remove one occurrence when picking this patch.

Thanks.

> +
> +# Touch above file, if kernel not patched, it will trigger an ASSERT()
> +#
> +# Even for patched kernel, we will still get EDQUOT error, but that
> +# is expected behavior.
> +touch $SCRATCH_MNT/file 2>&1 | _filter_scratch
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/154.out b/tests/btrfs/154.out
> new file mode 100644
> index 00000000..b526c3f3
> --- /dev/null
> +++ b/tests/btrfs/154.out
> @@ -0,0 +1,2 @@
> +QA output created by 154
> +touch: setting times of 'SCRATCH_MNT/file': Disk quota exceeded
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index d18450c7..c491e339 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -156,6 +156,7 @@
>  151 auto quick volume
>  152 auto quick metadata qgroup send
>  153 auto quick qgroup limit
> +154 auto quick qgroup limit
>  155 auto quick send
>  156 auto quick trim balance
>  157 auto quick raid
> --
> 2.28.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
