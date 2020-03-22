Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A39518ED5C
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Mar 2020 00:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgCVXtf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 22 Mar 2020 19:49:35 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40402 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgCVXtf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Mar 2020 19:49:35 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 9764F62716C; Sun, 22 Mar 2020 19:49:34 -0400 (EDT)
Date:   Sun, 22 Mar 2020 19:49:34 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Question: how understand the raid profile of a btrfs filesystem
Message-ID: <20200322234934.GE2693@hungrycats.org>
References: <517dac49-5f57-2754-2134-92d716e50064@alice.it>
 <20200321032911.GR13306@hungrycats.org>
 <fd306b0b-8987-e1e7-dee5-4502e34902c3@inwind.it>
 <20200321232638.GD2693@hungrycats.org>
 <3fb93a14-3608-0f64-cf5c-ca37869a76ef@inwind.it>
 <d472962c-c669-3004-7ab4-be65a6ed72ba@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <d472962c-c669-3004-7ab4-be65a6ed72ba@inwind.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 22, 2020 at 09:38:30AM +0100, Goffredo Baroncelli wrote:
> On 3/22/20 9:34 AM, Goffredo Baroncelli wrote:
> 
> > 
> > To me it seems complicated to
> [sorry I push the send button too early]
> 
> To me it seems too complicated (and error prone) to derive the target profile from an analysis of the filesystem.
> 
> Any thoughts ?

I still don't understand the use case you are trying to support.

There are 3 states for a btrfs filesystem:

	1.  All block groups use the same profile.  Pick any one,
	use its profile for future block groups.  Avoid deleting the
	last one.  Simple and easy to implement.

	2.  A conversion is in progress.  Look in fs_info->balance_ctl
	for a 'convert' filter.  If there is one, that's the profile for
	new block groups.  Old block groups will be emptied and destroyed
	by conversion, and then we automatically go back to state #1.

	3.  A conversion is interrupted prior to completion.  Sysadmin is
	expected to proceed immediately back to state #2, possibly after
	taking any necessary recovery actions that triggered entry into
	state #3.  It doesn't really matter what the current allocation
	profile is, since it is likely to change before we allocate
	any more block groups.

You seem to be trying to sustain or support a filesystem in state #3 for
a prolonged period of time.  Why would we do that?  If your use case is
providing information or guidance to a user, tell them how to get back
to state #2 ASAP, so that they can then return to state #1 where they
should be.

Suppose your use case does involve staying in state #3 for a prolonged
period of time--let's say e.g. you want to be able to use file attributes
to put some file data on single profile while putting other files on raid5
profile.  That use case would need to come with a bunch of infrastructure
to support it, i.e. you'd need to define what the attributes are, and
how btrfs could map those to device subsets and raid profiles.  None of
this exists, and even if it did, it would conflict with the "store the
[singular] target profile on disk" idea.

There could be a warning message in dmesg if we enter state #3.
This message would appear after a converting balance is cancelled or
aborted, and on mount when we scan block groups (which we would still need
to do even after we added a "target profile" field to the superblock).
Userspace like 'btrfs fi df' could also put out a warning like "multiple
allocation profiles detected, but conversion is not in progress.  Please
finish conversion at your earliest convenience to avoid disappointment."
I don't see the need to do anything more about it.

We only get to state #3 if the automation has already failed, or has
been explicitly cancelled at sysadmin request.  It is better to wait
for the sysadmin to decide what to do next, especially if the sysadmin's
prior choice led to us entering this state (e.g. not enough space to
complete a conversion to the target profile, so we can no longer use
the target profile for new allocations).  Picking a target profile
at random (from the set of profiles already used in the filesystem)
is no better or worse than any deterministic algorithm--it will always
be wrong in some situations, and a good choice in other situations.

I'd even consider removing the heuristics that are already there for
prioritizing profiles.  They are just surprising and undocumented
behavior, and it would be better to document it as "random, BTW you
should finish your conversion now."  It doesn't help if e.g. you
want to convert from raid6 to raid1, since the heuristic assumes you
only want to go the other way.


> BR
> G.Baroncelli
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> 
