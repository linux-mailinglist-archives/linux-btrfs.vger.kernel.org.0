Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C23A6C6163
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 09:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjCWIMu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 04:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjCWIMt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 04:12:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB46123669
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 01:12:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1964068AA6; Thu, 23 Mar 2023 09:12:38 +0100 (CET)
Date:   Thu, 23 Mar 2023 09:12:37 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/10] btrfs: offload all write I/O completions to a
 workqueue
Message-ID: <20230323081237.GA21669@lst.de>
References: <20230314165910.373347-1-hch@lst.de> <20230314165910.373347-4-hch@lst.de> <2aa047a7-984e-8f6f-163e-8fe6d12a41d8@gmx.com> <20230320123059.GB9008@lst.de> <d4514dd9-875a-59a1-e7c8-3831b1474ed8@gmx.com> <20230321125550.GB10470@lst.de> <5eebb0fc-0be3-c313-27cd-4e11a7b04405@gmx.com> <20230322083258.GA23315@lst.de> <bbcb7c0b-42e7-4480-abec-5ffe13ec7255@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbcb7c0b-42e7-4480-abec-5ffe13ec7255@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 23, 2023 at 04:07:28PM +0800, Qu Wenruo wrote:
>>> And if a work load can only be deadlock free using the default max_active,
>>> but not any value smaller, then I'd say the work load itself is buggy.
>>
>> Anything that has an interaction between two instances of a work_struct
>> can deadlock.  Only a single execution context is guaranteed (and even
>> that only with WQ_MEM_RECLAIM), and we've seen plenty of deadlocks due
>> to e.g. only using a global workqueue in file systems or block devices
>> that can stack.
>
> Shouldn't we avoid such cross workqueue workload at all cost?

Yes, btrfs uses per-sb workqueues.  As do most other places now,
but there as a bit of a learning curve years ago.

>> So this is the first time I see an actual explanation, thanks for that
>> first.  If this is the reason we should apply the max_active to all
>> workqueus that do csum an compression work, but not to other random
>> workqueues.
>
> If we're limiting the max_active for certain workqueues, then I'd say why 
> not to all workqueues?
>
> If we have some usage relying on the amount of workers, at least we should 
> be able to expose it and fix it.

Again, btrfs is the odd one out allowing the user to set arbitrary limits.
This code predates using the kernel workqueues, and I'm a little
doubtful it still is useful.  But for that I need to figure out why
it was even be kept when converting btrfs to use workqueues.

> (IIRC we should have a better way with less cross-workqueue dependency)

I've been very actively working on reducing the amount of different
workqueues.  This series is an important part of that.

