Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D431710C2F
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 14:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbjEYMeh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 08:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjEYMeg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 08:34:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA0B98
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 05:34:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 906D168D07; Thu, 25 May 2023 14:34:31 +0200 (CEST)
Date:   Thu, 25 May 2023 14:34:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 11/14] btrfs: atomically insert the new extent in
 btrfs_split_ordered_extent
Message-ID: <20230525123431.GA8594@lst.de>
References: <20230524150317.1767981-1-hch@lst.de> <20230524150317.1767981-12-hch@lst.de> <f574b91a-14f2-7d79-4b7f-8d625fdcde6c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f574b91a-14f2-7d79-4b7f-8d625fdcde6c@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 25, 2023 at 12:30:41PM +0000, Johannes Thumshirn wrote:
> I wonder if we couldn't reduce the code duplication between btrfs_split_ordered_extent
> and the new insert_ordered_extent function. The different lock ordering currently makes
> it impossible, though.

The interesting thing about the split case is that we really want to
do a removal and two inserts in an atomic fashion.  In the end
there's not really much code in insert_ordered_extent anyway, and
the decision where to split up btrfs_alloc_ordered_extent was at
least partially based on that tradeoff.
