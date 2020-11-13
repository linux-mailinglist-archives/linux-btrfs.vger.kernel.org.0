Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EC42B1D97
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 15:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgKMOja (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 09:39:30 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46768 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgKMOja (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 09:39:30 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 148978A41B3; Fri, 13 Nov 2020 09:39:26 -0500 (EST)
Date:   Fri, 13 Nov 2020 09:39:26 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/42] Cleanup error handling in relocation
Message-ID: <20201113143925.GC31381@hungrycats.org>
References: <cover.1605215645.git.josef@toxicpanda.com>
 <20201113035342.GB31381@hungrycats.org>
 <1658d318-3434-3e27-bcf5-00060233f10c@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658d318-3434-3e27-bcf5-00060233f10c@toxicpanda.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 06:03:39AM -0500, Josef Bacik wrote:
> On 11/12/20 10:53 PM, Zygo Blaxell wrote:
> > On Thu, Nov 12, 2020 at 04:18:27PM -0500, Josef Bacik wrote:
> > > Hello,
> > > 
> > > Relocation is the last place that is not able to handle errors at all, which
> > > results in all sorts of lovely panics if you encounter corruptions or IO errors.
> > > I'm going to start cleaning up relocation, but before I move code around I want
> > > the error handling to be somewhat sane, so I'm not changing behavior and error
> > > handling at the same time.
> > > 
> > > These patches are purely about error handling, there is no behavior changing
> > > other than returning errors up the chain properly.  There is a lot of room for
> > > follow up cleanups, which will happen next.  However I wanted to get this series
> > > done today and out so we could get it merged ASAP, and then the follow up
> > > cleanups can happen later as they are less important and less critical.
> > > 
> > > The only exception to the above is the patch to add the error injection sites
> > > for btrfs_cow_block and btrfs_search_slot, and a lockdep fix that I discovered
> > > while running my tests, those are the first two patches in the series.
> > > 
> > > I tested this with my error injection stress test, where I keep track of all
> > > stack traces that have been tested and only inject errors when we have a new
> > > stack trace, which means I should have covered all of the various error
> > > conditions.  With this patchset I'm no longer panicing while stressing the error
> > > conditions.  Thanks,
> > 
> > I just threw this patch set on top of kdave/for-next
> > (a12315094469d573e41fe3eee91c99a83cec02df) and I got something that
> > looks like runaway balances:
> > 
> 
> Yup I hit this with my xfstests run that I started after I sent these out, I
> got a little happy with deleting things for one of the patches, this time
> I'm running xfstests _before_ I send the next version.  Thanks,

Well, the good news is you killed the BUG_ON I was hitting every few hours
while running a test that sends a SIGINT to balance:

	https://lore.kernel.org/linux-btrfs/20200904155359.GC5890@hungrycats.org/

so I'm looking forward to the next version.

> Josef
