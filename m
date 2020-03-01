Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88450174D8F
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2020 14:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgCANyM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 08:54:12 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:35551 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgCANyM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Mar 2020 08:54:12 -0500
Received: by mail-pg1-f180.google.com with SMTP id 7so4053419pgr.2;
        Sun, 01 Mar 2020 05:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zJRNmhyHVjdCuisfZqrBWEUt9slyZyZshlGJyr+GzDs=;
        b=l6dqjfpfZdLgwxrsFQuJlfVdKbFzm/7coAVdZt97JU6q5bh02U8eJ/3J1s7fVEelBZ
         uggeJ5JIALTK22BcvpkX0Ebcg6rbZ6AtAuVN6jN1IU/0PXFt8WOyUqQs/5XCqpY4Jy4E
         fWwCqSunmEdosH9HttSBDpiNxUFSJhgZC2uD3u+kcRpujj2rlLgsmV+Vtnc+vOUwkgOX
         g6xlY3Ukoc4QO2Jj1FdWgqJ2CqPwkKr5ZrlZkamw/3tflpWDBXTkfuUQZSjKru3QSnHm
         pDWK/KuoUbY+i6IYl88bORb/2+qtAxMbv03aANcclizzOZCc1r5kRo1C49SPwVoj3TG3
         3guA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zJRNmhyHVjdCuisfZqrBWEUt9slyZyZshlGJyr+GzDs=;
        b=CTwLQUAiLLASK0/39i+lKdxgBlqhn5QC6WwA/sr7xBozMn6ux0OF8cN5vcMmBquveO
         LXgYL3p1M4JQi3Si8nyCAwZ2kkeVcl+y+dlB1JjOeM8kBGPRK11qiYyJy5dw+MhvQUu9
         tz852wg446NDSY5t/eMwlVXy3SbYqBc6iCdJUM/ge5YEo08q3Qlfz5G07StmWjI78rU3
         2UcK+KG2mNk7C/Ix6Rp4hGlpdGPxjr4Z/FIpbCNWQaFKcpPvF4O3lW1Ccm5bz0dbtTMH
         dXbavJ1E44E+wH65Ia+0YcN0fp2MGmqvWLsl9TqT1AOpoqUuSgovQDkitHNbbxpnUezC
         nYFw==
X-Gm-Message-State: APjAAAXpjjoY9ZuKx/bbfaRyB5EWFj9/aQklw2FlY+az+s44JNx137hz
        hSiJjg91l3HX7ide5zav8qg=
X-Google-Smtp-Source: APXvYqzhAzHQ1HsXvoauqP4Mz8ym5oWKepcg7ODWLBH7Msyrzi7SguBOCENsm5mUSjlKDmo02CmX4Q==
X-Received: by 2002:a63:f20a:: with SMTP id v10mr14283889pgh.420.1583070849686;
        Sun, 01 Mar 2020 05:54:09 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id q12sm17456135pfh.158.2020.03.01.05.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 05:54:08 -0800 (PST)
Date:   Sun, 1 Mar 2020 21:54:06 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     dsterba@suse.com, nborisov@suse.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [ fstests PATCHv3 2/2] btrfs: Test subvolume delete --subvolid
 feature
Message-ID: <20200301134026.GK3840@desktop>
References: <20200224031341.27740-1-marcos@mpdesouza.com>
 <20200224031341.27740-3-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224031341.27740-3-marcos@mpdesouza.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 24, 2020 at 12:13:41AM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Looks fine to me overall, but it'd be better to have commit message to
describe the test.

Also, it'd be great if btrfs folks could help review it.

Thanks,
Eryu

> ---
> Changes from v2:
> * Added 'Created subvolume...' into 203.out to match the subvolume creating command
> * Changed awk to $AWK_PROG, suggested by Eryu
> * Changed _run_btrfs_util_prog to $BTRFS_UTIL_PROG, suggested by Eryu
> * Use _scratch_unmount instead of executing umount by hand, sugested by Eryu
> * Created a local function to delete and list subvolumes, suggested by Eryu
> 
> Changes from v1:
> * Added some prints printing what is being tested
> * The test now uses the _btrfs_get_subvolid to get subvolumeids instead of using
>   plain integers
> 
> 
>  tests/btrfs/203     | 68 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/203.out | 17 ++++++++++++
>  tests/btrfs/group   |  1 +
>  3 files changed, 86 insertions(+)
>  create mode 100755 tests/btrfs/203
>  create mode 100644 tests/btrfs/203.out
> 
> diff --git a/tests/btrfs/203 b/tests/btrfs/203
> new file mode 100755
> index 00000000..0f662db1
> --- /dev/null
> +++ b/tests/btrfs/203
> @@ -0,0 +1,68 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FSQA Test No. 203
> +#
> +# Test subvolume deletion using the subvolume id, even when the subvolume in
> +# question is in a different mount space.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/filter.btrfs
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch
> +_require_btrfs_command subvolume delete --subvolid
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +_delete_and_list()
> +{
> +	local subvol_name="$1"
> +	local msg="$2"
> +
> +	SUBVOLID=$(_btrfs_get_subvolid $SCRATCH_MNT "$subvol_name")
> +	$BTRFS_UTIL_PROG subvolume delete --subvolid $SUBVOLID $SCRATCH_MNT | _filter_scratch
> +
> +	echo "$msg"
> +	$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | $AWK_PROG '{ print $NF }'
> +}
> +
> +# Test creating a normal subvolumes
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1 | _filter_scratch
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol2 | _filter_scratch
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol3 | _filter_scratch
> +
> +echo "Current subvolume ids:"
> +$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | $AWK_PROG '{ print $NF }'
> +
> +# Delete the subvolume subvol1, and list the remaining two subvolumes
> +_delete_and_list subvol1 "After deleting one subvolume:"
> +_scratch_unmount
> +
> +# Now we mount the subvol2, which makes subvol3 not accessible for this mount
> +# point, but we should be able to delete it using it's subvolume id
> +$MOUNT_PROG -o subvol=subvol2 $SCRATCH_DEV $SCRATCH_MNT
> +_delete_and_list subvol3 "Last remaining subvolume:"
> +_scratch_unmount
> +
> +# now mount the rootfs
> +_scratch_mount
> +# Delete the subvol2
> +_delete_and_list subvol2 "All subvolumes removed."
> +_scratch_unmount
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/203.out b/tests/btrfs/203.out
> new file mode 100644
> index 00000000..3301852b
> --- /dev/null
> +++ b/tests/btrfs/203.out
> @@ -0,0 +1,17 @@
> +QA output created by 203
> +Create subvolume 'SCRATCH_MNT/subvol1'
> +Create subvolume 'SCRATCH_MNT/subvol2'
> +Create subvolume 'SCRATCH_MNT/subvol3'
> +Current subvolume ids:
> +subvol1
> +subvol2
> +subvol3
> +Delete subvolume (no-commit): 'SCRATCH_MNT/subvol1'
> +After deleting one subvolume:
> +subvol2
> +subvol3
> +Delete subvolume (no-commit): 'SCRATCH_MNT/subvol3'
> +Last remaining subvolume:
> +subvol2
> +Delete subvolume (no-commit): 'SCRATCH_MNT/subvol2'
> +All subvolumes removed.
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 79f85e97..e7744217 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -204,3 +204,4 @@
>  200 auto quick send clone
>  201 auto quick punch log
>  202 auto quick subvol snapshot
> +203 auto quick subvol
> -- 
> 2.25.0
> 
