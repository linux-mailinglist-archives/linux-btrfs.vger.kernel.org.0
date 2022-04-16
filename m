Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9ACA5032FC
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Apr 2022 07:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiDPEvz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Apr 2022 00:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiDPEvy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Apr 2022 00:51:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C7D5FCC
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 21:49:24 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DC9A368AFE; Sat, 16 Apr 2022 06:49:20 +0200 (CEST)
Date:   Sat, 16 Apr 2022 06:49:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/5] btrfs: do not return errors from
 btrfs_submit_compressed_read
Message-ID: <20220416044920.GB6162@lst.de>
References: <20220415143328.349010-1-hch@lst.de> <20220415143328.349010-5-hch@lst.de> <935e4667-2414-4620-382c-333075150f8f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <935e4667-2414-4620-382c-333075150f8f@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 16, 2022 at 06:48:37AM +0800, Qu Wenruo wrote:
> More and more bio submit functions are returning void and endio of the bio.
>
> But there are still quite some not doing this, like btrfs_map_bio().
>
> I'm wondering at which boundary we should return void and handle
> everything in-house?

I don't think it is quite clear.  All the I/O errors with a bio should
be handled through end_io, and we already have that, module the compressed
case with it's extra layer of bios.  Now at what point we call the
endio handler is a different question.  Duplicating it everywhere is
a bit annoying, so having some low-level helpers that just return an
error might be useful.  I plan a fair amount of refactoring around
btrfs_map_bio, so I'll see if lifting the end_io call into it might
or might no make sense while I'm at it.
