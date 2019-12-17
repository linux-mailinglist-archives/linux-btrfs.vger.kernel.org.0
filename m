Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B14612339E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 18:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfLQRdg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 12:33:36 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39846 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfLQRdf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 12:33:35 -0500
Received: by mail-ua1-f65.google.com with SMTP id q22so3731503uam.6;
        Tue, 17 Dec 2019 09:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=g2ICq4Unry/hyhl7Lp3WAQxmiZQGUFDN3jvo094N4po=;
        b=h7+98SEjy+OLUBau9Qb0lVVOx4Ly+1/oPL1MXHX+L+tIFR4s5v6NBSut/KuBgn2LoJ
         XemFgiQnde0HmvM1RzkEFe3BbVEcrZYKDQZoaVWpFDYYIWTjJPfFtzevtyIkXLG67FNL
         7VtODvGnabyccwWU7Y0hA03b9Xveo1gG+9qIfet+hNcuWXljim1aoDO7r6rTg1C7pDzW
         JkmBvrTZR9sWmDZ+AmDxA0vb/vd7H0ht8BUrPzJUVehlQ1N3nQlEyZvrTVrFaE/rnyaT
         Oqv0gxZXi90SppnP/HYqqUDHtNvX88hB+O9vd0Zm+QaAs679zm5sw8TmDjH6Lm+BMrri
         fHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=g2ICq4Unry/hyhl7Lp3WAQxmiZQGUFDN3jvo094N4po=;
        b=mkxcXyEtl5KfMx4pmOYJ+wI4KaLKIUO7hi+ExQ6STR0vNMQje4g2ynkYJcKiPDgH6s
         j7iYQ5C5dTQtJ0WKiQIkGOi+5x3oGT7MYD+6AVNtjq+Xk0rw6Ige3nYdsPHx7QmbZqxR
         bS1WWIehWgzVQirzih/48nfVMfnkLh91NWr93CCfIbLADWL87cDCjWlWg0gFFJTXWWJl
         gtSEDFyW+9vf9PYH3ORZsA740gtJ41TLRnjy2sX8q5GCo+OnaiEFKGj/SiXfF+k3svUb
         ABy8IYlpq1tkNd+awEvNoHMEuIBShQ0vMLVuWrgXBqJnERMKAZe0og9AuM/WL+Tq3Q/t
         AQtA==
X-Gm-Message-State: APjAAAVBrr5P3iRGZpTzGwLNqFiaf7Tum2GzcCjP6Z8mrRpwnEvyW9+s
        KNMUxvMRUnXguOXtQmcW3NYqVpi12R/VXplxiAEptr2a
X-Google-Smtp-Source: APXvYqz0e90x6EJTcuNCpJC40WoBdzti6tNejj7jK2SrrOllLLGknQDOByX9IeqzgzzOG6Abp8VRzJm4kHz7trn7tVc=
X-Received: by 2002:ab0:4ac6:: with SMTP id t6mr4426635uae.0.1576604013139;
 Tue, 17 Dec 2019 09:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20191211104029.25541-1-wqu@suse.com> <20191211104029.25541-4-wqu@suse.com>
In-Reply-To: <20191211104029.25541-4-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 17 Dec 2019 17:33:22 +0000
Message-ID: <CAL3q7H5Oa9W0M3UYxhT6dgGXe6MkDE938Z7dcy8wOow_FxR5_Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] fstests: btrfs/15[78]: Use proper helper to get both
 devid and physical offset for corruption
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

On Wed, Dec 11, 2019 at 10:40 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> When using btrfs-progs v5.4, btrfs/157 and btrfs/158 will fail:
>
> btrfs/157 1s ... - output mismatch (see xfstests/results//btrfs/157.out.b=
ad)
>     --- tests/btrfs/157.out 2018-09-16 21:30:48.505104287 +0100
>     +++ xfstests/results//btrfs/157.out.bad
> 2019-12-10 15:35:43.112390076 +0000
>     @@ -1,9 +1,9 @@
>      QA output created by 157
>      wrote 131072/131072 bytes at offset 0
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -wrote 65536/65536 bytes at offset 9437184
>     +wrote 65536/65536 bytes at offset 22020096
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -wrote 65536/65536 bytes at offset 9437184
>     ...
>     (Run 'diff -u xfstests/tests/btrfs/157.out xfstests/results//btrfs/15=
7.out.bad'  to see the entire diff)
> btrfs/158 2s ... - output mismatch (see xfstests/results//btrfs/158.out.b=
ad)
>     --- tests/btrfs/158.out 2018-09-16 21:30:48.505104287 +0100
>     +++ xfstests/results//btrfs/158.out.bad
> 2019-12-10 15:35:44.844388521 +0000
>     @@ -1,9 +1,9 @@
>      QA output created by 158
>      wrote 131072/131072 bytes at offset 0
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -wrote 65536/65536 bytes at offset 9437184
>     +wrote 65536/65536 bytes at offset 22020096
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -wrote 65536/65536 bytes at offset 9437184
>     ...
>     (Run 'diff -u xfstests/tests/btrfs/158.out xfstests/results//btrfs/15=
8.out.bad'  to see the entire diff)
>
> [CAUSE]
> This two tests use physical offset as golden output, while mkfs.btrfs
> can do whatever it likes to arrange its chunk layout, thus physical
> offset is never reliable.
>
> And btrfs-progs commit c501c9e3b816 ("btrfs-progs: mkfs: match devid
> order to the stripe index") just changed the layout.
>
> So the output mismatch and failed.
>
> [FIX]
> In fact, that btrfs-progs commit not only changed offset, but also the
> device sequence.
>
> So we can't just simply remove the physical offset, but also need to use
> proper helper to get both devid (as its device path) and physical offset
> for corruption.
>
> As long as mkfs.btrfs still uses sequential devid, these tests should
> handle future chunk layout change without problem.
>
> Reported-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/157     | 53 +++++++++++++++++++++++++++++----------------
>  tests/btrfs/157.out |  4 ----
>  tests/btrfs/158     | 48 +++++++++++++++++++++++++---------------
>  tests/btrfs/158.out |  4 ----
>  4 files changed, 65 insertions(+), 44 deletions(-)
>
> diff --git a/tests/btrfs/157 b/tests/btrfs/157
> index 7f75c407..80b01b8d 100755
> --- a/tests/btrfs/157
> +++ b/tests/btrfs/157
> @@ -51,22 +51,30 @@ _require_scratch_dev_pool 4
>  _require_btrfs_command inspect-internal dump-tree
>  _require_btrfs_fs_feature raid56
>
> -get_physical_stripe0()
> +get_physical()
>  {
> -       $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
> -       grep " DATA\|RAID6" -A 10 | \
> -       $AWK_PROG '($1 ~ /stripe/ && $3 ~ /devid/ && $2 ~ /0/) { print $6=
 }'
> +       local stripe=3D$1
> +        $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | =
\
> +               grep " DATA\|RAID6" -A 10 | \
> +               awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/)=
 { print \$6 }"

Same as in the other patch, use $AWK_PROG instead.

>  }
>
> -get_physical_stripe1()
> +get_devid()
>  {
> -       $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
> -       grep " DATA\|RAID6" -A 10 | \
> -       $AWK_PROG '($1 ~ /stripe/ && $3 ~ /devid/ && $2 ~ /1/) { print $6=
 }'
> +       local stripe=3D$1
> +        $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | =
\
> +               grep " DATA\|RAID6" -A 10 | \
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
>  _scratch_dev_pool_get 4
> -# step 1: create a raid6 btrfs and create a 4K file
> +# step 1: create a raid6 btrfs and create a 128K file
>  echo "step 1......mkfs.btrfs" >>$seqres.full
>
>  mkfs_opts=3D"-d raid6 -b 1G"
> @@ -80,18 +88,25 @@ _scratch_mount -o nospace_cache
>  $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
>         "$SCRATCH_MNT/foobar" | _filter_xfs_io
>
> +logical=3D`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | =
cut -d '#' -f 1`
>  _scratch_unmount
>
> -stripe_0=3D`get_physical_stripe0`
> -stripe_1=3D`get_physical_stripe1`
> -dev4=3D`echo $SCRATCH_DEV_POOL | awk '{print $4}'`
> -dev3=3D`echo $SCRATCH_DEV_POOL | awk '{print $3}'`
> -
> -# step 2: corrupt the 1st and 2nd stripe (stripe 0 and 1)
> -echo "step 2......simulate bitrot at offset $stripe_0 of device_4($dev4)=
 and offset $stripe_1 of device_3($dev3)" >>$seqres.full
> -
> -$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_0 64K" $dev4 | _filter_xfs=
_io
> -$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_1 64K" $dev3 | _filter_xfs=
_io
> +phy0=3D$(get_physical 0)
> +devid0=3D$(get_devid 0)
> +devpath0=3D$(get_device_path $devid0)
> +phy1=3D$(get_physical 1)
> +devid1=3D$(get_devid 1)
> +devpath1=3D$(get_device_path $devid1)
> +
> +# step 2: corrupt stripe #0 and #1
> +echo "step 2......simulate bitrot at:" >>$seqres.full
> +echo "      ......stripe #0: devid $devid0 devpath $devpath0 phy $phy0" =
\
> +       >>$seqres.full
> +echo "      ......stripe #1: devid $devid1 devpath $devpath1 phy $phy1" =
\
> +       >>$seqres.full
> +
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $phy0 64K" $devpath0 > /dev/null
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $phy1 64K" $devpath1 > /dev/null
>
>  # step 3: read foobar to repair the bitrot
>  echo "step 3......repair the bitrot" >> $seqres.full
> diff --git a/tests/btrfs/157.out b/tests/btrfs/157.out
> index 08d592c4..d69c0f1d 100644
> --- a/tests/btrfs/157.out
> +++ b/tests/btrfs/157.out
> @@ -1,10 +1,6 @@
>  QA output created by 157
>  wrote 131072/131072 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 65536/65536 bytes at offset 9437184
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 65536/65536 bytes at offset 9437184
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  0200000 aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa
>  *
>  0400000
> diff --git a/tests/btrfs/158 b/tests/btrfs/158
> index 603e8bea..c8d5af82 100755
> --- a/tests/btrfs/158
> +++ b/tests/btrfs/158
> @@ -43,22 +43,30 @@ _require_scratch_dev_pool 4
>  _require_btrfs_command inspect-internal dump-tree
>  _require_btrfs_fs_feature raid56
>
> -get_physical_stripe0()
> +get_physical()
>  {
> -       $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
> -       grep " DATA\|RAID6" -A 10 | \
> -       $AWK_PROG '($1 ~ /stripe/ && $3 ~ /devid/ && $2 ~ /0/) { print $6=
 }'
> +       local stripe=3D$1
> +        $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | =
\
> +               grep " DATA\|RAID6" -A 10 | \
> +               awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/)=
 { print \$6 }"

Same here.

>  }
>
> -get_physical_stripe1()
> +get_devid()
>  {
> -       $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
> -       grep " DATA\|RAID6" -A 10 | \
> -       $AWK_PROG '($1 ~ /stripe/ && $3 ~ /devid/ && $2 ~ /1/) { print $6=
 }'
> +       local stripe=3D$1
> +        $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | =
\
> +               grep " DATA\|RAID6" -A 10 | \
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
>  _scratch_dev_pool_get 4
> -# step 1: create a raid6 btrfs and create a 4K file
> +# step 1: create a raid6 btrfs and create a 128K file
>  echo "step 1......mkfs.btrfs" >>$seqres.full
>
>  mkfs_opts=3D"-d raid6 -b 1G"
> @@ -74,16 +82,22 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsy=
nc" \
>
>  _scratch_unmount
>
> -stripe_0=3D`get_physical_stripe0`
> -stripe_1=3D`get_physical_stripe1`
> -dev4=3D`echo $SCRATCH_DEV_POOL | awk '{print $4}'`
> -dev3=3D`echo $SCRATCH_DEV_POOL | awk '{print $3}'`
> +phy0=3D$(get_physical 0)
> +devid0=3D$(get_devid 0)
> +devpath0=3D$(get_device_path $devid0)
> +phy1=3D$(get_physical 1)
> +devid1=3D$(get_devid 1)
> +devpath1=3D$(get_device_path $devid1)
>
>  # step 2: corrupt the 1st and 2nd stripe (stripe 0 and 1)
> -echo "step 2......simulate bitrot at offset $stripe_0 of device_4($dev4)=
 and offset $stripe_1 of device_3($dev3)" >>$seqres.full
> -
> -$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_0 64K" $dev4 | _filter_xfs=
_io
> -$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_1 64K" $dev3 | _filter_xfs=
_io
> +echo "step 2......simulate bitrot at:" >>$seqres.full
> +echo "      ......stripe #0: devid $devid0 devpath $devpath0 phy $phy0" =
\
> +       >>$seqres.full
> +echo "      ......stripe #1: devid $devid1 devpath $devpath1 phy $phy1" =
\
> +       >>$seqres.full
> +
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $phy0 64K" $devpath0 > /dev/null
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $phy1 64K" $devpath1 > /dev/null
>
>  # step 3: scrub filesystem to repair the bitrot
>  echo "step 3......repair the bitrot" >> $seqres.full
> diff --git a/tests/btrfs/158.out b/tests/btrfs/158.out
> index 1f5ad3f7..95562f49 100644
> --- a/tests/btrfs/158.out
> +++ b/tests/btrfs/158.out
> @@ -1,10 +1,6 @@
>  QA output created by 158
>  wrote 131072/131072 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 65536/65536 bytes at offset 9437184
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 65536/65536 bytes at offset 9437184
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  0000000 aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa
>  *
>  0400000
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
