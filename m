Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8F276DAFB
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 00:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjHBWvj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 18:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjHBWvi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 18:51:38 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116929B
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 15:51:36 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id DA3645C010D;
        Wed,  2 Aug 2023 18:51:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Aug 2023 18:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1691016692; x=1691103092; bh=dz
        TSzrTIIlY8tTbxS8OwvgUOZ6zi5MafGX5CAoaz04Y=; b=Wk/gKu5fatxPlZ5HRO
        hu4S00molDxwpbKLhIZCL6/D4/1vx0IAcgSvYRasninjWUCKHEr/+IzOsnr8B7n6
        Wn/x9tpw/VKzonUpri/2r91KXc918oywLpHMWbpM26yMBWiS1PrnZ50+UtePNpHW
        hYouC4kMGEijshscBsZpSibeSeWrevr6ev3TH5gsigA/Fv3lf9v3xtvKzD3ZdqLZ
        EWuiuyKr0vlzc35lwfLIBtla+UKMNDQjihUJhv/Rs53Gx5L9vyrz2RCMrspqX8dv
        X3inQN6XSrGPwFIQ1MgdEOOsFGYo6tQ+uAwKnFTiIrOB5peNiHf/PFIGXUDsn9gC
        xFIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691016692; x=1691103092; bh=dzTSzrTIIlY8t
        TbxS8OwvgUOZ6zi5MafGX5CAoaz04Y=; b=IuGWIqGNmV7SHOq1r9Hdu2tBZ9ijH
        v5TP8cdqKHPPgf2bLetAA9mA29onz8ML2gGFkqqtpjWUmohR6mmaEAMtPesysOG9
        CuyWJL/nPvPRBqbsS3ySJ262KR8pJrjc+3HLmPbRtr8pQK5uk4R1Qf6/j4UrHvbQ
        LZowa+2Qbutw9z6oxgdrtCqD6fxC/av6bTDLiDgNkmxCkmfQu/CeCt/ocryKAy3C
        TaZdLoMFbStkRHC1ma9VRkPUh4a5GFw1NoKvsC4KAw5LvJX8myYZ9uyVISjOnCq+
        gPYxyzZ9ipyC+9DC0l89OC3qJtDHWLakPG6ye1tD3idg5ROh18NRbU7dw==
X-ME-Sender: <xms:9N3KZPegq0Tup_uLhGqGUwfy3ZNNoSdk6sBGa2XuvDC5wzeZY3tiIA>
    <xme:9N3KZFOPW035EhibutwYtADC2Ia8T2KFQ6HX-4Lm-_HpmZgHjVzxT5mlZ7mNiMw3h
    IXe7kJ18u0oxR_6Hu4>
X-ME-Received: <xmr:9N3KZIjwpESAkVyG3X7csxMck2tROMlyaYtp3LIrfOhws8ZAJF6M_sjdJ2ChzVs47AMT0j_ZYxju0U0sjvRglGBqtdU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkedugddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepke
    dvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:9N3KZA8GmFzkOVc3xE9frA0EgcMvXhcyzu3vqrlDX2yt9B6Sa_gPnA>
    <xmx:9N3KZLvSQ9YeddPANEvWMD23WUBXPkRoAl8FUbDP-LqAKqMpDEMgMw>
    <xmx:9N3KZPFXfxnjFSxaiA0ggxMZjgAN4IfnPeetPl2H0Xouyiq0SgBMmw>
    <xmx:9N3KZLJqhqs0WRR5qm3xTfrN3-Az7fewylEnMoyAo8rgcIV44UGX1w>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Aug 2023 18:51:31 -0400 (EDT)
Date:   Wed, 2 Aug 2023 15:49:42 -0700
From:   Boris Burkov <boris@bur.io>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/9] btrfs: don't stop integrity writeback too early
Message-ID: <20230802224942.GA1934467@zen>
References: <20230724132701.816771-1-hch@lst.de>
 <20230724132701.816771-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724132701.816771-2-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 06:26:53AM -0700, Christoph Hellwig wrote:
> extent_write_cache_pages stops writing pages as soon as nr_to_write hits
> zero.  That is the right thing for opportunistic writeback, but incorrect
> for data integrity writeback, which needs to ensure that no dirty pages
> are left in the range.  Thus only stop the writeback for WB_SYNC_NONE
> if nr_to_write hits 0.
> 
> This is a port of write_cache_pages changes in commit 05fe478dd04e
> ("mm: write_cache_pages integrity fix").

This makes sense to me. What is the reason the same reasoning doesn't
apply to btree_write_cache_pages? Does the issue only happen in practice
with fsync that no one is doing on the btree inode? It feels, in theory,
we could do a writepages with SYNC_ALL and hit the same issue with pages
going dirty and stealing the nr_writes.

> 
> Note that I've only trigger the problem with other changes to the btrfs
> writeback code, but this condition seems worthwhile fixing anyway.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/extent_io.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c0440a0988c9a8..231e620e6c497d 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2098,7 +2098,8 @@ static int extent_write_cache_pages(struct address_space *mapping,
>  			 * We have to make sure to honor the new nr_to_write
>  			 * at any time
>  			 */
> -			nr_to_write_done = wbc->nr_to_write <= 0;
> +			nr_to_write_done = wbc->sync_mode == WB_SYNC_NONE &&
> +						wbc->nr_to_write <= 0;
>  		}
>  		folio_batch_release(&fbatch);
>  		cond_resched();
> -- 
> 2.39.2
> 
