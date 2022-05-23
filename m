Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE02530A31
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 May 2022 10:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiEWHWc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 May 2022 03:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiEWHVL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 May 2022 03:21:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA74C23A413
        for <linux-btrfs@vger.kernel.org>; Mon, 23 May 2022 00:12:49 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1002168AFE; Mon, 23 May 2022 08:26:36 +0200 (CEST)
Date:   Mon, 23 May 2022 08:26:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 8/8] btrfs: use btrfs_bio_for_each_sector in
 btrfs_check_read_dio_bio
Message-ID: <20220523062636.GA29750@lst.de>
References: <20220522114754.173685-1-hch@lst.de> <20220522114754.173685-9-hch@lst.de> <d3065bfe-c7ae-5182-84de-17101afbd39e@gmx.com> <20220522123108.GA23355@lst.de> <d7a1e588-7b2b-e85e-c204-a711d54ecc7c@gmx.com> <20220522125337.GB24032@lst.de> <8a6fb996-64c3-63b3-7f9c-aec78e83504e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a6fb996-64c3-63b3-7f9c-aec78e83504e@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 23, 2022 at 08:07:01AM +0800, Qu Wenruo wrote:
>
> I checked the code, but still find the code in patch "btrfs: add new
> read repair infrastructure" not that instinctive.
>
> - Why we bother different repair methods in btrfs_repair_one_mirror()?
>   In fact btrfs_repair_io_failure() can handle all profiles.

Becasue btrfs_repair_io_failure can't handle multiple-page I/O.  It
is also is rather cumbersome because it bypassed the normal bio
mapping.  As a follow on I'd rather move it over to btrfs_map_bio
with a special flag for the single mirror parity write rather than that
hack.

>   Then why we go back to write the whole bio?

Because the whole bio at this point is all the bad sectors.  There
is no point in writing only parts of the bio because that would leave
corruption on disk.

>   The only reason I can think of is, we're still trying to do some
>   "optimization".
>
>   But all our bio submission is already synchronous, I doubt such
>   "optimization" would make much difference.

Can you explain what you mean here?

>
> - The bio truncation
>   This really looks like a bandage to address the checker pattern
>   corruption.
>   I doubt why not just do per-sector read/write like:

Because now you wait for each I/O.

> To me, the "optimization" of batched read/write is only relevant if we
> have tons of corrupted sectors in a read bio, which I don't believe is a
> hot path in real world anyway.

It is is very easy low hanging fruit, and actually pretty common for
actual failures of components.  In other words:  single sector failures
happen some times, usually due to corruption on the transfer wire.  If
actual corruption happens on the driver it will usually fail quite
bit areas.  These are rather rare these days as a lot of device shut
down before returning bad data, but if it happens you'll rarely see
just a single sector.
