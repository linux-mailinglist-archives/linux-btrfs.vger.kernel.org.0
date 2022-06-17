Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2A954F50C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 12:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381731AbiFQKNb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 06:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381751AbiFQKNY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 06:13:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B272215A03
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 03:13:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C030B82859
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 10:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB27C3411D;
        Fri, 17 Jun 2022 10:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655460801;
        bh=ZjA+Exrbppx/WpjqFvxcr4rf10XALL1VUW4gGXoQnTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kb+kKWXpGZaynMO9l6DGRzlTxRHAsWxYIFpNRPLlaVkHk3wUnq5EH5kXMGnqRjFBP
         LoH6iUdZBO5syLJZEdkpdqZQekPz2ucC/UzuyldAl/VT93+cqMMX2F36vLcj0spwQN
         YFJf32U0hbzAxM9YPo/Ojl3gTnKNayS/A3GJE2gIsp5imWcRexPrx1IqRZM1+PsHWh
         Eh6jKR3wIjhYDw1btcE+gOJI1KfAsiFngmE1TPpL2IvEtrQ5tM2umNt8TEmzl5NRVZ
         noptxy//oXtjArrmO7UM505UinhMYJ9jnFDY4BeEg8iNl/EEjJ8O91Ngdv8ZKP33gm
         nG4u+p4nrn1GQ==
Date:   Fri, 17 Jun 2022 11:13:18 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: replace unnecessary goto with direct return
Message-ID: <20220617101318.GB4041436@falcondesktop>
References: <cover.1655391633.git.naohiro.aota@wdc.com>
 <7ccae9fc6975246cbb2be58c83d9ca6e3fcbb123.1655391633.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ccae9fc6975246cbb2be58c83d9ca6e3fcbb123.1655391633.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 17, 2022 at 12:45:42AM +0900, Naohiro Aota wrote:
> The "goto out;"s in cow_file_range() just results in a simple "return
> ret;" which are not really useful. Replace them with proper direct
> "return"s. It also makes the success path vs failure path stands out.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

The subject is too generic, just adding "... at cow_file_range()" would make
it much more clear without being too long.

Thanks.

> ---
>  fs/btrfs/inode.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index cae15924fc99..055c573e2eb3 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1253,7 +1253,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  			 * inline extent or a compressed extent.
>  			 */
>  			unlock_page(locked_page);
> -			goto out;
> +			return 0;
>  		} else if (ret < 0) {
>  			goto out_unlock;
>  		}
> @@ -1366,8 +1366,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  		if (ret)
>  			goto out_unlock;
>  	}
> -out:
> -	return ret;
> +	return 0;
>  
>  out_drop_extent_cache:
>  	btrfs_drop_extent_cache(inode, start, start + ram_size - 1, 0);
> @@ -1425,7 +1424,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  					     page_ops);
>  		start += cur_alloc_size;
>  		if (start >= end)
> -			goto out;
> +			return ret;
>  	}
>  
>  	/*
> @@ -1437,7 +1436,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  	extent_clear_unlock_delalloc(inode, start, end, locked_page,
>  				     clear_bits | EXTENT_CLEAR_DATA_RESV,
>  				     page_ops);
> -	goto out;
> +	return ret;
>  }
>  
>  /*
> -- 
> 2.35.1
> 
