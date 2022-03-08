Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CAF4D1BBA
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 16:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242617AbiCHPa5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 10:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239349AbiCHPa5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 10:30:57 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728984E399
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 07:30:00 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id bm39so15136004qkb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Mar 2022 07:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GgCyc6YCROLJSoyI0HIShhTHa5s8Kb0k+a/Ryn9scoQ=;
        b=tQ9F1/b5PBtgD4wRLsD8nQgJgumsdYUg9+tZ4LSJ5V964gKkJYaNR6z8mvLek0aWOn
         51sVxahLev2fmrvlD5cviQ1dDG+okqotwJRfQf8oAuI05v1/SF8pnTOz9BYMzafZ7ywo
         Bpi+quAlp902+ws1L9xQm1YHwDfGYGlgAh8EhobIE7pi7j6bHCdUgmK1iRkntf7+eE2G
         9OL/nSKQzFS99rJWdUyRc+pFQPnI6BmPOVl9k8vsLiPonQKX1YK0HAyEYWbNb0qL+Cez
         N+8nL2bX18VRrPJCVUKuSk4AnHWrZW9IN20pIKgjJ2x7mW4m5oE7+gAm+ofJLGHlx7tj
         o0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GgCyc6YCROLJSoyI0HIShhTHa5s8Kb0k+a/Ryn9scoQ=;
        b=0041Eexhe16nG8CLZMTe3XHeRl6TiWOEYD4zgLdEkeUcFSF8TNzcaBwtOmWGbfvYsr
         9EbXhfnbE8j3BK0ca+eEtFrZXtqWPuo+T7Hpjs8RKDR4qiFe5UQ9CpGQNMiwJenj8j+d
         RkAAJ1qA/R2kT5oF16L1m5VCVFGV26DAnikex6/Q2AIZLHIf7AZCB2OUtkUYGxjKudvy
         kFZ0KknMNe709VlerDfo2qJVHPNC6EF4uFYfX0LrU4+Oyt/k0R0bODW7Isu5x0n+iP+i
         ah6fDHVAVBBwUgBjGi1xM5sKKTCP8KPG8jG5Jm8pkphxtDyDo6uZWbOFKGwtdwY79Qyx
         aTEQ==
X-Gm-Message-State: AOAM533YIps0wJw1EGitSRrYSHvm+yvT672KhVfx0S3cwHeO0hNi8yhD
        maos7hfs3Z/WGjYZ23C+BNpQSHjzRHYaRWsS
X-Google-Smtp-Source: ABdhPJxPtBo5QXzBzVTl+IXlRQSIszleVvSRIpjhzGuGlGamZl+G73BLeIbaLc9zjLnde2zisycgFw==
X-Received: by 2002:a05:620a:709:b0:67d:15b0:3b87 with SMTP id 9-20020a05620a070900b0067d15b03b87mr2789030qkc.242.1646753399433;
        Tue, 08 Mar 2022 07:29:59 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c16-20020a05622a059000b002dc93dc92d1sm10952918qtb.48.2022.03.08.07.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 07:29:58 -0800 (PST)
Date:   Tue, 8 Mar 2022 10:29:57 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH v3 12/14] btrfs: Use btrfs_for_each_slot in
 btrfs_unlink_all_paths
Message-ID: <Yid2deUv+q/XyQp1@localhost.localdomain>
References: <20220302164829.17524-1-gniebler@suse.com>
 <20220302164829.17524-13-gniebler@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302164829.17524-13-gniebler@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 02, 2022 at 05:48:27PM +0100, Gabriel Niebler wrote:
> This function can be simplified by refactoring to use the new iterator macro.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> Signed-off-by: Gabriel Niebler <gniebler@suse.com>
> ---
>  fs/btrfs/send.c | 36 +++++++++++++-----------------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 7e40c73bb912..af3668279875 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -6119,8 +6119,11 @@ static int btrfs_unlink_all_paths(struct send_ctx *sctx)
>  {
>  	LIST_HEAD(deleted_refs);
>  	struct btrfs_path *path;
> +	struct btrfs_root *root = sctx->parent_root;
>  	struct btrfs_key key;
> +	struct btrfs_key found_key;
>  	struct parent_paths_ctx ctx;
> +	int iter_ret = 0;
>  	int ret;
>  
>  	path = alloc_path_for_send();
> @@ -6130,39 +6133,26 @@ static int btrfs_unlink_all_paths(struct send_ctx *sctx)
>  	key.objectid = sctx->cur_ino;
>  	key.type = BTRFS_INODE_REF_KEY;
>  	key.offset = 0;
> -	ret = btrfs_search_slot(NULL, sctx->parent_root, &key, path, 0, 0);
> -	if (ret < 0)
> -		goto out;
>  
>  	ctx.refs = &deleted_refs;
>  	ctx.sctx = sctx;
>  
> -	while (true) {
> -		struct extent_buffer *eb = path->nodes[0];
> -		int slot = path->slots[0];
> -
> -		if (slot >= btrfs_header_nritems(eb)) {
> -			ret = btrfs_next_leaf(sctx->parent_root, path);
> -			if (ret < 0)
> -				goto out;
> -			else if (ret > 0)
> -				break;
> -			continue;
> -		}
> -
> -		btrfs_item_key_to_cpu(eb, &key, slot);
> -		if (key.objectid != sctx->cur_ino)
> +	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
> +		if (found_key.objectid != key.objectid)
>  			break;
> -		if (key.type != BTRFS_INODE_REF_KEY &&
> -		    key.type != BTRFS_INODE_EXTREF_KEY)
> +		if (found_key.type != key.type &&
> +		    found_key.type != BTRFS_INODE_EXTREF_KEY)
>  			break;
>  
> -		ret = iterate_inode_ref(sctx->parent_root, path, &key, 1,
> +		ret = iterate_inode_ref(root, path, &key, 1,
>  					record_parent_ref, &ctx);

This patch is causing btrfs/168 to fail, this should be &found_key, not &key.
Thanks,

Josef
