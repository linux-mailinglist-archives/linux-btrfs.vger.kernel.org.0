Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CB63CF2F9
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 06:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbhGTDZI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 23:25:08 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:57052 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235428AbhGTDYw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 23:24:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UgNmDmp_1626753928;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UgNmDmp_1626753928)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Jul 2021 12:05:29 +0800
Date:   Tue, 20 Jul 2021 12:05:28 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
Message-ID: <20210720040528.GI60846@e18g06458.et15sqa>
References: <20210719071337.217501-1-wqu@suse.com>
 <YPWF5iqB0fOYZd9K@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPWF5iqB0fOYZd9K@mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 19, 2021 at 10:02:14AM -0400, Theodore Y. Ts'o wrote:
> On Mon, Jul 19, 2021 at 03:13:37PM +0800, Qu Wenruo wrote:
> > This patch will allow fstests to run custom hooks before and after each
> > test case.
> 
> Nice!   This is better than what I had been doing which was to set:
> 
> export LOGGER_PROG=/usr/local/lib/gce-logger
> 
> ... and then parse the passed message to be logged for "run xfstests
> $seqnum", and which only worked to hook the start of each test.
> 
> > diff --git a/README.hooks b/README.hooks
> > new file mode 100644
> > index 00000000..be92a7d7
> > --- /dev/null
> > +++ b/README.hooks
> > @@ -0,0 +1,72 @@
> > +To run extra commands before and after each test case, there is the
> > +'hooks/start.hook' and 'hooks/end.hook' files for such usage.
> > +
> > +Some notes for those two hooks:
> > +
> > +- Both hook files needs to be executable
> > +  Or they will just be ignored
> 
> Minor nit: I'd reword this as:
> 
> - The hook script must be executable or it
>   will be ignored.
> 
> > diff --git a/check b/check
> > index bb7e030c..f24906f5 100755
> > --- a/check
> > +++ b/check
> > @@ -846,6 +846,10 @@ function run_section()
> >  		# to be reported for each test
> >  		(echo 1 > $DEBUGFS_MNT/clear_warn_once) > /dev/null 2>&1
> >  
> > +		# Remove previous $seqres.full before start hook
> > +		rm -f $seqres.full
> > +
> > +		_run_start_hook
> 
> I wonder if it would be useful to have the start hook have a way to
> signal that a particular test should be skipped.  This might allow for
> various programatic tests that could be inserted by the test runner
> framework.

I have the same question as Darrick does, we now have the exclude list
infra to skip a given set of tests, does that work in your case? Why do
you need pre hook to skip a test?

Thanks,
Eryu

> 
> (E.g., this is the 5.4 kernel, we know this test is guaranteed to
> fail, so tell check to skip the test)
> 
> 	      	      	       	    	- Ted
