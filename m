Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3B23D1A66
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 01:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhGUWsB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 18:48:01 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:50729 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230091AbhGUWr7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 18:47:59 -0400
Received: from dread.disaster.area (pa49-181-34-10.pa.nsw.optusnet.com.au [49.181.34.10])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3C2DB863A9C;
        Thu, 22 Jul 2021 09:28:31 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1m6Lde-009HBN-Q3; Thu, 22 Jul 2021 09:28:30 +1000
Date:   Thu, 22 Jul 2021 09:28:30 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eryu Guan <eguan@linux.alibaba.com>, Qu Wenruo <wqu@suse.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
Message-ID: <20210721232830.GC2112234@dread.disaster.area>
References: <cb2bf09e-91fd-2976-4366-4daf29664890@gmx.com>
 <20210720064317.GC2031856@dread.disaster.area>
 <20210720075748.GJ60846@e18g06458.et15sqa>
 <3fd6494b-8f03-4d97-9d00-21343e0e8152@gmx.com>
 <6b7699a9-fc5e-32d9-78c5-9c0e3cf92895@gmx.com>
 <YPbt2ohi62VyWN7e@mit.edu>
 <f37bec82-85cd-b818-8691-6c047751c4a6@gmx.com>
 <20210721011105.GA2112234@dread.disaster.area>
 <ff57f17c-e3f2-14f3-42d8-fefaafd65637@gmx.com>
 <DM6PR04MB70812AEDDAB6DE7951F4FBBDE7E39@DM6PR04MB7081.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR04MB70812AEDDAB6DE7951F4FBBDE7E39@DM6PR04MB7081.namprd04.prod.outlook.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=hdaoRb6WoHYrV466vVKEyw==:117 a=hdaoRb6WoHYrV466vVKEyw==:17
        a=IkcTkHD0fZMA:10 a=e_q4qTt1xDgA:10 a=7-415B0cAAAA:8
        a=WWgSXLAHQ0wrzOdU2uYA:9 a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 21, 2021 at 02:23:14AM +0000, Damien Le Moal wrote:
> On 2021/07/21 10:53, Qu Wenruo wrote:
> > On 2021/7/21 上午9:11, Dave Chinner wrote:
> > If you believe your philosophy that every test tool should be a complex
> > mess, you're free to do whatever you always do.
> > 
> > And I can always express my objection just like you.
> > 
> > So, you want to build a complex framework using the simple hook, I would
> > just say NO.
> 
> I think that Dave's opinion is actually the reverse of this: hooks, if well
> designed, can be useful and facilitate adding functionalities to a complex test
> framework. And sure, the hook infrastructure implementation can in itself be
> complex, but if well designed, its use can be, and should be, very simple.
> 
> Implementation is done once. The complexity at that stage matters much less than
> the end result usability. As a general principle, the more time one put in
> design and development, the better the end result. Here, that means hooks being
> useful, flexible, extensible, and reusable.

Yup, that's pretty much what I'm advocating for.

I'm thinking that it is something relatively simple like this:

fstests/tests/hooks
- directory containing library of hook scripts

fstests/hooks/
- directory containing symlinks to hook scripts
- kept under gitignore, as hooks are a runtime configurable state,
  not a global repository configured state.
- symlink names indicate run target and order:
  	$seq.{B,E}.X
  where:	$seq is the test that the hook runs for
  			use "global" for a hook that every test runs
  		{B,E} indicates a test Begin or End hook
		X is an integer indicating run order,
			- 0 being the first script
			- Run in ascending numerical order


Now if you want to add a 'trace-cmd clear' command to run before
the start of a specific test, you do:

$ echo trace-cmd clear > tests/hooks/trace-cmd-clear
$ ln -s tests/hooks/trace-cmd-clear hooks/btrfs-160.B.0

And now when btrfs/160 starts, the Begin hook that you've set up is
run....

If you want to do this for other tests, too, then just add symlinks
for those tests. If you want all tests to run this trace hook, link
global.B.0 to the hook script. Essentially, managing the hooks to
run becomes an exercise in linking and unlinking external hook
scripts.

This means we can add curated hook scripts such as "use trace-cmd to
trace all xfs trace points and then dump the report into
$RESULTS_DIR/$seqres.traces" and hook them into to specific tests.
The setup also allows stacked hook scripts, so we can have multiple
monitoring options running at the same time (e.g. blktrace-scratch +
trace-cmd-xfs) without having to write a custom hook scripts.

> And one of the functionality of the hook setup could be "temporary, external
> hook" for some very special case debugging as you seem to need that. What you
> want to do and what Dave is proposing are not mutually exclusive.

Yup, if you want a one-off throwaway hook script, then just add a
file in to fstests/hooks and either name it as per above or link it
to the test it should hook.

Note: this just addresses the management side of running and
curating hook scripts. There's a whole 'nother discussion about
APIs to be had, but a curated hook library inside fstests is
definitely a viable solution to that problem, too, because then the
hook scripts can be changed at the same time the rest of fstests is
changed to use the modified API....

This isn't a huge amount of work to implement, but we really need to
decide how these hooks are going to be maintained, managed and
curated before we go much further...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
