Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F14B15AED1
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 18:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgBLRfl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 12:35:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:36950 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbgBLRfk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 12:35:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 111C4B20D;
        Wed, 12 Feb 2020 17:35:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C0086DA8DB; Wed, 12 Feb 2020 18:35:24 +0100 (CET)
Date:   Wed, 12 Feb 2020 18:35:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: sysfs, add devinfo, fix devid and cleanups
Message-ID: <20200212173523.GO2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1581499693-22407-1-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581499693-22407-1-git-send-email-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 12, 2020 at 05:28:09PM +0800, Anand Jain wrote:
> Here, first patch creates UUID/devinfo. 2nd relocates devid kobject to
> UUID/devinfo.
> 
> Patches 3 and 4 are cleanups.
> 
> Anand Jain (4):
>   btrfs: sysfs, add UUID/devinfo kobject
>   btrfs: sysfs, move dev_state kobject under UUID/devinfo
>   btrfs: sysfs, use btrfs_sysfs_remove_fsid in fail return in add_fsid
>   btrfs: sysfs, rename device_link add,remove functions

Thanks, all added to misc-next, 1 and 2 are going to 5.6-rc.

Please number the patchset iterations only, not versions of individual
patches.
