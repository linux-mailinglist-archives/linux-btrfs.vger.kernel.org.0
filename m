Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BEB52CF83
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 11:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbiESJgy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 05:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbiESJgt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 05:36:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3056C5EDF2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 02:36:45 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4386D68AFE; Thu, 19 May 2022 11:36:42 +0200 (CEST)
Date:   Thu, 19 May 2022 11:36:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 12/15] btrfs: add new read repair infrastructure
Message-ID: <20220519093641.GA32623@lst.de>
References: <20220517145039.3202184-1-hch@lst.de> <20220517145039.3202184-13-hch@lst.de> <e2c4e54c-548b-2221-3bf7-31f6c14a03ee@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2c4e54c-548b-2221-3bf7-31f6c14a03ee@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 18, 2022 at 07:04:22AM +0800, Qu Wenruo wrote:
> Function btrfs_repair_read_bio() will only return true if all of its
> data matches csum.
>
> Consider the following case:
>
> Profile RAID1C3, 2 sectors to read, the initial mirror is 1.
>
> Mirror 1:	|X|X|
> Mirror 2:	|X| |
> Mirror 3:	| |X|
>
> Now we will got -EIO, but in reality, we can repair the read by using
> the first sector from mirror 3 and the 2nd sector from mirror 2.

I tried to write a test case for this by copying btrfs/140 and then
as a first step extending it to three mirrors unsing the raid1c1
profile.  But it seems that the tricks used there don't work,
as the code in btrfs/140 relies on the fact that the btrfs logic
address repored by file frag is reported by dump-tree as the item
"index" ĭn this line:

item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 137756672) itemoff 15751 itemsiz

but for the raid1c3 profile that line reports something entirely
different.

for raid1:

logical: 137756672
item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 137756672) itemoff 15751 itemsize 112

for raid1c3:

logical: 343998464
item 5 key (FIRST_CHUNK_TREE CHUNK_ITEM 298844160) itemoff 15621 itemsize 144

any idea how to find physical sectors to corrupt for raid1c1?
