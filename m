Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287662729C3
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 17:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgIUPQt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 11:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgIUPQt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 11:16:49 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63902C061755;
        Mon, 21 Sep 2020 08:16:49 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id fa1so7659632pjb.0;
        Mon, 21 Sep 2020 08:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=v0bwgH8M+hJR8c9PL6tRoyaPzlRe3/aI8+ZUjZ7VAfc=;
        b=TJEgDfp46XQVIWrFlafpGQPqVmgDUTqlSCN+mq/w1eFHE3Kspa9JwMnV7yfNlLaS3p
         H1DKwdW/bbK3ZTV6c2/T96boHjClMkgaJBd6+k+aiFv0XH2zZgH+z54UC/r1L+/VGqZQ
         ZqUO4cXbW7HQOw5oQhSphM4ioW74xu3Sj2LMa3ov4z5xgbav32vj8pWpDQvj4GDP42br
         Qy83SpR5CGhTx+cAYIYqKnOvmV2nN6yxKbYF79XqvYkoZYbBhXNcYyUvfANOGywiSebV
         YewlY7mkixDNwvy49C2RaMI9TPRLQNcfPqwOKpYF7hNt3y687RZOZDjn4DShgB4Tuv3i
         EggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=v0bwgH8M+hJR8c9PL6tRoyaPzlRe3/aI8+ZUjZ7VAfc=;
        b=I+eEkkQyZbW+mtxF/nmV3GPMVqgQP9UjDoPkKhyJBpsaNRPX5oJo39bkLE2IpZpEDZ
         SLyFgnPchU15g5KJK2j1snWS2REWjdhsR4Lmpm476KGt3NFCwu0fXzKPO09gZ9a2n2tg
         3BfC7gqvDNsrQ9opWAJJY4eo9PKxMtdEV6BK/ZV1XUUrrZyTdG6OY+vJ6sMfbPgqlaD+
         TZZALtKh05TXZbvEKGyGnunNFLmHkVFz+MwY+PspDFnuhp8oDeWGnejSYk0IvpBrZKC+
         tRFR28fK2BFL7tfHtFbUeDDLNRhJrMBwy7sadt+zQUuJgZDWX2dN4yFHMiNrknvWasKN
         ouyQ==
X-Gm-Message-State: AOAM5306K0ZYehb9m3Dc3L3ADPaAh0h+0QsVhuxPNCDHMdtMnR7FIY1L
        l4GQpnqy0I6RWI291SZ6ceY=
X-Google-Smtp-Source: ABdhPJyuVoDguPTyFLFU8/J1dx9cdfvhCc43xZbf4RuJHvHA5r/Eu5QC9z6YriD58jnxidaS5ETntA==
X-Received: by 2002:a17:90b:317:: with SMTP id ay23mr253852pjb.68.1600701408462;
        Mon, 21 Sep 2020 08:16:48 -0700 (PDT)
Received: from realwakka ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id n127sm11883103pfn.155.2020.09.21.08.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 08:16:47 -0700 (PDT)
Date:   Mon, 21 Sep 2020 15:16:41 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] btrfs/022: Add qgroup assign test
Message-ID: <20200921151641.GB28122@realwakka>
References: <20200920085753.277590-1-realwakka@gmail.com>
 <585901fa-663a-b9e6-3f2f-9d060cd345c7@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <585901fa-663a-b9e6-3f2f-9d060cd345c7@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 21, 2020 at 09:21:33AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/9/20 下午4:57, Sidong Yang wrote:
> > The btrfs/022 test is basic test about qgroup. but it doesn't have
> > test with qgroup assign function. This patch adds parent assign
> > test. parent assign test make two subvolumes and a qgroup for assign.
> > Assign two subvolumes with a qgroup and check that quota of group
> > has same value with sum of two subvolumes.

Hi Qu!
Thanks for review!

> 
> A little surprised that I haven't submitted such test case, especially
> we had a fix in kernel.
> 
> cbab8ade585a ("btrfs: qgroup: mark qgroup inconsistent if we're
> inherting snapshot to a new qgroup")

Yeah, there was no test code for qgroup.

> 
> Despite the comment from Eryu, some btrfs specific comment inlined below.
> 
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
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
> > +{
> > +	echo "=== parent assign test ===" >> $seqres.full
> > +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
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
> 
> The coverage is not good enough.
> 
> Qgroup assign (or inherit) happens not only during "btrfs qgroup assign"
> but also "btrfs subvolume snapshot -i".
> 
> And we also need to consider cases like shared extents between two
> subvolumes (either caused by snapshot or reflink).
> 
> That means we have two factors, assign or snapshot -i, subvolumes with
> shared extents or not.
> That means we need at least 3 combinations:
> 
> - assign, no shared extents
> - assign, shared extents
> - snapshot -i, shared extents
> 
> (snapshot -i, no shared extents is invalid, as snapshot will always
> cause shared extents)

Thanks for good example!
but there is a question. How can I make shared extents in test code?
It's okay that write some file and make a snapshot from it?

> 
> > +
> > +	_ddt of=$SCRATCH_MNT/a/file bs=4M count=1 >> $seqres.full 2>&1
> > +	_ddt of=$SCRATCH_MNT/b/file bs=4M count=1 >> $seqres.full 2>&1
> > +	sync
> > +
> > +	a_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid_a")
> > +	a_shared=$(echo $a_shared | awk '{ print $2 }' | tr -dc '0-9')
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
> Nope, we don't need to do such complex checking all by ourselves.
> 
> Just let "btrfs check" to handle it, as it will also check the qgroup
> numbers.

It's very easy way to check! Thanks.

Taken together, I'll work for new test case that tests qgroup cases.

Sincerely,
Sidong

> 
> Thanks,
> Qu
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
> > 
> 
