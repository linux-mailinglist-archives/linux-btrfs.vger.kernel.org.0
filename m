Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6041113026
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2019 17:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfLDQkB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 11:40:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:46318 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727008AbfLDQkB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Dec 2019 11:40:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E4148B1A8;
        Wed,  4 Dec 2019 16:39:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0EB96DA786; Wed,  4 Dec 2019 17:39:55 +0100 (CET)
Date:   Wed, 4 Dec 2019 17:39:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: Make balance cancelling response faster
Message-ID: <20191204163954.GG2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191203064254.22683-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203064254.22683-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 03, 2019 at 02:42:50PM +0800, Qu Wenruo wrote:
> [PROBLEM]
> There are quite some users reporting that 'btrfs balance cancel' slow to
> cancel current running balance, or even doesn't work for certain dead
> balance loop.
> 
> With the following script showing how long it takes to fully stop a
> balance:
>   #!/bin/bash
>   dev=/dev/test/test
>   mnt=/mnt/btrfs
> 
>   umount $mnt &> /dev/null
>   umount $dev &> /dev/null
> 
>   mkfs.btrfs -f $dev
>   mount $dev -o nospace_cache $mnt
> 
>   dd if=/dev/zero bs=1M of=$mnt/large &
>   dd_pid=$!
> 
>   sleep 3
>   kill -KILL $dd_pid
>   sync
> 
>   btrfs balance start --bg --full $mnt &
>   sleep 1
> 
>   echo "cancel request" >> /dev/kmsg
>   time btrfs balance cancel $mnt
>   umount $mnt
> 
> It takes around 7~10s to cancel the running balance in my test
> environment.
> 
> [CAUSE]
> Btrfs uses btrfs_fs_info::balance_cancel_req to record how many cancel
> request are queued.
> However that cancelling request is only checked after relocating a block
> group.

Yes that's the reason why it takes so long to cancel. Adding more
cancellation points is fine, but I don't know what exactly happens when
the block group relocation is not finished. There's code to merge the
reloc inode and commit that, but that's only a high-level view of the
thing.
