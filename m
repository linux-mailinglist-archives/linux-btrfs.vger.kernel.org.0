Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F7D5A6BA7
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Aug 2022 20:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiH3SD1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Aug 2022 14:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiH3SDI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Aug 2022 14:03:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC88B104022
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 11:02:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A0665219E8;
        Tue, 30 Aug 2022 18:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661882541;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OtDX0gua3QyIeqR5ry70z0x0WOutSKtwOkP9x4KwpDw=;
        b=qpb5r8sEx9ctxBKEr1IZGdXEiKgK2GabIQWWWFOBrzogXaUwAE5rsSs7d/dqAuEPn5j/Lq
        9YnFfDojsoTDRAjrkjYOKPH1XhEjP3/3dWVZKjomsY5m7JI7Y+mG+3gdsShRbxdsYKd5EB
        ankV3D0G0WZIHapiC5uTOUSsVN9J/tE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661882541;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OtDX0gua3QyIeqR5ry70z0x0WOutSKtwOkP9x4KwpDw=;
        b=qPzy4MTX6WHyrOZanfVvlVesap3v8A0EInYfVQpASp+PyQlYVelT42pZzvV1phawfSISks
        IXVUhUOFVRkq8ZAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6360C13B0C;
        Tue, 30 Aug 2022 18:02:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XqUMF61QDmPGbQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 30 Aug 2022 18:02:21 +0000
Date:   Tue, 30 Aug 2022 19:57:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH DON'T MERGE] btrfs-progs: crash if eb has leaked for
 debug builds
Message-ID: <20220830175702.GD13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <d1986a1743d1f0e56a680b6ab4ba92ba225c21db.1661836144.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1986a1743d1f0e56a680b6ab4ba92ba225c21db.1661836144.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 30, 2022 at 01:10:29PM +0800, Qu Wenruo wrote:
> !!! DON'T MERGE !!!
> 
> Currently if we leaked some extent buffers, btrfs-progs can still work
> fine, and will only output a not-that-obvious message like:
> 
>  extent buffer leak: start 30572544 len 16384
> 
> This is pretty hard to catch and test cases will not be able to catch
> such regression.
> 
> This patch will add a new default debug cflags,
> -DDEBUG_ABORT_ON_EB_LEAK, and in extent_io_tree_cleanup(), if that
> debug flag is enabled, we will report all the leaked eb first, then
> crash to make users and test cases to catch this problem.
> 
> Unfortunately the eb leakage is a big problem, fsck tests can only reach
> 002 before crashing at that test image.
> 
> If someone can help fixing all the eb leakage it would be great.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  Makefile                  | 2 +-
>  kernel-shared/extent_io.c | 8 +++++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 2a37d1c6b5eb..beaa31d36f0e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -65,7 +65,7 @@ include Makefile.extrawarn
>  EXTRA_CFLAGS :=
>  EXTRA_LDFLAGS :=
>  
> -DEBUG_CFLAGS_DEFAULT = -O0 -U_FORTIFY_SOURCE -ggdb3
> +DEBUG_CFLAGS_DEFAULT = -O0 -U_FORTIFY_SOURCE -ggdb3 -DDEBUG_ABORT_ON_EB_LEAK
>  DEBUG_CFLAGS_INTERNAL =

We have the tests/scan-results.sh script with patterns to look for, the
extent buffer leak is not there but it could be:

+                       *extent\ buffer\ leak*) echo "EXTENT BUFFER LEAK: $last" ;;

The standard assert.h and assert can be used for the leak check but it's
also in the release build I think so we may use a separate macro for
that, or maybe add another class for leak checks.
