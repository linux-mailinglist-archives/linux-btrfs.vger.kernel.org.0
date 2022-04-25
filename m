Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4939050E6ED
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 19:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbiDYRUW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 13:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243926AbiDYRUL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 13:20:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B91928990
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 10:17:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CA21D68AFE; Mon, 25 Apr 2022 19:17:01 +0200 (CEST)
Date:   Mon, 25 Apr 2022 19:17:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/10] btrfs: split btrfs_submit_data_bio
Message-ID: <20220425171701.GA16295@lst.de>
References: <20220425075418.2192130-4-hch@lst.de> <62f71a43-8167-f29f-8e9f-d95bc6667e0e@gmx.com> <20220425091920.GC16446@lst.de> <458ba4e0-15f3-93e4-bc17-ae464bdf13e7@gmx.com> <20220425110928.GA24430@lst.de> <bade7fa8-d95b-e0e8-0af8-e40fec341789@gmx.com> <20220425111925.GA25233@lst.de> <af44fee8-deb9-a3e2-a04f-06dbcc16b6c0@gmx.com> <20220425113458.GA26412@lst.de> <9d6e5424-e872-7767-e1c7-6eb35d53250e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d6e5424-e872-7767-e1c7-6eb35d53250e@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 25, 2022 at 07:40:40PM +0800, Qu Wenruo wrote:
> That's only for RAID56, aren't you going to remove btrfs_bio usage 
> completely for all write (including buffered, non-compressing write)?

There are just two uses of bbio->iter in the current btrfs for-net
tree.  One is index_one_bio, which is removed by the patch I posted,
and the other one is btrfs_check_read_dio_bio, which is clearly read 
specific.

FYI, this is the next batch that's currently being tested:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-bio-cleanup-part4
