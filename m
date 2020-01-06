Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2EA6131770
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 19:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgAFSXt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 13:23:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:52908 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbgAFSXt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 13:23:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 52F97AEEE;
        Mon,  6 Jan 2020 18:23:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7A539DA78B; Mon,  6 Jan 2020 19:23:37 +0100 (CET)
Date:   Mon, 6 Jan 2020 19:23:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: fixes for relocation to avoid KASAN reports
Message-ID: <20200106182336.GS3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191211050004.18414-1-wqu@suse.com>
 <20191211153429.GO3929@twin.jikos.cz>
 <74a07fa4-ca35-57ee-2cd9-586a8db04712@gmx.com>
 <20200103155259.GA3929@twin.jikos.cz>
 <20200103161556.GB3929@twin.jikos.cz>
 <159ae5f2-92fd-dd71-8c6b-eac018e2faf0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <159ae5f2-92fd-dd71-8c6b-eac018e2faf0@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 06, 2020 at 03:04:32PM +0800, Qu Wenruo wrote:
> On 2020/1/4 上午12:15, David Sterba wrote:
> > On Fri, Jan 03, 2020 at 04:52:59PM +0100, David Sterba wrote:
> >> So it's one bit vs refcount and a lock. For the backports I'd go with
> >> the bit, but this needs the barriers as mentioned in my previous reply.
> >> Can you please update the patches?
> > 
> > The idea is in the diff below (compile tested only). I found one more
> > case that was not addressed by your patches, it's in
> > btrfs_update_reloc_root.
> > 
> > Given that the type of the fix is the same, I'd rather do that in one
> > patch. The reported stack traces are more or less the same.
> > 
> > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > index af4dd49a71c7..aeba3a7506e1 100644
> > --- a/fs/btrfs/relocation.c
> > +++ b/fs/btrfs/relocation.c
> > @@ -517,6 +517,15 @@ static int update_backref_cache(struct btrfs_trans_handle *trans,
> >  	return 1;
> >  }
> >  
> > +static bool have_reloc_root(struct btrfs_root *root)
> > +{
> > +	smp_mb__before_atomic();
> 
> Mind to explain why the before_atomic() is needed?
> 
> Is it just paired with smp_mb__after_atomic() for the
> set_bit()/clear_bit() part?

Yes. The reading part of a barrier must flush any pending state, then
read it.

> >  	reloc_root = root->reloc_root;
> > @@ -1489,6 +1498,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
> >  	if (fs_info->reloc_ctl->merge_reloc_tree &&
> >  	    btrfs_root_refs(root_item) == 0) {
> >  		set_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
> > +		smp_mb__after_atomic();
> 
> I get the point here, to make sure all other users see this bit change.
> 
> >  		__del_reloc_root(reloc_root);
> 
> Interestingly in that function we immediately triggers spin_lock() which
> implies memory barrier.
> (Not an excuse to skip memory barrier anyway)

Beware that spin_lock and spin_unlock are only half barriers. Full
barrier is implied by unlock/lock sequence.

> 
> >  	}
> >  
> > @@ -2201,6 +2211,7 @@ static int clean_dirty_subvols(struct reloc_control *rc)
> >  				if (ret2 < 0 && !ret)
> >  					ret = ret2;
> >  			}
> > +			smp_mb__before_atomic();
> >  			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
> 
> I guess this should be a smp_mb__after_atomic();

No, we want everything that happens before the clear bit to be stored
before the bit is cleared. IOW cleared bit must not be seen before all
the previous updates are done.

> 
> >  			btrfs_put_fs_root(root);
> 
> And btrfs_put_fs_root() triggers a release memory ordering.

But it's too late.

> So it looks memory order is not completely screwed up before, completely
> by pure luck...

Well, no :)
