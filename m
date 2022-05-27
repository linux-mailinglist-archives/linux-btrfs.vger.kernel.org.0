Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E62D535E1A
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 12:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350915AbiE0KX0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 06:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbiE0KXY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 06:23:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA1661295;
        Fri, 27 May 2022 03:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653646997;
        bh=BLRlL459mVG9i8IDmKvq4NxmzXjiCa/NUqH7a4akgaA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=NfeSrAyv7O6U8mOqJpcTciUlQHKtuliE6TCPalZcdck4NXcBrNLZv2tSgcN50q6eC
         BJ13S9vloGPRS9V6oW5RNdRq3C8Su46U0XYQnJ6gAf/et7u32/HmBHajmXd1hOBfCn
         lwJPqAoz8Ev6ubgjeNLgvT6ExMLXDcBfLI+kdOhA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N95eJ-1njARe0He3-0169c6; Fri, 27
 May 2022 12:23:17 +0200
Message-ID: <eae19028-784b-92b4-d032-331aa4b21bfe@gmx.com>
Date:   Fri, 27 May 2022 18:23:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 10/10] btrfs: test direct I/O read repair with interleaved
 corrupted sectors
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20220527081915.2024853-1-hch@lst.de>
 <20220527081915.2024853-11-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220527081915.2024853-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dg1GH4T24XOo7yivhzPUOyE88IRxfF+PyEmCwOQnzVhhKF42wcz
 aGMt7etSCUPkdUyKaJhE3G3wNq13X1eDkBSI2+KH1rQ7iAIIVr6ckLOF1hStUgdkUJYOiMG
 9fj2Suh+h7euChiThlMtMyAHb4WYU9wcv9SRg84Qhgplo69kLfhdGYRu1KMtWgIU1BYGa25
 hwY1m+SK518n+UTaciVBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gAEsS9gtJEs=:YynaPwrGA/DxMLEPz6qGf3
 SXg0A5I7Mqpom4MkOLUwLfisKbpCP9n1ReLnoUqHGx/u1/QlOg9iIa6Iiqo7pWZjhix2RtKOc
 p1siqE0silEl//3lpQztBVRBvRDeLz6Lt1ppYOrj4IeJnK31XBPqOgL7j/Zc832E+7m1nrO3A
 ogW17D0LscHI9fjafkO3Zw8fKONirY90E1fefV9waMpZy/8zYXCM6GN0k6Gb+fQzQSZUlX7QJ
 Fn5/MKEW7zJ5B8JickZlxN3t2DG4h3zxqodwWwRNZBCzRVmFWQewmXZ/ugz+J0SjG3Ut0Tgv6
 XwJpesc5lU4d56VbWHUojnq9o+ReybCfjUTx7b8KyQGoP8+sbn2q2WPWukTL6D9kgD7CsMhuN
 gUjMX9tAigCkfh8kLnT7MaCFKnSJYkZ4ASYM4iJAl/XkZVdEjPW382f1dxvS8qn7igMedA8KK
 GfswZujEb16IFSur3sJD2SCe5Ki4x+VexF/s6ucSXeWfM6EcMNBEg81Xpb4YgdrzyQ3iivHpH
 /Cw7iQOBnbDApWvansqRpqw0CmdX8Fi1gjoLZKrd+Y9tnnYHyB2KfJDNvCkjcGvovFmnELIJV
 aFt+wT7lwlOxzDDi78whj8S69H14NoVIfaTTO+yaL28JKG3BUZyliIfaJEKpXav9sOv95yVKk
 sTrSwKlD0xwmA8dWj1yOexAZIb+YLkAVoEDg6+R0GxwXPvUUwv0OZNzEQu4cfY17vmbCPnVBc
 mg1wPmfwxBDnW9PPUpf9UCyXGaqi8AyJhO2XkEcAKiPupelRsqnNhRSo/ce4Kj427LO1qmv6p
 1SKYp46MsOUdAhCXQDeu4YKG0gazSPjfKlh4vLaPfBXoWeyWdIseDaPDty5lumuObk1o63KTF
 6xUh8zZCncyJ1PB6+q3UZGagKKiWjTU2belaLm2P0LKfiL5eNz6WJOV8WJqpELNXJUnxObNW5
 vM4TAgzlMIkkvFO2Y0N/i5Ga6LT7nBHI4xCt0D9dxAqFYZAAxQbsTN87yYM51yOuAjj3weU7P
 3Xsoqkgki4BCg7LNZ9r+kET3oun7B0m882CQ+zME/WaO/CEUGpwe3Ipl/j6XJZf5wWb20PwWN
 okYnvMlWzvrtm3gp+XilibrK3f7twawZql79yhZ4VKREpHpajEmQzpicQ==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/27 16:19, Christoph Hellwig wrote:
> Test that repair handles the case where it needs to read from more than
> a single mirror on the raid1c3 profile and needs to take turns over the
> mirrors to recover data for the whole read.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   tests/btrfs/267     |  93 +++++++++++++++++++++++++++++++++++++
>   tests/btrfs/267.out | 109 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 202 insertions(+)
>   create mode 100755 tests/btrfs/267
>   create mode 100644 tests/btrfs/267.out
>
> diff --git a/tests/btrfs/267 b/tests/btrfs/267
> new file mode 100755
> index 00000000..cf19fdc8
> --- /dev/null
> +++ b/tests/btrfs/267
> @@ -0,0 +1,93 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2017 Liu Bo.  All Rights Reserved.
> +# Copyright (c) 2022 Christoph Hellwig.
> +#
> +# FS QA Test 267
> +#
> +# Test that btrfs buffered read repair on a raid1c3 profile can repair
> +# interleaving errors on all mirrors.
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
> +_scratch_mount
> +
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 256K 0 256K" \
> +	"$SCRATCH_MNT/foobar" | \
> +	_filter_xfs_io_offset
> +
> +# step 2, corrupt 4k in each copy

I guess you mean 64K?

Otherwise looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
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
> +_btrfs_direct_read_on_mirror 0 3 "$SCRATCH_MNT/foobar" 0 256K
> +_btrfs_direct_read_on_mirror 1 3 "$SCRATCH_MNT/foobar" 0 256K
> +_btrfs_direct_read_on_mirror 2 3 "$SCRATCH_MNT/foobar" 0 256K
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
> diff --git a/tests/btrfs/267.out b/tests/btrfs/267.out
> new file mode 100644
> index 00000000..2bdd32ea
> --- /dev/null
> +++ b/tests/btrfs/267.out
> @@ -0,0 +1,109 @@
> +QA output created by 267
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
