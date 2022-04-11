Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E1F4FB652
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 10:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiDKIv1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 04:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiDKIv1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 04:51:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D92E2
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 01:49:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3172F61550
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 08:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960D6C385AC
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 08:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649666951;
        bh=taawvodZ6v+rAzrCtXG3PvZJT4/xYilgzfGTfoSJz2M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UdQlQhEy7B1NJbCtYtp7VplmH4VWYYV6B5Zm3C8IiXFEqcbrGv2D2ImkWsVuNNLFa
         p/I/vr83dbNe0SgAAHVtlSSuuScTBkg9Eo+hULh/l/q36UjwpztdmqY4VdCAtszqoO
         ueXtTDoIt4IYtNM+HJGzCex2ga0yTKNhKta0stJGKzeRwocWrjFUJot9pCTfaf8Ht4
         yEFfgO0Sj4BZB6o8lRexXcNE/BMndxLyKIuIUQXv6hh3KZrMG+VC6x3In/gOOnXQJL
         Fteg5itOg8Lziux6SvRfRr945vLNf2GnMWY8tqPi/l1JvdfLmjXd289Lgdqn1XZeC3
         nbjAe0ikujYsg==
Received: by mail-qv1-f48.google.com with SMTP id kl29so12695395qvb.2
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 01:49:11 -0700 (PDT)
X-Gm-Message-State: AOAM530mfIhi4X8bKSHw+ugpRRxpNZ7o+zXruyaaT3v5IcjR5w8wyya4
        tzMOX4kcK+1kUxw+x4mfnSEaiYypuNT7436LqTQ=
X-Google-Smtp-Source: ABdhPJzgOfshYKAHWlTWRchJ3VQeB8CtuW4ZChaIwTa3Qlusb44WiyhDCx6EKYjhOfUQvr2c0F7HvWmk6nwoU0bCTsI=
X-Received: by 2002:a05:6214:f6d:b0:443:f201:aac9 with SMTP id
 iy13-20020a0562140f6d00b00443f201aac9mr22966626qvb.1.1649666950565; Mon, 11
 Apr 2022 01:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220409043432.1244773-1-cccheng@synology.com>
In-Reply-To: <20220409043432.1244773-1-cccheng@synology.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 11 Apr 2022 09:48:34 +0100
X-Gmail-Original-Message-ID: <CAL3q7H77p6yFhHMu-1kpgh+J5jv_dKeqqwga8mJMRXY6r0wAvg@mail.gmail.com>
Message-ID: <CAL3q7H77p6yFhHMu-1kpgh+J5jv_dKeqqwga8mJMRXY6r0wAvg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not allow compression on nocow files
To:     Chung-Chiang Cheng <cccheng@synology.com>
Cc:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, shepjeng@gmail.com,
        kernel@cccheng.net, Jayce Lin <jaycelin@synology.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 9, 2022 at 10:14 AM Chung-Chiang Cheng <cccheng@synology.com> wrote:
>
> Compression and nocow are mutually exclusive. Besides ioctl, there is
> another way to enable/disable/reset compression directly via xattr. The
> following steps will result in a invalid combination.
>
>   $ touch bar
>   $ lsattr bar
>   ---------------C-- bar

The example should show how the NOCOW attribute ended up in the file.
Either the filesystem mounted with -o nodatacow or a chattr +C was
done on the file bar before the lsattr command.

>   $ setfattr -n btrfs.compression -v zstd bar
>   $ lsattr bar
>   --------c------C-- bar
>
> Reported-by: Jayce Lin <jaycelin@synology.com>
> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>

The changelog should mention what happens if we end up both with
compression and nodatacow set on a file.
Will all future writes be compressed and nodatacow have no effect? Or
will compression have no effect and we nodatacow overrides it?
Or something else? Some corruption, some crash, etc?

> ---
>  fs/btrfs/props.c | 20 ++++++++++++--------
>  fs/btrfs/props.h |  3 ++-
>  fs/btrfs/xattr.c |  2 +-
>  3 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
> index 1a6d2d5b4b33..fde2bf069b03 100644
> --- a/fs/btrfs/props.c
> +++ b/fs/btrfs/props.c
> @@ -17,7 +17,7 @@ static DEFINE_HASHTABLE(prop_handlers_ht, BTRFS_PROP_HANDLERS_HT_BITS);
>  struct prop_handler {
>         struct hlist_node node;
>         const char *xattr_name;
> -       int (*validate)(const char *value, size_t len);
> +       int (*validate)(struct inode *inode, const char *value, size_t len);
>         int (*apply)(struct inode *inode, const char *value, size_t len);
>         const char *(*extract)(struct inode *inode);
>         int inheritable;
> @@ -55,7 +55,8 @@ find_prop_handler(const char *name,
>         return NULL;
>  }
>
> -int btrfs_validate_prop(const char *name, const char *value, size_t value_len)
> +int btrfs_validate_prop(struct inode *inode, const char *name,

The inode can be made const.
The validation handler should never need to change anything in the inode.

Also, we can use struct btrfs_inode * instead of struct inode (preferred).

> +                       const char *value, size_t value_len)
>  {
>         const struct prop_handler *handler;
>
> @@ -69,7 +70,7 @@ int btrfs_validate_prop(const char *name, const char *value, size_t value_len)
>         if (value_len == 0)
>                 return 0;
>
> -       return handler->validate(value, value_len);
> +       return handler->validate(inode, value, value_len);
>  }
>
>  int btrfs_set_prop(struct btrfs_trans_handle *trans, struct inode *inode,
> @@ -252,18 +253,21 @@ int btrfs_load_inode_props(struct inode *inode, struct btrfs_path *path)
>         return ret;
>  }
>
> -static int prop_compression_validate(const char *value, size_t len)
> +static int prop_compression_validate(struct inode *inode, const char *value, size_t len)

Same here, about const and using struct btrfs_inode * instead.

>  {
>         if (!value)
>                 return 0;
>
> -       if (btrfs_compress_is_valid_type(value, len))
> -               return 0;
> -
>         if ((len == 2 && strncmp("no", value, 2) == 0) ||
>             (len == 4 && strncmp("none", value, 4) == 0))
>                 return 0;
>
> +       if (!inode || BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW)

How can inode ever be NULL?
Unless I missed something, it can't be NULL.

We should also get a test case for fstests, to help prevent
regressions in the future.

Otherwise it looks fine.

Thanks.




> +               return -EINVAL;
> +
> +       if (btrfs_compress_is_valid_type(value, len))
> +               return 0;
> +
>         return -EINVAL;
>  }
>
> @@ -364,7 +368,7 @@ static int inherit_props(struct btrfs_trans_handle *trans,
>                  * This is not strictly necessary as the property should be
>                  * valid, but in case it isn't, don't propagate it further.
>                  */
> -               ret = h->validate(value, strlen(value));
> +               ret = h->validate(inode, value, strlen(value));
>                 if (ret)
>                         continue;
>
> diff --git a/fs/btrfs/props.h b/fs/btrfs/props.h
> index 40b2c65b518c..0504c03177e3 100644
> --- a/fs/btrfs/props.h
> +++ b/fs/btrfs/props.h
> @@ -13,7 +13,8 @@ void __init btrfs_props_init(void);
>  int btrfs_set_prop(struct btrfs_trans_handle *trans, struct inode *inode,
>                    const char *name, const char *value, size_t value_len,
>                    int flags);
> -int btrfs_validate_prop(const char *name, const char *value, size_t value_len);
> +int btrfs_validate_prop(struct inode *inode, const char *name,
> +                       const char *value, size_t value_len);
>
>  int btrfs_load_inode_props(struct inode *inode, struct btrfs_path *path);
>
> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> index 99abf41b89b9..9aceae07a02b 100644
> --- a/fs/btrfs/xattr.c
> +++ b/fs/btrfs/xattr.c
> @@ -403,7 +403,7 @@ static int btrfs_xattr_handler_set_prop(const struct xattr_handler *handler,
>         struct btrfs_root *root = BTRFS_I(inode)->root;
>
>         name = xattr_full_name(handler, name);
> -       ret = btrfs_validate_prop(name, value, size);
> +       ret = btrfs_validate_prop(inode, name, value, size);
>         if (ret)
>                 return ret;
>
> --
> 2.34.1
>
