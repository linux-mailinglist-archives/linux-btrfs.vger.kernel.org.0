Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8AB411E76B
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2019 17:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfLMQCg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 11:02:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:60782 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727974AbfLMQCg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 11:02:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 705AEAD31;
        Fri, 13 Dec 2019 16:02:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A4F14DA82A; Fri, 13 Dec 2019 17:02:33 +0100 (CET)
Date:   Fri, 13 Dec 2019 17:02:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Martin Raiber <martin@urbackup.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: df shows no available space in 5.4.1
Message-ID: <20191213160231.GZ3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Martin Raiber <martin@urbackup.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <0102016edd1b0184-848d9b6d-6b80-4ce3-8428-e472a224e554-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0102016edd1b0184-848d9b6d-6b80-4ce3-8428-e472a224e554-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 06, 2019 at 09:26:05PM +0000, Martin Raiber wrote:
> # df -h
> Filesystem                                            Size  Used Avail
> Use% Mounted on
> ...
> /dev/loop0                                            7.4T  623G     0
> 100% /media/backup
> ...
> 
> statfs("/media/backup", {f_type=BTRFS_SUPER_MAGIC, f_bsize=4096,
> f_blocks=1985810876, f_bfree=1822074245, f_bavail=0, f_files=0,
> f_ffree=0, f_fsid={val=[3667078581, 2813298474]}, f_namelen=255,
> f_frsize=4096, f_flags=ST_VALID|ST_NOATIME}) = 0
> 
> # btrfs fi usage /media/backup
> Overall:
>     Device size:                   7.40TiB
>     Device allocated:            671.02GiB
>     Device unallocated:            6.74TiB
>     Device missing:                  0.00B
>     Used:                        622.49GiB
>     Free (estimated):              6.79TiB      (min: 6.79TiB)
>     Data ratio:                       1.00
>     Metadata ratio:                   1.00
>     Global reserve:              512.00MiB      (used: 0.00B)
> 
> Data,single: Size:666.01GiB, Used:617.95GiB
>    /dev/loop0    666.01GiB
> 
> Metadata,single: Size:5.01GiB, Used:4.54GiB
>    /dev/loop0      5.01GiB

Here's the cause for 0 for available data: there's a special case in
statfs that checks for remaining metadata space and if thre's less than
some threshold then the value becomes 0.

The global block reserve needs to be accounted there to so

4.54G + 512M ~ 5.01G

> System,single: Size:4.00MiB, Used:96.00KiB
>    /dev/loop0      4.00MiB
> 
> Unallocated:
>    /dev/loop0      6.74TiB

Enough unallocated data for more metadata chunks, that are usually
allocated in advance so the above should not happen.

> # btrfs fi df /media/backup
> Data, single: total=666.01GiB, used=617.95GiB
> System, single: total=4.00MiB, used=96.00KiB
> Metadata, single: total=5.01GiB, used=4.54GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> # mount
> 
> ...
> /dev/loop0 on /media/backup type btrfs
> (rw,noatime,nossd,discard,space_cache=v2,enospc_debug,skip_balance,commit=86400,subvolid=5,subvol=/)

commit=86400 is kind extreme but this should affect only unwritten data
possibly buffered in memory before write and sync/commit can be started
for other reasons too.

So it looks to me that metadata chunks don't get allocated as before. A
workaround could be the mount option metadata_ratio, but finding the
root cause is desired as this looks like a regression.
