Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB9C4A8928
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 17:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349630AbiBCQ6x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 11:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiBCQ6w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 11:58:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F0FC061714
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 08:58:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4A90615AE
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 16:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAEBC340ED;
        Thu,  3 Feb 2022 16:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643907531;
        bh=UPnFkf8tj5e9kOkB6WcawBvN2xg76ujrNU/nhchFjjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cUfajK1dM7KDYvQs7G/WuxaVXVYd7zEqaSswqnuQdhzKBjkasQgvGmuE3oJ0QN7wb
         l0U7e1DzkpBT8tFvzkp9i1Jyb549T1eYAjK07RBossWatSlJQHS/+AGhEoe/I9qyHA
         bDyNM/vhhwA2po6PQaeLEvJ9fN6/U1FSTfJiXhyw22v/Q0MCUVE37NBaBEOJFqqvrj
         LRTf/4U9S52Tp/3x/MNaJdJkm3yCINhaYNchuWudme0yj2QyygaoMxZWJJvpEodfD/
         7bOflUC9mTEIxYcRkUMpXwTWp+W8BPdwOwqP20eVGEYeRAScwi7IeILHYJat2Ntf8+
         +JwB8OkLPh5Kw==
Date:   Thu, 3 Feb 2022 16:58:47 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] btrfs: uapi: introduce BTRFS_DEFRAG_RANGE_MASK for
 later sanity check
Message-ID: <YfwJxyxsT2q7SK+Y@debian9.Home>
References: <cover.1643357469.git.wqu@suse.com>
 <6f1befeab18c6ba33afb227fd20a3933ee95dc8b.1643357469.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f1befeab18c6ba33afb227fd20a3933ee95dc8b.1643357469.git.wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 28, 2022 at 04:12:55PM +0800, Qu Wenruo wrote:
> And since we're here, replace the hardcoded bit flags (1, 2) with
> (1UL << 0) (1UL << 2).

"... (1UL << 0) and (1UL << 1), respectively."

Other than that looks, fine, thanks.

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  include/uapi/linux/btrfs.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index 87925444d892..efd246e218d7 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -575,8 +575,10 @@ struct btrfs_ioctl_clone_range_args {
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
> 2.34.1
> 
