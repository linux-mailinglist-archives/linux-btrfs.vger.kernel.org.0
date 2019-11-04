Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB046EEB53
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 22:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbfKDVoS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 16:44:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:45474 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728409AbfKDVoS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Nov 2019 16:44:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EDFDDB3EA;
        Mon,  4 Nov 2019 21:44:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4C4CBDB6FC; Mon,  4 Nov 2019 22:44:24 +0100 (CET)
Date:   Mon, 4 Nov 2019 22:44:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu WenRuo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v3 2/3] btrfs: block-group: Refactor
 btrfs_read_block_groups()
Message-ID: <20191104214424.GH3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu WenRuo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Anand Jain <anand.jain@oracle.com>
References: <20191010023928.24586-1-wqu@suse.com>
 <20191010023928.24586-3-wqu@suse.com>
 <c1f08098-5f90-70c5-6554-9a9cf33e87be@suse.com>
 <20191104195352.GE3001@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191104195352.GE3001@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 04, 2019 at 08:53:52PM +0100, David Sterba wrote:
> On Wed, Oct 30, 2019 at 04:59:17AM +0000, Qu WenRuo wrote:
> > 
> > 
> > On 2019/10/10 上午10:39, Qu Wenruo wrote:
> > > Refactor the work inside the loop of btrfs_read_block_groups() into one
> > > separate function, read_one_block_group().
> > > 
> > > This allows read_one_block_group to be reused for later BG_TREE feature.
> > > 
> > > The refactor does the following extra fix:
> > > - Use btrfs_fs_incompat() to replace open-coded feature check
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> > > Reviewed-by: Anand Jain <anand.jain@oracle.com>
> > 
> > Hi David,
> > 
> > Mind to add this patch to for-next branch?
> > 
> > Considering the recent changes to struct btrfs_block_group_cache, there
> > is some considerable conflicts.
> 
> I see, as the patch is idependent I'll add it.
> 
> > It would be much easier to solve them sooner than later.
> > If needed I could send a newer version based on latest for-next branch.
> 
> I've fixed the conflicts, but please have a look anyway. The change was
> cache->item to local block group item and rename of found_key to key in
> read_one_block_group.

And it crashes during the self-tests, the patch is in branch
misc-next-with-bg-refactoring in my github tree, please have a look.
I've removed it from misc-next for now as I need to test for-next, but
it's probably going to be some trivial typo so the patch will be added
once it's found. Thanks.
