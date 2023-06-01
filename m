Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D1771F21B
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 20:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjFASai (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 14:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjFASab (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 14:30:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5149FE2;
        Thu,  1 Jun 2023 11:30:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C96456176F;
        Thu,  1 Jun 2023 18:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5194C433D2;
        Thu,  1 Jun 2023 18:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685644200;
        bh=UKT2wYQFWgvPbCbqBLMp8QEpivL9N56qu2Yss1i+ZVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M1BM/CroNCh2R0eax14T9KqzLie9WGDtS1GCw551HpQqmYREtKmxLtR0E8WDDDOBi
         TPksTHiSnmWFBZyxbs3omQZjX/u4USJV4h1kIcNzkQ9Ar4XPxPeVCfffWoiCPQsmOW
         E1k5Kz/AtjSGlVXxbxjgGCgGORnb/IW9/o2GtfRTq8KWMc/k1sUo9at1liSi4VFQvE
         yFg47Ny6an38UFxF2hPjPhaMUnKjYE4uRkZDGJILHJOvi6p3ZyhTjBMyp4e7S6fSz/
         sq20o1pBYZ3Oy9ATv8UQmsHbTVbHbfcs99n9ynthg5urlpnZ+l1KqgPBQsly8Y0pYm
         ePCMQTbu434xA==
Date:   Thu, 1 Jun 2023 11:29:57 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        ndesaulniers@google.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] btrfs: remove unused variable pages_processed
Message-ID: <20230601182957.GA3028824@dev-arch.thelio-3990X>
References: <20230530142154.3341677-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530142154.3341677-1-trix@redhat.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 30, 2023 at 10:21:54AM -0400, Tom Rix wrote:
> clang with W=1 reports
> fs/btrfs/extent_io.c:230:16: error: variable
>   'pages_processed' set but not used [-Werror,-Wunused-but-set-variable]
>         unsigned long pages_processed = 0;
>                       ^
> This variable is not used so remove it.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Caused by commit 6d6a31e7fc99 ("btrfs: split page locking out of
__process_pages_contig").

It is worth noting that while -Wunused-but-set-variable is normally
under W=1, btrfs explicitly enables it in their Makefile, so this
warning is visible during a normal build, which breaks the build with
CONFIG_WERROR.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  fs/btrfs/extent_io.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 89e093ae1c33..6919409c1183 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -227,7 +227,6 @@ static void __process_pages_contig(struct address_space *mapping,
>  	pgoff_t start_index = start >> PAGE_SHIFT;
>  	pgoff_t end_index = end >> PAGE_SHIFT;
>  	pgoff_t index = start_index;
> -	unsigned long pages_processed = 0;
>  	struct folio_batch fbatch;
>  	int i;
>  
> @@ -242,7 +241,6 @@ static void __process_pages_contig(struct address_space *mapping,
>  
>  			process_one_page(fs_info, &folio->page, locked_page,
>  					 page_ops, start, end);
> -			pages_processed += folio_nr_pages(folio);
>  		}
>  		folio_batch_release(&fbatch);
>  		cond_resched();
> -- 
> 2.27.0
> 
