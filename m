Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EA22A2DEE
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 16:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKBPRb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 10:17:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:50058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgKBPRa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 10:17:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 31C00ACA3;
        Mon,  2 Nov 2020 15:17:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 10A72DA7D2; Mon,  2 Nov 2020 16:15:52 +0100 (CET)
Date:   Mon, 2 Nov 2020 16:15:51 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/10] btrfs: use precalculated sectorsize_bits from
 fs_info
Message-ID: <20201102151551.GE6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1603981452.git.dsterba@suse.com>
 <b38721840b8d703a29807b71460464134b9ca7e1.1603981453.git.dsterba@suse.com>
 <5d586f76-7cad-b7be-60d3-44c8d3b67623@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d586f76-7cad-b7be-60d3-44c8d3b67623@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 02, 2020 at 10:05:54PM +0800, Qu Wenruo wrote:
> On 2020/10/29 下午10:27, David Sterba wrote:
> > We do a lot of calculations where we divide or multiply by sectorsize.
> > We also know and make sure that sectorsize is a power of two, so this
> > means all divisions can be turned to shifts and avoid eg. expensive
> > u64/u32 divisions.
> > 
> > The type is u32 as it's more register friendly on x86_64 compared to u8
> > and the resulting assembly is smaller (movzbl vs movl).
> > 
> > There's also superblock s_blocksize_bits but it's usually one more
> > pointer dereference farther than fs_info.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >  fs/btrfs/ctree.h           |  1 +
> >  fs/btrfs/disk-io.c         |  2 ++
> >  fs/btrfs/extent-tree.c     |  2 +-
> >  fs/btrfs/file-item.c       | 11 ++++++-----
> >  fs/btrfs/free-space-tree.c | 12 +++++++-----
> >  fs/btrfs/ordered-data.c    |  3 +--
> >  fs/btrfs/scrub.c           | 12 ++++++------
> >  fs/btrfs/tree-checker.c    |  3 ++-
> >  8 files changed, 26 insertions(+), 20 deletions(-)
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 8a83bce3225c..87c40cc5c42e 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -931,6 +931,7 @@ struct btrfs_fs_info {
> >  	/* Cached block sizes */
> >  	u32 nodesize;
> >  	u32 sectorsize;
> > +	u32 sectorsize_bits;
> 
> For the bit shift, it can alwasy be contained in one u8.
> Since one u32 is only to be at most 32 bits, it can be easily contained
> in u8 whose max value is 255.
> 
> This should allow us to pack several u8 together to reduce some memory
> usage.

As mentioned in the changelog, u32 generates slightly better assembly.
The size increase is minimal compared to overall fs_info size so I'd
become worried once we have a lot of u32 in place of u8 that would span
more cachelines than necessary. Reorganizing fs_info for better
cacheline access patterns would be interesting but at the moment we
leave it up to the CPU.
