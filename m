Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D1C3991ED
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jun 2021 19:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhFBRvK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Jun 2021 13:51:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47650 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhFBRvJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Jun 2021 13:51:09 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A8E10219CD;
        Wed,  2 Jun 2021 17:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622656165;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PdZRwuiC3MXgcKNePosjh3oOK9j7G1SQylokS6ipO1I=;
        b=GXGjs+c61NwK+kL5x5E8K6uXMV+h5LRtIkoXfYAPPW0cygVxdO12WsoDDUJJMwXLPt9O/r
        l0kE0WAdFvXzMm6rqWknGtczyp4+AHmg90zL458RbuJK+cjxAPZToYcO6Lgvr6EuXPqUO7
        8UsdoeMkqQRncZfFW1uHO7CMxmrf0G0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622656165;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PdZRwuiC3MXgcKNePosjh3oOK9j7G1SQylokS6ipO1I=;
        b=3uSqZ7sxGLb4i1eHkDjLFlHRuUJgOAIeKjDeaflSDHBGnghBDbgF2BzTmmwNPtPGe+8aY9
        2RuPryngrIhlMqBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A2D25A3B8A;
        Wed,  2 Jun 2021 17:49:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3507ADA880; Wed,  2 Jun 2021 19:10:11 +0200 (CEST)
Date:   Wed, 2 Jun 2021 19:10:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH v4 29/30] btrfs: fix a subpage relocation data corruption
Message-ID: <20210602171011.GQ31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
References: <20210531085106.259490-1-wqu@suse.com>
 <20210531085106.259490-30-wqu@suse.com>
 <ae84347a-12f5-3513-6a46-5c34dfdc4062@suse.com>
 <d8f635f9-7d85-5c18-6436-ec3d3773ee9a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8f635f9-7d85-5c18-6436-ec3d3773ee9a@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 01, 2021 at 09:07:46AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/5/31 下午6:26, Qu Wenruo wrote:
> > 
> > 
> > On 2021/5/31 下午4:51, Qu Wenruo wrote:
> >> [BUG]
> >> When using the following script, btrfs will report data corruption after
> >> one data balance with subpage support:
> >>
> >>    mkfs.btrfs -f -s 4k $dev
> >>    mount $dev -o nospace_cache $mnt
> >>    $fsstress -w -n 8 -s 1620948986 -d $mnt/ -v > /tmp/fsstress
> >>    sync
> >>    btrfs balance start -d $mnt
> >>    btrfs scrub start -B $mnt
> >>
> >> Similar problem can be easily observed in btrfs/028 test case, there
> >> will be tons of balance failure with -EIO.
> >>
> >> [CAUSE]
> >> Above fsstress will result the following data extents layout in extent
> >> tree:
> >>          item 10 key (13631488 EXTENT_ITEM 98304) itemoff 15889 
> >> itemsize 82
> >>                  refs 2 gen 7 flags DATA
> >>                  extent data backref root FS_TREE objectid 259 offset 
> >> 1339392 count 1
> >>                  extent data backref root FS_TREE objectid 259 offset 
> >> 647168 count 1
> >>          item 11 key (13631488 BLOCK_GROUP_ITEM 8388608) itemoff 15865 
> >> itemsize 24
> >>                  block group used 102400 chunk_objectid 256 flags DATA
> >>          item 12 key (13733888 EXTENT_ITEM 4096) itemoff 15812 
> >> itemsize 53
> >>                  refs 1 gen 7 flags DATA
> >>                  extent data backref root FS_TREE objectid 259 offset 
> >> 729088 count 1
> >>
> >> Then when creating the data reloc inode, the data reloc inode will look
> >> like this:
> >>
> >>     0    32K    64K    96K 100K    104K
> >>     |<------ Extent A ----->|   |<- Ext B ->|
> >>
> >> Then when we first try to relocate extent A, we setup the data reloc
> >> inode with iszie 96K, then read both page [0, 64K) and page [64K, 128K).
> >>
> >> For page 64K, since the isize is just 96K, we fill range [96K, 128K)
> >> with 0 and set it uptodate.
> >>
> >> Then when we come to extent B, we update isize to 104K, then try to read
> >> page [64K, 128K).
> >> Then we find the page is already uptodate, so we skip the read.
> >> But range [96K, 128K) is filled with 0, not the real data.
> >>
> >> Then we writeback the data reloc inode to disk, with 0 filling range
> >> [96K, 128K), corrupting the content of extent B.
> >>
> >> The behavior is caused by the fact that we still do full page read for
> >> subpage case.
> >>
> >> The bug won't really happen for regular sectorsize, as one page only
> >> contains one sector.
> >>
> >> [FIX]
> >> This patch will fix the problem by invalidating range [isize, PAGE_END]
> >> in prealloc_file_extent_cluster().
> > 
> > The fix is enough to fix the data corruption, but it leaves a very rare 
> > deadlock.
> > 
> > Above invalidating is in fact not safe, since we're not doing a proper 
> > btrfs_invalidatepage().
> > 
> > The biggest problem here is, we can leave the page half dirty, and half 
> > out-of-date.
> > 
> > Then later btrfs_readpage() can trigger a deadlock like this:
> > btrfs_readpage()
> > |  We already have the page locked.
> > |
> > |- btrfs_lock_and_flush_ordered_range()
> >     |- btrfs_start_ordered_extent()
> >        |- extent_write_cache_pages()
> >           |- pagevec_lookup_range_tag()
> >           |- lock_page()
> >              We try to lock a page which is already locked by ourselves.
> > 
> > This can only happen for subpage case, and normally it should never 
> > happen for regular subpage opeartions.
> > As we either read the full the page, then update part of the page to 
> > dirty, dirty the full page without reading it.
> > 
> > This shortcut in relocation code breaks the assumption, and could lead 
> > to above deadlock.
> > 
> > Although I still don't like to call btrfs_invalidatepage(), here we can 
> > workaround the half-dirty-half-out-of-date problem by just writing the 
> > page back to disk.
> > 
> > This will clear the page dirty bits, and allow later clear_uptodate() 
> > call to be safe.
> > 
> > I'll update the patchset in github repo first, and hope to merge it with 
> > other feedback into next update.
> > 
> > Currently the test looks very promising, as the Power8 VM has survived 
> > over 100 loops without crashing.
> 
> The extra diff will look like this before invalidating extent and page 
> status.
> 
> +               /*
> +                * Btrfs subpage can't handle page with DIRTY but without
> +                * UPTODATE bit as it can lead to the following deadlock:
> +                * btrfs_readpage()
> +                * | Page already *locked*
> +                * |- btrfs_lock_and_flush_ordered_range()
> +                *    |- btrfs_start_ordered_extent()
> +                *       |- extent_write_cache_pages()
> +                *          |- lock_page()
> +                *             We try to lock the page we already hold.
> +                *
> +                * Here we just writeback the whole data reloc inode, so 
> that
> +                * we will be ensured to have no dirty range in the 
> page, and
> +                * are safe to clear the uptodate bits.
> +                *
> +                * This shouldn't cause too much overhead, as we need to 
> write
> +                * the data back anyway.
> +                */
> +               ret = filemap_write_and_wait(mapping);
> +               if (ret < 0)
> +                       return ret;
> +
> 
> One special reason for using filemap_write_and_wait() for the whole data 
> reloc inode is, we can't just write back one page, as for data reloc 
> inode we have to writeback the whole cluster boundary, to meet the 
> extent size.
> 
> So far it survives the full night tests, and the overhead should be minimal.
> As we have to writeback the whole data reloc inode anyway.
> And we are here because either previous cluster is not continuous with 
> current one, or we have reached the cluster size limit.
> 
> Either way, writing back the whole inode would bring no extra overhead.

I've updated the patch from github. I've also updated isize to i_size so
it's more like the struct inode->i_size.
