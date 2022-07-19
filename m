Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C0357A2B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 17:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbiGSPNv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 11:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238314AbiGSPNu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 11:13:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5995407E
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 08:13:49 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0231068AFE; Tue, 19 Jul 2022 17:13:45 +0200 (CEST)
Date:   Tue, 19 Jul 2022 17:13:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: error writing primary super block on zoned btrfs
Message-ID: <20220719151345.GA21932@lst.de>
References: <20220718054944.GA22359@lst.de> <YtVSBLTuRCED9mYb@casper.infradead.org> <PH0PR04MB74161E9598C27B8CEA10F53F9B8F9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB74161E9598C27B8CEA10F53F9B8F9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 19, 2022 at 07:53:45AM +0000, Johannes Thumshirn wrote:
> Ha but zoned btrfs uses two zones as a ringbuffer for its super-block, could
> it be, that we're accumulating too many page references somewhere? And then it
> behaves like having millions of filesystems mounted?

That fact the superblock moves for zoned devices probably has
something to do with it.  But the whole code leaves me really puzzling.

Why does wait_dev_supers even do a find_get_page vs just stashing
three page pointers away in the btrfs_device structure?

Why does this abuse wait_on_page_locked vs using a completion?

Why does the code count errors while only an error on the primary
superblock has any consequences?

What is the point of the secodary superblocks if they aren't written
on fsync?

How does just setting the whole page uptodat work on file systems
with a block size smaller than the page size where we don't know
what is in the rest of the page?
