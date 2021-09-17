Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E6140FA38
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Sep 2021 16:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242877AbhIQOev (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 10:34:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33250 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241700AbhIQOeu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 10:34:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E11CD1FEE5;
        Fri, 17 Sep 2021 14:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631889207;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oNUQio2yPty8dFJFKsPeu+qD+0ok7A4ofdSZ4VKbuSo=;
        b=jRLyeU0/ZAUTmoT8vYHF4tlwARVNHC8uI/6ichhaZqhRJ5hbFVAuKFhvcn/KtCDxtKUp9d
        NgvqWwZ/jP/7LW2evskimBml248lael3mS3v1m05InpVJF3XeSERha+RC+WcWoL+xvFmE4
        CWdn67Ht4CMpDiKeSQktlTj6hn26u+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631889207;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oNUQio2yPty8dFJFKsPeu+qD+0ok7A4ofdSZ4VKbuSo=;
        b=OM0HbcmLSy45I+3JmBXK55jQlh+ixcu4CgKXwFiQQFfkDALOFEb9e+SBueISF2Z4scSEc2
        M6aOcE6ZZ/zAozCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D9B70A3B93;
        Fri, 17 Sep 2021 14:33:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3630DDA781; Fri, 17 Sep 2021 16:33:17 +0200 (CEST)
Date:   Fri, 17 Sep 2021 16:33:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/7] btrfs: do not take the uuid_mutex in
 btrfs_rm_device
Message-ID: <20210917143317.GU9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1627419595.git.josef@toxicpanda.com>
 <4f7529acd33594df9b0b06f7011d8cd4d195fc29.1627419595.git.josef@toxicpanda.com>
 <20210902125820.GR3379@twin.jikos.cz>
 <bfd5a7be-da05-62de-997e-2e513c606915@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfd5a7be-da05-62de-997e-2e513c606915@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 02, 2021 at 10:10:04AM -0400, Josef Bacik wrote:
> > This is a bit hand wavy but the critical part of the correctness proof,
> > and it's not explaining it enough IMO. The important piece happens in
> > device_list_add, the fs_devices lookup and EBUSY, but all that is now
> > excluded completely by the uuid_mutex from running in parallel with any
> > part of rm_device.
> > 
> > This means that the state of the device is seen complete by each (scan,
> > rm device). Without the uuid mutex the scaning can find the signature,
> > then try to lookup the device in the list, while in parallel the rm
> > device changes the signature or manipulates the list. But not everything
> > is covered by the device list mutex so there are combinations of both
> > tasks with some in-progress state.  Also count in the RCU protection.
> > 
> >  From high level it is what you say about ordering scan/scratch, but
> > otherwise I'm not convinced that the change is not subtly breaking
> > something.
> > 
> 
> Yeah this is far from ideal, we really need to rework our entire device 
> liftetime handling and locking, however this isn't going to break 
> anything.  We are worried about rm and scan racing with each other, 
> before this change we'll zero the device out under the UUID mutex so 
> when scan does run it'll make sure that it can go through the whole 
> device scan thing without rm messing with us.
> 
> We aren't worried if the scratch happens first, because the result is we 
> don't think this is a btrfs device and we bail out.
> 
> The only case we are concerned with is we scratch _after_ scan is able 
> to read the superblock and gets a seemingly valid super block, so lets 
> consider this case.
> 
> Scan will call device_list_add() with the device we're removing.  We'll 
> call find_fsid_with_metadata_uuid() and get our fs_devices for this 
> UUID.  At this point we lock the fs_devices->device_list_mutex.  This is 
> what protects us in this case, but we have two cases here.
> 
> 1. We aren't to the device removal part of the RM.  We found our device, 
> and device name matches our path, we go down and we set total_devices to 
> our super number of devices, which doesn't affect anything because we 
> haven't done the remove yet.
> 
> 2. We are past the device removal part, which is protected by the 
> device_list_mutex.  Scan doesn't find the device, it goes down and does the
> 
> if (fs_devices->opened)
> 	return -EBUSY;
> 
> check and we bail out.
> 
> Nothing about this situation is ideal, but the lockdep splat is real, 
> and the fix is safe, tho admittedly a bit scary looking.  Thanks,

Thanks, reading the code a few more times I tend to agree, I've added
this another explanation to the changelog.
