Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20994C21B5
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 03:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiBXCWA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Feb 2022 21:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiBXCV7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Feb 2022 21:21:59 -0500
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E09637A80;
        Wed, 23 Feb 2022 18:21:30 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 4D17953293A;
        Thu, 24 Feb 2022 13:21:29 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nN3l2-00Fgsu-7u; Thu, 24 Feb 2022 13:21:28 +1100
Date:   Thu, 24 Feb 2022 13:21:28 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: test log replay after fsync of file with prealloc
 extents beyond eof
Message-ID: <20220224022128.GK3061737@dread.disaster.area>
References: <abbc821350c8ef515e0a0317b5cbd64e3c5b81ab.1645099449.git.fdmanana@suse.com>
 <20220222234432.GF3061737@dread.disaster.area>
 <CAL3q7H41wY_GWStRUxuOWwPcgqX9zx-WZxEySaRAUrMtcE666w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H41wY_GWStRUxuOWwPcgqX9zx-WZxEySaRAUrMtcE666w@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6216ebaa
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=oGFeUVbbRNcA:10 a=7-415B0cAAAA:8 a=VwQbUJbxAAAA:8
        a=iox4zFpeAAAA:8 a=XrNU82xa2msIkV6VhdkA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22 a=AjGcO6oz07-iQ99wixmX:22
        a=WzC6qhA0u3u7Ye7llzcV:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 23, 2022 at 12:12:10PM +0000, Filipe Manana wrote:
> On Tue, Feb 22, 2022 at 11:44 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Thu, Feb 17, 2022 at 12:14:21PM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Test that after a full fsync of a file with preallocated extents beyond
> > > the file's size, if a power failure happens, the preallocated extents
> > > still exist after we mount the filesystem.
> > >
> > > This test currently fails and there is a patch for btrfs that fixes this
> > > issue and has the following subject:
> > >
> > >   "btrfs: fix lost prealloc extents beyond eof after full fsync"
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  tests/btrfs/261     | 79 +++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/btrfs/261.out | 10 ++++++
> >
> > What is btrfs specific about this test?
> 
> The comments that explain the steps are very btrfs specific.
> Without them it would be hard to understand why the test uses that
> specific file size, block size, mention of the btrfs inode's full sync
> bit, etc.

But the behaviour and layout should end up being the same for all
filesystems, right?

We have plenty of generic tests that are designed with a
specific configuration on a specific filesystem to reproduce a bug
seen on that filesystem, but as long as all filesystems should be
expected to behave the same way, it's a generic test.

AFAICT, the behaviour described and exercised by the test should be
the same for all filesystems that support preallocation beyond EOF.
Hence it isn't btrfs specific behaviour being exercised, just a
reproducing a bug where btrfs deviates from the correct behaviour
that should be consistent across all filesystems.

> Some years ago, when you maintained fstests, you complained once about
> this type of "too btrfs specific" comments on generic tests.

I can change my mind if I want. Besides, I'm looking at this new
test purely on it's own merits so past discussions aren't really
relevant. Maybe you didn't understand the context under which I was
considering a patch to be "too fs specific" rather than generic.

There's a big difference between "only btrfs will behave this way"
and "all filesystems should get the same result, but btrfs sometimes
fails to get that results in this specific case".  The former should
be a btrfs-only test, the latter should be a generic test.

Which class this test falls into is exactly what I'm asking here -
should all filesystems get the same result, or is successful
result encoded in the golden output behaviour that only btrfs will
ever produce?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
