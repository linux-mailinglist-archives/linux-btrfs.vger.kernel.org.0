Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D215233DAF
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 05:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbgGaDWM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 23:22:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47420 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731175AbgGaDWM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 23:22:12 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5BC051F5AE;
        Fri, 31 Jul 2020 03:22:12 +0000 (UTC)
Date:   Fri, 31 Jul 2020 03:22:12 +0000
From:   Eric Wong <e@80x24.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: raid1 with several old drives and a big new one
Message-ID: <20200731032212.GA21797@dcvr>
References: <20200731001652.GA28434@dcvr>
 <CAJCQCtS6fHYGBiHpqAJPu+-EoSzEKZ5YEaj4QjNxqPvO+JTACw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJCQCtS6fHYGBiHpqAJPu+-EoSzEKZ5YEaj4QjNxqPvO+JTACw@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Chris Murphy <lists@colorremedies.com> wrote:
> On Thu, Jul 30, 2020 at 6:16 PM Eric Wong <e@80x24.org> wrote:
> >
> > Say I have three ancient 2TB HDDs and one new 6TB HDD, is there
> > a way I can ensure one raid1 copy of the data stays on the new
> > 6TB HDD?
> 
> Yes. Use mdadm --level=linear --raid-devices=2 to concatenate the two
> 2TB drives. Or use LVM (linear by default). Leave the 6TB out of this
> regime. And now you have two block devices (one is the concat virtual
> device) to do a raid1 with btrfs, and the 6TB will always get one of
> the raid1 chunks.
> 
> There isn't a way to do this with btrfs alone.

Thanks for the response(s), I was hoping to simplify my stack
with btrfs alone.

> When one of the 2TB fails, there's some likelihood that it'll behave
> like a partially failing device. Some reads and writes will succeed,
> others won't. So you'll need to be prepared strategy wise what to do.
> Ideal scenario is a new 4+TB drive, and use 'btrfs replace' to replace
> the md concat device. Due to the large number of errors possible with
> the 'btrfs replace' you might want to use -r option.

If I went ahead with btrfs alone and am prepared to lose some
(not "all") files; could part of the FS remain usable (and the
rest restorable from slow backups) w/o involving LVM?

I could make metadata (and maybe system chunks?) raid1c3 or even
raid1c4 since they seem small and important enough with ancient
HW in play.

I mainly wanted raid1 because restoring from backups is slow;
and btrfs would let me grow a single FS without much planning
or having to find identical or even similar drives.

> And on second thought...
> 
> You might do some rudimentary read/write benchmarks on all three

<snip>
Not performance critical at all, all that is on SSD :)
