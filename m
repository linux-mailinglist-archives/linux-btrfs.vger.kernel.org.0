Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B021D7BF9
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 May 2020 16:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgERO53 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 May 2020 10:57:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:50332 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbgERO52 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 May 2020 10:57:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 806F3ACB1;
        Mon, 18 May 2020 14:57:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2A6EADA7AD; Mon, 18 May 2020 16:56:34 +0200 (CEST)
Date:   Mon, 18 May 2020 16:56:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/3] btrfs: REF_COWS bit rework
Message-ID: <20200518145633.GT18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200515060142.23609-1-wqu@suse.com>
 <20200515194559.GR18421@twin.jikos.cz>
 <17637fb6-1b76-32bb-b6ab-468eda982c60@gmx.com>
 <d280611d-b4ea-7365-7775-520814368b26@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d280611d-b4ea-7365-7775-520814368b26@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 18, 2020 at 01:13:34PM +0800, Qu Wenruo wrote:
> >> [  119.624572] BTRFS info (device vdb): balance: start -d -m -s
> >> [  119.630843] BTRFS info (device vdb): relocating block group 30408704 flags metadata|dup
> >> [  119.640113] BTRFS critical (device vdb): corrupt leaf: root=18446744073709551607 block=298909696 slot=0, invalid key objectid: has 1 expect 6 or [256, 18446744073709551360] or 18446744073709551604
> >> [  119.647511] BTRFS info (device vdb): leaf 298909696 gen 11 total ptrs 4 free space 15851 owner 18446744073709551607
> >> [  119.652214] BTRFS info (device vdb): refs 3 lock (w:0 r:0 bw:0 br:0 sw:0 sr:0) lock_owner 0 current 19404
> >> [  119.656275] 	item 0 key (1 1 0) itemoff 16123 itemsize 160
> >> [  119.658436] 		inode generation 1 size 0 mode 100600
> > 
> > This is using 1 as ino number, which means root::highest_objectid is not
> > properly initialized.
> > 
> > This happened when I'm using btrfs_read_tree_root() other than
> > btrfs_read_fs_root(), which initializes root::highest_objectid.
> 
> After fetching the misc-next branch, that's exactly the problem.
> 
> The 3rd patch is using the correct btrfs_get_fs_root() which won't
> trigger the problem.

I see, thanks. That the data reloc tree does not fit into the pattern of
other trees being initialized in the function with btrfs_read_tree_root
needs to be documented then.
