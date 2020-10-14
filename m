Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F322028E7DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Oct 2020 22:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbgJNU03 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Oct 2020 16:26:29 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:52443 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729022AbgJNU03 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Oct 2020 16:26:29 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3AA1DA6F;
        Wed, 14 Oct 2020 16:26:28 -0400 (EDT)
Received: from imap35 ([10.202.2.85])
  by compute3.internal (MEProxy); Wed, 14 Oct 2020 16:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=7SVNuQdI/9N+153NrQ1daUtKhV6+FXS
        6v+hqG9aNmYM=; b=ceTKlMHu2yg9mIspRTjSWbLlKjbQl5i6XomOcAoiK+JizQl
        BMTTHrydygNthuvf4qpBw+9Y99CNdoDZNiZbrPBIgm1LsmaF7OprWuu+UNofIf+S
        CkE2KBf0CDII4PgIYIKjB6lWk/RTUOgQoiW8sESSvwhG2YubElCCNRNGTbOvNH0q
        q/qFl2UG5uraCehYDH5me+V5zr/6iNjp1EkXiad7FyKwIphBVDeAbVjUzpNuno+a
        LFU3A93G2SllKAv2VYWLlf723SynBNUOmMxSeUeAEKw4kzY8cr4M1PZtZdm/xhgi
        zgxZz6xsaTrxgCsExJ1hSHC2O+m4kJc1xqGmdfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=7SVNuQ
        dI/9N+153NrQ1daUtKhV6+FXS6v+hqG9aNmYM=; b=nK9lanZPrzgMT7vwCciv0P
        EKcsXc1vaqYd5Vz6rgrvyxa/YvjHNHZk6JXq6hpHFL4NcSGSmT6eCzRYAxAdeylX
        UAX5fO9u1nGoURtZThC2EGeiwIQm1iV70PaVQPXkIHgREqDC0o5LIJmbhuSBvvCQ
        1Nc5NgMkcce7nc6IskJVPpzzQ2x1rRbr8iuY8KBNvhXBrXgIHjJnIGAwXiKFxHpb
        a0uOY7hjvk+5MFjGmjT1XlfnCGU4BbMn4SRiTAABEjWFoMJ2MtBwkuSO5yqmNflU
        TDqmgADcgC+UO5H9FBFs7cf4tIZnNNYuNSZ0ccatRPxrs564QbO3zxItRAZB7J5g
        ==
X-ME-Sender: <xms:816HXyKBGEP0u5-lb6op4oWsCs9SPdzTyB10Odub6LpPHmclR-UwnA>
    <xme:816HX6KjwWSNWZgoh_OnhmnNFz3cLmi1a4_tgiQ9Kr925Hf6h1KsRVQTlxtCWeZCb
    hsmR5f0X4tIPcTeIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedriedugdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpefofgggkfgjfhffhffvufgtsehttdertder
    redtnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnhepffekheffudfhveehkeeghffhhfekffelfedtheehtddt
    ieehleejgffhkeeiledtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhu
    rdighiii
X-ME-Proxy: <xmx:816HXyuQLiyOBN1bot70fcsN8Gz_q3KNXa3cJ9IE6fWQIC2-YPI3hw>
    <xmx:816HX3Zw4RtlKfEuJgOJRoKmnD8GxxGT5hj2AJVPULPNNgr723Fvxg>
    <xmx:816HX5aqEqdlohwdQYfH671gm9QX8yRx47eJ7WI0oQ2Q961_UE0t-g>
    <xmx:816HX9F92M-74e837rUj2kGGYrn_9MthBWa3foZsNQKsx6bnOB1Btw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 22C6F14C009C; Wed, 14 Oct 2020 16:26:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-489-gf39678d-fm-20201011.001-gf39678d0
Mime-Version: 1.0
Message-Id: <04fd46a0-c93c-4fd7-ae60-cd63f765beff@www.fastmail.com>
In-Reply-To: <20201009010910.270794-1-dxu@dxuuu.xyz>
References: <20201009010910.270794-1-dxu@dxuuu.xyz>
Date:   Wed, 14 Oct 2020 13:26:06 -0700
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     "Kernel Team" <kernel-team@fb.com>, josef@toxicpanda.com,
        quwenruo.btrfs@gmx.com, "Qu Wenruo" <wqu@suse.com>
Subject: Re: [PATCH v2] btrfs: Fix divide by zero
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 8, 2020, at 6:09 PM, Daniel Xu wrote:
> If there's no parity and num_stripes < ncopies, an btrfs image can
> trigger a divide by zero in calc_stripe_length().
> 
> The image (see link) was generated through fuzzing.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=209587
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
> 
> v1->v2:
> * Upload test image to kernel bugzilla
> 
> 
>  fs/btrfs/tree-checker.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 7b1fee630f97..e03c3807921f 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -760,18 +760,36 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
>  	u64 type;
>  	u64 features;
>  	bool mixed = false;
> +	int raid_index;
> +	int nparity;
> +	int ncopies;
>  
>  	length = btrfs_chunk_length(leaf, chunk);
>  	stripe_len = btrfs_chunk_stripe_len(leaf, chunk);
>  	num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
>  	sub_stripes = btrfs_chunk_sub_stripes(leaf, chunk);
>  	type = btrfs_chunk_type(leaf, chunk);
> +	raid_index = btrfs_bg_flags_to_raid_index(type);
> +	ncopies = btrfs_raid_array[raid_index].ncopies;
> +	nparity = btrfs_raid_array[raid_index].nparity;
>  
>  	if (!num_stripes) {
>  		chunk_err(leaf, chunk, logical,
>  			  "invalid chunk num_stripes, have %u", num_stripes);
>  		return -EUCLEAN;
>  	}
> +	if (num_stripes < ncopies) {
> +		chunk_err(leaf, chunk, logical,
> +			  "invalid chunk num_stripes < ncopies, have %u < %d",
> +			  num_stripes, ncopies);
> +		return -EUCLEAN;
> +	}
> +	if (nparity && num_stripes == nparity) {
> +		chunk_err(leaf, chunk, logical,
> +			  "invalid chunk num_stripes == nparity, have %u == %d",
> +			  num_stripes, nparity);
> +		return -EUCLEAN;
> +	}
>  	if (!IS_ALIGNED(logical, fs_info->sectorsize)) {
>  		chunk_err(leaf, chunk, logical,
>  		"invalid chunk logical, have %llu should aligned to %u",
> -- 
> 2.28.0
> 
>

Gentle poke.

Thanks,
Daniel
