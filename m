Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D5E532B51
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 15:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbiEXNaL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 09:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiEXNaJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 09:30:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6907499685;
        Tue, 24 May 2022 06:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653399004;
        bh=rLoS9oFxDh5MSILiVYzodx4CpuP8DR0E+/95ZtzD0NI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=V9qrOGhhBfCBJq0SqUuaiI/Zjy60Ehxd4jboAjKsQn6qJ/mChreGFK3jKAeAJX+z3
         /RLf0516acKbPyMYtrDarJUY1CNCYJ5Ckma4qMkewsGPPnIoe9zRhWFGLrANOO8Q+z
         Zv2j42w6js+kRXkV2CXc1fS/uVL6g5GEqIM1as7Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mplc7-1nUKnu30SD-00qCy5; Tue, 24
 May 2022 15:30:04 +0200
Message-ID: <991d947c-bf7a-9919-177b-03b4de3542f1@gmx.com>
Date:   Tue, 24 May 2022 21:30:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 9/9] btrfs: test repair with corrupted sectors interleaved
 over multiple mirrors
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20220524071838.715013-1-hch@lst.de>
 <20220524071838.715013-10-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220524071838.715013-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V3AMAF+FlxzeMQWrBdBwQ681ywsnuaYQ8pjNS0g0OvBhabkZP/W
 mOsFHJzer6TkoF0lIguEJkM5G1PXXyDQW8DPDI6JP/Mg/y2EMQAwNjst2xP1T2yd3Cnh6kB
 vNFzQZ2oDCOzXg/FI5uca/s21MG90RY+DlIj26X9OgrkWJ+YsoWfbWASwUgK88QnKzTL1FC
 BOWrMC6OqNXQHUSdfl7aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JzkK1AumTVQ=:8T+UMYdX/+DUFOM+in9FXJ
 QHOkeFp9ncn9noMBCRkNt1DNQc5uaygbkUcaz2u1qkneQaUkkthG9JRs+AKNymGpJa5+lumiF
 xK2ANlbgqSyoolXVLoWB5RGSd+6aU/3Esk+NkQMGDZpP6SORxhGdCA53ykJpTfv4phe9QRBWa
 DBbOOWmv7YXW1wDWTTw5RONxSqMhf+TL+bmrUFyVPvGsKrqUBPFDfVAc5tBiu5g5IEjxXwdOe
 iCQwJfNSo2V0stPRrZJ2XWiSoU7NDDpeh1PyOdn65UnF36MyrjskNOzqyxe2R0K9WNlHd4C9X
 8/WijOSMTSu1hq1HOpMq3qc5dB20I+caAMQaYauwq0MPOnFJV78vjgKuBmp+GB6K0RdJpl/Ky
 VBAtkRvzTe7LztKCFm42riYfaxNQaBrCZTvgoy32BV9VSJWeG+aeE4OiSWT12MWdrxMtrRX04
 fDoIw8THtMMrMGSheO9Rb8i3YOm1qoqu1op28jagerbzeO11FqhfWJGi+B9vxQbdoNtu+zWW3
 pX4ATMoVwgGQuYHbZbstrh4FipmGynF2xSFZpeHZlKCw3LE1TCvPBlKh4X9QTbPItbwezPbg8
 3bAgo9VPC9K6JJluX6F9+KiDdeZIsQMqInpb+gU4VuXifKxGyKKQvR6YMaSrs71uavJ6hojZI
 EVe5Dp+nLhR4TD0zevwF83sZZIg/lcwrh/xuQPGKpk88blCaCwsSjddLTiTBPu90krMh6fmYf
 GWNd+TPZdNAwCasPDZ/3JuypxPbbEW2AF+3d5g5eTYtWqi+GPM3fKsKiM8QlWNgQ5GjywUt/U
 cUWYEACHJvuRSU0CXu7GoeCDgQZhOjuwYmMLIr0/QpHKTMJTTnfebEEircu2kDDhDcBVb8pIP
 Flb7lt9G4VZh+SnXinIb1pod5QMotS9wJ0JKhjayVgcpGI5QGijG8M1YI3XhA8pD7eCbW34HX
 VztbHF6squJ8ky5j4YyJk4Wt4W1TNvv7tQavbP5ewUdBQvDHlagZLudK3E7FnsAzeLhEZXSkR
 mEKdiF8r2kKJXa+Cqf6lXyOOCymz8+K2AyiY4vkyx52iGsfvjf5Kn8jdDx+7RcEQTiKj5V3Iu
 PfMZwzK8v5ch6xtBiGtoCmrcBuodtSLPTTjHb9b+1q1hkiYsW+f8lFH7A==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/24 15:18, Christoph Hellwig wrote:
> Test that repair handles the case where it needs to read from more than
> a single mirror on the raid1c3 profile and needs to take turns over the
> mirrors to recover data for the whole read.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just the same cosmetic nitpick on the _btrfs_no_v1_cache_opt and its
comments.

Thanks,
Qu
> ---
>   tests/btrfs/266     |  94 ++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/266.out | 109 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 203 insertions(+)
>   create mode 100755 tests/btrfs/266
>   create mode 100644 tests/btrfs/266.out
>
> diff --git a/tests/btrfs/266 b/tests/btrfs/266
> new file mode 100755
> index 00000000..43f4dff2
> --- /dev/null
> +++ b/tests/btrfs/266
> @@ -0,0 +1,94 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2017 Liu Bo.  All Rights Reserved.
> +# Copyright (c) 2022 Christoph Hellwig.
> +#
> +# FS QA Test 266
> +#
> +# Test that btrfs raid repair on a raid1c3 profile can repair interleav=
ing
> +# errors on all mirrors.
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick read_repair
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +_require_scratch_dev_pool 3
> +
> +_require_odirect
> +# Overwriting data is forbidden on a zoned block device
> +_require_non_zoned_device "${SCRATCH_DEV}"
> +
> +_scratch_dev_pool_get 3
> +# step 1, create a raid1 btrfs which contains one 128k file.
> +echo "step 1......mkfs.btrfs"
> +
> +mkfs_opts=3D"-d raid1c3 -b 1G"
> +_scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
> +
> +# make sure data is written to the start position of the data chunk
> +_scratch_mount $(_btrfs_no_v1_cache_opt)
> +
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 256K 0 256K" \
> +	"$SCRATCH_MNT/foobar" | \
> +	_filter_xfs_io_offset
> +
> +# step 2, corrupt 4k in each copy
> +echo "step 2......corrupt file extent"
> +
> +# ensure btrfs-map-logical sees the tree updates
> +sync
> +
> +logical=3D$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
> +
> +physical1=3D$(_btrfs_get_physical ${logical} 1)
> +devpath1=3D$(_btrfs_get_device_path ${logical} 1)
> +
> +physical2=3D$(_btrfs_get_physical ${logical} 2)
> +devpath2=3D$(_btrfs_get_device_path ${logical} 2)
> +
> +physical3=3D$(_btrfs_get_physical ${logical} 3)
> +devpath3=3D$(_btrfs_get_device_path ${logical} 3)
> +
> +_scratch_unmount
> +
> +$XFS_IO_PROG -d -c "pwrite -S 0xbd -b 64K $physical3 64K" \
> +	$devpath3 > /dev/null
> +
> +$XFS_IO_PROG -d -c "pwrite -S 0xba -b 64K $physical1 128K" \
> +	$devpath1 > /dev/null
> +
> +$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $((physical2 + 65536)) 128K" =
\
> +	$devpath2 > /dev/null
> +
> +$XFS_IO_PROG -d -c "pwrite -S 0xbc -b 64K $((physical3 + (2 * 65536))) =
128K"  \
> +	$devpath3 > /dev/null
> +
> +_scratch_mount
> +
> +# step 3, 128k dio read (this read can repair bad copy)
> +echo "step 3......repair the bad copy"
> +
> +_btrfs_buffered_read_on_mirror 0 3 "$SCRATCH_MNT/foobar" 0 256K
> +_btrfs_buffered_read_on_mirror 1 3 "$SCRATCH_MNT/foobar" 0 256K
> +_btrfs_buffered_read_on_mirror 2 3 "$SCRATCH_MNT/foobar" 0 256K
> +
> +_scratch_unmount
> +
> +echo "step 4......check if the repair worked"
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical1 512" $devpath1 |\
> +	_filter_xfs_io_offset
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical2 512" $devpath2 |\
> +	_filter_xfs_io_offset
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical3 512" $devpath3 |\
> +	_filter_xfs_io_offset
> +
> +_scratch_dev_pool_put
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/266.out b/tests/btrfs/266.out
> new file mode 100644
> index 00000000..fcf2f5b8
> --- /dev/null
> +++ b/tests/btrfs/266.out
> @@ -0,0 +1,109 @@
> +QA output created by 266
> +step 1......mkfs.btrfs
> +wrote 262144/262144 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +step 2......corrupt file extent
> +step 3......repair the bad copy
> +step 4......check if the repair worked
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +read 512/512 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +read 512/512 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +read 512/512 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
