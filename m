Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01406BED1A
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 10:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfIZIMl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 04:12:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43131 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfIZIMk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 04:12:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id v27so1113219pgk.10;
        Thu, 26 Sep 2019 01:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7h/Ek76QcPz6SQy9iyM21ULaECKE/xap1PTS1m34nno=;
        b=L+3DCOVYjo6021vg7X7u2yyVOO/9u0OX+2EPpa/AXYH8oSz2DCj09eS1IoP7NdyOli
         SXiE8i/020G0cPpflTzztVEfH9/9wU7+UBmXZRsxcyz/sNGIFf7PcwKnL4NhKrMHw77X
         xF9+7CKwGxqy+lr3RIThd53OS99aMaFdV97DavJKOYRZ6DVm2NihQbAdjFT+5Xwl9LCO
         LWMi0DVeBgtAYWIVRFQ1Ttbhr1wYJh/23tl+4DZlkOGLmG7S7KEWe1XEKqJJTbqQkIEL
         c5YuWHF4IehizBZozjNJLXVaFpTdEW9WqZEF13aVDT4WFJwU+xXAphgvAJFR0yB9NETL
         HR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7h/Ek76QcPz6SQy9iyM21ULaECKE/xap1PTS1m34nno=;
        b=UuKwf9bCgXNikeHclYiP1j3/tkMQvPfrHEIwGcxrsaBHjMmWIrb1bleQbGuf5vjlQi
         ZLTeG0EBAMdq+MJp9YxVXjT/9E6lGJjIcfbdYvWCcB8ZaxMYuYJTXfxSsmrAafob09Fx
         OXnD7qDtP+CvwQzDLrtaKchnW+e6EAEzpwayf6CIAzsJQzomfCL0XQFMejJ7V390Gmjm
         0pOZl+PB4FAPsJO8zyMCIydAD6Cx0xKYV2KcfsB55OUGnLGUyXf66X7dpSvzA+17rRRF
         /vAR8Y9ooppMLfZU7qDnHCI1r6w/+gm3SKATpjMkt4sj1aFXrRx+/CHqD9Cv3a9YnvBP
         XV4g==
X-Gm-Message-State: APjAAAW+ugltejV+mP5m9QhGb7bdgrlnIb/HPFR8os40xtyGPdvbqLFU
        YHhYei4D4rjKafKxR3YeeX+K9I6nBN7qlw==
X-Google-Smtp-Source: APXvYqy0itwxUckmdyDruJPYoOSKoerQNyL03ufdmbo/RDMYQjpC2iIgarcl21Rckj57J1YvvNAHZA==
X-Received: by 2002:a63:d909:: with SMTP id r9mr2085723pgg.381.1569485558885;
        Thu, 26 Sep 2019 01:12:38 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id 197sm2887775pge.39.2019.09.26.01.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 01:12:38 -0700 (PDT)
Date:   Thu, 26 Sep 2019 16:12:32 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCH] btrfs: Add regression test for SINGLE profile conversion
Message-ID: <20190926081230.GX2622@desktop>
References: <20190926072635.9310-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926072635.9310-1-nborisov@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 26, 2019 at 10:26:35AM +0300, Nikolay Borisov wrote:
> This is a regression test for the bug fixed by
> 'btrfs: Fix a regression which we can't convert to SINGLE profile'
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  tests/btrfs/194     | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/194.out |  2 ++
>  tests/btrfs/group   |  1 +
>  3 files changed, 55 insertions(+)
>  create mode 100755 tests/btrfs/194
>  create mode 100644 tests/btrfs/194.out
> 
> diff --git a/tests/btrfs/194 b/tests/btrfs/194
> new file mode 100755
> index 000000000000..8935defd3f5e
> --- /dev/null
> +++ b/tests/btrfs/194
> @@ -0,0 +1,52 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 194
> +#
> +# Test that block groups profile can be converted to SINGLE. This is a regression
> +# test for 'btrfs: Fix a regression which we can't convert to SINGLE profile'
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
> +_require_scratch_dev_pool 2
> +
> +_scratch_dev_pool_get 2
> +_scratch_pool_mkfs -draid1
> +
> +_scratch_mount 
> +
> +$BTRFS_UTIL_PROG balance start -dconvert=single $SCRATCH_MNT > $seqres.full 2>&1
> +[ $? -eq 0 ] || _fail "Convert failed"

This indicates we're missing profile conversion tests in fstests. I
think it's better to add a test framework/helpers and a full set of
profile conversion tests instead of this raid1->single special case.

e.g.

Define a test case array, which describes what's the src/dst of this
conversion and how many devices this case requires, e.g.

test_cases=(
        # $nr_dev_min:$metadata:$data:$metadata_convert:$data_convert
        "2:single:single:raid0:raid0"
        "2:single:single:raid1:raid1"
        "2:single:single:raid1:raid0"
        "3:single:single:raid5:raid5"
        "4:single:single:raid6:raid6"
        "4:single:single:raid10:raid10"
        "2:raid0:raid0:raid1:raid0"
        "2:raid0:raid0:raid1:raid1"
        "3:raid0:raid0:raid5:raid5"
        "4:raid0:raid0:raid6:raid6"
        "4:raid0:raid0:raid10:raid10"
        "2:raid1:raid0:raid1:raid1"
        "3:raid1:raid0:raid5:raid5"
        "4:raid1:raid0:raid6:raid6"
        "4:raid1:raid1:raid10:raid10"
        "4:raid5:raid5:raid1:raid1"
        "4:raid5:raid5:raid6:raid6"
        "4:raid5:raid5:raid10:raid10"
        "4:raid6:raid6:raid1:raid1"
        "4:raid6:raid6:raid5:raid5"
        "4:raid6:raid6:raid10:raid10"
        "4:raid10:raid10:raid5:raid5"
        "4:raid10:raid10:raid6:raid6"
	<adding more cases>
)

Then, create btrfs in source profile and populate fs with different
kinds of files, compute sha1 digests of these files(fssum?), start
conversion, after conversion compare sha1 digests.

And perhaps we could split the test cases into group and add them to
different tests, in case putting all cases in a single test makes the
test time too long.

Thanks,
Eryu

> +
> +_scratch_umount
> +_scratch_dev_pool_put
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
> index b92cb12ca66f..6a11eb1b8230 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -196,3 +196,4 @@
>  191 auto quick send dedupe
>  192 auto replay snapshot stress
>  193 auto quick qgroup enospc limit
> +194 auto quick volume balance
> -- 
> 2.7.4
> 
