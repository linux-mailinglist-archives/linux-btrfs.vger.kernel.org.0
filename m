Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7079646C335
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 19:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240583AbhLGS7t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 13:59:49 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:32818 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhLGS7t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 13:59:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DC6501FE00;
        Tue,  7 Dec 2021 18:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638903377;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u5NacZsPhQsy8KIuwecJl/5ozGh155BhJSKbjsdXSqk=;
        b=0xpGjm+i/Qn16O60Q5wlNVcpi5eBd+R9jwFQJxkp2nwn8W67QTwmQyVBlPtKf4Tu5ExdXG
        RDy3jUl3U9MfoVNue6ZUxHvZkRzcoKWP6kDLSjAyr5jvkm3sVFAWi0xtLgtb6XoPziYunc
        o18Gkagrc2GINv9wdLKI6VQpqOCtsRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638903377;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u5NacZsPhQsy8KIuwecJl/5ozGh155BhJSKbjsdXSqk=;
        b=k+/WpnAWfx5mO49a+FMwCY8S9WylhsPnNTYEdIzVDdHVWiPOqwQ7NapefZjqfK4tWJ/9GW
        JbZGTTx3Iw7iaMAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CA12BA3B81;
        Tue,  7 Dec 2021 18:56:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 29EA2DA799; Tue,  7 Dec 2021 19:56:03 +0100 (CET)
Date:   Tue, 7 Dec 2021 19:56:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 2/2] btrfs: sysfs add devinfo/fsid to retrieve fsid
 from the device
Message-ID: <20211207185602.GZ28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <cover.1634829757.git.anand.jain@oracle.com>
 <33e179f8b9341c88754df639b77dafaa1ffec0d1.1634829757.git.anand.jain@oracle.com>
 <20211116171621.GU28560@twin.jikos.cz>
 <5f269a90-7145-0991-5da4-5f03fc0937fa@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f269a90-7145-0991-5da4-5f03fc0937fa@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 17, 2021 at 11:29:26AM +0800, Anand Jain wrote:
> On 17/11/2021 01:16, David Sterba wrote:
> > On Thu, Oct 21, 2021 at 11:31:17PM +0800, Anand Jain wrote:
> >> In the case of the seed device, the fsid can be different from the mounted
> >> sprout fsid.  The userland has to read the device superblock to know the
> >> fsid but, that idea fails if the device is missing. So add a sysfs
> >> interface devinfo/<devid>/fsid to show the fsid of the device.
> >>
> >> For example:
> >>   $ cd /sys/fs/btrfs/b10b02a5-f9de-4276-b9e8-2bfd09a578a8
> >>
> >>   $ cat devinfo/1/fsid
> >>   c44d771f-639d-4df3-99ec-5bc7ad2af93b
> >>   $ cat  devinfo/3/fsid
> >>   b10b02a5-f9de-4276-b9e8-2bfd09a578a8
> > 
> >  From user perspective, it's another fsid, one is in the path, so I'm
> > wondering if it should be named like read_fsid or sprout_fsid or if the
> > seed/sprout information should be put into another directory completely.
> 
> I am viewing it as fsid as per the device's sb.

That's a reasonable point.

> This fsid matches with
> the blkid(8) output. A path to the device's fsid will help to script.
> So I am not voting for sprout_fsid because it does not exist in the
> most common non-sprouted fsid.

Yeah agreed, I've put this to the changelog as it explains the naming.
