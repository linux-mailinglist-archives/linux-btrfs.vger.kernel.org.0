Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5265E17AAAA
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2020 17:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgCEQjQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Mar 2020 11:39:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:57466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbgCEQjP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Mar 2020 11:39:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 34B22B2B7;
        Thu,  5 Mar 2020 16:39:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 01302DA733; Thu,  5 Mar 2020 17:38:50 +0100 (CET)
Date:   Thu, 5 Mar 2020 17:38:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v3 3/3] Btrfs: implement full reflink support for inline
 extents
Message-ID: <20200305163850.GE2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
References: <20200224171327.3655282-1-fdmanana@kernel.org>
 <5e044000-09e8-ade1-69a6-44cfc59fdc48@toxicpanda.com>
 <CAL3q7H7twdkw1LphkCWexABjT=WGxKHQvq7hsq+99VF5KJE3Uw@mail.gmail.com>
 <20200305141959.GC2902@twin.jikos.cz>
 <CAL3q7H7v4iVheXM_hCt2jaK+JK360ZjA-Ff6FZTGOhm4Zho23w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7v4iVheXM_hCt2jaK+JK360ZjA-Ff6FZTGOhm4Zho23w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 05, 2020 at 03:03:14PM +0000, Filipe Manana wrote:
> On Thu, Mar 5, 2020 at 2:20 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Thu, Mar 05, 2020 at 11:57:52AM +0000, Filipe Manana wrote:
> > > So this actually isn't safe.
> > >
> > > It can bring back the race that leads to file extent items with
> > > overlapping ranges. Not because of the hole detection part but because
> > > of the part where we copy extent items from the fs/subvolume tree into
> > > the log tree using btrfs_search_forward(), as we copy all extent
> > > items, including the ones outside the fsync range - so we could race
> > > in the same way as we did during hole detection with ordered extent
> > > completion for ordered extents outside the range.
> > >
> > > I'll have to rework this a bit.
> >
> > Ok, I'll remove the branch from for-next. Thanks.
> 
> Wrong thread, the comment was meant for:
> https://patchwork.kernel.org/patch/11419793/

Saw it just now and taht was a bit wtf if my mail did not make it
through. So, reflink stays in for-next.
