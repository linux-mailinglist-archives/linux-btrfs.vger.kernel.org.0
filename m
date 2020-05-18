Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60421D7C4A
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 May 2020 17:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgERPE1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 May 2020 11:04:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:54100 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbgERPE1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 May 2020 11:04:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0EDA3AF3F;
        Mon, 18 May 2020 15:04:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B7D8BDA7AD; Mon, 18 May 2020 17:03:31 +0200 (CEST)
Date:   Mon, 18 May 2020 17:03:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/3] btrfs: REF_COWS bit rework
Message-ID: <20200518150331.GU18421@twin.jikos.cz>
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

Looking at it futher, btrfs_get_fs_root does a few more things that does
not seem to be necessary for the data reloc tree.

The following two should be sufficient:

- btrfs_read_tree_root
- btrfs_init_fs_root

but with btrfs_get_fs_root there's an orphan item check and the data
reloc tree is added to fs_roots_radix.
