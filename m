Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA3E27A16F
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Sep 2020 16:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgI0Oqp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Sep 2020 10:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgI0Oqo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Sep 2020 10:46:44 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19E9C0613CE;
        Sun, 27 Sep 2020 07:46:44 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l126so7025125pfd.5;
        Sun, 27 Sep 2020 07:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q28cYy5t0/CO8OKXuy8ZUb+Vrq9bonFEca6dHPm/P+g=;
        b=SVT4PBS7yqHZ3lWd7g4waQdY4K7c4g2WgFZaWh4V5Iz4xO3LNmtT89Zb8kKzTWneT7
         mei89Q8JxxGXZ+Ao3obCpm2EhGxXuW+o7bo78XVKD5UY9bJ/mmRBPJr5m+d3xvKKLoRp
         VIprM75dlXb8KSmrRFKdTA18ybYOTvn2cMEph0Ux1Wk+KweL6OyyhUoOBY2+57GhqcND
         +w68Nw5Ow7rRQJIn2ZoXnHy7R+YeNfyzm/tI3wZ7+PhNFb991jgrvcXhM1NJuTplcPTb
         ywBY8UGPjH5DSfdvRSR//UExXL9sMyQOaaZOGXDbGJqrqcIpcc+Big82H9mEzHTnVrqo
         yxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q28cYy5t0/CO8OKXuy8ZUb+Vrq9bonFEca6dHPm/P+g=;
        b=Na79E2EdXiMynm0IuIdNfJSl46p+aSfbAJfdFnp+Yl0C0klLchhRcx0HOQS69e0xsm
         S9haRlYzfuqf+066zPbjqw2acLCXgfGG3KPD76Hxhb/KaJllrNyPhW1tdYJAau+XPah7
         4dIfpr6Mpo/mgw1ER7JxlqDI4WnUZLVLBFYWQ1u7uEeU7F0bWtMY9VnXn/9WnUK8JkqC
         UcVCqugT+r1pGEsw+9sW2aG/bKrKLcQQ+KS9MibBVTDv2G59KcUI9IVP56bnS5CsXDVs
         SybcsOk6x7UrwGiQ7JdUKfcxJaS1ZFw6pGuq0WX9CulwO0s414wbg09Buk8J+he01Jf2
         rXmg==
X-Gm-Message-State: AOAM530Gi+Zdx+z3ElJkNj+4WWfDmvkF5YmuclyBL4U6UnE6+22W8DsS
        Xuv4vJR9vneXwPYSijEmnD9AxgBPDbII2CMb
X-Google-Smtp-Source: ABdhPJzLhDKUw9ZPwg4zlijm97T8o8fD/ITyzW8dpPuKfnju0wanD7/2fP3Wtkx764J/rVmVSkjxGA==
X-Received: by 2002:a63:e655:: with SMTP id p21mr5920659pgj.420.1601218004240;
        Sun, 27 Sep 2020 07:46:44 -0700 (PDT)
Received: from realwakka ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id l11sm4162698pjf.17.2020.09.27.07.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 07:46:43 -0700 (PDT)
Date:   Sun, 27 Sep 2020 14:46:33 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Qu Wenruo <wqu@suse.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v4] btrfs: Add new test for qgroup assign functionality
Message-ID: <20200927144633.GA1172@realwakka>
References: <20200924144348.46203-1-realwakka@gmail.com>
 <20200927095707.GS3853@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927095707.GS3853@desktop>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 27, 2020 at 05:57:07PM +0800, Eryu Guan wrote:
> On Thu, Sep 24, 2020 at 02:43:48PM +0000, Sidong Yang wrote:
> > This new test will test btrfs's qgroup assign functionality. The
> > test has 3 cases.
> > 
> >  - assign, no shared extents
> >  - assign, shared extents
> >  - snapshot -i, shared extents
> > 
> > Each cases create subvolumes and assign qgroup in their own way
> > and check with the command "btrfs check".
> > 
> > Cc: Qu Wenruo <wqu@suse.com>
> > Cc: Eryu Guan <guan@eryu.me>
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> > v2:
> >  - Create new test and use the cases
> > v3:
> >  - Fix some minor mistakes
> >  - Make that write some data before assign or snapshot in test
> >  - Put mkfs & mount pair in test function
> > v4:
> >  - Add rescan command for assign no shared
> >  - Use _check_scratch_fs for checking  
> > ---
> >  tests/btrfs/221     | 116 ++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/221.out |   2 +
> >  tests/btrfs/group   |   1 +
> >  3 files changed, 119 insertions(+)
> >  create mode 100755 tests/btrfs/221
> >  create mode 100644 tests/btrfs/221.out
> > 
> > diff --git a/tests/btrfs/221 b/tests/btrfs/221
> > new file mode 100755
> > index 00000000..6b7c9674
> > --- /dev/null
> > +++ b/tests/btrfs/221
> > @@ -0,0 +1,116 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2020 Sidong Yang.  All Rights Reserved.
> > +#
> > +# FS QA Test 221
> > +#
> > +# Test the assign functionality of qgroups
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +. ./common/reflink
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs btrfs
> > +_supported_os Linux
> > +
> > +_require_scratch
> > +_require_btrfs_qgroup_report
> > +_require_cp_reflink
> > +
> > +# Test assign qgroup for submodule with shared extents by reflink
> > +assign_shared_test()
> > +{
> > +	_scratch_mkfs > /dev/null 2>&1
> > +	_scratch_mount
> > +
> > +	echo "=== qgroup assign shared test ===" >> $seqres.full
> > +	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> > +	$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
> > +
> > +	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
> > +	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/b >> $seqres.full
> > +
> > +	_ddt of="$SCRATCH_MNT"/a/file1 bs=1M count=1 >> $seqres.full 2>&1
> > +	cp --reflink=always "$SCRATCH_MNT"/a/file1 "$SCRATCH_MNT"/b/file1
> 
> There's a helper to do this, _cp_reflink.
> 
> > +
> > +	$BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
> > +	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/a 1/100 $SCRATCH_MNT
> > +	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/b 1/100 $SCRATCH_MNT
> > +
> > +	_scratch_unmount
> > +	_check_scratch_fs
> > +}
> > +
> > +# Test assign qgroup for submodule without shared extents
> > +assign_no_shared_test()
> > +{
> > +	_scratch_mkfs > /dev/null 2>&1
> > +	_scratch_mount
> > +
> > +	echo "=== qgroup assign no shared test ===" >> $seqres.full
> > +	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> > +	$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full	
> 
> Trailing whitespace in above line.
> 
> > +
> > +	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
> > +	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/b >> $seqres.full
> > +	
> 
> Trailing whitespace in above line.
> 
> > +	$BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
> > +	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/a 1/100 $SCRATCH_MNT
> > +	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/b 1/100 $SCRATCH_MNT
> > +	
> 
> Trailing whitespace in above line.
> 
> > +	_scratch_unmount
> > +	_check_scratch_fs
> > +}
> > +
> > +# Test snapshot with assigning qgroup for submodule
> > +snapshot_test()
> > +{
> > +	_scratch_mkfs > /dev/null 2>&1
> > +	_scratch_mount
> > +
> > +	echo "=== qgroup snapshot test ===" >> $seqres.full
> > +	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> > +	$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
> > +
> > +	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
> > +	_ddt of="$SCRATCH_MNT"/a/file1 bs=1M count=1 >> $seqres.full 2>&1
> > +	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
> > +	$BTRFS_UTIL_PROG subvolume snapshot -i 0/$subvolid $SCRATCH_MNT/a $SCRATCH_MNT/b >> $seqres.full
> > +	
> 
> Trailing whitespace in above line.
> 
> > +	_scratch_unmount
> > +	_check_scratch_fs	
> 
> Trailing whitespace in above line.
> 
> Otherwise looks fine.
> 
> Thanks,
> Eryu

Thanks Eryu!
I've submitted a new patch for this.
Could you check it for me?

Thanks,
Sidong

> 
> > +}
> > +
> > +
> > +assign_no_shared_test
> > +
> > +assign_shared_test
> > +
> > +snapshot_test
> > +
> > +# success, all done
> > +echo "Silence is golden"
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/221.out b/tests/btrfs/221.out
> > new file mode 100644
> > index 00000000..aa4351cd
> > --- /dev/null
> > +++ b/tests/btrfs/221.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 221
> > +Silence is golden
> > diff --git a/tests/btrfs/group b/tests/btrfs/group
> > index 1b5fa695..cdda38f3 100644
> > --- a/tests/btrfs/group
> > +++ b/tests/btrfs/group
> > @@ -222,3 +222,4 @@
> >  218 auto quick volume
> >  219 auto quick volume
> >  220 auto quick
> > +221 auto quick qgroup
> > -- 
> > 2.25.1
