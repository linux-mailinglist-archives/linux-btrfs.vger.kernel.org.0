Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361B83CFDC4
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 17:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242188AbhGTO7x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 10:59:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36581 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241953AbhGTO54 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 10:57:56 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-100.corp.google.com [104.133.0.100] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16KFc3L1021009
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 11:38:04 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2949A4202F5; Tue, 20 Jul 2021 11:38:02 -0400 (EDT)
Date:   Tue, 20 Jul 2021 11:38:02 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Eryu Guan <eguan@linux.alibaba.com>,
        Dave Chinner <david@fromorbit.com>, Qu Wenruo <wqu@suse.com>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
Message-ID: <YPbt2ohi62VyWN7e@mit.edu>
References: <20210719071337.217501-1-wqu@suse.com>
 <20210720002536.GA2031856@dread.disaster.area>
 <3f2d4ebd-bf75-b283-45be-3fa81e65d5bf@gmx.com>
 <20210720021437.GB2031856@dread.disaster.area>
 <cb2bf09e-91fd-2976-4366-4daf29664890@gmx.com>
 <20210720064317.GC2031856@dread.disaster.area>
 <20210720075748.GJ60846@e18g06458.et15sqa>
 <3fd6494b-8f03-4d97-9d00-21343e0e8152@gmx.com>
 <6b7699a9-fc5e-32d9-78c5-9c0e3cf92895@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b7699a9-fc5e-32d9-78c5-9c0e3cf92895@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 20, 2021 at 04:44:29PM +0800, Qu Wenruo wrote:
> Anyway, if building a stable and complex API just for hooks, then it's
> completely against my initial purpose.

So you said you are only using this for debugging purposes; at least
in my workflow, when I'm trying to debug a particular test case, I'm
*only* run a single test.  So today, the way I handle this is to run
hook scripts in the gce-xfstests framework before and after running
the check script.  It does mean that there is excess work which gets
traced from the check script setting up and cleaning up, but it's
mainly been good enough for me.

It would be slightly nicer if there was a way to start and stop
various debugging hooks (e.g., starting and stopping traces, clearing
and grabing the lock_Stat info), etc.,) jut before and starting the
test.  But it was never important to me to propose changes to the
upstream xfstests.

In answer to the question which Darrick and Dave asked, yes, I could
do this via the exclude list.  It just seemed that if we're going to
add a programmtic hook, maybe it would make sense to do it via the
hook script.  It is true that there are ways to do this, though,
although there is a difference to a static excldue list that has to
get created for all tests that might be run, versus hook script that
is run for each test.  <Shrug>  There are other ways of doing things;
the question is whether the hook script approach is sufficiently
better that it's worth getting something like this upstream.  It may
be that keeping things like this in each developer's own private test
runner is the right thing.   I have "gce-xfstests --hooks <hookdir>" for
my own use, and have had it for years.

Cheers,

					- Ted

