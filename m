Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33FF6C3215
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 13:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjCUMzz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 08:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjCUMzy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 08:55:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44B2206A4
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 05:55:53 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5642868AFE; Tue, 21 Mar 2023 13:55:50 +0100 (CET)
Date:   Tue, 21 Mar 2023 13:55:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/10] btrfs: offload all write I/O completions to a
 workqueue
Message-ID: <20230321125550.GB10470@lst.de>
References: <20230314165910.373347-1-hch@lst.de> <20230314165910.373347-4-hch@lst.de> <2aa047a7-984e-8f6f-163e-8fe6d12a41d8@gmx.com> <20230320123059.GB9008@lst.de> <d4514dd9-875a-59a1-e7c8-3831b1474ed8@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4514dd9-875a-59a1-e7c8-3831b1474ed8@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 21, 2023 at 07:37:46AM +0800, Qu Wenruo wrote:
>> I think it is stalled.  That's why the workqueue heavily discourages
>> limiting max_active unless you have a good reason to, and most callers
>> follow that advise.
>
> To me, this looks more like hiding a bug in the workqueue user.
> Shouldn't we expose such bugs instead of hiding them?

If you limit max_active to a certain value, you clearly tell the
workqueue code not not use more workers that that.  That is what the
argument is for.

I don't see where there is a bug, and that someone is hiding it.

> Furthermore although I'm a big fan of plain workqueue, the old btrfs 
> workqueues allows us to apply max_active to the plain workqueues, but now 
> we don't have this ability any more.

You can pass max_active to plain Linux workqueues and there is a bunch
of places that do that, although the vast majority passes either 0 to
use the default, or 1 to limit themselves to a single active worker.

The core also allows to change it, but nothing but the btrfs_workqueue
code ever does.  We can wire up btrfs to change the conccurency if we
have a good reason to do.  And I'd like to figure out if there is one,
and if yes for which workqueue, but for that we'd need to have an
argument for why which workqueue would like to use a larger or smaller
than default value.  The old argument of higher resource usage with
a bigger number of workers does not apply any more with the concurrency
managed workqueue implementation.

>>> Personally speaking, I'd like to keep the btrfs bio endio function calls in
>>> the old soft/hard irq context, and let the higher layer to queue the work.
>>
>> Can you explain why?
>
> Just to keep the context consistent.

Which is what this series does.  Before all read I/O completion handlers
were called in workqueue context, while write ones weren't.  With the
series write completion handlers are called from workqueue context
as well, and with that all significant btrfs code except for tiny bits
of bi_end_io handlers are called from process context.

> Image a situation, where we put some sleep functions into a endio function 
> without any doubt, and fully rely on the fact the endio function is 
> executed under workqueue context.

Being able to do that is the point of this series.
