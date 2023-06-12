Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A1B72C833
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 16:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbjFLOXo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 10:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbjFLOX2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 10:23:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B11B4493
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 07:21:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C0E7D1FFAD;
        Mon, 12 Jun 2023 14:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686579686;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/S0T7saA0zamYpgQOvJi3PoRo34YAQGlfu/zaqTiXM8=;
        b=W5ix5YypW8Jpnuww14N/n+5BVoUNG9Wom/elGYPcaC/T91Z0Sdy46TFqoisfiFyGVeLgBp
        ixX7ZmshZjQmIw9VOtztlmWeZEQSfK/fd0bFgFDoHUy32L+cVFYQlVniLgPZTpJsZHYeCM
        1HUgJc7s2tVRkjYaL8RZ63TmtmdfVh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686579686;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/S0T7saA0zamYpgQOvJi3PoRo34YAQGlfu/zaqTiXM8=;
        b=frD7OSpVx30t2kS/YFbIghKtIWY/a4ZRj+hqiZecJX1eyHAeHA+v+Ft8pOBabbQ7PITnUW
        y3H473Mlsb51/PBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB7CE1357F;
        Mon, 12 Jun 2023 14:21:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pEw8KeYph2QJHQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 12 Jun 2023 14:21:26 +0000
Date:   Mon, 12 Jun 2023 16:15:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: remove scrub_ctx::csum_list member
Message-ID: <20230612141508.GC13486@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <71bd17cb42d8caafe12b9fc009d97ba869d627b4.1686550463.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71bd17cb42d8caafe12b9fc009d97ba869d627b4.1686550463.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 12, 2023 at 02:14:29PM +0800, Qu Wenruo wrote:
> Since the rework of scrub introduced by commit 2af2aaf98205 ("btrfs:
> scrub: introduce structure for new BTRFS_STRIPE_LEN based interface")
> and later commits, scrub no longer keeps its data checksum inside sctx.
> 
> Instead we have scrub_stripe::csums for the checksum of the stripe.
> 
> Thus we can remove the unused scrub_ctx::csum_list member.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
