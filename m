Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77C2AEE900
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 20:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfKDTxq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 14:53:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:47334 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728346AbfKDTxq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Nov 2019 14:53:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 09E9EB048;
        Mon,  4 Nov 2019 19:53:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 67D9BDB6FC; Mon,  4 Nov 2019 20:53:52 +0100 (CET)
Date:   Mon, 4 Nov 2019 20:53:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu WenRuo <wqu@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v3 2/3] btrfs: block-group: Refactor
 btrfs_read_block_groups()
Message-ID: <20191104195352.GE3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu WenRuo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Anand Jain <anand.jain@oracle.com>
References: <20191010023928.24586-1-wqu@suse.com>
 <20191010023928.24586-3-wqu@suse.com>
 <c1f08098-5f90-70c5-6554-9a9cf33e87be@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1f08098-5f90-70c5-6554-9a9cf33e87be@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 30, 2019 at 04:59:17AM +0000, Qu WenRuo wrote:
> 
> 
> On 2019/10/10 上午10:39, Qu Wenruo wrote:
> > Refactor the work inside the loop of btrfs_read_block_groups() into one
> > separate function, read_one_block_group().
> > 
> > This allows read_one_block_group to be reused for later BG_TREE feature.
> > 
> > The refactor does the following extra fix:
> > - Use btrfs_fs_incompat() to replace open-coded feature check
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> > Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> Hi David,
> 
> Mind to add this patch to for-next branch?
> 
> Considering the recent changes to struct btrfs_block_group_cache, there
> is some considerable conflicts.

I see, as the patch is idependent I'll add it.

> It would be much easier to solve them sooner than later.
> If needed I could send a newer version based on latest for-next branch.

I've fixed the conflicts, but please have a look anyway. The change was
cache->item to local block group item and rename of found_key to key in
read_one_block_group.
