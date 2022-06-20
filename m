Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBF05511CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 09:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbiFTHt0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 03:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238525AbiFTHtZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 03:49:25 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9EA6583
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 00:49:24 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0448F68AA6; Mon, 20 Jun 2022 09:49:22 +0200 (CEST)
Date:   Mon, 20 Jun 2022 09:49:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 06/10] btrfs: transfer the bio counter reference to the
 raid submission helpers
Message-ID: <20220620074921.GA12343@lst.de>
References: <20220617100414.1159680-1-hch@lst.de> <20220617100414.1159680-7-hch@lst.de> <59dc5c97-36c6-9737-b7ab-1d4fcfaba2e3@gmx.com> <20220620073725.GA11832@lst.de> <7d0a5aa7-bdfb-e6c4-64b5-028ab73a54c1@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d0a5aa7-bdfb-e6c4-64b5-028ab73a54c1@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 20, 2022 at 03:45:45PM +0800, Qu Wenruo wrote:
> For the sake of consistency, is it possible that the other profiles also
> follow the same behavior?

Yes.  I actually just wrote the patch for that after reading your
other mail.  Still needs more testing of course.

> I guess it will need at least a counter to track how many pending bios
> in btrfs_io_context so bio counter is only decreased for the last bio?

We already do that using the bi_pending counter in the bio.
