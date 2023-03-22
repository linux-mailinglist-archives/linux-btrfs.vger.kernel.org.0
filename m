Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B8A6C44F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 09:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCVIdE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 04:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjCVIdC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 04:33:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1B9136E6
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 01:33:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5957E67373; Wed, 22 Mar 2023 09:32:58 +0100 (CET)
Date:   Wed, 22 Mar 2023 09:32:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/10] btrfs: offload all write I/O completions to a
 workqueue
Message-ID: <20230322083258.GA23315@lst.de>
References: <20230314165910.373347-1-hch@lst.de> <20230314165910.373347-4-hch@lst.de> <2aa047a7-984e-8f6f-163e-8fe6d12a41d8@gmx.com> <20230320123059.GB9008@lst.de> <d4514dd9-875a-59a1-e7c8-3831b1474ed8@gmx.com> <20230321125550.GB10470@lst.de> <5eebb0fc-0be3-c313-27cd-4e11a7b04405@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eebb0fc-0be3-c313-27cd-4e11a7b04405@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 22, 2023 at 07:37:07AM +0800, Qu Wenruo wrote:
>> If you limit max_active to a certain value, you clearly tell the
>> workqueue code not not use more workers that that.  That is what the
>> argument is for.
>
> And if a work load can only be deadlock free using the default max_active, 
> but not any value smaller, then I'd say the work load itself is buggy.

Anything that has an interaction between two instances of a work_struct
can deadlock.  Only a single execution context is guaranteed (and even
that only with WQ_MEM_RECLAIM), and we've seen plenty of deadlocks due
to e.g. only using a global workqueue in file systems or block devices
that can stack.

Fortunately these days lockdep is generally able to catch these
dependencies as well.

> The usecase is still there.
> To limit the amount of CPU time spent by btrfs workloads, from csum 
> verification to compression.

So this is the first time I see an actual explanation, thanks for that
first.  If this is the reason we should apply the max_active to all
workqueus that do csum an compression work, but not to other random
workqueues.

Dave, Josef, Chis: do you agree to this interpretation?
