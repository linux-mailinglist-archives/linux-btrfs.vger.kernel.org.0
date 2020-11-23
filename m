Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51862C0F29
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Nov 2020 16:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbgKWPlW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Nov 2020 10:41:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:44024 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729496AbgKWPlV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Nov 2020 10:41:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4C82ADC5;
        Mon, 23 Nov 2020 15:41:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8549DDA818; Mon, 23 Nov 2020 16:39:31 +0100 (CET)
Date:   Mon, 23 Nov 2020 16:39:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        josef@toxicpanda.com
Subject: Re: [PATCH] btrfs: tree-checker: annotate all error branches as
 unlikely
Message-ID: <20201123153931.GB8669@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        josef@toxicpanda.com
References: <20201120161023.5033-1-dsterba@suse.com>
 <76e69b7d-ce38-47ff-82f0-4b18d8305f56@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76e69b7d-ce38-47ff-82f0-4b18d8305f56@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 21, 2020 at 08:44:17AM +0800, Qu Wenruo wrote:
> On 2020/11/21 上午12:10, David Sterba wrote:
> > The tree checker is called many times as it verifies metadata at
> > read/write time. The checks follow a simple pattern:
> > 
> >   if (error_condition) {
> > 	  report_error();
> > 	  return -EUCLEAN;
> >   }
> > 
> > All the error reporting functions are annotated as __cold that is
> > supposed to hint the compiler to move the statement block out of the hot
> > path. This does not seem to happen that often.
> > 
> > As the error condition is expected to be false almost always, we can
> > annotate it with 'unlikely' as this satisfies one of the few use cases
> > for the annotation. The expected outcome is a stronger hint to compiler
> > to reorder the checks
> > 
> >   test
> >   jump to exit
> >   test
> >   jump to exit
> >   ...
> > 
> > which can be observed in asm of eg. check_dir_item,
> > btrfs_check_chunk_valid, check_root_item or check_leaf.
> > 
> > There's a measurable run time improvement reported by Josef, the testing
> > workload went from 655 MiB/s to 677 MiB/s, which is about +3%.
> > 
> > There should be no functional changes but some of the conditions have
> > been rewritten to produce more readable result, some lines are longer
> > than 80, for the sake of readability.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> 
> The patch itself is pretty awesome, but still some questionable
> likely/unlikely branches, comment inlined below.
> > ---
> > 
> > Josef, would be good if you can add some details about the workload and
> > hw, I'll update the changelog. Thanks.
> > 
> ...
> > @@ -181,10 +182,10 @@ static bool check_prev_ino(struct extent_buffer *leaf,
> >  	 * Only subvolume trees along with their reloc trees need this check.
> >  	 * Things like log tree doesn't follow this ino requirement.
> >  	 */
> > -	if (!is_fstree(btrfs_header_owner(leaf)))
> > +	if (likely(!is_fstree(btrfs_header_owner(leaf))))
> >  		return true;
> 
> This likely() is questionable.
> 
> Although the biggest metadata user of btrfs is mostly csum tree, one can
> still argue that for  fs with mostly inlined extents, fs trees can be
> more common.
> 
> >  
> > -	if (key->objectid == prev_key->objectid)
> > +	if (likely(key->objectid == prev_key->objectid))
> >  		return true;
> 
> This is also questionable, this is completely dependent on fs content.
> 
> Thus we should only use likely/unlikely on the return value of
> check_prev_ino(), but not inside it.

Right after the two checks there's the error case:

 184         if (!is_fstree(btrfs_header_owner(leaf)))
 185                 return true;
 186
 187         if (key->objectid == prev_key->objectid)
 188                 return true;
 189
 191         dir_item_err(leaf, slot,

so the likely/likely annotation emulates unlikely on the dir_item_err
call. But thinking about it again, you're right that we don't need it
inisde check_prev_ino, the checks already follow the check/jump pattern
and there's not much space for reordering in that function. I'll drop
them.
