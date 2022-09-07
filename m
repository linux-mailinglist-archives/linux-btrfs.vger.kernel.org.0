Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754F25B028A
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 13:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiIGLLM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 07:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiIGLKp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 07:10:45 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908EE32AA6
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 04:10:24 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E832367373; Wed,  7 Sep 2022 13:10:09 +0200 (CEST)
Date:   Wed, 7 Sep 2022 13:10:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: code placement for bio / storage layer code
Message-ID: <20220907111009.GA8131@lst.de>
References: <20220901074216.1849941-1-hch@lst.de> <20220907091056.GA32007@lst.de> <382f747b-7ea3-f1a9-805f-0550ae90963e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <382f747b-7ea3-f1a9-805f-0550ae90963e@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 07, 2022 at 06:28:05PM +0800, Qu Wenruo wrote:
> To me, the old volumes should really only contain the chunk tree related
> code (read, add, delete a chunk), thus it may be better renamed to
> somethings like chunks.c?

I'll leave that question to folks who know that area of code much better.

> Then the storage layer code should be the lower level code mostly
> touching the bio.

For the initial version just doing the move, this would be

 - btrfs_submit_bio
 - btrfs_submit_mirrored_bio
 - btrfs_submit_dev_bio
 - btrfs_clone_write_end_io
 - btrfs_orig_write_end_io
 - btrfs_raid56_end_io
 - btrfs_simple_end_io
 - btrfs_end_bio_work
 - btrfs_end_io_wq
 - btrfs_log_dev_io_error
 - btrfs_bio_clone_partial
 - btrfs_bio_alloc
 - btrfs_bio_init
 - btrfs_bioset_init
 - btrfs_bioset_exit

> BTW, we may also want to extract a lot of code from extent_io.c to that
> new storage layer file.

Yes, this series moves a fair chunk to volumes.c that should go into
the new file instead, and there might be a few more bits.

> But I'm not sure if the bio.c is really the best name.
> What about storage.c?

I'm fine either way with a slight preference for bio.c.
