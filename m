Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC49331553
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 18:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhCHRzR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Mar 2021 12:55:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:35338 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhCHRzQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Mar 2021 12:55:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7485AB8C;
        Mon,  8 Mar 2021 17:55:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C56EFDA81B; Mon,  8 Mar 2021 18:53:17 +0100 (CET)
Date:   Mon, 8 Mar 2021 18:53:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/4] Introduce a mmap sem to deal with some mmap issues
Message-ID: <20210308175317.GE7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1612995212.git.josef@toxicpanda.com>
 <20210304174741.GW7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304174741.GW7604@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 04, 2021 at 06:47:41PM +0100, David Sterba wrote:
> On Wed, Feb 10, 2021 at 05:14:32PM -0500, Josef Bacik wrote:
> > v1->v2:
> > - Rebase against misc-next.
> > - Add Filipe's reviewed-bys.
> > 
> > --- Original email ---
> > 
> > Hello,
> > 
> > Both Filipe and I have found different issues that result in the same thing, we
> > need to be able to exclude mmap from happening in certain scenarios.  The
> > specifics are well described in the commit logs, but generally there's 2 issues
> > 
> > 1) dedupe needs to validate that pages match, and since the validation is done
> >    outside of the extent lock we can race with mmap and dedupe pages that do not
> >    match.
> > 2) We can deadlock in certain low metadata scenarios where we need to flush
> >    an ordered extent, but can't because mmap is holding the page lock.
> > 
> > These issues exist for remap and fallocate, so add an i_mmap_sem to allow us to
> > disallow mmap in these cases.  I'm still waiting on xfstests to finish with
> > this, but 2 hours in and no lockdep or deadlocks.  Thanks,
> > 
> > Josef Bacik (4):
> >   btrfs: add a i_mmap_lock to our inode
> >   btrfs: cleanup inode_lock/inode_unlock uses
> >   btrfs: exclude mmaps while doing remap
> >   btrfs: exclude mmap from happening during all fallocate operations
> 
> Added as a topic branch to for-next.

Moved to misc-next. The added semaphore is not exactly cheap in terms of
in memory inode, but the dio_sem got removed recently so it's not that
bad. Regarding performance, there's probably some hit but in this case
correctness must come first so we can't do much about that. Thanks.
