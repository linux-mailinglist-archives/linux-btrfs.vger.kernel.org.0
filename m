Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BF73BB47C
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 02:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhGEAUP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Jul 2021 20:20:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:38663 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhGEAUP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 4 Jul 2021 20:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625444254;
        bh=WANSdCLx2HuMwdY8S7ESrzpHtNrDI830msWiZjqwZyw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AE5oNS0oQSURt+kd7gdjcAM8K+qm0aOUXBxYkdPLesQZ/yvePTAws6UF5AhHkJgAv
         dNOfUTjbAyYKNZ342TRR+NJDTiNrr4i2mpuzmiuffmwPi86tc2FymMDluxSnU45C4n
         nETuzyjzAEIejoeICsr33pi8wBS5uygQsMm29otU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMGN2-1lj4ci00Lm-00JHJt; Mon, 05
 Jul 2021 02:17:34 +0200
Subject: Re: [PATCH] btrfs/242: test case to fstrim on a degraded filesystem
To:     Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <a70c9f6b4e45d9bcdc5c2f19182f89ef8e22c074.1625237782.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <bf5ab599-a3e8-b8b8-4131-dfa02aa7d0e4@gmx.com>
Date:   Mon, 5 Jul 2021 08:17:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a70c9f6b4e45d9bcdc5c2f19182f89ef8e22c074.1625237782.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZeSPzBNfG3V1oMdYu8uW4yBbt6e7SSD6pzhB+e7j/Gb/Aa5f1FO
 pCGeQjouK4aWVBwVkofNEOnpfu2mb9J650ot26c050oRwp0JYnwbUkDWoe4zzg+t7ouB442
 8q16WDx0Z68rERyysyBET6yE4dI799accf8VFkPRKGuawH0gq9iDhgIP17Xp7by+j6PkoHG
 QUV8/MKARLM1o+xbDv+FA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:r9VEYMEztrE=:S/jBJ4lGUiPXkjzbzIC6xr
 lzNXWA0MG+f19Ik9VLc7XZ8GKL+RMoCOXnzaCMPony9pNZwGXyb1PDnjiEoX6j9bu8aKYaU4f
 tiSKP52xkp0ghlw63htOvwucog5TcYoDmnmZLgm/qBDx7ETzpTxsOqrkBpo4Fw/4+hGqMpVE7
 0RpzMa1L8il/ZrS/Gb6Lbe5cUsSOWYLAb88WltoQsTdLR9o90vyrvexxcs4r060yWeXO3Zn1U
 HlxEN9oFyLsyl6ehsvTrpFdMPEd9YD11FOQC1lNH0floD1La2aeS6SdH7VGQVqGantO4mD9gr
 MeSMLONfggG8TVHk35leclG0ChE/wltTDvZh+DwSNcrEi8cGCAxWfL5/yEu+4V00mhfX4bBAQ
 JTlqJkbEiicFrRLbYVjaZBNRxVHUiruAReSbsCUqjw/pPjxypaqbspRkizSGLDd+Yo+C/IoEH
 zy6iaKD679eAk8VK4+4zeXyJsULdCgwNiueya4IJHaAMWtYwPyyq+XJq6Oa1wHgpHgeUD+5+A
 TnZsnRx0onutmbAkUkN/Fw/7OORsfd1rEzIj5jdWOarROPpOfdtR+VfO8+eLUtNNt4/ewjwZS
 vUIrGt3aTajmGAfYGtml865mWyPVflR8JjEMVN7eRbCglMKJ7TxUtwinB5/A4Qu+OiTdtS68e
 BNOZ0xCKjeN4c0xxgOoLujDnodCGW8skVeufvCj2eo6kME2ubdUXx47u4Q28E5/u+oc5Q+i87
 xk49xckcFKOtr/408N7hU6C3qF4Oc32YXVg5qisx0FIuOMlbQrydi1aivXeyUV8Kxa7CMP9hw
 1+PLJZx5GsAXM3dmIQYkugsFIGraigs8QwVQSsQah3Y7x6nwn1BZavOeivyxc0x4PC3G+JWbZ
 XnmCvbO3KMK+Gz48ILj9lTuRFDVfAARs6krxjOztza8NPK0qqD2aNrRBPv2qxJw2RXLVBiv7Y
 HIrVYs+b16Civqosz+fSjRUlHBs2gqLNn3XSC3mKljcSWxEQYL5IT4nPmesQxt21R/YG7G95v
 pKyGTty86WNBHlJCGhpvSyayQQMJQWaCWjX3asWzar7/tEjvPdgWiKah5hOiD4gckLcmYTQRN
 79saF62ODk9muaSlo1hzEpF5KCPFAt0YGSKZwxogikC1JAeprp/8WjNvQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/4 =E4=B8=8B=E5=8D=887:20, Anand Jain wrote:
> Create a degraded btrfs filesystem and run fstrim on it.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   tests/btrfs/242     | 49 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/242.out |  2 ++
>   2 files changed, 51 insertions(+)
>   create mode 100755 tests/btrfs/242
>   create mode 100644 tests/btrfs/242.out
>
> diff --git a/tests/btrfs/242 b/tests/btrfs/242
> new file mode 100755
> index 000000000000..e946ee6ac7c2
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
> +
> +. ./common/preamble
> +_begin_fstest auto quick replace trim
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_btrfs_forget_or_module_loadable

Since you have wipefs requirement commented out, I guess you're also
unsure which is the better way.

Personally speaking, I think wipefs is better.
As it's more generic and needs no kernel support.

Despite that it looks good to me.

Thanks,
Qu

> +_require_scratch_dev_pool 2
> +#_require_command "$WIPEFS_PROG" wipefs
> +
> +_scratch_dev_pool_get 2
> +dev1=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $1 }')
> +
> +_scratch_pool_mkfs "-m raid1 -d raid1"
> +_scratch_mount
> +_require_batched_discard $SCRATCH_MNT
> +
> +# Add a test file with some data.
> +$XFS_IO_PROG -f -c "pwrite -S 0xab 0 10M" $SCRATCH_MNT/foo > /dev/null
> +
> +# Unmount the filesystem.
> +_scratch_unmount
> +
> +# Mount the filesystem in degraded mode
> +_btrfs_forget_or_module_reload
> +_mount -o degraded $dev1 $SCRATCH_MNT
> +
> +# Run fstrim
> +$FSTRIM_PROG $SCRATCH_MNT
> +
> +_scratch_dev_pool_put
> +
> +echo Silence is golden
> +
> +status=3D0
> +exit
> diff --git a/tests/btrfs/242.out b/tests/btrfs/242.out
> new file mode 100644
> index 000000000000..a46d77702f23
> --- /dev/null
> +++ b/tests/btrfs/242.out
> @@ -0,0 +1,2 @@
> +QA output created by 242
> +Silence is golden
>
