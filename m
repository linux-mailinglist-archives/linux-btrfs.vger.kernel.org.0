Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDA43BBC6C
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 13:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhGELyc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jul 2021 07:54:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:58811 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhGELyc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Jul 2021 07:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625485910;
        bh=EO2m/NuEe3jDGVDa5YMWA5P96siPx6lfK1ls9sZfHq0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ECaF7LJHMVJWoUvD3/60wEg+oeB8TjfxilL37NbDVdm/rX9sH3OLbCUT1Dd/KRHaF
         BFrCGmN/+6nKQcfVjXGZ/RH3OtEwW+nUpa6ubCp9X8qMXdqdpRZCflI5cQdc00Czue
         zShu57hOgTfKGp4C5qqYsYdbAftUkUIrWoXAA244=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MkHMP-1lKgk30erp-00kfmk; Mon, 05
 Jul 2021 13:51:50 +0200
Subject: Re: [PATCH v3] btrfs/242: test case to fstrim on a degraded
 filesystem
To:     Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fdmanana@gmail.com
References: <a70c9f6b4e45d9bcdc5c2f19182f89ef8e22c074.1625237782.git.anand.jain@oracle.com>
 <cae6a7e7836949a0407cf6859d7f9102636bab8f.1625481473.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <d39a3fba-e887-29b5-f577-841a16de49ec@gmx.com>
Date:   Mon, 5 Jul 2021 19:51:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cae6a7e7836949a0407cf6859d7f9102636bab8f.1625481473.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WiHP4f4QY6zFGXhDn5F3oyQs3r7rOlQizz28LQZD/fy2ZRvsoPd
 BoLfvACVdfwnQQt5OZKpfNcjCnYxkqLfHm7Iz5BVzeTc8tMI/b1p08Vr/3AZXZck1V85NB/
 3BCa0eHsKpc51/yEBQ+HyuqdrI7eAUeir/KiBLYeFeeBur3Jr/0wEXXBG3KVujtNubXmKTP
 analX1hMig6Z+wtfpgScw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+uSrSkuglYQ=:CNbVt065PcXkdAYcc5XP/3
 mm8PQwhPu8ATeWFeHpf++R0xghOqa+UCWLJU2GJpth4/VPWRIKfbsiOICcvMxz2hiIbvlu6vT
 51DFtygRbicXtx951x0RHQanh19pcigUOysYKz3wOwnMNru68CvMPLai+It9xT8QMOyPJjeCp
 wZ0Oe0owmdIfZteAt1t+E1j/hAUwMaLgRH3UUaUsSqTJ7p1aOjfCMLcaGQ/t5iLCrcG6yOopm
 jhl87qxA+KyqS/6ND3J9SDDACLLs33l1x/gGoD1FF05WM7mv1UvW6iV5WfPJMduWJOKdAaT8F
 BJUs3nzTlDgio7mFpXOZXF+NsfmMGu1SkRwhoKqcYoH3tuNRoFrkZjs8aYC2BC6MDEFjV9kTI
 NqIe6TMsPgc2F05gKGeniK31jVFpMpgcHmErI1RpHm2ocI+YsjQclhBeDHNSLwr/tWfI8iSeB
 9z8NBoewulAqhW1tVunqWiFHJJQP5WoVrXfpMZwmCMi2lBMmFaIxyi60JLJw4h4BJfvct4GaF
 C0QtvjzRzXzbsegrNCfyn7ersHvPC4w9m35tlXCx5+5bniUrk2sXkmU1O31iUQZEm86IZqxNB
 8J7uKAVEdl7J/HbPyGce0zzE3RYcCH0xOiDXYPS24TFZh3fCBHZCOixl+jkpkylThuaZZYVKo
 XAsDe8r5OUowmnsNusKsxjski29pvtx50Siy9NComrZZA4A5x/7BAB8NewvbliPPZA8EuvDgG
 BJOJ1gM9RF8s8yTyEXfMtUh+Hss7Svn+ejK7IAzZnscNxnlt/BJcsivV6+9rgQpkAlfRq1fNo
 0KhwF0aJLb3x0BHEpqVS0CEkk1XZttuHFeQGR4iN84275rwge1rNG4M5d4WXqNhDy6QWgM2JS
 pjQfa64vJWqd1cqy6mrgSebaIfWurcNrvYGHf0rMJmNm6RKundv4tggc56kJQnWTAdd4eWnXu
 CgzxJl2WWnJ2fKdqzxsVWZun/jBi4LU2T9UAjNWuFS0eEF0XRVsx5J78WMZyOiZxlYr1wXNOH
 uchavqyEdi2S2YEEmkFE4pGrwPNyAszKrAP6hCSXVwMac1aNPSJLTuegtsrF043kGn08LJ3E6
 0y6Zy6T2NvfAq96O/LjjsOW9hQ2tDx2GeRf7ZCQJA5wuZE1bgIM2F9o9w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/5 =E4=B8=8B=E5=8D=886:43, Anand Jain wrote:
> Create a degraded btrfs filesystem and run fstrim on it.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
> v3: Remove from replace-group.
>      Add to the volume-group.
>      Check for the data integrity.
> v2: Remove the commented #_require_command "$WIPEFS_PROG" wipefs
>      which I forgot to remove earlier.
>   tests/btrfs/242     | 49 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/242.out |  7 +++++++
>   2 files changed, 56 insertions(+)
>   create mode 100755 tests/btrfs/242
>   create mode 100644 tests/btrfs/242.out
>
> diff --git a/tests/btrfs/242 b/tests/btrfs/242
> new file mode 100755
> index 000000000000..da787c1ef91f
> --- /dev/null
> +++ b/tests/btrfs/242
> @@ -0,0 +1,49 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021 Oracle. All Rights Reserved.
> +#
> +# FS QA Test 242
> +#
> +# Test that fstrim can run on the degraded filesystem
> +#   Kernel requires fix for the null pointer deref in btrfs_trim_fs()
> +#     [patch] btrfs: check for missing device in btrfs_trim_fs
> +
> +. ./common/preamble
> +_begin_fstest auto quick volume trim
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_btrfs_forget_or_module_loadable
> +_require_scratch_dev_pool 2
> +
> +_scratch_dev_pool_get 2
> +dev1=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $1 }')
> +
> +_scratch_pool_mkfs "-m raid1 -d raid1"
> +_scratch_mount
> +_require_batched_discard $SCRATCH_MNT
> +
> +# Add a test file with some data.
> +$XFS_IO_PROG -f -c "pwrite -S 0xab 0 10M" $SCRATCH_MNT/foo | _filter_xf=
s_io
> +
> +# Unmount the filesystem.
> +_scratch_unmount
> +
> +# Mount the filesystem in degraded mode
> +_btrfs_forget_or_module_reload
> +_mount -o degraded $dev1 $SCRATCH_MNT
> +
> +# Run fstrim, it should skip on the missing device.
> +$FSTRIM_PROG $SCRATCH_MNT
> +
> +# Verify data integrity as in the golden output.
> +echo "File foo data:"
> +od -A d -t x1 $SCRATCH_MNT/foo
> +
> +_scratch_dev_pool_put
> +
> +status=3D0
> +exit
> diff --git a/tests/btrfs/242.out b/tests/btrfs/242.out
> new file mode 100644
> index 000000000000..0f478fc93db7
> --- /dev/null
> +++ b/tests/btrfs/242.out
> @@ -0,0 +1,7 @@
> +QA output created by 242
> +wrote 10485760/10485760 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +File foo data:
> +0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
> +*
> +10485760
>
