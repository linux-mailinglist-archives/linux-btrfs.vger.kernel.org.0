Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308501EA677
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgFAPFk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:05:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:47998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgFAPFk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:05:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5D12FACBD;
        Mon,  1 Jun 2020 15:05:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3079ADA79B; Mon,  1 Jun 2020 17:05:37 +0200 (CEST)
Date:   Mon, 1 Jun 2020 17:05:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Btrfs: fix race between block group removal and
 block group creation
Message-ID: <20200601150537.GW18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200529111823.12510-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529111823.12510-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 29, 2020 at 12:18:23PM +0100, fdmanana@kernel.org wrote:
> @@ -1103,23 +1128,9 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>  
>  	mutex_unlock(&fs_info->chunk_mutex);
>  
> -	ret = remove_block_group_free_space(trans, block_group);
> -	if (ret)
> -		goto out_put_group;
> -
>  	/* Once for the block groups rbtree */
>  	btrfs_put_block_group(block_group);
>  
> -	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
> -	if (ret > 0)
> -		ret = -EIO;
> -	if (ret < 0)
> -		goto out;
> -
> -	ret = btrfs_del_item(trans, root, path);
> -	if (ret)
> -		goto out;
> -

I get conflicts in this hunk when applied to misc-next. The merging tool
'wiggle' can handle the rest of the patch and leaves this as the
unresolved conflict:

1154 <<<<<<< found
1155         ret = remove_block_group_item(trans, path, block_group);
1156 ||||||| expected
1157         ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
1158         if (ret > 0)
1159                 ret = -EIO;
1160 =======
1161 >>>>>>> replacement
