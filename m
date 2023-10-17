Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B2F7CC51F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Oct 2023 15:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343938AbjJQNte (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Oct 2023 09:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjJQNtd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Oct 2023 09:49:33 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA76F0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Oct 2023 06:49:31 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a87ac9d245so27118147b3.3
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Oct 2023 06:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697550570; x=1698155370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jb7UFpPZArWftbXhbJJf4z6MpND+8qI0D+AxnGViw4w=;
        b=FeWic8TLteKNRMthncl0Gqlsc2BojpjGyEG4e4t5GWnZ23eDdSJdBOM52T2ua6FM6I
         2S4Eqhgs6rqGdpj7lQ2Ucex4/zn2Bl9vwcPdxKSEZBV/rskIdJgEaoLMIgCINDWZlhFr
         1v3IWdxNj/LDZsem/AjwP4MdIb/g+0FumaFKvv+rR1CDDhWWareGUFiSSLFJR0LfduFi
         Z5Lw3StxAQKpFD9cy8hFQVhHJQt5+W5UG2Eev4FvX4jM1s20FNLi7gttog88bCVxCkJ6
         VNVtatU4ojlMfHTGVlvmjI5cxqCIHWzVSTGHewBDoyP9P7rC62nXnCDwa7acvz+0Hl4Q
         G/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697550570; x=1698155370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jb7UFpPZArWftbXhbJJf4z6MpND+8qI0D+AxnGViw4w=;
        b=me2jKRhKLKGIAQegV7ZGd4NLg3UO93WT7z+eezipQbDebqc1IvobOrgNMfQ6pWCZKz
         IXTV85ZyuIqpoAuWjWShltgAVPPfIYS9OIzecZh6rpu1AVvqeKBhCACVT0k6NF1+bCgQ
         ca7+TlsLOOfy8yPXWr64mPhpYLTJ6FNvM1m7v2zGbcnV3gH4EMaV2sTKUFbQQ9cYDO+a
         k2Vmo57R3QEtMHyqLrG6G3PPgMA8PuEADSEzskbI+ae5pwqrDsVnmaMz4WMuUgYb5DGR
         +AfHAl0yBfohD92XgXxYfLOJK7Qs4j+ZUpFyrpVw1xAel0pCA++KqISCGHstnW+yMsga
         tHcQ==
X-Gm-Message-State: AOJu0YyJnNExfgSXIwxM26CNerEHxYq5AUZsCmtECSafiQ9Fh7TYTvoJ
        nxvwygVNdKexdVAOwR2eZZADz2QpIPvFsX8NoLHpXw==
X-Google-Smtp-Source: AGHT+IF2D1k751vNKUjEnzdFe0xepOJZQ7Px1tchmCyYELGKew1B/PJpjnE1k1sa9ef3WUCBu3a+AQ==
X-Received: by 2002:a81:8341:0:b0:5a7:c6bd:7ac0 with SMTP id t62-20020a818341000000b005a7c6bd7ac0mr2761768ywf.13.1697550570231;
        Tue, 17 Oct 2023 06:49:30 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id o63-20020a0dfe42000000b0059a34cfa2a5sm620059ywf.67.2023.10.17.06.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:49:29 -0700 (PDT)
Date:   Tue, 17 Oct 2023 09:49:29 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/6] btrfs-progs: use a unified btrfs_make_subvol()
 implementation
Message-ID: <20231017134929.GA2350212@perftesting>
References: <cover.1697430866.git.wqu@suse.com>
 <7b951f3a0619880f35f2490e2e251eb35e2f2292.1697430866.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b951f3a0619880f35f2490e2e251eb35e2f2292.1697430866.git.wqu@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 16, 2023 at 03:08:50PM +1030, Qu Wenruo wrote:
> To create a subvolume there are several different helpers:
> 
> - create_subvol() from convert/main.c
>   This relies one using an empty fs_root tree to copy its root item.
>   But otherwise has a pretty well wrapper btrfs_ake_root_dir() helper to
>   handle the inode item/ref insertion.
> 
> - create_data_reloc_tree() from mkfs/main.c
>   This is already pretty usable for generic subvolume creation, the only
>   bad code is the open-coded rootdir setup.
> 
> So here this patch introduce a better version with all the benefit from
> the above implementations:
> 
> - Move btrfs_make_root_dir() into kernel-shared/root-tree.[ch]
> 
> - Implement a unified btrfs_make_subvol() to replace above two implementations
>   It would go with btrfs_create_root(), and btrfs_make_root_dir() to
>   remove duplicated code, and return a btrfs_root pointer for caller
>   to utilize.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  convert/main.c            | 55 +++++--------------------
>  kernel-shared/ctree.h     |  4 ++
>  kernel-shared/root-tree.c | 86 +++++++++++++++++++++++++++++++++++++++
>  mkfs/common.c             | 39 ------------------
>  mkfs/common.h             |  2 -
>  mkfs/main.c               | 78 +++--------------------------------
>  6 files changed, 107 insertions(+), 157 deletions(-)
> 
> diff --git a/convert/main.c b/convert/main.c
> index 73740fe26d55..453e2c003c20 100644
> --- a/convert/main.c
> +++ b/convert/main.c
> @@ -915,44 +915,6 @@ out:
>  	return ret;
>  }
>  
> -static int create_subvol(struct btrfs_trans_handle *trans,
> -			 struct btrfs_root *root, u64 root_objectid)
> -{
> -	struct extent_buffer *tmp;
> -	struct btrfs_root *new_root;
> -	struct btrfs_key key;
> -	struct btrfs_root_item root_item;
> -	int ret;
> -
> -	ret = btrfs_copy_root(trans, root, root->node, &tmp,
> -			      root_objectid);
> -	if (ret)
> -		return ret;
> -
> -	memcpy(&root_item, &root->root_item, sizeof(root_item));
> -	btrfs_set_root_bytenr(&root_item, tmp->start);
> -	btrfs_set_root_level(&root_item, btrfs_header_level(tmp));
> -	btrfs_set_root_generation(&root_item, trans->transid);
> -	free_extent_buffer(tmp);
> -
> -	key.objectid = root_objectid;
> -	key.type = BTRFS_ROOT_ITEM_KEY;
> -	key.offset = trans->transid;
> -	ret = btrfs_insert_root(trans, root->fs_info->tree_root,
> -				&key, &root_item);
> -
> -	key.offset = (u64)-1;
> -	new_root = btrfs_read_fs_root(root->fs_info, &key);
> -	if (!new_root || IS_ERR(new_root)) {
> -		error("unable to fs read root: %lu", PTR_ERR(new_root));
> -		return PTR_ERR(new_root);
> -	}
> -
> -	ret = btrfs_make_root_dir(trans, new_root, BTRFS_FIRST_FREE_OBJECTID);
> -
> -	return ret;
> -}
> -
>  /*
>   * New make_btrfs() has handle system and meta chunks quite well.
>   * So only need to add remaining data chunks.
> @@ -1012,6 +974,7 @@ static int make_convert_data_block_groups(struct btrfs_trans_handle *trans,
>  static int init_btrfs(struct btrfs_mkfs_config *cfg, struct btrfs_root *root,
>  			 struct btrfs_convert_context *cctx, u32 convert_flags)
>  {
> +	struct btrfs_root *created_root;
>  	struct btrfs_key location;
>  	struct btrfs_trans_handle *trans;
>  	struct btrfs_fs_info *fs_info = root->fs_info;
> @@ -1057,15 +1020,19 @@ static int init_btrfs(struct btrfs_mkfs_config *cfg, struct btrfs_root *root,
>  			     BTRFS_FIRST_FREE_OBJECTID);
>  
>  	/* subvol for fs image file */
> -	ret = create_subvol(trans, root, CONV_IMAGE_SUBVOL_OBJECTID);
> -	if (ret < 0) {
> -		error("failed to create subvolume image root: %d", ret);
> +	created_root = btrfs_create_subvol(trans, CONV_IMAGE_SUBVOL_OBJECTID);
> +	if (IS_ERR(created_root)) {
> +		ret = PTR_ERR(created_root);
> +		errno = -ret;
> +		error("failed to create subvolume image root: %m");
>  		goto err;
>  	}
>  	/* subvol for data relocation tree */
> -	ret = create_subvol(trans, root, BTRFS_DATA_RELOC_TREE_OBJECTID);
> -	if (ret < 0) {
> -		error("failed to create DATA_RELOC root: %d", ret);
> +	created_root = btrfs_create_subvol(trans, BTRFS_DATA_RELOC_TREE_OBJECTID);
> +	if (IS_ERR(created_root)) {
> +		ret = PTR_ERR(created_root);
> +		errno = -ret;
> +		error("failed to create DATA_RELOC root: %m");
>  		goto err;
>  	}
>  
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index 1dda40e96a60..ea459464063d 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -1134,6 +1134,10 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
>  		      *item);
>  int btrfs_find_last_root(struct btrfs_root *root, u64 objectid, struct
>  			 btrfs_root_item *item, struct btrfs_key *key);
> +int btrfs_make_root_dir(struct btrfs_trans_handle *trans,
> +			struct btrfs_root *root, u64 objectid);
> +struct btrfs_root *btrfs_create_subvol(struct btrfs_trans_handle *trans,
> +				       u64 objectid);
>  /* dir-item.c */
>  int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, struct btrfs_root
>  			  *root, const char *name, int name_len, u64 dir,
> diff --git a/kernel-shared/root-tree.c b/kernel-shared/root-tree.c
> index 33f9e4697b18..1fe7d535fdc7 100644
> --- a/kernel-shared/root-tree.c
> +++ b/kernel-shared/root-tree.c

We're moving towards a world where kernel-shared will be an exact-ish copy of
the kernel code.  Please put helpers like this in common/, I did this for
several of the extent tree related helpers we need for fsck, this is a good fit
for that.  Thanks,

Josef
