Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B481A39E6EE
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jun 2021 20:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFGTAf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 15:00:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37906 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhFGTAc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Jun 2021 15:00:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 662CE1FD2A;
        Mon,  7 Jun 2021 18:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623092320;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cqTYytf/tOVILZ0wzshm5HnlgJUrkXVERtt5VSEOuAc=;
        b=B+O7lJIeEjVHHVRzQm8tVcz4crtTX16f2VONytBVCG5nPmBfFhrf8jaxPKFA0LGXRYquXU
        M4mwvrFsbSdSaWJknFjNwdnM4aABVHbqruBULf1owsHXElI2AZ5MEs/o4DwndsQZxnt60n
        k+IxPxnrOS/HYK2n/bikurasuTI8HpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623092320;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cqTYytf/tOVILZ0wzshm5HnlgJUrkXVERtt5VSEOuAc=;
        b=9G2SxkIfaqFXbSH8AvVpCDTfIDaimC8xgeyYfVtSS9a2aGu0x/r8PSN0Zhm+AKiyc7BLhK
        4mkVq5ohznMqfNAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 60839A3BA6;
        Mon,  7 Jun 2021 18:58:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3C898DB228; Mon,  7 Jun 2021 20:55:57 +0200 (CEST)
Date:   Mon, 7 Jun 2021 20:55:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: export dev stats in devinfo directory
Message-ID: <20210607185556.GL31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210604132058.11334-1-dsterba@suse.com>
 <5aeca0cd-c6b2-939a-6f83-7ea5722076dc@oracle.com>
 <20210604142105.GD31483@twin.jikos.cz>
 <77708664-a7db-50e0-aa44-6cbb3fb90070@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77708664-a7db-50e0-aa44-6cbb3fb90070@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jun 05, 2021 at 06:38:16AM +0800, Anand Jain wrote:
> On 04/06/2021 22:21, David Sterba wrote:
> > On Fri, Jun 04, 2021 at 09:41:09PM +0800, Anand Jain wrote:
> >> On 4/6/21 9:20 pm, David Sterba wrote:
> >>> The device stats can be read by ioctl, wrapped by command 'btrfs device
> >>> stats'. Provide another source where to read the information in
> >>> /sys/fs/btrfs/FSID/devinfo/DEVID/stats .
> >>
> >>    The planned stat here is errors stat.
> >>    So why not rename this to error_stats?
> > 
> > I think it's commonly called device stats, dev stats, so when it's in
> > 'devinfo' it's like it's the 'stats' for the device.
> 
> 
> > We don't have other
> > stats, like regarding io but in that case it would make sense to
> > distnguish the names.
> 
> My read_policy work (which I suppose is next on your list for review) 

Yeah, it's among the next things to merge once the current features
stabilize enough.

> made sense that publishing the io-stat information locally from btrfs is 
> a good idea. So that it provides clarity if the IO is skewed to a device 
> or balanced. Which is even more essential in the case of mixed device 
> types. For now IMHO,  /sys/fs/btrfs/FSID/devinfo/DEVID/error_stats
> is harmless.

Agreed, I thought about the same, gathering some regular io stats, so
the error_stats makes sense. There's still one open question whether to
do it all in one file or in a subdirectory error_stats/ . The sysfs way
is one value per file but for the stats I'm more inclined to follow what
/proc/ stats do. It's more convenient to monitor stats in one file read
than having to do 'cat error_stats/*' or with filenames as 'grep ^
error_stats/*'.
