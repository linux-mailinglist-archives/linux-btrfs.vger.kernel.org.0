Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC15E2DE62C
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 16:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgLRPFo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 10:05:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:52990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbgLRPFn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 10:05:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7DE64AD09;
        Fri, 18 Dec 2020 15:05:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0F5DBDA806; Fri, 18 Dec 2020 16:03:21 +0100 (CET)
Date:   Fri, 18 Dec 2020 16:03:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/6] btrfs: Remove useless ASSERTS
Message-ID: <20201218150321.GY6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201207153237.1073887-1-nborisov@suse.com>
 <20201207153237.1073887-4-nborisov@suse.com>
 <20201215165857.GX6430@twin.jikos.cz>
 <a2f46694-e2f8-3601-c45c-6b714b9bf1d6@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2f46694-e2f8-3601-c45c-6b714b9bf1d6@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 15, 2020 at 07:48:18PM +0200, Nikolay Borisov wrote:
> 
> 
> On 15.12.20 г. 18:58 ч., David Sterba wrote:
> > On Mon, Dec 07, 2020 at 05:32:34PM +0200, Nikolay Borisov wrote:
> >> The invariants the asserts are checking are already verified by the
> >> tree checker, just remove them.
> > 
> > I haven't found where exactly does tree-checker verify the invariant and
> > also think that we can safely leave the asserts there. Even if it's for
> > a normally impossible case, assertions usually catch bugs after changing
> > some other code.
> > 
> 
>    2         if (unlikely((key->objectid < BTRFS_                                           
>      1                       key->objectid > BTRFS_ #define BTRFS_ROOT_TREE_DIR_OBJECTID 6ULL 
>   402                       key->objectid != BTRFS_ROOT_TREE_DIR_OBJECTID &&           
>      1                      key->objectid != BTRFS_FREE_INO_OBJECTID)) { 
> 
> 
> in check_inode_key. We verify that for every inode its objectid is
> within range, transitively

Ah so it's only indirectly implied.

> this assures highest_objectid is also
> within range. But If you want to leave it - I'm fine with it. 

Tree checker verifies that any inode that is read has the object id
within the bounds, that's fine. The highest free objectid is obtained
by doing reverse search, without reading (and checking) any existing
inode.

btrfs_init_root_free_objectid checks only object ids in the tree, not
necessarily inodes (though technically we use the objectids only for
inode-like items).

Things can be improved by doing proper checks inside
btrfs_init_root_free_objectid and drop the asserts, I can imagine a
crafted image that would trigger the asserts so we'd better handle that.
