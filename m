Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B2A4D85DE
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 14:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbiCNN1X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 09:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiCNN1W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 09:27:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B108311141
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 06:26:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6483A218FE;
        Mon, 14 Mar 2022 13:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647264371;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f+EiOmtBFvdumL+WQzEThvCiEZP5qt6liaWp6i+0mcg=;
        b=huhZaxmw7LblGe5LeW2CdFw1lys5WJT0ij87P8sXJUviphqGKySl3xGt/ZMdXs7Hzhfohv
        JI1jlOw+F8Ge9frI5j0Sn2VK9XL3uoGz7+ChNatRm4UkVDx3Sk/ascGV+67VYZHwQbvuEK
        zkw4erMmbhx79sRmWFSz79Qqm/jtSO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647264371;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f+EiOmtBFvdumL+WQzEThvCiEZP5qt6liaWp6i+0mcg=;
        b=vWH3JHuqnDB1HgBGD2OGreAGDPFYj94cW18fn/bhgAtu+VbUCBHCu909O1F1XAmXZF1jdS
        L3F1zNbjjHn0xzAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5B3A3A3B93;
        Mon, 14 Mar 2022 13:26:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3C502DA7E1; Mon, 14 Mar 2022 14:22:13 +0100 (CET)
Date:   Mon, 14 Mar 2022 14:22:13 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/3] btrfs: scrub: rename members related to
 scrub_block::pagev
Message-ID: <20220314132213.GJ12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1647161284.git.wqu@suse.com>
 <c9b166e536844ca1dd42adb8ea1e3520fc53618a.1647161284.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9b166e536844ca1dd42adb8ea1e3520fc53618a.1647161284.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 13, 2022 at 06:40:00PM +0800, Qu Wenruo wrote:
> The following will be renamed in this patch:
> 
> - scrub_block::pagev -> sectorv

			  sectors
> 
> - scrub_block::page_count -> sector_count
> 
> - SCRUB_MAX_PAGES_PER_BLOCK -> SCRUB_MAX_SECTORS_PER_BLOCK
> 
> - page_num -> sector_num to iterate scrub_block::sectorv

						 ::sectors
> 
> For now scrub_page is not yet renamed, as the current changeset is
> already large enough.
> 
> The rename for scrub_page will come in a separate patch.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/scrub.c | 221 +++++++++++++++++++++++------------------------
>  1 file changed, 110 insertions(+), 111 deletions(-)

> @@ -2193,8 +2192,8 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
>  {
>  	struct scrub_ctx *sctx = sblock->sctx;
>  	struct btrfs_fs_info *fs_info = sctx->fs_info;
> -	u64 length = sblock->page_count * PAGE_SIZE;
> -	u64 logical = sblock->pagev[0]->logical;
> +	u64 length = sblock->sector_count * fs_info->sectorsize;

This should have been also converted to << sectorsize_bits

> +	u64 logical = sblock->sectors[0]->logical;
>  	struct btrfs_io_context *bioc = NULL;
>  	struct bio *bio;
>  	struct btrfs_raid_bio *rbio;
> @@ -4058,18 +4057,18 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
>  	}
>  
>  	if (fs_info->nodesize >
> -	    PAGE_SIZE * SCRUB_MAX_PAGES_PER_BLOCK ||
> -	    fs_info->sectorsize > PAGE_SIZE * SCRUB_MAX_PAGES_PER_BLOCK) {
> +	    SCRUB_MAX_SECTORS_PER_BLOCK * fs_info->sectorsize ||

And here.

> +	    fs_info->sectorsize > PAGE_SIZE * SCRUB_MAX_SECTORS_PER_BLOCK) {
>  		/*
>  		 * would exhaust the array bounds of pagev member in
>  		 * struct scrub_block
>  		 */
>  		btrfs_err(fs_info,
> -			  "scrub: size assumption nodesize and sectorsize <= SCRUB_MAX_PAGES_PER_BLOCK (%d <= %d && %d <= %d) fails",
> +			  "scrub: size assumption nodesize and sectorsize <= SCRUB_MAX_SECTORS_PER_BLOCK (%d <= %d && %d <= %d) fails",
>  		       fs_info->nodesize,
> -		       SCRUB_MAX_PAGES_PER_BLOCK,
> +		       SCRUB_MAX_SECTORS_PER_BLOCK,
>  		       fs_info->sectorsize,
> -		       SCRUB_MAX_PAGES_PER_BLOCK);
> +		       SCRUB_MAX_SECTORS_PER_BLOCK);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.35.1
