Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74C77255B9
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 09:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbjFGHb7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 03:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239094AbjFGHbe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 03:31:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95984211
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 00:27:17 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 29F776732D; Wed,  7 Jun 2023 09:27:13 +0200 (CEST)
Date:   Wed, 7 Jun 2023 09:27:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 15/16] btrfs: refactor the zoned device handling in
 cow_file_range
Message-ID: <20230607072712.GA24006@lst.de>
References: <20230531060505.468704-1-hch@lst.de> <20230531060505.468704-16-hch@lst.de> <d4csqyddmdeg2rlzonfsdusggur2anpi3gepwyvjnihbrcnfws@yiiytibnjfb2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4csqyddmdeg2rlzonfsdusggur2anpi3gepwyvjnihbrcnfws@yiiytibnjfb2>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 06, 2023 at 02:20:50PM +0000, Naohiro Aota wrote:
> > +			/*
> > +			 * For zoned devices, let the caller retry after writing
> > +			 * out the already allocated regions or waiting for a
> > +			 * zone to finish if no allocation was possible at all.
> > +			 *
> > +			 * Else convert to -ENOSPC since the caller cannot
> > +			 * retry.
> > +			 */
> > +			if (btrfs_is_zoned(fs_info)) {
> > +				if (start == orig_start)
> > +					return -EAGAIN;
> > +				*done_offset = start - 1;
> 
> This will hit a null pointer dereference when it is called from
> submit_uncompressed_range(). Well, that means we need to implement the
> partial writing also in submit_uncompressed_range().

I think we need to do that anyway, don't we?  As far as I can tell
submit_uncompressed_range is simply broken right now on zoned devices
if cow_file_range fails to allocate all blocks.

> BTW, we also need to handle -EAGAIN from btrfs_reserve_extent() in
> btrfs_new_extent_direct() as it currently returns -EAGAIN to the userland.

Indeed.

> >  			ASSERT(ret == 0);
> >  			return 0;
> >  		}
> > +		if (ret == -EAGAIN) {
> > +			ASSERT(btrfs_is_zoned(inode->root->fs_info));
> 
> Is this necessary? run_delalloc_zoned() should be called only for zoned
> mode anyway.

True.
