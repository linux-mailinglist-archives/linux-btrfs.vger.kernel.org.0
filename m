Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0606C74E2
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 02:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCXBKF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 21:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjCXBKD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 21:10:03 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3606AD39
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 18:10:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4AC4A68B05; Fri, 24 Mar 2023 02:09:59 +0100 (CET)
Date:   Fri, 24 Mar 2023 02:09:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@meta.com>
Cc:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/10] btrfs: offload all write I/O completions to a
 workqueue
Message-ID: <20230324010959.GB12152@lst.de>
References: <20230314165910.373347-1-hch@lst.de> <20230314165910.373347-4-hch@lst.de> <2aa047a7-984e-8f6f-163e-8fe6d12a41d8@gmx.com> <20230320123059.GB9008@lst.de> <d4514dd9-875a-59a1-e7c8-3831b1474ed8@gmx.com> <20230321125550.GB10470@lst.de> <5eebb0fc-0be3-c313-27cd-4e11a7b04405@gmx.com> <20230322083258.GA23315@lst.de> <ff18e85e-061d-084d-d835-aa7b23a54f1a@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff18e85e-061d-084d-d835-aa7b23a54f1a@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 23, 2023 at 10:53:16AM -0400, Chris Mason wrote:
> The original reason for limiting the number of workers was that work
> like crc calculations was causing tons of context switches.  This isn't
> a surprise, there were a ton of work items, and each one was processed
> very quickly.

Yeah.  Although quite a bit of that went away since, by not doing
the offload for sync I/O, not for metadata when there is a fast crc32
implementation (we need to do the same for small data I/O and hardware
accelerated sha256, btw), and by doing these in larger chunks, but ..

> 
> So the original btrfs thread pools had optimizations meant to limit
> context switches by preferring to give work to a smaller number of workers.

.. this is something that the workqueue code already does under the hood
anyway.

> For compression it's more clear cut.  I wanted the ability to saturate
> all the CPUs with compression work, but also wanted a default that
> didn't take over the whole machine.

And that's actually a very good use case.

It almost asks for a separate option just for compression, or at least
for compression and checksumming only.

Is there consensus that for now we should limit thread_pool for 
se workqueues that do compression and chekcsumming for now?  Then
I'll send a series to wire it up for the read completion workqueue
again that does the checksum verification, the compressed write
workqueue, but drop it for all others but the write submission
one?
