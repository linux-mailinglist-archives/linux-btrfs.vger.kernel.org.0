Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DCE554188
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 06:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356690AbiFVETj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 00:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiFVETi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 00:19:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CBBCE7
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 21:19:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AD51668AA6; Wed, 22 Jun 2022 06:19:15 +0200 (CEST)
Date:   Wed, 22 Jun 2022 06:19:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 01/10] btrfs: remove a bunch of pointles stripe_len
 arguments
Message-ID: <20220622041915.GA21099@lst.de>
References: <20220617100414.1159680-1-hch@lst.de> <20220617100414.1159680-2-hch@lst.de> <20220620171608.GU20633@twin.jikos.cz> <20220620173834.GA23580@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620173834.GA23580@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 20, 2022 at 07:38:34PM +0200, Christoph Hellwig wrote:
> > I'd rather keep it there so it gets used eventually, we have ongoing
> > work to fix the corner cases of raid56 so removing and adding it back
> > causes churn, but I'll give it another thought.
> 
> Well, right now it is very much dead code and complicates a lot
> of the argument passing as well as bloating the code size.
> 
> IFF the superblock member were to be actually used in the future,
> it would make sense to expose it in the btrfs_fs_info and use that
> instead of the constant, but still skip all the argument passing.
> 
> hch@brick:~/work/linux$ size btrfs.o.*
>    text	   data	    bss	    dec	    hex	filename
> 1502453	 125590	  28776	1656819	 1947f3	btrfs.o.new
> 1502599	 125590	  28776	1656965	 194885	btrfs.o.old

So I guess this wasn't convincing enough. My plan B would be the fs_info
member.  The related member seems to be the sectorsize field in the super
block, which is checked if it is a power of two but otherwise completely
ignored.  The fs_info has a stripe_size member that is initialized to the
sectorsize after reading the super_block but then also mostly ignored.

So this is a ll a bit of a mess unfortunately :(
