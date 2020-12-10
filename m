Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16C42D6780
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 20:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404422AbgLJTu6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 14:50:58 -0500
Received: from mx.ewheeler.net ([173.205.220.69]:49674 "EHLO mail.ewheeler.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404426AbgLJTuv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 14:50:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.ewheeler.net (Postfix) with ESMTP id 937A940;
        Thu, 10 Dec 2020 19:50:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mail.ewheeler.net ([127.0.0.1])
        by localhost (mail.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 1pJyHC1j_7XW; Thu, 10 Dec 2020 19:50:06 +0000 (UTC)
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.ewheeler.net (Postfix) with ESMTPSA id 9BD9C3E;
        Thu, 10 Dec 2020 19:50:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ewheeler.net 9BD9C3E
Date:   Thu, 10 Dec 2020 19:50:06 +0000 (UTC)
From:   Eric Wheeler <btrfs@lists.ewheeler.net>
X-X-Sender: lists@pop.dreamhost.com
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Global reserve ran out of space at 512MB, fails to rebalance
In-Reply-To: <20201210031251.GJ31381@hungrycats.org>
Message-ID: <alpine.LRH.2.21.2012101935440.15698@pop.dreamhost.com>
References: <alpine.LRH.2.21.2012100149160.15698@pop.dreamhost.com> <20201210031251.GJ31381@hungrycats.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 9 Dec 2020, Zygo Blaxell wrote:
> On Thu, Dec 10, 2020 at 01:52:19AM +0000, Eric Wheeler wrote:
> > Hello all,
> > 
> > We have a 30TB volume with lots of snapshots that is low on space and we 
> > are trying to rebalance.  Even if we don't rebalance, the space cleaner 
> > still fills up the Global reserve:
> > 
> > >>> Global reserve:              512.00MiB	(used: 512.00MiB) <<<<<<<
> 
> It would be nice to have the rest of the btrfs fi usage output.  We are
> having to guess how your drives are populated with data and metadata
> and what profiles are in use.

Here is the whole output:

]# df -h /mnt/btrbackup ; echo; btrfs fi df /mnt/btrbackup|column -t; echo; btrfs fi usage /mnt/btrbackup

Filesystem                  Size  Used Avail Use% Mounted on
/dev/mapper/btrbackup-luks   30T   30T  541G  99% /mnt/btrbackup

Data,           single:  total=29.80TiB,  used=29.28TiB
System,         DUP:     total=8.00MiB,   used=3.42MiB
Metadata,	DUP:     total=99.00GiB,  used=87.03GiB
GlobalReserve,  single:  total=4.00GiB,   used=1.73MiB

Overall:
    Device size:                  30.00TiB
    Device allocated:             30.00TiB
    Device unallocated:            1.00GiB
    Device missing:                  0.00B
    Used:                         29.45TiB
    Free (estimated):            540.74GiB	(min: 540.24GiB)
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:                4.00GiB	(used: 1.73MiB) <<<< with 4GB hack

Data,single: Size:29.80TiB, Used:29.28TiB (98.23%)
   /dev/mapper/btrbackup-luks     29.80TiB

Metadata,DUP: Size:99.00GiB, Used:87.03GiB (87.91%)
   /dev/mapper/btrbackup-luks    198.00GiB

System,DUP: Size:8.00MiB, Used:3.42MiB (42.77%)
   /dev/mapper/btrbackup-luks     16.00MiB

Unallocated:
   /dev/mapper/btrbackup-luks	   1.00GiB
 
> You probably need to be running some data balances (btrfs balance start
> -dlimit=9 about once a day) to ensure there is always at least 1GB of
> unallocated space on every drive.

Thanks for the daily rebalance tip.  Is there a reason you chose 
-dlimit=9?  I know it means 9 chunks, but why 9?  Also, how big is a 
"chunk" ? 

In this case we have 1GB unallocated.

> Never balance metadata, especially not from a scheduled job.  Metadata
> balances lead directly to this situation.

So when /would/ you balance metadata?

> > This was on a Linux 5.6 kernel.  I'm trying a Linux 5.9.13 kernel with a 
> > hacked in SZ_4G in place of the SZ_512MB and will report back when I learn 
> > more.
>
> I've had similar problems with snapshot deletes hitting ENOSPC with
> small amounts of free metadata space.  In this case, the upgrade from
> 5.6 to 5.9 will include a fix for that (it's in 5.8, also 5.4 and earlier
> LTS kernels).

Ok, now on 5.9.13
 
> Increasing the global reserve may seem to help, but so will just rebooting
> over and over, so a positive result from an experimental kernel does not
> necessarily mean anything.

At least this reduces the number of times I need to reboot ;)

Question: 

What do people think of making this a module option or ioctl for those who 
need to hack it into place to minimize reboots?

-Eric

--
Eric Wheeler
