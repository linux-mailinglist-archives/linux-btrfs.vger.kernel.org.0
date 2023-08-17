Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2244B77F581
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 13:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244606AbjHQLpQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 07:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350479AbjHQLpE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 07:45:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980941FF3
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 04:44:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5ADA71F38A;
        Thu, 17 Aug 2023 11:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692272697;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SfN0IQazquKotUmhcuvCA14DGijfD1xrrbP8xCz/Ymw=;
        b=0GbgoGXxBPbs9HNoL1UphSraAijaDp0s5iCErlakqH8r2b6VCunzkwY2gcg4YHAiXqCGXw
        7bMeL4IC22KIGbigpvSjfZQUCJZBxm/UxbSZHt03ia17vxkCNs+/9AzfUefVqcGjg3XybB
        xIm40VCi02/QJG4+Dv4BWkfxBbzGgik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692272697;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SfN0IQazquKotUmhcuvCA14DGijfD1xrrbP8xCz/Ymw=;
        b=RlMEw9bCHRk2BKIY7TzNdhw9o+3/teo4cpB/L+kcWrGP8MYn6sgDYdLohqr1smNxsbO1Fl
        7yH3qdm/3ptZ+7Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E9311358B;
        Thu, 17 Aug 2023 11:44:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NmF5BjkI3mQLRQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 17 Aug 2023 11:44:57 +0000
Date:   Thu, 17 Aug 2023 13:38:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chris Mason <clm@fb.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, hch@lst.de
Subject: Re: [PATCH v2] Btrfs: only subtract from len_to_oe_boundary when it
 is tracking an extent
Message-ID: <20230817113828.GH2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230801162828.1396380-1-clm@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801162828.1396380-1-clm@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 01, 2023 at 09:28:28AM -0700, Chris Mason wrote:
> [Note: I dropped the RFC because I can now trigger on Linus kernels, and
> I think we need to send something to stable as well ]
> 
> bio_ctrl->len_to_oe_boundary is used to make sure we stay inside a zone
> as we submit bios for writes.  Every time we add a page to the bio, we
> decrement those bytes from len_to_oe_boundary, and then we submit the
> bio if we happen to hit zero.
> 
> Most of the time, len_to_oe_boundary gets set to U32_MAX.
> submit_extent_page() adds pages into our bio, and the size of the bio
> ends up limited by:
> 
> - Are we contiguous on disk?
> - Does bio_add_page() allow us to stuff more in?
> - is len_to_oe_boundary > 0?
> 
> The len_to_oe_boundary math starts with U32_MAX, which isn't page or
> sector aligned, and subtracts from it until it hits zero.  In the
> non-zoned case, the last IO we submit before we hit zero is going to be
> unaligned, triggering BUGs and other sadness.
> 
> This is hard to trigger because bio_add_page() isn't going to make a bio
> of U32_MAX size unless you give it a perfect set of pages and fully
> contiguous extents on disk.  We can hit it pretty reliably while making
> large swapfiles during provisioning because the machine is freshly
> booted, mostly idle, and the disk is freshly formatted.  It's also
> possible to trigger with reads when read_ahead_kb is set to 4GB.
> 
> The code has been clean up and shifted around a few times, but this flaw
> has been lurking since the counter was added.  I think Christoph's
> commit ended up exposing the bug.
> 
> The fix used here is to skip doing math on len_to_oe_boundary unless
> we've changed it from the default U32_MAX value.  bio_add_page() is the
> real limit we want, and there's no reason to do extra math when Jens
> is doing it for us.
> 
> Sample repro, note you'll need to change the path to the bdi and device:
> 
> SUBVOL=/btrfs/swapvol
> SWAPFILE=$SUBVOL/swapfile
> SZMB=8192
> 
> mkfs.btrfs -f /dev/vdb
> mount /dev/vdb /btrfs
> 
> btrfs subvol create $SUBVOL
> chattr +C $SUBVOL
> dd if=/dev/zero of=$SWAPFILE bs=1M count=$SZMB
> sync;sync;sync
> 
> echo 4 > /proc/sys/vm/drop_caches
> 
> echo 4194304 > /sys/class/bdi/btrfs-2/read_ahead_kb
> 
> while(true) ; do
>         echo 1 > /proc/sys/vm/drop_caches
>         echo 1 > /proc/sys/vm/drop_caches
>         dd of=/dev/zero if=$SWAPFILE bs=4096M count=2 iflag=fullblock
> done
> 
> Signed-off-by: Chris Mason <clm@fb.com>
> Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> CC: stable@vger.kernel.org # 6.4
> Fixes: 24e6c8082208 ("btrfs: simplify main loop in submit_extent_page")

Added to misc-next, thanks.
