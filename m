Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57066A752C
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 21:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCAUUr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 15:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCAUUq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 15:20:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377D8521CB
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 12:20:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4046A21A98;
        Wed,  1 Mar 2023 20:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677701984;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x7/o9bnT7/lT0f0P85In+6beXf+h+CBL2SRIsjN/wCI=;
        b=B4W6zv7V4Oe+8gRTVNBuC39usFlqwJXGWpss7J8WJcZpTe69KNvJVhkfrRjOHEYFX1VLjk
        9dMsawu9L9ipPCdsiPB7iiGMgixlbJK4qu7ikdjXpOX5zq+5LcRHiSJuqpuPrmcpJLLzUq
        yrHOmeWBTIoLikIeCrYUM/5ioQO1jC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677701984;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x7/o9bnT7/lT0f0P85In+6beXf+h+CBL2SRIsjN/wCI=;
        b=kHfGQvGFbCE6cKudUf9TieFSP2pq/oWdNB603s9ZfiuguoXbkzgbh/455fMVNnIJpHtOkO
        rmjywF8scSDkl4BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A5C113A3E;
        Wed,  1 Mar 2023 20:19:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P3yfBWCz/2PocAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 01 Mar 2023 20:19:44 +0000
Date:   Wed, 1 Mar 2023 21:13:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: avoid unnecessary extent tree search for
 simple stripes
Message-ID: <20230301201344.GZ10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e8b3a59de5f43c185427a8d87c303ba3e8ff6ff1.1673244671.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8b3a59de5f43c185427a8d87c303ba3e8ff6ff1.1673244671.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 09, 2023 at 02:11:15PM +0800, Qu Wenruo wrote:
> [BUG]
> When scrubing an empty fs with RAID0, we will call scrub_simple_mirror()
> again and again on ranges which has no extent at all.
> 
> This is especially obvious if we have both RAID0 and SINGLE.
> 
>  # mkfs.btrfs -f -m single -d raid0 $dev
>  # mount $dev $mnt
>  # xfs_io -f -c "pwrite 0 4k" $mnt/file
>  # sync
>  # btrfs scrub start -B $mnt
> 
> With extra call trace on scrub_simple_mirror(), we got the following
> trace:
> 
>   256.028473: scrub_simple_mirror: logical=1048576 len=4194304 bg=1048576 bg_len=4194304
>   256.028930: scrub_simple_mirror: logical=5242880 len=8388608 bg=5242880 bg_len=8388608
>   256.029891: scrub_simple_mirror: logical=22020096 len=65536 bg=22020096 bg_len=1073741824
>   256.029892: scrub_simple_mirror: logical=22085632 len=65536 bg=22020096 bg_len=1073741824
>   256.029893: scrub_simple_mirror: logical=22151168 len=65536 bg=22020096 bg_len=1073741824
>   ... 16K lines skipped ...
>   256.048777: scrub_simple_mirror: logical=1095630848 len=65536 bg=22020096 bg_len=1073741824
>   256.048778: scrub_simple_mirror: logical=1095696384 len=65536 bg=22020096 bg_len=1073741824
> 
> The first two lines shows we just call scrub_simple_mirror() for the
> metadata and system chunks once.
> 
> But later 16K lines are all scrub_simple_mirror() for the almost empty
> RAID0 data block group.
> 
> Most of the calls would exit very quickly since there is no extent in
> that data chunk.
> 
> [CAUSE]
> For RAID0/RAID10 we go scrub_simple_stripe() to handle the scrub for the
> block group. And since inside each stripe it's just plain SINGLE/RAID1,
> thus we reuse scrub_simple_mirror().
> 
> But there is a pitfall, that inside scrub_simple_mirror() we will do at
> least one extent tree search to find the extent in the range.
> 
> Just like above case, we can have a huge gap which has no extent in them
> at all.
> In that case, we will do extent tree search again and again, even we
> already know there is no more extent in the block group.
> 
> [FIX]
> To fix the super inefficient extent tree search, we introduce
> @found_next parameter for the following functions:
> 
> - find_first_extent_item()
> - scrub_simple_mirror()
> 
> If the function find_first_extent_item() returns 1 and @found_next
> pointer is provided, it will store the bytenr of the bytenr of the next
> extent (if at the end of the extent tree, U64_MAX is used).
> 
> So for scrub_simple_stripe(), after scrubing the current stripe and
> increased the logical bytenr, we check if our next range reaches
> @found_next.
> 
> If not, increase our @cur_logical by our increment until we reached
> @found_next.
> 
> By this, even for an almost empty RAID0 block group, we just execute
> "cur_logical += logical_increment;" 16K times, not doing tree search 16K
> times.
> 
> With the optimization, the same trace looks like this now:
> 
>   1283.376212: scrub_simple_mirror: logical=1048576 len=4194304 bg=1048576 bg_len=4194304
>   1283.376754: scrub_simple_mirror: logical=5242880 len=8388608 bg=5242880 bg_len=8388608
>   1283.377623: scrub_simple_mirror: logical=22020096 len=65536 bg=22020096 bg_len=1073741824
>   1283.377625: scrub_simple_mirror: logical=67108864 len=65536 bg=22020096 bg_len=1073741824
>   1283.377627: scrub_simple_mirror: logical=67174400 len=65536 bg=22020096 bg_len=1073741824
> 
> Note the scrub at logical 67108864, that's because the 4K write only
> lands there, not at the beginning of the data chunk (due to super block
> reserved space split the 1G chunk into two parts).
> 
> And the time duration of the chunk 22020096 is much shorter
> (18887us vs 4us).
> 
> Unfortunately this optimization only works for RAID0/RAID10 with big
> holes in the block group.
> 
> For real world cases it's much harder to find huge gaps (although we can
> still skip several stripes).
> And even for the huge gap cases, the optimization itself is hardly
> observable (less than 1 second even for an almost empty 10G block group).
> 
> And also unfortunately for RAID5 data stripes, we can not go the similar
> optimization for RAID0/RAID10 due to the extra rotation.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This patch does not apply cleanly and I'm not sure if you were planning
an followup or not. If yes, please resend, thanks.
