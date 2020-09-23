Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE21A274DD1
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 02:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgIWA2W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 20:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgIWA2W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 20:28:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D1EC061755;
        Tue, 22 Sep 2020 17:28:22 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id v14so2254425pjd.4;
        Tue, 22 Sep 2020 17:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5tUm3qEMH2GFAQapz3Y9eW8+8Nc4B+LpYJQnWXRrIUI=;
        b=ITxu9FpMdhJbsUrmlQXVmepK2rUy/zk+7pedeuiY/d2HWrochSF5Q2u26AbNPUr+Qe
         E+FnRnz/ausXmikcTWOErzPE8m3R2OW7we4Gsx8amoc52p6AX9yKb8OF55x8aWBrXtAA
         GDZmeu1DIAVcOThmuwmev2qAfFp0iB9iOEiAtYgWscbxj8OR5U1j4VYbBi6+vUgQ1uHU
         w6y1t82oJQm0qX6v1JNT4uMBFfImV3VW1U2rYR/08XvPyeF/x4AJS7JzYiUEMcHOK8oC
         Htnj4UizHl0EIV4zkS3q/GvqRNwx8nshNh0dMZ40MjaO+lXSh3UbcFKIgfQ39lYRr4wM
         l0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5tUm3qEMH2GFAQapz3Y9eW8+8Nc4B+LpYJQnWXRrIUI=;
        b=DEkiWZGKQ7iWfQwYX5LtuTtssBclBYjvsZWcbA9QYKDWGt5vDGgc7yLy0Ccmo3Y5is
         huCptHyZMPONdBKdOPzuoPsJfaIwgxZFpuqAv67gBwBQ+wY61PbVk2VjXGtpeoqLTfBw
         lc/ZYRfMqwmxxorSO8QzXw/V5JsgSlaD5gRtrS82bB2nOmrAoINicK0FMjaRPBHkfrpe
         MqI2wd/HaHaTOQFxa2HMPaO4gX9YQxAlpVajg0w/0s3UeVdP92RxKovYAgELqb+dKKkk
         1RrKoNS9pI6leHHge9BrJpcMyi8t5xwUu5j/AZH8JVMcl6tOeiGBIh+ybL0XjHu8uD3P
         oZug==
X-Gm-Message-State: AOAM532Yz34PVj0mZSFNQPDAWs7Tpr5MCSS0/9bhy6jpgWLB2hytdPWJ
        Tlcz/GQG0NPzPvimHkU4U1RgziVr8QmYccX3
X-Google-Smtp-Source: ABdhPJw8nXbPHacxCeYTamHgqpNq2WeFr+kaksi/Yruy/Kq2tbeJCJoUq5fD/95au9qM3hU+3f0hNw==
X-Received: by 2002:a17:90a:c83:: with SMTP id v3mr5836320pja.229.1600820901948;
        Tue, 22 Sep 2020 17:28:21 -0700 (PDT)
Received: from realwakka ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id q18sm15828408pfg.158.2020.09.22.17.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 17:28:21 -0700 (PDT)
Date:   Wed, 23 Sep 2020 00:28:12 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] btrfs/022: Add qgroup assign test
Message-ID: <20200923002812.GA10444@realwakka>
References: <20200920085753.277590-1-realwakka@gmail.com>
 <585901fa-663a-b9e6-3f2f-9d060cd345c7@suse.com>
 <20200921151641.GB28122@realwakka>
 <4538473b-eff3-8e2f-2ac4-b66d90beebb9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4538473b-eff3-8e2f-2ac4-b66d90beebb9@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 22, 2020 at 07:49:19AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/9/21 下午11:16, Sidong Yang wrote:
> > On Mon, Sep 21, 2020 at 09:21:33AM +0800, Qu Wenruo wrote:
> >>
> >>
> >> On 2020/9/20 下午4:57, Sidong Yang wrote:
> >>> The btrfs/022 test is basic test about qgroup. but it doesn't have
> >>> test with qgroup assign function. This patch adds parent assign
> >>> test. parent assign test make two subvolumes and a qgroup for assign.
> >>> Assign two subvolumes with a qgroup and check that quota of group
> >>> has same value with sum of two subvolumes.
> > 
> > Hi Qu!
> > Thanks for review!
> > 
> >>
> >> A little surprised that I haven't submitted such test case, especially
> >> we had a fix in kernel.
> >>
> >> cbab8ade585a ("btrfs: qgroup: mark qgroup inconsistent if we're
> >> inherting snapshot to a new qgroup")
> > 
> > Yeah, there was no test code for qgroup.
> > 
> >>
> >> Despite the comment from Eryu, some btrfs specific comment inlined below.
> >>
> >>>
> >>> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> >>> ---
> >>>  tests/btrfs/022 | 40 ++++++++++++++++++++++++++++++++++++++++
> >>>  1 file changed, 40 insertions(+)
> >>>
> >>> diff --git a/tests/btrfs/022 b/tests/btrfs/022
> >>> index aaa27aaa..cafaa8b2 100755
> >>> --- a/tests/btrfs/022
> >>> +++ b/tests/btrfs/022
> >>> @@ -110,6 +110,40 @@ _limit_test_noexceed()
> >>>  	[ $? -eq 0 ] || _fail "should have been allowed to write"
> >>>  }
> >>>  
> >>> +#basic assign testing
> >>> +_parent_assign_test()
> >>> +{
> >>> +	echo "=== parent assign test ===" >> $seqres.full
> >>> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
> >>> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
> >>> +	subvolid_a=$(_btrfs_get_subvolid $SCRATCH_MNT a)
> >>> +
> >>> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/b
> >>> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
> >>> +	subvolid_b=$(_btrfs_get_subvolid $SCRATCH_MNT b)
> >>> +
> >>> +	_run_btrfs_util_prog qgroup create 1/100 $SCRATCH_MNT
> >>> +
> >>> +	_run_btrfs_util_prog qgroup assign 0/$subvolid_a 1/100 $SCRATCH_MNT
> >>> +	_run_btrfs_util_prog qgroup assign 0/$subvolid_b 1/100 $SCRATCH_MNT
> >>
> >> The coverage is not good enough.
> >>
> >> Qgroup assign (or inherit) happens not only during "btrfs qgroup assign"
> >> but also "btrfs subvolume snapshot -i".
> >>
> >> And we also need to consider cases like shared extents between two
> >> subvolumes (either caused by snapshot or reflink).
> >>
> >> That means we have two factors, assign or snapshot -i, subvolumes with
> >> shared extents or not.
> >> That means we need at least 3 combinations:
> >>
> >> - assign, no shared extents
> >> - assign, shared extents
> >> - snapshot -i, shared extents
> >>
> >> (snapshot -i, no shared extents is invalid, as snapshot will always
> >> cause shared extents)
> > 
> > Thanks for good example!
> > but there is a question. How can I make shared extents in test code?
> 
> Reflink is the most simple solution.
> 
> > It's okay that write some file and make a snapshot from it?
> 
> If you only want some shared extents, reflink is easier than snapshot.

I've written a new patch v2 for this. Could you review it?

Thanks,
Sidong

> 
> Thanks,
> Qu
> 
> > 
> >>
> >>> +
> >>> +	_ddt of=$SCRATCH_MNT/a/file bs=4M count=1 >> $seqres.full 2>&1
> >>> +	_ddt of=$SCRATCH_MNT/b/file bs=4M count=1 >> $seqres.full 2>&1
> >>> +	sync
> >>> +
> >>> +	a_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid_a")
> >>> +	a_shared=$(echo $a_shared | awk '{ print $2 }' | tr -dc '0-9')
> >>> +
> >>> +	b_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid_b")
> >>> +	b_shared=$(echo $b_shared | awk '{ print $2 }' | tr -dc '0-9')
> >>> +	sum=$(expr $b_shared  + $a_shared)
> >>> +
> >>> +	q_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "1/100")
> >>> +	q_shared=$(echo $q_shared | awk '{ print $2 }' | tr -dc '0-9')
> >>> +
> >>> +	[ $sum -eq $q_shared ] || _fail "shared values don't match"
> >>
> >> Nope, we don't need to do such complex checking all by ourselves.
> >>
> >> Just let "btrfs check" to handle it, as it will also check the qgroup
> >> numbers.
> > 
> > It's very easy way to check! Thanks.
> > 
> > Taken together, I'll work for new test case that tests qgroup cases.
> > 
> > Sincerely,
> > Sidong
> > 
> >>
> >> Thanks,
> >> Qu
> >>
> >>> +}
> >>> +
> >>>  units=`_btrfs_qgroup_units`
> >>>  
> >>>  _scratch_mkfs > /dev/null 2>&1
> >>> @@ -133,6 +167,12 @@ _check_scratch_fs
> >>>  _scratch_mkfs > /dev/null 2>&1
> >>>  _scratch_mount
> >>>  _limit_test_noexceed
> >>> +_scratch_unmount
> >>> +_check_scratch_fs
> >>> +
> >>> +_scratch_mkfs > /dev/null 2>&1
> >>> +_scratch_mount
> >>> +_parent_assign_test
> >>>  
> >>>  # success, all done
> >>>  echo "Silence is golden"
> >>>
> >>
> 



