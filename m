Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62194DC0A7
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2019 11:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505062AbfJRJNx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 05:13:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35473 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731444AbfJRJNx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 05:13:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id c3so2560197plo.2;
        Fri, 18 Oct 2019 02:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lozbRcCvxJztvPerdircEnIU3t776F+eRATBcFXanM8=;
        b=X29P4OXGk1zL283iI90L9lIzfRGYw1aFSR8B0AA7fKffmDwfqAocs+LJg4kDfVzcR2
         fJm+0/+5VTxL1TTYUb9W3fqjSKPneiOYpI+zxpWR+Cmhg+ZMhe6KwuV/gr0vMjP9qqGA
         BQP1nXNTmEMb9h2nmk2SfaBbyjxCh8J7Tua253YBGIi0TLiSwFkE4XpU6bVGzu4wrIDS
         mecknFilD21g6qHnQIaMJ4yi0jckhBpJmP3mhREwmnZEpCh1xBps1k4M9hTfPGRNG3Iq
         lsrq1BndNrlpR7jNLLiz+hz/QISciUkNueXIYFo/NabArxrrNdsu+9hMMPPErrNxlrt1
         HaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lozbRcCvxJztvPerdircEnIU3t776F+eRATBcFXanM8=;
        b=UeNtxbwSblFdJ+hppFMO9j7vOyatLeTiQyQhKc+bEK24MkWRxrATZTETo25u4yA4YP
         wL3X/TO5Jj2oITZ4i0c8nJn+lvPXQpScVynoz5PERknrITFWmNXVqd0iGbUrSqLCV/9Z
         dRX2ZlkKlQtf3Wv2X5RVMJoyl0yj0C74V2JydlcZK55dKa3Wb08x19gz4aAclvY/DyB9
         Fdl6ekgyQZn4DYAOGr6uTv/1z32CTdpbpreaxC5nKDsE+y+9t2mE7lz/ZhTTO8Bhj8QP
         F7W0bWvboHcQYAQtTDIs0Ynz7McvfREt7S+EsyH8+NpBrWPM4bQ1R6yrq8lwe5N1d5WR
         djsw==
X-Gm-Message-State: APjAAAWRezDNvU5p0xuHfuqJ+wwQlswxmPOxuTt5gK4Nifh63H4nP3ul
        7c+aH3LgST0FzqbESPZJHoPlvrbRId4=
X-Google-Smtp-Source: APXvYqwDCNLEajs8Ut1Suk7aqb/YKfr1a4hlBArwSb6Zc6N2v9O1kAu8h33qJ20OQtxleMlKsG/qNw==
X-Received: by 2002:a17:902:6b08:: with SMTP id o8mr8895881plk.152.1571390030533;
        Fri, 18 Oct 2019 02:13:50 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id w2sm5133887pgr.78.2019.10.18.02.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 02:13:49 -0700 (PDT)
Date:   Fri, 18 Oct 2019 17:13:44 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] fstest: btrfs/197: test for alien devices
Message-ID: <20191018091344.GL2622@desktop>
References: <20191007094101.784-1-anand.jain@oracle.com>
 <20191007094101.784-2-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007094101.784-2-anand.jain@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 05:41:01PM +0800, Anand Jain wrote:
> Test if btrfs.ko sucessfully identifies and reports the missing device,
> if the missed device contians no btrfs magic string.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/197     | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/197.out | 25 +++++++++++++++++
>  tests/btrfs/group   |  1 +
>  3 files changed, 105 insertions(+)
>  create mode 100755 tests/btrfs/197
>  create mode 100644 tests/btrfs/197.out
> 
> diff --git a/tests/btrfs/197 b/tests/btrfs/197
> new file mode 100755
> index 000000000000..82e1a299ca43
> --- /dev/null
> +++ b/tests/btrfs/197
> @@ -0,0 +1,79 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 197
> +#
> +# Test stale and alien device in the fs devices list.
> +# Similar to the testcase btrfs/196 except that here the alien device no more
> +# contains the btrfs superblock.
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
> +_require_command "$WIPEFS_PROG" wipefs
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

Stale comments above.

Otherwise looks fine to me.

> +
> +	# don't test with the first device as auto fs check (_check_scratch_fs)
> +	# picks the first device
> +	device_1=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> +	$WIPEFS_PROG -a $device_1 >> $seqres.full 2>&1

If creating a new btrfs works for btrfs/196, I wonder if we could merge
the two tests into one test, firstly create a new fs & degraded mount,
then wipefs & degraded mount.

Thanks,
Eryu

> +
> +	device_2=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
> +	_mount -o degraded $device_2 $SCRATCH_MNT
> +	# Check if missing device is reported as in the 196.out
> +	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
> +						_filter_btrfs_filesystem_show
> +
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
> diff --git a/tests/btrfs/197.out b/tests/btrfs/197.out
> new file mode 100644
> index 000000000000..79237b854b5a
> --- /dev/null
> +++ b/tests/btrfs/197.out
> @@ -0,0 +1,25 @@
> +QA output created by 197
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
> index c86ea2516397..f2eac5c20712 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -199,3 +199,4 @@
>  194 auto volume
>  195 auto volume
>  196 auto quick volume
> +197 auto quick volume
> -- 
> 1.8.3.1
> 
