Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B903D0653
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 03:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhGUAaj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 20:30:39 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:37485 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230083AbhGUAae (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 20:30:34 -0400
Received: from dread.disaster.area (pa49-181-34-10.pa.nsw.optusnet.com.au [49.181.34.10])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id EAAAC69AA6;
        Wed, 21 Jul 2021 11:11:06 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1m60lN-008vEM-LB; Wed, 21 Jul 2021 11:11:05 +1000
Date:   Wed, 21 Jul 2021 11:11:05 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eryu Guan <eguan@linux.alibaba.com>, Qu Wenruo <wqu@suse.com>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
Message-ID: <20210721011105.GA2112234@dread.disaster.area>
References: <20210720002536.GA2031856@dread.disaster.area>
 <3f2d4ebd-bf75-b283-45be-3fa81e65d5bf@gmx.com>
 <20210720021437.GB2031856@dread.disaster.area>
 <cb2bf09e-91fd-2976-4366-4daf29664890@gmx.com>
 <20210720064317.GC2031856@dread.disaster.area>
 <20210720075748.GJ60846@e18g06458.et15sqa>
 <3fd6494b-8f03-4d97-9d00-21343e0e8152@gmx.com>
 <6b7699a9-fc5e-32d9-78c5-9c0e3cf92895@gmx.com>
 <YPbt2ohi62VyWN7e@mit.edu>
 <f37bec82-85cd-b818-8691-6c047751c4a6@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f37bec82-85cd-b818-8691-6c047751c4a6@gmx.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=hdaoRb6WoHYrV466vVKEyw==:117 a=hdaoRb6WoHYrV466vVKEyw==:17
        a=kj9zAlcOel0A:10 a=e_q4qTt1xDgA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=5wG-iPeVDH74maIrQxkA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 21, 2021 at 06:34:16AM +0800, Qu Wenruo wrote:
> I would no longer consider to upstream any simple debug purposed code.

Qu, please stop behaving like a small child throwing a tantrum
because they were told no.

If there's good reason to host debug code in the fstests repository,
that's where it should go. See the patch I just posted that adds a
dm-logwrites replay script to the tools/ directory:

https://lore.kernel.org/fstests/20210721001333.2999103-1-david@fromorbit.com/T/#u

This is really necessary to be able to analyse failures from tests
that use dm-logwrites, and such a tool does not exist. Rather than
requiring every developer that has to debug a dm-logwrites failure
have to write their own replay tool, fstests should provide one.

That's the whole point here.  I could be selfish and say "it's a
debugging tool, I don't need to publish it because others can just
write their own", but that ignores the fact it took me the best part
of two days just to come up to speed on what dm-logwrites and
generic/482 was doing before I could even begin to debug the
failure.

Requiring everyone to pass that high bar just to begin to debug a
g/482 failure is not an effective use of community time and
resources. The script I wrote embodies the main logwrites
interactions I needed to reproduce and debug the issue, and I don't
think anyone else should need to spend a couple of days of WTFing
around the logwrites code just to be able to manually replay a
failed g/482 test case. I've sunk that cost into a simple to use
script and by pushing it into the fstests repository nobody else now
needs to spend that time to write a manual replay script.

If we apply that same logic to debugging hooks and the scripts that
they run, then a hook script that is useful to one person for
debugging a complex test is probably going to be useful to many more
people. Hence if we are going to include hooks into the fstests
infrastructure, we also need to consider including a method of
curating a libary of hook scripts that people can just link into the
hooks/ directory and start using with no development time at all.

You need to stop thinking about debug code as "throw-away code".
Debug code is just as important, if not more important, than the code
that is being tested. As Brian Kernighan once said:

	"Debugging is twice as hard as writing the code in the first
	place. Therefore, if you write the code as cleverly as
	possible, you are, by definition, not smart enough to debug
	it."

Put simply, anything we can do to lower the bar for debugging
complex code exercised by complex tests is worth doing and *worth
doing well*. Hooks can be a powerful debugging tool, but the
introduction of such infrastructure needs more discussion and
consideration than "here's a rudimetary start/end hook for one-off
throw-away debug code".

Most importantly, the discussion needs a much more constructive
conversation than responding "No because I don't care about anyone
else" to every suggestion or potential issue that is raised. Please
try to be constructive and help move the discussion forward,
otherwise the functionality you propose won't go anywhere largely
because of your own behaviour rather than for unsovlable technical
reasons...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
