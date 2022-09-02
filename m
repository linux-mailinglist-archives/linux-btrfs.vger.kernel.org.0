Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9355AABAF
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 11:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbiIBJmy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 05:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbiIBJmv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 05:42:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85381CCE1C;
        Fri,  2 Sep 2022 02:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662111764;
        bh=EerkxjvmxnIlbJga+jXmNGmfN0/eIJP/nXPk7zuf1t0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ZM6cF1Ckl05KkXfGwMTXlDt3UYUuQIyeKML11DmAV2TEzUmwKIhFnDoc1FdNjE53u
         qKpwjDCT6WQqlkPjwfIe8Knft8O1lMWsHsgVgvlSm9TolQ5VByzyN05QjaD1UpBBME
         GH8Tvb/UtO/vKs0sErkiUW3K29FO9n3r2hnmegw8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M89L1-1oPuam1fQh-005IpU; Fri, 02
 Sep 2022 11:42:44 +0200
Message-ID: <58aafcbd-7fe8-fb50-3229-65e9721e471b@gmx.com>
Date:   Fri, 2 Sep 2022 17:42:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] btrfs: test that we can not delete a subvolume with an
 active swap file
Content-Language: en-US
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <0bc9cd4abfbde3f76b981628942f94631cef7162.1662110839.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <0bc9cd4abfbde3f76b981628942f94631cef7162.1662110839.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KhnnFJl6Jb3e954zWnTvoCeFald9/Ty8pDkbpHuknTBGgxETgQO
 9oA31OzX5vFF2x/rWIW0lqgkdJ7PsNZyVPVlATjYOE1NqLVssBI5ifNo60PjoBNx5kKbGzm
 Ay4sOdiCfagPW9bRkrQ1xd5MR2VZ7z+9/bD9Nrk/i9e8RxV4+GQU5lH5O+0dtHgeCmbIGNt
 aF/Gy3Fr5jXUzgqKsahYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jmLeVHmm1Oc=:V4WmIjg3UASkChnME+2CUV
 G1bEUx75IKCV/pMAiA3UgOGXHPfRbhFAqrj40q5D++Mdu0SBNh1LrHidmZvcn3QeGFw8/Kvnx
 PLKlgkK+97cUiAOFDua1g1FuimvXcUKp7AnsvJE8Z1OA7o6AehWx9BNK1Oitjg/AEq8K7hCDQ
 RP/CmDivLjxNUSBXmXe5iNZodyLTJh0xJ9B74vCyvRnXM0C1zzWXlB3S2czMeUhv7jAH10bG/
 ZIyCu/+abcB0eoEVnERNl6kc0Ob2kzHZ0rCAR2l9vhmPKJyVBKVq0NzETsMV+Fsmj/tSIaxNr
 eKUubOBVRyL71ga9lFUFMwFmFiYL+dA4Zq2jxZUsNpophy1nLfLi7v87nV43nqbZIlVr1sWcz
 cMqyXXjPAecZ7dcCja3hggJ0l1V4x5p7lzshsLCgjIayW0Zd2SSMXzy6/KyzXNNJrj+UsVExt
 ALv4LysTxaban/Plm9plY1ftve1gvzTEnYnFe1CPOx7KN1lznHDJjNN30UiQw545q9VDYT0RB
 5WJFLR9tSB93LiU+5z1XSMzkDq7CVqI36Ctplo/b8bKD4qw0Xk8H11R0NKMHdfA1PO+wQ+Ehm
 KztCADI6pl/JgK8LyQGvVMLmPsvAWhvV+QLJQbtqd3K2/A+jAIh4l09ueZsTklR7eFw7sO6Vb
 T0tAjcej43aIdK2h2koCVAXjOUf7YPcTd07CRkWoffUGUrxUv91aoi4MPGHcXwhYkAeXBhsLa
 C6/KVyabgPbWmpijUfW93XyZonOXaDsALi/5V5pqhKZbOD9eqY0BEeMprj0medj9s4zk3uaCK
 EQsZIDObcgCR8HVQg8/Mg6Ls/vL3wBXYMKC0JS80LmYCB+SPFfiLoJ6/0YfZwIvhElPz58Ehm
 yc56rGmIufXoQYsZ6gdafh9MK1ZynMD5sa8EH9vCBo2m72VGlLGMkt9n7VylU0KSfDurkDl1N
 YFnObLT4G3Gt79tlmtYVMtIsHxNEhY2byyYYYbiZin5l9ulX3jIkz0UOeMYezwotCAo9iKwcA
 RuS1MyLdXlKL1mNj9NV2qqek+zLppwrR8BiBp0OUJBKr05uosGvfEVAniF2eYQgvcf5R39zmG
 DINZ+S9NQSWNhWGRU047uXw3YWL2ERxbi1WXfuTbjVGznfWuYOS87V+3w92Zs9aczzf3r+EEm
 JeIMG0bc0DwBRUaz6JOPRylN1P
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/2 17:30, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> Verify that we can not delete a subvolume that has an active swap file,
> and that after disabling the swap file, we can delete it.
>
> This tests a fix done by kernel commit 60021bd754c6ca ("btrfs: prevent
> subvol with swapfile from being deleted"), which landed in kernel 5.18.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Pretty straightforward.

Reivewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>
> V2: Add _cleanup() override to make sure swapfile is disabled in case
>      the test is interrupted.
>
>   tests/btrfs/274     | 58 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/274.out |  6 +++++
>   2 files changed, 64 insertions(+)
>   create mode 100755 tests/btrfs/274
>   create mode 100644 tests/btrfs/274.out
>
> diff --git a/tests/btrfs/274 b/tests/btrfs/274
> new file mode 100755
> index 00000000..c0594e25
> --- /dev/null
> +++ b/tests/btrfs/274
> @@ -0,0 +1,58 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 274
> +#
> +# Test that we can not delete a subvolume that has an active swap file.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick swap subvol
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +	test -n "$swap_file" && swapoff $swap_file &> /dev/null
> +}
> +
> +. ./common/filter
> +
> +_supported_fs btrfs
> +_fixed_by_kernel_commit 60021bd754c6ca \
> +    "btrfs: prevent subvol with swapfile from being deleted"
> +_require_scratch_swapfile
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +swap_file=3D"$SCRATCH_MNT/subvol/swap"
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol | _filter_scratch
> +
> +echo "Creating and activating swap file..."
> +_format_swapfile $swap_file $(($(get_page_size) * 32)) >> $seqres.full
> +_swapon_file $swap_file
> +
> +echo "Attempting to delete subvolume with swap file enabled..."
> +# Output differs with different btrfs-progs versions and some display m=
ultiple
> +# lines on failure like this for example:
> +#
> +#   ERROR: Could not destroy subvolume/snapshot: Operation not permitte=
d
> +#   WARNING: deletion failed with EPERM, send may be in progress
> +#   Delete subvolume (no-commit): '/home/fdmanana/btrfs-tests/scratch_1=
/subvol'
> +#
> +# So just redirect all output to the .full file and check the command's=
 exit
> +# status instead.
> +$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/subvol >> $seqres.full 2=
>&1 && \
> +    echo "subvolume deletion successful, expected failure!"
> +
> +echo "Disabling swap file..."
> +swapoff $swap_file
> +
> +echo "Attempting to delete subvolume after disabling swap file..."
> +$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/subvol >> $seqres.full 2=
>&1 || \
> +   echo "subvolume deletion failure, expected success!"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/274.out b/tests/btrfs/274.out
> new file mode 100644
> index 00000000..66e0de25
> --- /dev/null
> +++ b/tests/btrfs/274.out
> @@ -0,0 +1,6 @@
> +QA output created by 274
> +Create subvolume 'SCRATCH_MNT/subvol'
> +Creating and activating swap file...
> +Attempting to delete subvolume with swap file enabled...
> +Disabling swap file...
> +Attempting to delete subvolume after disabling swap file...
