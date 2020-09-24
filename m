Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC832773EB
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 16:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbgIXO3G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 10:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbgIXO3G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 10:29:06 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FD8C0613CE;
        Thu, 24 Sep 2020 07:29:05 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d19so1789130pld.0;
        Thu, 24 Sep 2020 07:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tzHGsyzPcS+DvGM3a/i0s4+6MJ1r5aPfjoy4Xoy7aKo=;
        b=qStbee9sHsKcTyuS7/kI0suQCV44bRvaRzp+kfW5Dukg6OsAaNX8UAPLpoalck6rrz
         cOFmrxA+LWvhDPFdtGXc/dNGggfDXe1sxaBK2wbKgLpGVKVLGzADkq8vnmpuqqHsHszW
         IvKvQMfEjXL1LjQEJKZ+h6e37j5g565+HVx3DodRBrTk0JFYVlI9HHS3ARiYr7wq2Apo
         n5whfsy36w/QBHVKb6Azvg1lm5Dr1Wk7Swn3hJGeBT3qIBeaUn/Mhw51+Iw2ua2Mavjg
         tKtxNijoejjEZLZcLGhF+54V0DoZ5YuVtEO7UvXStY/MRaG2hgFHu/UcOxHVh2LuNVkH
         O/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tzHGsyzPcS+DvGM3a/i0s4+6MJ1r5aPfjoy4Xoy7aKo=;
        b=az+b3PsiY4xdMrOBJGqtHi4u8dxmXVD/AHvA9yvJvm41tkLlA56SgbI/1Z3Dzvj/XG
         QcTW43TGg+MKFrshNpRE7+tXWWyvmGSxMQZtE1saZEii4ErEJyYSigXi1VVofqfjT9S8
         fA3/SP9qOyDzMZm+e6qHZmm2SrwertoY3fX5xfS3KcJLvKEzq2TID3O64dyZJwgO1NjU
         XN+2dpGhD73AzKts/BlaxSuXp8+oHz6qqPD3IKYxKKs/aRFJV/QG6gRtXFXRaw+9IxZf
         HYOzWAUYAOxvbH/LwwUbX9+u8ZL3g+gs4coKmQD7ttwT0LooBERe2QfVDR6sHt7bUF0P
         63ZQ==
X-Gm-Message-State: AOAM5331LxAR+IpSRDMsscy4Uwz/QQas6JuHiyD8VMEdTJQ3+kJ71waO
        M7VohecXSjsRh4NQhE4cVE2UmQ44Y6EAYKmU
X-Google-Smtp-Source: ABdhPJwiAowAro03RDbVZtJ9yIcY44HKmEF8r/MK8vYRMiXHv+gb5kPTNwCANMypQ9snAquhg98g6w==
X-Received: by 2002:a17:90a:c83:: with SMTP id v3mr4126074pja.229.1600957745271;
        Thu, 24 Sep 2020 07:29:05 -0700 (PDT)
Received: from realwakka ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id x6sm2650920pjp.25.2020.09.24.07.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 07:29:04 -0700 (PDT)
Date:   Thu, 24 Sep 2020 14:28:54 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>, Eryu Guan <guan@eryu.me>
Subject: Re: [PATCH v3] btrfs: Add new test for qgroup assign functionality
Message-ID: <20200924142854.GA43851@realwakka>
References: <20200924041146.32577-1-realwakka@gmail.com>
 <d67277a5-c0a9-cee5-cddd-54ab8610fc41@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d67277a5-c0a9-cee5-cddd-54ab8610fc41@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 24, 2020 at 01:08:13PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/9/24 下午12:11, Sidong Yang wrote:
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
> 
> This version is much better overall.
Thanks to you.
> 
> The remaining small problems are mostly fstests related then.
> ...
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
> > +
> > +	$BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
> > +	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/a 1/100 $SCRATCH_MNT
> > +	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/b 1/100 $SCRATCH_MNT
> > +
> > +	_scratch_unmount
> > +	$BTRFS_UTIL_PROG check $SCRATCH_DEV >> $seqres.full 2>&1
> 
> We have _check_scratch_fs() function to do it properly already.
Okay!
> 
> > +	[ $? -eq 0 ] || _fail "btrfs check failed"
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
> 
> It's recommended to call "quota rescan -w" to ensure we finished rescan.
> 
> As fast enough system can go to next command before the auto rescan even
> finished.
Yeah, I need to call "quota rescan -w" after enabling quota.

> 
> Not sure if Eryu would have extra comments.
I'm continuously ccing Eryu.
I'll write a new v4 patch.

Thanks!
Sidong

> 
> Thanks,
> Qu
> 
> > +	$BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
> > +
> > +	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
> > +	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/b >> $seqres.full
> > +
> > +	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/a 1/100 $SCRATCH_MNT
> > +	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/b 1/100 $SCRATCH_MNT
> > +	_scratch_unmount
> > +
> > +	$BTRFS_UTIL_PROG check $SCRATCH_DEV >> $seqres.full 2>&1
> > +	[ $? -eq 0 ] || _fail "btrfs check failed"
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
> > +	_scratch_unmount
> > +
> > +	$BTRFS_UTIL_PROG check $SCRATCH_DEV >> $seqres.full 2>&1
> > +	[ $? -eq 0 ] || _fail "btrfs check failed"
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
> > 
> 
