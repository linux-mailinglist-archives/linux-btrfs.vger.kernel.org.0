Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856B853E33B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 10:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiFFGbL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 02:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiFFGa4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 02:30:56 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61BF6BFE3
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Jun 2022 23:30:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3062868AA6; Mon,  6 Jun 2022 08:30:50 +0200 (CEST)
Date:   Mon, 6 Jun 2022 08:30:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: pass the btrfs_bio_ctrl to submit_one_bio
Message-ID: <20220606063050.GA2308@lst.de>
References: <20220603071103.43440-1-hch@lst.de> <20220603071103.43440-4-hch@lst.de> <ee3f0a66-ce9d-5e3d-2a8e-fd620bcb5f5d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee3f0a66-ce9d-5e3d-2a8e-fd620bcb5f5d@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 05, 2022 at 06:31:18AM +0800, Qu Wenruo wrote:
> In fact the only call sites really caring num_mirror is the metadata
> read path (as it doesn't rely on the read-repair code, since metadata
> has inline csum and it has a different validation condition).
>
> It may be a good idea to make a union for btrfs_bio, to contain all the
> needed info for metadata verification (btrfs_key, transid, level), so
> that we can get rid of the num_mirror parameter for submit_extent_page()
> completely.

My idea was to pass that in structure in bio->bi_private.  But that
is just thought for now, I've not tried to actually implement it yet.
