Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A64101545C4
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 15:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgBFOLv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 09:11:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:57050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbgBFOLv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Feb 2020 09:11:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8BF41ADF1;
        Thu,  6 Feb 2020 14:11:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8A14ADA952; Thu,  6 Feb 2020 15:11:36 +0100 (CET)
Date:   Thu, 6 Feb 2020 15:11:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 0/4 RESEND 1-3/4 v5 4/4] btrfs, sysfs cleanup and add
 dev_state
Message-ID: <20200206141136.GX2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20200203110012.5954-1-anand.jain@oracle.com>
 <20200203171659.GA2654@twin.jikos.cz>
 <c0ac6404-ed46-be94-ac05-01c723f05134@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0ac6404-ed46-be94-ac05-01c723f05134@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 06, 2020 at 02:31:02PM +0800, Anand Jain wrote:
> 
> 
> On 2/4/20 1:16 AM, David Sterba wrote:
> > On Mon, Feb 03, 2020 at 07:00:08PM +0800, Anand Jain wrote:
> >> Resend:
> >>    Patch 4/4 is already integrated without the cleanup and preparatory
> >>    patches (1,2,3)/4. So I am resending those 3 patches. And the changes
> >>    in patch 4/4 as in misc-next is imported into patch v5 4/4 here. Patch
> >>    4/4 has the details of the changes.
> > 
> > All the patches have been merged and now are in linus/master branch.
> 
> 
> David,
> 
> > I haven't reordered the patches so they're not in a group and the
> > preparatory patches are about 10 commits above v5.5-rc7 which is the
> > beginning of the branch.
> 
> 
>   It will cause problem during bisect, without the preparatory patches
>   the devid kobject lands under devices instead of under devinfo,
>   that's how I noticed that preparatory patches are missing.

I've tested current master and the device ids are indeed placed under
device/ and there is no devinfo/, so this needs to be fixed.

Preparatory patches I was referring to are:

bc036bb33524  btrfs: sysfs, merge btrfs_sysfs_add devices_kobj and fsid
be2cf92e0a2f  btrfs: sysfs, rename btrfs_sysfs_add_device()
c6761a9ed329  btrfs: sysfs, btrfs_sysfs_add_fsid() drop unused argument parent
b5501504cb6a  btrfs: sysfs, rename devices kobject holder to devices_kobj

so I'll have another look at what you sent.
