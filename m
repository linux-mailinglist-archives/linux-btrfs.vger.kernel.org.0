Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2554328A5DD
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Oct 2020 08:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgJKGN1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Oct 2020 02:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgJKGN1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Oct 2020 02:13:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E35DC0613CE;
        Sat, 10 Oct 2020 23:13:26 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id u24so10984079pgi.1;
        Sat, 10 Oct 2020 23:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HVxeznub2EIoRkzXrms9sz9JcvVi3jKYOyxnRqiXeTE=;
        b=o41c9LtQHDPNwKr4DRRRuqMx2HOetW7fwiVbRRP1MSRh9Oadq8TxzrNHn9XJwok7VD
         xaJPulpKvNV+MSzVX//Rzcle37MfaYWh7m2c8T/a8EMWgvILsU/0X48tWunT4HIduNvJ
         WIIDrvxgZr4OM0Y2xa9WlD0K7SXYBgONg/4cHztEZMbwWZj4uMSsF7T8oIEVyCInotZi
         Weh8sSJhHFVUby8qqU/h3m63XCyuDK3ORt0YknUrtnvR+qiu/a7VfXN7c6njaCz/m9j1
         D7XQ8t8LaWjbbln6BOY+Limd02TyM/SNQq8SrQ5+6juSf5hbb195KV2/Cr7LM4pUYa2Z
         cnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HVxeznub2EIoRkzXrms9sz9JcvVi3jKYOyxnRqiXeTE=;
        b=L9STdXORhi6s/wbwyDvYpOE180Rt606kj8B0OcnA8MHb/SMpRFOrdfgPECLxsJPkMl
         2o6mlEK6psnPCvlMJiPJcAeN2w5PaXONDwoyX+kbqHIWUVV0QSonlXF/9JBMj3Ds6uzL
         yJD796lfms6MtumatzjhM2TvHm7T2WtUlo1VGAHEOyqPt6Hj7ZLdqAqovMOF3hixLtjg
         sDGjteSYl9hy6kQzxfAovbY3PTc7uOPk/SRsho+Gv2Ya0xCo3KgfhSizWqWSinx3D9Eq
         Jp8ecajLcdLCan8irkSu986M8dUokABMsgLCbjZOGhQkHdxMkFp7V5ho05PvL79z0byy
         uX4A==
X-Gm-Message-State: AOAM533a+Bh1v2ZXhKEss/rv+IZf0Abxhw8c9HMSY0q3FgMDbX9yTpD8
        0IUo2UfsWmXrVNgfaoSBcRWu1NPNbMQBNA==
X-Google-Smtp-Source: ABdhPJx1BJ7/Ks+4kzb62VNbnGZN6k3IBnn76akwDp63ix/h1Ar6xN4L7THIfhikcwg0JjqkkmqmQQ==
X-Received: by 2002:a17:90a:6b0d:: with SMTP id v13mr13721867pjj.206.1602396805503;
        Sat, 10 Oct 2020 23:13:25 -0700 (PDT)
Received: from realwakka ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id d2sm9881736pjx.4.2020.10.10.23.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2020 23:13:24 -0700 (PDT)
Date:   Sun, 11 Oct 2020 06:13:12 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Qu Wenruo <wqu@suse.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v5] btrfs: Add new test for qgroup assign functionality
Message-ID: <20201011061312.GA2898@realwakka>
References: <20200927171512.1253-1-realwakka@gmail.com>
 <20201011031457.GT3853@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201011031457.GT3853@desktop>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 11, 2020 at 11:14:57AM +0800, Eryu Guan wrote:
> On Sun, Sep 27, 2020 at 05:15:12PM +0000, Sidong Yang wrote:
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
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > Reviewed-by: Qu Wenruo <wqu@suse.com>
> > Reviewed-by: Eryu Guan <guan@eryu.me>
> 
> Please don't add "Reviewed-by" tag before it's provided explicitly,
> Qu and I have given review comments but that doesn't mean we provide a
> "Reviewed-by" tag.

Thanks! I should take care of it next time.

> 
> > 
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
> > v5:
> >  - Remove trailing whitespaces
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
> > index 00000000..19b3740b
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
> Seems you miss the comment about using "_cp_reflink" helper.

Yes, I missed it sorry. 
I'll write a new patch right away.
Thanks so much!

Thanks,
Sidong
> 
> Thanks,
> Eryu
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
> > +
> > +	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
> > +	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/b >> $seqres.full
> > +
> > +	$BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
> > +	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/a 1/100 $SCRATCH_MNT
> > +	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/b 1/100 $SCRATCH_MNT
> > +
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
> > +	_scratch_unmount
> > +	_check_scratch_fs
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
