Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338EF4378DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 16:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhJVORO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Oct 2021 10:17:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57316 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbhJVORM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Oct 2021 10:17:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 50D6A21639;
        Fri, 22 Oct 2021 14:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634912094;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CllnVNYquA2b/ef4zsfDXQLB5qJ7wtPVmRuLokEoQuc=;
        b=bW5LJbPvqenlDXA3YC8f4wRb/RhXarq0VL06h489kDs6rS2CB5zw93jaMPbW/TRGz48J6X
        RK3zodso/35qtI/hWctROOxxAkuGvV/tInaQeP1YXpD2jsKU+cCmpq6seIGAUir0U7Tmjx
        lJzeh80n3UphfALzrEH1+ah47WkrwCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634912094;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CllnVNYquA2b/ef4zsfDXQLB5qJ7wtPVmRuLokEoQuc=;
        b=vDWZZWN22z1gxQ+4qozLnSVBMU9+n797o8u3bnT2QB5wIFQP+GaWBguqXtglU2YPmjqtXV
        /sYFrFk6aRq1eQCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 49173A3B85;
        Fri, 22 Oct 2021 14:14:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 16BA7DA7A9; Fri, 22 Oct 2021 16:14:24 +0200 (CEST)
Date:   Fri, 22 Oct 2021 16:14:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Remove spurious unlock/lock of unused_bgs_lock
Message-ID: <20211022141424.GL20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211014070311.1595609-1-nborisov@suse.com>
 <20211021170410.GI20319@twin.jikos.cz>
 <1802ecc2-b8d4-0982-6488-f777005b7fc7@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1802ecc2-b8d4-0982-6488-f777005b7fc7@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 22, 2021 at 09:12:11AM +0300, Nikolay Borisov wrote:
> On 21.10.21 г. 20:04, David Sterba wrote:
> > On Thu, Oct 14, 2021 at 10:03:11AM +0300, Nikolay Borisov wrote:
> >> Since both unused block groups and reclaim bgs lists are protected by
> >> unused_bgs_lock then free them in the same critical section without
> >> doing an extra unlock/lock pair.
> >>
> >> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> >> ---
> >>  fs/btrfs/block-group.c | 2 --
> >>  1 file changed, 2 deletions(-)
> >>
> >> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> >> index e790ea0798c7..308b8e92c70e 100644
> >> --- a/fs/btrfs/block-group.c
> >> +++ b/fs/btrfs/block-group.c
> >> @@ -3873,9 +3873,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
> >>  		list_del_init(&block_group->bg_list);
> >>  		btrfs_put_block_group(block_group);
> >>  	}
> >> -	spin_unlock(&info->unused_bgs_lock);
> >>  
> >> -	spin_lock(&info->unused_bgs_lock);
> > 
> > That looks correct, I'm not sure about one thing. The calls to
> > btrfs_put_block_group can be potentaily taking some time if the last
> > reference is dropped and we need to call btrfs_discard_cancel_work and
> > several kfree()s. Indirectly there's eg. cancel_delayed_work_sync and
> > btrfs_discard_schedule_work, so calling all that under unused_bgs_lock
> > seems quite heavy.
> 
> btrfs_free_block_groups is called from 2 contexts only:
> 
> 1. If we error out during mount
> 2. One of the last things we do during unmount, when all worker threads
> are stopped.
> 
> IMO doing the cond_resched_lock would be a premature optimisation and
> I'd aim for simplicity.

I'm not optimizing anything but rather preventing problems, cond_resched
is lightweight and one of the things that's nice to the rest of the
system.
