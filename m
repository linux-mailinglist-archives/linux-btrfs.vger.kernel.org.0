Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C52050DE81
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 13:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241651AbiDYLMt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 07:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241710AbiDYLMg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 07:12:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECA012A94
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 04:09:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 79C0F68AFE; Mon, 25 Apr 2022 13:09:28 +0200 (CEST)
Date:   Mon, 25 Apr 2022 13:09:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/10] btrfs: split btrfs_submit_data_bio
Message-ID: <20220425110928.GA24430@lst.de>
References: <20220425075418.2192130-1-hch@lst.de> <20220425075418.2192130-4-hch@lst.de> <62f71a43-8167-f29f-8e9f-d95bc6667e0e@gmx.com> <20220425091920.GC16446@lst.de> <458ba4e0-15f3-93e4-bc17-ae464bdf13e7@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458ba4e0-15f3-93e4-bc17-ae464bdf13e7@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 25, 2022 at 05:37:40PM +0800, Qu Wenruo wrote:
> Oh, please don't completely get rid of btrfs_bio, even just for writes.
>
> The btrfs_bio::iter is pretty important for us to grab the original
> logical bytenr of a bio.
> As bio::bi_iter can be modified by lower level (does dm modifies it
> too?), or btrfs itself.
>
> In fact, my incoming updated btrfs repair repair code heavily rely on
> btrfs_bio::iter, both read and write, to grab the original logical
> bytenr of the bio.

Then it's doing the wrong thing.  I actually have a series to remove
it entirely.
