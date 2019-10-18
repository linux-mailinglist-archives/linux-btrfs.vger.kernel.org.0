Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 091EFDC098
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2019 11:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406901AbfJRJKa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 05:10:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45652 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733255AbfJRJKa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 05:10:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id y72so3466646pfb.12;
        Fri, 18 Oct 2019 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aCWQOn8ewMFqF+jhOhPXREA8YxtCM0O9nZ8HdeW9foM=;
        b=lYZPAI6tH/QQvXB20WsTSMFJuULq3aYEpxTR34jWN3DVbRY83IKWeb8N8N/V+v1sw2
         zQLJvjma362zqWGKx8gY0Sw0BoNjsoGzxTu1le7uERBrcI4JOS/FuYll2pJGNcbHzSVW
         rZSN++mcUUVqvfQADzf2uzIYSflm4V5jTrWdF2N1aaBabdCGYBszI9eEgHrcadHZMREx
         U44oiXLITuYq4GcTFJwg3YWZzCHh5O92SgzRFtq0d3FYCu2SKTh2sC+I9BJm4VxAtfY6
         mnptLCi+k7Z+Me6MwN5SEffSu2F3417AZFG7yfMyiBQTz4QDphzCfQnhm7sB0IoRnZD7
         xyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aCWQOn8ewMFqF+jhOhPXREA8YxtCM0O9nZ8HdeW9foM=;
        b=a0HFUSemV4MYH2HQz9U5LvbC5Cp9jNI7UCFTiKG4ndu26/BdfW6ivnvlag8ciE/b/w
         oxxVONV1hxzDNbEH54ThzDLZceLO/6pxWLY1E63SJgve9u3zN9mWtaw7yL862gSwIuHB
         rWgSmRGNZQdEDxIhuP495ZZCWTJfMjsAZuFrCWQANggzKsaUm1bULw7YAr3psGuqCvfW
         NfIEgeUndCHjsbPaL1RpHYfdSWeWKasarg3EkKU6xToY5hmC9KDGJ1bIVUKM7u+rAegZ
         P1GmR8bcpjiM6n/FJ090GQXZC+dPopicV3uXq591zMl9Zqev9RplXcDALEUekgiAgYDH
         coag==
X-Gm-Message-State: APjAAAUoibBW95TaPandZ+KQ/lAAfLDlkaD0H5hb1IqD2c6wwNKcCL45
        dTJz5Yvu+pL4nHQbKz7Lrxo=
X-Google-Smtp-Source: APXvYqz6tMk4wMpss0ZpquvbPCw7j1m22R7O9Ci/a6q/W5XNBVxWzflrv31zlTBo+3HpKcg8JI5KhQ==
X-Received: by 2002:aa7:80c6:: with SMTP id a6mr5323992pfn.89.1571389827360;
        Fri, 18 Oct 2019 02:10:27 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id 69sm5852375pfb.145.2019.10.18.02.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 02:10:25 -0700 (PDT)
Date:   Fri, 18 Oct 2019 17:10:19 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] fstest: btrfs/196: test for alien btrfs-devices
Message-ID: <20191018091019.GK2622@desktop>
References: <20191007094101.784-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007094101.784-1-anand.jain@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 05:41:00PM +0800, Anand Jain wrote:
> Test if btrfs.ko sucessfully identifies and reports the missing device,
> if the missed device contians someother btrfs.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/196     | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/196.out | 25 +++++++++++++++++
>  tests/btrfs/group   |  1 +
>  3 files changed, 103 insertions(+)
>  create mode 100755 tests/btrfs/196
>  create mode 100644 tests/btrfs/196.out
> 
> diff --git a/tests/btrfs/196 b/tests/btrfs/196
> new file mode 100755
> index 000000000000..e35cdce492e5
> --- /dev/null
> +++ b/tests/btrfs/196
> @@ -0,0 +1,77 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 196
> +#
> +# Test stale and alien btrfs-device in the fs devices list.
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
> +. ./common/filter.btrfs
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux

_supported_os btrfs

> +_require_scratch
> +_require_scratch_dev_pool 4
> +
> +workout()
> +{
> +	raid=$1
> +	device_nr=$2
> +
> +	echo $raid
> +	_scratch_dev_pool_get $device_nr
> +
> +	_scratch_pool_mkfs "-d$raid -m$raid" >> $seqres.full 2>&1 || \
> +							_fail "mkfs failed"
> +
> +	# Make device_1 an alien btrfs device for the raid created above by
> +	# adding it to the $TEST_DIR

Instead of adding $device_1 to $TEST_DIR, does creating a new btrfs on
$device_1 work? I'm a bit worried that changing $TEST_DIR/$TEST_DEV
configuration would have some side effects, e.g. we add it to $TEST_DIR
and cancle the test before removing it, the $TEST_DEV will end up in an
unexpected state in next test run. (Though we could remove the device in
_cleanup, this is just an example.)

> +
> +	# don't test with the first device as auto fs check (_check_scratch_fs)
> +	# picks the first device
> +	device_1=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> +	$BTRFS_UTIL_PROG device add -f "$device_1" "$TEST_DIR"
> +
> +	device_2=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
> +	_mount -o degraded $device_2 $SCRATCH_MNT
> +	# Check if missing device is reported as in the 196.out

Test could be renumbered, no need to hardcode 196.out, just ".out file"
would be fine.

> +	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
> +						_filter_btrfs_filesystem_show
> +
> +	$BTRFS_UTIL_PROG device remove "$device_1" "$TEST_DIR"

I think we should remove $device_1 in _cleanup if it's not empty in case
test exits unexpectly. But as mentioned above, better to avoid adding
new device to $TEST_DIR.

Thanks,
Eryu

> +	_scratch_unmount
> +	_scratch_dev_pool_put
> +}
> +
> +workout "raid1" "2"
> +workout "raid5" "3"
> +workout "raid6" "4"
> +workout "raid10" "4"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/196.out b/tests/btrfs/196.out
> new file mode 100644
> index 000000000000..311ae9e2f46a
> --- /dev/null
> +++ b/tests/btrfs/196.out
> @@ -0,0 +1,25 @@
> +QA output created by 196
> +raid1
> +Label: none  uuid: <UUID>
> +	Total devices <NUM> FS bytes used <SIZE>
> +	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> +	*** Some devices missing
> +
> +raid5
> +Label: none  uuid: <UUID>
> +	Total devices <NUM> FS bytes used <SIZE>
> +	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> +	*** Some devices missing
> +
> +raid6
> +Label: none  uuid: <UUID>
> +	Total devices <NUM> FS bytes used <SIZE>
> +	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> +	*** Some devices missing
> +
> +raid10
> +Label: none  uuid: <UUID>
> +	Total devices <NUM> FS bytes used <SIZE>
> +	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> +	*** Some devices missing
> +
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 3ce6fa4628d8..c86ea2516397 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -198,3 +198,4 @@
>  193 auto quick qgroup enospc limit
>  194 auto volume
>  195 auto volume
> +196 auto quick volume
> -- 
> 1.8.3.1
> 
