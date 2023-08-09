Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98BE776791
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 20:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjHISoO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 14:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjHISoN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 14:44:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F70E51
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 11:44:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 19DE7210E6;
        Wed,  9 Aug 2023 18:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691606651;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jFweVdO4MxfdlBYOQMMO+bOtDOUJv504jnvxzatUD9o=;
        b=2rdJZ134u4e31QfnewAZ7nmVSJfr1lVofgQ7AvYrGGLv+UZNp/j0r1cwKC8xNQjJEZXrMT
        IBcqB7nyfzA2S6KsFmFmtmZ5zU/CavpmBQLid9k1GaE1jrjL6mBa8VFiayeeZw2hRVKQwY
        f6vz4qg7/KR4usgzvzVC29c6QS/2YwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691606651;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jFweVdO4MxfdlBYOQMMO+bOtDOUJv504jnvxzatUD9o=;
        b=TqwA0pB938UVrNxVDIpBpkIy10+X3FFeKsRDdW5g1hgs+mXhi2e1PeuRfElPRHHg3bjXTX
        nCyf3IqHpINXzhDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04D13133B5;
        Wed,  9 Aug 2023 18:44:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +31sAHve02R/HwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 09 Aug 2023 18:44:11 +0000
Date:   Wed, 9 Aug 2023 20:44:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: handle errors properly in
 update_inline_extent_backref()
Message-ID: <ZNPeebcs8XyBmSod@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <7a56e967d536bbb3d40c90def6e59e9970ef3445.1691564698.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a56e967d536bbb3d40c90def6e59e9970ef3445.1691564698.git.wqu@suse.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 09, 2023 at 03:08:21PM +0800, Qu Wenruo wrote:
> [PROBLEM]
> Inside function update_inline_extent_backref(), we have several
> BUG_ON()s along with some ASSERT()s which can be triggered by corrupted
> filesystem.
> 
> [ANAYLYSE]
> Most of those BUG_ON()s and ASSERT()s are just a way of handling
> unexpected on-disk data.
> 
> Although we have tree-checker to rule out obviously incorrect extent
> tree blocks, it's not enough for those ones.

Yeah we know tree-checker does not have and cannot have complete
coverage of the input data so we may need to add more sanity checks and
definitely convert the BUG_ONs if they "act" as error handling.

> Thus we need proper error handling for them.
> 
> [FIX]
> Thankfully all the callers of update_inline_extent_backref() would
> eventually handle the errror by aborting the current transaction.
> 
> So this patch would do the proper error handling by:
> 
> - Make update_inline_extent_backref() to return int
>   The return value would be either 0 or -EUCLEAN.
> 
> - Replace BUG_ON()s and ASSERT()s with proper error handling
>   This includes:
>   * Dump the bad extent tree leaf
>   * Output an error message for the cause
>     This would include the extent bytenr, num_bytes (if needed),
>     the bad values and expected good values.
>   * Return -EUCLEAN
> 
>   Note here we remove all the WARN_ON()s, as eventually the transaction
>   would be aborted, thus a backtrace would be triggered anyway.
> 
> - Better comments on why we expect refs == 1 and refs_to_mode == -1 for
>   tree blocks
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
