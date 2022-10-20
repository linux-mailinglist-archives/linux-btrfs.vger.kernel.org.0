Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495A7606508
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 17:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiJTPuO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 11:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiJTPuM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 11:50:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ABDBE510
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 08:50:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C26691FE78;
        Thu, 20 Oct 2022 15:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666281008;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9GTM+3TQQkXJuE3/1GSgrHZqG3bwd1rcUjQUnppwklw=;
        b=PJAck+PvnGxiNDmjQqb7umdlAl/eldaIohddhzJ6y/Cy0oUXDRu1HXhFlwGwW2T73ZiKOf
        rYPuGdDVv4dhqFViwSa/ivflVvO+DQlxJidDQfXA7/eycLcmXqN9YLlGRZjMctdcS+jDng
        TlVNBNRadxPmxvD5pevEWlyxy2J4j/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666281008;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9GTM+3TQQkXJuE3/1GSgrHZqG3bwd1rcUjQUnppwklw=;
        b=ZA44FAZG64MB1FzRseHUvNxreKdrc8pLCtzS1kGCeYPW0ScrEDwgmnMKAY1dvfDhFqfNXj
        Y6ASIDd74iBbNDCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92DE013494;
        Thu, 20 Oct 2022 15:50:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UFneIjBuUWNIEgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 20 Oct 2022 15:50:08 +0000
Date:   Thu, 20 Oct 2022 17:49:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 02/15] btrfs: move assert helpers out of ctree.h
Message-ID: <20221020154957.GJ13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1666190849.git.josef@toxicpanda.com>
 <d89ffe6bc0dd3fa90d5567a9a790a00acbf3d1e9.1666190849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d89ffe6bc0dd3fa90d5567a9a790a00acbf3d1e9.1666190849.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 19, 2022 at 10:50:48AM -0400, Josef Bacik wrote:
> These call functions that aren't defined in, or will be moved out of,
> ctree.h  Move them to super.c where the other assert/error message code
> is defined.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ctree.h | 18 +++---------------
>  fs/btrfs/super.c | 14 ++++++++++++++
>  2 files changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 52987ee61c72..c97a02a81517 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3320,18 +3320,11 @@ do {								\
>  } while (0)
>  
>  #ifdef CONFIG_BTRFS_ASSERT
> -__cold __noreturn

I think __noreturn should be preserved as BUG() is called in the new
function too

> -static inline void assertfail(const char *expr, const char *file, int line)
> -{
> -	pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
> -	BUG();
> -}

> +void __cold btrfs_assertfail(const char *expr, const char *file, int line)
> +{
> +	pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
> +	BUG();
> +}
