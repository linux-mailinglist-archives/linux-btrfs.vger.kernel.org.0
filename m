Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74204B0276
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 19:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbfIKRR1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 13:17:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:51664 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729314AbfIKRR1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 13:17:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6404BAFE4;
        Wed, 11 Sep 2019 17:17:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6C09ADA7D9; Wed, 11 Sep 2019 19:17:48 +0200 (CEST)
Date:   Wed, 11 Sep 2019 19:17:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: volumes: Allow missing devices to be writeable
Message-ID: <20190911171748.GI2850@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190829071731.11521-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829071731.11521-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 29, 2019 at 03:17:31PM +0800, Qu Wenruo wrote:
> [BUG]
> There is a long existing bug that degraded mounted btrfs can allocate new
> SINGLE/DUP chunks on a RAID1 fs:
>   #!/bin/bash
> 
>   dev1=/dev/test/scratch1
>   dev2=/dev/test/scratch2
>   mnt=/mnt/btrfs
> 
>   umount $mnt &> /dev/null
>   umount $dev1 &> /dev/null
>   umount $dev2 &> /dev/null
> 
>   dmesg -C
>   mkfs.btrfs -f -m raid1 -d raid1 $dev1 $dev2
> 
>   wipefs -fa $dev2
> 
>   mount -o degraded $dev1 $mnt
>   btrfs balance start --full $mnt
>   umount $mnt
>   echo "=== chunk after degraded mount ==="
>   btrfs ins dump-tree -t chunk $dev1 | grep stripe_len.*type
> 
> The result fs will have chunks with SINGLE and DUP only:
>   === chunk after degraded mount ===
>                   length 33554432 owner 2 stripe_len 65536 type SYSTEM
>                   length 1073741824 owner 2 stripe_len 65536 type DATA
>                   length 1073741824 owner 2 stripe_len 65536 type DATA|DUP
>                   length 219676672 owner 2 stripe_len 65536 type METADATA|DUP
>                   length 33554432 owner 2 stripe_len 65536 type SYSTEM|DUP
> 
> This behavior greatly breaks the RAID1 tolerance.
> 
> Even with missing device replaced, if the device with DUP/SINGLE chunks
> on them get missing, the whole fs can't be mounted RW any more.
> And we already have reports that user even can't mount the fs as some
> essential tree blocks got written to those DUP chunks.
> 
> [CAUSE]
> The cause is pretty simple, we treat missing devices as non-writable.
> Thus when we need to allocate chunks, we can only fall back to single
> device profiles (SINGLE and DUP).
> 
> [FIX]
> Just consider the missing devices as WRITABLE, so we allocate new chunks
> on them to maintain old profiles.

I'm not sure this is the best way to fix it, it makes the meaning of
rw_devices ambiguous. A missing device is by definition not readable nor
writeable.

This should be tracked separatelly, ie. counting real devices that can
be written and devices that can be considered for allocation (with a
documented meaning that even missing devices are included).
