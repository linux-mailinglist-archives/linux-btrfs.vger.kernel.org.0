Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C231728033
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 14:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbjFHMjH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 08:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236119AbjFHMjG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 08:39:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9F8E43
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 05:39:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 572AF1FDE4;
        Thu,  8 Jun 2023 12:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686227944;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TlDnBB5jVrbGpSrAelawORcZbLMTz3K/5DdMeS0e5y4=;
        b=InsxGT9rkblBww2Ql1vjjSLCXShDcE1KEdVf8vBmTKibW47RPqKjl8rrPfw9BMEO9ypfPv
        kHQzhAagosth16E0PFQzps+RQSwtBYwPP5A7gXogbh0eIXcHEZw+COP3jUZ6LePxKIT/9m
        SLWN9cxjjye4HQn/IApvIGOCT7OBVak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686227944;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TlDnBB5jVrbGpSrAelawORcZbLMTz3K/5DdMeS0e5y4=;
        b=NanVNyeWEd+fQMsNA20AjWwRMGYwF7FWisFAMg3VL0a99slAdDK/N7h30pA2jtIgKVwISt
        nAvT6kxfavsNjECg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 368CD13480;
        Thu,  8 Jun 2023 12:39:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3D9tDOjLgWTHRQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 08 Jun 2023 12:39:04 +0000
Date:   Thu, 8 Jun 2023 14:32:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: also report errors hit during the initial
 read
Message-ID: <20230608123248.GF28933@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <40578035047b80505e2adf02978c4c293abb44c9.1686035069.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40578035047b80505e2adf02978c4c293abb44c9.1686035069.git.wqu@suse.com>
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

On Tue, Jun 06, 2023 at 03:08:28PM +0800, Qu Wenruo wrote:
> [BUG]
> After the recent scrub rework introduced in commit e02ee89baa66 ("btrfs:
> scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure"),
> btrfs scrub no longer reports repaired errors any more:
> 
>  # mkfs.btrfs -f $dev -d DUP
>  # mount $dev $mnt
>  # xfs_io -f -d -c "pwrite -b 64K -S 0xaa 0 64" $mnt/file
>  # umount $dev
>  # xfs_io -f -c "pwrite -S 0xff $phy1 64K" $dev # Corrupt the first mirror
>  # mount $dev $mnt
>  # btrfs scrub start -BR $mnt
>  scrub done for 725e7cb7-8a4a-4c77-9f2a-86943619e218
>  Scrub started:    Tue Jun  6 14:56:50 2023
>  Status:           finished
>  Duration:         0:00:00
>  	data_extents_scrubbed: 2
>  	tree_extents_scrubbed: 18
>  	data_bytes_scrubbed: 131072
>  	tree_bytes_scrubbed: 294912
>  	read_errors: 0
>  	csum_errors: 0 <<< No errors here
>  	verify_errors: 0
> 	[...]
>  	uncorrectable_errors: 0
>  	unverified_errors: 0
>  	corrected_errors: 16 <<< Only corrected errors
>  	last_physical: 2723151872
> 
> This can confuse btrfs-progs, as it relies on the csum_errors to
> determine if there is anything wrong.
> 
> While on v6.3.x kernels, the report is different:
> 
>  	csum_errors: 16 <<<
>  	verify_errors: 0
> 	[...]
>  	uncorrectable_errors: 0
>  	unverified_errors: 0
>  	corrected_errors: 16 <<<
> 
> [CAUSE]
> In the reworked scrub, we update the scrub progress inside
> scrub_stripe_report_errors(), using various bitmaps to update the
> result.
> 
> For example for csum_errors, we use bitmap_weight() of
> stripe->csum_error_bitmap.
> 
> Unfortunately at that stage, all error bitmaps (except
> init_error_bitmap) are the result of the latest repair attempt, thus if
> the stripe is fully repaired, those error bitmaps will all be empty,
> resulting the above output mismatch.
> 
> To fix this, record the number of errors into stripe->init_nr_*_errors.
> Since we don't really care about where those errors are, we only need to
> record the number of errors.
> 
> Then in scrub_stripe_report_errors(), use those initial numbers to
> update the progress other than using the latest error bitmaps.
> 
> Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks. Also queued with the other scrub patch for 6.4
