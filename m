Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BF67D5C40
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Oct 2023 22:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343896AbjJXUQC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Oct 2023 16:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343823AbjJXUQB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Oct 2023 16:16:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7496ED7A
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Oct 2023 13:15:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD0271FEB5;
        Tue, 24 Oct 2023 20:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698178555;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FjdDIPD9PeF5Jc7OQ3s9knRp/bxEJy67IAyLK1pJMu4=;
        b=QFhE2auybH6wjPXVY7FE+MXoX8PpFkViMElI7cRSj1QZFvi4EItK/qe6uSUu1Gs/j+9CGG
        YJC0Wy7sfv4rhFURYSkwPV2kMqZlDbYhoC6nPq97Oh/wKZ4NndC6o6Bq4k3w0zuGBPcjoK
        OSnhs8G7BvLvJUYtmGo/LIwyCEEylIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698178555;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FjdDIPD9PeF5Jc7OQ3s9knRp/bxEJy67IAyLK1pJMu4=;
        b=2AIXVNzqYGmmTx+AY/7GXQ8yGQnJmBDOyzAgHoOpl8RhpGkDBFz6ztM70mDNsRnl1g7JfH
        XgOsUtyCVw8gqNBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B7541391C;
        Tue, 24 Oct 2023 20:15:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yJhvIfslOGU3VwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 24 Oct 2023 20:15:55 +0000
Date:   Tue, 24 Oct 2023 22:09:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: move space cache removal to rescue group
Message-ID: <20231024200901.GU26353@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b64e4bc22f58a826d65aae73c2eed9ca029f1dca.1698139433.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b64e4bc22f58a826d65aae73c2eed9ca029f1dca.1698139433.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 24, 2023 at 07:53:57PM +1030, Qu Wenruo wrote:
> The option "--clear-space-cache" is not really that suitable for "btrfs
> check" group, as there are some concerns:
> 
> - Allowing transid mismatch
> - No leaf item checks
> 
>   Those behaviors are inherited from the default open ctree flags for
>   "btrfs check", which can be unsafe if the end user just wants to clear
>   the cache.
> 
> - Unclear if the the cache clearing would happen along with repair
> 
>   Thankfully the clearing of space cache is done without any repair
> 
> Thus there is a proposal to move space cache removal to rescue group,
> and this patch would do that exactly.
> 
> However this would lead to some behavior changes:
> 
> - Transid mismatch would be treated as error
> - Leaf items size/offset would still be checked
> 
>   If we hit any above error, we should just abort without doing any
>   write.
> 
> These change would increase the safety of the space cache removal, thus
> I believe it's worthy to introduce such behavior change.
> 
> Since we're here, also add a small explanation on why we need this
> dedicated tool to clear space cache (especially for v1 cache).
> 
> Issue: #698
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.

> --- a/check/main.c
> +++ b/check/main.c
> @@ -10232,6 +10232,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  	}
>  
>  	if (clear_space_cache) {
> +		warning("--clear-space-cache option is deprecated, please use \"btrfs rescue clear-space-cache\" instead");

I've also moved the help text of the option to the deprecated section.
