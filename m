Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B480712E8EA
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 17:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgABQsK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 11:48:10 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35504 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbgABQsK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 11:48:10 -0500
Received: by mail-qt1-f195.google.com with SMTP id e12so35090944qto.2
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 08:48:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7EPPwNi5A9XLHbMLmNHQ+8Cu4lie4l9v3txu2b77QVU=;
        b=E3z16uQ+cEuszduVs/CxhBJRrWFC1tqvP4mRhkmZ/B7wj31oEmYPnyV6Ek4l7Zd9Ex
         Tj47YJlJDuUA4tlA1uO/bZiumKIQan/W7loTQMznL7ikQLcZEnJUs2ONoG5CO5XwfiED
         AMEk0Fet7ogV7bNAGHc/RJZY1093tnyeR1CAeAwA1h8XUCkctS/kM5Pvm145gYHbI4ag
         fJ2qwQx5g2CpNEU2oSJwWPhuk2Y2NPbXPkoJQipCd0HI5M6iioh3hcDZAw9YVNdH0eRM
         QxWcTxntqTRMf3GYXZBwiZxSbzxh/nI6iZdpyd+j1P5/ogt5iWhs9oaBPYuYCGURqRWr
         CuSQ==
X-Gm-Message-State: APjAAAWSBw/ysOMxGl99dhDmYl1432e9VYmACCBdxvcefkK2RRv8MpcL
        DnLXJB8E901+fb11rssNqZg=
X-Google-Smtp-Source: APXvYqz+3SDzr2QDq8wGtpnzmAoXPoPZAe8NXC/JXh5OFhnF2K1tuvBp5B23oC8l3ZXiJ5ISQsKywQ==
X-Received: by 2002:ac8:704:: with SMTP id g4mr60598248qth.197.1577983689118;
        Thu, 02 Jan 2020 08:48:09 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::1:29bb])
        by smtp.gmail.com with ESMTPSA id f97sm17150322qtb.18.2020.01.02.08.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 08:48:08 -0800 (PST)
Date:   Thu, 2 Jan 2020 11:48:06 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 15/22] btrfs: limit max discard size for async discard
Message-ID: <20200102164806.GC86832@dennisz-mbp.dhcp.thefacebook.com>
References: <cover.1576195673.git.dennis@kernel.org>
 <396e2d043068b620574892ebfc4b9f5c77b41618.1576195673.git.dennis@kernel.org>
 <20191230180803.GB3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230180803.GB3929@twin.jikos.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 30, 2019 at 07:08:03PM +0100, David Sterba wrote:
> On Fri, Dec 13, 2019 at 04:22:24PM -0800, Dennis Zhou wrote:
> > Throttle the maximum size of a discard so that we can provide an upper
> > bound for the rate of async discard. While the block layer is able to
> > split discards into the appropriate sized discards, we want to be able
> > to account more accurately the rate at which we are consuming ncq slots
> > as well as limit the upper bound of work for a discard.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/discard.h          |  5 ++++
> >  fs/btrfs/free-space-cache.c | 48 +++++++++++++++++++++++++++----------
> >  2 files changed, 41 insertions(+), 12 deletions(-)
> > 
> > diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
> > index 3ed6855e24da..cb6ef0ab879d 100644
> > --- a/fs/btrfs/discard.h
> > +++ b/fs/btrfs/discard.h
> > @@ -3,10 +3,15 @@
> >  #ifndef BTRFS_DISCARD_H
> >  #define BTRFS_DISCARD_H
> >  
> > +#include <linux/sizes.h>
> > +
> >  struct btrfs_fs_info;
> >  struct btrfs_discard_ctl;
> >  struct btrfs_block_group;
> >  
> > +/* Discard size limits. */
> > +#define BTRFS_ASYNC_DISCARD_MAX_SIZE	(SZ_64M)
> > +
> >  /* Work operations. */
> >  void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
> >  			       struct btrfs_block_group *block_group);
> > diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> > index 57df34480b93..0dbcea6c59f9 100644
> > --- a/fs/btrfs/free-space-cache.c
> > +++ b/fs/btrfs/free-space-cache.c
> > @@ -3466,19 +3466,40 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
> >  		if (entry->offset >= end)
> >  			goto out_unlock;
> >  
> > -		extent_start = entry->offset;
> > -		extent_bytes = entry->bytes;
> > -		extent_trim_state = entry->trim_state;
> > -		start = max(start, extent_start);
> > -		bytes = min(extent_start + extent_bytes, end) - start;
> > -		if (bytes < minlen) {
> > -			spin_unlock(&ctl->tree_lock);
> > -			mutex_unlock(&ctl->cache_writeout_mutex);
> > -			goto next;
> > -		}
> > +		if (async) {
> > +			start = extent_start = entry->offset;
> > +			bytes = extent_bytes = entry->bytes;
> > +			extent_trim_state = entry->trim_state;
> > +			if (bytes < minlen) {
> > +				spin_unlock(&ctl->tree_lock);
> > +				mutex_unlock(&ctl->cache_writeout_mutex);
> > +				goto next;
> > +			}
> > +			unlink_free_space(ctl, entry);
> > +			if (bytes > BTRFS_ASYNC_DISCARD_MAX_SIZE) {
> > +				bytes = extent_bytes =
> > +					BTRFS_ASYNC_DISCARD_MAX_SIZE;
> > +				entry->offset += BTRFS_ASYNC_DISCARD_MAX_SIZE;
> > +				entry->bytes -= BTRFS_ASYNC_DISCARD_MAX_SIZE;
> > +				link_free_space(ctl, entry);
> > +			} else {
> > +				kmem_cache_free(btrfs_free_space_cachep, entry);
> > +			}
> > +		} else {
> 
> > +			extent_start = entry->offset;
> > +			extent_bytes = entry->bytes;
> > +			extent_trim_state = entry->trim_state;
> 
> This is common initialization for both async and sync cases so it could
> be merged to a common block.
> 

I removed the chain initialization and moved the common out.

> > +			start = max(start, extent_start);
> > +			bytes = min(extent_start + extent_bytes, end) - start;
> > +			if (bytes < minlen) {
> > +				spin_unlock(&ctl->tree_lock);
> > +				mutex_unlock(&ctl->cache_writeout_mutex);
> > +				goto next;
> > +			}
