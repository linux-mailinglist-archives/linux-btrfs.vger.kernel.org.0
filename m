Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9CF8161243
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 13:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgBQMnS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 07:43:18 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42355 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgBQMnS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 07:43:18 -0500
Received: by mail-pl1-f193.google.com with SMTP id e8so6675781plt.9;
        Mon, 17 Feb 2020 04:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eFO35s5Ky07X/mGIAKSwzxotrlVv59NIdxN2RO+AkxA=;
        b=ibHuOs+tSlumPgXUcfrrVYlJBsiXDuUTBSVxnVTmP9hqQKgXnZDbzvNooUZIxzTtVE
         bm/lqTEBgYLyp0KIagkl0mZvRnu0c2oz6uja5N7B5ESS6bqnjU5I+xlCu1gUQNjxCMNC
         ZZ49SWy4Obt3XXtDC4NLVRlQSBoogxEYRMdSgwwj2CK5HYDYRqbFseM9mUGzMNRKP07S
         M2u5W+J1fBQ2erHxuFFAHyJGpD2IJOYoDLaC2LAWIVudPOleZb6zlAXI0Q9tDgz5IUOK
         0633s7nCAMXLgTIoUhgyzYjmNrWgw1agPYpJNXYLGweirYhNn0GsWj7VvVJpoH4vcxtg
         CHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eFO35s5Ky07X/mGIAKSwzxotrlVv59NIdxN2RO+AkxA=;
        b=twLw47VhaMsU2G3QoDARusDnhszOzutdWRpISbe1rbiyvbFJp+KkdntwFqTcIdn9Zm
         NyDdlOPYwjSsQgI31enbwIR45ndzNeCXAPaB0J3CnVlGnJmnt6/GNrTQfikcigPGU/KZ
         RpV21gRYI3M7AZsp6c3Ih4OeilMTVE8w93Kvb8vM6IwOijoQzX9UfluE2EID5g9aCGE2
         PRtk30GHbL8a+vczem8r2v+oqKWs3UpnbmGOU0CVqud/VnIfmb4wanLt5O+dvHd5uwLA
         4ivygfYr//rxAI4w5MQvfRgGjbH0IxrGWs9IU2ijQulgBxhNeaYi7+0gwgigU8rYpotx
         PQYA==
X-Gm-Message-State: APjAAAWEwvr2FS1hU12i/5PVuuoVAF95knRThj7EJiwGtSOJojr5ZUM7
        ldT1Bd5DzS7suQfUBHXvPLk=
X-Google-Smtp-Source: APXvYqwnnMMhmoFTmrRol9eOqHqlEEC8v6ZnIMHGAI0QoHjc03ggFMzg6VbC5gVmzmHnNyZcc4RKiw==
X-Received: by 2002:a17:902:45:: with SMTP id 63mr16112839pla.109.1581943397226;
        Mon, 17 Feb 2020 04:43:17 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id q8sm337349pfs.161.2020.02.17.04.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 04:43:16 -0800 (PST)
Date:   Mon, 17 Feb 2020 20:43:11 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: test unaligned punch hole at ENOSPC
Message-ID: <20200217124309.GJ2697@desktop>
References: <526051b1-4a48-fd40-c8dc-af7e1b399111@gmx.com>
 <20200131050957.3491-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131050957.3491-1-anand.jain@oracle.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 31, 2020 at 01:09:57PM +0800, Anand Jain wrote:
> Try to punch hole with unaligned size and offset when the FS is
> full and mounted with nodatacow option.
> Mainly holes are punched at locations which are unaligned
> with the file extent boundaries when the FS is full by data.
> As the punching holes at unaligned location will involve
> truncating blocks instead of just dropping the extents, it shall
> involve reserving data and metadata space for delalloc and so data
> alloc fails as the FS is full.
> 
> btrfs_punch_hole()
>  btrfs_truncate_block()
>    btrfs_check_data_free_space() <-- ENOSPC
> 
> We don't fail punch hole if the holes are aligned with the file
> extent boundaries as it shall involve just dropping the related
> extents, without truncating data extent blocks.
> 
> Link: https://patchwork.kernel.org/patch/11357415/

I've went through above link, and all btrfs developers involved there
agreed to restore the original btrfs/172 case. Then I'm fine with it
too. But we really should avoid such remove/reconstruct again,
especially this time btrfs/172 is already taken by other test..

Thanks,
Eryu

> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Eryu Guan <guaneryu@gmail.com>
> (cherry picked from commit 4c2c678cd56a81a210cb16f9f9347073e91e2fb0)
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Conflicts:
> 	tests/btrfs/group
> ---
> Its decided to bring back this test case, now the problem is better understood
> and the fix is available in the ML as in [Link].
> v2: mention nodatacow option used in the testcase in the commit log.
> 
>  tests/btrfs/204     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/204.out |  2 ++
>  tests/btrfs/group   |  1 +
>  3 files changed, 76 insertions(+)
>  create mode 100755 tests/btrfs/204
>  create mode 100644 tests/btrfs/204.out
> 
> diff --git a/tests/btrfs/204 b/tests/btrfs/204
> new file mode 100755
> index 000000000000..0dffb2dff40b
> --- /dev/null
> +++ b/tests/btrfs/204
> @@ -0,0 +1,73 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2018 Oracle. All Rights Reserved.
> +#
> +# FS QA Test 204
> +#
> +# Test if the unaligned (by size and offset) punch hole is successful when FS
> +# is at ENOSPC.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
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
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch
> +_require_xfs_io_command "fpunch"
> +
> +_scratch_mkfs_sized $((256 * 1024 *1024)) >> $seqres.full
> +
> +# max_inline ensures data is not inlined within metadata extents
> +_scratch_mount "-o max_inline=0,nodatacow"
> +
> +cat /proc/self/mounts | grep $SCRATCH_DEV >> $seqres.full
> +$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
> +
> +extent_size=$(_scratch_btrfs_sectorsize)
> +unalign_by=512
> +echo extent_size=$extent_size unalign_by=$unalign_by >> $seqres.full
> +
> +$XFS_IO_PROG -f -c "pwrite -S 0xab 0 $((extent_size * 10))" \
> +					$SCRATCH_MNT/testfile >> $seqres.full
> +
> +echo "Fill all space available for data and all unallocated space." >> $seqres.full
> +dd status=none if=/dev/zero of=$SCRATCH_MNT/filler bs=512 >> $seqres.full 2>&1
> +
> +hole_offset=0
> +hole_len=$unalign_by
> +$XFS_IO_PROG -c "fpunch $hole_offset $hole_len" $SCRATCH_MNT/testfile
> +
> +hole_offset=$(($extent_size + $unalign_by))
> +hole_len=$(($extent_size - $unalign_by))
> +$XFS_IO_PROG -c "fpunch $hole_offset $hole_len" $SCRATCH_MNT/testfile
> +
> +hole_offset=$(($extent_size * 2 + $unalign_by))
> +hole_len=$(($extent_size * 5))
> +$XFS_IO_PROG -c "fpunch $hole_offset $hole_len" $SCRATCH_MNT/testfile
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/204.out b/tests/btrfs/204.out
> new file mode 100644
> index 000000000000..ce2de3f0d107
> --- /dev/null
> +++ b/tests/btrfs/204.out
> @@ -0,0 +1,2 @@
> +QA output created by 204
> +Silence is golden
> -- 
> 1.8.3.1
> 
