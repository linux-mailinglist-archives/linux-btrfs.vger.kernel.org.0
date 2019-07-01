Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2EE65C057
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2019 17:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfGAPfN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jul 2019 11:35:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:47760 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727208AbfGAPfN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jul 2019 11:35:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE378AFFB;
        Mon,  1 Jul 2019 15:35:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2B0C0DA840; Mon,  1 Jul 2019 17:35:57 +0200 (CEST)
Date:   Mon, 1 Jul 2019 17:35:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Btrfs: factor out extent dropping code from hole
 punch handler
Message-ID: <20190701153557.GK20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20190627170031.6191-1-fdmanana@kernel.org>
 <c1bc797b-096e-1d9b-7222-86b0a2e70a64@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1bc797b-096e-1d9b-7222-86b0a2e70a64@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 28, 2019 at 08:32:15AM +0300, Nikolay Borisov wrote:
> 
> 
> On 27.06.19 г. 20:00 ч., fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > Move the code that is responsible for dropping extents in a range out of
> > btrfs_punch_hole() into a new helper function, btrfs_punch_hole_range(),
> > so that later it can be used by the reflinking (extent cloning and dedup)
> > code to fix a ENOSPC bug.
> > 
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/file.c | 308 ++++++++++++++++++++++++++++++--------------------------
> >  1 file changed, 166 insertions(+), 142 deletions(-)
> > 
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 1c7533db16b0..393a6d23b6b0 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -2448,27 +2448,171 @@ static int btrfs_punch_hole_lock_range(struct inode *inode,
> >  	return 0;
> >  }
> >  
> > +/*
> > + * The respective range must have been previously locked, as well as the inode.
> > + * The end offset is inclusive (last byte of the range).
> > + */
> > +static int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
> > +				  const u64 start, const u64 end,
> > +				  struct btrfs_trans_handle **trans_out)
> 
> I'm not a big fan of the way a lower function starts a transaction which
> is then passed to the caller. So while it fixes a real bug in the next
> patch it isn't really pushing the code in the right direction. I see
> that this transaction is bound to whether no_hole is enabled or not so
> it's not just a matter of lifting it up to the caller. And there's also
> the while loop which commits it and starts a new one. So yeah, it
> doesn't seem like there's a significantly better way of doing that now
> but IMO we need to think of cleaning that up later.

I agree with the point about starting the transaction from the lower
function, and also don't see a better way to do it right now. Oh well.
