Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF87397A58
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jun 2021 21:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbhFATDE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Jun 2021 15:03:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57044 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbhFATDE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Jun 2021 15:03:04 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7266A1FD4C;
        Tue,  1 Jun 2021 19:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622574081;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rLrfsn8EIvXw5/xSSRO19/jKLe9Oalp8brBJMttIfpI=;
        b=xm9veW6mDelsbtZmpnlrkNwRs33zjLTbc5E/kYXb9ZEZ0A3ENxVWgaVXpslV7PTzkkJ0/C
        cdNN4gBX8vOirXce9T7rHwW0y/3v1WK8HxTPmeoLnaP3TA4DpUrv88hCSv6MY90kwiO6+D
        2CR5rNtcO7wTpiYSk9hmpACYU75P5XE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622574081;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rLrfsn8EIvXw5/xSSRO19/jKLe9Oalp8brBJMttIfpI=;
        b=40KKlVXS9YSNDhebKEvp2XoOm8125kYKT9VhO6Lo6dGKECZ+QJjjUt6/rLjBMxQ6/JEujk
        xRQCcYz71PLIw4Aw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7244DA3B81;
        Tue,  1 Jun 2021 19:01:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 75D3EDA734; Tue,  1 Jun 2021 20:58:40 +0200 (CEST)
Date:   Tue, 1 Jun 2021 20:58:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: limit ordered extent to zoned append size
Message-ID: <20210601185840.GK31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <65f1b716324a06c5cad99f2737a8669899d4569f.1621588229.git.johannes.thumshirn@wdc.com>
 <20210531185826.GF31483@twin.jikos.cz>
 <PH0PR04MB741628EB9F56A1B5843FA3B69B3E9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB741628EB9F56A1B5843FA3B69B3E9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 01, 2021 at 07:44:29AM +0000, Johannes Thumshirn wrote:
> On 31/05/2021 21:01, David Sterba wrote:
> > On Fri, May 21, 2021 at 06:11:04PM +0900, Johannes Thumshirn wrote:
> >> --- a/fs/btrfs/extent_io.c
> >> +++ b/fs/btrfs/extent_io.c
> >> @@ -1860,6 +1860,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
> >>  				    u64 *end)
> >>  {
> >>  	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
> >> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> >>  	u64 max_bytes = BTRFS_MAX_EXTENT_SIZE;
> >>  	u64 delalloc_start;
> >>  	u64 delalloc_end;
> >> @@ -1868,6 +1869,9 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
> >>  	int ret;
> >>  	int loops = 0;
> >>  
> >> +	if (fs_info && fs_info->max_zone_append_size)
> > 
> > Do you really need to check for a valid fs_info? It's derived from an
> > inode so it must be valid or something is seriously wrong.
> 
> I thought it was because some selftest tripped over a NULL pointer, but it looks 
> very much like cargo cult. I'll recheck.

Ah right, self tests have some exceptions regarding fsinfo though IIRC
ther's always some but maybe not fully setup or with some artifical
nodesize etc to test the structures that are just in memory.

I'd rather not pull selftets-specific code so if it really crashed in
tests then let's please fix the tests.
