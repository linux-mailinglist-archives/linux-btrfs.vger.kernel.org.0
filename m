Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96CFB123391
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 18:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfLQRa7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 12:30:59 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39750 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfLQRa7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 12:30:59 -0500
Received: by mail-ua1-f66.google.com with SMTP id q22so3727770uam.6;
        Tue, 17 Dec 2019 09:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=L8iTG+jcGPw8hJXnkKlNo4739HD7wzF13X3OBsz+gQg=;
        b=unuIYiGHhZplJaLhCrV9zxICc0hIcAdigDTgPJ0MPsiEZBfCNHjM+YvQ6mMnHzkpeb
         fPJvaeuLt/BbWLkA2dQ9JYRBX/8dDfkqKfiynJyw2iibBxtIwXRj6QAXU3W7tdNc1CXD
         1gXCuaFG93WmX6W9GC1PO9T4RF23Ejd7gJeIKtaf+LgIf1MKnaNQYpAZoc1otvBXWT/3
         gii+bnudUjeusOiGJeqHIh90X35+evbosTzj7CD293PuYU12UCcWhp4OqxsUOYoMSGpd
         dU5W05igD6y+S+3+ptzuyu8Iym46ubZx0Hc6aFvvZBM63kFxeRmfbIDmGt6pRku5HSlm
         Qwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=L8iTG+jcGPw8hJXnkKlNo4739HD7wzF13X3OBsz+gQg=;
        b=jKTJY0p1xgW72egX8tMgyubPI4VoQPephHEHxFDon7oNfipe3YwhhbJvCufyUrST3e
         3k2mBxVABlLrk/VdLBBIh3TOAowDP95FGJZWB+2SOYsVdsUQUKQdNj9CCDTVBvMfIZTc
         EV+cj1HKlGFuTssMr/U2v35eaVYVGoP0PrvGhmm1wA6JEv5DEqvYgVbj3r8/CEruH7PT
         OXlFVKanTox8djt3eLrfT93h3Uv6nAW+8ngmgjAvt+zvbTJV04eraqwsvWBpTBOyt1X1
         U2QPdWQ/OEm8E1p+jxEivZZ8F160T2F43BkRjHP58Q64WF7Z/mDjkCPIHf2mtW25fxmZ
         Nc4w==
X-Gm-Message-State: APjAAAXhZv614PbnxwwklATDI3c8Uovpdf2Mg94MCaSAIQHe7DS1chWZ
        FVmL131N3fgwYU3oXV5VDkP4+My6fe/lYmdW7QSakbDf
X-Google-Smtp-Source: APXvYqz5HZtCwL9x9na+222PFQRoIAD1hGF41hyjKpRf3Ynzcdx6Q/LKqbGEp1kMRGVmjsHLGDC/Xtq11PR9ByzreSs=
X-Received: by 2002:ab0:4ac6:: with SMTP id t6mr4415842uae.0.1576603857209;
 Tue, 17 Dec 2019 09:30:57 -0800 (PST)
MIME-Version: 1.0
References: <20191211104029.25541-1-wqu@suse.com> <20191211104029.25541-3-wqu@suse.com>
In-Reply-To: <20191211104029.25541-3-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 17 Dec 2019 17:30:46 +0000
Message-ID: <CAL3q7H4g7evsO450gmKK-rfVmLiLrB+VvxbEKKfj+F94ERafbg@mail.gmail.com>
Subject: Re: [PATCH 2/3] fstests: btrfs/14[23]: Use proper help to get both
 devid and physical offset for corruption.
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 11, 2019 at 10:41 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> When using btrfs-progs v5.4, btrfs/142 and btrfs/143 will fail:
> btrfs/142 1s ... - output mismatch (see xfstests/results//btrfs/142.out.b=
ad)
>     --- tests/btrfs/142.out 2018-09-16 21:30:48.505104287 +0100
>     +++ xfstests/results//btrfs/142.out.bad
> 2019-12-10 15:35:40.280392626 +0000
>     @@ -3,37 +3,37 @@
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>      wrote 65536/65536 bytes
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa .........=
.......
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa .........=
.......
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa .........=
.......
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa .........=
.......
>     ...
>     (Run 'diff -u xfstests/tests/btrfs/142.out xfstests/results//btrfs/14=
2.out.bad' to see the entire diff)
>
> [CAUSE]
> Btrfs/14[23] test whether a read on corrupted stripe will re-silver
> itself.
> Such test by its nature will need to modify on-disk data, thus need to
> get the btrfs logical -> physical mapping, which is done by near
> hard-coded lookup function, which rely on certain stripe:devid sequence.
>
> Recent btrfs-progs commit c501c9e3b816 ("btrfs-progs: mkfs: match devid
> order to the stripe index") changes how we use devices in mkfs.btrfs,
> this caused a change in chunk layout, and break the hard-coded
> stripe:devid sequence.
>
> [FIX]
> This patch will do full devid and physical offset lookup, instead of old
> physical offset only lookup.
>
> The only assumption made is, mkfs.btrfs assigns devid sequentially for
> its devices.
> Which means, for "mkfs.btrfs $dev1 $dev2 $dev3", we get devid 1 for $dev1=
,
> devid 2 for $dev2, and so on.
>
> This change will allow btrfs/14[23] to handle even future chunk layout
> change. (Although I hope this will never happen again).
>
> This also addes extra debug output (although less than 10 lines) into
> $seqres.full, just in case when layout changes and current lookup can't
> handle it, developer can still pindown the problem easily.
>
> Reported-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/142     | 50 +++++++++++++++++++++++++++++++--------------
>  tests/btrfs/142.out |  2 --
>  tests/btrfs/143     | 48 +++++++++++++++++++++++++++++++------------
>  tests/btrfs/143.out |  2 --
>  4 files changed, 70 insertions(+), 32 deletions(-)
>
> diff --git a/tests/btrfs/142 b/tests/btrfs/142
> index a23fe1bf..9c037ff6 100755
> --- a/tests/btrfs/142
> +++ b/tests/btrfs/142
> @@ -47,30 +47,45 @@ _require_command "$FILEFRAG_PROG" filefrag
>
>  get_physical()
>  {
> -        # $1 is logical address
> -        # print chunk tree and find devid 2 which is $SCRATCH_DEV
> +       local logical=3D$1
> +       local stripe=3D$2
>          $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | =
\
> -       grep $1 -A 6 | awk '($1 ~ /stripe/ && $3 ~ /devid/ && $4 ~ /1/) {=
 print $6 }'
> +               grep $logical -A 6 | \
> +               awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/)=
 { print \$6 }"

Should use $AWK_PROG instead of direct call to 'awk'.

>  }
>
> +get_devid()
> +{
> +       local logical=3D$1
> +       local stripe=3D$2
> +        $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | =
\
> +               grep $logical -A 6 | \
> +               awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/)=
 { print \$4 }"

Same here.

> +}
>
> -SYSFS_BDEV=3D`_sysfs_dev $SCRATCH_DEV`
> +get_device_path()
> +{
> +       local devid=3D$1
> +       echo "$SCRATCH_DEV_POOL" | awk "{print \$$devid}"
> +}
>
>  start_fail()
>  {
> +       local sysfs_bdev=3D"$1"
>         echo 100 > $DEBUGFS_MNT/fail_make_request/probability
>         echo 2 > $DEBUGFS_MNT/fail_make_request/times
>         echo 1 > $DEBUGFS_MNT/fail_make_request/task-filter
>         echo 0 > $DEBUGFS_MNT/fail_make_request/verbose
> -       echo 1 > $SYSFS_BDEV/make-it-fail
> +       echo 1 > $sysfs_bdev/make-it-fail
>  }
>
>  stop_fail()
>  {
> +       local sysfs_bdev=3D"$1"
>         echo 0 > $DEBUGFS_MNT/fail_make_request/probability
>         echo 0 > $DEBUGFS_MNT/fail_make_request/times
>         echo 0 > $DEBUGFS_MNT/fail_make_request/task-filter
> -       echo 0 > $SYSFS_BDEV/make-it-fail
> +       echo 0 > $sysfs_bdev/make-it-fail
>  }
>
>  _scratch_dev_pool_get 2
> @@ -87,17 +102,23 @@ _scratch_mount -o nospace_cache,nodatasum
>  $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foob=
ar" |\
>         _filter_xfs_io_offset
>
> -# step 2, corrupt the first 64k of one copy (on SCRATCH_DEV which is the=
 first
> -# one in $SCRATCH_DEV_POOL
> +# step 2, corrupt the first 64k of stripe #1
>  echo "step 2......corrupt file extent" >>$seqres.full
>
>  ${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
>  logical_in_btrfs=3D`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_fi=
lefrag | cut -d '#' -f 1`
> -physical_on_scratch=3D`get_physical ${logical_in_btrfs}`
> +physical=3D`get_physical ${logical_in_btrfs} 1`
> +devid=3D$(get_devid ${logical_in_btrfs} 1)
> +target_dev=3D$(get_device_path $devid)
> +
> +SYSFS_BDEV=3D`_sysfs_dev $target_dev`
>
>  _scratch_unmount
> -$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical_on_scratch 64K" $SCR=
ATCH_DEV |\
> -       _filter_xfs_io_offset
> +$BTRFS_UTIL_PROG ins dump-tree -t 3 $SCRATCH_DEV | \
> +       grep $logical_in_btrfs -A 6 >> $seqres.full
> +echo "Corrupt stripe 1 devid $devid devpath $target_dev physical $physic=
al" \
> +       >> $seqres.full
> +$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $target_dev > /=
dev/null
>
>  _scratch_mount -o nospace_cache
>
> @@ -106,8 +127,7 @@ echo "step 3......repair the bad copy" >>$seqres.full
>
>  # since raid1 consists of two copies, and the bad copy was put on stripe=
 #1
>  # while the good copy lies on stripe #0, the bad copy only gets access w=
hen the
> -# reader's pid % 2 =3D=3D 1 is true
> -start_fail
> +start_fail $SYSFS_BDEV
>  while [[ -z ${result} ]]; do
>         # enable task-filter only fails the following dio read so the rep=
air is
>         # supposed to work.
> @@ -117,12 +137,12 @@ while [[ -z ${result} ]]; do
>                 exec $XFS_IO_PROG -d -c \"pread -b 128K 0 128K\" \"$SCRAT=
CH_MNT/foobar\"
>         fi");
>  done
> -stop_fail
> +stop_fail $SYSFS_BDEV
>
>  _scratch_unmount
>
>  # check if the repair works
> -$XFS_IO_PROG -c "pread -v -b 512 $physical_on_scratch 512" $SCRATCH_DEV =
|\
> +$XFS_IO_PROG -c "pread -v -b 512 $physical 512" $target_dev | \
>         _filter_xfs_io_offset
>
>  _scratch_dev_pool_put
> diff --git a/tests/btrfs/142.out b/tests/btrfs/142.out
> index 0f32ffbe..2e22f292 100644
> --- a/tests/btrfs/142.out
> +++ b/tests/btrfs/142.out
> @@ -1,8 +1,6 @@
>  QA output created by 142
>  wrote 131072/131072 bytes
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 65536/65536 bytes
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
>  XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
>  XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> diff --git a/tests/btrfs/143 b/tests/btrfs/143
> index 91af52f9..b2ffeb63 100755
> --- a/tests/btrfs/143
> +++ b/tests/btrfs/143
> @@ -54,30 +54,48 @@ _require_command "$FILEFRAG_PROG" filefrag
>
>  get_physical()
>  {
> -        # $1 is logical address
> -        # print chunk tree and find devid 2 which is $SCRATCH_DEV
> +       local logical=3D$1
> +       local stripe=3D$2
>          $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | =
\
> -       grep $1 -A 6 | awk '($1 ~ /stripe/ && $3 ~ /devid/ && $4 ~ /1/) {=
 print $6 }'
> +               grep $logical -A 6 | \
> +               awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/)=
 { print \$6 }"

Same here.

> +}
> +
> +get_devid()
> +{
> +       local logical=3D$1
> +       local stripe=3D$2
> +        $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | =
\
> +               grep $logical -A 6 | \
> +               awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/)=
 { print \$4 }"

Same here.

> +}
> +
> +get_device_path()
> +{
> +       local devid=3D$1
> +       echo "$SCRATCH_DEV_POOL" | awk "{print \$$devid}"
>  }
>
>  SYSFS_BDEV=3D`_sysfs_dev $SCRATCH_DEV`
>
>  start_fail()
>  {
> +       local sysfs_bdev=3D"$1"
>         echo 100 > $DEBUGFS_MNT/fail_make_request/probability
>         # the 1st one fails the first bio which is reading 4k (or more du=
e to
>         # readahead), and the 2nd one fails the retry of validation so th=
at it
>         # triggers read-repair
>         echo 2 > $DEBUGFS_MNT/fail_make_request/times
>         echo 0 > $DEBUGFS_MNT/fail_make_request/verbose
> -       echo 1 > $SYSFS_BDEV/make-it-fail
> +       echo 1 > $sysfs_bdev/make-it-fail
>  }
>
>  stop_fail()
>  {
> +       local sysfs_bdev=3D"$1"
>         echo 0 > $DEBUGFS_MNT/fail_make_request/probability
>         echo 0 > $DEBUGFS_MNT/fail_make_request/times
> -       echo 0 > $SYSFS_BDEV/make-it-fail
> +       echo 0 > $sysfs_bdev/make-it-fail
>  }
>
>  _scratch_dev_pool_get 2
> @@ -94,17 +112,21 @@ _scratch_mount -o nospace_cache,nodatasum
>  $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foob=
ar" |\
>         _filter_xfs_io_offset
>
> -# step 2, corrupt the first 64k of one copy (on SCRATCH_DEV which is the=
 first
> -# one in $SCRATCH_DEV_POOL
> +# step 2, corrupt the first 64k of stripe #1
>  echo "step 2......corrupt file extent" >>$seqres.full
>
>  ${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
>  logical_in_btrfs=3D`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_fi=
lefrag | cut -d '#' -f 1`
> -physical_on_scratch=3D`get_physical ${logical_in_btrfs}`
> +physical=3D`get_physical ${logical_in_btrfs} 1`
> +devid=3D$(get_devid ${logical_in_btrfs} 1)
> +target_dev=3D$(get_device_path $devid)
>
> +SYSFS_BDEV=3D`_sysfs_dev $target_dev`
>  _scratch_unmount
> -$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical_on_scratch 64K" $SCR=
ATCH_DEV |\
> -       _filter_xfs_io_offset
> +
> +echo "corrupt stripe 1 devid $devid devpath $target_dev physical $physic=
al" \
> +       >> $seqres.full
> +$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $target_dev > /=
dev/null
>
>  _scratch_mount -o nospace_cache
>
> @@ -118,18 +140,18 @@ while [[ -z ${result} ]]; do
>      # invalidate the page cache.
>      _scratch_cycle_mount
>
> -    start_fail
> +    start_fail $SYSFS_BDEV
>      result=3D$(bash -c "
>          if [[ \$((\$\$ % 2)) -eq 1 ]]; then
>                  exec $XFS_IO_PROG -c \"pread 0 4K\" \"$SCRATCH_MNT/fooba=
r\"
>          fi");
> -    stop_fail
> +    stop_fail $SYSFS_BDEV
>  done
>
>  _scratch_unmount
>
>  # check if the repair works
> -$XFS_IO_PROG -c "pread -v -b 512 $physical_on_scratch 512" $SCRATCH_DEV =
|\
> +$XFS_IO_PROG -c "pread -v -b 512 $physical 512" $target_dev |\
>         _filter_xfs_io_offset
>
>  _scratch_dev_pool_put
> diff --git a/tests/btrfs/143.out b/tests/btrfs/143.out
> index 66afea4b..a9e82ceb 100644
> --- a/tests/btrfs/143.out
> +++ b/tests/btrfs/143.out
> @@ -1,8 +1,6 @@
>  QA output created by 143
>  wrote 131072/131072 bytes
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 65536/65536 bytes
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
>  XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
>  XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> --
> 2.23.0
>

Other than that (which can probably be fixed at commit time by Eryu)
it looks good and it solves the problem.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
