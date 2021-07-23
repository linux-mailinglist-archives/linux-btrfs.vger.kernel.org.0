Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06833D40B0
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jul 2021 21:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhGWSn5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jul 2021 14:43:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47850 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhGWSn4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jul 2021 14:43:56 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F38E6220BC;
        Fri, 23 Jul 2021 19:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627068269;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2T8g9e/awfX3Vu+0w8TJP8RAgy26B8aoKGtGPJTE/Xs=;
        b=uv5xRSj1xiEVBhZllXrODnwAs6hLZAMkyG+YDDtGKfHeIZD1buAQ58swuTRm69a83WoPfy
        RVUpAqD2jJoCRmdBavTCMCggCbOlrT/HulVK35I81knfBbKSITed7RNPJsqjTkdQ0L+ejv
        GNbZH5TL/duyUq7bRkQuqg+xZz81XHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627068269;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2T8g9e/awfX3Vu+0w8TJP8RAgy26B8aoKGtGPJTE/Xs=;
        b=yBh89vvMxhyxl4DeziC1RYTgElIM7Mtqxk8tMfVztOqxIoVdDJ5zbO+nXu6wO6aSw//0Em
        9nMOYki3/TfxC3Aw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E9790A3B85;
        Fri, 23 Jul 2021 19:24:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4DDA9DA8EB; Fri, 23 Jul 2021 21:21:45 +0200 (CEST)
Date:   Fri, 23 Jul 2021 21:21:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: allow degenerate raid0/raid10
Message-ID: <20210723192145.GF19710@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Roman Mamedov <rm@romanrm.net>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210722192955.18709-1-dsterba@suse.com>
 <db9e2f31-73a5-0d0d-a1da-7acde6fb118e@gmx.com>
 <20210723140843.GE19710@twin.jikos.cz>
 <20210723222730.1d23f9b4@natsu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723222730.1d23f9b4@natsu>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 23, 2021 at 10:27:30PM +0500, Roman Mamedov wrote:
> On Fri, 23 Jul 2021 16:08:43 +0200
> David Sterba <dsterba@suse.cz> wrote:
> 
> > > Can we slightly enhance the output?
> > > RAID0/1 really looks like a new profile now, even the "1" really means
> > > the number of device.
> > 
> > Do you have a concrete suggestion? This format was inspired by a
> > discussion and suggested by users so I guess this is what people expect
> > and I find it clear. It's also documented in manual page so if you think
> > it's not clear or missing some important information, please let me
> > know.
> 
> It really reads like another RAID level, easily confused with RAID10.
> 
> Or that it would flip between RAID0 and RAID1 depending on something.

I think it could be confusing when the number of stripes is also another
raid level, like /1 in this case. From the commit
https://github.com/kdave/btrfs-progs/commit/4693e8226140289dcf8f0932af05895a38152817

/dev/vdc, ID: 1
   Device size:             1.00GiB
   Device slack:              0.00B
   Data,RAID0/2:          912.62MiB
   Data,RAID0/3:          912.62MiB
   Metadata,RAID1:        102.38MiB
   System,RAID1:            8.00MiB
   Unallocated:             1.00MiB

it's IMHO clear or at least prompting to read the docs what it means.

> Maybe something like RAID0d1?

That looks similar to RAID1c3 which I'd interpret as a new profile as
well. The raid56 profiles also print the stripe count so I don't know if
eg. RAID5d4 is really an improvement.

A 4 device mix of raid56 data and metadata would look like:

# btrfs dev us .
/dev/sda10, ID: 1
   Device size:            10.00GiB
   Device slack:              0.00B
   Data,RAID5/4:            1.00GiB
   Metadata,RAID6/4:       64.00MiB
   System,RAID6/4:          8.00MiB
   Unallocated:             8.93GiB

/dev/sda11, ID: 2
   Device size:            10.00GiB
   Device slack:              0.00B
   Data,RAID5/4:            1.00GiB
   Metadata,RAID6/4:       64.00MiB
   System,RAID6/4:          8.00MiB
   Unallocated:             8.93GiB

/dev/sda12, ID: 3
   Device size:            10.00GiB
   Device slack:              0.00B
   Data,RAID5/4:            1.00GiB
   Metadata,RAID6/4:       64.00MiB
   System,RAID6/4:          8.00MiB
   Unallocated:             8.93GiB

/dev/sda13, ID: 4
   Device size:            10.00GiB
   Device slack:              0.00B
   Data,RAID5/4:            1.00GiB
   Metadata,RAID6/4:       64.00MiB
   System,RAID6/4:          8.00MiB
   Unallocated:             8.93GiB

Maybe it's still too new so nobody is used to it and we've always had
problems with the raid naming scheme anyway.
