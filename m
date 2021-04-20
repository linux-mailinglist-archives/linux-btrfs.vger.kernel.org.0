Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5B4365E62
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 19:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhDTRTX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 13:19:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:57242 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231549AbhDTRTX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 13:19:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B1C78ABED;
        Tue, 20 Apr 2021 17:18:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C9CD8DA83A; Tue, 20 Apr 2021 19:16:31 +0200 (CEST)
Date:   Tue, 20 Apr 2021 19:16:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix metadata extent leak after failure to create
 subvolume
Message-ID: <20210420171631.GW7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <e94fda2a13e93bbeae458d9815a1610d6438ba33.1618912341.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e94fda2a13e93bbeae458d9815a1610d6438ba33.1618912341.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 20, 2021 at 10:55:12AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When creating a subvolume we allocate an extent buffer for its root node
> after starting a transaction. We setup a root item for the subvolume that
> points to that extent buffer and then attempt to insert the root item into
> the root tree - however if that fails, due to -ENOMEM for example, we do
> not free the extent buffer previously allocated and we do not abort the
> transaction (as at that point we did nothing that can not be undone).
> 
> This means that we effectively do not return the metadata extent back to
> the free space cache/tree and we leave a delayed reference for it which
> causes a metadata extent item to be added to the extent tree, in the next
> transaction commit, without having backreferences. When this happens
> 'btrfs check' reports the following:
> 
>   $ btrfs check /dev/sdi
>   Opening filesystem to check...
>   Checking filesystem on /dev/sdi
>   UUID: dce2cb9d-025f-4b05-a4bf-cee0ad3785eb
>   [1/7] checking root items
>   [2/7] checking extents
>   ref mismatch on [30425088 16384] extent item 1, found 0
>   backref 30425088 root 256 not referenced back 0x564a91c23d70
>   incorrect global backref count on 30425088 found 1 wanted 0
>   backpointer mismatch on [30425088 16384]
>   owner ref check failed [30425088 16384]
>   ERROR: errors found in extent allocation tree or chunk allocation
>   [3/7] checking free space cache
>   [4/7] checking fs roots
>   [5/7] checking only csums items (without verifying data)
>   [6/7] checking root refs
>   [7/7] checking quota groups skipped (not enabled on this FS)
>   found 212992 bytes used, error(s) found
>   total csum bytes: 0
>   total tree bytes: 131072
>   total fs tree bytes: 32768
>   total extent tree bytes: 16384
>   btree space waste bytes: 124669
>   file data blocks allocated: 65536
>    referenced 65536
> 
> So fix this by freeing the metadata extent if btrfs_insert_root() returns
> an error.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
