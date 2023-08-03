Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D22776DC8E
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 02:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjHCAXy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 20:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHCAXx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 20:23:53 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D1211D
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 17:23:51 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id CA9C63200959;
        Wed,  2 Aug 2023 20:23:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 02 Aug 2023 20:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1691022227; x=1691108627; bh=hj
        rIVtUDfLTuMtusbnXCVi9ufTRwvwurAsJt0KKKtjc=; b=b40bpn7u5AsikE9OrO
        q6ohQ+Srg+nk+8ZUQR8FsPbb19Aq192IKNuSXzSjZ4tlvqTDzwz574luCix6naWg
        Zjy3UgmV+v9nG56gm1qBJ7CGAtpM5O3P65vJ8Ff48fgyXoP535w/fovyBNvNgEcp
        BAhhlhOxZVx0b9u+vqzzJ9/bAU148iqbmtYfMiBu1bliVO3UOP8C8QeCpw85TDDl
        7dLRNPxcJ4JMKoUGRuZK945XsVfbU9dooPtgZLY767FuhC/46fXrv/LvOHROtuC/
        L5VSqjzHNflLZPcGSe4xE6TukSMRU55eEpAiW+VsNkWI/zT+z62/Gl9PFPKyOjrx
        LDpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691022227; x=1691108627; bh=hjrIVtUDfLTuM
        tusbnXCVi9ufTRwvwurAsJt0KKKtjc=; b=KfLibAUwKUbmCvgywjUUoru1HvtFL
        O1qYTOWN5duLcZUNhrELTJ9ZS6Xkqft4i+qZW39xIj8I1H8cpPlnTAkaZ7wNEmuO
        rHaxZcaeTrLgVdyvFEXb75/di2b17tDWnSJe9w/a4VtfAiV1SR78T9j5OMMN7e3X
        dg9gHJFKVsnLuHa2uaTEMRNxDmWFfYc8Zl1TqMluavEveoqd8lAFzThdB8OpN5Kz
        QNlk3V7PafarwTUfi8uiIcYDD18AAc+mEoRDuounfa3NVbOMtYGncQLFbFVnxLmq
        zl9E0ovdQvW1fPir1+cBl0nHB+5DpnA0DVgZ4DfvgH041YYGJa6YOUSIA==
X-ME-Sender: <xms:kvPKZPbRV19OJRLgPMDKUuVxNC4NDGNSatAihuicVIlxdksQysjGqw>
    <xme:kvPKZOaFxamUe6tSZf7qZprSKF858UlfWrsHvKWybY6kOn3h3syiZtvFGNLifcc6T
    2oOWVVQkhoPXCzjWI4>
X-ME-Received: <xmr:kvPKZB__zpo954srT0o47WLjWJtZ9zObHc5DX0GyPVn5Gjrrdv2JkeXdzcuMWL06Yc0VRoqUPMlZ4nCWOC7Hd11Bj0U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkedugdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepke
    dvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:kvPKZFrmzzqJGPKw_kHW-C_eXW4cSGLjTvr-guwXtovwI9SBPt0b0Q>
    <xmx:kvPKZKq0tXb17YO-SiLG5Za-wXDqpoxRCJgxdzfXx7a1mz1XYNkALQ>
    <xmx:kvPKZLRETUU7sDsSG4MyTw9EtzOlbUHKOxmtoqaLzxhdFZcX1x2uTA>
    <xmx:k_PKZNUMToyJPQP8_oM6hcOzi4ex7WwaCzQneH62zcuekK8MRl9VNw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Aug 2023 20:23:46 -0400 (EDT)
Date:   Wed, 2 Aug 2023 17:21:56 -0700
From:   Boris Burkov <boris@bur.io>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/9] btrfs: move the cow_fixup earlier in writepages
 handling
Message-ID: <20230803002156.GB1934467@zen>
References: <20230724132701.816771-1-hch@lst.de>
 <20230724132701.816771-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724132701.816771-5-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 06:26:56AM -0700, Christoph Hellwig wrote:
> btrfs has a special fixup for pages that are marked dirty without having
> space reserved for them.  But the place where is is run means it can't
> work for I/O that isn't kicked off inline from __extent_writepage, most
> notable compressed I/O and I/O to zoned file systems.
> 
> Move the fixup earlier based on not findining any delalloc range in the
> I/O tree to cover this case as well instead of relying on the fairly
> obscure fallthrough behavior that calls __extent_write_page_io even when
> no delalloc space was found.

This almost makes sense to me, but not quite. As far as I can tell, the
zoned and compressed cases you are describing are the cases in
btrfs_run_delalloc_range which end up calling extent_write_locked_range.
And indeed, if that happens, it appears we return 1, don't call
__extent_writepage, and don't do the redirty check. However, if that
happens, then your new code won't run either, because it will set
found_delalloc after btrfs_run_delalloc_range returns 1 (>= 0).

Therefore, it must be the case that your new check uses the assumption
that in any case where the fixup would trip, the find_delalloc must have
failed as well. Let's assume that's true, because we always set the
delalloc bit for any page we properly dirty. Even then, this feels like
it strictly reduces the cases we do the fixup.

To me it seems like best case this is a no-op change, worst case it
reduces the cases where catch wrong dirty pages.

Put another way, I don't see a codepath which hits this logic, but
doesn't hit the old logic.

Do you have a reproducer for what this is fixing?

Thanks,
Boris

> 
> Fixes: c8b978188c9a ("Btrfs: Add zlib compression support")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/extent_io.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1cc46bbbd888cd..cc258bddd88eab 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1153,6 +1153,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
>  	u64 delalloc_start = page_start;
>  	u64 delalloc_end = page_end;
>  	u64 delalloc_to_write = 0;
> +	bool found_delalloc = false;
>  	int ret = 0;
>  
>  	while (delalloc_start < page_end) {
> @@ -1169,6 +1170,22 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
>  			return ret;
>  
>  		delalloc_start = delalloc_end + 1;
> +		found_delalloc = true;
> +	}
> +
> +	/*
> +	 * If we did not find any delalloc range in the io_tree, this must be
> +	 * the rare case of dirtying pages through get_user_pages without
> +	 * calling into ->page_mkwrite.
> +	 * While these are in the process of being fixed by switching to
> +	 * pin_user_pages, some are still around and need to be worked around
> +	 * by creating a delalloc reservation in a fixup worker, and waiting
> +	 * us to be called again with that reservation.
> +	 */
> +	if (!found_delalloc && btrfs_writepage_cow_fixup(page)) {
> +		redirty_page_for_writepage(wbc, page);
> +		unlock_page(page);
> +		return 1;
>  	}
>  
>  	/*
> @@ -1274,14 +1291,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>  	int ret = 0;
>  	int nr = 0;
>  
> -	ret = btrfs_writepage_cow_fixup(page);
> -	if (ret) {
> -		/* Fixup worker will requeue */
> -		redirty_page_for_writepage(bio_ctrl->wbc, page);
> -		unlock_page(page);
> -		return 1;
> -	}
> -
>  	bio_ctrl->end_io_func = end_bio_extent_writepage;
>  	while (cur <= end) {
>  		u32 len = end - cur + 1;
> @@ -1421,9 +1430,6 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
>  		goto done;
>  
>  	ret = __extent_writepage_io(BTRFS_I(inode), page, bio_ctrl, i_size, &nr);
> -	if (ret == 1)
> -		return 0;
> -
>  	bio_ctrl->wbc->nr_to_write--;
>  
>  done:
> @@ -2176,8 +2182,6 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
>  
>  		ret = __extent_writepage_io(BTRFS_I(inode), page, &bio_ctrl,
>  					    i_size, &nr);
> -		if (ret == 1)
> -			goto next_page;
>  
>  		/* Make sure the mapping tag for page dirty gets cleared. */
>  		if (nr == 0) {
> @@ -2193,7 +2197,6 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
>  		btrfs_page_unlock_writer(fs_info, page, cur, cur_len);
>  		if (ret < 0)
>  			found_error = true;
> -next_page:
>  		put_page(page);
>  		cur = cur_end + 1;
>  	}
> -- 
> 2.39.2
> 
