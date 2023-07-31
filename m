Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86258768D56
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 09:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjGaHLs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 03:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjGaHL3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 03:11:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53290210A
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 00:09:23 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1CAE967373; Mon, 31 Jul 2023 09:02:51 +0200 (CEST)
Date:   Mon, 31 Jul 2023 09:02:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Mason <clm@fb.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, josef@toxicpanda.com, hch@lst.de
Subject: Re: [PATCH RFC] Btrfs: only subtract from len_to_oe_boundary when
 it is tracking an extent
Message-ID: <20230731070251.GB31096@lst.de>
References: <20230730190226.4001117-1-clm@fb.com> <e6557f41-9c3c-628a-958d-057582f8cab9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6557f41-9c3c-628a-958d-057582f8cab9@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 31, 2023 at 10:27:02AM +0800, Qu Wenruo wrote:
> Personally speaking, I think we'd better moving the ordered extent based
> split (only for zoned devices) to btrfs bio layer.

That goes completely counter the direction I've been working to.  The
ordered extent is the "container" for writeback, so having a bio
that spawns them creates all kinds of problems.  Thats's the reason
why we now have a bbio->ordered pointer now.

> Another concern is, how we could hit a bio which has a size larger than
> U32_MAX?
>
> The bio->bi_iter.size is only unsigned int, it should never exceed U32_MAX.
>
> It would help a lot if you can provide a backtrace of such unaligned bio.

That's indeed a bit weird.

