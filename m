Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEDB3CF1FE
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 04:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244634AbhGTBir (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 21:38:47 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:51418 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244029AbhGTBeH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 21:34:07 -0400
Received: from dread.disaster.area (pa49-181-34-10.pa.nsw.optusnet.com.au [49.181.34.10])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id E44996A038;
        Tue, 20 Jul 2021 12:14:38 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1m5fHJ-008YeT-RS; Tue, 20 Jul 2021 12:14:37 +1000
Date:   Tue, 20 Jul 2021 12:14:37 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
Message-ID: <20210720021437.GB2031856@dread.disaster.area>
References: <20210719071337.217501-1-wqu@suse.com>
 <20210720002536.GA2031856@dread.disaster.area>
 <3f2d4ebd-bf75-b283-45be-3fa81e65d5bf@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f2d4ebd-bf75-b283-45be-3fa81e65d5bf@gmx.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=hdaoRb6WoHYrV466vVKEyw==:117 a=hdaoRb6WoHYrV466vVKEyw==:17
        a=IkcTkHD0fZMA:10 a=e_q4qTt1xDgA:10 a=7-415B0cAAAA:8
        a=NsbJQidqhOGAuf6Gt_UA:9 a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 20, 2021 at 08:36:49AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/20 上午8:25, Dave Chinner wrote:
> > On Mon, Jul 19, 2021 at 03:13:37PM +0800, Qu Wenruo wrote:
> > > This patch will allow fstests to run custom hooks before and after each
> > > test case.
> > > 
> > > These hooks will need to follow requirements:
> > > 
> > > - Both hook files needs to be executable
> > >    Or they will just be ignored
> > > 
> > > - Stderr and stdout will be redirected to "$seqres.full"
> > >    With extra separator to distinguish the hook output with real
> > >    test output
> > > 
> > >    Thus if any of the hook is specified, all tests will generate
> > >    "$seqres.full" which may increase the disk usage for results.
> > > 
> > > - Error in hooks script will be ignored completely
> > > 
> > > - Environment variable "$HOOK_TEMP" will be exported for both hooks
> > >    And the variable will be ensured not to change for both hooks.
> > > 
> > >    Thus it's possible to store temporary values between the two hooks,
> > >    like pid.
> > > 
> > > - Start hook has only one parameter passed in
> > >    $1 is "$seq" from "check" script. The content will the path of current
> > >    test case. E.g "tests/btrfs/001"
> > > 
> > > - End hook has two parameters passed in
> > >    $1 is the same as start hook.
> > >    $2 is the return value of the test case.
> > >    NOTE: $2 doesn't take later golden output mismatch check nor dmesg/kmemleak
> > >    check.
> > > 
> > > For more info, please refer to "README.hooks".
> > 
> > This is all info that should be in README.hooks, not in the commit
> > message.  Commit messages are about explaining why something needs
> > to exist or be changed, not to describe the change being made. This
> > commit message doesn't tell me anything about what this is for, so I
> > can't really make any value judgement on it - exactly what is this
> > intended to be used for?
> 
> To run whatever you may want.

No, don't try to turn this around and put it on me to think up use
cases to justify your change. You have a use case for this, so
*document it so everyone understands what it is*.

> Don't you want to run some trace-cmd to record the ftrace buffer for
> certain tests to debug?

I already have a way of doing that, thanks - the command line is
just fine for tracing failing tests. IOWs, I don't actually need
hooks inside fstests for that.

Again, this isn't about what I need from fstests. This is something
_you_ want, so describe your use case and how these hooks are the
best way to provide the functionality you require.

> > FWIW, if a test needs something to be run before/after the test, it
> > really should be in the test, run as part of the test.
> 
> Not the trace-cmd things one is going to debug.

I don't follow your reasoning, likely because you haven't actually
described how you intend to use these hooks.

If it's for tracing one-off test failures, then we can already do
that from the command line. If it's for something else, then you
haven't described what that is yet....

> > Adding
> > overhead to every test being just to check for something that
> > doesn't actually have a defined use, nor will exist or be used on
> > the vast majority of systems running fstests doesn't seem like the
> > best idea to me.
> 
> Then you can do whatever you did when you debug certain test case like
> before, adding whatever commands you need into "check" script.
>
> If you believe that's the cleanest way to debug, then sure.

Again, this isn't about what I "beleive".

My concerns are about whether the infrastructure is maintainable
from a long term persepective, and that all depends on what use
cases we have for it and whether global hooks are the likely best
solution to those use cases over the long term.  I'm not opposed to
adding hooks, I'm just asking for context and justification that is
needed to be able to consider if this is the best solution for the
use cases that are put forward...

It may be there are different ways to do what you need, or there are
better places to implement it, or it might need more fine grained
scope than an single global hook that all tests run. I can see that
per-test granularity would be much preferable to having to do this
sort of stuff in global hook files:

case $seq in
generic/001) ....
	;;
generic/005) ....
	;;
....
esac

But that assumes that this is intended for hooking every test and
doing different things for different tests (which appears to be what
the implementation does).

IOWs, without a description of your use case and requirements, I
have no basis from which to determine if this is useful
infrastructure over the long term or not. It may be a horrible
maintenance nightmare when people start writing tests that are
dependent on certain hooks being present once the infrastructure is
in place....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
