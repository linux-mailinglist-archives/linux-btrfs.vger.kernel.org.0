Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E878CCBD7
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Oct 2019 19:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfJERyE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Oct 2019 13:54:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43784 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfJERyE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Oct 2019 13:54:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id v27so5581923pgk.10;
        Sat, 05 Oct 2019 10:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1NK3bFr9WcTGunAh+IYyae+fsnerpgCiQm20MSwF5ak=;
        b=CwYMjgZREbBR9fI1Ktccb5ffDHuFs0mDeG+KwATznfgqX89rzIZPTqPoWm3K+1qdms
         VZJjjh+8iSmqEHKSt6l7QSmqvgu36D0RhZ+iY6xWd2oHUyiGoVDDW+UiqGegUj78hv/G
         2pyCpk7BntsaQziTNQd0Z2jxInjsi8vNAwb3xnm1LEoLgDAwL1O3CbAbl8i8I08f4gDQ
         dq/jveotOdd2dHHKu/mUEsCFsuSYlGCGYY3ncUBxVV6040ShyhiEcDdTAYwQPAusVWIU
         Y0CzZoZv+EuEC7yjQH6qo0ZiHP2MjrEqfsuZOGRRJstODvSTB9LsqmCcovv+ox/z9z5q
         GgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1NK3bFr9WcTGunAh+IYyae+fsnerpgCiQm20MSwF5ak=;
        b=nmew7/OyVfnxA4ykUWbi4/AILavq0ZJQBC+XkHG/9fx4tTSXeNMSlcep/a8RkhCoQX
         WsjNqUs02RHNIEjRstDjjDziRGJgox4oHmeu2IT/P+b+/eOOjl4kLKw940L0rBMZDp40
         LKvN+mUOfEzk5DobHr16N7qXal+CWzWuNij9sO2irr3/MvBt/9VIb16JDn5H7j7NL+Tc
         FTqG77C0kxdfm1yAu4somfRydE9XkR/iHuqw0fXydF7sRmhQtM4Uo4yMRXyIsTaqCyjW
         7j5gSv4bJBC05II3T4uzQoBV4qj45BWqR2S4Tv6LtxrfqwdU3fh72OcZtoVF/GuHQp7r
         kCWQ==
X-Gm-Message-State: APjAAAUZCB+u7wglche6mQb0X1b/VqzIykYzInc3qO7cPVbb7hImSdx3
        NekBkO9bappUCIZZDCXxbnI=
X-Google-Smtp-Source: APXvYqxXgQWAIVdXWE4RGAzdBvmAHWC4zbhRvaoqsKfY2kCVDEBbpMrMVrEv5gWb6zzt33zQfG1d3Q==
X-Received: by 2002:a17:90a:a2b:: with SMTP id o40mr24218059pjo.107.1570298043108;
        Sat, 05 Oct 2019 10:54:03 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id r24sm9745640pfh.69.2019.10.05.10.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 10:54:02 -0700 (PDT)
Date:   Sun, 6 Oct 2019 01:53:57 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: Add test for btrfs balance convert
 functionality
Message-ID: <20191005175354.GD2622@desktop>
References: <20191001090419.22153-1-nborisov@suse.com>
 <20191001090419.22153-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001090419.22153-2-nborisov@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

On Tue, Oct 01, 2019 at 12:04:19PM +0300, Nikolay Borisov wrote:
> Add basic test to ensure btrfs conversion functionality is tested. This test
> exercies conversion to all possible types of the data portion. This is sufficient
> since from the POV of relocation we are only moving blockgroups. 
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Would you please help review this v2 as well? Thanks a lot!

Eryu

> ---
>  tests/btrfs/194     | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/194.out |  2 ++
>  tests/btrfs/group   |  1 +
>  3 files changed, 87 insertions(+)
>  create mode 100755 tests/btrfs/194
>  create mode 100644 tests/btrfs/194.out
> 
> diff --git a/tests/btrfs/194 b/tests/btrfs/194
> new file mode 100755
> index 000000000000..39b6e0a969c1
> --- /dev/null
> +++ b/tests/btrfs/194
> @@ -0,0 +1,84 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 194
> +#
> +# Test raid profile conversion. It's sufficient to test all dest profiles as 
> +# source profiles just rely on being able to read the metadata. 
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
> +_require_scratch_dev_pool 4
> +
> +
> +declare -a TEST_VECTORS=(
> +# $nr_dev_min:$data:$metadata:$data_convert:$metadata_convert
> +"4:single:raid1"
> +"4:single:raid0"
> +"4:single:raid10"
> +"4:single:dup"
> +"4:single:raid5"
> +"4:single:raid6"
> +"2:raid1:single"
> +)
> +
> +run_testcase() {
> +	IFS=':' read -ra args <<< $1
> +	num_disks=${args[0]}
> +	src_type=${args[1]}
> +	dst_type=${args[2]}
> +
> +	_scratch_dev_pool_get $num_disks
> +
> +	echo "=== Running test: $1 ===" >> $seqres.full 
> +
> +	_scratch_pool_mkfs -d$src_type >> $seqres.full 2>&1
> +	_scratch_mount 
> +
> +	# Create random filesystem with 20k write ops
> +	run_check $FSSTRESS_PROG -d $SCRATCH_MNT -w -n 10000 $FSSTRESS_AVOID
> +
> +	$BTRFS_UTIL_PROG balance start -f -dconvert=$dst_type $SCRATCH_MNT >> $seqres.full 2>&1
> +	[ $? -eq 0 ] || echo "$1: Failed convert"
> +
> +	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> +	[ $? -eq 0 ] || echo "$1: Scrub failed"
> +
> +	_scratch_unmount
> +	_check_btrfs_filesystem $SCRATCH_DEV
> +	_scratch_dev_pool_put
> +}
> +
> +for i in "${TEST_VECTORS[@]}"; do 
> +	run_testcase $i
> +done
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/194.out b/tests/btrfs/194.out
> new file mode 100644
> index 000000000000..7bfd50ffb5a4
> --- /dev/null
> +++ b/tests/btrfs/194.out
> @@ -0,0 +1,2 @@
> +QA output created by 194
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index b92cb12ca66f..a2c0ad87d0f6 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -196,3 +196,4 @@
>  191 auto quick send dedupe
>  192 auto replay snapshot stress
>  193 auto quick qgroup enospc limit
> +194 auto volume balance
> -- 
> 2.7.4
> 
