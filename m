Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F941E451D
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 16:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgE0ODT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 10:03:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:45900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730313AbgE0ODQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 10:03:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 22CADAE16;
        Wed, 27 May 2020 14:03:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B006DDA72D; Wed, 27 May 2020 16:02:17 +0200 (CEST)
Date:   Wed, 27 May 2020 16:02:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove redundant local var in
 read_block_for_search
Message-ID: <20200527140217.GH18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200527101059.7391-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527101059.7391-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 27, 2020 at 01:10:59PM +0300, Nikolay Borisov wrote:
> The local 'b' variable is only used to directly read values from passed
> extent buffer. So eliminate  it and directly use the input parameter. Furthermore
> this shrinks the size of the following functions:
> 
> ./scripts/bloat-o-meter ctree.orig fs/btrfs/ctree.o
> add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-73 (-73)
> Function                                     old     new   delta
> read_block_for_search.isra                   876     871      -5
> push_node_left                              1112    1044     -68
> -	struct extent_buffer *b = *eb_ret;

> -	blocknr = btrfs_node_blockptr(b, slot);
> -	gen = btrfs_node_ptr_generation(b, slot);
> -	parent_level = btrfs_header_level(b);
> -	btrfs_node_key_to_cpu(b, &first_key, slot);
> +	blocknr = btrfs_node_blockptr(*eb_ret, slot);
> +	gen = btrfs_node_ptr_generation(*eb_ret, slot);
> +	parent_level = btrfs_header_level(*eb_ret);
> +	btrfs_node_key_to_cpu(*eb_ret, &first_key, slot);

It's interesting how such trivial and obvious change can improve the
code generation. The removed indirection resulted in smaller function
push_node_left that is not even called directly, but as there are lot of
static helpers it's some intra-procedural pass that can utilize the
reduced variable indirection.
