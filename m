Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D19D294EE0
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 16:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442021AbgJUOj1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 10:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441957AbgJUOj1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 10:39:27 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB96DC0613CF
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 07:39:26 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id f5so1217426qvx.6
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uhs2O0Q9ROPySc3PNKjV9W8o3FvbjaUgLr9y9vPm1wI=;
        b=spCBcQ1vptHk2ODMp7PEEmeVeQaLAHYVk7CYfT1n6TrmOdIB7azzmQmWrQ/4AZs6Yc
         kPlMhG9/sNDgsPxmGAWUz5s4mVpYPURI437CRAq0Hhb7npFvvYVX1W8FadQn9VD4S0Ts
         M6QD2zwp98x+dOeyD0GAhrp5+p+5K6Zih8PcMtimVOLavUDipwoXXStA/dO0T8yxVroR
         4nKGVGgOTTzS6fb5HT+49ZTWHfQ3Y+X6Vqg3QSAIY8wD9ipkK09zkfSCjDe4H9eY7xHn
         e9Gxs/Fq8HERCgf0v7C2V+LBDyF5ROCLPh/nbagT+wXQQ4lTOkEhaiFKysi0f9L1xHJU
         Y0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uhs2O0Q9ROPySc3PNKjV9W8o3FvbjaUgLr9y9vPm1wI=;
        b=AwKiq12n24N5C8Fzof8GXoBToWtwgXPKrMdLn7Qh1JvPCVieVK6FZHafcihbUJkIuI
         /Y0dNuEYUzv6QeVQCJrp3TByvKnkoiu0Wwc5P6XQtD1eutwoeB5aakCx1esVH35yVO5U
         MrtXTUUR13rK3jUPM/9diWHzsSg1XdlXiednRnqBGoupkoKR/os28/4r0X+tOvliQ2q7
         ifnZLznfrzIww1BF6WEzsXUlDm+MUccGtpdIvMZSRcCociVrYRB64yTNOA42IWf3rveX
         zEgxtjGg3OXwiDJ4OQxXq9pOo09/SQhy9pBg1cdiQxzo/0JMWERenvdyHSK5E4PmqTgl
         xsMw==
X-Gm-Message-State: AOAM531W2nHHBHVK5nKaGZsm8VyqJYTImxCuga0S8NTR0wUEtHqGm1t0
        1H1V+YLk5kMaLMwapC/WkrmkQw==
X-Google-Smtp-Source: ABdhPJzfZUQ7l5l9jL3TSZavb43dBYbAGvSWX2UE69O+MFoFvv5Hd+s60qtJca+XXxqBLp+IpRnwoA==
X-Received: by 2002:a05:6214:153:: with SMTP id x19mr3229836qvs.50.1603291165932;
        Wed, 21 Oct 2020 07:39:25 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n199sm1330258qkn.77.2020.10.21.07.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 07:39:25 -0700 (PDT)
Subject: Re: [PATCH] btrfs: add test case for rwf_nowait writes
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <5cfe8cb86da5593dda6c03b4ac404fa3b4c8b0d8.1603204654.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1aa6d939-6818-f8f3-d857-642237e56cf8@toxicpanda.com>
Date:   Wed, 21 Oct 2020 10:39:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <5cfe8cb86da5593dda6c03b4ac404fa3b4c8b0d8.1603204654.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/20/20 10:43 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test several scenarios for RWF_NOWAIT writes, to verify we don't regress
> on btrfs specific behaviour (snapshots, cow files, reflinks, holes,
> prealloc extent beyond eof).
> 
> We had some bugs in the past related to RWF_NOWAIT writes not failing on
> btrfs when they should or failing when they shouldn't, these were fixed by
> the following kernel commits:
> 
>    4b1946284dd6 ("btrfs: fix failure of RWF_NOWAIT write into prealloc extent beyond eof")
>    260a63395f90 ("btrfs: fix RWF_NOWAIT write not failling when we need to cow")
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   tests/btrfs/225     | 140 ++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/225.out |  70 ++++++++++++++++++++++
>   tests/btrfs/group   |   1 +
>   3 files changed, 211 insertions(+)
>   create mode 100755 tests/btrfs/225
>   create mode 100644 tests/btrfs/225.out
> 
> diff --git a/tests/btrfs/225 b/tests/btrfs/225
> new file mode 100755
> index 00000000..f55e8c80
> --- /dev/null
> +++ b/tests/btrfs/225
> @@ -0,0 +1,140 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test No. btrfs/225
> +#
> +# Test several (btrfs specific) scenarios with RWF_NOWAIT writes, cases where
> +# they should fail and cases where they should succeed.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/reflink
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_scratch_reflink
> +_require_chattr C
> +_require_odirect
> +_require_xfs_io_command pwrite -N
> +_require_xfs_io_command falloc -k
> +_require_xfs_io_command fpunch
> +
> +rm -f $seqres.full
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +# Test a write against COW file/extent - should fail with -EAGAIN. Disable the
> +# NOCOW attribute of the file just in case MOUNT_OPTIONS has "-o nodatacow".
> +echo "Testing write against COW file"
> +touch $SCRATCH_MNT/f1
> +$CHATTR_PROG -C $SCRATCH_MNT/f1
> +$XFS_IO_PROG -s -c "pwrite -S 0xab 0 128K" $SCRATCH_MNT/f1 | _filter_xfs_io
> +$XFS_IO_PROG -d -c "pwrite -N -V 1 -S 0xff 32K 64K" $SCRATCH_MNT/f1

Should we do something like

expected_to_fail_command > /dev/null 2>&1 || echo "FAILED!"

so we don't get screwed by error strings changing in the future or some such 
other nonsense?  Thanks,

Josef
