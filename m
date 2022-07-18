Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79283578261
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 14:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbiGRMdK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 08:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiGRMdJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 08:33:09 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D2A205F7
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 05:33:08 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 96F6C68AA6; Mon, 18 Jul 2022 14:33:04 +0200 (CEST)
Date:   Mon, 18 Jul 2022 14:33:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: error writing primary super block on zoned btrfs
Message-ID: <20220718123304.GA15340@lst.de>
References: <20220718054944.GA22359@lst.de> <YtVSBLTuRCED9mYb@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtVSBLTuRCED9mYb@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 18, 2022 at 01:28:52PM +0100, Matthew Wilcox wrote:
> A "value" entry in the block device's i_pages will be a shadow entry --
> that is, the page has reached the end of the LRU list and been discarded,
> so we made a note that we would have liked to keep it in the LRU list,
> but we didn't have enough memory in the system to do so.  That helps
> us put it back in the right position in the LRU list when it gets
> brought back in from disc.
> 
> I'd sugegst something else has gone wrong, maybe the refcount should
> have been kept elevated to prevent the superblock from being paged out.
> I find it hard to believe that we can be so low on memory that we need
> to page out a superblock to make room for some other memory allocation.
> 
> (Although maybe if you have millions of unusued filesystems mounted ...?)

This is a freshly booted VM running the test on the only non-root
disk file system.  So yeah, there must be a logic error somewhere
in the use of the page cache.
