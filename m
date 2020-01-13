Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 807CB139D2B
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 00:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgAMXVd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 18:21:33 -0500
Received: from trent.utfs.org ([94.185.90.103]:38006 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbgAMXVd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 18:21:33 -0500
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id D58675F86D;
        Tue, 14 Jan 2020 00:21:30 +0100 (CET)
Date:   Mon, 13 Jan 2020 15:21:30 -0800 (PST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Chris Murphy <lists@colorremedies.com>
cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: file system full on a single disk?
In-Reply-To: <CAJCQCtS9rx0M30zLxkND5MYTwLEPxYG=8BuRB3b1Bi8Vr3KTqg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.99999.375.2001131514010.21037@trent.utfs.org>
References: <alpine.DEB.2.21.99999.375.2001131400390.21037@trent.utfs.org> <CAJCQCtS9rx0M30zLxkND5MYTwLEPxYG=8BuRB3b1Bi8Vr3KTqg@mail.gmail.com>
User-Agent: Alpine 2.21.99999 (DEB 375 2019-10-29)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 13 Jan 2020, Chris Murphy wrote:
> It's a reporting bug. File system is fine.

Well, I received some ENOSPC notifications from various apps, so it was a 
real problem.

> > I'm running a --full-balance now and it's progressing, slowly. I've seen
> > tricks on the interwebs to temporarily add a ramdisk, run another balance,
> > remove the ramdisk again - but that seems hackish.
> 
> I'd stop the balance. Balancing metadata in particular appears to make
> the problem more common. And you're right, it's hackish, it's not a
> great work around for anything these days, and if it is, good chance
> it's a bug.

For now, the balancing "helped", but the fs still shows only 391 GB 
allocated from the 924 GB device:

=======================================================================
# btrfs filesystem show /
Label: 'root'  uuid: 75a6d93a-5a5c-48e0-a237-007b2e812477
        Total devices 1 FS bytes used 388.00GiB
        devid    1 size 824.40GiB used 391.03GiB path /dev/mapper/luks-root

# df -h /
Filesystem             Size  Used Avail Use% Mounted on
/dev/mapper/luks-root  825G  390G  433G  48% /
=======================================================================

> In theory it should be enough to unmount then remount the file system;
> of course for sysroot that'd be a reboot.

OK, I'll try a reboot next time.

> There may be certain workloads that encourage it, that could be worked 
> around temporarily using mount option metadata_ratio=1.

I'll do that after it happens again, to see if this was a one-off or 
happens regularily. The file system is rather new (created Dec 14) and 
apart from spinning up some libvirt VMs (but no snapshots involved) the 
workload is a mix of web browsing and compiling things, no nothing too 
fancy.

Thanks for your input, and thanks for taking the time to respond.

Christian.
-- 
BOFH excuse #69:

knot in cables caused data stream to become twisted and kinked
