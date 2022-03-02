Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6B74CA635
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 14:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242317AbiCBNoK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 08:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbiCBNoJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 08:44:09 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EFF2DD6A;
        Wed,  2 Mar 2022 05:43:25 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 132so1666234pga.5;
        Wed, 02 Mar 2022 05:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gfhyI8flMOCCCDy4we3a3ZQhGakr/xaZpa4FrJIjjNA=;
        b=ApCW4f8gx6HXU3KHUiC38X78tl6/6DGhVX3tYAFyjj1TWL0MSLnFoi/Cb3/Cq2K5Zk
         Rpb2Q1LOrU9UEThsBOktdlJHtuKZFTZ/Rh4ZQKt8pGX5R/6THRZt0FVQJ+zr2wTLq6gF
         AczDvmrUwqgNHot/RseoGffQzZw3KqQa64Y20+Gthb5YmKh3mB67+dnHlYcvZ26ubMDl
         c1E5p+Suv9cYPYILQHoqAaUCR9Y2waH77hN22seGSiMvdhbpNOgjPcgJl8uM3rxpjuNj
         1MqFc3t9RV13CyLMjnMI06xALeBTBa3Ej6r691xyYzrBNlomC4sw9sJcQsxPPUW0n+YI
         z31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gfhyI8flMOCCCDy4we3a3ZQhGakr/xaZpa4FrJIjjNA=;
        b=A3h+m19++sXMqryaKIekfETiIih7LlyY16bbilf2kXliJ5frz/2BGKC/zf+9tKiYY0
         wkTITbEnXCz/idGzwMsMgSKoBjPE6zibUGhJSJq5HM4BkJ9itkxRHdWBgINmk6xPG4oR
         ZlyqKcplar4LheV4+FoBOLJc8IDarMn2TS+7kHPJldfdMDtWwZsvDcYWXOuRbOXx3G0A
         3IRFV4cm5Ef+DCq2Hlv6SlWxryvNmQO0RAKDH4LRFcWwwPDevsEpTBKoGo8yb/yYqT1w
         wFGLO3Vpk1YJ//ge3a9TSDcQr0x0oJUwsYxMektz+tUker1nWE5Da/pWrYkoU0D3qoKC
         5vWg==
X-Gm-Message-State: AOAM533HXzBA07pshbtk2HdeXvoBatFB6jMpQpXqtd+Bbdfh5zpVCMdG
        wHfPXJwKpM0K0YnpLXBk8II=
X-Google-Smtp-Source: ABdhPJyzH0SEnQwOB0HTS9g76OoP40m1/YdH27r740Itc33RAF3gtUF9EUkHqYcxoqRa9dvwDxntvg==
X-Received: by 2002:a65:6751:0:b0:363:43a5:c7e3 with SMTP id c17-20020a656751000000b0036343a5c7e3mr25644579pgu.46.1646228605244;
        Wed, 02 Mar 2022 05:43:25 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a00150900b004f4735396fesm6867234pfu.191.2022.03.02.05.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:43:24 -0800 (PST)
Date:   Wed, 2 Mar 2022 13:43:16 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs: add test for enable/disable quota and
 create/destroy qgroup repeatedly
Message-ID: <20220302134316.GA2682@realwakka>
References: <20220301151930.1315-1-realwakka@gmail.com>
 <Yh9eoC1FwfNK5kXn@debian9.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh9eoC1FwfNK5kXn@debian9.Home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 02, 2022 at 12:10:08PM +0000, Filipe Manana wrote:

Hi, Filipe!
Thanks for review.
> On Tue, Mar 01, 2022 at 03:19:30PM +0000, Sidong Yang wrote:
> > Test enabling/disable quota and creating/destroying qgroup repeatedly
> > in asynchronous and confirm it does not cause kernel hang. This is a
> 
> in asynchronous -> in parallel

Sure, Thanks!
> 
> > regression test for the problem reported to linux-btrfs list [1].
> 
> It's worth mentioning the deadlock only happens starting with kernel 5.17-rc3.

It only happens in 5.17-rc3 version? I didn't know about it. I'll add
mention about this.
> 
> > 
> > The hang was recreated using the test case and fixed by kernel patch
> > titled
> > 
> >   btrfs: qgroup: fix deadlock between rescan worker and remove qgroup
> > 
> > [1] https://lore.kernel.org/linux-btrfs/20220228014340.21309-1-realwakka@gmail.com/
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> 
> In addition to Shinichiro's comments...
> 
> > ---
> >  tests/btrfs/262     | 54 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/262.out |  2 ++
> >  2 files changed, 56 insertions(+)
> >  create mode 100755 tests/btrfs/262
> >  create mode 100644 tests/btrfs/262.out
> > 
> > diff --git a/tests/btrfs/262 b/tests/btrfs/262
> > new file mode 100755
> > index 00000000..9be380f9
> > --- /dev/null
> > +++ b/tests/btrfs/262
> > @@ -0,0 +1,54 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 YOUR NAME HERE.  All Rights Reserved.
> > +#
> > +# FS QA Test 262
> > +#
> > +# Test the deadlock between qgroup and quota commands
> 
> The test description should be a lot more clear.
> 
> "the deadlock" is vague a gives the wrong idea we only ever had a single
> deadlock related to qgroups. "qgroup and quota commands" is confusing,
> and "qgroup" and "quota" are pretty much synonyms, and it should mention
> which commands.
> 
> Plus what we want to test is that we can run some qgroup operations in
> parallel without triggering a deadlock, crash, etc.
> 
> Perhaps something like:
> 
> """
> Test that running qgroup enable, create, destroy and disable commands in
> parallel does not result in a deadlock, a crash or any filesystem
> inconsistency.
> """
> 
Yeah, It was not clear. I found that this test is not only for checking
deadlock. But it checks that test runs without any problem.

> 
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto qgroup
> 
> Can also be added to the "quick" group. It takes 1 second in my slowest vm.

Okay, Thanks!
> 
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs btrfs
> > +
> > +_require_scratch
> > +
> > +# Run command that enable/disable quota and create/destroy qgroup asynchronously
> 
> With the more clear test description above, this can go away.

Sure!
> 
> > +qgroup_deadlock_test()
> > +{
> > +	_scratch_mkfs > /dev/null 2>&1
> > +	_scratch_mount
> > +	echo "=== qgroup deadlock test ===" >> $seqres.full
> 
> There's no point in echoing this message to the .full file, it provides no
> value at all, as testing that is all that this testcase does.

I agree. This is pointless because it's simple test.
> 
> > +
> > +	pids=()
> > +	for ((i = 0; i < 200; i++)); do
> > +		$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT 2>> $seqres.full &
> > +		pids+=($!)
> > +		$BTRFS_UTIL_PROG qgroup create 1/0 $SCRATCH_MNT 2>> $seqres.full &
> > +		pids+=($!)
> > +		$BTRFS_UTIL_PROG qgroup destroy 1/0 $SCRATCH_MNT 2>> $seqres.full &
> > +		pids+=($!)
> > +		$BTRFS_UTIL_PROG quota disable $SCRATCH_MNT 2>> $seqres.full &
> > +		pids+=($!)		
> > +	done
> > +
> > +	for pid in "${pids[@]}"; do
> > +		wait $pid
> > +	done
> 
> As pointed before by Shinichiro, a simple 'wait' here is enough, no need to
> keep track of the PIDs.

Yeah, I don't have to go hard way.
> 
> > +
> > +	_scratch_unmount
> > +	_check_scratch_fs
> 
> Not needed, the fstests framework automatically runs 'btrfs check' when a test
> finishes. Doing this explicitly is only necessary when we need to do several
> mount/unmount operations and want to check the fs is fine after each unmount
> and before the next mount.
> 

I didn't know about that. I don't need to check manually.
> > +}
> > +
> > +qgroup_deadlock_test
> 
> There's no point in putting all the test code in a function, as the function
> is only called once.

Of course!
> 
> Otherwise it looks good, and the test works as advertised, it triggers a
> deadlock on 5.17-rc3+ kernel and passes on a patched kernel.
> 
> Thanks for converting the reproducer into a test case.
> 

Thanks for detailed review. I'll back soon with v2.

Thanks,
Sidong
> > +
> > +# success, all done
> > +echo "Silence is golden"
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/262.out b/tests/btrfs/262.out
> > new file mode 100644
> > index 00000000..404badc3
> > --- /dev/null
> > +++ b/tests/btrfs/262.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 262
> > +Silence is golden
> > -- 
> > 2.25.1
> > 
