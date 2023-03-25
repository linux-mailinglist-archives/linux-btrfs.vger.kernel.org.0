Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CE56C8C5C
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Mar 2023 09:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjCYINr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Mar 2023 04:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCYINr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Mar 2023 04:13:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B2BE1AE
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Mar 2023 01:13:46 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 034F168AA6; Sat, 25 Mar 2023 09:13:42 +0100 (CET)
Date:   Sat, 25 Mar 2023 09:13:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@meta.com>
Cc:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 03/10] btrfs: offload all write I/O completions to a
 workqueue
Message-ID: <20230325081341.GB7353@lst.de>
References: <2aa047a7-984e-8f6f-163e-8fe6d12a41d8@gmx.com> <20230320123059.GB9008@lst.de> <d4514dd9-875a-59a1-e7c8-3831b1474ed8@gmx.com> <20230321125550.GB10470@lst.de> <5eebb0fc-0be3-c313-27cd-4e11a7b04405@gmx.com> <20230322083258.GA23315@lst.de> <ff18e85e-061d-084d-d835-aa7b23a54f1a@meta.com> <20230324010959.GB12152@lst.de> <14e253bb-8530-af11-7395-9e4148249c54@meta.com> <eb544c31-7a74-d503-83f0-4dc226917d1a@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb544c31-7a74-d503-83f0-4dc226917d1a@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 24, 2023 at 03:20:47PM -0400, Chris Mason wrote:
> I asked Jens to run some numbers on his fast drives (thanks Jens!).  He
> did 1M buffered writes w/fio.
> 
> Unpatched Linus:
> 
> write: IOPS=3316, BW=3316MiB/s (3477MB/s)(200GiB/61757msec); 0 zone resets
> 
> Jens said there was a lot of variation during the run going down as low
> as 1100MB/s.
> 
> Synchronous crcs:
> 
> write: IOPS=4882, BW=4882MiB/s (5119MB/s)(200GiB/41948msec); 0 zone resets
> 
> The synchronous run had about the same peak write speed but much lower
> dips, and fewer kworkers churning around.

FYI, I did some similar runs on this just with kvm on consumer drives,
and the results were similar.  Interestingly enough I first accidentally
ran with the non-accelerated crc32 code, as kvm by default doesn't
pass through cpu flags.  Even with that the workqueue offload only
looked better for really large writes, and then only marginally.
