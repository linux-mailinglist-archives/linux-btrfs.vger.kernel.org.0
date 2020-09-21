Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550962718DB
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 02:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgIUAzp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Sep 2020 20:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIUAzp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Sep 2020 20:55:45 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE95C061755;
        Sun, 20 Sep 2020 17:55:45 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 7so7464852pgm.11;
        Sun, 20 Sep 2020 17:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ygTGQtlvHxCxEH9uG0f8lrwshg3qNyL8NnJCyUolwZ4=;
        b=FiuoMToWvXmKp6vPksgDVFt70jLke6TEY2UUJkjqvgEcjIwOXdTPKpW5Q0YMBcD7MD
         UNfgr5Te/nPLAjzk41ZF0VzGb8MoVijhXMmHhmk4o43MRS7b0B4YWewCAWW9588EuErQ
         45O7n1WMJZBzSRrsSaUqf1kNkEjDn1GVY6jOGMY3PhI1OleHifARfD2hi/hthwufA/kb
         oMTz/u+3v/xZ2ufcAq4YJ15QwE4Mcrr0Phk3pmSY8XH2sjKDa4yheL+cFGQIph13qdNV
         qQv48fULtIwFaSB1F4YgELPAHaeTFpkG6tzJOUJK1RISUfVa1YHK4QOisLBr/tbLqtQi
         YFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ygTGQtlvHxCxEH9uG0f8lrwshg3qNyL8NnJCyUolwZ4=;
        b=ncTX6De8sR8ttpP+udvfseklesYEufb7VC0RU8oejVvzRQLg403SoYvZjZoHIeJKIg
         hn3QrCp5XDeZOrHq3sqDjKsZL4zyPfJZYVILNXMJmAzS7CtEjlFyHFl254p7TMoees6l
         yQd0EyOEnaTlhMThqAFW9eJiDmPE1vae8b3kva8EaJU/kmiLBbKI2j5txXcesnFWpWV9
         bGgWMG7uPnJFLPtIrxzd9hkvl1avsjpvmhTm7uHif0fEcgZs0cgshCuHCJOaScgyNgGd
         SjVT+7kYMo68bmCc/se59lRI/kZPyURO9OsUIGQbow20KFNK/aAeeDkyY9QpiqQrL7sW
         q2jw==
X-Gm-Message-State: AOAM530CWd3YckhCMSXVE7b0DYm3u2rFs8/gLr5jIQaNHKKkXaMudew6
        h53bdzZUJs03fsES4Bi3RQP2eiOokWo/L93Y
X-Google-Smtp-Source: ABdhPJxm3OUHHKpaGTW7HxbBkfLBOIcjXT+7Hv7zTS1bI9X9DB9AVa3U6Pk7v/2SQqhdUPUCkfoLzA==
X-Received: by 2002:a63:5d07:: with SMTP id r7mr22631515pgb.440.1600649744266;
        Sun, 20 Sep 2020 17:55:44 -0700 (PDT)
Received: from realwakka ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id c68sm3887395pfc.31.2020.09.20.17.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 17:55:43 -0700 (PDT)
Date:   Mon, 21 Sep 2020 00:55:35 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Qu Wenruo <wqu@suse.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] btrfs/022: Add qgroup assign test
Message-ID: <20200921005535.GA28122@realwakka>
References: <20200920085753.277590-1-realwakka@gmail.com>
 <20200920172740.GQ3853@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200920172740.GQ3853@desktop>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 21, 2020 at 01:27:40AM +0800, Eryu Guan wrote:
> On Sun, Sep 20, 2020 at 08:57:53AM +0000, Sidong Yang wrote:
> > The btrfs/022 test is basic test about qgroup. but it doesn't have
> > test with qgroup assign function. This patch adds parent assign
> > test. parent assign test make two subvolumes and a qgroup for assign.
> > Assign two subvolumes with a qgroup and check that quota of group
> > has same value with sum of two subvolumes.
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> 

Hi Eryu.
Thanks for review!

> We usually don't add new test case to existing tests, as that may make a
> PASSed test starting to FAIL, which looks like a regression.

Okay, If then, is it okay for writing a new script for this?
> 
> > ---
> >  tests/btrfs/022 | 40 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> > 
> > diff --git a/tests/btrfs/022 b/tests/btrfs/022
> > index aaa27aaa..cafaa8b2 100755
> > --- a/tests/btrfs/022
> > +++ b/tests/btrfs/022
> > @@ -110,6 +110,40 @@ _limit_test_noexceed()
> >  	[ $? -eq 0 ] || _fail "should have been allowed to write"
> >  }
> >  
> > +#basic assign testing
> > +_parent_assign_test()
> 
> Local function names don't need to be prefixed with "_".
okay, thanks.
> 
> > +{
> > +	echo "=== parent assign test ===" >> $seqres.full
> > +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
> 
> The helpers based on run_check are not recommended, please just
> open-coded btrfs subvolume command and filter the output when necessary.
> j
> > +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
> > +	subvolid_a=$(_btrfs_get_subvolid $SCRATCH_MNT a)
> > +
> > +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/b
> > +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
> > +	subvolid_b=$(_btrfs_get_subvolid $SCRATCH_MNT b)
> > +
> > +	_run_btrfs_util_prog qgroup create 1/100 $SCRATCH_MNT
> > +
> > +	_run_btrfs_util_prog qgroup assign 0/$subvolid_a 1/100 $SCRATCH_MNT
> > +	_run_btrfs_util_prog qgroup assign 0/$subvolid_b 1/100 $SCRATCH_MNT
> > +
> > +	_ddt of=$SCRATCH_MNT/a/file bs=4M count=1 >> $seqres.full 2>&1
> > +	_ddt of=$SCRATCH_MNT/b/file bs=4M count=1 >> $seqres.full 2>&1
> > +	sync
> 
> Just fsync the individule files if possible.

Thanks. I'll fix it like this.
sync $SCRATCH_MNT/b/file

> 
> 
> > +
> > +	a_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid_a")
> > +	a_shared=$(echo $a_shared | awk '{ print $2 }' | tr -dc '0-9')
> 
> $AWK_PROG
Okay! awk -> $AWK_PROG
> 
> > +
> > +	b_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid_b")
> > +	b_shared=$(echo $b_shared | awk '{ print $2 }' | tr -dc '0-9')
> > +	sum=$(expr $b_shared  + $a_shared)
> > +
> > +	q_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "1/100")
> > +	q_shared=$(echo $q_shared | awk '{ print $2 }' | tr -dc '0-9')
> > +
> > +	[ $sum -eq $q_shared ] || _fail "shared values don't match"
> 
> Print the actual number and expected number as well?
Yes, you mean writing like this?

echo "a_shared = $a_shared" >> $seqres.full
echo "b_shared = $b_shared" >> $seqres.full
echo "sum = $sum" >> $seqres.full
echo "q_shared = $q_shared" >> $seqres.full

and I'm just curious that we don't need to cleanup qgroup environment after testing finished?

Thanks,
Sidong

> 
> Thanks,
> Eryu
> 
> > +}
> > +
> >  units=`_btrfs_qgroup_units`
> >  
> >  _scratch_mkfs > /dev/null 2>&1
> > @@ -133,6 +167,12 @@ _check_scratch_fs
> >  _scratch_mkfs > /dev/null 2>&1
> >  _scratch_mount
> >  _limit_test_noexceed
> > +_scratch_unmount
> > +_check_scratch_fs
> > +
> > +_scratch_mkfs > /dev/null 2>&1
> > +_scratch_mount
> > +_parent_assign_test
> >  
> >  # success, all done
> >  echo "Silence is golden"
> > -- 
> > 2.25.1
