Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C52961F414
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 14:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiKGNOL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 08:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiKGNOJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 08:14:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF92D74
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 05:14:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B05431F891;
        Mon,  7 Nov 2022 13:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667826847;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XPGrK2RTqTFtH4xXy/g81dgwgSPonQBXxlR6l5KpCCM=;
        b=wH9g8cuE1Fmdm1uK4S29aw9g45lzZuI9Toc9LfJEpzAD+nXMTwFJgtAHGrWT7hRCAXiNPQ
        dYKG0KtkT1t7DsVzlhKu5XxeSbsERx+oS5QFWvlBEu0b3LQdSWNPlr4k7+fDt1BPC+ZQz/
        1MP4DK5AUKtftbL1Gl+KsTr0VuKmgag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667826847;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XPGrK2RTqTFtH4xXy/g81dgwgSPonQBXxlR6l5KpCCM=;
        b=ql1ippYBTRLq+apJgKYFOhcoWRAK3ZDGb1CBNTpSEYjpWXUfIRLwgtQAAgMDs78OMcdDsj
        WK6ciVlLTPoYoMAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94B8113494;
        Mon,  7 Nov 2022 13:14:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RvlyI58EaWOeUgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 07 Nov 2022 13:14:07 +0000
Date:   Mon, 7 Nov 2022 14:13:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Revert "btrfs: scrub: use larger block size for data
 extent scrub"
Message-ID: <20221107131346.GS5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <97622c5c2e2dbb2316901c6ebd9792cbf58385fd.1667776994.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97622c5c2e2dbb2316901c6ebd9792cbf58385fd.1667776994.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 07, 2022 at 07:23:26AM +0800, Qu Wenruo wrote:
> This reverts commit 786672e9e1a39a231806313e3c445c236588ceef.
> 
> [BUG]
> Since commit 786672e9e1a3 ("btrfs: scrub: use larger block size for data
> extent scrub"), btrfs scrub no longer reports errors if the corruption
> is not in the first sector of a STRIPE_LEN.
> 
> The following script can expose the problem:
> 
>  mkfs.btrfs -f $dev
>  mount $dev $mnt
>  xfs_io -f -c "pwrite -S 0xff 0 8k" $mnt/foobar
>  umount $mnt
> 
>  # 13631488 is the logical bytenr of above 8K extent
>  btrfs-map-logical -l 13631488 -b 4096 $dev
>  mirror 1 logical 13631488 physical 13631488 device /dev/test/scratch1
> 
>  # Corrupt the 2nd sector of that extent
>  xfs_io -f -c "pwrite -S 0x00 13635584 4k" $dev
> 
>  mount $dev $mnt
>  btrfs scrub start -B $mnt
>  scrub done for 54e63f9f-0c30-4c84-a33b-5c56014629b7
>  Scrub started:    Mon Nov  7 07:18:27 2022
>  Status:           finished
>  Duration:         0:00:00
>  Total to scrub:   536.00MiB
>  Rate:             0.00B/s
>  Error summary:    no errors found <<<
> 
> [CAUSE]
> That offending commit enlarge the data extent scrub size from sector
> size to BTRFS_STRIPE_LEN, to avoid extra scrub_block to be allocated.
> 
> But unfortunately the data extent scrub is still heavily relying on the
> fact that there is only one scrub_sector per scrub_block.
> 
> Thus it will only check the first sector, and ignoring the remaining
> sectors.
> 
> Furthermore the error reporting is not able to handle multiple sectors
> either.
> 
> [FIX]
> For now just revert the offending commit.
> 
> The consequence is just extra memory usage during scrub.
> We will need a proper change to make the remaining data scrub path to
> handle multiple sectors before we enlarging the data scrub size.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
