Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEFE10D6CE
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2019 15:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfK2OS3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Nov 2019 09:18:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:45198 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726608AbfK2OS3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Nov 2019 09:18:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E484CB2AF;
        Fri, 29 Nov 2019 14:18:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B7C4ADA7D9; Fri, 29 Nov 2019 15:18:23 +0100 (CET)
Date:   Fri, 29 Nov 2019 15:18:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Opencode ordered_data_tree_panic
Message-ID: <20191129141822.GL2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191129093813.574-1-nborisov@suse.com>
 <d310c88f-547a-a5db-09a7-74d8a22957c1@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d310c88f-547a-a5db-09a7-74d8a22957c1@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 29, 2019 at 11:49:23AM +0200, Nikolay Borisov wrote:
> 
> 
> On 29.11.19 г. 11:38 ч., Nikolay Borisov wrote:
> > It's a simple wrapper over btrfs_panic and is called only once. Just
> > open code it.
> > 
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> > ---
> >  fs/btrfs/extent-tree.c  |  5 +----
> >  fs/btrfs/ordered-data.c | 10 +---------
> >  2 files changed, 2 insertions(+), 13 deletions(-)
> > 
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index f68b38f44f0b..ab99ec6e188b 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -4172,11 +4172,8 @@ int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
> >  	struct btrfs_block_group *cache;
> >  
> >  	cache = btrfs_lookup_block_group(fs_info, start);
> > -	if (!cache) {
> > -		btrfs_err(fs_info, "Unable to find block group for %llu",
> > -			  start);
> > +	if (!cache)
> >  		return -ENOSPC;
> > -	}
> >  
> >  	btrfs_add_free_space(cache, start, len);
> >  	btrfs_free_reserved_bytes(cache, len, delalloc);
> 
> Grrr this hunk should be dropped.... Shall I resend ?

No, i'll drop it
