Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E89E73052B
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 18:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbjFNQko (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 12:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbjFNQkT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 12:40:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265FB1A3
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jun 2023 09:40:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CA9A61FDBD;
        Wed, 14 Jun 2023 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686760816;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XcH4yKxfNMrcybUVufsxPP1vtFSKkHhRbUtneZiS5Sc=;
        b=aBDbadWkKD5ojNKm1hJCv5qHynfh8W5digV5a/jObwRHg2jalsP7ZzSoZAbSDaypIHkrHU
        j3nSGCqf9T+ysloT6uJKLVcCYA2DaMN1tjtAJzwc40UY0bHTDndQ/Jx3+kliv0DnU+kTMp
        aseWZxs8DPfCK+ef2OUMALlsh5SHVe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686760816;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XcH4yKxfNMrcybUVufsxPP1vtFSKkHhRbUtneZiS5Sc=;
        b=C8ta1pBRq1w5rhmkH+j1kC3KAhL6nhLJJx5HnV+S5fhnrb8Rs3kR9pfyBtP63wEJ7FCewR
        8WDJIVK4+QV201DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A12271391E;
        Wed, 14 Jun 2023 16:40:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id silnJnDtiWR1PQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 14 Jun 2023 16:40:16 +0000
Date:   Wed, 14 Jun 2023 18:33:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: remove unused btrfs_path in
 scrub_simple_mirror()
Message-ID: <20230614163357.GN13486@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9a09b2850b25de2eb9142d95bcdb1b46ff0207af.1686724789.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a09b2850b25de2eb9142d95bcdb1b46ff0207af.1686724789.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 14, 2023 at 02:39:55PM +0800, Qu Wenruo wrote:
> The @path in scrub_simple_mirror() is no longer utilized after commit
> e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe
> infrastructure").
> 
> Before that commit, we call find_first_extent_item() directly, which
> needs a path and that path can be reused.
> 
> But after that switch commit, the extent search is done inside
> queue_scrub_stripe(), which will no longer accept a path from outside.
> 
> So the @path variable can be removed safed.
> 
> Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.

> ---
>  fs/btrfs/scrub.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 7bd446720104..be6efe9f3b55 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1958,15 +1958,12 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
>  	struct btrfs_fs_info *fs_info = sctx->fs_info;
>  	const u64 logical_end = logical_start + logical_length;
>  	/* An artificial limit, inherit from old scrub behavior */

This comment became stale after e02ee89baa66 ("btrfs: scrub: switch
scrub_simple_mirror() to scrub_stripe infrastructure") so I'll update
the patch to remove it as well.
