Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D37718001
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 14:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbjEaMfU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 08:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbjEaMfS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 08:35:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5EF123
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 05:35:17 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 022DD68B05; Wed, 31 May 2023 14:35:14 +0200 (CEST)
Date:   Wed, 31 May 2023 14:35:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Christoph Hellwig <hch@lst.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/6] btrfs: optimize simple reads in btrfsic_map_block
Message-ID: <20230531123514.GD26481@lst.de>
References: <20230531041740.375963-1-hch@lst.de> <20230531041740.375963-3-hch@lst.de> <6997cf68-8775-f518-9b7d-2dbc15b5ce58@gmx.com> <c5f70d87-6eed-5367-eec9-cc20c65f51e5@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5f70d87-6eed-5367-eec9-cc20c65f51e5@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 31, 2023 at 12:31:24PM +0000, Johannes Thumshirn wrote:
> > I'm more curious on whether the check-integrity feature is still under
> > heavy usage.
> > 
> > It's from old time where we don't have a lot of sanity checks, but
> > nowadays it looks less worthy and can cause extra burden to maintain.
> 
> I was going to ask the same question. I wouldn't mind removing it 
> at all.

I've never actively used it and defintively had my fair amount of run
ins with the somewhat interesting kind of code there.
