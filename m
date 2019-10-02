Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7DDEC8AAD
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 16:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfJBOO5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 10:14:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:45256 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726200AbfJBOO4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Oct 2019 10:14:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0C248ACA4;
        Wed,  2 Oct 2019 14:14:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3DEF4DA88C; Wed,  2 Oct 2019 16:15:12 +0200 (CEST)
Date:   Wed, 2 Oct 2019 16:15:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     dsterba@suse.cz, josef@toxicpanda.com, clm@fb.com,
        dsterba@suse.com, axboe@kernel.dk, jack@suse.cz,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCHSET v3 btrfs/for-next] btrfs: fix cgroup writeback support
Message-ID: <20191002141512.GP2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Tejun Heo <tj@kernel.org>,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, axboe@kernel.dk,
        jack@suse.cz, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190710192818.1069475-1-tj@kernel.org>
 <20190726151321.GF2868@twin.jikos.cz>
 <20190905115937.GA2850@twin.jikos.cz>
 <20190906174656.GQ2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906174656.GQ2263813@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 06, 2019 at 10:46:56AM -0700, Tejun Heo wrote:
> On Thu, Sep 05, 2019 at 01:59:37PM +0200, David Sterba wrote:
> > On Fri, Jul 26, 2019 at 05:13:21PM +0200, David Sterba wrote:
> > > On Wed, Jul 10, 2019 at 12:28:13PM -0700, Tejun Heo wrote:
> > > > This patchset contains only the btrfs part of the following patchset.
> > > > 
> > > >   [1] [PATCHSET v2 btrfs/for-next] blkcg, btrfs: fix cgroup writeback support
> > > > 
> > > > The block part has already been applied to
> > > > 
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/ for-linus
> > > > 
> > > > with some naming changes.  This patchset has been updated accordingly.
> > > 
> > > I'm going to add this patchset to for-next to get some testing coverage,
> > > there are some comments pending, but that are changelog updates and
> > > refactoring.
> > 
> > No updates, so patchset stays in for-next, closest merge target is 5.5.
> 
> Sorry about dropping the ball.  It looked like Chris and Nikolay
> weren't agreeing so I wasn't sure what the next step should be and
> then forgot about it.  The following is the discussion.
> 
>   https://lore.kernel.org/linux-btrfs/c2419d01-5c84-3fb4-189e-4db519d08796@suse.com/
> 
> What do you think about the exchange?

I've read the thread again and talked to Nikolay. After going through
the questions raised for patch 3/5, I'm more or less ok with merging it
as there are no blockers.  I'll update the changelogs with points from
the discussion.

The patchset has been in for-next for some months now so we have testing
coverage but we'll have more in the main devel patch queue, that I'll
add after I do one more review pass.
