Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1B744327C
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 17:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbhKBQJN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 12:09:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58636 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbhKBQET (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 12:04:19 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 984CF218D6;
        Tue,  2 Nov 2021 16:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635868903;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7cVHXpoVPPgrRSOw0P152RgHjff0Yl+kqK0cDW7ep1U=;
        b=TfGDUYZb4vlsXSEurr0MEG7Y3Mx8q7/0Edou5E7J88GKQdhfYO6MRsi1Zji312kr5pqfR3
        1wCwj/6bDg0Bmw8PYuEAa9XOpTH8LFeOoYOaKIHuSwrXD91YB8+9LVcFnW7B6010ZZFb13
        Am6oD0DMWnB3DEmFkR7TrNCeutnekIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635868903;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7cVHXpoVPPgrRSOw0P152RgHjff0Yl+kqK0cDW7ep1U=;
        b=4SAnm+frEL2waY4D5P0AnZtHjYy+L/JLDaFEct0uSNihxvuAESAUPjIO6DexbW/DvFwMwg
        dEM+4xA1eR3KLFDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 909B2A3B83;
        Tue,  2 Nov 2021 16:01:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 354D1DA7A9; Tue,  2 Nov 2021 17:01:08 +0100 (CET)
Date:   Tue, 2 Nov 2021 17:01:07 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Chris Murphy <lists@colorremedies.com>
Subject: Re: [PATCH] btrfs: fix memory ordering between normal and ordered
 work functions
Message-ID: <20211102160107.GL20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, Chris Murphy <lists@colorremedies.com>
References: <20211102124916.433836-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102124916.433836-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 02, 2021 at 02:49:16PM +0200, Nikolay Borisov wrote:
> Ordered work functions aren't guaranteed to be handled by the same thread
> which executed the normal work functions. The only way execution between
> normal/ordered functions is synchronized is via the WORK_DONE_BIT,
> unfortunately the used bitops don't guarantee any ordering whatsoever.
> 
> This manifested as seemingly inexplicable crashes on arm64, where
> async_chunk::inode is seens as non-null in async_cow_submit which causes
> submit_compressed_extents to be called and crash occurs because
> async_chunk::inode suddenly became NULL. The call trace was similar to:
> 
>     pc : submit_compressed_extents+0x38/0x3d0
>     lr : async_cow_submit+0x50/0xd0
>     sp : ffff800015d4bc20
> 
>     <registers omitted for brevity>
> 
>     Call trace:
>      submit_compressed_extents+0x38/0x3d0
>      async_cow_submit+0x50/0xd0
>      run_ordered_work+0xc8/0x280
>      btrfs_work_helper+0x98/0x250
>      process_one_work+0x1f0/0x4ac
>      worker_thread+0x188/0x504
>      kthread+0x110/0x114
>      ret_from_fork+0x10/0x18
> 
> Fix this by adding respective barrier calls which ensure that all
> accesses preceding setting of WORK_DONE_BIT are strictly ordered before
> settint the flag. At the same time add a read barrier after reading of
> WORK_DONE_BIT in run_ordered_work which ensures all subsequent loads
> would be strictly ordered after reading the bit. This in turn ensures
> are all accesses before WORK_DONE_BIT are going to be strictly ordered
> before any access that can occur in ordered_func.
> 
> Fixes: 08a9ff326418 ("btrfs: Added btrfs_workqueue_struct implemented ordered execution based on kernel workqueue")
> Reported-by: Chris Murphy <lists@colorremedies.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2011928
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.
> ---
> 
> David,
> 
> IMO this is stable material.

Yes. You can add the CC: stable@ tag or leave such notice so we don't
spam their mailinglist.
