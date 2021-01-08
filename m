Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2252EF5EB
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jan 2021 17:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbhAHQnY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jan 2021 11:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbhAHQnX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jan 2021 11:43:23 -0500
X-Greylist: delayed 2045 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Jan 2021 08:42:43 PST
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BA6C061381
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jan 2021 08:42:43 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1kxuJe-0005ek-1O; Fri, 08 Jan 2021 16:08:42 +0000
Date:   Fri, 8 Jan 2021 16:08:41 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Claudius Ellsel <claudius.ellsel@live.de>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Improve balance command
Message-ID: <20210108160841.GA3686@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Claudius Ellsel <claudius.ellsel@live.de>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <AM0P191MB056105988C894B2A076AA0B3E2AE0@AM0P191MB0561.EURP191.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0P191MB056105988C894B2A076AA0B3E2AE0@AM0P191MB0561.EURP191.PROD.OUTLOOK.COM>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 08, 2021 at 02:30:52PM +0000, Claudius Ellsel wrote:
> Hello,
> 
> currently I am slowly adding drives to my filesystem (RAID1). This process is incremental, since I am copying files off them to the btrfs filesystem and then adding the free drive to it afterwards. Since RAID1 needs double the space, I added an empty 12TB drive and also had a head start with an empty 1TB and 4TB drive. With that I can go ahead and copy a 4TB drive, then add it to the filesystem until I have three 4TB and one 12TB drives (the 1TB drive will get replaced in the process).
> While I was doing this (still in the process), I have used the `balance` command after adding a drive as described in the Wiki. Unforunately I now learned that this will at least by default rewrite all data and not only the relevant chunks that need to be rewritten to reach a balanced drive. In order that leads to pretty long process times and also I don't really like that the drives are stressed unnecessarily.
> 
> So now I have the question whether there are better methods to do rebalancing (like some filters?) or whether it is even needed every time. I also created a bug report to suggest improvement of the rebalancing option if you are interested: https://bugzilla.kernel.org/show_bug.cgi?id=211091.
> 
> On a slightly different topic: I was wondering what would happen if I just copied stuff over without adding new drives. The 1TB and 4TB drives would then be full while the 12TB one still had space.

   The algorithm puts new data chunks on the devices with the most
space free. In this case, each data chunk needs two devices.

   With a 12TB, 4TB and 1TB, you'll be able to get 5TB of data on a
RAID-1 array. One copy goes on the 12TB, and the other copy will go on
one of the other two devices. (In this process, the first 3 TB of data
will go exclusively on the two larger ones, and only then will the 1TB
drive be written to as well).

   You can keep adding devices to this without balancing, and it will
all work OK, as long as you have at least two devices with free space
on them. If you have only one device with free space on it (or near
that), that's the point that you need to balance. You can cancel the
balance when there's an approximately even distribution of free space
on the devices.

   (When I say "free space" in the above, I'm talking about
unallocated space, as reported by btrfs fi usage).

> I am asking because when running `sudo btrfs filesystem usage /mount/point` I am getting displayed more free space than would be possible with RAID1:

> Overall:
>     Device size:		  19.10TiB
>     Device allocated:		   8.51TiB
>     Device unallocated:		  10.59TiB
>     Device missing:		     0.00B
>     Used:			   8.40TiB
>     Free (estimated):		   5.35TiB	(min: 5.35TiB)
>     Data ratio:			      2.00
>     Metadata ratio:		      2.00
>     Global reserve:		 512.00MiB	(used: 0.00B)
> 
> Data,RAID1: Size:4.25TiB, Used:4.20TiB (98.74%)
>    /dev/sdc	 565.00GiB
>    /dev/sdd	   3.28TiB
>    /dev/sdb	   4.25TiB
>    /dev/sde	 430.00GiB
> 
> Metadata,RAID1: Size:5.00GiB, Used:4.78GiB (95.61%)
>    /dev/sdc	   1.00GiB
>    /dev/sdd	   4.00GiB
>    /dev/sdb	   5.00GiB
> 
> System,RAID1: Size:32.00MiB, Used:640.00KiB (1.95%)
>    /dev/sdd	  32.00MiB
>    /dev/sdb	  32.00MiB
> 
> Unallocated:
>    /dev/sdc	 365.51GiB
>    /dev/sdd	 364.99GiB
>    /dev/sdb	   6.66TiB
>    /dev/sde	   3.22TiB
> 
> It looks a bit like the free size was simply calculated by total disk space - used space and then divided by two since it is RAID1. But that would in reality mean that some chunks are just twice on the 12TB drive and not spread. Is this the way it will work in practice or is the estimated value just wrong?

   A reasonably accurate free space calculation is either complicated
or expensive, and I don't think any of the official tools gets it
right in all cases. You can get a better idea of the usable space on
any given configuration by putting the unallocated space into the tool
at

https://carfax.org.uk/btrfs-usage

or I think there's an accurate implementation as a command-line tool
in Hans's python-btrfs library.

   Hugo.

-- 
Hugo Mills             | You are not stuck in traffic: you are traffic
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                    German ad campaign
