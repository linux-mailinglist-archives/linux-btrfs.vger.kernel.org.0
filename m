Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B31C5A6A4E
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Aug 2022 19:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiH3R1E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Aug 2022 13:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiH3R0W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Aug 2022 13:26:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D3EF23D5
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 10:24:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 38DE921F64;
        Tue, 30 Aug 2022 17:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661880169;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JonBnXnORadoo3iFxqvlWqXO6qcs0F5rLy4bZOxvb4M=;
        b=jm9K7BDfgm4AnwL1klKK0niVQnURJDy//cbBc80CF7LN7026uQiJA4KlC5gBGfuewci2lQ
        86wsA/Vu2buST81Uh1vH449ZfJAekvEegOqBfcZTwmGtmJE+oP1ABjylssAwrw4hbi5zuG
        zjYz+Mb+IbHIt2ktvlSppH8kuGOvegA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661880169;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JonBnXnORadoo3iFxqvlWqXO6qcs0F5rLy4bZOxvb4M=;
        b=HXX4HjDe/2cCxlCaC3gZg3kg4jKtm9kqv8N0KC3odkpdLm1aiwlwUevnYfqSq6nFFQ6Vuf
        AOXRe0gZ57xxWKCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01E2613B0C;
        Tue, 30 Aug 2022 17:22:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id g/v7OmhHDmNGXwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 30 Aug 2022 17:22:48 +0000
Date:   Tue, 30 Aug 2022 19:17:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fix eb leakage caused by missing
 btrfs_release_path() call.
Message-ID: <20220830171730.GB13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <043f1db2c7548723eaff302ebba4183afb910830.1661835430.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <043f1db2c7548723eaff302ebba4183afb910830.1661835430.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 30, 2022 at 12:57:16PM +0800, Qu Wenruo wrote:
> [BUG]
> Commit 06b6ad5e017e ("btrfs-progs: check: check for invalid free space
> tree entries") makes btrfs check to report eb leakage even on newly
> created btrfs:
> 
>  # mkfs.btrfs -f test.img
>  # btrfs check test.img
>   Opening filesystem to check...
>   Checking filesystem on test.img
>   UUID: 13c26b6a-3b2c-49b3-94c7-80bcfa4e494b
>   [1/7] checking root items
>   [2/7] checking extents
>   [3/7] checking free space tree
>   [4/7] checking fs roots
>   [5/7] checking only csums items (without verifying data)
>   [6/7] checking root refs
>   [7/7] checking quota groups skipped (not enabled on this FS)
>   found 147456 bytes used, no error found
>   total csum bytes: 0
>   total tree bytes: 147456
>   total fs tree bytes: 32768
>   total extent tree bytes: 16384
>   btree space waste bytes: 140595
>   file data blocks allocated: 0
>    referenced 0
>   extent buffer leak: start 30572544 len 16384 <<< Extent buffer leakage
> 
> [CAUSE]
> Surprisingly the patch submitted to the mailing list is correct:
> 
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	while (1) {
> ...
> +		if (ret < 0)
> +			goto out;
> +		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0]))
> +			break;
> ...
> +	}
> +	ret = 0;
> +out:
> +	btrfs_free_path(path);
> +	return ret;
> +}

Please don't put diffs into changelogs, it confuses some tools that
parse the mails or patches.

> 
> So no matter if it's an error or we exhausted the free space tree, the
> path will be released and freed eventually.
> 
> But the commit merged into btrfs-progs goes on-stack path method:

I do that because that's the preferred style, but not all people respond
to mailing list comments so we're left with unfixed bug with patch or a
unclean version committed if there's no followup. Or something in
between that could introduce bugs.

> 
> +       btrfs_init_path(&path);
> +
> +       while (1) {
> ...
> +               if (ret < 0)
> +                       goto out;
> +               if (path.slots[0] >= btrfs_header_nritems(path.nodes[0]))
> +                       break;
> +
> +               btrfs_release_path(&path);
> ...
> +       }
> +       ret = 0;
> +out:
> +       return ret;
> +}
> +
> 
> Now we only release the path inside the while loop, no at out tag.
> This means, if we hit error or even just exhausted free space tree as
> expected, we will leak the path to free space tree root.
> 
> Thus leading to the above leakage report.
> 
> [FIX]
> Fix the bug by calling btrfs_release_path() at out: tag too.
> 
> This should make the code behave the same as the patch submitted to the
> mailing list.
> 
> Fixes: 06b6ad5e017e ("btrfs-progs: check: check for invalid free space tree entries")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
