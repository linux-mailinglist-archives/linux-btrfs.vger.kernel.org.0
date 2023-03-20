Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC256C0A3B
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Mar 2023 06:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCTFqL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 01:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCTFqI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 01:46:08 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C6918AB4
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Mar 2023 22:46:07 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F23C668AFE; Mon, 20 Mar 2023 06:46:01 +0100 (CET)
Date:   Mon, 20 Mar 2023 06:46:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 04/20] btrfs: always read the entire extent_buffer
Message-ID: <20230320054600.GA18708@lst.de>
References: <20230309090526.332550-1-hch@lst.de> <20230309090526.332550-5-hch@lst.de> <d2f3a67e-cd76-5d02-e7f1-9e7cab1a31ec@wdc.com> <20230317231609.GE10580@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317231609.GE10580@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 18, 2023 at 12:16:09AM +0100, David Sterba wrote:
> I remember one bug that was solved by splitting the first loop into two,
> one locking all pages first and then checking the uptodate status, the
> comment is explaining that.
> 
> 2571e739677f ("Btrfs: fix memory leak in reading btree blocks")
> 
> As you can see in the changelog it's a bit convoluted race, the number
> of loops should not matter if they're there for correctness reasons. I
> haven't checked the final code but I doubt it's equivalent and may
> introduce subtle bugs.

The patch we're replying to would have actually fixed that above
bug on it's own, and thus have also fixed the above issue.  The
problem it solves was that num_pages could be smaller than the
actual number of pages in the extent_buffer.  With this change,
we always read all pages and thus can't have a wrong ->io_pages.
In fact a later patch removes ->io_pages entirely.  Even better
at the end of the series the locking between different reads moves
to the extent_buffer level, so the above race is fundamentally
fixed at a higher level and there won't be an extra read at all.
