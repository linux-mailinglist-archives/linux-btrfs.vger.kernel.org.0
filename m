Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0BC7624C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 23:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjGYVtV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jul 2023 17:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjGYVtU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jul 2023 17:49:20 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C462127
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 14:49:19 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666e64e97e2so3705380b3a.1
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 14:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690321758; x=1690926558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O68PvqqV9gRBuxDZl0WOVIRv5G/X4NrMEdbh/768tzA=;
        b=WpyPx27WCr/WIbEfCSxs1Y8b4Gg4/pW0aKUoGH4ssc0OCZecu8jXj20aNS6wF3tblu
         XmuW8qKYNhzHdxjrATt9wvXBBGzM0YrZmLmiyTq3oAuvOetPDU+3f+ZlV4hRm2orFEtE
         6Y/7E3DwS9WBOPNuGwOQd0SCBuaLRzFC2vdQrxsADf3CZJ6+CcxSrtiN70KeKLvMagMy
         eXf4wX/2fWzomv+wLjuS+ruBfpILqSMX2zATgJY5tevg8w5F0h1bTnw7NcR+ZInS1hoS
         1h84VW506r3LzA6A4J8fgl+br0tUuPcuVEG5KoXcUAWT9U8qQH+ESRL+xre6zQGoA/R0
         tqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690321758; x=1690926558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O68PvqqV9gRBuxDZl0WOVIRv5G/X4NrMEdbh/768tzA=;
        b=ESk+964hwS3v1rwdVEvJv63D52OpaLKf0BQlC+6J9gm0HHK198v+mbVngfZsWd1GO2
         oZt+b2oeYxlPZjzSVn9zgXIRRyoG3UV7sc7TATCdpSIYCM8Bp2onhOTiKxo97lTnlD1b
         u/sgsidEs52n54vnlfIpRVMXjZzm8Z+JMfPeKuq3q2abuoMK9JaceFQZMAde4VBKPrmE
         ciNRCFpzNwU77vQ70RC2DjPyJmYs87uUzo/qDyi8PyW2vL24utPD6SBajS88zIWLwoEg
         /x0sa4Rb2ujtcu87bMfowN01K/WbAo6gGHzd419lM6IpkEjvFVapzAT9cHdYPzUS4GWP
         5K7A==
X-Gm-Message-State: ABy/qLY2IJp9mL2w5qmgbxEPUTTNb7x1Lpu/f7LcJZGWZXa17ztq9L1D
        epHVt9RMHXEk0lBHp52QH0bLkg==
X-Google-Smtp-Source: APBJJlEkPBc//RP5lMftBxjIlZlZ6A6JNiLvfq/eGPDXJfguV4IQ7rGDXp7ppM4o8is0I+HWifddKw==
X-Received: by 2002:a05:6a21:790a:b0:137:6958:d517 with SMTP id bg10-20020a056a21790a00b001376958d517mr263272pzc.24.1690321758506;
        Tue, 25 Jul 2023 14:49:18 -0700 (PDT)
Received: from google.com ([2620:15c:2d1:203:a7a4:bf67:c9d5:c1b7])
        by smtp.gmail.com with ESMTPSA id i2-20020a63a842000000b0055fead55e81sm11269105pgp.57.2023.07.25.14.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 14:49:18 -0700 (PDT)
Date:   Tue, 25 Jul 2023 14:49:13 -0700
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] btrfs: remove unused pages_processed variable
Message-ID: <ZMBDWbHiJVOt03u5@google.com>
References: <20230724121934.1406807-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724121934.1406807-1-arnd@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 02:19:15PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The only user of pages_processed was removed, so it's now a local write-only
> variable that can be eliminated as well:
> 
> fs/btrfs/extent_io.c:214:16: error: variable 'pages_processed' set but not used [-Werror,-Wunused-but-set-variable]
> 
> Fixes: 9480af8687200 ("btrfs: split page locking out of __process_pages_contig")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307241541.8w52nEnt-lkp@intel.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch!
Reported-by: kernelci.org bot <bot@kernelci.org>
Link: https://lore.kernel.org/llvm/64c00cd4.630a0220.6ad79.0eac@mx.google.com/
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  fs/btrfs/extent_io.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c0440a0988c9a..121edea2cfe85 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -211,7 +211,6 @@ static void __process_pages_contig(struct address_space *mapping,
>  	pgoff_t start_index = start >> PAGE_SHIFT;
>  	pgoff_t end_index = end >> PAGE_SHIFT;
>  	pgoff_t index = start_index;
> -	unsigned long pages_processed = 0;
>  	struct folio_batch fbatch;
>  	int i;
>  
> @@ -226,7 +225,6 @@ static void __process_pages_contig(struct address_space *mapping,
>  
>  			process_one_page(fs_info, &folio->page, locked_page,
>  					 page_ops, start, end);
> -			pages_processed += folio_nr_pages(folio);
>  		}
>  		folio_batch_release(&fbatch);
>  		cond_resched();
> -- 
> 2.39.2
> 
