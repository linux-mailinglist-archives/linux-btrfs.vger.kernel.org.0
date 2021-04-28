Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6A736D4B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 11:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhD1JZJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 05:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhD1JZI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 05:25:08 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F99C061574;
        Wed, 28 Apr 2021 02:24:24 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id o5so62862985qkb.0;
        Wed, 28 Apr 2021 02:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=e4E23fo2uqkPZqy8jNheR4lbTC+Jlc+ewTDxu0GmTSM=;
        b=BlEAY98lCkzFSiCpYCaSn3l8ykr7Su0b9hROF13loutsfllKMsX9jB1ckoplwZtPM2
         IKSr/1BGXeHQZmfzPJ16X22qpaqudOnBLeeqNz6wG9hiGEZwS7hYRHJdobpSdRrLoTAy
         PfApEgN2GbggCjWFIo5+hcKnpaNW/nZ7CXcotb4MtuBbkKXEow9XVHp9iV2IBI1vcWJu
         6QNbygyxYIh4bS4e50piLnuemILIT6C/utzJnwb9ZZ+I1kBabqScZM8ZsKNhHCvrYeHR
         AlnsyOEioS5nvm9xPvK5sOM3woX5eTFev7Ndu2VZ+1B7Mso21Ieams91t/huIxL/4BR+
         1Hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=e4E23fo2uqkPZqy8jNheR4lbTC+Jlc+ewTDxu0GmTSM=;
        b=NiWOL+WZbUVXGxqRCmuYhwTLXpmJ4G3lAm8sBwkrcwkSrCMqsCvoGdMbH3Z+YWYaRV
         xyF1IBP32tAsn2z2iMm+vhVZmsbalEYfqTnT3r5IOCZAL355jT0ABdiK9XDaR37bAK+I
         lN1m2otWb8/shKWnx+uPsobVkn/kXlgD3po42wSD8sYKkq0ZmQf6da7S/QCsSPEY8m0A
         rEZoWA8XAu7e4KqiX1Php8s5lda9RfvhwA2NflNHlOZrLRzLjsadLgL6UVkhL+5IFaZ9
         nBcKhFzjj/CptexfCRxdKUz8KCfAd8HDPHocFD2F1BB7b4lR8M2mV0Zd97Xp3acpITZy
         AdJQ==
X-Gm-Message-State: AOAM530GePpEuFy3f8y6L04aCAY7RxU0DL05gTItCBO+Uvt1snPQdLII
        l3rsYLUNahH8nQFc/BfsUiSLGkd9zsAIZdEr+7VKa6LH32da5A==
X-Google-Smtp-Source: ABdhPJz5G6CVjVfRFGqdfjJ5avdbVSeJUOYH04EshpTiM8+FEaYQM6/u+QhKQwu2gOEDpWI9HBuuUyPB3nXWnl06qXg=
X-Received: by 2002:a37:4017:: with SMTP id n23mr26213255qka.338.1619601863531;
 Wed, 28 Apr 2021 02:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210428084608.21213-1-johannes.thumshirn@wdc.com> <20210428084608.21213-3-johannes.thumshirn@wdc.com>
In-Reply-To: <20210428084608.21213-3-johannes.thumshirn@wdc.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 28 Apr 2021 10:24:12 +0100
Message-ID: <CAL3q7H4z=eePUYbOgOVZhMCp+u8m8bbvKfU5nNqq3rd_8YNm1g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] btrfs: add test for zone auto reclaim
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Eryu Guan <guan@eryu.me>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 28, 2021 at 9:46 AM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Add a test for the patch titled "btrfs: zoned: automatically reclaim
> zones".

Since this is already in Linus' tree, we could specify here the commit.

>
> This test creates a two file on a newly created FS in a way that when we
> delete the first one, an auto reclaim process will be triggered by the FS=
.
>
> After the reclaim process, it verifies that the data was moved to another
> zone and old zone was successfully reset.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  common/config       |   1 +
>  tests/btrfs/236     | 103 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/236.out |   2 +
>  tests/btrfs/group   |   1 +
>  4 files changed, 107 insertions(+)
>  create mode 100755 tests/btrfs/236
>  create mode 100644 tests/btrfs/236.out
>
> diff --git a/common/config b/common/config
> index a47e462c7792..1a26934985dd 100644
> --- a/common/config
> +++ b/common/config
> @@ -226,6 +226,7 @@ export FSVERITY_PROG=3D"$(type -P fsverity)"
>  export OPENSSL_PROG=3D"$(type -P openssl)"
>  export ACCTON_PROG=3D"$(type -P accton)"
>  export E2IMAGE_PROG=3D"$(type -P e2image)"
> +export BLKZONE_PROG=3D"$(type -P blkzone)"
>
>  # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
>  # newer systems have udevadm command but older systems like RHEL5 don't.
> diff --git a/tests/btrfs/236 b/tests/btrfs/236
> new file mode 100755
> index 000000000000..3be74196ec5d
> --- /dev/null
> +++ b/tests/btrfs/236
> @@ -0,0 +1,103 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Western Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 236
> +#
> +# Test that zone autoreclaim works as expected, that is: if the dirty
> +# threashold is exceeded the data gets relocated to new block group and =
the

threashold -> threshold

> +# old block group gets deleted. On block group deletion, the underlying =
device
> +# zone also needs to be reset.
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
> +_supported_fs btrfs
> +_require_scratch
> +_require_btrfs_command inspect-internal dump-tree
> +_require_btrfs_command filesystem sync
> +_require_command "$BLKZONE_PROG" blkzone
> +_require_zoned_device "$SCRATCH_DEV"
> +
> +get_data_bg()
> +{
> +       $BTRFS_UTIL_PROG inspect-internal dump-tree -t CHUNK $SCRATCH_DEV=
 |\
> +               grep -A 1 "CHUNK_ITEM" | grep -B 1 "type DATA" |\
> +               grep -Eo "CHUNK_ITEM [[:digit:]]+" | cut -d ' ' -f 2
> +}
> +
> +zonesize=3D$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/chunk_secto=
rs)
> +zonesize=3D$((zonesize << 9))
> +
> +_scratch_mkfs >/dev/null 2>&1
> +_scratch_mount -o commit=3D5 # 5s commit time to speed up test

Why not 1s? Would even be faster.

> +
> +uuid=3D$(findmnt -n -o UUID "$SCRATCH_MNT")
> +reclaim_threshold=3D75
> +echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
> +fill_percent=3D$((reclaim_threshold + 2))
> +rest_percent=3D$((90 - fill_percent)) # make sure we're not creating a n=
ew BG
> +fill_size=3D$((zonesize * fill_percent / 100))
> +rest=3D$((zonesize * rest_percent / 100))
> +
> +# step 1, fill FS over $fillsize
> +$XFS_IO_PROG -fdc "pwrite -W 0 $fill_size" $SCRATCH_MNT/$seq.test1 >> $s=
eqres.full
> +$XFS_IO_PROG -fdc "pwrite -W 0 $rest" $SCRATCH_MNT/$seq.test2 >> $seqres=
.full
> +sleep 5 # need to make sure the transaction got committed

I don't get this.
Why not just call 'sync'? That commits the transaction too.
Doing regular buffered writes followed by sync is more intuitive and faster=
.

If for some reason direct IO is really needed, it also misses a
_require_odirect.

> +
> +zones_before=3D$($BLKZONE_PROG report $SCRATCH_DEV | grep -v -e em -e nw=
 | wc -l)
> +echo "Before reclaim: $zones_before zones open" >> $seqres.full
> +old_data_zone=3D$(get_data_bg)
> +old_data_zone=3D$((old_data_zone >> 9))
> +printf "Old data zone 0x%x\n" $old_data_zone >> $seqres.full
> +
> +# step 2, delete the 1st $fill_size sized file to trigger reclaim
> +rm $SCRATCH_MNT/$seq.test1
> +$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
> +sleep 10 # 1 transaction commit for 'rm' and one for balance
> +
> +# check that we don't have more zones open than before
> +zones_after=3D$($BLKZONE_PROG report $SCRATCH_DEV | grep -v -e em -e nw =
| wc -l)
> +echo "After reclaim: $zones_after zones open" >> $seqres.full
> +
> +# Check that old data zone was reset
> +old_wptr=3D$($BLKZONE_PROG report -o $old_data_zone -c 1 $SCRATCH_DEV |\
> +       grep -Eo "wptr 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
> +if [ "$old_wptr" !=3D "0x000000" ]; then
> +       _fail "Old wptr still at $old_wptr"
> +fi
> +
> +new_data_zone=3D$(get_data_bg)
> +new_data_zone=3D$((new_data_zone >> 9))
> +printf "New data zone 0x%x\n" $new_data_zone >> $seqres.full
> +
> +# Check that data was really relocated to a different zone
> +if [ $old_data_zone -eq $new_data_zone ]; then
> +       _fail "New zone same as old zone"

The use of _fail is usually discouraged. A simple echo would suffice here.

Other than that, it looks good, but I don't have an environment to
test zoned devices, so it's just eyeballing.

Thanks.

> +fi
> +
> +# success, all done
> +echo "Silence is golden"
> +status=3D0
> +exit
> diff --git a/tests/btrfs/236.out b/tests/btrfs/236.out
> new file mode 100644
> index 000000000000..b6b6e0cad9a7
> --- /dev/null
> +++ b/tests/btrfs/236.out
> @@ -0,0 +1,2 @@
> +QA output created by 236
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 331dd432fac3..62c9c761e974 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -238,3 +238,4 @@
>  233 auto quick subvolume
>  234 auto quick compress rw
>  235 auto quick send
> +236 auto quick balance
> --
> 2.31.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
