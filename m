Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B83C22EE2D
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jul 2020 16:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgG0ODo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 10:03:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:45660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgG0ODo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 10:03:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 101F6AB8B;
        Mon, 27 Jul 2020 14:03:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 80871DA701; Mon, 27 Jul 2020 16:03:14 +0200 (CEST)
Date:   Mon, 27 Jul 2020 16:03:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: fix root leak printk to use %lld instead of
 %llu
Message-ID: <20200727140314.GL3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200722160722.8641-1-josef@toxicpanda.com>
 <20200722160722.8641-2-josef@toxicpanda.com>
 <20200723142041.GD3703@twin.jikos.cz>
 <ce52445d-b104-252c-005f-9bc13b2141d7@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce52445d-b104-252c-005f-9bc13b2141d7@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 24, 2020 at 08:40:17AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/7/23 下午10:20, David Sterba wrote:
> > On Wed, Jul 22, 2020 at 12:07:22PM -0400, Josef Bacik wrote:
> >> I'm a actual human being so am incapable of converting u64 to s64 in my
> >> head, use %lld so we can see the negative number in order to identify
> >> which of our special roots we leaked.
> >>
> >> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >> ---
> >>  fs/btrfs/disk-io.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> >> index f1fdbdd44c02..cc4081a1c7f9 100644
> >> --- a/fs/btrfs/disk-io.c
> >> +++ b/fs/btrfs/disk-io.c
> >> @@ -1508,7 +1508,7 @@ void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info)
> >>  	while (!list_empty(&fs_info->allocated_roots)) {
> >>  		root = list_first_entry(&fs_info->allocated_roots,
> >>  					struct btrfs_root, leak_list);
> >> -		btrfs_err(fs_info, "leaked root %llu-%llu refcount %d",
> >> +		btrfs_err(fs_info, "leaked root %lld-%llu refcount %d",
> > 
> > But this is wrong in another way, roots with high numbers will appear as
> > negative numbers.
> > 
> 
> Nope. We won't have that many roots.
> 
> In fact, for subvolumes, the highest id is only 2 ^ 48, an special limit
> introduced for qgroup.

It's not a hard limit and certainly can have subvolumes with numbers
that high. That qgoups interpret the qgroup in some way is not a
limitation on subvolumes. We'll have to start reusing the subvolume ids
eventually, with qgroups we can on.

Also the negativer numbers start to appear with 2^32 so that's still
below the percieved limit of 2^48.

> So we won't have high enough subvolume ids to be negative, but only
> special trees.

For the internal trees we eg. have pretty-printer in progs so kernel can
reuse that.
