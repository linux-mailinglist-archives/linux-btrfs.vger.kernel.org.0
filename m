Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6FF225256
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jul 2020 16:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgGSOyh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jul 2020 10:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgGSOyg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jul 2020 10:54:36 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FBAC0619D2
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jul 2020 07:54:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a15so490961wrh.10
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jul 2020 07:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=Gla6+7qMQqHa0RS+l4OqcNKjsd4holet0hTT/50IEp4=;
        b=O7zw2W6/F0OEEZDpp2hJcgkfpKrXcmcxEo1HomnxP9AHYYP53HoMuXMyIu/HLuwG9p
         abFWd0ltBQDMJ0Eq1ESeNq47XK4bjYj4xjk5kgwilDUr8C8UduSyA180ol4qdxaAhBjn
         PTHn2OEwqqR52TGiDA6Z69VnqHUFiSL90Up1bfi40woXvbQxKL4TpRUVeLWKSY798Cpm
         oTTwN/rwmYx1iEj91Zb0VN7hn2ibDTYpXW+CgMCvAjue9/yDsSBj+JYE61t5pVxb+mKM
         Mg6nFXNsBsbarU4zconMllmnsWmxPa5M2tT3Rawxf9bXg92NOUnXMY2qrl4IOdBoFUwQ
         ICZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Gla6+7qMQqHa0RS+l4OqcNKjsd4holet0hTT/50IEp4=;
        b=ji8+6UD970GEkMq4tqCglqqLTNuY8mDVTGomkawzJrQfEHB9hFU575u1A4H2ByRGmq
         W0rP8sSaMXhFUQSLLGCmBj6xnORnjmQUke0Rm5/H7d4dtDH5GFNmwRgGQbGm87BrQy3b
         xvLxCrtfln1dbZijrwL64PdhLPeS0F1Imj/fgvh/Vb/BwfWDJFvlmpc+skuz3h6k7iAV
         LIxtPyd9vKEQQSjwv0u/eVCcafHC0Jk8C9VbDUBYIyw6AP+K89SWudm3f4hFCwMCb6Am
         MCzOW9X811fjsd6Ghs26BGXKBgqI0CzoGphvwPp4+DaUr4X2TWSrg0L8DJp4ilGLQcSP
         TB3Q==
X-Gm-Message-State: AOAM5314zu7/5tc3TW0JytCTk6EXfmOD/TmAX181kgcQ7bONcEjlZ76F
        /90jMFKn1JhcLa/Td/llN+BlravW
X-Google-Smtp-Source: ABdhPJwQFyu9qPgpRLopwgonPC1rcI2ElUt/QJpEl3B+E4us6x6LB3abXgMKdEeefQOoI85i7TQMMg==
X-Received: by 2002:adf:a34a:: with SMTP id d10mr18448905wrb.59.1595170474943;
        Sun, 19 Jul 2020 07:54:34 -0700 (PDT)
Received: from igors-t480s (cst-prg-76-121.cust.vodafone.cz. [46.135.76.121])
        by smtp.gmail.com with ESMTPSA id x1sm26757585wrp.10.2020.07.19.07.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 07:54:34 -0700 (PDT)
Message-ID: <4ff16d6d05508c1a4599a4116ac1a936ffb21e59.camel@gmail.com>
Subject: Re: [RFC][PATCH] btrfs: add an autodefrag property
From:   Igor Raits <igor.raits@gmail.com>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, chris@colorremedies.com
Date:   Sun, 19 Jul 2020 16:54:32 +0200
In-Reply-To: <20200717204221.2285627-1-josef@toxicpanda.com>
References: <20200717204221.2285627-1-josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.37.3 (3.37.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Fri, 2020-07-17 at 16:42 -0400, Josef Bacik wrote:
> Autodefrag is very useful for somethings, like the 9000 sqllite files
> that Firefox uses, but is way less useful for virt images.
> Unfortunately this is only available currently as a whole mount
> option.
> Fix this by adding an "autodefrag" property, that users can set on a
> per
> file or per directory basis.  Thus allowing them to control where
> exactly the extra write activity is going to occur.

This would be cool so that openSUSE could drop their autodefrag plugin
for zypper (essentially forces defragmentation of rpmdb) and we could
write some code to set this property for RPMDB inside RPM itself.

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> - This is an RFC because I want to make sure we're ok with this
> before I go and
>   add btrfs-progs support for this.  I'm not married to the name or
> the value,
>   but I think the core goal is valuable.
> 
>  fs/btrfs/btrfs_inode.h |  1 +
>  fs/btrfs/file.c        | 16 ++++++++++------
>  fs/btrfs/props.c       | 41
> +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index e7d709505cb1..4f04f0535f90 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -31,6 +31,7 @@ enum {
>  	BTRFS_INODE_READDIO_NEED_LOCK,
>  	BTRFS_INODE_HAS_PROPS,
>  	BTRFS_INODE_SNAPSHOT_FLUSH,
> +	BTRFS_INODE_AUTODEFRAG,
>  };
>  
>  /* in memory btrfs inode */
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 841c516079a9..cac2092bdcdf 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -116,12 +116,16 @@ static int __btrfs_add_inode_defrag(struct
> btrfs_inode *inode,
>  	return 0;
>  }
>  
> -static inline int __need_auto_defrag(struct btrfs_fs_info *fs_info)
> +static inline int __need_auto_defrag(struct btrfs_fs_info *fs_info,
> +				     struct btrfs_inode *inode)
>  {
> -	if (!btrfs_test_opt(fs_info, AUTO_DEFRAG))
> +	if (btrfs_fs_closing(fs_info))
>  		return 0;
>  
> -	if (btrfs_fs_closing(fs_info))
> +	if (inode && test_bit(BTRFS_INODE_AUTODEFRAG, &inode-
> >runtime_flags))
> +		return 1;
> +
> +	if (!btrfs_test_opt(fs_info, AUTO_DEFRAG))
>  		return 0;
>  
>  	return 1;
> @@ -140,7 +144,7 @@ int btrfs_add_inode_defrag(struct
> btrfs_trans_handle *trans,
>  	u64 transid;
>  	int ret;
>  
> -	if (!__need_auto_defrag(fs_info))
> +	if (!__need_auto_defrag(fs_info, inode))
>  		return 0;
>  
>  	if (test_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags))
> @@ -187,7 +191,7 @@ static void btrfs_requeue_inode_defrag(struct
> btrfs_inode *inode,
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  	int ret;
>  
> -	if (!__need_auto_defrag(fs_info))
> +	if (!__need_auto_defrag(fs_info, inode))
>  		goto out;
>  
>  	/*
> @@ -348,7 +352,7 @@ int btrfs_run_defrag_inodes(struct btrfs_fs_info
> *fs_info)
>  			     &fs_info->fs_state))
>  			break;
>  
> -		if (!__need_auto_defrag(fs_info))
> +		if (btrfs_fs_closing(fs_info))
>  			break;
>  
>  		/* find an inode to defrag */
> diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
> index 2dcb1cb21634..5c6411c8b19f 100644
> --- a/fs/btrfs/props.c
> +++ b/fs/btrfs/props.c
> @@ -310,6 +310,40 @@ static const char
> *prop_compression_extract(struct inode *inode)
>  	return NULL;
>  }
>  
> +static int prop_autodefrag_validate(const char *value, size_t len)
> +{
> +	if (!value)
> +		return 0;
> +	if (!strncmp("true", value, 4))
> +		return 0;
> +	return -EINVAL;
> +}
> +
> +static int prop_autodefrag_apply(struct inode *inode, const char
> *value,
> +				 size_t len)
> +{
> +	if (len == 0) {
> +		clear_bit(BTRFS_INODE_AUTODEFRAG,
> +			  &BTRFS_I(inode)->runtime_flags);
> +		return 0;
> +	}
> +
> +	if (!strncmp("true", value, 4)) {
> +		set_bit(BTRFS_INODE_AUTODEFRAG,
> +			&BTRFS_I(inode)->runtime_flags);
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const char *prop_autodefrag_extract(struct inode *inode)
> +{
> +	if (test_bit(BTRFS_INODE_AUTODEFRAG, &BTRFS_I(inode)-
> >runtime_flags))
> +		return "true";
> +	return NULL;
> +}
> +
>  static struct prop_handler prop_handlers[] = {
>  	{
>  		.xattr_name = XATTR_BTRFS_PREFIX "compression",
> @@ -318,6 +352,13 @@ static struct prop_handler prop_handlers[] = {
>  		.extract = prop_compression_extract,
>  		.inheritable = 1
>  	},
> +	{
> +		.xattr_name = XATTR_BTRFS_PREFIX "autodefrag",
> +		.validate = prop_autodefrag_validate,
> +		.apply = prop_autodefrag_apply,
> +		.extract = prop_autodefrag_extract,
> +		.inheritable = 1
> +	},
>  };
>  
>  static int inherit_props(struct btrfs_trans_handle *trans,

- -- 
Igor Raits <igor.raits@gmail.com>
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEcwgJ58gsbV5f5dMcEV1auJxcHh4FAl8UXqgACgkQEV1auJxc
Hh7QpxAAmC5pEaP1WTQQgfb+tS+pww2ln+Vk/3yTBRjOapyvisk7FIs4evPLlKFW
kIGb2q+FsGTZ+f/8PWXEcXJSU2HSXYv3dbHh6gp6/ZFKMjZPAoxnErFTDx2ZT1af
0GcmKJdpV8RS24qQjs+cORnzOPF1HAyBSL6qHEfpdzkws1LmJXvPOxsToVV24h1D
JKaCH3XdIRLf4JXuLyRup0ASpspA1oENHLr6+YcoQjN8IVTNjPaBdJcz+VkFarEi
tIwWMJr3A6e1yFWkKldt3HBMtMR+QLWYga3b8d2tROZ2bAsU+JXeWtyUmBONx++r
japV9wSquPEj7ht2QH58VsisU68tSFHqyyaGJ5a6CV6BsMkF5KhArK971F3Du3xl
te8A5HVvSOnNLzHllhklMehDN2e0qsTjeZaU9DniCV1OkS5F8SNXftJ25YWJtrba
mdchFezuXwcQzfC/G5WSZK+6YDNb/Gnind+rkV8fgtz7JiuVpluR3EMZMVD0mMN8
ahZH86xw+78VZeQ/4Q1FGjS+BrDVakn8cGKjSUjJAFF+owx1aXIPByObIKAKd6rf
lEmsaPWj0roM81PU+93BxN16Ti8s9wzEM1eoBEmhVrFCKsKt7iSJ+ZJyLRpPIRCZ
qAexm0iOKCxY8EMa0A7XbCxcvDSw6NXjwgbkNqFQRd4286uDdsk=
=kcj9
-----END PGP SIGNATURE-----

