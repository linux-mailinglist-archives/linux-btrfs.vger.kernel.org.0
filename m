Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63DB485683
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 17:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241855AbiAEQLj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 11:11:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46674 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241849AbiAEQLf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jan 2022 11:11:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34CD36164D;
        Wed,  5 Jan 2022 16:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC5CC36AE0;
        Wed,  5 Jan 2022 16:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641399094;
        bh=ZKKlCVjotxQ/mWW+wBX7WNgKdj9sFqeaW4C5i3zAAK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6CTWgBp2mHIz528O9KmNIS/Lo349/KB4sc5YDeWhjmTVRBNElXaHcuj6qF5z/XzK
         8nlMoczvRyJPEqTWZUt7fCnWcL+HWQfFlkhc/66vz9ZssFWyDdfyuRQIEBR4QekWpZ
         D98i7JXIYWZqMBzg+NSTqniWxvjEwakxV/+7MQwJdS1B9qdAtVpHaSkwoP3wCNL5M2
         eTQIp4MKdS9syGrutbWyBsBzZ877pK/nFsuSfp5yMHPi1r7jxJGUAN4DhsAyP7CPc6
         ggLTN/96IU9htJM4m0s4NkZzd7upk5myqkogSpei6fy185zAa5OCao3KRebfjUXJXP
         sCOnLPTwoiXng==
Date:   Wed, 5 Jan 2022 16:11:30 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2] btrfs: Remove redundant assignment of slot and leaf
Message-ID: <YdXDMjJcUKLwJdiW@debian9.Home>
References: <20220105150758.29670-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105150758.29670-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 05, 2022 at 11:07:58PM +0800, Jiapeng Chong wrote:
> From: chongjiapeng <jiapeng.chong@linux.alibaba.com>
> 
> slot and leaf are being initialized to path->slots[0] and
> path->nodes[0], but this is never read as slot and leaf
> is overwritten later on. Remove the redundant assignment.
> 
> Cleans up the following clang-analyzer warning:
> 
> fs/btrfs/tree-log.c:6125:7: warning: Value stored to 'slot' during its
> initialization is never read [clang-analyzer-deadcode.DeadStores].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: chongjiapeng <jiapeng.chong@linux.alibaba.com>
> ---
> Changes in v2:
>   -Remove redundant assignment of leaf.
> 
>  fs/btrfs/tree-log.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 4b89ac769347..d99cda0acd95 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -6188,8 +6188,6 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
>  		if (ret < 0)
>  			return ret;
>  
> -		leaf = path->nodes[0];
> -		slot = path->slots[0];

No, this is not correct.

Right before those assignments we called btrfs_search_slot(), which updates
path->nodes and path->slots, and we need those updated values below.

The redundant assignments are not these two, but instead the ones when the
variables are declared at the top of the loop:

   struct extent_buffer *leaf = path->nodes[0];
   int slot = path->slots[0];

Thanks.

>  		if (slot >= btrfs_header_nritems(leaf)) {
>  			ret = btrfs_next_leaf(root, path);
>  			if (ret < 0)
> -- 
> 2.19.1.6.gb485710b
> 
