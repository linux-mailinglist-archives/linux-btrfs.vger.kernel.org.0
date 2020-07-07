Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30902177E5
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 21:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgGGTZf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 15:25:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:52900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbgGGTZe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jul 2020 15:25:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F103ACAF;
        Tue,  7 Jul 2020 19:25:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5AEE7DA818; Tue,  7 Jul 2020 21:25:13 +0200 (CEST)
Date:   Tue, 7 Jul 2020 21:25:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     robbieko <robbieko@synology.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: speedup mount time with readahead chunk tree
Message-ID: <20200707192511.GE16141@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, robbieko <robbieko@synology.com>,
        linux-btrfs@vger.kernel.org
References: <20200707035944.15150-1-robbieko@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707035944.15150-1-robbieko@synology.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 07, 2020 at 11:59:44AM +0800, robbieko wrote:
> From: Robbie Ko <robbieko@synology.com>
> 
> When mounting, we always need to read the whole chunk tree,
> when there are too many chunk items, most of the time is
> spent on btrfs_read_chunk_tree, because we only read one
> leaf at a time.
> 
> It is unreasonable to limit the readahead mechanism to a
> range of 64k, so we have removed that limit.
> 
> In addition we added reada_maximum_size to customize the
> size of the pre-reader, The default is 64k to maintain the
> original behavior.
> 
> So we fix this by used readahead mechanism, and set readahead
> max size to ULLONG_MAX which reads all the leaves after the
> key in the node when reading a level 1 node.

The readahead of chunk tree is a special case as we know we will need
the whole tree, in all other cases the search readahead needs is
supposed to read only one leaf.

For that reason I don't want to touch the current path readahead logic
at all and do the chunk tree readahead in one go instead of the
per-search.

Also I don't like to see size increase of btrfs_path just to use the
custom once.

The idea of the whole tree readahead is to do something like:

- find first item
- start readahead on all leaves from its level 1 node parent
  (readahead_tree_block)
- when the level 1 parent changes during iterating items, start the
  readahead again

This skips readahead of all nodes above level 1, if you find a nicer way
to readahead the whole tree I won't object, but for the first
implementation the level 1 seems ok to me.

> I have a test environment as follows:
> 
> 200TB btrfs volume: used 192TB
> 
> Data, single: total=192.00TiB, used=192.00TiB
> System, DUP: total=40.00MiB, used=19.91MiB

Can you please check what's the chunk tree height? 'btrfs inspect
tree-stats' prints that but it takes long as needs to go through the
whole metadata, so extracting it from 'btrfs inspect dump-tree -c chunk'
would be faster. Thanks.
