Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39B152BC4E
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 16:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbiERMs6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 08:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237452AbiERMse (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 08:48:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEAD175682
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 05:48:23 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 04A2E68E10; Wed, 18 May 2022 14:48:16 +0200 (CEST)
Date:   Wed, 18 May 2022 14:48:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 12/15] btrfs: add new read repair infrastructure
Message-ID: <20220518124815.GA24176@lst.de>
References: <20220517145039.3202184-1-hch@lst.de> <20220517145039.3202184-13-hch@lst.de> <e2c4e54c-548b-2221-3bf7-31f6c14a03ee@gmx.com> <20220518085409.GG6933@lst.de> <779bd017-ad7c-10d0-0943-9c0080c55795@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <779bd017-ad7c-10d0-0943-9c0080c55795@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 18, 2022 at 06:20:53PM +0800, Qu Wenruo wrote:
> My bad, I see the bio_alloc_bioset() but didn't check it's allocating a
> bi_io_vec with size 0, and soon utilize the original bi_io_vec.
>
> So the function matches its name, it's really bio clone.
>
> And it's very different from my version, which really allocates a new
> bio with larger enough bi_io_vec then adding back the needed sectors
> from the original bio.
>
> Then I guess the BIO_CLONE flag is completely fine.
>
> But in that case, you may want to call bio_alloc_clone() directly? Which
> can handle bioset without problem.

The big difference is that bio_alloc_clone directly looks at
bio->bi_iter, while we must look at btrfs_bio->iter as bio->bi_iter
may already be consumed by the driver.  I though the comment in the
code explains that, but maybe I need to improve it.
