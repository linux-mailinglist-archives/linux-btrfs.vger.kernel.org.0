Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545183CCDAE
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 07:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbhGSF4I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 01:56:08 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:37154 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbhGSF4I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 01:56:08 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 3F0181E00587;
        Mon, 19 Jul 2021 08:53:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1626673988; bh=Ch1oMIojgS5lR4jUvWSWUUNJq9yPpbxZkay34DPTV9I=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=a3tkGjcWfZZWP7aE17jcuR+GCCFQHG3kxoxPp2V2Aa3sD/xLTcqOYAKCXwxFEJl8D
         VbRfK8nWMflNz0AE2QvE4ymnUORpwUVefmjWBTn81GDvPJiBgsF3yp1Ko0L8Av6Zgz
         FWIOeNm8BTzs0NXtU3kRvRDxn9J4rSqK/zn2FHjc=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 317181E0057F;
        Mon, 19 Jul 2021 08:53:08 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id NkIAs-FMKg3G; Mon, 19 Jul 2021 08:53:07 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 8A8541E00513;
        Mon, 19 Jul 2021 08:53:07 +0300 (EEST)
Received: from nas (unknown [103.138.53.19])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 3C2311BE00D4;
        Mon, 19 Jul 2021 08:53:05 +0300 (EEST)
References: <20210719054304.181509-1-wqu@suse.com>
User-agent: mu4e 1.5.8; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Zhenyu Wu <wuzy001@gmail.com>
Subject: Re: [PATCH v4] btrfs: rescue: allow ibadroots to skip bad extent
 tree when reading block group items
Date:   Mon, 19 Jul 2021 13:52:19 +0800
Message-ID: <im16x32d.fsf@damenly.su>
In-reply-to: <20210719054304.181509-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6N1ml5Y3ejOlil2/QnjWGwM0sStAQJ6b9qflkAEq73aCSjLmCkUMVhC2n2R1THi+og==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Mon 19 Jul 2021 at 13:43, Qu Wenruo <wqu@suse.com> wrote:

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
>

LGTM.

Reviewed-by: Su Yue <l@damenly.su>

--
Su
> ---
> Changelog:
> v2:
> - Don't try to fill with dummy block groups when we hit ENOMEM
> v3:
> - Remove a dead condition
>   The empty fs_info->extent_root case has already been handled.
> v4:
> - Skip to next block group if we hit EEXIST when inserting the 
> block
>   group cache
> ---
>  fs/btrfs/block-group.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 5bd76a45037e..758ba856f8c6 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2105,11 +2105,22 @@ static int fill_dummy_bgs(struct 
> btrfs_fs_info *fs_info)
>  		bg->used = em->len;
>  		bg->flags = map->type;
>  		ret = btrfs_add_block_group_cache(fs_info, bg);
> +		/*
> +		 * We may have some valid block group cache added already, 
> in
> +		 * that case we skip to next bg.
> +		 */
> +		if (ret == -EEXIST) {
> +			ret = 0;
> +			btrfs_put_block_group(bg);
> +			continue;
> +		}
> +
>  		if (ret) {
>  			btrfs_remove_free_space_cache(bg);
>  			btrfs_put_block_group(bg);
>  			break;
>  		}
> +
>  		btrfs_update_space_info(fs_info, bg->flags, em->len, 
>  em->len,
>  					0, 0, &space_info);
>  		bg->space_info = space_info;
> @@ -2212,6 +2223,14 @@ int btrfs_read_block_groups(struct 
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
