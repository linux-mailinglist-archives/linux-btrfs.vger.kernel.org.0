Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CC3768C7E
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 09:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjGaHAf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 03:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjGaHAe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 03:00:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED18C186
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 00:00:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2C6FB67373; Mon, 31 Jul 2023 09:00:27 +0200 (CEST)
Date:   Mon, 31 Jul 2023 09:00:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, hch@lst.de
Subject: Re: [PATCH RFC] Btrfs: only subtract from len_to_oe_boundary when
 it is tracking an extent
Message-ID: <20230731070025.GA31096@lst.de>
References: <20230730190226.4001117-1-clm@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730190226.4001117-1-clm@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 30, 2023 at 12:02:26PM -0700, Chris Mason wrote:
> [ This is an RFC because Christoph switched us to almost always set
> len_to_oe_boundary in a patch in for-next  I think we still need this
> commit for strange corners, but it's already pretty hard to hit reliably
> so I wanted to toss it out for discussion. We should consider either
> Christoph's "btrfs: limit write bios to a single ordered extent" or this
> commit for 6.4 stable as well ]

I'm torn.  On the one hand "btrfs: limit write bios to a single ordered
extent" is a pretty significant behavior change, on the other hand
stable-only patches with totally different behavior are always a bit
strange.

Note that with my entire pending queue, len_to_oe_boundary goes away
entirely, but with the current speed of patch application it might take
another 6 to 8 month to get there.

> This is hard to trigger because bio_add_page() isn't going to make a bio
> of U32_MAX size unless you give it a perfect set of pages and fully
> contiguous extents on disk.  We can hit it pretty reliably while making
> large swapfiles during provisioning because the machine is freshly
> booted, mostly idle, and the disk is freshly formatted.

It might be useful to create and xfstests for that, even if it only
hits on a freshly booted machine, although we'll need some reordering
in the xfstests sequence to make sure it gets run early..

