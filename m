Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B784C9DC3
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 07:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbiCBG1w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 01:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbiCBG1w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 01:27:52 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1DD7DA96;
        Tue,  1 Mar 2022 22:27:09 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id e6so821446pgn.2;
        Tue, 01 Mar 2022 22:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1W4vSsKVxXU5/hqO6SPRcea7N3CcKsO+U3EDO9AsJOo=;
        b=hxjZFMM0ljimrl3By8710lZRk16bs8Cb/WEoXmGTEo0rQ0fb1I43aPD9Sm0ubPLhUU
         ufGWA5R39od7UGNZIOX79v2T3th+ynoOdJOUyFg+zka1QRE/PRwzFuFmAA6Kj26N31IT
         5QFz1IFoWLM8L6qZZbUgaJiREAN4OX5Tk6YTfN+hnxejG0wvxG1w8dUCBN7kI5he1mkS
         Fhdk1I6b4d7U8EALnUdiUKXYX9o0TtQzk+Nv6bu36ODxMTutEbdrOrVX9/CT+cp67M+6
         +ZJZ0yi5ReToD1MjJxtpjMBnt+/Lv0EXLWsxkjoqO4R5HChb4EHSPI+FbWoVN3rrd1AN
         DOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1W4vSsKVxXU5/hqO6SPRcea7N3CcKsO+U3EDO9AsJOo=;
        b=GPyRc6ZgC0s72a3ea7l/sUv+BCFUagVfRzYTIBB98v+RpSalS48iuXM6j/q0giM2Ap
         qegnlejzVoQtvqlRs2/CEpg8PlhqB5drlNnc3SwAX1CbieEjTCWkVnRu6OrfkBhjS7cy
         lXuV6vuZyMmqPzn5FojDTyp1QbiS2Yitg3ZTBQUo0unj5mm/40gpdqElVMp7mAfTBmfS
         lCKpwHT5jHzuBQPqhD5MyJ3gykAjwdiqtNq9SJKYZ30g1Ksmxfxt7hJLL4ibX+2HXmWM
         eJUJtHc3EG5S3iQJ0sf4RMVhrVXHGxCi3K5EoDXhimRm0IyqiLCc8s0TbJp910O3XPQM
         H6rQ==
X-Gm-Message-State: AOAM5331DpF5qzOzSeywyZQngX6Uojo8F+Ww66e5DVjCM0yBhIrvLnLE
        NSaPjNuFT4ImiUAtrLBeLjk=
X-Google-Smtp-Source: ABdhPJzRCPq6zGw4476XzrfHQVf3OFZTRMeyaOHcLpZRwBQjUI+SLjUCFcvazdrikHMWkgLQGmUv0A==
X-Received: by 2002:a63:af06:0:b0:378:3582:a49f with SMTP id w6-20020a63af06000000b003783582a49fmr20143353pge.125.1646202428956;
        Tue, 01 Mar 2022 22:27:08 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id e13-20020a056a001a8d00b004f0f28910cdsm18730602pfv.42.2022.03.01.22.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 22:27:08 -0800 (PST)
Date:   Wed, 2 Mar 2022 06:26:59 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Filipe Manana <fdmanana@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs: add test for enable/disable quota and
 create/destroy qgroup repeatedly
Message-ID: <20220302062659.GA1852@realwakka>
References: <20220301151930.1315-1-realwakka@gmail.com>
 <20220302044334.ojz2crbcc6eapvex@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302044334.ojz2crbcc6eapvex@shindev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 02, 2022 at 04:43:35AM +0000, Shinichiro Kawasaki wrote:

Hi, Shinichiro.

Thanks for reply!

> Hi Sidong,
> 
> I tried this patch and observed that it recreates the hang and confirms the fix.
> Thanks. Here's my comments for improvements.
> 
> On Mar 01, 2022 / 15:19, Sidong Yang wrote:
> > Test enabling/disable quota and creating/destroying qgroup repeatedly
> 
> nit: gerund (...ing) and base form are mixed. Base form would be the better to
> be same as the code comment.

Yeah, 'disable' should be disabling.
> 
> > in asynchronous and confirm it does not cause kernel hang. This is a
> > regression test for the problem reported to linux-btrfs list [1].
> > 
> > The hang was recreated using the test case and fixed by kernel patch
> > titled
> > 
> >   btrfs: qgroup: fix deadlock between rescan worker and remove qgroup
> > 
> > [1] https://lore.kernel.org/linux-btrfs/20220228014340.21309-1-realwakka@gmail.com/
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
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
> 
> It's the better to put your name there :)

Oops, 
> 
> > +#
> > +# FS QA Test 262
> > +#
> > +# Test the deadlock between qgroup and quota commands
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto qgroup
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> 
> Can we remove this comment?
Sure!
> 
> > +_supported_fs btrfs
> > +
> > +_require_scratch
> > +
> > +# Run command that enable/disable quota and create/destroy qgroup asynchronously
> > +qgroup_deadlock_test()
> > +{
> > +	_scratch_mkfs > /dev/null 2>&1
> > +	_scratch_mount
> > +	echo "=== qgroup deadlock test ===" >> $seqres.full
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
> 
> Trailing tabs in the line above.
Oops..
> 
> > +	done
> > +
> > +	for pid in "${pids[@]}"; do
> > +		wait $pid
> > +	done
> 
> I think simple "wait" command does what the for loop does.

I didn't know that "wait" command with no parameter waits all background
processes to finish. So it seems that we don't need pids it can be
deleted. Thanks.

Actually I've been agony about this. Does it needs timeout? When I tried
to command like this "timeout 10s wait", This command couldn't be
executed becase "wait" command is not binary. How can I insert timeout?

> 
> > +
> > +	_scratch_unmount
> > +	_check_scratch_fs
> 
> I think _scratch_unmount and _check_scratch_fs are required only when
> the test case repeats scratch mount and unmount. This test case looks
> simple for me and the qgroup_deadlock_test function may not be necessary.

I agree. This case is very simple. We don't need to use function. It
would be better that it's written in simple.

> 
> > +}
> > +
> > +qgroup_deadlock_test
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
> 
> -- 
> Best Regards,
> Shin'ichiro Kawasaki
