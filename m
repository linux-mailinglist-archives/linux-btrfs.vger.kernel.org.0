Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94FF3F8ECD
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 21:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243484AbhHZTjk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 15:39:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54086 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243480AbhHZTjk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 15:39:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E04A31FEAB;
        Thu, 26 Aug 2021 19:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630006731;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b/lrvpf6WDhl+xAG8BzejCFv/J8xCcqn9pkfEE2Ujw4=;
        b=xjzJDH7USp0EshMuTkNtc+hyqZS/wTwWJt5NPa+Lvl7HxF4Wj7VWd74lqy2EKIblv5ugV6
        aBx93kKfw4iNLGnXshBz0YJ93TAv7/EXq28r4dEE9wUoAY9rn333tPJ6aO7jRiV/1nb2tE
        xpQs3LeUmc5gmR+YdyHQdU+2hf8cDDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630006731;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b/lrvpf6WDhl+xAG8BzejCFv/J8xCcqn9pkfEE2Ujw4=;
        b=UHSz1Mj5FTY8rLnR3DrxLqbjk67FEnR42f9MHUl4SJnpwC5MwPd4OrOiUu95y8hNudtG1n
        C3se6yg4JgyQ/4Bw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C0204A3B8E;
        Thu, 26 Aug 2021 19:38:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 50E47DA7F3; Thu, 26 Aug 2021 21:36:03 +0200 (CEST)
Date:   Thu, 26 Aug 2021 21:36:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
Subject: Re: Regression in v5.14-rc1: f2165627319f btrfs: compression: don't
 try to compress if we don't have enough pages
Message-ID: <20210826193602.GR3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <20210822055115.GD29026@hungrycats.org>
 <20210823111715.GW5047@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823111715.GW5047@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 23, 2021 at 01:17:15PM +0200, David Sterba wrote:
> On Sun, Aug 22, 2021 at 01:51:15AM -0400, Zygo Blaxell wrote:
> > Before this commit:
> > 
> > 	# head /dev/zero -c 4095 > inline
> > 	# compsize inline
> > 	Type       Perc     Disk Usage   Uncompressed Referenced  
> > 	TOTAL        0%       18B         3.9K         3.9K       
> > 	zstd         0%       18B         3.9K         3.9K       
> > 
> > After this commit:
> > 
> > 	# head /dev/zero -c 4095 > inline                                                                        
> > 	# compsize inline                                                                                        
> > 	Processed 1 file, 1 regular extents (1 refs), 0 inline.                                                                                      
> > 	Type       Perc     Disk Usage   Uncompressed Referenced                                                                                     
> > 	TOTAL      100%      4.0K         4.0K         4.0K                                                                                          
> > 	none       100%      4.0K         4.0K         4.0K                                                                                          
> > 
> > This change makes the metadata sizes of trees of small files (e.g. source
> > checkouts) blow up.
> > 
> > It looks like we need to look at the offset of the extent, as well as
> > its length.
> 
> Thanks for the report, my bad, I'll look into it.

The patch has been reverted in Linus' tree so it'll be in 5.14 final and
will be in the upcoming stable updates according to their release
schedule.
