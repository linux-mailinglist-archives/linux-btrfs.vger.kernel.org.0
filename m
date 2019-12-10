Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBA2118FC1
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 19:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfLJS0H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 13:26:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:49116 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726771AbfLJS0G (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 13:26:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 23490B246;
        Tue, 10 Dec 2019 18:26:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6B07ADA727; Tue, 10 Dec 2019 19:26:06 +0100 (CET)
Date:   Tue, 10 Dec 2019 19:26:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 1/9] btrfs: get rid of trivial __btrfs_lookup_bio_sums()
 wrappers
Message-ID: <20191210182606.GG3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
References: <cover.1575336815.git.osandov@fb.com>
 <af5aefd84186419ead73107895ddd6aba02ef8b6.1575336815.git.osandov@fb.com>
 <20191210171210.GC3929@twin.jikos.cz>
 <20191210182430.GA204474@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210182430.GA204474@vader>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 10, 2019 at 10:24:30AM -0800, Omar Sandoval wrote:
> On Tue, Dec 10, 2019 at 06:12:10PM +0100, David Sterba wrote:
> > On Mon, Dec 02, 2019 at 05:34:17PM -0800, Omar Sandoval wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > > 
> > > Currently, we have two wrappers for __btrfs_lookup_bio_sums():
> > > btrfs_lookup_bio_sums_dio(), which is used for direct I/O, and
> > > btrfs_lookup_bio_sums(), which is used everywhere else. The only
> > > difference is that the _dio variant looks up csums starting at the given
> > > offset instead of using the page index, which isn't actually direct
> > > I/O-specific. Let's clean up the signature and return value of
> > > __btrfs_lookup_bio_sums(), rename it to btrfs_lookup_bio_sums(), and get
> > > rid of the trivial helpers.
> > > 
> > >  				ret = btrfs_lookup_bio_sums(inode, comp_bio,
> > > -							    sums);
> > > +							    false, 0, sums);
> > 
> > > -		ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
> > > +		ret = btrfs_lookup_bio_sums(inode, comp_bio, false, 0, sums);
> > 
> > > -			ret = btrfs_lookup_bio_sums(inode, bio, NULL);
> > > +			ret = btrfs_lookup_bio_sums(inode, bio, false, 0, NULL);
> > 
> > > -		ret = btrfs_lookup_bio_sums_dio(inode, dip->orig_bio,
> > > -						file_offset);
> > > +		ret = btrfs_lookup_bio_sums(inode, dip->orig_bio, true,
> > > +					    file_offset, NULL);
> > 
> > Can't we also get rid of the at_offset parameter? Encoding that into
> > file_offset itself where at_offset=true would be some special
> > placeholder like (u64)-1 that can never be a valid file offset.
> 
> Yeah Nikolay mentioned this as well but I was on the fence about whether
> it would look any nicer. I'll go ahead and make that change.

Ok, let's do that as another patch so it's not mixed to the helper
removal. Thanks.
