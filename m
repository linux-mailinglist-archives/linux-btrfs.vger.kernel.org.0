Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF794929AE
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 16:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbiARPbu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jan 2022 10:31:50 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52672 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbiARPbt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jan 2022 10:31:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 762E5218E0;
        Tue, 18 Jan 2022 15:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642519908;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t4zZIVzTHY1eS0K2yU19dYbSC5jS7rWHgQD+MWOU3JI=;
        b=BO4RwgrQSDPBkccJEQ4Uwd6BB2r+z5Xy72BmmK5my3/+Ny8f3hlEkFWijmotyOZHc6nowN
        7Dxv2PmWZ7xTvuXZaSZ9bn7JuHQaJ9d3ErcqDbXKuhxyesK3GQvuI7jAkEgoeoiEqOlfU7
        caeVveCLFsPBGMSYGH7Adxb0h/73YRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642519908;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t4zZIVzTHY1eS0K2yU19dYbSC5jS7rWHgQD+MWOU3JI=;
        b=32yv9XSlOmUdbXBeO/CY6viGlaBKXo4BtMp+/9OKXUcqaZ4EMpM99zQHAFh2rq/pD54z+R
        drKlN0oJAG3juPAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 66EB5A3B84;
        Tue, 18 Jan 2022 15:31:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B4CDCDA7A3; Tue, 18 Jan 2022 16:31:11 +0100 (CET)
Date:   Tue, 18 Jan 2022 16:31:11 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.com, nborisov@suse.com, l@damenly.su,
        kreijack@libero.it
Subject: Re: [PATCH v5 0/4] btrfs: match device by dev_t
Message-ID: <20220118153111.GM14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com,
        nborisov@suse.com, l@damenly.su, kreijack@libero.it
References: <cover.1641963296.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1641963296.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 12, 2022 at 01:05:58PM +0800, Anand Jain wrote:
> v5: Patch 1/4 device_matched() to return bool; absorb errors in it to false.
>      Move if (!device->name) into device_matched().
>     Patch 2/4 fix the commit title and add a comment.
>     Patch 3/4 add more comment about btrfs_device::devt.
>     
> v4: Return 1 for device matched in device_matched()
>     Use scnprintf() instead of sprintf() in device_matched()
>     Change log updated drop commit id
>     Use str[0] instead of strlen()
>     Change logic from !lookup_bdev() to lookup_bdev == 0
> 
> v3: Added patch 3/4 saves and uses dev_t in btrfs_device and
>     thus patch 4/4 removes the function device_matched().
>     fstests btrfs passed with no new regressions.
> 
> v2: Fix 
>      sparse: warning: incorrect type in argument 1 (different address spaces)
>      For using device->name->str
> 
>     Fix Josef suggestion to pass dev_t instead of device-path in the
>      patch 2/2.
> 
> --- original cover letter -----
> Patch 1 is the actual bug fix and should go to stable 5.4 as well.
> On 5.4 patch1 conflicts (outside of the changes in the patch),
> so not yet marked for the stable.
> 
> Patch 2 simplifies calling lookup_bdev() in the device_matched()
> by moving the same to the parent function two levels up.
> 
> Patch 2 is not merged with 1 because to keep the patch 1 changes local
> to a function so that it can be easily backported to 5.4 and 5.10.
> 
> We should save the dev_t in struct btrfs_device with that may be
> we could clean up a few more things, including fixing the below sparse
> warning.
> 
>   sparse: sparse: incorrect type in argument 1 (different address spaces)
> 
> For using without rcu:
> 
>   error = lookup_bdev(device->name->str, &dev_old); 
> 
> 
> Anand Jain (4):
>   btrfs: harden identification of the stale device
>   btrfs: redeclare btrfs_free_stale_devices arg1 to dev_t
>   btrfs: add device major-minor info in the struct btrfs_device
>   btrfs: use dev_t to match device in device_matched

V5 looks good to me, thanks. If there are still fixups needed, I'm not
sure Nick has seen v5, I'll fold them to the patches in misc-next.
