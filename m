Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A762855FAD9
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jun 2022 10:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiF2ImH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jun 2022 04:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiF2ImF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jun 2022 04:42:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44E23CA78
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 01:42:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C606967373; Wed, 29 Jun 2022 10:42:01 +0200 (CEST)
Date:   Wed, 29 Jun 2022 10:42:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: fix read repair on compressed extents
Message-ID: <20220629084201.GA25725@lst.de>
References: <20220623055338.3833616-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623055338.3833616-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Any chance to get a review on this one?

On Thu, Jun 23, 2022 at 07:53:34AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> while looking into the repair code I found that read repair of compressed
> extents is current fundamentally broken, in that repair tries to write
> the uncompressed data into a corrupted extent during a repair.  This is
> demonstrated by the "btrfs: test read repair on a corrupted compressed
> extent" test submitted to xfstests.
> 
> This series fixes that, but is a bit invaside as it requires both
> refactoring of the compression code and changes to the repair code to
> not look up the logic address on every repair attempt.  On the plus
> side it removes a whole lot of code.
> 
> It is based on the for-next branch plus my "btrfs: repair all known bad
> mirrors" patch.
> 
> Diffstat:
>  compression.c |  287 ++++++++++++++++------------------------------------------
>  compression.h |   11 --
>  ctree.h       |    4 
>  extent_io.c   |   93 +++++++-----------
>  extent_io.h   |    9 -
>  inode.c       |   34 +++---
>  6 files changed, 148 insertions(+), 290 deletions(-)
---end quoted text---
