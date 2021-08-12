Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3812E3EA6DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 16:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbhHLOxk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 10:53:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57556 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238169AbhHLOxj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 10:53:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8FAC4221B2;
        Thu, 12 Aug 2021 14:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628779993;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z+TJG/0ohJ3C6qkMnV2I9iav+85UDvZLpGlbRFORorI=;
        b=L4QsEmnQ628VRQ/P/0RSDwjEt46NhEk1oZW/hWU1+o8FdAxmzdImFI/6tqYMgcBDnbT1nR
        Oh5FvWC+l2Si/yJKk9TBltkh/6qrBcoXJNsl2vYP9aY7SzECLF9KCHgMIZAvDb2donGW5Y
        wLOcUwCFATl7+OgSxFi/4PDmBP0p0a8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628779993;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z+TJG/0ohJ3C6qkMnV2I9iav+85UDvZLpGlbRFORorI=;
        b=RMaTbmZcm/bJo5ptvF9V6BOp8oSiJxPnsbe6ai+Dgq8BCcZPHZLT263cXWCu02oJpCKOKr
        Avm2wXsmzn42PaCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5C170A3F60;
        Thu, 12 Aug 2021 14:53:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4F1D4DA733; Thu, 12 Aug 2021 16:50:19 +0200 (CEST)
Date:   Thu, 12 Aug 2021 16:50:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: exclude relocation and page writeback
Message-ID: <20210812145017.GJ5047@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
References: <a858fb2ff980db27b3638e92f7d2d7a416b8e81e.1628776260.git.johannes.thumshirn@wdc.com>
 <20210812142558.GI5047@suse.cz>
 <PH0PR04MB7416785CF79EF72CCDCF931E9BF99@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416785CF79EF72CCDCF931E9BF99@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 12, 2021 at 02:40:59PM +0000, Johannes Thumshirn wrote:
> On 12/08/2021 16:28, David Sterba wrote:
> > That's a lot of new bytes for an inode, and just for zoned mode. Is
> > there another way how to synchronize that? Like some inode state bit and
> > then waiting on it, using the generic wait queues and API like
> > wait_var_event?
> 
> I can look into that yes.
> 
> Filipe originally suggested using the inode_lock() which would avoid the
> new mutex as well. I went away from using the inode_lock() mainly for 
> documentation purposes but I can call btrfs_inode_lock() from 
> btrfs_zoned_relocation_io_lock() as well.
> 
> I'll try implementing #1 and if that fails see if #2 is usable.
> 
> The longer alternative that Naohiro and Damien also suggested is avoiding
> zone append on relocation and running a block group that is a target for 
> relocation at QD=1 but that is way more intrusive and not a good candidate
> for stable IMHO.

The zoned mode still gets improved in each version so we might not limit
ourselves by backportability of the fix. 5.12 is not updated anymore and
that's the lowest version we care about regardind zoned mode.

We could perhaps have first "heavy" solution like the mutex backported
to 5.13/5.14 as that we'll probably use as testing base for some time.
In the long term I'd rather have something that looks lighter, but I
haven't analyzed the bug nor the solutions very closely so can't say
which one is the best.
