Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB05718009
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 14:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjEaMhS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 08:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjEaMhR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 08:37:17 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B372E2
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 05:37:16 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 43FBF68B05; Wed, 31 May 2023 14:37:13 +0200 (CEST)
Date:   Wed, 31 May 2023 14:37:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6/6] btrfs: remove need_full_stripe
Message-ID: <20230531123713.GA26932@lst.de>
References: <20230531041740.375963-1-hch@lst.de> <20230531041740.375963-7-hch@lst.de> <f1930f26-6422-8f57-0d4a-7cc431dd1a7c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1930f26-6422-8f57-0d4a-7cc431dd1a7c@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 31, 2023 at 04:52:53PM +0800, Qu Wenruo wrote:
>> need_full_stripe is just a somewhat complicated way to say
>> "op != BTRFS_MAP_READ".  Just spell that explicit check out, which makes
>> a lot of the code currently using the helper easier to understand.
>
> In fact the old "need_full_stripe" can even be confusing, as
> BTRFS_MAP_READ with mirror_num > 1 on RAID56 would still need all the
> stripes.

Yes, that's one of the reasons.  And that in general in the conditionals
READ/!READ tends to explain the logic better than !need_full_stripe vs
need_full_stripe.
