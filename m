Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0B1655FAD
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Dec 2022 05:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiLZERU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Dec 2022 23:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLZERS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Dec 2022 23:17:18 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538D9E68
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Dec 2022 20:17:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A6590CE0861
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Dec 2022 04:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A527C433D2;
        Mon, 26 Dec 2022 04:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672028233;
        bh=WjcgB8b9KOwVdHOgPsbxXPcn2mzQzapJEoOIrCPxgjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EEU5H8Ibkcfy7ZCh2rKd5pwsgoz++yNivMnjU8k+Omo+PG23Xjb0cvDbnRMpYrV2d
         tBuNkDhfDSeqNgIW9ktZzAVSHxlsKQkwuUAs1mnwKet1coGDx9MBIbqzNDjAEv51mO
         dpjq/e8ODjXthSXajj2dTmCOOWG/fI1Ozqrzv/v2LpcGMFYQWJN4bI4QVJZ+/IE6CT
         ybp/+nHQKDDuBKFZ79CtaXfVM/bbtG2mp0MrqxPZTMCTb5hO5BwEbkcrtO5h1282Pq
         xx/raH+oHstPd3i+KNGRz/h88tuOcsrcmnHrA9IqCLhWGeCRQW/iUzl9TUzZ5JzTRi
         REM7nrwcafBTQ==
Date:   Sun, 25 Dec 2022 21:17:11 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        llvm@lists.linux.dev
Subject: Re: [PATCH 8/8] btrfs: turn on -Wmaybe-uninitialized
Message-ID: <Y6kgR4qnb23UdAEX@dev-arch.thelio-3990X>
References: <cover.1671221596.git.josef@toxicpanda.com>
 <1d9deaa274c13665eca60dee0ccbc4b56b506d06.1671221596.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d9deaa274c13665eca60dee0ccbc4b56b506d06.1671221596.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 16, 2022 at 03:15:58PM -0500, Josef Bacik wrote:
> We had a recent bug that would have been caught by a newer compiler with
> -Wmaybe-uninitialized and would have saved us a month of failing tests
> that I didn't have time to investigate.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

This needs to be moved to the condflags section, as
-Wmaybe-uninitialized is a GCC only flag, so this breaks our builds with
clang on next-20221226:

  error: unknown warning option '-Wmaybe-uninitialized'; did you mean '-Wuninitialized'? [-Werror,-Wunknown-warning-option]

I can send a patch on Tuesday unless the original commit can be amended.

> ---
>  fs/btrfs/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index 555c962fdad6..eca995abccdf 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -7,6 +7,7 @@ subdir-ccflags-y += -Wmissing-format-attribute
>  subdir-ccflags-y += -Wmissing-prototypes
>  subdir-ccflags-y += -Wold-style-definition
>  subdir-ccflags-y += -Wmissing-include-dirs
> +subdir-ccflags-y += -Wmaybe-uninitialized
>  condflags := \
>  	$(call cc-option, -Wunused-but-set-variable)		\
>  	$(call cc-option, -Wunused-const-variable)		\
> -- 
> 2.26.3
> 
> 
