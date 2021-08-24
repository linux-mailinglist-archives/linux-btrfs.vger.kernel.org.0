Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05BB3F6282
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 18:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhHXQOk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 12:14:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42182 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbhHXQOi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 12:14:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3C4372205F;
        Tue, 24 Aug 2021 16:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629821633;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ILmyu9G7cKLch5m+JnqQvCR9313B3UZRcKMhw6ahbtY=;
        b=UjTQMHPp8yYCcC8IMuQS92n53uFkijpBbLx0wONgEke0tVDu8OIevHhchb2zB65Qjb/7lv
        oN1uk1k3HBM8kFCQqEbHeC27Aii0c6tktWt5fKhqjctjSX+/OuAH4a/HP6w8p3kmeApPA7
        9yOZIKNg3sBt+qjsF0/MwTtlS7b3G6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629821633;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ILmyu9G7cKLch5m+JnqQvCR9313B3UZRcKMhw6ahbtY=;
        b=+hVBl2OMAmqilTOA5RN90zFELh6JQ/a6AOXZEekT81z1sWWiOOAl1HmizGXc5BTWrj2REd
        lw/e0FjAQeKEKzBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 32B2CA3BC2;
        Tue, 24 Aug 2021 16:13:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3FC90DA85B; Tue, 24 Aug 2021 18:11:06 +0200 (CEST)
Date:   Tue, 24 Aug 2021 18:11:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        l@damenly.su
Subject: Re: [PATCH v4 0/4] btrf_show_devname related fixes
Message-ID: <20210824161106.GD3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, l@damenly.su
References: <cover.1629458519.git.anand.jain@oracle.com>
 <20210823194618.GT5047@twin.jikos.cz>
 <b0792837-0227-0404-315e-d4a5d7ca4a2c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0792837-0227-0404-315e-d4a5d7ca4a2c@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 24, 2021 at 08:28:09AM +0800, Anand Jain wrote:
> 
> 
> On 24/08/2021 03:46, David Sterba wrote:
> > On Mon, Aug 23, 2021 at 07:31:38PM +0800, Anand Jain wrote:
> >> These fixes are inspired by the bug report and its discussions in the
> >> mailing list subject
> >>   btrfs: traverse seed devices if fs_devices::devices is empty in show_devname
> >>
> >> And depends on the patch
> >>   [PATCH v2] btrfs: fix lockdep warning while mounting sprout fs
> >> in the ML
> >>
> >> v4:
> >>   Fix unrelated changes in 2/4
> >> v3:
> >>   Fix rcu_lock in the patch 3/4
> >>
> >> Anand Jain (4):
> >>    btrfs: consolidate device_list_mutex in prepare_sprout to its parent
> >>    btrfs: save latest btrfs_device instead of its block_device in
> >>      fs_devices
> >>    btrfs: use latest_dev in btrfs_show_devname
> >>    btrfs: update latest_dev when we sprout
> > 
> > Patchset survived one round of fstests and I haven't seen the lockdep
> > warning in btrfs/020 that's caused by some unrelated work in loop device
> > driver.
> 
> 
> > There's a series from Josef to fix it by shuffling locking,
> 
>   Hm. Is it a recent patch? I can't find.

https://lore.kernel.org/linux-btrfs/cover.1627419595.git.josef@toxicpanda.com/

>   Is it about device_list_mutex (as in cleanup patch 1 above) or 
> btrfs_show_devname() (which patches 2-4 fixes)?

Relatd to device locking, so device list mutex and also uuid mutex IIRC.
