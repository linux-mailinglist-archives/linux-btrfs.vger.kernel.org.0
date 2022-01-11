Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589EC48B19A
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 17:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349799AbiAKQIO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 11:08:14 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57490 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240042AbiAKQIN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 11:08:13 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B37C71F3B9;
        Tue, 11 Jan 2022 16:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641917292;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LBycJvGkEqMVbJWzLuLrTIrZNv/mO/AlmiwshVaO16E=;
        b=vaeZYqIPZSwuu5okFxLyW2X2D4M389jYhd+OJkJEEKrig/IsyRzAx+0v1w0q3BGNAn748+
        EStl1JSPIak4UOL6VYg2WlJ0/d3uW6ZKsR9DA8M1YnuNLDKpREq6yzzA1xpoIawELXdU1M
        CqfEZGNU0Dpurwz7wo3NDWC1eGZFIMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641917292;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LBycJvGkEqMVbJWzLuLrTIrZNv/mO/AlmiwshVaO16E=;
        b=l+7ZnDzP7hyPqOQi4fQl6bVIvtokyNojD0w1rVR49nffsq2pVxBLBSWg0ywLv0IMo7n58F
        JZSGJaa1eXqVMwAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AB7EFA3B81;
        Tue, 11 Jan 2022 16:08:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A882ADA7A9; Tue, 11 Jan 2022 17:07:39 +0100 (CET)
Date:   Tue, 11 Jan 2022 17:07:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Juan =?iso-8859-1?Q?Sim=F3n?= <decedion@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: 48 seconds to mount a BTRFS hard disk drive seems too long to me
Message-ID: <20220111160739.GR14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chris Murphy <lists@colorremedies.com>,
        Juan =?iso-8859-1?Q?Sim=F3n?= <decedion@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAMQzBqCSzr4UO1VFTjtSDPt+0ukhf6yqK=q+eLA+Tp1hiB_weA@mail.gmail.com>
 <CAJCQCtR_oogvxKozaMM8UUiW2kKxFUnc+1cqTuwT12ZBOTDFgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJCQCtR_oogvxKozaMM8UUiW2kKxFUnc+1cqTuwT12ZBOTDFgQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 06, 2022 at 12:58:58PM -0700, Chris Murphy wrote:
> On Thu, Jan 6, 2022 at 8:48 AM Juan Simón <decedion@gmail.com> wrote:
> >
> > Hard disk: 16TB SEAGATE IRONWOLF PRO 3.5", 7200 RPM 256MB CACHE
> > Arch Linux
> > Linux juan-PC 5.15.13-xanmod1-tt-1 #1 SMP Thu, 06 Jan 2022 12:14:06
> > +0000 x86_64 GNU/Linux
> > btrfs-progs v5.15.1
> >
> > $ btrfs fi df /multimedia
> > Data, single: total=10.89TiB, used=10.72TiB
> > System, DUP: total=8.00MiB, used=1.58MiB
> > Metadata, DUP: total=15.00GiB, used=13.19GiB
> > GlobalReserve, single: total=512.00MiB, used=0.00B
> >
> > I have formatted it as BTRFS and the mounting options (fstab) are:
> >
> > /multimedia     btrfs
> > rw,noatime,autodefrag,compress-force=zstd,nossd,space_cache=v2    0 0
> >
> > The disk works fine, I have not detected any problems but every time I
> > reboot the system takes a long time due to the mounting of this drive
> >
> > $ systemd-analyze blame
> > 48.575s multimedia.mount
> > ....
> >
> > I find it too long to mount a drive, is this normal, is it because of
> > one of the mounting options, or because of the size of the hard drive?
> 
> I think it's due to reading all the block group items which are buried
> in the extent tree. And on large file systems with a large extent
> tree, it results in a lot of random IO reads, so on spinning drives
> you get a ton of latency hits for this search.
> 
> This thread discusses some of the details as it relates to zoned
> devices, which have even longer mount times I guess. But the comments
> about block groups and extent tree apply the same to non-zoned.
> https://lore.kernel.org/linux-btrfs/CAHQ7scVGPAwEGQOq3Kmn75GJzyzSQ9qrBBZrHFu+4YWQhGE0Lw@mail.gmail.com/

That's unrelated to the problem on zoned drives, the delay there is
caused by time spent on reading the zone information.
