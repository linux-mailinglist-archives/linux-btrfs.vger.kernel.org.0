Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F276B3855
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 09:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCJIRW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 03:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCJIRV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 03:17:21 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CD3F9EEC
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 00:17:19 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 23C4C6732D; Fri, 10 Mar 2023 09:17:16 +0100 (CET)
Date:   Fri, 10 Mar 2023 09:17:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 07/20] btrfs: simplify the read_extent_buffer end_io
 handler
Message-ID: <20230310081715.GB15515@lst.de>
References: <20230309090526.332550-1-hch@lst.de> <20230309090526.332550-8-hch@lst.de> <dcc3f350-bfee-4813-ff9c-65c835c7af57@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcc3f350-bfee-4813-ff9c-65c835c7af57@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 10, 2023 at 04:14:46PM +0800, Qu Wenruo wrote:
> Here we call btrfs_validate_extent_buffer() directly.
>
> But in the case that a metadata bio is split, the endio function would be 
> called on each split part.

No.  bbio->end_io is called on the originally submitted bbio after all
I/O has finished, and is not called multiple times when split.  Without
that all consumers of btrfs_submit_bio would have to know about splitting
and need to be able to deal with cloned bios, which is exactly what I
spent great effort on to avoid (similar to how the block layer works).
