Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733913C9A0A
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 10:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbhGOIEs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 04:04:48 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:51276 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhGOIEs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 04:04:48 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id EEE676C0085D;
        Thu, 15 Jul 2021 11:01:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1626336113; bh=8jfAOa9DtZO93hnWZGgvBB8GKmnkfRpNBUFpfsYIuiE=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=TYjd+3YSYghYildKfHeFGl4H4O9P7REybM0oHtiRxdJovFvUjXn0RgRpzvHy5K4VT
         0HuL+/x8qwFBzrgd83mnSbU597wXas9E2kzLuPClxGbEudtJ+o+A47SdFmoqr9wANs
         4Z76RrqbvrcUoJKKWdG/DzZCBYqcamWtXhtTjEfQ=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id E0DEE6C0085C;
        Thu, 15 Jul 2021 11:01:53 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id ES4NuLzOP8Aw; Thu, 15 Jul 2021 11:01:53 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 5CFAF6C0085A;
        Thu, 15 Jul 2021 11:01:53 +0300 (EEST)
Received: from nas (unknown [203.184.131.49])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 940481BE00A2;
        Thu, 15 Jul 2021 11:01:51 +0300 (EEST)
References: <20210715050036.30369-1-wqu@suse.com>
User-agent: mu4e 1.5.8; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Zhenyu Wu <wuzy001@gmail.com>
Subject: Re: [PATCH v3] btrfs: rescue: allow ibadroots to skip bad extent
 tree when reading block group items
Date:   Thu, 15 Jul 2021 15:50:27 +0800
Message-ID: <r1g0vwm4.fsf@damenly.su>
In-reply-to: <20210715050036.30369-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: +d1m7PFSY16piF6iXXrWARg2rCtXWOT5mZS30wE76Hb7Ny6FfEAOURSxgR8IQDzn/iM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Thu 15 Jul 2021 at 13:00, Qu Wenruo <wqu@suse.com> wrote:

> When extent tree gets corrupted, normally it's not extent tree 
> root, but
> one toasted tree leaf/node.
>
> In that case, rescue=ibadroots mount option won't help as it can 
> only
> handle the extent tree root corruption.
>
> This patch will enhance the behavior by:
>
> - Allow fill_dummy_bgs() to ignore -EEXIST error
>
>   This means we may have some block group items read from disk, 
>   but
>   then hit some error halfway.
>
> - Fallback to fill_dummy_bgs() if any error gets hit in
>   btrfs_read_block_groups()
>
>   Of course, this still needs rescue=ibadroots mount option.
>
> With that, rescue=ibadroots can handle extent tree corruption 
> more
> gracefully and allow a better recover chance.
>
> Reported-by: Zhenyu Wu <wuzy001@gmail.com>
> Link: https://www.spinics.net/lists/linux-btrfs/msg114424.html
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Don't try to fill with dummy block groups when we hit ENOMEM
> v3:
> - Remove a dead condition
>   The empty fs_info->extent_root case has already been handled.
> ---
>  fs/btrfs/block-group.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 5bd76a45037e..9bc68515bc4a 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2105,11 +2105,16 @@ static int fill_dummy_bgs(struct 
> btrfs_fs_info *fs_info)
>  		bg->used = em->len;
>  		bg->flags = map->type;
>  		ret = btrfs_add_block_group_cache(fs_info, bg);
> -		if (ret) {
> +		/*
> +		 * We may have some block groups filled already, thus 
> ignore
> +		 * the -EEXIST error.
> +		 */
> +		if (ret && ret != -EEXIST) {
>  			btrfs_remove_free_space_cache(bg);
>  			btrfs_put_block_group(bg);
>  			break;
>  		}
>
So we continue to link_block_group() bellow even -EEXIST. The new
allocated bg will be inserted into 
&space_info->block_groups[index].
Then while calling close_ctree(), it only frees bgs not allocated 
by
fill_dummy_bgs(). The bgs still exist in
&space_info->block_groups[index]. Memory leaks!

--
Su

> +		ret = 0;
>  		btrfs_update_space_info(fs_info, bg->flags, em->len, 
>  em->len,
>  					0, 0, &space_info);
>  		bg->space_info = space_info;
> @@ -2212,6 +2217,14 @@ int btrfs_read_block_groups(struct 
> btrfs_fs_info *info)
>  	ret = check_chunk_block_group_mappings(info);
>  error:
>  	btrfs_free_path(path);
> +	/*
> +	 * We hit some error reading the extent tree, and have 
> rescue=ibadroots
> +	 * mount option.
> +	 * Try to fill using dummy block groups so that the user can 
> continue
> +	 * to mount and grab their data.
> +	 */
> +	if (ret && btrfs_test_opt(info, IGNOREBADROOTS))
> +		ret = fill_dummy_bgs(info);
>  	return ret;
>  }
