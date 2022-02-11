Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D714B30CF
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 23:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345891AbiBKWjd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 17:39:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbiBKWjc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 17:39:32 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28E4D61
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 14:39:30 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4B22F5C01A2;
        Fri, 11 Feb 2022 17:39:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 11 Feb 2022 17:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=AqUdd6pKCQFWptaf1WXI2axOExv3zseD3ScqTW
        hsT2A=; b=Tk4LR7tGOxw+Hqa9HvZ58OX80EYtFh6Ja8I+jVwI7GOdfPa0v7TNre
        7xV69o/fCdaAXhoPMhyJtrAnKpLkXKznvae2nuSLKcrt06NFcIB4eiA5uRZKOSXq
        CDBHVjTM5Mg8TpQYBtRfh0dslNXFBJxI8tBHmqzWKqYMXb82NEaIoSLkvPqHxOiT
        51EAdGzaGjvG5pYSbtwhtE5tvwYTRex4k7RlmR6qVqxpJYWyOhXO7BsEWOpsJ+9m
        aLtwk3azg12k08XBiJsFz40UxOFbpPszDLnkIWvQ41KL1XjPnmt1jt9xvhVBIiEw
        ulbUUKj4eNKTnZKBYoOBselgaZgbUVmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=AqUdd6pKCQFWptaf1
        WXI2axOExv3zseD3ScqTWhsT2A=; b=h87D5jBIuzQCqT4FHCfG39tbiZKuoxd1y
        iLelGX2rtd2sG+yRIDoHRSyoyFNulBfWgJy9pISsQqDbWBZQ7JqfiD5mb13iAtPM
        UiSP25ixGvwa0nC4SvyrUHIAUOX0w7GDSvh+3HCzb3XWo6kVMudCn/G38lHdu2j+
        7mZqGUkUx0OZmY4NeNyN0WU7kE7p3F4fIXNtsvTf0/+in30Cobdx4xfkwMbMsctX
        mi416HP1vsc3fC1t3X2Fh82aNvfmQkhk2s533eifz00PWCoEYM2VHUwr9lKOiTei
        s3/R69WneYJBK4FhfDl7VGKMDnT2s/uH/BSU2GzHQoVNrU5PjMBrg==
X-ME-Sender: <xms:ouUGYtY8w-tGBA_d9gt-8uIuJqbyWDL5HZfEZsPippCTPBz_J8LhcQ>
    <xme:ouUGYkZHB7x-HpEkZa8PnCzlcDUtsfTIec84S3fU2cdjNOaK4LtQq10WMpafnY9J3
    nKoPqSU3YKSooVvoyk>
X-ME-Received: <xmr:ouUGYv-UCvmXPkWIhLeNkjgkjM9KJJCSX8TPBMKud2WhfoQdKmhdM6h8Jkeh_-XslinmeHkMZ_cw3wiyWNhlYDx8vXyHZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieegucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhr
    khhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepheduveelke
    eiteelveeiuefhudehtdeigfehkeeffeegledvueevgefgudeuveefnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrih
    ho
X-ME-Proxy: <xmx:ouUGYrr2VU1KM5gt0wD6fOjEDCcmalsYQ_sUlHsaFuO1xOF2_u1xaA>
    <xmx:ouUGYortACWhgzY8MgKlT9wdz31OzVfD09iRnhqfBTc71RVWkLQGcg>
    <xmx:ouUGYhS87b7OQzs_mUOScvCQAiXJ-1-7VAXSGbE-yRbYwwVvAniOpw>
    <xmx:ouUGYlBfi6YbVsZyr5ll_No9n_zHwLQ-QRFDuZyEuwB8J0dKGKR1rA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 17:39:29 -0500 (EST)
Date:   Fri, 11 Feb 2022 14:39:28 -0800
From:   Boris Burkov <boris@bur.io>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/8] btrfs: make search_csum_tree return 0 if we get
 -EFBIG
Message-ID: <YgbloFyn4FfIyjy5@zen>
References: <cover.1644532798.git.josef@toxicpanda.com>
 <772083c44ddbae8edb2d52ce2292f8a2dfc08ccb.1644532798.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <772083c44ddbae8edb2d52ce2292f8a2dfc08ccb.1644532798.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 10, 2022 at 05:44:19PM -0500, Josef Bacik wrote:
> We can either fail to find a csum entry at all and return -ENOENT, or we
> can find a range that is close, but return -EFBIG.  In essence these
> both mean the same thing when we are doing a lookup for a csum in an
> existing range, we didn't find a csum.  We want to treat both of these
> errors the same way, complain loudly that there wasn't a csum.  This
> currently happens anyway because we do
> 
> 	count = search_csum_tree();
> 	if (count <= 0) {
> 		// reloc and error handling
> 	}
> 
> however it forces us to incorrectly treat EIO or ENOMEM errors as on
> disk corruption.  Fix this by returning 0 if we get either -ENOENT or
> -EFBIG from btrfs_lookup_csum() so we can do proper error handling.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/file-item.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 9a3de652ada8..efb24cc0b083 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -305,7 +305,7 @@ static int search_csum_tree(struct btrfs_fs_info *fs_info,
>  	read_extent_buffer(path->nodes[0], dst, (unsigned long)item,
>  			ret * csum_size);
>  out:
> -	if (ret == -ENOENT)
> +	if (ret == -ENOENT || ret == -EFBIG)
>  		ret = 0;
>  	return ret;
>  }
> -- 
> 2.26.3
> 
