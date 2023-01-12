Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9856679BC
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jan 2023 16:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240608AbjALPpN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Jan 2023 10:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240408AbjALPol (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Jan 2023 10:44:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADBC5D6B7
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jan 2023 07:35:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 72C88402A5;
        Thu, 12 Jan 2023 15:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673537706;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GbgUuUDHl202OK5HFlczqmhS8JRfeqzOV/7SZCtpmb0=;
        b=R7mOvOWnhcefT6lnGz1qRMaPwh62QsYLhFKjJ43jAcesC0WMhXxR4yEGkl67YkQdSOVx8t
        WxsQKUBIVLTPTeWyvUVuQXTZzzREoX5dY1pQqcBjeQS2igc3hnYIYB1HPg/LkQP/DRbp1Q
        LmaiXnVkVWbqw8fO7JVxIEgkQeoC3rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673537706;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GbgUuUDHl202OK5HFlczqmhS8JRfeqzOV/7SZCtpmb0=;
        b=qAR1IcW48N8atvw7rFHAc3yK+Z+s5BY9tKoLJ6ip1lIhzp3U3AsWsm7a7fvducblluZMoC
        3+3WydpV8ApU8xDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50E0613776;
        Thu, 12 Jan 2023 15:35:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0DnMEqoowGPwKQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 12 Jan 2023 15:35:06 +0000
Date:   Thu, 12 Jan 2023 16:29:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: improve its tree block error reporting
Message-ID: <20230112152930.GO11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0ba09faab92972fb164215f3614678678cc0fa16.1671244467.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ba09faab92972fb164215f3614678678cc0fa16.1671244467.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Dec 17, 2022 at 10:34:29AM +0800, Qu Wenruo wrote:
> [BUG]
> When debugging a scrub related metadata error, it turns out that our
> metadata error reporting is not ideal.
> 
> The only 3 error messages are:
> 
> - BTRFS error (device dm-2): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 0, gen 1
>   Showing we have metadata generation mismatch errors.
> 
> - BTRFS error (device dm-2): unable to fixup (regular) error at logical 7110656 on dev /dev/mapper/test-scratch1
>   Showing which tree blocks are corrupted.
> 
> - BTRFS warning (device dm-2): checksum/header error at logical 24772608 on dev /dev/mapper/test-scratch2, physical 3801088: metadata node (level 1) in tree 5
>   Showing which physical range the corrupted metadata is at.
> 
> We have to combine the above 3 to know we have a corrupted metadata with
> generation mismatch.
> 
> And this is already the better case, if we have other problems, like
> fsid mismatch, we can not even know the cause.
> 
> [CAUSE]
> The problem is caused by the fact that, scrub_checksum_tree_block()
> never outputs any error message.
> 
> It just return two bits for scrub: sblock->header_error, and
> sblock->generation_error.
> 
> And later we report error in scrub_print_warning(), but unfortunately we
> only have two bits, there is not really much thing we can done to print
> any detailed errors.
> 
> [FIX]
> This patch will do the following to enhance the error reporting of
> metadata scrub:
> 
> - Add extra warning (ratelimited) for every error we hit
>   This can help us to distinguish the different types of errors.
>   Some errors can help us to know what's going wrong immediately,
>   like bytenr mismatch.
> 
> - Re-order the checks
>   Currently we check bytenr first, then immediately geneartion.
>   This can lead to false generation mismatch reports, while the fsid
>   mismatches.
> 
> Here is the newer output for the bug I'm debugging (we forgot to
> writeback tree blocks for commit roots):
> 
>  BTRFS warning (device dm-2): tree block 24117248 mirror 1 has bad fsid, has b77cd862-f150-4c71-90ec-7baf0544d83f want 17df6abf-23cd-445f-b350-5b3e40bfd2fc
>  BTRFS warning (device dm-2): tree block 24117248 mirror 0 has bad fsid, has b77cd862-f150-4c71-90ec-7baf0544d83f want 17df6abf-23cd-445f-b350-5b3e40bfd2fc
> 
> Now we can immediately know it's some tree blocks didn't even get written
> back, other than the original confusing generation mismatch.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
