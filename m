Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09926100CFE
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 21:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKRUSe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 15:18:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:41348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726475AbfKRUSe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 15:18:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3FCF5ABF4;
        Mon, 18 Nov 2019 20:18:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DF953DAB3A; Mon, 18 Nov 2019 21:18:34 +0100 (CET)
Date:   Mon, 18 Nov 2019 21:18:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: More intelligent degraded chunk allocator
Message-ID: <20191118201834.GN3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191107062710.67964-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107062710.67964-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 07, 2019 at 02:27:07PM +0800, Qu Wenruo wrote:
> This patchset will make btrfs degraded mount more intelligent and
> provide more consistent profile keeping function.
> 
> One of the most problematic aspect of degraded mount is, btrfs may
> create unwanted profiles.
> 
>  # mkfs.btrfs -f /dev/test/scratch[12] -m raid1 -d raid1
>  # wipefs -fa /dev/test/scratch2
>  # mount -o degraded /dev/test/scratch1 /mnt/btrfs
>  # fallocate -l 1G /mnt/btrfs/foobar
>  # btrfs ins dump-tree -t chunk /dev/test/scratch1
>         item 7 key (FIRST_CHUNK_TREE CHUNK_ITEM 1674575872) itemoff 15511 itemsize 80
>                 length 536870912 owner 2 stripe_len 65536 type DATA
>  New data chunk will fallback to SINGLE or DUP.
> 
> 
> The cause is pretty simple, when mounted degraded, missing devices can't
> be used for chunk allocation.
> Thus btrfs has to fall back to SINGLE profile.
> 
> This patchset will make btrfs to consider missing devices as last resort if
> current rw devices can't fulfil the profile request.
> 
> This should provide a good balance between considering all missing
> device as RW and completely ruling out missing devices (current mainline
> behavior).

Thanks. This is going to change the behaviour with a missing device, so
the question is if we should make this configurable first and then
switch the default.

How does this work with scrub? Eg. if there are 2 devices in RAID1, one
goes missing and then scrub is started. It makes no sense to try to
repair the missing blocks, but given the logic in the patches all the
data will be rewritten, right?
