Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2E33CF4B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 08:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbhGTGDA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 02:03:00 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:60414 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237878AbhGTGCq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 02:02:46 -0400
Received: from dread.disaster.area (pa49-181-34-10.pa.nsw.optusnet.com.au [49.181.34.10])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 2897E80B75D;
        Tue, 20 Jul 2021 16:43:19 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1m5jTJ-008d1T-S5; Tue, 20 Jul 2021 16:43:17 +1000
Date:   Tue, 20 Jul 2021 16:43:17 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
Message-ID: <20210720064317.GC2031856@dread.disaster.area>
References: <20210719071337.217501-1-wqu@suse.com>
 <20210720002536.GA2031856@dread.disaster.area>
 <3f2d4ebd-bf75-b283-45be-3fa81e65d5bf@gmx.com>
 <20210720021437.GB2031856@dread.disaster.area>
 <cb2bf09e-91fd-2976-4366-4daf29664890@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb2bf09e-91fd-2976-4366-4daf29664890@gmx.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=hdaoRb6WoHYrV466vVKEyw==:117 a=hdaoRb6WoHYrV466vVKEyw==:17
        a=IkcTkHD0fZMA:10 a=e_q4qTt1xDgA:10 a=7-415B0cAAAA:8
        a=p1jNpjReWds5lNl4ywoA:9 a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 20, 2021 at 10:45:17AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/20 上午10:14, Dave Chinner wrote:
> > On Tue, Jul 20, 2021 at 08:36:49AM +0800, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2021/7/20 上午8:25, Dave Chinner wrote:
> > > > On Mon, Jul 19, 2021 at 03:13:37PM +0800, Qu Wenruo wrote:
> > > > > This patch will allow fstests to run custom hooks before and after each
> > > > > test case.
> > > > > 
> > > > > These hooks will need to follow requirements:
> > > > > 
> > > > > - Both hook files needs to be executable
> > > > >     Or they will just be ignored
> > > > > 
> > > > > - Stderr and stdout will be redirected to "$seqres.full"
> > > > >     With extra separator to distinguish the hook output with real
> > > > >     test output
> > > > > 
> > > > >     Thus if any of the hook is specified, all tests will generate
> > > > >     "$seqres.full" which may increase the disk usage for results.
> > > > > 
> > > > > - Error in hooks script will be ignored completely
> > > > > 
> > > > > - Environment variable "$HOOK_TEMP" will be exported for both hooks
> > > > >     And the variable will be ensured not to change for both hooks.
> > > > > 
> > > > >     Thus it's possible to store temporary values between the two hooks,
> > > > >     like pid.
> > > > > 
> > > > > - Start hook has only one parameter passed in
> > > > >     $1 is "$seq" from "check" script. The content will the path of current
> > > > >     test case. E.g "tests/btrfs/001"
> > > > > 
> > > > > - End hook has two parameters passed in
> > > > >     $1 is the same as start hook.
> > > > >     $2 is the return value of the test case.
> > > > >     NOTE: $2 doesn't take later golden output mismatch check nor dmesg/kmemleak
> > > > >     check.
> > > > > 
> > > > > For more info, please refer to "README.hooks".
> > > > 
> > > > This is all info that should be in README.hooks, not in the commit
> > > > message.  Commit messages are about explaining why something needs
> > > > to exist or be changed, not to describe the change being made. This
> > > > commit message doesn't tell me anything about what this is for, so I
> > > > can't really make any value judgement on it - exactly what is this
> > > > intended to be used for?
> > > 
> > > To run whatever you may want.
> > 
> > No, don't try to turn this around and put it on me to think up use
> > cases to justify your change. You have a use case for this, so
> > *document it so everyone understands what it is*.
> 
> If you don't need it, then fine.
> 
> But there are already other guys interesting in this feature.
> 
> Talk to them too.
> 
> Something you don't need doesn't mean other don't.

Hold up, what's with the attitude?

I asked you to describe the use case for the hooks because it wasn't
in the commit message and I don't have a clue how you intend to use
it. Hence I need you, the patch author and submitter, to tell me
what it is intended for.

Shouting at me telling how I should read about what others want when
instead of actually answering my question by describing your use
case as I've asked you (repeatedly) to describe is not helpful.

So please clam down, take a step back and please explain to me in a
calm, rational, professional manner what this functionality is
needed for.

> > My concerns are about whether the infrastructure is maintainable
> > from a long term persepective, and that all depends on what use
> > cases we have for it and whether global hooks are the likely best
> > solution to those use cases over the long term.  I'm not opposed to
> > adding hooks, I'm just asking for context and justification that is
> > needed to be able to consider if this is the best solution for the
> > use cases that are put forward...
> 
> Nope. All hook users are responsible for whatever they do.
> 
> Maybe it's adding trace-cmd calls, maybe it's to do extra error
> injection setup, I don't care.

You might not care, but other people will. I can see that if these
execution hooks becomes a common thing people use, it will need to
be formalised and further developed and documented. Because if they
are in widespread use, we really, really care about things like API
changes because breaking everyone's custom hook scripts because we
removed or changed a global variable or function is not in anyone's
interests.

> I just provide a way to do that more simply, to add two points to call
> executable scripts, and any modification in their hooks won't be
> submitted to fstests by default (check the gitignore update)
> What users do in their hooks is not what I really care, and nor what you
> should care.

Yes, I get it that you don't care. And that's a problem.

ISTM that you haven't thought this through beyond "add a hook for
running throw-away debug code". You clearly haven't thought about
what a developer would need to do to build a library of hook
implementations for debugging different tests. I say that because
maintaining that library via commits in local fstests repositories
is impossible because gitignore rules you added. I know, you don't
care, but I very much do, because storing stacks of custom changes
to fstests in local repositories is how I deploy fstests to my test
machines...

And given that it appears you haven't thought about maintaining a
local repository of hooks, I strongly doubt you've even consider the
impact of future changes to the hook API on existing hook scripts
that devs and test engineers have written over months and years
while debugging test failures.

Darrick pointed out the difference between running in the check vs
test environment, which is something that is very much an API
consideration - we change the test environment arbitrarily and fix
all the tests that change affects at the same time. But if there are
private scripts that depend on the test environment and variables
being stable, then we can't do things like, say, rename the "seqres"
variable across all tests because that will break every custom hook
script out there that writes to $seqres.full...

See what I'm getting at here? I've looked at the proposal and I'm
asking questions that your implementation raises. I'm not asking
these questions to be difficult, I'm asking them because I want to
know if I can use the hooks to replace some of the things I do with
other methods. And if I do, how I'm expected to maintain and deploy
them to the test machine farm from my master git repository they all
pull from...

> If someone is running hooks with every test case, it's their problem or
> intention. I don't care!
> 
> > 
> > IOWs, without a description of your use case and requirements, I
> > have no basis from which to determine if this is useful
> > infrastructure over the long term or not.
> OK, my use case is just to run "trace-cmd clear" before one test,
> btrfs/160, and I don't want to populate my workplace so that I may
> submit some patch with my debugging setup included.
> 
> I would only run that btrfs/160 with my custom hook, that's all.

If you have to submit a patch with the debugging and custom hook
defined in it to the build system, why can't you just submit a patch
that, say, runs "trace-cmd clear" at the start of btrfs/160 itself?

IOWs, I don't understand why generic, fstests-global script
execution hooks are needed just to run a simple command for helping
debug a single test. Why not just *patch the test* and then once
you're done throw away the debug patch?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
