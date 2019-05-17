Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 132A12189F
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 14:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfEQMxO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 08:53:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:35830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728073AbfEQMxO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 08:53:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A1A44AF76;
        Fri, 17 May 2019 12:53:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C4222DA8A7; Fri, 17 May 2019 14:54:12 +0200 (CEST)
Date:   Fri, 17 May 2019 14:54:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Hans van Kranenburg <hans@knorrie.org>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 06/15] btrfs: use raid_attr table in calc_stripe_length
 for nparity
Message-ID: <20190517125412.GA3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Hans van Kranenburg <hans@knorrie.org>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1558085801.git.dsterba@suse.com>
 <a4a37111b3166662450059a35eb9998cf8f9677b.1558085801.git.dsterba@suse.com>
 <318e980a-8b63-f425-804d-4d87a9d13d34@knorrie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <318e980a-8b63-f425-804d-4d87a9d13d34@knorrie.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 17, 2019 at 12:06:05PM +0200, Hans van Kranenburg wrote:
> > -	default:
> > +	if (nparity)
> > +		data_stripes = num_stripes - nparity;
> > +	else
> >  		data_stripes = num_stripes / ncopies;
> > -		break;
> > -	}
> 
> A few lines earlier in that file we have this:
> 
>         /*
>          * this will have to be fixed for RAID1 and RAID10 over
>          * more drives
>          */
>         data_stripes = (num_stripes - nparity) / ncopies;
> 
> 1) I changed the calculation in b50836edf9 and did it in one statement,
> I see you use and extra if here. Which one do you prefer and why?

I did the cleanup only in the function and was not aware of the above,
but the ifs did not feel right so I'm glad you pointed that out.

And actually I think there must be an ultimate formula that also
includes the sub_stripes (raid10) and devs_increment (dup), this could
clean up the rest of the special cases.

> 2) Back then I wanted to get rid of that comment, because I don't
> understand it. "this will have to be fixed" does not tell me what should
> be fixed, so I left it there. Maybe now is the time? Do you know what
> this comment/warning means and if it can be removed? I mean, even with
> raid1c3 the calculation would be correct. There's no parity and three
> copies.

Yeah the comment does not help much, it was introduced by the monster
raid56 commit but I don't think there's anything to be fixed, regarding
raid1 or raid10.
