Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD4452B58E
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 11:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbiERIpf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 04:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiERIpe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 04:45:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0119521E2C
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 01:45:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3BBD068AFE; Wed, 18 May 2022 10:45:30 +0200 (CEST)
Date:   Wed, 18 May 2022 10:45:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 09/15] btrfs: factor out a btrfs_csum_ptr helper
Message-ID: <20220518084529.GC6933@lst.de>
References: <20220517145039.3202184-1-hch@lst.de> <20220517145039.3202184-10-hch@lst.de> <PH0PR04MB74165799E9088993A3DC984C9BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB74165799E9088993A3DC984C9BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 17, 2022 at 03:24:26PM +0000, Johannes Thumshirn wrote:
> On 17/05/2022 16:52, Christoph Hellwig wrote:
> > +static inline u8 *btrfs_csum_ptr(struct btrfs_fs_info *fs_info, u8 *csums,
> > +		u64 offset)
> > +{
> > +	return csums +
> > +		((offset >> fs_info->sectorsize_bits) * fs_info->csum_size);
> 
> I guess a local variable for holding 'offset >> fs_info->sectorsize_bits'
> wouldn't have hurt readability and the compiler would've optimized it away,
> but that's just me nitpicking.

I can do that if there is a strong opinion, but I'm not sure it would
help readability at all.
