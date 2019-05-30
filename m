Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D6D2FC8B
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2019 15:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfE3Nml (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 May 2019 09:42:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:39326 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbfE3Nmk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 May 2019 09:42:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF194ABF0;
        Thu, 30 May 2019 13:42:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BE525DA85E; Thu, 30 May 2019 15:43:33 +0200 (CEST)
Date:   Thu, 30 May 2019 15:43:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tree-checker: Check if the file extent end
 overflow
Message-ID: <20190530134333.GF15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190503003054.9346-1-wqu@suse.com>
 <20190530120253.GC15290@twin.jikos.cz>
 <10c517e9-7a70-4c98-6c7c-290bc5540170@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10c517e9-7a70-4c98-6c7c-290bc5540170@gmx.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 30, 2019 at 08:03:48PM +0800, Qu Wenruo wrote:
> >> @@ -112,6 +112,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
> >>  	struct btrfs_file_extent_item *fi;
> >>  	u32 sectorsize = fs_info->sectorsize;
> >>  	u32 item_size = btrfs_item_size_nr(leaf, slot);
> >> +	u64 extent_end;
> >>  
> >>  	if (!IS_ALIGNED(key->offset, sectorsize)) {
> >>  		file_extent_err(leaf, slot,
> >> @@ -186,6 +187,14 @@ static int check_extent_data_item(struct extent_buffer *leaf,
> >>  	    CHECK_FE_ALIGNED(leaf, slot, fi, offset, sectorsize) ||
> >>  	    CHECK_FE_ALIGNED(leaf, slot, fi, num_bytes, sectorsize))
> >>  		return -EUCLEAN;
> >> +	/* Catch extent end overflow case */
> >> +	if (check_add_overflow(btrfs_file_extent_num_bytes(leaf, fi),
> >> +			       key->offset, &extent_end)) {
> >> +		file_extent_err(leaf, slot,
> >> +	"extent end overflow, have file offset %llu extent num bytes %llu",
> >> +				key->offset,
> >> +				btrfs_file_extent_num_bytes(leaf, fi));
> > 
> > Isn't this missing
> > 
> > 		return -EUCLEAN;
> 
> Oh, my bad.
> 
> Would you mind to fold that return line?

Udated and added to misc-next.
