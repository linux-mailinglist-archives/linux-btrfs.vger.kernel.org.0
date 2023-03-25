Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776D66C8C7F
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Mar 2023 09:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjCYIQ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Mar 2023 04:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjCYIQp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Mar 2023 04:16:45 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3146815CAD
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Mar 2023 01:16:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F39D768AA6; Sat, 25 Mar 2023 09:15:15 +0100 (CET)
Date:   Sat, 25 Mar 2023 09:15:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@meta.com>
Cc:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/10] btrfs: offload all write I/O completions to a
 workqueue
Message-ID: <20230325081515.GC7353@lst.de>
References: <20230314165910.373347-4-hch@lst.de> <2aa047a7-984e-8f6f-163e-8fe6d12a41d8@gmx.com> <20230320123059.GB9008@lst.de> <d4514dd9-875a-59a1-e7c8-3831b1474ed8@gmx.com> <20230321125550.GB10470@lst.de> <5eebb0fc-0be3-c313-27cd-4e11a7b04405@gmx.com> <20230322083258.GA23315@lst.de> <ff18e85e-061d-084d-d835-aa7b23a54f1a@meta.com> <20230324010959.GB12152@lst.de> <14e253bb-8530-af11-7395-9e4148249c54@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14e253bb-8530-af11-7395-9e4148249c54@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 24, 2023 at 09:25:07AM -0400, Chris Mason wrote:
> As you mentioned above, we're currently doing synchronous crcs for
> metadata when BTRFS_FS_CSUM_IMPL_FAST, and for synchronous writes.
> We've benchmarked this a few times and I think with modern hardware a
> better default is just always doing synchronous crcs for data too.
> 
> Qu or David have you looked synchronous data crcs recently?

As mentioend in the other mail I have a bit.  But only for crc32
so far, and only on x86, so the matrix might be a little more
complicated.

> My preference would be:
> 
> - crcs are always inline if your hardware is fast
> - Compression, encryption, slow hardware crcs use the thread_pool_size knob
> - We don't try to limit the other workers
> 
> The idea behind the knob is just "how much of your CPU should each btrfs
> mount consume?"  Obviously we'll silently judge anyone that chooses less
> than 100% but I guess it's good to give people options.

Ok.  I'll do a series about the nobs ASAP, and then the inline CRCs
next.
