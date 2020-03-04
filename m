Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 535F617918E
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 14:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgCDNkf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 08:40:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:32928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728278AbgCDNkf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 08:40:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CE6CCB3C2;
        Wed,  4 Mar 2020 13:40:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2F40BDA7B4; Wed,  4 Mar 2020 14:40:09 +0100 (CET)
Date:   Wed, 4 Mar 2020 14:40:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/19] btrfs: Move generic backref cache build functions
 to backref.c
Message-ID: <20200304134009.GQ2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200303071409.57982-1-wqu@suse.com>
 <b6520f1a-4849-4390-6aa8-e08e69bebcd8@toxicpanda.com>
 <886e97a1-2dff-7a1e-1324-6c389bb972b9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <886e97a1-2dff-7a1e-1324-6c389bb972b9@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 04, 2020 at 12:54:24PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/3/4 上午5:22, Josef Bacik wrote:
> > On 3/3/20 2:13 AM, Qu Wenruo wrote:
> >> The patchset is based on previous backref_cache_refactor branch, which
> >> is further based on misc-next.
> >>
> >> The whole series can be fetched from github:
> >> https://github.com/adam900710/linux/tree/backref_cache_code_move
> >>
> >> All the patches in previous branch is not touched at all, thus they are
> >> not re-sent in this patchset.
> >>
> >>
> >> Currently there are 3 major parts of build_backref_tree():
> >> - ITERATION
> >>    This will do a breadth-first search, starts from the target bytenr,
> >>    and queue all parents into the backref cache.
> >>    The result is a temporary map, which is only single-directional, and
> >>    involved new backref nodes are not yet inserted into the cache.
> >>
> >> - WEAVING
> >>    Finish the map to make it bi-directional, and insert new nodes into
> >>    the cache.
> >>
> >> - CLEANUP
> >>    Cleanup the useless nodes, either remove it completely or add them
> >>    into the cache as detached.
> >>
> > 
> > I've found a bunch of bugs in the backref code while fixing Zygo's
> > problem, you are probably going to want to wait for my patches to go in
> > before you start moving things around, because it's going to conflict a
> > bunch.  Thanks,
> 
> No problem, it's expected to have some comments even for previous patchset.
> 
> So rebasing is expected.

The fixes get merged first so they can be applied to older stable trees,
the cleanups that move code are best done as the last thing in the patch
queue. So this depends on timing and the amount of conflicts but we have
like 2 rcs to go.
