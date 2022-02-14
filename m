Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188F74B4DEC
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Feb 2022 12:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350671AbiBNLR0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Feb 2022 06:17:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347431AbiBNLQ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Feb 2022 06:16:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA726C91F
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Feb 2022 02:48:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EFB260E83
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Feb 2022 10:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1267EC340E9;
        Mon, 14 Feb 2022 10:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644835681;
        bh=EFLw+6/XhRXnh3+1WGY9FLxu999qxRV3irOEs4aeX1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qg8TH9LacWcVYXl1MRuCuAiYHhrprH+C9AkgJAoquPRNqUd5ceeazTal7x8BacXEb
         MSHE2i653NEg+YYr2+SMbji28HT7XI1yKWg6m1r8lutgfnyjdlkWTY1ZI8E/qlpwJ5
         WqWN0hAm4fwuTp2rvA2LeRHMG6WdAjUDFGtOm6HX5JiXZsx0BHbNaIr6m+sj3SNBP5
         O5MfMoKgvJhS2BtTRkbmTAvGMvohYSrJ/GQKFqKEyW5ClwY6bS2/dCY4+XBaiyLnxj
         fmjMLpc6r39ybha3lotuKfyb9nzb3WeRDcV5vD0CNwP9Irpm7ajAteab1gXkxE71qr
         nYr6ZSFd/XCow==
Date:   Mon, 14 Feb 2022 10:47:58 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: do not SetPageError on a read error for
 extent buffers
Message-ID: <YgozXnBw6EN7X82j@debian9.Home>
References: <cover.1644596294.git.josef@toxicpanda.com>
 <0682dfc75f9d32f4cb4152f6547a5fc4ef23d575.1644596294.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0682dfc75f9d32f4cb4152f6547a5fc4ef23d575.1644596294.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 11, 2022 at 11:24:38AM -0500, Josef Bacik wrote:
> For reads the page is marked !uptodate and that indicates that there was
> a problem.  We should only be using SetPageError for write errors, and
> in fact do that everywhere except for extent buffer reads.  

We are also doing that for data page reads, at end_page_read() - we clear
the uptodate bit from the page and then set the error bit as well. So it
needs to be fixed as well.

> Fix this so
> we maintain that PageError == write error.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/extent_io.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 16b6820c913d..bb3c29984fcd 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -6671,7 +6671,6 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
>  				 * i.e unlock page/set error bit.
>  				 */
>  				ret = err;
> -				SetPageError(page);

The comment above also needs to be upodated, and it mentions we
must set the error bit on the page.

Thanks.

>  				unlock_page(page);
>  				atomic_dec(&eb->io_pages);
>  			}
> -- 
> 2.26.3
> 
