Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0AA6313EA
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Nov 2022 13:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiKTMlX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Nov 2022 07:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKTMlW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Nov 2022 07:41:22 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F064E43A
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Nov 2022 04:41:20 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 74C6068AA6; Sun, 20 Nov 2022 13:41:15 +0100 (CET)
Date:   Sun, 20 Nov 2022 13:41:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: move struct btrfs_tree_parent_check out of
 disk-io.h
Message-ID: <20221120124114.GA7245@lst.de>
References: <20221115094407.1626250-1-hch@lst.de> <20221115094407.1626250-2-hch@lst.de> <20221118140722.GO5824@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118140722.GO5824@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 18, 2022 at 03:07:23PM +0100, David Sterba wrote:
> On Tue, Nov 15, 2022 at 10:44:04AM +0100, Christoph Hellwig wrote:
> > Move struct btrfs_tree_parent_check out of disk-io.h so that volumes.h
> > an various .c files don't have to include disk-io.h just for it.
> 
> Splitting that from disk-io.h makes sense but why creating a new file
> that has just the one structure?

Because there is no other header where it obviously fits.

> We have the tree-checker.h that seems
> like a place for various checks so I'll move it there.

Despite the similar naming there's actually no overlap between the
functionality offered in tree-checker.h and these uses of
struct btrfs_tree_parent_check at all.
