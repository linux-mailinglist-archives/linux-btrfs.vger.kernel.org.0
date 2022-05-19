Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4788E52D0CF
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 12:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbiESKub (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 06:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbiESKu2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 06:50:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A71AEE3F
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 03:50:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8B95868AFE; Thu, 19 May 2022 12:50:23 +0200 (CEST)
Date:   Thu, 19 May 2022 12:50:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 12/15] btrfs: add new read repair infrastructure
Message-ID: <20220519105023.GA5891@lst.de>
References: <20220517145039.3202184-1-hch@lst.de> <20220517145039.3202184-13-hch@lst.de> <e2c4e54c-548b-2221-3bf7-31f6c14a03ee@gmx.com> <20220519093641.GA32623@lst.de> <d99b2ba3-23d2-0ea1-9aa4-13a898e77ab6@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d99b2ba3-23d2-0ea1-9aa4-13a898e77ab6@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 19, 2022 at 06:41:52PM +0800, Qu Wenruo wrote:
> So in that case, the best solution is to use "btrfs-map-logical -l 
> 343998464", which will directly return the physical offset of the wanted 
> logical on each involved devices.
>
> Although we need to note:
>
> - btrfs-map-logical may not always be shipped in progs in the future
>   This tool really looks like a debug tool. I'm not sure if we will keep
>   shipping it (personally I really hope to)
>
> - btrfs-map-logical only return data stripes
>   Thus it doesn't work for RAID56 just in case you want to use it.
>
> Despite the weird extent logical bytenr, everything should be fine with 
> btrfs-map-logical.


Oh, nice, this is much better than the hackery in the existing tests.

That bein said the -c option does not seem to work.  No matter what
I specify it always returns all three mirrors.  I guess a little
awk will fix that, but the behavior seems odd.
