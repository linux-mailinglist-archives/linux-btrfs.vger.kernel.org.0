Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493E56C11D3
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Mar 2023 13:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjCTMYb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 08:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCTMY3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 08:24:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B819F4237
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 05:24:25 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A687468C4E; Mon, 20 Mar 2023 13:24:20 +0100 (CET)
Date:   Mon, 20 Mar 2023 13:24:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/10] btrfs: use a plain workqueue for ordered_extent
 processing
Message-ID: <20230320122420.GA9008@lst.de>
References: <20230314165910.373347-1-hch@lst.de> <20230314165910.373347-2-hch@lst.de> <c797c695-cd20-9ab6-7b12-19e43ab1069c@gmx.com> <65e3dc23-6e86-dc4d-0a1b-2ec69060dd44@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65e3dc23-6e86-dc4d-0a1b-2ec69060dd44@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 20, 2023 at 07:35:45PM +0800, Qu Wenruo wrote:
> In fact, I believe we not only need to add workqueue_set_max_active() for 
> the thread_pool= mount option, but also add a test case for thread_pool=1 
> to shake out all the possible hidden bugs...
>
> Mind me to send a patch adding the max_active setting for all plain 
> workqueues?

I don't think blindly doing that is a good idea.  As explained in my
reply to Dave, going all the way back to 2014, all workqueues hat had
a less than default treshold never used it to start with.

I'm also really curious (and I might have to do some digging) what
the intended use case is, and if it actually works as-is.  I know
one of your workloads mentioned a higher concurrency for some HDD
workloads, do you still remember what the workloads are?  Because
I'm pretty sure it won't be needed for all workqueues, and the fact
that btrfs is the only caller of workqueue_set_max_active in the
entire kernel makes me very sceptical that we do need it everywhere.

So I'd be much happier to figure out where we needed it first, but even
if not and we want to restore historic behavior from some point in the
past we'd still only need to apply it selectively.
