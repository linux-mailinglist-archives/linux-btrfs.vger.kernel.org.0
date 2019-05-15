Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE041F91B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2019 19:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfEORGY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 May 2019 13:06:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:45204 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbfEORGY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 May 2019 13:06:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB7ACAD7F
        for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2019 17:06:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 038EDDA8E5; Wed, 15 May 2019 19:07:20 +0200 (CEST)
Date:   Wed, 15 May 2019 19:07:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        fdmanana@suse.com
Subject: Re: [PATCH] btrfs: fiemap: preallocate ulists for btrfs_check_shared
Message-ID: <20190515170718.GV3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        fdmanana@suse.com
References: <20190515133104.1364-1-dsterba@suse.com>
 <aa32ffbf-256f-e988-3fb1-f440f18d6909@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa32ffbf-256f-e988-3fb1-f440f18d6909@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 15, 2019 at 04:45:42PM +0300, Nikolay Borisov wrote:
> 
> 
> On 15.05.19 г. 16:31 ч., David Sterba wrote:
> > btrfs_check_shared looks up parents of a given extent and uses ulists
> > for that. These are allocated and freed repeatedly. Preallocation in the
> > caller will avoid the overhead and also allow us to use the GFP_KERNEL
> > as it is happens before the extent locks are taken.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> 
> Looks good, one minor nit worth considering below, otherwise:
> 
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> 
> > ---
> >  fs/btrfs/backref.c   | 17 ++++++-----------
> >  fs/btrfs/backref.h   |  3 ++-
> >  fs/btrfs/extent_io.c | 15 +++++++++++++--
> >  3 files changed, 21 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> > index 982152d3f920..89116afda7a2 100644
> > --- a/fs/btrfs/backref.c
> > +++ b/fs/btrfs/backref.c
> > @@ -1465,12 +1465,11 @@ int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
> >   *
> >   * Return: 0 if extent is not shared, 1 if it is shared, < 0 on error.
> >   */
> > -int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr)
> > +int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
> > +		struct ulist *roots, struct ulist *tmp)
> >  {
> >  	struct btrfs_fs_info *fs_info = root->fs_info;
> >  	struct btrfs_trans_handle *trans;
> > -	struct ulist *tmp = NULL;
> > -	struct ulist *roots = NULL;
> >  	struct ulist_iterator uiter;
> >  	struct ulist_node *node;
> >  	struct seq_list elem = SEQ_LIST_INIT(elem);
> > @@ -1481,12 +1480,8 @@ int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr)
> >  		.share_count = 0,
> >  	};
> >  
> > -	tmp = ulist_alloc(GFP_NOFS);
> > -	roots = ulist_alloc(GFP_NOFS);
> > -	if (!tmp || !roots) {
> > -		ret = -ENOMEM;
> > -		goto out;
> > -	}
> > +	ulist_init(roots);
> > +	ulist_init(tmp);
> >  
> >  	trans = btrfs_attach_transaction(root);
> >  	if (IS_ERR(trans)) {
> > @@ -1527,8 +1522,8 @@ int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr)
> >  		up_read(&fs_info->commit_root_sem);
> >  	}
> >  out:
> > -	ulist_free(tmp);
> > -	ulist_free(roots);
> > +	ulist_release(roots);
> > +	ulist_release(tmp);
> 
> nit: If we turn these into ulist_reinit there is no need to do ulit_init
> at the beginning. Having said that, the only difference between
> ulist_release/init is that the latter also does ulist->nnode=0 (apart
> form the memory freeing). So ulist_release can really boil down to:
> 
> list_for_each_entry_safe() {
> kfree}
> ulist_init(ulist)

I think I had the _reinit at the end in one of the versions, but then it
looked more clear with the explicit _init at the beginning of the
function so that it does not rely on the caller to initialize.
