Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE7F797DD7
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 23:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjIGVQz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 17:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjIGVQy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 17:16:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E60E1BCE
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 14:16:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 14000212AE;
        Thu,  7 Sep 2023 21:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694121408;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m1n1+gC71HiCJzdyfOa5tB09pxt7FxONEYqkDlMTIjg=;
        b=h0IjyIx7IQ7Poqlv13O/nlBjQzPifMivUxNLUXioJkP4x27pl8AEFUmUee+O+CkvpqzPDV
        B4oJxy0DIg/OVKnP0fWyisE2kkD+GP9ssUh0QPISIiWbTgq4XM5zJaYFBjVsXLB1HjJIVT
        NMMmwww15A8N4k195BI3FccOhLYJ5oY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694121408;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m1n1+gC71HiCJzdyfOa5tB09pxt7FxONEYqkDlMTIjg=;
        b=QGrmOwXwbToAO57cAfAQvVeHRAsMrOE+8NBxXBoC/xmjrWcaHfSPnZk2sWMzwS8jIBAG6s
        aOxH1aOBVwyIFOCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF735138F9;
        Thu,  7 Sep 2023 21:16:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FMrYMb89+mSfGwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Sep 2023 21:16:47 +0000
Date:   Thu, 7 Sep 2023 23:10:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: pseudo device-scan for single-device filesystems
Message-ID: <20230907211015.GR3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b0e0240254557461c137cd9b943f00b0d5048083.1693959204.git.anand.jain@oracle.com>
 <20230907143658.GQ3159@twin.jikos.cz>
 <3a5c3d54-2e34-fe47-1ed0-12c765a928b9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a5c3d54-2e34-fe47-1ed0-12c765a928b9@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 12:48:04AM +0800, Anand Jain wrote:
> Right. btrfs_read_disk_super() called during scan, performs sanity
> checks on the superblock.
> 
> >> The seed device must remain in the kernel memory to allow the sprout
> >> device to mount without the need to specify the seed device explicitly.
> > 
> > And in case the seeding status of the already scanned and registered
> > device is changed another scan will happen by udev due to openning for
> > write. So I guess it's safe.
> 
> Changed? I think you meant converting the seed device back to a normal
> device.
> 
> With the current code, the stale fs_devices will remain until the
> changed device is mounted, as its udev scan will return success without
> calling the device_list_add() function.
> 
> However, there are two things we can do to fix it:
> 
> In the kernel, call btrfs_free_stale_devices() before the pseudo scan's
> return.
> 
> In the btrfs-progs, 'btrfstune -S 0 <dev-seed>' thread to call 'scan
> --forget <dev-seed> ioctl'.

This should work without involvement of userspace regarding the single
devices, while adding an explicit 'device scan --forget' to the scan
command would make sure that our tools do the right thing in case
somebody copies that.

The device scanning is quite specific but systemd/udevd has own utility
that scans devices so it could be updated (depends when) and if kernel
does it right regardless of the systemd scan then we can cover more
cases.

> >> --- a/fs/btrfs/volumes.c
> >> +++ b/fs/btrfs/volumes.c
> >> @@ -1218,7 +1218,8 @@ int btrfs_forget_devices(dev_t devt)
> >>    * and we are not allowed to call set_blocksize during the scan. The superblock
> >>    * is read via pagecache
> >>    */
> >> -struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
> >> +struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
> >> +					   bool mount_arg_dev)
> >>   {
> >>   	struct btrfs_super_block *disk_super;
> >>   	bool new_device_added = false;
> >> @@ -1263,10 +1264,19 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
> >>   		goto error_bdev_put;
> >>   	}
> >>   
> >> +	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
> >> +	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
> >> +		pr_info("skip registering single non seed device path %s\n",
> >> +			path);
> > 
> > Wouldn't this be too noisy in the logs? With the scanning and
> > registration repeated scans of a device there will be only the first
> > message, but on a system with potentially many single-dev devices each
> > time udev would want to scan it and it'd get logged.
> 
> Ah. I used it for debugging; it should be removed.

You can turn it to pr_debug if you found it useful, for testing setups
we don't mind more messages.
