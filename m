Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F5F578255
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 14:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiGRM27 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 08:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbiGRM25 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 08:28:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF79C2718
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 05:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9KMef1S9S1wYGKsHE+OIjRmvqXI5e6hbX2wz7L9SgiY=; b=e7dQbVV0FvQTGFnbifns+5bKe8
        oB0hTJWg3qDF2qYC00KMtGbCfgQ86VC6wuiJSidRESlOWFJDLfHd5N3VGIE0kRvL+6nM9c2r1vBEs
        AoXmBcQ5gvZTHP2CU8yt1CWu2qQFNp9rB3rbv/tqmbnWVy5oXgnLa6BSVOPQf0zPsw+7gDs11dNLT
        qfhOH9TddYksMeMWVkI7ULtgO9zneJayWl3MWTIJDIc3WzCv1ui2KjbLfOVatdd7P2+tn2OrQEqIf
        Bq/9YSJ6nwOpHlMjyU623MgYrdp1bnPhC1b0beYHo1k3w7FkR97mDVsx9KsQcZsoPTolo1wnF66Ry
        Dfhzr1ug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDPro-00Cg7A-BB; Mon, 18 Jul 2022 12:28:52 +0000
Date:   Mon, 18 Jul 2022 13:28:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: Re: error writing primary super block on zoned btrfs
Message-ID: <YtVSBLTuRCED9mYb@casper.infradead.org>
References: <20220718054944.GA22359@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718054944.GA22359@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 18, 2022 at 07:49:44AM +0200, Christoph Hellwig wrote:
> Hi Naohiro, (and willy for insights on the pagecache, see below),
> 
> when running plain fsx on zoned btrfs on a null_blk devices as below:
> 
> dev="/sys/kernel/config/nullb/nullb1"
> size=12800 # MB
> 
> mkdir ${dev}
> echo 2 > "${dev}"/submit_queues
> echo 2 > "${dev}"/queue_mode
> echo 2 > "${dev}"/irqmode
> echo "${size}" > "${dev}"/size
> echo 1 > "${dev}"/zoned
> echo 0 > "${dev}"/zone_nr_conv
> echo 128 > "${dev}"/zone_size
> echo 96 > "${dev}"/zone_capacity
> echo 14 > "${dev}"/zone_max_active
> echo 1 > "${dev}"/memory_backed
> echo 1000000 > "${dev}"/completion_nsec
> echo 1 > "${dev}"/power
> mkfs.btrfs -m single /dev/nullb1
> mount /dev/nullb1 /mnt/test/
> ~/xfstests-dev/ltp/fsx /mnt/test/foobar
> 
> fsx will eventually after ~10 minutes fail with the following left
> in dmesg:
> 
> [ 1185.480200] BTRFS error (device nullb1): error writing primary super block to device 1
> [ 1185.480988] BTRFS: error (device nullb1) in write_all_supers:4488: errno=-5 IO failure (1 errors while writing supers)
> [ 1185.481971] BTRFS info (device nullb1: state E): forced readonly
> [ 1185.482521] BTRFS: error (device nullb1: state EA) in btrfs_sync_log:3341: errno=-5 IO failure
> 
> I tracked this down to the find_get_page call in wait_dev_supers
> returning NULL, and digging furter it seems to come from
> xa_is_value() in __filemap_get_folio returnin true.  I'm not sure
> why we'd see a value here in the block device mapping and why that
> only happens in zoned mode (the same config on regular device ran
> for 10 hours last night).

A "value" entry in the block device's i_pages will be a shadow entry --
that is, the page has reached the end of the LRU list and been discarded,
so we made a note that we would have liked to keep it in the LRU list,
but we didn't have enough memory in the system to do so.  That helps
us put it back in the right position in the LRU list when it gets
brought back in from disc.

I'd sugegst something else has gone wrong, maybe the refcount should
have been kept elevated to prevent the superblock from being paged out.
I find it hard to believe that we can be so low on memory that we need
to page out a superblock to make room for some other memory allocation.

(Although maybe if you have millions of unusued filesystems mounted ...?)
