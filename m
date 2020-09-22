Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD712743D4
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 16:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgIVOHS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 10:07:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:40468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgIVOHS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 10:07:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CD028AC7D;
        Tue, 22 Sep 2020 14:07:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BB545DA6E9; Tue, 22 Sep 2020 16:06:01 +0200 (CEST)
Date:   Tue, 22 Sep 2020 16:06:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 14/19] btrfs: make btree inode io_tree has its special
 owner
Message-ID: <20200922140601.GZ6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-15-wqu@suse.com>
 <20200916160612.GO1791@twin.jikos.cz>
 <9ea58668-b6e5-6471-01fe-d4bf8ae8b310@suse.com>
 <20200917125031.GS1791@twin.jikos.cz>
 <08592bd0-0336-7170-3f3e-0d730d002aaa@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08592bd0-0336-7170-3f3e-0d730d002aaa@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 18, 2020 at 04:18:27PM +0800, Qu Wenruo wrote:
> >>> This looks like an independent patch, so it could be taken separately.
> >>>
> >> Errr, why?
> >>
> >> We added a new owner for btree inode io tree, and utilize that new owner
> >> in the same patch looks completely sane to me.
> >>
> >> Or did I miss something?
> > 
> > The IO_TREE_* ids are only for debugging and IO_TREE_INODE_IO is
> > supposed to be used for data inodes. But the btree_inode has that too,
> > which does not seem to follow the purpose of the tree id, you fix that
> > in this patch and it applies to current code too.
> > 
> Oh, I didn't see it as a fix. But your point still stands, and makes sense.
> 
> And this patch would be the base stone for later btree io tree specific
> re-mapping bits.
> So if this patch can be applied to current code, it would only be a good
> thing.

Thanks for confirming, I'll add it to misc-next.
