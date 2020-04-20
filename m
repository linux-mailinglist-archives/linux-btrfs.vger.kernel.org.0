Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6031B19B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 00:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgDTWoA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 18:44:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:54312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgDTWoA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 18:44:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6F52CAC53;
        Mon, 20 Apr 2020 22:43:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E6951DA72D; Tue, 21 Apr 2020 00:43:15 +0200 (CEST)
Date:   Tue, 21 Apr 2020 00:43:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        kjlu@umn.edu, Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] btrfs: Fix btrfs_block_group refcnt leak
Message-ID: <20200420224315.GI18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xin Tan <tanxin.ctf@gmail.com>
References: <1587361120-83160-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587361120-83160-1-git-send-email-xiyuyang19@fudan.edu.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 20, 2020 at 01:38:40PM +0800, Xiyu Yang wrote:
> btrfs_remove_block_group() invokes btrfs_lookup_block_group(), which
> returns a local reference of the blcok group that contains the given
> bytenr to "block_group" with increased refcount.
> 
> When btrfs_remove_block_group() returns, "block_group" becomes invalid,
> so the refcount should be decreased to keep refcount balanced.
> 
> The reference counting issue happens in several exception handling paths
> of btrfs_remove_block_group(). When those error scenarios occur such as
> btrfs_alloc_path() returns NULL, the function forgets to decrease its
> refcnt increased by btrfs_lookup_block_group() and will cause a refcnt
> leak.
> 
> Fix this issue by jumping to "out_put_group" label and calling
> btrfs_put_block_group() when those error scenarios occur.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Thanks for the fix. May I ask if this was found by code inspection or by
some analysis tool?

> @@ -1132,6 +1132,9 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>  		btrfs_delayed_refs_rsv_release(fs_info, 1);
>  	btrfs_free_path(path);
>  	return ret;
> +out_put_group:
> +	btrfs_put_block_group(block_group);
> +	goto out;

As Filipe noted, the trailing gotos are not a great pattern, what we'd
like to do is a more linear sequence where the resource
allocation/freeing nesting is obvious, like:


	x = allocate(X);
	if (!x)
		goto out;
	...
	y = allocate(Y);
	if (!y)
		goto out_free_x;
	z = allocate(Z);
	if (!z)
		goto out_free_y;
	...
	free(z);
out_free_y:
	free(y);
out_free_x:
	free(x);
out:
	return;


(where allocate/free can be refcount inc/dec and similar). Sometimes
it's not that straightforward and the freeing block needs conditionals,
but from code reading perspective this is still better than potentially
wild gotos.
