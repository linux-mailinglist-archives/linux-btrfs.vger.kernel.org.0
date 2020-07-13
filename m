Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5DF21D364
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 12:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgGMKFs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 06:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgGMKFr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 06:05:47 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ED8C061755;
        Mon, 13 Jul 2020 03:05:47 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id p25so6285249vsg.4;
        Mon, 13 Jul 2020 03:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=uM0JEojwXbAlEJNPSKkc7/3UJ+yzCSSyEbyYoF7Mg7Q=;
        b=KrFiHAKYP6pq0Mx2C6yoTy7osq4mRSi8mf0Hn6e0DNxGPizTuxQWihst3sdoQK4Bxq
         m9TuAlWTTQtEqvg0xCoaEVUY6751O9mk8g5hOStHVR8uzThg+hVI9FOeYjIHlrd5LMde
         n0qgGdPy5KydEKAqrQy25P0cD01Q9X+T3G2C76wQUB5CK4oRBHdS2oJCxWmrilLfBqru
         pmJvoDgWK4/2c29MG6NokIiz42ts1hFs2NlB8sp8aROaurs5pN19o5rC7cNcfe1w5NjP
         82R64iFxYpwicsUS0RHpXvl474XZRujE+8LEyM7b0zF9QdgpyuH8m9tTfsfA1m/rf5a5
         92+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=uM0JEojwXbAlEJNPSKkc7/3UJ+yzCSSyEbyYoF7Mg7Q=;
        b=F9O11kqDQqDocXSONJobuT+gGatjgCn/26oZnSLItR/42kLZudxcJwa0qynd2mR9fP
         LPF6pS/AMHF38QOC4czm0n8gc9J3UKf9a0scCyThVS3BBpzg5xSa6b3+xN72AZ9L3rTD
         Uo5xbZpnjEld0tfHBTyuzzYvuve4zTpsI9fWnk9MIrqXKSrIaY3sjIkQnYxMrdt8C+5c
         bcQxOmsDUsK+khmlpMX/in9yCpHf9o9iXIrcC2F6fGpj4b6897QFJpYzmxP4yumSwl+H
         No690mjNRM6/9crWdaNX4YiCh799Smk4bLmHebbZEmUGDWw9EDsnQGwQx9dQu4xwIwqV
         RM0g==
X-Gm-Message-State: AOAM531DEmCoeqDEg0SjXm2BiJGSWRZw05t5l1PFFQYFGLa6clUt+pqY
        mMn1EZYhDFoGR6W1Zl/7vA5assDHLxs4SnCqPmPc3BJt
X-Google-Smtp-Source: ABdhPJxJq2zPWq6lBSgWiylvDu01IjIVa94nhxRvJhiiBqn1Z1sPuAEPsg0POuOuq8TFI0c1Pkb//5Vi7X5JAiqsOtM=
X-Received: by 2002:a67:7241:: with SMTP id n62mr5007710vsc.206.1594634746554;
 Mon, 13 Jul 2020 03:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200710185519.10322-1-marcos@mpdesouza.com>
In-Reply-To: <20200710185519.10322-1-marcos@mpdesouza.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 13 Jul 2020 11:05:35 +0100
Message-ID: <CAL3q7H4PswiXqS_Zy+w58Oj8cv6iBHj-LYDN4-EmU-Q5PAEubA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Ignore output of "btrfs quota rescan"
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 10, 2020 at 7:57 PM Marcos Paulo de Souza
<marcos@mpdesouza.com> wrote:
>
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>
> Some recent test already ignore this output, while older ones do not.
> It can sometimes make tests fail because "quota rescan" can show the
> message "quota rescan started". Ignoring the output of the command
> solves this problem.


Hi Marcos,

Can you elaborate exactly how it fails?
I've never seen those tests fail due to an unexpected "quota rescan
started" message.

I also don't see how this change fixes anything, because:

1) The quota rescans are always executed - so we should always see such fai=
lure;

2) More importantly _run_btrfs_util_prog is:

_run_btrfs_util_prog()
{
   run_check $BTRFS_UTIL_PROG $*
}

and run_check:

run_check()
{
   echo "# $@" >> $seqres.full 2>&1
   "$@" >> $seqres.full 2>&1 || _fail "failed: '$@'"
}

So any output from _run_btrfs_util_prog is redirected to the test's .full f=
ile.
It will not cause a mismatch with the golden output.


>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  tests/btrfs/017 | 2 +-
>  tests/btrfs/022 | 4 ++--
>  tests/btrfs/028 | 2 +-
>  tests/btrfs/057 | 2 +-
>  tests/btrfs/091 | 2 +-
>  tests/btrfs/104 | 2 +-
>  tests/btrfs/123 | 2 +-
>  tests/btrfs/126 | 2 +-
>  tests/btrfs/139 | 2 +-
>  tests/btrfs/153 | 2 +-
>  tests/btrfs/193 | 2 +-
>  tests/btrfs/210 | 2 +-
>  12 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/tests/btrfs/017 b/tests/btrfs/017
> index 1bb8295b..a888b8db 100755
> --- a/tests/btrfs/017
> +++ b/tests/btrfs/017
> @@ -64,7 +64,7 @@ $CLONER_PROG -s 0 -d 0 -l $EXTENT_SIZE $SCRATCH_MNT/foo=
 \
>              $SCRATCH_MNT/snap/foo-reflink2
>
>  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null

So this is pointless, as mentioned before, any output is already
redirected to the test's .full file.
The same applies to all changes below.

So I fail to see what problem you are trying to solve.

Thanks.

>
>  rm -fr $SCRATCH_MNT/foo*
>  rm -fr $SCRATCH_MNT/snap/foo*
> diff --git a/tests/btrfs/022 b/tests/btrfs/022
> index aaa27aaa..442cc05c 100755
> --- a/tests/btrfs/022
> +++ b/tests/btrfs/022
> @@ -38,7 +38,7 @@ _basic_test()
>         echo "=3D=3D=3D basic test =3D=3D=3D" >> $seqres.full
>         _run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
>         _run_btrfs_util_prog quota enable $SCRATCH_MNT/a
> -       _run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> +       _run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
>         subvolid=3D$(_btrfs_get_subvolid $SCRATCH_MNT a)
>         $BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid=
 >> \
>                 $seqres.full 2>&1
> @@ -77,7 +77,7 @@ _rescan_test()
>         echo "qgroup values before rescan: $output" >> $seqres.full
>         refer=3D$(echo $output | awk '{ print $2 }')
>         excl=3D$(echo $output | awk '{ print $3 }')
> -       _run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> +       _run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
>         output=3D$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | gre=
p "0/$subvolid")
>         echo "qgroup values after rescan: $output" >> $seqres.full
>         [ $refer -eq $(echo $output | awk '{ print $2 }') ] || \
> diff --git a/tests/btrfs/028 b/tests/btrfs/028
> index 98b9c8b9..4a574b8b 100755
> --- a/tests/btrfs/028
> +++ b/tests/btrfs/028
> @@ -42,7 +42,7 @@ _scratch_mkfs >/dev/null
>  _scratch_mount
>
>  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
>
>  # Increase the probability of generating de-refer extent, and decrease
>  # other.
> diff --git a/tests/btrfs/057 b/tests/btrfs/057
> index 82e3162e..aa1d429c 100755
> --- a/tests/btrfs/057
> +++ b/tests/btrfs/057
> @@ -47,7 +47,7 @@ run_check $FSSTRESS_PROG -d $SCRATCH_MNT/snap1 -w -p 5 =
-n 1000 \
>         $FSSTRESS_AVOID >&/dev/null
>
>  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
>
>  echo "Silence is golden"
>  # btrfs check will detect any qgroup number mismatch.
> diff --git a/tests/btrfs/091 b/tests/btrfs/091
> index 6d2a23c8..a4aeebc3 100755
> --- a/tests/btrfs/091
> +++ b/tests/btrfs/091
> @@ -59,7 +59,7 @@ _run_btrfs_util_prog subvolume create $SCRATCH_MNT/subv=
2
>  _run_btrfs_util_prog subvolume create $SCRATCH_MNT/subv3
>
>  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
>
>  # if we don't support noinode_cache mount option, then we should double =
check
>  # whether inode cache is enabled before executing the real test payload.
> diff --git a/tests/btrfs/104 b/tests/btrfs/104
> index f0cc67d6..d3338e35 100755
> --- a/tests/btrfs/104
> +++ b/tests/btrfs/104
> @@ -113,7 +113,7 @@ _explode_fs_tree 1 $SCRATCH_MNT/snap2/files-snap2
>  # Enable qgroups now that we have our filesystem prepared. This
>  # will kick off a scan which we will have to wait for.
>  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
>
>  # Remount to clear cache, force everything to disk
>  _scratch_cycle_mount
> diff --git a/tests/btrfs/123 b/tests/btrfs/123
> index 65177159..63b6d428 100755
> --- a/tests/btrfs/123
> +++ b/tests/btrfs/123
> @@ -56,7 +56,7 @@ sync
>
>  # enable quota and rescan to get correct number
>  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
>
>  # now balance data block groups to corrupt qgroup
>  _run_btrfs_balance_start -d $SCRATCH_MNT >> $seqres.full
> diff --git a/tests/btrfs/126 b/tests/btrfs/126
> index 8635791e..eceaabb2 100755
> --- a/tests/btrfs/126
> +++ b/tests/btrfs/126
> @@ -41,7 +41,7 @@ _scratch_mkfs >/dev/null
>  _scratch_mount "-o enospc_debug"
>
>  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
>  _run_btrfs_util_prog qgroup limit 512K 0/5 $SCRATCH_MNT
>
>  # The amount of written data may change due to different nodesize at mkf=
s time,
> diff --git a/tests/btrfs/139 b/tests/btrfs/139
> index 1b636e81..44168e2a 100755
> --- a/tests/btrfs/139
> +++ b/tests/btrfs/139
> @@ -43,7 +43,7 @@ SUBVOL=3D$SCRATCH_MNT/subvol
>
>  _run_btrfs_util_prog subvolume create $SUBVOL
>  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
>  _run_btrfs_util_prog qgroup limit -e 1G $SUBVOL
>
>
> diff --git a/tests/btrfs/153 b/tests/btrfs/153
> index f343da32..1f8e37e7 100755
> --- a/tests/btrfs/153
> +++ b/tests/btrfs/153
> @@ -41,7 +41,7 @@ _scratch_mkfs >/dev/null
>  _scratch_mount
>
>  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
>  _run_btrfs_util_prog qgroup limit 100M 0/5 $SCRATCH_MNT
>
>  testfile1=3D$SCRATCH_MNT/testfile1
> diff --git a/tests/btrfs/193 b/tests/btrfs/193
> index 16b7650c..8bdc7566 100755
> --- a/tests/btrfs/193
> +++ b/tests/btrfs/193
> @@ -43,7 +43,7 @@ _scratch_mkfs > /dev/null
>  _scratch_mount
>
>  $BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" > /dev/null
> -$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
> +$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" >/dev/null
>  $BTRFS_UTIL_PROG qgroup limit -e 256M "$SCRATCH_MNT"
>
>  # Create a file with the following layout:
> diff --git a/tests/btrfs/210 b/tests/btrfs/210
> index daa76a87..a9a04951 100755
> --- a/tests/btrfs/210
> +++ b/tests/btrfs/210
> @@ -46,7 +46,7 @@ _pwrite_byte 0xcd 0 16M "$SCRATCH_MNT/src/file" > /dev/=
null
>  # by qgroup
>  sync
>  $BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT"
> -$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT"
> +$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" >/dev/null
>  $BTRFS_UTIL_PROG qgroup create 1/0 "$SCRATCH_MNT"
>
>  # Create a snapshot with qgroup inherit
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
