Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E584822395C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jul 2020 12:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgGQKfR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jul 2020 06:35:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:58400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgGQKfR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jul 2020 06:35:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7386FB614;
        Fri, 17 Jul 2020 10:35:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A124FDA8A5; Fri, 17 Jul 2020 12:34:52 +0200 (CEST)
Date:   Fri, 17 Jul 2020 12:34:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Remove done label in writepage_delalloc
Message-ID: <20200717103452.GC3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200716151719.3967-1-nborisov@suse.com>
 <SN4PR0401MB3598754B32E2FAF5092C8EB09B7C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598754B32E2FAF5092C8EB09B7C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 17, 2020 at 07:31:22AM +0000, Johannes Thumshirn wrote:
> On 16/07/2020 17:17, Nikolay Borisov wrote:
> > Since there is not common cleanup run after the label it makes it somewhat
> > redundant.
> > 
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> > ---
> >  fs/btrfs/extent_io.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index a76b7da91aa6..e6d1d46ae384 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -3445,8 +3445,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
> >  			 * started, so we don't want to return > 0 unless
> >  			 * things are going well.
> >  			 */
> > -			ret = ret < 0 ? ret : -EIO;
> > -			goto done;
> > +			return ret < 0 ? ret : -EIO;
> >  		}
> >  		/*
> >  		 * delalloc_end is already one less than the total length, so
> > @@ -3478,10 +3477,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
> >  		return 1;
> >  	}
> > 
> > -	ret = 0;
> > -
> > -done:
> > -	return ret;
> > +	return 0;
> >  }
> 
> I thought David doesn't like direct returns in loops?
> 
> /me thinks this is easier to understand though

I don't but try to evaluate each patch if it makes sense and the code is
readable and does not diverge too much from patterns we have elsewhere.
This one looks ok, so I'll add it to misc-next.
