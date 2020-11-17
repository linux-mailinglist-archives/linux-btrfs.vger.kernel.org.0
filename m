Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D479F2B5588
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Nov 2020 01:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbgKQAHA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 19:07:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:34404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730776AbgKQAHA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 19:07:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5471BAD2D;
        Tue, 17 Nov 2020 00:06:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 214F1DA6E3; Tue, 17 Nov 2020 01:05:13 +0100 (CET)
Date:   Tue, 17 Nov 2020 01:05:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, wqu@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: tree-checker: missing returns after data_ref
 alignment checks
Message-ID: <20201117000512.GV6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        wqu@suse.com, linux-btrfs@vger.kernel.org
References: <20201116190113.GT6756@twin.jikos.cz>
 <3f687422-bacf-40cd-bfef-bafb771ac913@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f687422-bacf-40cd-bfef-bafb771ac913@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 17, 2020 at 07:45:25AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/11/17 上午3:01, David Sterba wrote:
> > Hi Qu,
> > 
> > I've found more missing return satetments in tree-checker but I'm not
> > sure if leaving them out was intentional. Both are for extent data_ref
> > item alignment checks. It could be that alignment is not a hard problem,
> > tough it could point to one, there's a check of the hash vs key->offset
> > that would catch inconsistent data.
> 
> All my bad.
> 
> The case is, alignment is the first sign of corruption.
> So if alignment is incorrect, there is no need to continue.
> 
> So yeah, I forgot more return lines.
> > 
> > As there's only one statement after if, this looks like it was
> > forgotten, but otherwise needs a comment why the returns are not there
> > given that the rest of the file follows the same pattern
> > "if / extent_err/ return -EUCLEAN".
> > 
> > ---
> >  fs/btrfs/tree-checker.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> > index 1b27242a9c0b..f3f666b343ef 100644
> > --- a/fs/btrfs/tree-checker.c
> > +++ b/fs/btrfs/tree-checker.c
> > @@ -1424,6 +1424,7 @@ static int check_extent_data_ref(struct extent_buffer *leaf,
> >  	"invalid item size, have %u expect aligned to %zu for key type %u",
> >  			    btrfs_item_size_nr(leaf, slot),
> >  			    sizeof(*dref), key->type);
> > +		return -EUCLEAN;
> 
> For EXTENT_DATA_REF_KEY, it should only contains one or more
> btrfs_extent_data_ref, thus the alignment is a hard requirement.
> 
> Thus the return is needed.
> >  	}
> >  	if (!IS_ALIGNED(key->objectid, leaf->fs_info->sectorsize)) {
> >  		generic_err(leaf, slot,
> > @@ -1452,6 +1453,7 @@ static int check_extent_data_ref(struct extent_buffer *leaf,
> >  			extent_err(leaf, slot,
> >  	"invalid extent data backref offset, have %llu expect aligned to %u",
> >  				   offset, leaf->fs_info->sectorsize);
> > +			return -EUCLEAN;
> 
> Basic sector size alignment requirement.
> So yet another missing return.

Thanks, I'll resend it as a proper patch.
