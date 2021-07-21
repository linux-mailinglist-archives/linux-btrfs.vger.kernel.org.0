Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FA63D150E
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 19:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhGUQnv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 12:43:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53660 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbhGUQnu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 12:43:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4BEFD1FED0;
        Wed, 21 Jul 2021 17:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626888266;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pLO1GpJQdVve5zsiOKHxqoZ5Cpinmpssxi7dSWcegvw=;
        b=PG4htvV3TcRrSPJSnaw/W/pyMm3BeTq8TLJ1glUnhB8e10pplpDGgKyvH4Qh8e362/bVSt
        qhuKpOBinjaNPVZi7pRCF4hJgVVinUjIYr6F++/WfBJmBM0sNE1y+zDWD3bPbT5vtA07DV
        RAv6MtHUWdyS38oMlwegNbWH309Y924=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626888266;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pLO1GpJQdVve5zsiOKHxqoZ5Cpinmpssxi7dSWcegvw=;
        b=wKU0a64ncwfh8ZxwzvjwBjSjwvOhYL5XqicGaPOO/RtPPSFqMrQRbCXvRLAMN6bI8/D/Fo
        aC++A4YexTwSjsBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 469D3A3B88;
        Wed, 21 Jul 2021 17:24:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0C8BFDA704; Wed, 21 Jul 2021 19:21:44 +0200 (CEST)
Date:   Wed, 21 Jul 2021 19:21:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: stop doing GFP_KERNEL memory allocations in
 the ref verify tool
Message-ID: <20210721172144.GL19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1626791739.git.fdmanana@suse.com>
 <a3c49375c499e32d265feea5895d59da78db1c89.1626791739.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3c49375c499e32d265feea5895d59da78db1c89.1626791739.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 20, 2021 at 04:05:23PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In commit 351cbf6e4410e7 ("btrfs: use nofs allocations for running delayed
> items") we wrapped all btree updates when running delayed items with
> memalloc_nofs_save() and memalloc_nofs_restore(), due to a lock inversion
> detected by lockdep involving reclaim and the mutex of delayed nodes.
> 
> The problem is because the ref verify tool does some memory allocations
> with GFP_KERNEL, which can trigger reclaim and reclaim can trigger inode
> eviction, which requires locking the mutex of an inode's delayed node.
> On the other hand the ref verify tool is called when allocating metadata
> extents as part of operations that modify a btree, which is a problem when
> running delayed nodes, where we do btree updates while holding the mutex
> of a delayed node. This is what caused the lockdep warning.
> 
> Instead of wrapping every btree update when running delayed nodes, change
> the ref verify tool to never do GFP_KERNEL allocations, because:
> 
> 1) We get less repeated code, which at the moment does not even have a
>    comment mentioning why we need to setup the NOFS context, which is a
>    recommended good practice as mentioned at
>    Documentation/core-api/gfp_mask-from-fs-io.rst
> 
> 2) The ref verify tool is something meant only for debugging and not
>    something that should be enabled on non-debug / non-development
>    kernels;
> 
> 3) We may have yet more places outside delayed-inode.c where we have
>    similar problem: doing btree updates while holding some lock and
>    then having the GFP_KERNEL memory allocations, from the ref verify
>    tool, trigger reclaim and trying again to acquire the same lock
>    through the reclaim path.
>    Or we could get more such cases in the future, therefore this change
>    prevents getting into similar cases when using the ref verify tool.

That all sounds reasonable to me regarding the GFP flags use.
