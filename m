Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D17B61233CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 18:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfLQRoD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 12:44:03 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46234 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfLQRoC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 12:44:02 -0500
Received: by mail-ua1-f66.google.com with SMTP id l6so3263942uap.13;
        Tue, 17 Dec 2019 09:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=PE+y+kGa7gfD/I7FoyZ8FdVWsS2hnoq61wngQANzDL0=;
        b=UoyuVd1+nYhfliJQLNJ81MYsXavYAMVcOQJ2VXscWIArtsshzHcVVV4NzfDGGMG/9u
         pQ1ugV3byeAeCRGLColWvwjoTRlPJZliTW8kS9lnDWx9VyP0yq0TtBsyG3PuNGqR4Vpa
         NikaPeh83Aw6S5DLVZXYbPavFlKi/laAAb309ChxRoIju6Bn1berzMG7c/qAxZBsim2+
         eorqGBnN0US8GWA0AVDG/uQI47Gwhkc8apEVRxwlUV7MY5ZahEiRnCyNFNL0SbKfz3Ur
         LxZ0/TRlCa4jVIotchTCirn10mGzkbncEGdWMEaUmMHy+Cb3doE2A1ip2tFF9fGn71aq
         U90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=PE+y+kGa7gfD/I7FoyZ8FdVWsS2hnoq61wngQANzDL0=;
        b=mZ94xL56lz4dA/NmbXWOJYdSyqCYmJl7yoSOoIVfcQE6BrvWbOJk68+qZwngzoWK0G
         Q31Bd0Ed9hONnifiiHcKwyWYJOztpnq/4nydpu1IQ0GlVlFEB2ynmP0lDC0qUgzj/sPF
         wZA4GWkY3U9bYaXdR5cY95njcqMd5u2ybLh8ce0RXtWUMNpbA/4plS2JDYX4J12+rCNc
         6c1cbaJi4R/uKIz4DGJJWe7SUk2VXuhrhjW0q/bwaY7vx2A2VVXawkTFB8bSscKLoaSc
         5i3u0ECbqLjEis9Z9Hw2AtHkqyq0zOg5S8gsD1ym6pp9X4ID7L+GCpuXra2vXGkc04t5
         I45w==
X-Gm-Message-State: APjAAAUNbF5A98mGr1SIL+l52RPvY6+MKRK4zNSVu8zecNkkBTf/PnBK
        7rLmkJrk0il1XqWgZofnW+nGcL9DYpT+1sNZoG4=
X-Google-Smtp-Source: APXvYqwPjCCmUugcvMCFUBF1tWdoPw7pebki/8M9ZwnD55ZvgoY37hUoSTFb4T5lodjtZkF4q1ypaI7f1rLuOCPyXbM=
X-Received: by 2002:a9f:368f:: with SMTP id p15mr4123251uap.123.1576604641289;
 Tue, 17 Dec 2019 09:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20191212083123.25888-1-wqu@suse.com>
In-Reply-To: <20191212083123.25888-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 17 Dec 2019 17:43:50 +0000
Message-ID: <CAL3q7H5C+R3nPs-hW8k5pdFy9qDEVvD1UY+jNngZcmaDhcyr7w@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/14[01]: Use proper helper to get both
 devid and physical for corruption
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 12, 2019 at 8:31 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> With btrfs-progs v5.4, btrfs/140 and btrfs/141 will fail.

Oddly, it doesn't fail for me. Only 142, 143, 157 and 158.

However this seems correct.

>
> [CAUSE]
> Both tests are testing re-silvering of RAID1, thus they need to corrupt
> on-disk data.
>
> This requires to do manual logical -> physical bytes mapping in the test
> case.
> However the test case itself uses too many hard coded helper to grab
> physical offset, which will change with mkfs.btrfs.
>
> [FIX]
> Use more flex helper, to get both devid and physical for such

more flex -> more flexible

> corruption.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/140     | 36 ++++++++++++++++++++++++++++--------
>  tests/btrfs/140.out |  2 --
>  tests/btrfs/141     | 33 ++++++++++++++++++++++++++-------
>  tests/btrfs/141.out |  2 --
>  4 files changed, 54 insertions(+), 19 deletions(-)
>
> diff --git a/tests/btrfs/140 b/tests/btrfs/140
> index 1c5aa679..5c6de733 100755
> --- a/tests/btrfs/140
> +++ b/tests/btrfs/140
> @@ -46,10 +46,26 @@ _require_odirect
>
>  get_physical()
>  {
> -       # $1 is logical address
> -       # print chunk tree and find devid 2 which is $SCRATCH_DEV
> -       $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
> -       grep $1 -A 6 | awk '($1 ~ /stripe/ && $3 ~ /devid/ && $4 ~ /1/) {=
 print $6 }'
> +       local logical=3D$1
> +       local stripe=3D$2
> +        $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | =
\
> +               grep $logical -A 6 | \
> +               awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/)=
 { print \$6 }"
> +}

Same as before, $AWK_PROG.

These helpers seems the same as in 142 and 143 (and 141, updated later
in this patch).
I know this patch isn't introducing them, but we should move them into
helpers at common/btrfs one day.

Thanks.

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
> +}
> +
> +get_device_path()
> +{
> +       local devid=3D$1
> +       echo "$SCRATCH_DEV_POOL" | awk "{print \$$devid}"
>  }
>
>  _scratch_dev_pool_get 2
> @@ -72,11 +88,15 @@ echo "step 2......corrupt file extent" >>$seqres.full
>
>  ${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
>  logical_in_btrfs=3D`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_fi=
lefrag | cut -d '#' -f 1`
> -physical_on_scratch=3D`get_physical ${logical_in_btrfs}`
> +physical=3D$(get_physical ${logical_in_btrfs} 1)
> +devid=3D$(get_devid ${logical_in_btrfs} 1)
> +devpath=3D$(get_device_path ${devid})
>
>  _scratch_unmount
> -$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical_on_scratch 64K" $SCR=
ATCH_DEV |\
> -       _filter_xfs_io_offset
> +
> +echo " corrupt stripe #1, devid $devid devpath $devpath physical $physic=
al" \
> +       >> $seqres.full
> +$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $devpath > /dev=
/null
>
>  _scratch_mount
>
> @@ -96,7 +116,7 @@ done
>  _scratch_unmount
>
>  # check if the repair works
> -$XFS_IO_PROG -d -c "pread -v -b 512 $physical_on_scratch 512" $SCRATCH_D=
EV |\
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical 512" $devpath |\
>         _filter_xfs_io_offset
>
>  _scratch_dev_pool_put
> diff --git a/tests/btrfs/140.out b/tests/btrfs/140.out
> index f3fdf174..fb5aa108 100644
> --- a/tests/btrfs/140.out
> +++ b/tests/btrfs/140.out
> @@ -1,8 +1,6 @@
>  QA output created by 140
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
> diff --git a/tests/btrfs/141 b/tests/btrfs/141
> index 186d18c8..2f5ad1a2 100755
> --- a/tests/btrfs/141
> +++ b/tests/btrfs/141
> @@ -46,10 +46,26 @@ _require_command "$FILEFRAG_PROG" filefrag
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
> +}
> +
> +get_device_path()
> +{
> +       local devid=3D$1
> +       echo "$SCRATCH_DEV_POOL" | awk "{print \$$devid}"
>  }
>
>  _scratch_dev_pool_get 2
> @@ -72,11 +88,14 @@ echo "step 2......corrupt file extent" >>$seqres.full
>
>  ${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
>  logical_in_btrfs=3D`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_fi=
lefrag | cut -d '#' -f 1`
> -physical_on_scratch=3D`get_physical ${logical_in_btrfs}`
> +physical=3D$(get_physical ${logical_in_btrfs} 1)
> +devid=3D$(get_devid ${logical_in_btrfs} 1)
> +devpath=3D$(get_device_path ${devid})
>
>  _scratch_unmount
> -$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical_on_scratch 64K" $SCR=
ATCH_DEV |\
> -       _filter_xfs_io_offset
> +echo " corrupt stripe #1, devid $devid devpath $devpath physical $physic=
al" \
> +       >> $seqres.full
> +$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $devpath > /dev=
/null
>
>  _scratch_mount
>
> @@ -97,7 +116,7 @@ done
>  _scratch_unmount
>
>  # check if the repair works
> -$XFS_IO_PROG -c "pread -v -b 512 $physical_on_scratch 512" $SCRATCH_DEV =
|\
> +$XFS_IO_PROG -c "pread -v -b 512 $physical 512" $devpath |\
>         _filter_xfs_io_offset
>
>  _scratch_dev_pool_put
> diff --git a/tests/btrfs/141.out b/tests/btrfs/141.out
> index 116f98a2..4b8be189 100644
> --- a/tests/btrfs/141.out
> +++ b/tests/btrfs/141.out
> @@ -1,8 +1,6 @@
>  QA output created by 141
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


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
