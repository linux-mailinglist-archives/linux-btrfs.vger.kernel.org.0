Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3763FEF6C
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 16:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345475AbhIBO13 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 10:27:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54822 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbhIBO10 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 10:27:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6E9B120373;
        Thu,  2 Sep 2021 14:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630592787;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aPyL9JDByoH1GVDcyVBn1F79AUrISIjB5TaQbemOMUE=;
        b=Fn7PuMoZ59eIeCPseLMpzsTeo/zH3VuwKGnGdRm+ukE0wdeN4Zv+Eenz4szAWBkiT5tsIS
        v7NsmaurWO75blZAwXsdwxDObZzLWf/LSzMuF5B9MFxZAy5EGLpnbcpTvUSG0jhknYW/Sx
        yTUFPThp6Wv1vnWJJU5ZaMGOJsAj4so=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630592787;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aPyL9JDByoH1GVDcyVBn1F79AUrISIjB5TaQbemOMUE=;
        b=8UnlGvFMgojmyYy+7L2tb8uuOyW2tBA6elhu4Oo8W5vpRKH4AtyK9FRVNLiA2a6EYbdBDG
        ui5Ieu0SF0JNk3CQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 64ECAA3B87;
        Thu,  2 Sep 2021 14:26:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2D00ADA72B; Thu,  2 Sep 2021 16:26:26 +0200 (CEST)
Date:   Thu, 2 Sep 2021 16:26:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, l@damenly.su
Subject: Re: [PATCH V5 4/4] btrfs: fix comment about the btrfs_show_devname
Message-ID: <20210902142625.GU3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, l@damenly.su
References: <cover.1629780501.git.anand.jain@oracle.com>
 <c3e2f34f0d328196dd7cd6bdae67a8219cef840c.1629780501.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3e2f34f0d328196dd7cd6bdae67a8219cef840c.1629780501.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 24, 2021 at 01:05:22PM +0800, Anand Jain wrote:
> There were few lock dep warnings because btrfs_show_devname() was using
> device_list_mutex as recorded in the commits
>   ccd05285e7f (btrfs: fix a possible umount deadlock)
>   779bf3fefa8 (btrfs: fix lock dep warning, move scratch dev out of
>   device_list_mutex and uuid_mutex)
> 
> And finally, commit 88c14590cdd6 (btrfs: use RCU in btrfs_show_devname
> for device list traversal) removed the device_list_mutex from
> btrfs_show_devname for performance reasons.
> 
> This patch fixes a stale comment about the function btrfs_show_devname.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 8470c5b5f35e..1d1204547e72 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2278,10 +2278,7 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
>  
>  	/*
>  	 * The update_dev_time() with in btrfs_scratch_superblocks()
> -	 * may lead to a call to btrfs_show_devname() which will try
> -	 * to hold device_list_mutex. And here this device
> -	 * is already out of device list, so we don't have to hold
> -	 * the device_list_mutex lock.
> +	 * may lead to a call to btrfs_show_devname().

I think the whole comment can be deleted, it was there namely for the
device_list_mutex and potential problems with show_devname, but this is
now sorted. What's remaining is that btrfs_scratch_superblocks happens
out of all locks but it's IMO clear from the code that the device is
being now disconnected from all structures and freed.
