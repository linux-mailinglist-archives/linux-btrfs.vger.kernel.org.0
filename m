Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B900E560DB4
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jun 2022 01:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiF2Xsg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jun 2022 19:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiF2Xsf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jun 2022 19:48:35 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3914F1DA5F
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 16:48:34 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 3A22D3200942;
        Wed, 29 Jun 2022 19:48:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 29 Jun 2022 19:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1656546512; x=1656632912; bh=2RFuteCT4d
        zQ1MiGDpQhrWCzWdnmKMpBcJ9l45L+vC8=; b=TKiOGYr0SvAeZ+TxOrznA8JQvM
        vIPzW+if6TbrNKa9kAc8IQ2yOhtuPI2GNU0vZN60XQYBoEUsnjW/vj+HR74A5DqC
        kwLO90RtcwRkoAuhZwKWq4JpDzCYNunn0MQuzJ+A0LbqlqUFzdhhUUpQ/oduggVE
        LG1E11NRTfBkHK1rQF0Sdu796T6woUUBLIWDB8BXpCMB3OZ9dXfwJC401xAExq7b
        sZzoY/8qxfG4Dh7pbzcnGxI/X6F+X9hF6lR2Gb8RJrEhCZ3J0WjJqWWwE1cgfiec
        eSBylbSH6w6FFFF/In05HYVjXidGZPFbYbuqYIi03pk5svlYFLXQfDqpRwPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1656546512; x=1656632912; bh=2RFuteCT4dzQ1MiGDpQhrWCzWdnm
        KMpBcJ9l45L+vC8=; b=iz+cz2yb0/UZWegPlFQlGyzIVBXLNliKTETWdEpGG97s
        F6kCRmOek9+SeN/w6nhYNk3WGFIh6OAY9ywn77WQPNs7rLbUzAyiiHQGaAqKIyr0
        YYRS7w/YTGl96k7lTe6mxIAwTzlf50u6Vuihhw0moi3DjCQYgYnVfMUs9nhJ57FW
        r47V+s9ZlqHVgkWwoK464qdU12AiuWcfDhWAQgPa5aNceQYiysabTqip/wCeDnE+
        3URY7ycmeJHZeNVR4EAFYeRrIUqnxHyaIEif4lAOmlcWPfvOTvkOxVqdqrhFizB9
        3tJ+4rRDFEvKO5npZLGlLe2liKGDr/EtntvazwmL1g==
X-ME-Sender: <xms:0OS8Yo5KYkyacA89S5Y1g7fI8mMU7s8N82FgquR4VkDSYrNVG25zIw>
    <xme:0OS8Yp5us_s7fEq9WlDhlft1MdwSSPshaen_dUp3e6S55ScA_QmNcGrtP5JlSX0s1
    rEFYWgppzJXEy9uc3A>
X-ME-Received: <xmr:0OS8Yndl0FXpN0WTpuccWvxaaUjaKrdWNJWa_QDn8XOmgN2r21mR8b9w4lQO8swq1syDxTgm3STEy3D8mLu0uSTJjCDvcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehtddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:0OS8YtKJe8XlDodG6XZgWcUjJBalCD5I2MBjelwXJCpNadZ_gsKMVQ>
    <xmx:0OS8YsIeSHkCT5EiyUiLlPgWj1sWPKas3dGVXrZWn75yBzmCUI_jFQ>
    <xmx:0OS8YuwAFoeHOXrS1dNuOdAQsjtoicbchV7NCMulXUF_UsHpHTUQAg>
    <xmx:0OS8Yg0YLbANtKkAiEkXd8wAS35S-_qsqLijlRNxrcd0OoW0DdgmvA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jun 2022 19:48:32 -0400 (EDT)
Date:   Wed, 29 Jun 2022 16:48:31 -0700
From:   Boris Burkov <boris@bur.io>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/4] btrfs: remove the start argument to check_data_csum
Message-ID: <Yrzkz3BLMZYPNnYK@zen>
References: <20220623055338.3833616-1-hch@lst.de>
 <20220623055338.3833616-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623055338.3833616-4-hch@lst.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 23, 2022 at 07:53:37AM +0200, Christoph Hellwig wrote:
> Just derive it from the btrfs_bio now that ->file_offset is always valid.
> Also make the function available outside of inode.c as we'll need that
> soon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/ctree.h |  2 ++
>  fs/btrfs/inode.c | 22 +++++++++-------------
>  2 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4e2569f84aabc..164f54e6aa447 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3293,6 +3293,8 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
>  unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
>  				    u32 bio_offset, struct page *page,
>  				    u64 start, u64 end);
> +int check_data_csum(struct inode *inode, struct btrfs_bio *bbio, u32 bio_offset,
> +		    struct page *page, u32 pgoff);
>  struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
>  					   u64 start, u64 len);
>  noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index a627b2af9e243..429428fde4a88 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3396,20 +3396,18 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
>  /*
>   * check_data_csum - verify checksum of one sector of uncompressed data
>   * @inode:	inode
> - * @io_bio:	btrfs_io_bio which contains the csum
> + * @bbio:	btrfs_io_bio which contains the csum
>   * @bio_offset:	offset to the beginning of the bio (in bytes)
>   * @page:	page where is the data to be verified
>   * @pgoff:	offset inside the page
> - * @start:	logical offset in the file
>   *
>   * The length of such check is always one sector size.
>   *
>   * When csum mismatch is detected, we will also report the error and fill the
>   * corrupted range with zero. (Thus it needs the extra parameters)
>   */
> -static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
> -			   u32 bio_offset, struct page *page, u32 pgoff,
> -			   u64 start)
> +int check_data_csum(struct inode *inode, struct btrfs_bio *bbio, u32 bio_offset,
> +		    struct page *page, u32 pgoff)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	u32 len = fs_info->sectorsize;
> @@ -3425,8 +3423,9 @@ static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
>  	return 0;
>  
>  zeroit:
> -	btrfs_print_data_csum_error(BTRFS_I(inode), start, csum, csum_expected,
> -				    bbio->mirror_num);
> +	btrfs_print_data_csum_error(BTRFS_I(inode),
> +				    bbio->file_offset + bio_offset,
> +				    csum, csum_expected, bbio->mirror_num);
>  	if (bbio->device)
>  		btrfs_dev_stat_inc_and_print(bbio->device,
>  					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
> @@ -3495,8 +3494,7 @@ unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
>  					  EXTENT_NODATASUM);
>  			continue;
>  		}
> -		ret = check_data_csum(inode, bbio, bio_offset, page, pg_off,
> -				      page_offset(page) + pg_off);
> +		ret = check_data_csum(inode, bbio, bio_offset, page, pg_off);
>  		if (ret < 0) {
>  			const int nr_bit = (pg_off - offset_in_page(start)) >>
>  				     root->fs_info->sectorsize_bits;
> @@ -7946,7 +7944,7 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
>  
>  		if (uptodate &&
>  		    (!csum || !check_data_csum(inode, bbio, offset, bv.bv_page,
> -					       bv.bv_offset, start))) {
> +					       bv.bv_offset))) {
>  			clean_io_failure(fs_info, failure_tree, io_tree, start,
>  					 bv.bv_page, btrfs_ino(BTRFS_I(inode)),
>  					 bv.bv_offset);
> @@ -10324,7 +10322,6 @@ static blk_status_t btrfs_encoded_read_verify_csum(struct btrfs_bio *bbio)
>  	u32 sectorsize = fs_info->sectorsize;
>  	struct bio_vec *bvec;
>  	struct bvec_iter_all iter_all;
> -	u64 start = priv->file_offset;
>  	u32 bio_offset = 0;
>  
>  	if (priv->skip_csum || !uptodate)
> @@ -10338,9 +10335,8 @@ static blk_status_t btrfs_encoded_read_verify_csum(struct btrfs_bio *bbio)
>  		for (i = 0; i < nr_sectors; i++) {
>  			ASSERT(pgoff < PAGE_SIZE);
>  			if (check_data_csum(&inode->vfs_inode, bbio, bio_offset,
> -					    bvec->bv_page, pgoff, start))
> +					    bvec->bv_page, pgoff))
>  				return BLK_STS_IOERR;
> -			start += sectorsize;
>  			bio_offset += sectorsize;
>  			pgoff += sectorsize;
>  		}
> -- 
> 2.30.2
> 
