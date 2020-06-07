Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946211F0AD3
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jun 2020 12:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgFGKuX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jun 2020 06:50:23 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:64087 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgFGKuW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 7 Jun 2020 06:50:22 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49ftSr0T0Kz2d;
        Sun,  7 Jun 2020 12:50:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1591527020; bh=WFaX9TmZSim7pEm7sVRigGmANoxJa9DqDz4fQJQemoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KiH6gLemJFb35hV46QolPBnpYOfbTSU0hjLmO26RvKjO/9OlzQZG3vI53BRXPse5a
         oy8tGNqdyEDUNd5aApHFyupJYW8+d6qMsBL4DIGnMomz9q9hqAnGgGgPTTmAunbDuB
         q5oET+CipawuzeOpN8K1od5yOY5gSGag0rY7dcfuX6vxzpjyoyulR8T2AUZMH9YvZm
         nd+DlbiBRbYknlZB6M222IA6JuyAsHv5ibUIIq6aTKOpTjMYz3tBkO7rV07vu/hu73
         IDU72SC706wQ/W4gl527aXyXflppkrkkmrQkh1W75QdErg57Aj71f4lkqYd7IwXgWt
         RjMywx2voYG5g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 7 Jun 2020 12:50:18 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     kreijack@inwind.it
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: balance + ENOFS -> readonly filesystem
Message-ID: <20200607105018.GA2249@qmqm.qmqm.pl>
References: <20200607051217.GE12913@qmqm.qmqm.pl>
 <88e8b58e-9a4c-1f3e-4b08-8a56de191dd4@gmx.com>
 <20200607083452.GA9208@qmqm.qmqm.pl>
 <41bfa30e-cc9f-5f26-3aab-c141a9e3aa91@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41bfa30e-cc9f-5f26-3aab-c141a9e3aa91@libero.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 07, 2020 at 12:09:30PM +0200, Goffredo Baroncelli wrote:
> On 6/7/20 10:34 AM, Michał Mirosław wrote:
> > On Sun, Jun 07, 2020 at 03:35:36PM +0800, Qu Wenruo wrote:
> > > On 2020/6/7 下午1:12, Michał Mirosław wrote:
> > > > Dear btrfs developers,
> > > > 
> > > > I just added a new disk to already almost full filesystem and tried to
> > > > enable raid1 for metadata (transcript below).
> > > May I ask for your per-disk usage?
> > > 
> > > There is a known bug (but rare to hit) that completely unbalance disk
> > > usage can lead to unexpected ENOSPC (-28) error at certain critical code
> > > and cause the transaction abort you're hitting.
> > > 
> > > If you have added a new disk to an almost full one, then I guess that
> > > would be the case...
> > 
> > # btrfs filesystem usage .
> > Overall:
> >      Device size:                   1.82TiB
> >      Device allocated:            932.51GiB
> >      Device unallocated:          930.49GiB
> >      Device missing:                  0.00B
> >      Used:                        927.28GiB
> >      Free (estimated):            933.86GiB      (min: 468.62GiB)
> >      Data ratio:                       1.00
> >      Metadata ratio:                   2.00
> >      Global reserve:              512.00MiB      (used: 0.00B)
> > 
> > Data,single: Size:928.47GiB, Used:925.10GiB
> >     /dev/mapper/btrfs1         927.47GiB
> >     /dev/mapper/btrfs2           1.00GiB
> > 
> > Metadata,RAID1: Size:12.00MiB, Used:1.64MiB
> >     /dev/mapper/btrfs1          12.00MiB
> >     /dev/mapper/btrfs2          12.00MiB
> > 
> > Metadata,DUP: Size:2.00GiB, Used:1.09GiB
> >     /dev/mapper/btrfs1           4.00GiB
> > 
> > System,DUP: Size:8.00MiB, Used:144.00KiB
> >     /dev/mapper/btrfs1          16.00MiB
> > 
> > Unallocated:
> >     /dev/mapper/btrfs1           1.02MiB
> >     /dev/mapper/btrfs2         930.49GiB
> 
> The old disk is full. And the fact that Metadata has a raid1 profile prevent further metadata allocation/reshape.
> The filesystem goes RO after the mount ? If no a simple balance of metadata should be enough; pay attention to select
> "single" profile for metadata for this first attempt.
> 
> # btrfs balance start -mconvert=single <mnt-point>
> 
> This should free about 4G from the old disk. Then, balance the data
> 
> # btrfs balance start -d <mnt-point>
> 
> Then rebalance the metadata as raid1, because now you should have enough space.
> 
> # btrfs balance start -mconvert=raid1 <mnt-point>

Thanks! It worked all right! (data rebalance wasn't needed.)

Best Regards,
Michał Mirosław
