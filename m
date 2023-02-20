Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCE769D5A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 22:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjBTVO6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 16:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjBTVO5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 16:14:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F35113D4D
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 13:14:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4B81020BCC;
        Mon, 20 Feb 2023 21:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676927694;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XWtI2eKXc+Xaw7oKfrl7Q2+93z0LXHlxVs270EJSSmU=;
        b=hURsleUw2rzabaUux19YPAJpYAg/bsJJADp24wJVcvnlilIw7FKde8JtJhEkrFUXAbFXbw
        OvcwuotUJry/6yzmHlgZq5L75yvw6cyDBjTkgGv+CDoH7qkcEU2+CPsGdXt1T63v6Lstkf
        JuKtWh+r37cMJmEoABudK4xIfCr7qHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676927694;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XWtI2eKXc+Xaw7oKfrl7Q2+93z0LXHlxVs270EJSSmU=;
        b=nZhFQbtdbN5V5wn+q5p70I1k9W8QD8JTTg1dD+p3ITztXr0RIuluCy4ndvZ/qvoSt36ECv
        dWdugvc/6JoHlgAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DFCCD134BA;
        Mon, 20 Feb 2023 21:14:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id woGkNc3i82PJcAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 20 Feb 2023 21:14:53 +0000
Date:   Mon, 20 Feb 2023 22:08:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] btrfs: cleanup and small refactors around
 __btrfs_map_block()
Message-ID: <20230220210858.GL10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1676611535.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1676611535.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 17, 2023 at 01:36:57PM +0800, Qu Wenruo wrote:
> This series is based on the current misc-next branch, and can be fetched
> from github:
> 
>   https://github.com/adam900710/linux/tree/map_block_refactor
> 
> 
> This is the rebased and merged version of two patchset:
> 
>   btrfs: reduce div64 calls for __btrfs_map_block() and its variants
>   btrfs: reduce the memory usage for btrfs_io_context, and reduce its variable sized members
> 
> Originally the 2nd patchset has some dependency on the first one, but
> the first one is causing some conflicts with newer cleanups, thus only
> the 2nd patchset get merged into for-next.
> 
> This updated version would resolve the conflicts, and use the modified
> version from for-next.
> 
> Qu Wenruo (6):
>   btrfs: remove map_lookup->stripe_len
>   btrfs: reduce div64 calls by limiting the number of stripes of a chunk
>     to u32
>   btrfs: simplify the bioc argument for handle_ops_on_dev_replace()
>   btrfs: reduce type width of btrfs_io_contexts
>   btrfs: use a more space efficient way to represent the source of
>     duplicated stripes
>   btrfs: replace btrfs_io_context::raid_map with a fixed u64 value

Added to misc-next with some fixups, thanks.
