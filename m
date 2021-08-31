Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE2C3FCAF9
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 17:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239455AbhHaPlI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 11:41:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33050 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbhHaPlH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 11:41:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CC30E22283;
        Tue, 31 Aug 2021 15:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630424410;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jL3bNX1RHzN5PXMi8ai9LljHnw6sDekdCXg8HrQ2/jk=;
        b=ny7Lgkx72x+r9C7/Stnvx5gpClWULuHFHwHuF+lKEy+VApGMyQVsnFyw+3bqsgLqDnl5ad
        XCzoWCbTuhm3tlIkw0L1A1LgJZzqVlseIUt0sS5IAlI0Did3Uk1KykRax/Pohko5XKRGWH
        XmmWna8OGtUoN+oTh3/Hhwlcl6rFzpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630424410;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jL3bNX1RHzN5PXMi8ai9LljHnw6sDekdCXg8HrQ2/jk=;
        b=e5ogPx2olXK7bi1BXKAbTFVSJ8cG87XSpsQR9vRkyVeAsrMdVU6MNrPiisysRN6EEOJiU1
        c5DJaA2FTdDmdZBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C18ACA3B9F;
        Tue, 31 Aug 2021 15:40:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5DA40DA8C1; Tue, 31 Aug 2021 17:40:09 +0200 (CEST)
Date:   Tue, 31 Aug 2021 17:40:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org, l@damenly.su
Subject: Re: [PATCH v4 0/4] btrf_show_devname related fixes
Message-ID: <20210831154008.GK3379@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org, l@damenly.su
References: <cover.1629458519.git.anand.jain@oracle.com>
 <20210823194618.GT5047@twin.jikos.cz>
 <b0792837-0227-0404-315e-d4a5d7ca4a2c@oracle.com>
 <20210824161106.GD3379@twin.jikos.cz>
 <a3af668b-a91a-548f-4ec5-1104bd831a78@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3af668b-a91a-548f-4ec5-1104bd831a78@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 25, 2021 at 10:13:52AM +0800, Anand Jain wrote:
> On 25/08/2021 00:11, David Sterba wrote:
> > On Tue, Aug 24, 2021 at 08:28:09AM +0800, Anand Jain wrote:
> >>
> >>
> >> On 24/08/2021 03:46, David Sterba wrote:
> >>> On Mon, Aug 23, 2021 at 07:31:38PM +0800, Anand Jain wrote:
> >>>> These fixes are inspired by the bug report and its discussions in the
> >>>> mailing list subject
> >>>>    btrfs: traverse seed devices if fs_devices::devices is empty in show_devname
> >>>>
> >>>> And depends on the patch
> >>>>    [PATCH v2] btrfs: fix lockdep warning while mounting sprout fs
> >>>> in the ML
> >>>>
> >>>> v4:
> >>>>    Fix unrelated changes in 2/4
> >>>> v3:
> >>>>    Fix rcu_lock in the patch 3/4
> >>>>
> >>>> Anand Jain (4):
> >>>>     btrfs: consolidate device_list_mutex in prepare_sprout to its parent
> >>>>     btrfs: save latest btrfs_device instead of its block_device in
> >>>>       fs_devices
> >>>>     btrfs: use latest_dev in btrfs_show_devname
> >>>>     btrfs: update latest_dev when we sprout
> >>>
> >>> Patchset survived one round of fstests and I haven't seen the lockdep
> >>> warning in btrfs/020 that's caused by some unrelated work in loop device
> >>> driver.
> >>
> >>
> >>> There's a series from Josef to fix it by shuffling locking,
> >>
> >>    Hm. Is it a recent patch? I can't find.
> > 
> > https://lore.kernel.org/linux-btrfs/cover.1627419595.git.josef@toxicpanda.com/
> 
> Thx.
> It is the same fix I sent ~3months before in the ML[1].

Well, I've seen the patch and pings but sometimes the timing is not good
and there's something else I have to finish before looking into new
area. And device locking is something that needs full attention. The
bugs/warnings in question weren't that important.

But anyway now the 5.15 branch is out and there are several patches
regarding the devices so I'm going to spend time on that.  Also because
the recent updates to loop devices started to trigger lockdep warnings
that make testing harder and we're missing lockdep in many tests.
