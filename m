Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B684A9D14
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 17:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376613AbiBDQlC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 11:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiBDQlC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 11:41:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518A1C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 08:41:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0AF761958
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 16:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7073C004E1;
        Fri,  4 Feb 2022 16:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643992861;
        bh=28NETc0sTDG60/TucDbKcXk3N757P+1kxSQGpQ2D8kA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GikhMktw0I8m7VJneQK3HUEJx9RZeMokYQlkjndKuy6IRP0rYMUiCKrWlXioIRpGB
         O9nOQbv3At/ZQamsOjm5EAKyiqjMsBJ7poCj+tftN5pNb9IBcJASz/v8C+9oqY8+dx
         opzkZQAyAx2WdPTy4MtzC8hIfPBgqCEYi03whZ05HgOmo+RWXNsbKyyVDpdaeLKRqY
         D1N8QSjcgNkMYfpkJNfidl/Zfcne3ZsijEsymWWNuiluwroiDs8DoSLOjB0FlJgIhZ
         RdaCG0g9EvFye0TTMN9Bvbw/8je0GbH7lCAaak20QdErN3NY6zcqrpziFJgLofTd7G
         SQgQMNAJBtUwQ==
Date:   Fri, 4 Feb 2022 16:40:58 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/5] btrfs: uapi: introduce BTRFS_DEFRAG_RANGE_MASK
 for later sanity check
Message-ID: <Yf1XGlNotgcK26Jn@debian9.Home>
References: <cover.1643961719.git.wqu@suse.com>
 <39643a206e4439d0461780a52b9e0a734d75290a.1643961719.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39643a206e4439d0461780a52b9e0a734d75290a.1643961719.git.wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 04, 2022 at 04:11:55PM +0800, Qu Wenruo wrote:
> And since we're here, replace the hardcoded bit flags (1, 2) with
> (1UL << 0) and (1UL << 2), respectively.

It's supposed to be (1UL << 1) and not << 2.
However I won't make you send another patch version just for that.
Can be fixed when it's picked up.

Thanks.

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  include/uapi/linux/btrfs.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index 1cb1a3860f1d..57332a529c4e 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -576,8 +576,10 @@ struct btrfs_ioctl_clone_range_args {
>   * Used by:
>   * struct btrfs_ioctl_defrag_range_args.flags
>   */
> -#define BTRFS_DEFRAG_RANGE_COMPRESS 1
> -#define BTRFS_DEFRAG_RANGE_START_IO 2
> +#define BTRFS_DEFRAG_RANGE_COMPRESS	(1UL << 0)
> +#define BTRFS_DEFRAG_RANGE_START_IO	(1UL << 1)
> +#define BTRFS_DEFRAG_RANGE_FLAGS_MASK	(BTRFS_DEFRAG_RANGE_COMPRESS |\
> +					 BTRFS_DEFRAG_RANGE_START_IO)
>  struct btrfs_ioctl_defrag_range_args {
>  	/* start of the defrag operation */
>  	__u64 start;
> -- 
> 2.35.0
> 
