Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBFB776A0B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 22:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjHIUcZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 16:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjHIUcY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 16:32:24 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145842109
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 13:32:24 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-56cd753b31cso194475eaf.1
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Aug 2023 13:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1691613143; x=1692217943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+9jbhv5iRSaWahybEFEapetYSXwpFObzgRbUr4w/3LU=;
        b=ZmYrxpioYeC/sNqa8TuxEzWvBdzWiiYBoMwXDhZplnQJNCwcRehDNxsQhuLEIUJpDO
         J0yHseO8uOcmmOzVISmgU1GICJ1poa+ljjmTQ5r8ZYCLC0VOQeVi0jzZiffFWoAuIcW4
         YQe9aCqWCryinhGixGOGCYCNgNEXEC8bL+Rq+5yGTBjsDA3dCk4FgL1LF7Pc98VrqVAT
         U3nu0s9cweuqNP58OnOapz83SO8mk5CfNbWWRjQeec1+IPc0rxdI/xDf5yPN+d/56lAQ
         nV235jQPQD12pb0IEwA0ws8b8MRnoFgM3m2HCnjD0M/w7SbOuoE+DdP8rkMCEadJEof5
         BgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691613143; x=1692217943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9jbhv5iRSaWahybEFEapetYSXwpFObzgRbUr4w/3LU=;
        b=G3LSxQ9rQ5WEwKOd1VFXjMt6fGJ6MqfJJmRELguANUJTdDVzObCHwTaqC5ylndkuD1
         friwrpJDEcB9O6V5QK2AbKrIm2FYKa23P4N+yfjjIeah2sahz12NN3BEM7rEbFaO7ThV
         bqTkQQhuWpKJLWZFWZYp6afkb0c7EWQyZ8tLZxM02UTK+ZSta0AWO/GBC7hM2eQwaKo7
         lXyXY0lHc/6R2bPDF31eZc9mRs0NYy14FZveVVk4yQGVPi0OtyBkGmtIKVgxGIiD1fkz
         UxEmjqtLNWVcitJbm/k4hREdLBUmUvHaGKpIxTHPEswSGRXBeTbq6QDuSGiyxEZcDD/x
         c69Q==
X-Gm-Message-State: AOJu0YzMemsxD/vcqPR1skgw7QQxF2WuOv/9uqbwBrNs77qx5fi4tC3x
        3Xuo36NF1W0eXPgKjVZZfmkvhA==
X-Google-Smtp-Source: AGHT+IGL0LQa9K0sU2gf72cgP6x+lj3Qa1yKmUqyQ+DHO1R9zWsJSdmQWesQ7t/xoKPVJYT/J1sdlQ==
X-Received: by 2002:a05:6808:14d2:b0:3a7:72e2:f6be with SMTP id f18-20020a05680814d200b003a772e2f6bemr632147oiw.2.1691613143307;
        Wed, 09 Aug 2023 13:32:23 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c6-20020ae9e206000000b0076ce477b85dsm4177208qkc.134.2023.08.09.13.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:32:22 -0700 (PDT)
Date:   Wed, 9 Aug 2023 16:32:21 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@meta.com,
        linux-btrfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v3 08/17] btrfs: handle nokey names.
Message-ID: <20230809203221.GC2561679@perftesting>
References: <cover.1691510179.git.sweettea-kernel@dorminy.me>
 <adfd6682729107364481959f2ee4850c276ce211.1691510179.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adfd6682729107364481959f2ee4850c276ce211.1691510179.git.sweettea-kernel@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_FILL_THIS_FORM_SHORT autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 08, 2023 at 01:12:10PM -0400, Sweet Tea Dorminy wrote:
> For encrypted or unencrypted names, we calculate the offset for the dir
> item by hashing the name for the dir item. However, this doesn't work
> for a long nokey name, where we do not have the complete ciphertext.
> Instead, fscrypt stores the filesystem-provided hash in the nokey name,
> and we can extract it from the fscrypt_name structure in such a case.
> 
> Additionally, for nokey names, if we find the nokey name on disk we can
> update the fscrypt_name with the disk name, so add that to searching for
> diritems.
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
>  fs/btrfs/dir-item.c | 37 +++++++++++++++++++++++++++++++++++--
>  fs/btrfs/fscrypt.c  | 27 +++++++++++++++++++++++++++
>  fs/btrfs/fscrypt.h  | 11 +++++++++++
>  3 files changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
> index da95ae411d72..ee7dad888f53 100644
> --- a/fs/btrfs/dir-item.c
> +++ b/fs/btrfs/dir-item.c
> @@ -231,6 +231,28 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
>  	return di;
>  }
>  
> +/*
> + * If appropriate, populate the disk name for a fscrypt_name looked up without
> + * a key.
> + *
> + * @path:	The path to the extent buffer in which the name was found.
> + * @di:		The dir item corresponding.
> + * @fname:	The fscrypt_name to perhaps populate.
> + *
> + * Returns: 0 if the name is already populated or the dir item doesn't exist
> + * or the name was successfully populated, else an error code.
> + */
> +static int ensure_disk_name_from_dir_item(struct btrfs_path *path,
> +					  struct btrfs_dir_item *di,
> +					  struct fscrypt_name *name)
> +{
> +	if (name->disk_name.name || !di)
> +		return 0;
> +
> +	return btrfs_fscrypt_get_disk_name(path->nodes[0], di,
> +					   &name->disk_name);
> +}
> +
>  /*
>   * Lookup for a directory item by fscrypt_name.
>   *
> @@ -257,8 +279,12 @@ struct btrfs_dir_item *btrfs_lookup_dir_item_fname(struct btrfs_trans_handle *tr
>  
>  	key.objectid = dir;
>  	key.type = BTRFS_DIR_ITEM_KEY;
> -	key.offset = btrfs_name_hash(name->disk_name.name, name->disk_name.len);
> -	/* XXX get the right hash for no-key names */
> +
> +	if (!name->disk_name.name)
> +		key.offset = name->hash | ((u64)name->minor_hash << 32);
> +	else
> +		key.offset = btrfs_name_hash(name->disk_name.name,
> +					     name->disk_name.len);
>  
>  	ret = btrfs_search_slot(trans, root, &key, path, mod, -mod);
>  	if (ret == 0)
> @@ -266,6 +292,8 @@ struct btrfs_dir_item *btrfs_lookup_dir_item_fname(struct btrfs_trans_handle *tr
>  
>  	if (ret == -ENOENT || (di && IS_ERR(di) && PTR_ERR(di) == -ENOENT))
>  		return NULL;
> +	if (ret == 0)
> +		ret = ensure_disk_name_from_dir_item(path, di, name);
>  	if (ret < 0)
>  		di = ERR_PTR(ret);
>  
> @@ -382,7 +410,12 @@ btrfs_search_dir_index_item(struct btrfs_root *root, struct btrfs_path *path,
>  	btrfs_for_each_slot(root, &key, &key, path, ret) {
>  		if (key.objectid != dirid || key.type != BTRFS_DIR_INDEX_KEY)
>  			break;
> +
>  		di = btrfs_match_dir_item_fname(root->fs_info, path, name);
> +		if (di)
> +			ret = ensure_disk_name_from_dir_item(path, di, name);
> +		if (ret)
> +			break;

This is a little wonky, I'd rather just

if (!di)
	continue;
ret = ensure_disk_name_from_dir_item(path, di, name);
if (ret)
	break
return di;

Thanks,

Josef
