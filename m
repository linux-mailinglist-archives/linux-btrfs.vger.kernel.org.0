Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C383E8AB0
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 09:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbhHKHD2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 03:03:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42550 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbhHKHD1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 03:03:27 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9F463220DC;
        Wed, 11 Aug 2021 07:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628665383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XbaCz4LWNEvaumF6dsz7XQmrnnxx4wf+tK6kcEsEGTM=;
        b=A713rWvcVHOeP5n3KpZRFi5vZY85nh9NLwjZ2zgVrKKIPnSIPh49alCcxrNCVhjtHyhWB4
        NfssW1Bf0k/2L8uBXvMD4zATnkN/cbB3oiH8W/am8esL94X0y7KQBMHleukabuxwtnS6kQ
        VRcNVOMUq3gH3MBR7q0tY/wj9Grfcl8=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 70BB0137FE;
        Wed, 11 Aug 2021 07:03:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id z92HGCd2E2HCWgAAGKfGzw
        (envelope-from <nborisov@suse.com>); Wed, 11 Aug 2021 07:03:03 +0000
Subject: Re: [PATCH] btrfs-progs: map-logical: handle corrupted fs better
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210810235445.44567-1-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <a9c908a2-ada5-24ab-dc01-ebd686294000@suse.com>
Date:   Wed, 11 Aug 2021 10:03:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210810235445.44567-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.08.21 г. 2:54, Qu Wenruo wrote:
> Currently if running btrfs-map-logical on a filesystem with corrupted
> extent tree, it will fail due to open_ctree() error.
> 
> But the truth is, btrfs-map-logical only requires chunk tree to do
> logical bytenr mapping.
> 
> Make btrfs-map-logical more robust by:
> 
> - Loosen the open_ctree() requirement
>   Now it doesn't require an extent tree to work.
> 
> - Don't return error for map_one_extent()
>   Function map_one_extent() is too lookup extent tree to ensure there is
>   at least one extent for the range we're looking for.
> 
>   But since now we don't require extent tree at all, there is no hard
>   requirement for that function.
>   Thus here we change it to return void, and only do the check when
>   possible.
> 
> Now btrfs-map-logical can work on a filesystem with corrupted extent
> tree.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  btrfs-map-logical.c | 50 +++++++++++----------------------------------
>  1 file changed, 12 insertions(+), 38 deletions(-)
> 
> diff --git a/btrfs-map-logical.c b/btrfs-map-logical.c
> index b35677730374..f06a612f6c14 100644
> --- a/btrfs-map-logical.c
> +++ b/btrfs-map-logical.c
> @@ -38,8 +38,8 @@
>   * */
>  static FILE *info_file;
>  
> -static int map_one_extent(struct btrfs_fs_info *fs_info,
> -			  u64 *logical_ret, u64 *len_ret, int search_forward)
> +static void map_one_extent(struct btrfs_fs_info *fs_info,
> +			   u64 *logical_ret, u64 *len_ret, int search_forward)
>  {
>  	struct btrfs_path *path;
>  	struct btrfs_key key;
> @@ -52,7 +52,7 @@ static int map_one_extent(struct btrfs_fs_info *fs_info,
>  
>  	path = btrfs_alloc_path();
>  	if (!path)
> -		return -ENOMEM;
> +		return;
>  
>  	key.objectid = logical;
>  	key.type = 0;
> @@ -94,7 +94,11 @@ out:
>  		if (len_ret)
>  			*len_ret = len;
>  	}
> -	return ret;
> +	/*
> +	 * Ignore any error for extent item lookup, it can be corrupted
> +	 * extent tree or whatever. In that case, just ignore the
> +	 * extent item lookup and reset @ret to 0.
> +	 */
>  }
>  
>  static int __print_mapping_info(struct btrfs_fs_info *fs_info, u64 logical,
> @@ -261,7 +265,8 @@ int main(int argc, char **argv)
>  	radix_tree_init();
>  	cache_tree_init(&root_cache);
>  
> -	root = open_ctree(dev, 0, 0);
> +	root = open_ctree(dev, 0, OPEN_CTREE_PARTIAL |
> +				  OPEN_CTREE_NO_BLOCK_GROUPS);
>  	if (!root) {
>  		fprintf(stderr, "Open ctree failed\n");
>  		free(output_file);
> @@ -293,34 +298,7 @@ int main(int argc, char **argv)
>  	cur_len = bytes;
>  
>  	/* First find the nearest extent */
> -	ret = map_one_extent(root->fs_info, &cur_logical, &cur_len, 0);
> -	if (ret < 0) {
> -		errno = -ret;
> -		fprintf(stderr, "Failed to find extent at [%llu,%llu): %m\n",
> -			cur_logical, cur_logical + cur_len);
> -		goto out_close_fd;
> -	}
> -	/*
> -	 * Normally, search backward should be OK, but for special case like
> -	 * given logical is quite small where no extents are before it,
> -	 * we need to search forward.
> -	 */
> -	if (ret > 0) {
> -		ret = map_one_extent(root->fs_info, &cur_logical, &cur_len, 1);
> -		if (ret < 0) {
> -			errno = -ret;
> -			fprintf(stderr,
> -				"Failed to find extent at [%llu,%llu): %m\n",
> -				cur_logical, cur_logical + cur_len);
> -			goto out_close_fd;
> -		}
> -		if (ret > 0) {
> -			fprintf(stderr,
> -				"Failed to find any extent at [%llu,%llu)\n",
> -				cur_logical, cur_logical + cur_len);
> -			goto out_close_fd;
> -		}
> -	}
> +	map_one_extent(root->fs_info, &cur_logical, &cur_len, 0);


You essentially make map_one_extent fail silently in this case how can
the call to it be reliable at all? Shouldn't it be removed altogether?
alternatively, the function can be made to return an error, yet it
should be up to the caller to choose to ignore it. Also if the tree is
corrupted what pervents for the btrfs_search_slot in map_one_extent to
return 0 which will trigger a BUG_ON ?


Furthermore with map_one_extent present the semantics of the program is
that it prints the logical mapping of the real extent rather then the
passed in bytes. Because the user is allowed to pass an offset for which
there isn't a real extent. So if we want to retain this your change is a
no-go. OTOH if we want to have btrfs_map_logical to serve as a simple
calculation aid i.e you pass in some logical byte, irrespective whether
it contains a real extent or not, and have the program return what the
physical mapping is then map_one_extent becomes redundant altogether.

<snip>
