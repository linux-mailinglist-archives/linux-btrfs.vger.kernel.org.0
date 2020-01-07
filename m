Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB88132B3E
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 17:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgAGQlV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 11:41:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:36564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgAGQlU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jan 2020 11:41:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 42D98B172;
        Tue,  7 Jan 2020 16:41:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 46FDBDA78B; Tue,  7 Jan 2020 17:41:09 +0100 (CET)
Date:   Tue, 7 Jan 2020 17:41:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [bug report] btrfs: get rid of trivial __btrfs_lookup_bio_sums()
 wrappers
Message-ID: <20200107164108.GB3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dan Carpenter <dan.carpenter@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20200107081058.35la6yytkwly2h52@kili.mountain>
 <20200107161046.GZ3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107161046.GZ3929@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 07, 2020 at 05:10:46PM +0100, David Sterba wrote:
> On Tue, Jan 07, 2020 at 11:10:58AM +0300, Dan Carpenter wrote:
> >    276                  diff = diff * csum_size;
> >    277                  count = min_t(int, nblocks, (item_last_offset - disk_bytenr) >>
> >    278                                              inode->i_sb->s_blocksize_bits);
> >    279                  read_extent_buffer(path->nodes[0], csum,
> >    280                                     ((unsigned long)item) + diff,
> >    281                                     csum_size * count);
> >    282  found:
> >    283                  csum += count * csum_size;
> >    284                  nblocks -= count;
> >    285  next:
> >    286                  while (count--) {
> >                                ^^^^^^^
> > This loop exits with count set to -1.
> > 
> >    287                          disk_bytenr += fs_info->sectorsize;
> >    288                          offset += fs_info->sectorsize;
> >    289                          page_bytes_left -= fs_info->sectorsize;
> >    290                          if (!page_bytes_left)
> >    291                                  break; /* move to next bio */
> >    292                  }
> >    293          }
> >    294  
> >    295          WARN_ON_ONCE(count);
> >                              ^^^^^
> > Originally this warning was next to the line 291 so it should probably
> > be "WARN_ON_ONCE(count >= 0);"  This WARN is two years old now and no
> > one has complained about it at run time.  That's very surprising to me
> > because I would have expected count to -1 in the common case.
> 
> Possible explanation I see is that the "if (!page_bytes_left)" does not
> let the count go from 0 -> -1 and exits just in time. I'm runing a test
> to see if it's true.

It is. It's not very clear from the context, count is set up so that it
matches page_bytes_left decrements. So using "count--" is not completely
wrong, but it is confusing and relying on other subtle behaviour. It
should be either --count or the decrement moved to out of the condition.

I can write the patch and add you as reporter or you can send the patch
as you did the analysis in the first place.
