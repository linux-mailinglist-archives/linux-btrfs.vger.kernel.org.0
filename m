Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430FB276791
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 06:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgIXEOm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 00:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgIXEOl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 00:14:41 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E690C0613CE;
        Wed, 23 Sep 2020 21:14:41 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d19so984164pld.0;
        Wed, 23 Sep 2020 21:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=O9eU9IcMxwOkpeCw15QJZfSZ7Wwg0QQAR4KazDUkrUE=;
        b=ML8VRNVeXCIB4opv/HtFiw/XOLs4e0LOSdRp9RrB+5i7TKAnjjoiJn25pGq/RKoiGm
         pmxqN79+DwIUz9fBmZXnJxyforFSLXuMov4x1IB2KzLwJde7JYeIoU9ILXTYy6feWJOc
         giuwyXbZyyMbTY4w3oLQDBLXglRaWldcxlYpKevYAerXIMcjHbXqOlX3Xjj1SgdCuN/4
         /tIhOPuk/UUnxZmQeLE1jhNiwh8TYyg7OaA5HaJBlsg4WH4gccURZniHvxVREnLY/IxW
         FnTyD31dgJnRY/5yxFanklo5poyXfo/R13RGYUye6g9Kr0snahMm5a4DNSGXx50Ku5ZS
         CbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=O9eU9IcMxwOkpeCw15QJZfSZ7Wwg0QQAR4KazDUkrUE=;
        b=PIUG0M+QUzrFc7EpJcMvYZJIUzmXpMjsxapk9/y3kgQXelkP/ESOQK5SFITKroV+Aj
         S4I+Z2QZK3Xx+FYeb63yMRy0LrK0OTLPd5/bF/uDRYSyapbj6fbD9ttyCARNf/QJjl8x
         Omgcau/CRV+X2eegurQp6LAbcYfuGbj7RK8Cg8t6lPfIHr9+LWvwGak1wkDk0WcDf7W/
         fLNd0N0v2rGVSRSkJqE3p+d9Paa1w8SHjCqXGS3F2B92ntTUqKgod1mwri7swVUAA6ZL
         ZflNv0iqA7xbE1BNHJpyxMqrkWciWoDzISpolTh/HYVFw50QRIiZ2G+4MsQmwpy4HT1R
         Ueiw==
X-Gm-Message-State: AOAM530ZayoTPRqkdzfxtBgxHrAdmFcAnBycr/Yv8e83mmuHqlx2iiYt
        nVDpHeGoZYnSR/4Bik8n5Wg=
X-Google-Smtp-Source: ABdhPJzOLgImCnF6LRWF2PaM166Keus6W/4ceFOGiMy+BqqNM1f/Prc5BJYu7d6ypPGAv3Lae9MvuQ==
X-Received: by 2002:a17:902:b186:b029:d1:cc21:9a7d with SMTP id s6-20020a170902b186b02900d1cc219a7dmr2734309plr.8.1600920879790;
        Wed, 23 Sep 2020 21:14:39 -0700 (PDT)
Received: from realwakka ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id gn24sm808852pjb.8.2020.09.23.21.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 21:14:39 -0700 (PDT)
Date:   Thu, 24 Sep 2020 04:14:29 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Qu Wenruo <wqu@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Eryu Guan <guan@eryu.me>
Subject: Re: [PATCH v2] btrfs: Add new test for qgroup assign functionality
Message-ID: <20200924041429.GA30950@realwakka>
References: <20200922153604.10004-1-realwakka@gmail.com>
 <de490dbb-6fd2-be19-54b5-7e4a4c5e10c5@gmx.com>
 <20200923165028.GA1091@realwakka>
 <0a1b6b19-20bf-b278-13a5-89543e9b7997@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a1b6b19-20bf-b278-13a5-89543e9b7997@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 24, 2020 at 08:48:20AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/9/24 上午12:50, Sidong Yang wrote:
> > On Wed, Sep 23, 2020 at 09:55:02AM +0800, Qu Wenruo wrote:
> >>
> >>
> >> On 2020/9/22 下午11:36, Sidong Yang wrote:
> >>> This new test will test btrfs's qgroup assign functionality. The
> >>> test has 3 cases.
> >>>
> >>>  - assign, no shared extents
> >>>  - assign, shared extents
> >>>  - snapshot -i, shared extents
> >>>
> >>> Each cases create subvolumes and assign qgroup in their own way
> >>> and check with the command "btrfs check".
> >>>
> >>> Cc: Qu Wenruo <wqu@suse.com>
> >>> Cc: Eryu Guan <guan@eryu.me>
> >>>
> >>> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> >>> ---
> >>> v2: create new test and use the cases
> >>> ---
> >>>  tests/btrfs/221     | 121 ++++++++++++++++++++++++++++++++++++++++++++
> >>>  tests/btrfs/221.out |   2 +
> >>>  tests/btrfs/group   |   1 +
> >>>  3 files changed, 124 insertions(+)
> >>>  create mode 100755 tests/btrfs/221
> >>>  create mode 100644 tests/btrfs/221.out
> >>>
> >>> diff --git a/tests/btrfs/221 b/tests/btrfs/221
> >>> new file mode 100755
> >>> index 00000000..7fe5d78f
> >>> --- /dev/null
> >>> +++ b/tests/btrfs/221
> >>> @@ -0,0 +1,121 @@
> >>> +#! /bin/bash
> >>> +# SPDX-License-Identifier: GPL-2.0
> >>> +# Copyright (c) 2020 YOUR NAME HERE.  All Rights Reserved.
> >>
> >> So, "YOUR NAME HERE" is your name? :)
> > 
> > Oops! I missed it.
> > 
> >>
> >>> +#
> >>> +# FS QA Test 221
> >>> +#
> >>> +# Test the assign functionality of qgroups
> >>> +#
> >>> +seq=`basename $0`
> >>> +seqres=$RESULT_DIR/$seq
> >>> +echo "QA output created by $seq"
> >>> +
> >>> +here=`pwd`
> >>> +tmp=/tmp/$$
> >>> +status=1	# failure is the default!
> >>> +trap "_cleanup; exit \$status" 0 1 2 3 15
> >>> +
> >>> +_cleanup()
> >>> +{
> >>> +	cd /
> >>> +	rm -f $tmp.*
> >>> +}
> >>> +
> >>> +# get standard environment, filters and checks
> >>> +. ./common/rc
> >>> +. ./common/filter
> >>> +. ./common/reflink
> >>> +
> >>> +# remove previous $seqres.full before test
> >>> +rm -f $seqres.full
> >>> +
> >>> +# real QA test starts here
> >>> +
> >>> +# Modify as appropriate.
> >>> +_supported_fs generic
> >>
> >> It's a btrfs specific test.
> > Thanks!
> >>
> >>> +_supported_os Linux
> >>> +
> >>> +_require_test
> >>
> >> You don't need test_dev at all.
> > Yeah, I just realized that I used only scratch dev noy test dev.
> > Thanks!
> >>
> >>> +_require_scratch
> >>> +_require_btrfs_qgroup_report
> >>> +_require_cp_reflink
> >>> +
> >>> +# Test assign qgroup for submodule with shared extents by reflink
> >>> +assign_shared_test()
> >>> +{
> >>> +	echo "=== qgroup assign shared test ===" >> $seqres.full
> >>> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
> >>
> >> I'm not sure if _run_btrfs_util_prog is still recommended.
> >> IIRC nowadays we recommend to call $BTRFS_UTIL_PROG directly.
> >>
> >> Test case btrfs/193 would be the example.
> > It's good to replace it! Thanks.
> >>
> >>> +	_run_btrfs_util_prog qgroup create 1/100 $SCRATCH_MNT
> >>> +
> >>> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
> >>> +	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
> >>> +	_run_btrfs_util_prog qgroup assign 0/$subvolid 1/100 $SCRATCH_MNT
> >>
> >> "btrfs qgroup assign" can take path directly. This would save your some
> >> lines. E.g:
> >>
> >>   # btrfs qgroup create 1/100 /mnt/btrfs/
> >>   # btrfs qgroup assign /mnt/btrfs/ 1/100 /mnt/btrfs/
> >>   # btrfs qgroup  show -pc /mnt/btrfs/
> >>   qgroupid         rfer         excl parent  child
> >>   --------         ----         ---- ------  -----
> >>   0/5          16.00KiB     16.00KiB 1/100   ---
> >>   1/100        16.00KiB     16.00KiB ---     0/5
> > Thanks for good tip!
> > 
> >>
> >>> +
> >>> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/b
> >>> +	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT b)
> >>> +	_run_btrfs_util_prog qgroup assign 0/$subvolid 1/100 $SCRATCH_MNT
> >>
> >> Shouldn't this assign happens when we have shared extents between the
> >> two subvolumes?
> >>
> >> Now you're just testing the basic qgroup functionality of accounting,
> >> not assign.
> >>
> >> For real assign tests, what we want is either:
> >> - After assign, qgroup accounting is still correct
> >>   We don't need even to rescan.
> >>   And "btrfs check" will verify the numbers are correct.
> >>
> >> - After assign, qgroup accounting is inconsistent
> >>   At least we should either have qgroup inconsistent bit set, or qgroup
> >>   rescan kicked in automatically.
> >>   And "btrfs check" will skip the qgroup numbers.
> >>
> >> But in your case, we're assigning two empty subovlumes into the same
> >> qgroup, then do some operations.
> >> This only covers the "assign, no shared extents" case.
> > 
> > You mean that there should be some data with reflink before assigning?
> > If so, the code below should be executed before assigning qgroups.
> > Should test process be like this?
> > make submodules -> make data -> copy with reflink -> assign qgroup
> 
> Yep.
> 
> Furthermore, we should have qgroup enabled/rescanned before make subvolumes.
> > 
> >>
> >>> +	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> >>> +
> >>> +	_ddt of="$SCRATCH_MNT"/a/file1 bs=1M count=1 >> $seqres.full 2>&1
> >>> +	cp --reflink=always "$SCRATCH_MNT"/a/file1 "$SCRATCH_MNT"/b/file1 >> $seqres.full 2>&1
> >>> +
> >>> +	_scratch_unmount
> >>
> >> Since you're unmounting here, why not keep the _scratch_mkfs and
> >> _scratch_unmount pair in the same function?
> >>
> >>> +	_run_btrfs_util_prog check $SCRATCH_DEV
> >>> +}
> >>> +
> >>> +# Test assign qgroup for submodule without shared extents
> >>> +assign_no_shared_test()
> >>> +{
> >>> +	echo "=== qgroup assign no shared test ===" >> $seqres.full
> >>> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
> >>> +	_run_btrfs_util_prog qgroup create 1/100 $SCRATCH_MNT
> >>> +
> >>> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
> >>> +	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
> >>> +	_run_btrfs_util_prog qgroup assign 0/$subvolid 1/100 $SCRATCH_MNT
> >>> +
> >>> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/b
> >>> +	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT b)
> >>> +	_run_btrfs_util_prog qgroup assign 0/$subvolid 1/100 $SCRATCH_MNT
> >>> +
> >>> +	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> >>
> >> No, we don't want rescan.
> >>
> >> And the timing is still wrong.
> > Yeah, I'll delete it.
> >>
> >>> +	_scratch_unmount
> >>> +
> >>> +	_run_btrfs_util_prog check $SCRATCH_DEV
> >>> +}
> >>> +
> >>> +# Test snapshot with assigning qgroup for submodule
> >>> +snapshot_test()
> >>> +{
> >>> +	echo "=== qgroup snapshot test ===" >> $seqres.full
> >>> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
> >>> +
> >>> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
> >>> +	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
> >>> +
> >>> +	_run_btrfs_util_prog subvolume snapshot -i 0/$subvolid $SCRATCH_MNT/a $SCRATCH_MNT/b
> >>> +	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT b)
> >>
> >> Even we're snapshotting on the source subvolume, since it's empty, we
> >> will only copy the root item, resulting two empty subvolumes without
> >> sharing anything.
> >>
> >> You need to at least fill the source subvolumes with some data.
> >> It's better to bump the tree level with some inline extents.
> > 
> > I should write some data before snapshot. is it right?
> 
> Right. That's the bare minimal.
> 
> Thanks,
> qu

Thanks so much! I've written a new patch just before.
Could you review it please?

Thanks,
Sidong

> 
> > Thanks for all your comments.
> > 
> > Thanks,
> > Sidong
> > 
> >>
> >> Thanks,
> >> Qu
> >>
> >>> +
> >>> +	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> >>> +	_scratch_unmount
> >>> +
> >>> +	_run_btrfs_util_prog check $SCRATCH_DEV
> >>> +}
> >>> +
> >>> +
> >>> +_scratch_mkfs > /dev/null 2>&1
> >>> +_scratch_mount
> >>> +assign_no_shared_test
> >>> +
> >>> +_scratch_mkfs > /dev/null 2>&1
> >>> +_scratch_mount
> >>> +assign_shared_test
> >>> +
> >>> +_scratch_mkfs > /dev/null 2>&1
> >>> +_scratch_mount
> >>> +snapshot_test
> >>> +
> >>> +# success, all done
> >>> +echo "Silence is golden"
> >>> +status=0
> >>> +exit
> >>> diff --git a/tests/btrfs/221.out b/tests/btrfs/221.out
> >>> new file mode 100644
> >>> index 00000000..aa4351cd
> >>> --- /dev/null
> >>> +++ b/tests/btrfs/221.out
> >>> @@ -0,0 +1,2 @@
> >>> +QA output created by 221
> >>> +Silence is golden
> >>> diff --git a/tests/btrfs/group b/tests/btrfs/group
> >>> index 1b5fa695..cdda38f3 100644
> >>> --- a/tests/btrfs/group
> >>> +++ b/tests/btrfs/group
> >>> @@ -222,3 +222,4 @@
> >>>  218 auto quick volume
> >>>  219 auto quick volume
> >>>  220 auto quick
> >>> +221 auto quick qgroup
> >>>
> >>
> > 
> > 
> > 
> 



