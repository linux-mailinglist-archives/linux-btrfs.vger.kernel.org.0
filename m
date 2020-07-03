Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA16213A13
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 14:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgGCM3a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jul 2020 08:29:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:38528 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgGCM3a (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jul 2020 08:29:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 18980ACA0;
        Fri,  3 Jul 2020 12:29:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 559E0DA87C; Fri,  3 Jul 2020 14:29:11 +0200 (CEST)
Date:   Fri, 3 Jul 2020 14:29:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Greed Rong <greedrong@gmail.com>
Subject: Re: [PATCH 3/4] btrfs: preallocate anon_dev for subvolume and
 snapshot creation
Message-ID: <20200703122910.GZ27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Greed Rong <greedrong@gmail.com>
References: <20200616021737.44617-1-wqu@suse.com>
 <20200616021737.44617-4-wqu@suse.com>
 <20200616151004.GE27795@twin.jikos.cz>
 <f792151a-ebd5-2ac7-c9ac-0c274ea1ab8e@gmx.com>
 <20200701173928.GF27795@twin.jikos.cz>
 <0cfc15be-3a4a-c6d2-b294-eeb0a4506df4@gmx.com>
 <20200702160821.GT27795@twin.jikos.cz>
 <20200702234632.GU27795@twin.jikos.cz>
 <dce7628b-f182-783b-6f8f-da543bc5421b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dce7628b-f182-783b-6f8f-da543bc5421b@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 03, 2020 at 01:19:14PM +0800, Qu Wenruo wrote:
> >> In conclusion, your proposal is better and I'm going to merge it.
> >>
> >>> Although I would definitely remove the "__" prefix as we shouldn't add
> >>> such prefix anymore.
> >>
> >> Yeah with the small naming fixups.
> > 
> > It's in for-next-20200703. I've updated the changelogs to reflect what
> > we found during debugging the issue, the __ function renamed to
> > btrfs_get_root_ref and some function comments added. All patches
> > reordered and tagged for stable though the preallocation is not within
> > the size limit.
> > 
> 
> Thanks for the merge and dropping the unneeded check patch.
> 
> All the modification looks good to me.
> 
> Just a small nitpick for commit a561defc34aa ("btrfs: don't allocate
> anonymous block device for user invisible roots"), there is an
> unnecessary new line after "[CAUSE]".

Fixed, thanks for checking. I'm not entirely satisfied with the name of
btrfs_get_root_ref, as it could be confused with the on-disk
btrfs_root_ref. The get-ref functions could use some cleanup as
btrfs_get_fs_root is sometimes used for non-filesystem roots. Adding a
generic get_any_root that would accept any tree and btrfs_get_fs_root
would be only for subvolume roots or perhaps related trees like data
reloc. But this is not essential for the anon bdev fixes so that's for
later.
