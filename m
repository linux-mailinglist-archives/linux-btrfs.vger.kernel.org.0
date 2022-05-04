Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9630B51A1D6
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 16:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351071AbiEDOMc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 10:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351037AbiEDOMb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 10:12:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF1D419A6
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 07:08:55 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 10B3168AFE; Wed,  4 May 2022 16:08:52 +0200 (CEST)
Date:   Wed, 4 May 2022 16:08:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/10] btrfs: split btrfs_submit_data_bio
Message-ID: <20220504140851.GA17969@lst.de>
References: <20220504122524.558088-1-hch@lst.de> <20220504122524.558088-5-hch@lst.de> <4b4e9991-3c1b-6758-3e1d-c6aafac61c13@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b4e9991-3c1b-6758-3e1d-c6aafac61c13@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 04, 2022 at 08:38:23PM +0800, Qu Wenruo wrote:
>> +	struct inode *inode = tree->private_data;
>
> I guess we shouldn't use the extent_io_tree for bio->bi_private at all
> if we're just tring to grab an inode.
>
> In fact, for all submit_one_bio() callers, we are handling buffered
> read/write, thus we can grab inode using
> bio_first_page_all(bio)->mapping->host.
>
> No need for such weird io_tree based dance.

Yes, we can eventully.  Not for this series, though.

>> -	if (is_data_inode(tree->private_data))
>> -		btrfs_submit_data_bio(tree->private_data, bio, mirror_num,
>> -					    compress_type);
>> +	if (!is_data_inode(tree->private_data))
>> +		btrfs_submit_metadata_bio(inode, bio, mirror_num);
>
> Can we just call btrfs_submit_metadata_bio() and return?
>
> Every time I see an "if () else if ()", I can't stop thinking if we have
> some corner cases not taken into consideration.

I generally agree with you, but for this case I think it is pretty
simple.  But a few more series down the road these helpers will change
a bit anyway, so we can revisit it.

