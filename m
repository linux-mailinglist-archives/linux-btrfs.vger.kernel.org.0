Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AE275AC99
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 13:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjGTLLX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 07:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjGTLLW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 07:11:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23EC268F;
        Thu, 20 Jul 2023 04:11:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A3405206B7;
        Thu, 20 Jul 2023 11:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689851479;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0kyCPYIuNcoxBYURlB9p29wj+CqprZvqzi2vSmZLS2s=;
        b=B2t0oJCRVOlabAC2kjJPVRg3wXr3+ncqmZ5GyQehvb7c1o3NrvtRSG7cNFiZ2HdL3QaexX
        7QjUYBJpBF0dhp+iHODPeH8k3ZEXwbGr4wALNbDqexQvdTcUIX7t8ZVPwvIcBGIuDqVEUL
        Iqh6MCAWwY3aJzV8r0bJ0YRMVsly1co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689851479;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0kyCPYIuNcoxBYURlB9p29wj+CqprZvqzi2vSmZLS2s=;
        b=zggSSTpXeJUGaWwN78N3QSFipV98u6ki1zNmJ06y6PGi7so4v8XgRBoVoqN8umTMSxK18X
        THIRnt3mCuFxcnAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BB8E133DD;
        Thu, 20 Jul 2023 11:11:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o50kFVcWuWShfQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 20 Jul 2023 11:11:19 +0000
Date:   Thu, 20 Jul 2023 13:04:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: turn unpin_extent_cache() into a void function
Message-ID: <20230720110438.GU20457@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230718173906.12568-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230718173906.12568-1-lhenriques@suse.de>
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

On Tue, Jul 18, 2023 at 06:39:06PM +0100, Luís Henriques wrote:
> The value of the 'ret' variable is never changed in function
> unpin_extent_cache().  And since the only caller of this function doesn't
> check the return value, it can simply be turned into a void function.
> 
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>  fs/btrfs/extent_map.c | 7 ++-----
>  fs/btrfs/extent_map.h | 2 +-
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 0cdb3e86f29b..f99c458071a4 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -292,10 +292,9 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
>   * to the generation that actually added the file item to the inode so we know
>   * we need to sync this extent when we call fsync().
>   */
> -int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
> -		       u64 gen)
> +void unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
> +			u64 gen)
>  {
> -	int ret = 0;
>  	struct extent_map *em;
>  	bool prealloc = false;
>  
> @@ -327,8 +326,6 @@ int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
>  	free_extent_map(em);
>  out:
>  	write_unlock(&tree->lock);
> -	return ret;
> -
>  }

This function has unfortunatelly attracting attention to do a simple fix
to just return void, several have been aleary sent but none of them
fixes it properly. To the point I don't want to reply anymore.

https://lore.kernel.org/linux-btrfs/20180815124425.GM24025@twin.jikos.cz/
https://lore.kernel.org/linux-btrfs/20230530150359.GS575@twin.jikos.cz/
https://patchwork.kernel.org/project/linux-btrfs/patch/20190416055739.25771-1-wqu@suse.com/#22596309

"When switching a fuction to return void, please check the whole
callgraph for functions that do not properly handler errors and do
BUG_ON. You won't see errors passed from them so this gives the
impression no error handling is needed in the caller."
