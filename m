Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE8E3E5DDD
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 16:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbhHJO1I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 10:27:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36178 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241521AbhHJO0j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 10:26:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4D7BC22078;
        Tue, 10 Aug 2021 14:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628605576;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Wj0/ZvSfj0MxUIX2Hm9nFlQIZba0/qLQ4OObUIe2yY=;
        b=2+d88YCjtaebu4/4bsBsvyYRlwglvc7snDCI2HCs9qjG/7aWX0wwBPzhQGND99/49INSsi
        5os5iqSwU0FqCSEon2g96XHTvc7KHpANNDFd8cC3MlThfonUxd79dVLruO70aXGgu8z4nr
        DSfAjNSVmGguWVllclMmYsZ1aqJ/lWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628605576;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Wj0/ZvSfj0MxUIX2Hm9nFlQIZba0/qLQ4OObUIe2yY=;
        b=ghgoPVPiNLBcRo/X5aGUeqZ3Y23OFYp3HOM8IVQ9/sCgCUR7/fBWhhcxL4bIoxzOtG9fht
        4jAD74c3Z4jZQ5Dw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 45258A3B8B;
        Tue, 10 Aug 2021 14:26:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EA30CDA880; Tue, 10 Aug 2021 16:23:23 +0200 (CEST)
Date:   Tue, 10 Aug 2021 16:23:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        butt3rflyh4ck <butterflyhuangxx@gmail.com>
Subject: Re: [PATCH] btrfs: fix NULL pointer dereference when deleting device
 by invalid id
Message-ID: <20210810142323.GX5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        butt3rflyh4ck <butterflyhuangxx@gmail.com>
References: <20210806102415.304717-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806102415.304717-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 06, 2021 at 06:24:15PM +0800, Qu Wenruo wrote:
> [BUG]
> It's super easy to trigger NULL pointer dereference, just by removing a
> non-exist device id:
> 
>  # mkfs.btrfs -f -m single -d single /dev/test/scratch1 \
> 				     /dev/test/scratch2
>  # mount /dev/test/scratch1 /mnt/btrfs
>  # btrfs device remove 3 /mnt/btrfs
> 
> Then we have the following kernel NULL pointer dereference:
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 9 PID: 649 Comm: btrfs Not tainted 5.14.0-rc3-custom+ #35
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>  RIP: 0010:btrfs_rm_device+0x4de/0x6b0 [btrfs]
>   btrfs_ioctl+0x18bb/0x3190 [btrfs]
>   ? lock_is_held_type+0xa5/0x120
>   ? find_held_lock.constprop.0+0x2b/0x80
>   ? do_user_addr_fault+0x201/0x6a0
>   ? lock_release+0xd2/0x2d0
>   ? __x64_sys_ioctl+0x83/0xb0
>   __x64_sys_ioctl+0x83/0xb0
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> [CAUSE]
> Commit a27a94c2b0c7 ("btrfs: Make btrfs_find_device_by_devspec return
> btrfs_device directly") moves the "missing" device path check into
> btrfs_rm_device().
> 
> But btrfs_rm_device() itself can have case where it only receives
> @devid, with NULL as @device_path.
> 
> In that case, calling strcmp() on NULL will trigger the NULL pointer
> dereference.
> 
> Before that commit, we handle the "missing" case inside
> btrfs_find_device_by_devspec(), which will not check @device_path at all
> if @devid is provided, thus no way to trigger the bug.
> 
> [FIX]
> Before calling strcmp(), also make sure @device_path is not NULL.
> 
> Fixes: a27a94c2b0c7 ("btrfs: Make btrfs_find_device_by_devspec return btrfs_device directly")
> Reported-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thanks for the report and fix, added to misc-next.
