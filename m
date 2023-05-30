Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FBA7163D6
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 16:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjE3OWg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 10:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjE3OWS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 10:22:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF291720
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 07:21:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 611AB68B05; Tue, 30 May 2023 16:20:10 +0200 (CEST)
Date:   Tue, 30 May 2023 16:20:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: don't split ordered_extents for zoned writes at I/O submission
 time
Message-ID: <20230530142009.GA8807@lst.de>
References: <20230524150317.1767981-1-hch@lst.de> <45d88c8a-4eab-6fc2-8970-6224878940a1@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45d88c8a-4eab-6fc2-8970-6224878940a1@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 30, 2023 at 01:21:14PM +0000, Johannes Thumshirn wrote:
> Btw, as this came up multiple times today, should we also add a patch on top
> of this series merging consecutive ordered extents if the on disk extents are
> consecutive as well?
> 
> This would reduce fragmentation that unfortunately is a byproduct of the
> Zone Append writing scheme.

With this series we don't split ordered extents for zoned writes unless
they are non-consecutive.  So I'm not sure what we should merge, as
there isn't any splitting going on unless either a block group didn't
have space, or zone append actually reordered.
