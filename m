Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035791B8ECE
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Apr 2020 12:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgDZKZw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Apr 2020 06:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726116AbgDZKZw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Apr 2020 06:25:52 -0400
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621D0C061A0C
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Apr 2020 03:25:52 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1jSeTr-0003gf-R8; Sun, 26 Apr 2020 11:25:47 +0100
Date:   Sun, 26 Apr 2020 11:25:47 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Marc Lehmann <schmorp@schmorp.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: questoin about Data=single on multi-device fs
Message-ID: <20200426102547.GM32577@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Marc Lehmann <schmorp@schmorp.de>, linux-btrfs@vger.kernel.org
References: <20200426100405.GA5270@schmorp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426100405.GA5270@schmorp.de>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 26, 2020 at 12:04:05PM +0200, Marc Lehmann wrote:
> Hi!
> 
> I have a quesion about a possible behaviour change. I have a multi-device
> btrfs filesystem with metadatas profile raid1 and data profile single.
> 
> With my current kernel (5.4.28), it seems btrfs is balancing writes to the
> devices, which is nice for performance (it's kind of a best-effort raid0),
> but not so nice for data recovery (files get sepasrated out on all kinds of
> disks, which increases data loss on device failure).
> 
> I remember (maybe wrongly!) that this behaviour was diferent with older
> kernels (4.9, possibly 4.19), in that I feel that btrfs was mostly writing ot
> a single disk until it was more or less full before switching to another
> disk, which is worse for performance, but much better for data recovery.
> 
> The reason I chose data=single was specifically to help in case of device
> loss at the cost of performance.

   Make backups. That's the only way to be sure about this sort of thing.

> So my question is: did the behaviour change (possibly I misinterpreted
> what I saw weith older kernels), and is there a way to get the behaviour
> I thought it had before, where it mostly stayed with one disk without
> balancing writes?

   As far as I'm aware, the behaviour hasn't changed.

   With single data, *chunk allocation* will go to the device with the
largest amount of unallocated space. If your data is WORM
(write-once-read-many), then you'll get a gigabyte of contiguous space
on one device, and then it'll switch to a different one.

   If you are also deleting or modifying files, then the FS may be
placing newly-written extents within any free space in existing chunk
allocation. This could be anywhere within the FS, and so could be on
any device.

   There's no way to control this behaviour (either the chunk
allocation or the extent allocation).

   Hugo.

> (I can simulate this for my case using either btrfs resize or incremental
> btrfs adds).
> 
> Thanks a lot for any insights!
> 

-- 
Hugo Mills             | Someone's been throwing dead sheep down my Fun Well
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                          Nick Gibbins
