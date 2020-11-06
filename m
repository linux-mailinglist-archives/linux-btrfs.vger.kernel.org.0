Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622012A9D4D
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 20:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgKFTFa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 14:05:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:46860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727765AbgKFTF2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Nov 2020 14:05:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DFDABAF28;
        Fri,  6 Nov 2020 19:05:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 87272DA6E3; Fri,  6 Nov 2020 20:03:47 +0100 (CET)
Date:   Fri, 6 Nov 2020 20:03:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 12/32] btrfs: disk-io: extract the extent buffer
 verification from btrfs_validate_metadata_buffer()
Message-ID: <20201106190346.GT6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-13-wqu@suse.com>
 <15477e44-e15d-9b8b-634a-d300d3c82d84@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15477e44-e15d-9b8b-634a-d300d3c82d84@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 05, 2020 at 03:57:14PM +0200, Nikolay Borisov wrote:
> > +int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio, u64 phy_offset,
> > +				   struct page *page, u64 start, u64 end,
> > +				   int mirror)
> > +{
> > +	struct extent_buffer *eb;
> > +	int ret = 0;
> > +	int reads_done;
> > +
> > +	if (!page->private)
> > +		goto out;
> > +
> 
> nit:I think this is redundant since metadata pages always have their eb
> attached at ->private.

We could have an assert here instead.

> > +	eb = (struct extent_buffer *)page->private;
> 
> If the above check is removed then this line can be moved right next to
> eb's definition.
> 
> <snip>
