Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAC428F622
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Oct 2020 17:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389861AbgJOPuO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Oct 2020 11:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389860AbgJOPuN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Oct 2020 11:50:13 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4839DC061755;
        Thu, 15 Oct 2020 08:50:12 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id h140so2691057qke.7;
        Thu, 15 Oct 2020 08:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=rEbjske5mDlNieltAoCJbb+TMr09wUzshU8wqhJozBM=;
        b=BH10G57vzbt2BRHjUitflSSLc9QcTptJ3/+Sbznc7Q3pb1FSyfxHIIZElUKR0ZfWB6
         7N27VaMvDSGUL31GiEKtBzC4WHAEHmhnbAMIiqPVBpDMse5/9hs3VVbdGkTJPfLY16Li
         83/ZivaYfHdxUFoXEeumuK/ltJuAe1Je39SbQxCARhs5wUoSazrttwl39uuiW/EkQMz2
         iqjVdFNxNOC34nTSU5kV4k84qJOI1GFw7Yo+j7SWpJ0Kx1hP1niap6vZzXboSq+bujqN
         IyZb94R5hBHBZlhqL37/l88J1+Xbk1vGl625UCqCaVI3L9OdkZkupNwkGBA7LD8xlVLz
         EgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=rEbjske5mDlNieltAoCJbb+TMr09wUzshU8wqhJozBM=;
        b=sFpV8OQKhNtHFRoWS/cq68sE9qgOLuNHMWkH76DP0C+QvFLY2DIMaRZ+iTBDeWl1Vm
         aO1kE7OQASPblzyQcEMjYGFHYbBF8J4Two6A6SIzCpvHlGrhyAvb41OaPf146ojNDOXx
         M3bdtUPnYELbNtG8llMSXQfbpH9Pyv3KqGnDUKJwDmLHhmrTSSWd2Qy0T8FgUTmfQ2ZK
         GPfxDOcv6QbU6gH4Em2gPr98YZvky1se9N/IM/rapXux38s/p6Nrou71piDF2ar2Z0Ge
         dxGg24seuKJTkkKmX2x9WD7n27oBOqIfsiIvSXPniDpaPcb02D+yCwXhzL5mZY6+DO5O
         7LhA==
X-Gm-Message-State: AOAM532/5YN2Twtxf4ANTLyIODGI8ubriZo/GGwJxpdI+nhmHz7AUmuk
        q5fuPfMIoh7SkOXTOhUo/ZCpBMzxh7wvTm7vOYw=
X-Google-Smtp-Source: ABdhPJy2O2+MrGrQHX5lSX9G513JkGpNbh60nXpwD78ay80bSoGDbN7JaFBhHwbY6rR6tsPSEm9z3dSnw2lGIkFlKdI=
X-Received: by 2002:a37:a202:: with SMTP id l2mr4561971qke.0.1602777011474;
 Thu, 15 Oct 2020 08:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599233551.git.anand.jain@oracle.com> <2378cbf0ec6f649de7269a756b652f0b7a6619b3.1599233551.git.anand.jain@oracle.com>
In-Reply-To: <2378cbf0ec6f649de7269a756b652f0b7a6619b3.1599233551.git.anand.jain@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 15 Oct 2020 16:49:59 +0100
Message-ID: <CAL3q7H5kmY5pGqXpWF6gycVOuf-9GqtWXgqJrDPcDGe=0W=Jaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs/163: replace sprout instead of seed
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 5, 2020 at 12:25 AM Anand Jain <anand.jain@oracle.com> wrote:
>
> Make this test case inline with the kernel patch [1] changes
> [1] btrfs: fix replace of seed device

Same comment as in the previous patch. Now that this is in Linus'
tree, it would be good to mention the commit id too.
>
> So use the sprout device as the replace target instead of the seed device=
.
> This change is compatible with the older kernels.
>
> While at this, this patch also fixes a typo fix as well.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/163     | 21 ++++++++++++++++-----
>  tests/btrfs/163.out |  5 ++++-
>  2 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/tests/btrfs/163 b/tests/btrfs/163
> index 24c725afb6b9..354d88502d47 100755
> --- a/tests/btrfs/163
> +++ b/tests/btrfs/163
> @@ -4,11 +4,15 @@
>  #
>  # FS QA Test 163
>  #
> -# Test case to verify that a seed device can be replaced
> +# Test case to verify that a sprouted device can be replaced
>  #  Create a seed device
>  #  Create a sprout device
>  #  Remount RW
> -#  Run device replace on the seed device
> +#  Run device replace on the sprout device
> +#
> +# Depends on the kernel patch
> +#   btrfs: fail replace of seed device
> +
>  seq=3D`basename $0`
>  seqres=3D$RESULT_DIR/$seq
>  echo "QA output created by $seq"
> @@ -39,6 +43,7 @@ _supported_fs btrfs
>  _supported_os Linux
>  _require_command "$BTRFS_TUNE_PROG" btrfstune
>  _require_scratch_dev_pool 3
> +_require_btrfs_forget_or_module_loadable
>
>  _scratch_dev_pool_get 3
>
> @@ -52,7 +57,7 @@ create_seed()
>         run_check _mount $dev_seed $SCRATCH_MNT
>         $XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 4M" $SCRATCH_MNT/foobar >=
\
>                 /dev/null
> -       echo -- gloden --
> +       echo -- golden --
>         od -x $SCRATCH_MNT/foobar
>         _run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
>         _scratch_unmount
> @@ -64,22 +69,28 @@ add_sprout()
>  {
>         _run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT
>         _run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
> +       _mount -o remount,rw $dev_sprout $SCRATCH_MNT
> +       $XFS_IO_PROG -f -d -c "pwrite -S 0xcd 0 4M" $SCRATCH_MNT/foobar2 =
>\
> +               /dev/null

Same comment as for the other patch.
Why the direct IO? The test passes with buffered IO as well.
If there's a reason for direct IO, it should be mentioned in a comment
and _require_odirect added above.

>  }
>
>  replace_seed()
>  {
> -       _run_btrfs_util_prog replace start -fB $dev_seed $dev_replace_tgt=
 $SCRATCH_MNT
> +       _run_btrfs_util_prog replace start -fB $dev_sprout $dev_replace_t=
gt $SCRATCH_MNT

So now the function should be renamed from replace_seed() to
replace_sprout() as well. Shouldn't it?

Other than that, it looks good and it works as expected.

Thanks.

>         _run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
>         _scratch_unmount
> -       run_check _mount $dev_replace_tgt $SCRATCH_MNT
> +       _btrfs_forget_or_module_reload
> +       run_check _mount -o device=3D$dev_seed $dev_replace_tgt $SCRATCH_=
MNT
>         echo -- sprout --
>         od -x $SCRATCH_MNT/foobar
> +       od -x $SCRATCH_MNT/foobar2
>         _scratch_unmount
>
>  }
>
>  seed_is_mountable()
>  {
> +       _btrfs_forget_or_module_reload
>         run_check _mount $dev_seed $SCRATCH_MNT
>         _run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
>         _scratch_unmount
> diff --git a/tests/btrfs/163.out b/tests/btrfs/163.out
> index 91f6f5b6f48a..351ef7b040b2 100644
> --- a/tests/btrfs/163.out
> +++ b/tests/btrfs/163.out
> @@ -1,5 +1,5 @@
>  QA output created by 163
> --- gloden --
> +-- golden --
>  0000000 abab abab abab abab abab abab abab abab
>  *
>  20000000
> @@ -7,3 +7,6 @@ QA output created by 163
>  0000000 abab abab abab abab abab abab abab abab
>  *
>  20000000
> +0000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
> +*
> +20000000
> --
> 2.25.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
