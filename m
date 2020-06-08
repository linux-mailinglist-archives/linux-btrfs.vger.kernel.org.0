Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1031F12FD
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 08:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgFHGmn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 02:42:43 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:48217 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728785AbgFHGmn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Jun 2020 02:42:43 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49gNwc4nBmz2d;
        Mon,  8 Jun 2020 08:42:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1591598560; bh=m9HIZOjo8QYglPrdsDxqqqXFz2PY7a3gSXcTyiRDNTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rL3CEXMFwyKOfP41QHhL3+EmzrNrMhmlLFzcIOD4m+bQw2GnYEZN+ASWNwlL9eN7P
         zSzVe+uJ/IUzoJzl/XB+thmMEtoClZf1TGbKxqLO8kaYA8rUtB4WCr5Li8qrmS4VaJ
         dkg0zdQvR7M3nDiZIkzAjvnSt3YE9INf1rhhGekJcSjlaHcPVXqoNxcA0nD1FAhDuB
         6CyDBYQtSvwDvZAw68pp0jjhVU3IKsmSDV6ce5/eFcP4qKOo+5QBFOG5UEPtmQoTXk
         eEpEpwEabbkq7uLntwl+fyY7dot9E1H0uA948MGrE89sAk/A5sW88mduVzEQo3F1Cr
         rCwvhvA5yw23g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 8 Jun 2020 08:42:38 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: balance + ENOFS -> readonly filesystem
Message-ID: <20200608064238.GA32305@qmqm.qmqm.pl>
References: <20200607051217.GE12913@qmqm.qmqm.pl>
 <88e8b58e-9a4c-1f3e-4b08-8a56de191dd4@gmx.com>
 <20200607083452.GA9208@qmqm.qmqm.pl>
 <41bfa30e-cc9f-5f26-3aab-c141a9e3aa91@libero.it>
 <20200607105018.GA2249@qmqm.qmqm.pl>
 <bba0847a-dcd3-6fe0-0c59-8d79f4b6ea2f@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bba0847a-dcd3-6fe0-0c59-8d79f4b6ea2f@inwind.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 07, 2020 at 05:29:48PM +0200, Goffredo Baroncelli wrote:
> Hi Micha³
> 
> On 6/7/20 12:50 PM, Micha³ Miros³aw wrote:
> > On Sun, Jun 07, 2020 at 12:09:30PM +0200, Goffredo Baroncelli wrote:
> [...]
> > > > # btrfs filesystem usage .
> > > > Overall:
> > > >       Device size:                   1.82TiB
> > > >       Device allocated:            932.51GiB
> > > >       Device unallocated:          930.49GiB
> > > >       Device missing:                  0.00B
> > > >       Used:                        927.28GiB
> > > >       Free (estimated):            933.86GiB      (min: 468.62GiB)
> > > >       Data ratio:                       1.00
> > > >       Metadata ratio:                   2.00
> > > >       Global reserve:              512.00MiB      (used: 0.00B)
> > > > 
> > > > Data,single: Size:928.47GiB, Used:925.10GiB
> > > >      /dev/mapper/btrfs1         927.47GiB
> > > >      /dev/mapper/btrfs2           1.00GiB
> > > > 
> > > > Metadata,RAID1: Size:12.00MiB, Used:1.64MiB
> > > >      /dev/mapper/btrfs1          12.00MiB
> > > >      /dev/mapper/btrfs2          12.00MiB
> > > > 
> > > > Metadata,DUP: Size:2.00GiB, Used:1.09GiB
> > > >      /dev/mapper/btrfs1           4.00GiB
> > > > 
> > > > System,DUP: Size:8.00MiB, Used:144.00KiB
> > > >      /dev/mapper/btrfs1          16.00MiB
> > > > 
> > > > Unallocated:
> > > >      /dev/mapper/btrfs1           1.02MiB
> > > >      /dev/mapper/btrfs2         930.49GiB
> > > 
> > > The old disk is full. And the fact that Metadata has a raid1 profile prevent further metadata allocation/reshape.
> > > The filesystem goes RO after the mount ? If no a simple balance of metadata should be enough; pay attention to select
> > > "single" profile for metadata for this first attempt.
> > > 
> > > # btrfs balance start -mconvert=single <mnt-point>
> > > 
> > > This should free about 4G from the old disk. Then, balance the data
> > > 
> > > # btrfs balance start -d <mnt-point>
> > > 
> > > Then rebalance the metadata as raid1, because now you should have enough space.
> > > 
> > > # btrfs balance start -mconvert=raid1 <mnt-point>
> > 
> > Thanks! It worked all right! (data rebalance wasn't needed.)
> 
> Which metadata profile will you set ?
> If you set a RAID1 metadata profile, in the long term you will face the same problem. And even if you use a different metadata profile than RAID1, I suggest to switch to RAID1 as metadata profile.
> 
> From the "btrfs fi us" output, balance the data is not an high urgency, however I strongly suggest to do soon.

I used raid1 for metadata and did rebalance data later. This all worked ok.

Thanks for your support!

Best Regards,
Micha³ Miros³aw
