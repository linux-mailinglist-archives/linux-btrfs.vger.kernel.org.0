Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38982A46FD
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Sep 2019 05:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfIAD3A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Aug 2019 23:29:00 -0400
Received: from fenrir.routify.me ([155.94.238.126]:43254 "EHLO
        fenrir.routify.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfIAD27 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Aug 2019 23:28:59 -0400
Received: from coach (unknown [50.236.75.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by fenrir.routify.me (Postfix) with ESMTPSA id 0C0A84000F;
        Sun,  1 Sep 2019 03:28:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 fenrir.routify.me 0C0A84000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seangreenslade.com;
        s=fenrir-outgoing; t=1567308539;
        bh=J6l+dGngtHIeQB2zW7qwZrzObo1pQdT+9ByONXM/rp0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=N4m5iwQabVRP7qstjiEuO1RICg6A0tgXvlg2WMwbxg7ZtXvai3MH2Wied/+gqRWyL
         h7v7WSE70+L8s7ZXlWHlcxBYXZlIs7bMgXWQ7FjkImZ5f27TvsTRhnZScua+8IMtXk
         TEst+Th2I+yR+W9MtozCie9sLyyheGCCao+hSBM4=
Date:   Sat, 31 Aug 2019 20:28:55 -0700
From:   Sean Greenslade <sean@seangreenslade.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Spare Volume Features
Message-ID: <20190901032855.GA5604@coach>
References: <0b7bfde0-0711-cee3-1ed8-a37b1a62bf5e@megavolts.ch>
 <CD4A10E4-5342-4F72-862A-3A2C3877EC36@seangreenslade.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CD4A10E4-5342-4F72-862A-3A2C3877EC36@seangreenslade.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 28, 2019 at 07:21:14PM -0700, Sean Greenslade wrote:
> On August 28, 2019 5:51:02 PM PDT, Marc Oggier <marc.oggier@megavolts.ch> wrote:
> >Hi All,
> >
> >I am currently buidling a small data server for an experiment.
> >
> >I was wondering if the features of the spare volume introduced a couple
> >
> >of years ago (ttps://patchwork.kernel.org/patch/8687721/) would be 
> >release soon. I think this would be awesome to have a drive installed, 
> >that can be used as a spare if one drive of an array died to avoid
> >downtime.
> >
> >Does anyone have news about it, and when it will be officially in the 
> >kernel/btrfs-progs ?
> >
> >Marc
> >
> >P.S. It took me a long time to switch to btrfs. I did it less than a 
> >year ago, and I love it.  Keep the great job going, y'all
> 
> I've been thinking about this issue myself, and I have an (untested)
> idea for how to accomplish something similar. My file server has three
> disks in a btrfs raid1. I added a fourth disk to the array as just a
> normal, participating disk. I keep an eye on the usage to make sure
> that I never exceed 3 disk's worth of usage. That way, if one disk
> dies, there are still enough disks to mount RW (though I may still
> need to do an explicit degraded mount, not sure). In that scenario, I
> can just trigger an online full balance to rebuild the missing raid
> copies on the remaining disks. In theory, minimal to no downtime.
> 
> I'm curious if anyone can see any problems with this idea. I've never
> tested it, and my offsite backups are thorough enough to survive
> downtime anyway.
> 
> --Sean

I decided to do a bit of experimentation to test this theory. The
primary goal was to see if a filesystem could suffer a failed disk and
have that disk removed and rebalanced among the remaining disks without
the filesystem losing data or going read-only. Tested on kernel
5.2.5-arch1-1-ARCH, progs: v5.2.1.

I was actually quite impressed. When I ripped one of the block devices
out from under btrfs, the kernel started spewing tons of BTRFS errors,
but seemed to keep on trucking. I didn't leave it in this state for too
long, but I was reading, writing, and syncing the fs without issue.
After performing a btrfs device delete <MISSING_DEVID>, the filesystem
rebalanced and stopped reporting errors. Looks like this may be a viable
strategy for high-availability filesystems assuming you have adequate
monitoring in place to catch the disk failures quickly. I personally
wouldn't want to fully automate the disk deletion, but it's certainly
possible.

--Sean

