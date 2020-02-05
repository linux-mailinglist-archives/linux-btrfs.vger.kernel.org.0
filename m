Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3617B153216
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 14:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgBENoR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 08:44:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:51990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgBENoQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 08:44:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F137BAC84;
        Wed,  5 Feb 2020 13:44:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2EE48DA7E6; Wed,  5 Feb 2020 14:44:02 +0100 (CET)
Date:   Wed, 5 Feb 2020 14:44:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/3] btrfs: add a comment describing delalloc space
 reservation
Message-ID: <20200205134401.GK2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200203204436.517473-1-josef@toxicpanda.com>
 <20200203204436.517473-3-josef@toxicpanda.com>
 <7000f8a2-4d78-d9a1-2e3f-143b88ace1eb@gmx.com>
 <55055cf9-2c36-8e3e-d1b8-b3fb53cc03c1@suse.com>
 <356f2d03-bc34-7d13-ff0c-15cf39676333@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <356f2d03-bc34-7d13-ff0c-15cf39676333@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 04, 2020 at 08:39:19PM +0800, Qu Wenruo wrote:
> >> Although I'm not sure if such lifespan should belong to delalloc-space.c.
> >
> > This omits a lot of critical details. FOr example it should be noted
> > that in btrfs_buffered_write we reserve as much space as is requested by
> > the user. Then in run_delalloc_range it must be mentioned that in case
> > of compressed extents it can be called to allocate an extent which is
> > less than the space reserved in btrfs_buffered_write => that's where the
> > possible space savings in case of compressed come from.
> 
> If you spoiler everything in the introduction, I guess it's no longer
> introduction.
> An introduction should only tell the overall picture, not every details.
> For details, we go read mentioned functions.
> 
> And too many details would make the introduction pretty hard to
> maintain. What if one day we don't the current always reserve behavior
> for buffered write?
> 
> So I tend to have just a overview, and entrance function. With minimal
> details unless it's a really complex design.

I'd rather keep it as it is and enhance more, the ascii graphics might
help but I don't insist. Even if it's introductory, giving just pointers
would be IMHO too little. I'm assuming the overview should be enough to
read and then go to code and already have a clue what's happening.

We can update the docs further but we need a start so I've applied v2 to
misc-next and let's take that as starting point so we can discuss
suggested improvements as new patches. In case there's something that
really does not fit the .c file comment there's always the docs git
repository.
