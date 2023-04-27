Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955BC6F0F04
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 01:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344165AbjD0XdX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 19:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjD0XdW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 19:33:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1624524F;
        Thu, 27 Apr 2023 16:32:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3C52E1FEFA;
        Thu, 27 Apr 2023 23:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682638366;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vlp/Rv+SFv3x38FVekbx/u55bHGOziVKYfn31F1U83g=;
        b=Oc6gNs8DyFaEKSt5TixDG+EcWCZtI+JoHC98gWHktdYcvL3gPM3k9puDoW9Ww9lTYgfUvU
        0tzJW25tLFHTNAc8hBAU6cNs6lc1WwTQE7HFrIH3FSB2aHZPmRW7ONcKhczl1C87HRXUoJ
        yWBNxbNVe08rb0m5Tn6LIzBaj6d41qU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682638366;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vlp/Rv+SFv3x38FVekbx/u55bHGOziVKYfn31F1U83g=;
        b=Aji2uaydvXAV+Y6+o9iMrP2oIEz0vmaDg8RoQwsc6mOVNGsiOXm9kmy6x60Q4HGa7En/zd
        r9fvdLw+PuqzF4Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0512913910;
        Thu, 27 Apr 2023 23:32:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x05TAB4GS2StEAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 27 Apr 2023 23:32:46 +0000
Date:   Fri, 28 Apr 2023 01:32:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: properly reject clear_cache and v1 cache for
 block-group-tree
Message-ID: <20230427233229.GK19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <832315ce8d970a393a2948e4cc21690a1d9e1cac.1682559926.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <832315ce8d970a393a2948e4cc21690a1d9e1cac.1682559926.git.wqu@suse.com>
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

On Thu, Apr 27, 2023 at 09:45:32AM +0800, Qu Wenruo wrote:
> [BUG]
> With block-group-tree feature enabled, mounting it with clear_cache
> would cause the following transaction abort at mount or remount:
> 
>  BTRFS info (device dm-4): force clearing of disk cache
>  BTRFS info (device dm-4): using free space tree
>  BTRFS info (device dm-4): auto enabling async discard
>  BTRFS info (device dm-4): clearing free space tree
>  BTRFS info (device dm-4): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
>  BTRFS info (device dm-4): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
>  BTRFS error (device dm-4): block-group-tree feature requires fres-space-tree and no-holes
>  BTRFS error (device dm-4): super block corruption detected before writing it to disk
>  BTRFS: error (device dm-4) in write_all_supers:4288: errno=-117 Filesystem corrupted (unexpected superblock corruption detected)
>  BTRFS warning (device dm-4: state E): Skipping commit of aborted transaction.
> 
> [CAUSE]
> For block-group-tree feature, we have an artificial dependency on
> free-space-tree.
> 
> This means if we detects block-group-tree without v2 cache, we consider
> it a corruption and cause the problem.
> 
> For clear_cache mount option, it would temporary disable v2 cache, then
> re-enable it.
> 
> But unfortunately for that temporary v2 cache disabled status, we refuse
> to write a superblock with bg tree only flag, thus leads to the above
> transaction abortion.
> 
> [FIX]
> For now, just reject clear_cache and v1 cache mount option for block
> group tree.
> So now we got a graceful rejection other than a transaction abort:
> 
>  BTRFS info (device dm-4): force clearing of disk cache
>  BTRFS error (device dm-4): cannot disable free space tree with block-group-tree feature
>  BTRFS error (device dm-4): open_ctree failed
> 
> Cc: stable@vger.kernel.org # 6.1+
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> For the proper fix, we need to change the behavior of clear_cache and v1
> cache switch.
> 
> For pure clear_cache without switch cache version, we should allow
> rebuilding v2 cache without fully disable v2 cache.

There was an issue to clarify docs about the space caches and it's a
mess, once we had v2 the number of states has increased and it's
becoming user unfriendly. At least we have the block-group-tree and
free-space-tree tied together and this should be the focus of the
feature compatibility.

I think it should be acceptable to slightly change the behaviour for
some obscure combination v1/v2/clear/bgt and either reject some of them
or suggest more than one step how to do it. E.g. first fully convert
from v1 to v2 and then to bgt, or allow v2/bgt/clear in one go.

Added to misc-next, thanks.
