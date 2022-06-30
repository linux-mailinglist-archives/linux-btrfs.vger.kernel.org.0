Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B8A560FFC
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jun 2022 06:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiF3EYM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jun 2022 00:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiF3EYL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jun 2022 00:24:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9393D32EE1
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 21:24:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F2E3F68AA6; Thu, 30 Jun 2022 06:24:07 +0200 (CEST)
Date:   Thu, 30 Jun 2022 06:24:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Boris Burkov <boris@bur.io>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: fix repair of compressed extents
Message-ID: <20220630042407.GC4901@lst.de>
References: <20220623055338.3833616-1-hch@lst.de> <20220623055338.3833616-5-hch@lst.de> <YrzrvwOx8/Jgf2Co@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrzrvwOx8/Jgf2Co@zen>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 29, 2022 at 05:18:07PM -0700, Boris Burkov wrote:
> > @@ -3290,6 +3290,8 @@ void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
> >  			int mirror_num, enum btrfs_compression_type compress_type);
> >  int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
> >  			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
> 
> As far as I can tell, this is redundant with the last patch.

It is, this must have slipped in in the rebase.
