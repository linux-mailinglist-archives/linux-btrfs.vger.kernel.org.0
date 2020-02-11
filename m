Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7085F1599C0
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 20:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgBKT3W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 14:29:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:35722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729540AbgBKT3W (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 14:29:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 73A50AAFD;
        Tue, 11 Feb 2020 19:29:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4EA65DA703; Tue, 11 Feb 2020 20:29:06 +0100 (CET)
Date:   Tue, 11 Feb 2020 20:29:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 0/4 RESEND 1-3/4 v5 4/4] btrfs, sysfs cleanup and add
 dev_state
Message-ID: <20200211192904.GG2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20200203110012.5954-1-anand.jain@oracle.com>
 <20200203171659.GA2654@twin.jikos.cz>
 <c0ac6404-ed46-be94-ac05-01c723f05134@oracle.com>
 <20200206141136.GX2654@twin.jikos.cz>
 <5a9e45e2-645c-e15e-c87c-6914d3e2f397@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a9e45e2-645c-e15e-c87c-6914d3e2f397@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 11, 2020 at 12:46:58PM +0800, Anand Jain wrote:
> > I've tested current master and the device ids are indeed placed under
> > device/ and there is no devinfo/, so this needs to be fixed.
> > 
> > Preparatory patches I was referring to are:
> > 
> > bc036bb33524  btrfs: sysfs, merge btrfs_sysfs_add devices_kobj and fsid
> > be2cf92e0a2f  btrfs: sysfs, rename btrfs_sysfs_add_device()
> > c6761a9ed329  btrfs: sysfs, btrfs_sysfs_add_fsid() drop unused argument parent
> > b5501504cb6a  btrfs: sysfs, rename devices kobject holder to devices_kobj
> > 
> > so I'll have another look at what you sent.
> > 
> David,
> 
>   Busy? Can I ping on this?
> 
>   Those aren't the preparatory patches. The patches sent here applies
>   nicely on misc-next with git revert 668e48af7a94

Do you realize that patch 668e48af7a94 had been merged to linus/master
at the time you sent the patchset a week ago? How can I do git revert?
That was in the middle of merge window, 2 weeks after code freeze. If I
don't merge a patch intentionally or by mistake, then you send me an
incremental change.

Please send update with this patch order:

* "btrfs: sysfs, add UUID/devinfo kobject"
* fixup of the device id files created under devices
* the other cleanups
