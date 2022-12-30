Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C197659B30
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Dec 2022 19:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiL3SCz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Dec 2022 13:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiL3SCz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Dec 2022 13:02:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DCC178B5;
        Fri, 30 Dec 2022 10:02:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB48BB81BFF;
        Fri, 30 Dec 2022 18:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CEBC433EF;
        Fri, 30 Dec 2022 18:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672423371;
        bh=dU/4Pv/AsYdZCFgnxqG06UuR7FIxiOj383GZLqs7CKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YVke1mwrwckJqTSC5qFg3iSO4PnnvFhrY3huSdAsyQpsi2HgA2xA6pLEfJstspZmA
         h8+JnKHdAocxme4TS58wtSQ6juanTAXkDu1P63GtTWmbRYAaWpOIPaLLLTNevk30sI
         byXYp2xoIHivnWvKR65suF8t8qXpFR4r0xIqOiE6NqeGaVce2bEZ8HgG0gupjk1Gsm
         eRLaAzJQFYTkR2M2Ync6J68fZ+baosDbbm4CARayJc3wmN+6nu6UGqHbAld3osQWuW
         M0/QqOE014vl873Otu5eNB9NRIPe1lSeCD10WOdkYovuYfitC4dbEG+yhZ4REFpfND
         jKqgu8XSgCsag==
Date:   Fri, 30 Dec 2022 11:02:49 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        ndesaulniers@google.com, wqu@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] btrfs: handle -Wmaybe-uninitialized with clang
Message-ID: <Y68nyfHNXieotO+C@dev-arch.thelio-3990X>
References: <20221230175507.1630431-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230175507.1630431-1-trix@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 30, 2022 at 12:55:07PM -0500, Tom Rix wrote:
> The clang build reports this error
> error: unknown warning option '-Wmaybe-uninitialized'; did you mean '-Wuninitialized'? [-Werror,-Wunknown-warning-option]
> make[3]: *** [scripts/Makefile.build:252: fs/btrfs/super.o] Error 1
> 
> -Wmaybe-uninitialized is a gcc only flag.  Move to setting with cc-option.
> 
> Fixes: 1b19c4c249a1 ("btrfs: turn on -Wmaybe-uninitialized")
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks for the patch! Looks like I forgot to double back to this...

https://lore.kernel.org/Y6kgR4qnb23UdAEX@dev-arch.thelio-3990X/

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  fs/btrfs/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index eca995abccdf..460eced3f5bd 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -7,12 +7,12 @@ subdir-ccflags-y += -Wmissing-format-attribute
>  subdir-ccflags-y += -Wmissing-prototypes
>  subdir-ccflags-y += -Wold-style-definition
>  subdir-ccflags-y += -Wmissing-include-dirs
> -subdir-ccflags-y += -Wmaybe-uninitialized
>  condflags := \
>  	$(call cc-option, -Wunused-but-set-variable)		\
>  	$(call cc-option, -Wunused-const-variable)		\
>  	$(call cc-option, -Wpacked-not-aligned)			\
> -	$(call cc-option, -Wstringop-truncation)
> +	$(call cc-option, -Wstringop-truncation)		\
> +	$(call cc-option, -Wmaybe-uninitialized)
>  subdir-ccflags-y += $(condflags)
>  # The following turn off the warnings enabled by -Wextra
>  subdir-ccflags-y += -Wno-missing-field-initializers
> -- 
> 2.27.0
> 
