Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E660293C45
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Oct 2020 14:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406700AbgJTMxd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Oct 2020 08:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406565AbgJTMxd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Oct 2020 08:53:33 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F62AC061755;
        Tue, 20 Oct 2020 05:53:33 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id h140so1430407qke.7;
        Tue, 20 Oct 2020 05:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=PSqQCZvVnrt86jZHSpXMAumyD51djaC26USXOGg0YZ8=;
        b=fJfEisqlNaWE808nrM5cQb5e2L9HE7Vm4mYQgS/P61MU7DEmQregw9tbMI4n426gLJ
         qtIKdl+hzMeLEz/1ezPDtMGo7neoyWDgU45D1dIYu1SRNUK/nyymDZjMn0id8aa9ZsUS
         6gYbIuE5zuKKVpU7Z6E50/CllsIPbAgpGG7TpCErBhHZ+2i6HcZnopOtLngngCIJeTtc
         DDZ6tKrPjWom8tRjcNorDE21/QLdItGi1act/jo/4h2i87ZU1rX8dEq+F9y/MJ1CcJOW
         pp0yZleM+PHwsxk85SjOhpRCqnuA2Lz6d2hXkNBuHcsMOMlvIFt1tHjkk4S0ai08hV1/
         IC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=PSqQCZvVnrt86jZHSpXMAumyD51djaC26USXOGg0YZ8=;
        b=Fo+65YNq1ryrkJju3A5P8/XlcOpILddzZJhNF2x3ijihOudH4mloJ3U29qGB4HzQR+
         KeqX4cy23pzfBnxYXfZ01n3s5PlkvM5cO4W2xxbJDrXcEqIXqhPJ5Vw/SDukqxST5oNG
         /b48Vez7RcZBztRW9UCWEmP7o1rxHhwymHQ94AwbSsEqH/ooUvl5deNQ4aUeekOmQL+S
         QBEGk+raTYH5OfsL8OHc5ZwQTAeeg4N6GYlPTBtGrg34SneXh81P2J6MtYOi6j2LTkVx
         GTt/HZKFEa3yA5H1P72kKyrrweJtmreGMlhE4sCOEINs6as0abSYgxc3aeNePdMJeAfu
         Yiwg==
X-Gm-Message-State: AOAM533B+g/U+wW1gl5wQaXuu145jpb6sWq+wZjAU/cjY1bh3aif6HFK
        fm9g6F7Hg/NGOOEE/d6H66WYBnzMp/4yRwrK+b3RzMq9o4rrpQ==
X-Google-Smtp-Source: ABdhPJz8hhhyPCBW9cLW6oCHFe3UAEvrUMqFaHl+dlG4EOZ/NcP9mmHhNa1q8Mwa4on9S4RXPLRgm77eLlbi8hnUq+w=
X-Received: by 2002:a37:9cd3:: with SMTP id f202mr2474771qke.479.1603198412295;
 Tue, 20 Oct 2020 05:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603196609.git.anand.jain@oracle.com> <da8894afef8f5186ee2876c6a3cff32bd28e8cb6.1603196609.git.anand.jain@oracle.com>
In-Reply-To: <da8894afef8f5186ee2876c6a3cff32bd28e8cb6.1603196609.git.anand.jain@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 20 Oct 2020 13:53:21 +0100
Message-ID: <CAL3q7H5Lw8Ho99MrkwEP_UQ+GkfQBc8tGkUGxijKOHw7f7GLXg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] btrfs/163: replace sprout instead of seed
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 20, 2020 at 1:34 PM Anand Jain <anand.jain@oracle.com> wrote:
>
> Make this test case inline with the kernel patch [1] changes
> [1] c6a5d954950c btrfs: fix replace of seed device
>
> So use the sprout device as the replace target instead of the seed device=
.
> This change is compatible with the older kernels.
>
> While at this, this patch also fixes a typo fix as well.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> v3:
>   add kernel commit id in the change log and in the header.
>   remove directio in xfs_io.
>   rename replace_seed() to replace_sprout().
>
> v2:
>   none
>
>  tests/btrfs/163     | 25 ++++++++++++++++++-------
>  tests/btrfs/163.out |  5 ++++-
>  2 files changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/tests/btrfs/163 b/tests/btrfs/163
> index 3047862f9e15..735881c6936e 100755
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
> +#   c6a5d954950c btrfs: fail replace of seed device
> +
>  seq=3D`basename $0`
>  seqres=3D$RESULT_DIR/$seq
>  echo "QA output created by $seq"
> @@ -38,6 +42,7 @@ rm -f $seqres.full
>  _supported_fs btrfs
>  _require_command "$BTRFS_TUNE_PROG" btrfstune
>  _require_scratch_dev_pool 3
> +_require_btrfs_forget_or_module_loadable
>
>  _scratch_dev_pool_get 3
>
> @@ -51,7 +56,7 @@ create_seed()
>         run_check _mount $dev_seed $SCRATCH_MNT
>         $XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 4M" $SCRATCH_MNT/foobar >=
\
>                 /dev/null
> -       echo -- gloden --
> +       echo -- golden --
>         od -x $SCRATCH_MNT/foobar
>         _run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
>         _scratch_unmount
> @@ -63,22 +68,28 @@ add_sprout()
>  {
>         _run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT
>         _run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
> +       _mount -o remount,rw $dev_sprout $SCRATCH_MNT
> +       $XFS_IO_PROG -f -c "pwrite -S 0xcd 0 4M" $SCRATCH_MNT/foobar2 >\
> +               /dev/null
>  }
>
> -replace_seed()
> +replace_sprout()
>  {
> -       _run_btrfs_util_prog replace start -fB $dev_seed $dev_replace_tgt=
 $SCRATCH_MNT
> +       _run_btrfs_util_prog replace start -fB $dev_sprout $dev_replace_t=
gt $SCRATCH_MNT
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
> @@ -86,7 +97,7 @@ seed_is_mountable()
>
>  create_seed
>  add_sprout
> -replace_seed
> +replace_sprout
>
>  seed_is_mountable
>
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
