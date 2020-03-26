Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2327193544
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 02:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCZBaM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 21:30:12 -0400
Received: from magic.merlins.org ([209.81.13.136]:37132 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbgCZBaM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 21:30:12 -0400
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1jHHLT-00085b-IZ by authid <merlin>; Wed, 25 Mar 2020 18:30:07 -0700
Date:   Wed, 25 Mar 2020 18:30:07 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: 5.4.20: cannot mount device that blipped off the bus: duplicate
 device fsid:devid for
Message-ID: <20200326013007.GS15123@merlins.org>
References: <20200321202307.GA15906@merlins.org>
 <1aaae706-0029-be4f-9f6f-194b03087b35@suse.com>
 <20200325201455.GO29461@merlins.org>
 <a9dd1b1a-b38e-a0f4-91e1-b89063e8ae1e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9dd1b1a-b38e-a0f4-91e1-b89063e8ae1e@oracle.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 26, 2020 at 07:56:10AM +0800, Anand Jain wrote:
> > Are users really supposed to know this?
> > Why does btrfs device scan not invalidate the cache of devices and keep
> > remembering a device that's gone (not visible in new scan)?
> 
>  btrfs device scan --forget is only useful to cleanup the unmounted
>  devices, per the logs below the device was mounted when it disappeared.
>  More below.
 
I'm confused: why is --forget even needed? Why would it remember devices
that were unmounted and not part of a new scan?

And yes, the device was not unmounted. The sata layer failed, device
disappeared while mounted and then re-appeared 
I was able to force umount the mountpoints, so maybe --forget would have
helped, but I'm confused as to why it even exists.
 
>   This indicates the device was mounted when it disappeared. So it
>   re-appears with the new path, but as its fsid+uuid+devid matches
>   with the old still mounted device we rightly consider it as an
>   alien device and fail the mount.
 
It was unmounted after disappearing, see the 'grep sde /proc/mounts'
showing that it wasn't mounted anymore, so it seems that even that part
didn't work as intended?

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
