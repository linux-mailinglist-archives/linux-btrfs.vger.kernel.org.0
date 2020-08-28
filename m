Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A0D2551F4
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Aug 2020 02:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgH1Aak (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Aug 2020 20:30:40 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35258 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH1Aaj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Aug 2020 20:30:39 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id C1E2F7D58FD; Thu, 27 Aug 2020 20:30:37 -0400 (EDT)
Date:   Thu, 27 Aug 2020 20:30:37 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     kreijack@inwind.it
Cc:     Eric Wong <e@80x24.org>, linux-btrfs@vger.kernel.org
Subject: Re: adding new devices to degraded raid1
Message-ID: <20200828003037.GU5890@hungrycats.org>
References: <20200827124147.GA16923@dcvr>
 <862ab235-298a-12eb-647b-04ec01d95293@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <862ab235-298a-12eb-647b-04ec01d95293@libero.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 27, 2020 at 07:14:18PM +0200, Goffredo Baroncelli wrote:
> On 8/27/20 2:41 PM, Eric Wong wrote:
> > I don't need to do it right away, but is it possible to add new
> > devices to a degraded raid1?
> > 
> > One thing I might do in the future is replace a broken big drive
> > with two small drives.  It may even be used to migrate to SSDs.
> > 
> > Since btrfs-replace only seems to do 1:1 replacements, and I
> > needed to physically remove an existing broken device to make
> > room for the replacements, could I do something like:
> > 
> > 	mount -o degraded /mnt/foo
> > 	btrfs device add small1 small2 /mnt/foo
> > 	btrfs device remove broken /mnt/foo

Note that add/remove is orders of magnitude slower than replace.
Replace might take hours or even a day or two on a huge spinning drive.
Add/remove might take _months_, though if you have 8-year-old disks
then it's probably a few days, weeks at most.

Add/remove does work for raid1* (i.e. raid1, raid10, raid1c3, raid1c4).
At the moment only 'replace' works reliably for raid5/raid6.

> > ?
> > 
> 
> Instead of
> 
>  	btrfs device remove broken /mnt/foo
> 
> You should do
> 
> 	btrfs device remove missing /mnt/foo
> 
> ("missing" has to be write as is, it is a special term, see man page)
> 
> and
> 
> 	btrfs balance start /mnt/foo

If the replacement disks are larger than half the size of the failed disk
then device remove may do sufficient data relocation and you won't need
balance.  Once all the disks have equal amounts of unallocated space in
'btrfs fi usage' you can cancel any balances that are running.

On the other hand, if the replacement disks are close to half the size
of the failed disk, then some careful balance filtering is required in
order to utilize all the available space.  This filtering is more than
what the stock tool offers.  You have to make sure that there are no block
groups with a mirror copy on both of the small disks, as any such block
group removes 1GB of available mirror space for data on the largest disk.

> To redistribute the data to the disks.
> 
> Please before trying it, wait for other suggestions or confirmation from more expert dveloper about that
> 
> BR
> G.Baroncelli
> 
> > Anyways, so far raid1 has been working great for me, but I have
> > some devices nearing 70K Power_On_Hours according to SMART
> > 
> > Thanks.
> > 
> 
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
