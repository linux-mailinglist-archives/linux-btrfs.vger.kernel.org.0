Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B81598380
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 14:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244835AbiHRMzq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 08:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244892AbiHRMzo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 08:55:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427DD21838
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Aug 2022 05:55:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F1E4C3EF74;
        Thu, 18 Aug 2022 12:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660827342;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sJEwWSFqU6oCQ3hFoCpEh8KwtvEuuUKuQbO2CF8zCc8=;
        b=h1OLkr82SewDyYOY4iBD9lIIE+v444KNmpoV3cbmGueLnAJ7EHicb4rHKxisw2La5Iglyu
        FSm0RPrbXoRLnrV+1exuaPBzlROPGXoSRAg4yJKBwAbHVyJm7o6dC62ePZMSIKGmcwrrR4
        30z+YpcY9gK2GzHyRbnbMSLPArHm9ZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660827342;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sJEwWSFqU6oCQ3hFoCpEh8KwtvEuuUKuQbO2CF8zCc8=;
        b=7GEb1o+ob+UZ0gz9UzqgWkBPASolx2pCDw+wtXcI+tDAhtGiEqFTONOckvRA9D8fr3s9bF
        QThvU/Z5z18tfnBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF00A133B5;
        Thu, 18 Aug 2022 12:55:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DeCjLc02/mKdUAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 18 Aug 2022 12:55:41 +0000
Date:   Thu, 18 Aug 2022 14:50:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] btrfs: don't merge pages into bio if their page
 offset is not continuous
Message-ID: <20220818125030.GK13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Christoph Hellwig <hch@lst.de>
References: <1d9b69af6ce0a79e54fbaafcc65ead8f71b54b60.1660377678.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d9b69af6ce0a79e54fbaafcc65ead8f71b54b60.1660377678.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 13, 2022 at 04:06:53PM +0800, Qu Wenruo wrote:
> [BUG]
> Zygo reported on latest devel branch, he can hit ASSERT()/BUG_ON()
> caused crash when doing RAID5 recovery (intentionally corrupt one disk,
> and let btrfs to recovery the data during read/scrub).
> 
> And The following minimal reproducer can cause extent state leakage at
> rmmod time:
> 
>   mkfs.btrfs -f -d raid5 -m raid5 $dev1 $dev2 $dev3 -b 1G > /dev/null
>   mount $dev1 $mnt
>   fsstress -w -d $mnt -n 25 -s 1660807876
>   sync
>   fssum -A -f -w /tmp/fssum.saved $mnt
>   umount $mnt
> 
>   # Wipe the dev1 but keeps its super block
>   xfs_io -c "pwrite -S 0x0 1m 1023m" $dev1
>   mount $dev1 $mnt
>   fssum -r /tmp/fssum.saved $mnt > /dev/null
>   umount $mnt
>   rmmod btrfs
> 
> This will lead to the following extent states leakage:
> 
>  BTRFS: state leak: start 499712 end 503807 state 5 in tree 1 refs 1
>  BTRFS: state leak: start 495616 end 499711 state 5 in tree 1 refs 1
>  BTRFS: state leak: start 491520 end 495615 state 5 in tree 1 refs 1
>  BTRFS: state leak: start 487424 end 491519 state 5 in tree 1 refs 1
>  BTRFS: state leak: start 483328 end 487423 state 5 in tree 1 refs 1
>  BTRFS: state leak: start 479232 end 483327 state 5 in tree 1 refs 1
>  BTRFS: state leak: start 475136 end 479231 state 5 in tree 1 refs 1
>  BTRFS: state leak: start 471040 end 475135 state 5 in tree 1 refs 1
> 
> [CAUSE]
> Since commit 7aa51232e204 ("btrfs: pass a btrfs_bio to
> btrfs_repair_one_sector"), we always use btrfs_bio->file_offset to
> determine the file offset of a page.
> 
> But that usage assume that, one bio has all its page having a continuous
> page offsets.
> 
> Unfortunately that's not true, btrfs only requires the logical bytenr
> continuous when assembling its bios.
> 
> >From above script, we have one bio looks like this:
>   fssum-27671  submit_one_bio: bio logical=217739264 len=36864
>   fssum-27671  submit_one_bio:   r/i=5/261 page_offset=466944 <<<
>   fssum-27671  submit_one_bio:   r/i=5/261 page_offset=724992 <<<
>   fssum-27671  submit_one_bio:   r/i=5/261 page_offset=729088
>   fssum-27671  submit_one_bio:   r/i=5/261 page_offset=733184
>   fssum-27671  submit_one_bio:   r/i=5/261 page_offset=737280
>   fssum-27671  submit_one_bio:   r/i=5/261 page_offset=741376
>   fssum-27671  submit_one_bio:   r/i=5/261 page_offset=745472
>   fssum-27671  submit_one_bio:   r/i=5/261 page_offset=749568
>   fssum-27671  submit_one_bio:   r/i=5/261 page_offset=753664
> 
> Note that the 1st and the 2nd page has non-continuous page offsets.
> 
> This means, at repair time, we will have completely wrong file offset
> passed in:
> 
>    kworker/u32:2-19927  btrfs_repair_one_sector: r/i=5/261 page_off=729088 file_off=475136 bio_offset=8192
> 
> Since the file offset is incorrect, we latter incorrectly set the extent
> states, and no way to really release them.
> 
> Thus later it causes the leakage.
> 
> In fact, this can be even worse, since the file offset is incorrect, we
> can hit cases like the incorrect file offset belongs to a HOLE, and
> later cause btrfs_num_copies() to trigger error, finally hit
> BUG_ON()/ASSERT() later.
> 
> [FIX]
> This patch will add an extra condition in btrfs_bio_add_page() for
> uncompressed IO.
> 
> Now we will have more strict requirement for bio pages:
> 
> - They should all have the same mapping
>   (the mapping check is already implied by the call chain)
> 
> - Their logical bytenr should be adjacent
>   This is the same as the old condition.
> 
> - Their page_offset() (file offset) should be adjacent
>   This is the new check.
>   This would result a slightly increased amount of bios from btrfs
>   (needs holes and inside the same stripe boundary to trigger).
> 
>   But this would greatly reduce the confusion, as it's pretty common
>   to assume a btrfs bio would only contain continuous page cache.
> 
> Later we may need extra cleanups, as we no longer needs to handle gaps
> between page offsets in endio functions.
> 
> Currently this should be the minimal patch to fix commit 7aa51232e204
> ("btrfs: pass a btrfs_bio to btrfs_repair_one_sector").
> 
> Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Fixes: 7aa51232e204 ("btrfs: pass a btrfs_bio to btrfs_repair_one_sector")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thanks for fixing it, added to misc-next.

> @@ -3265,10 +3265,34 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
>  	if (bio_ctrl->compress_type != compress_type)
>  		return 0;
>  
> -	if (bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
> +
> +	if (bio->bi_iter.bi_size == 0) {
> +		/* We can always add a page into an empty bio. */
> +		contig = true;
> +	} else if (bio_ctrl->compress_type == BTRFS_COMPRESS_NONE) {
> +		struct bio_vec *bvec = bio_last_bvec_all(bio);
> +
> +		/*
> +		 * The contig check requires the following conditions to be met:
> +		 * 1) The pages are belonging to the same inode
> +		 *    This is implied by the call chain.
> +		 *
> +		 * 2) The range has adjacent logical bytenr
> +		 *
> +		 * 3) The range has adjacent file offset (NEW)
> +		 *    This is required for the usage of btrfs_bio->file_offset.
> +		 */
> +		contig = bio_end_sector(bio) == sector &&
> +			 page_offset(bvec->bv_page) + bvec->bv_offset +
> +			 bvec->bv_len == page_offset(page) + pg_offset;

I've converted this to an if(), the one line condition assignments
should be used for simple expressions like "X = (A == B)", otherwise
it's hard to read.
