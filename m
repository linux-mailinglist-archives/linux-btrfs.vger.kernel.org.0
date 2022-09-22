Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADADA5E681A
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 18:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiIVQJr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Sep 2022 12:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiIVQJp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Sep 2022 12:09:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313091C914
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 09:09:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CA04E1F920;
        Thu, 22 Sep 2022 16:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663862982;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sx7vmkHmPIkgCCfhhYQyfRXPNsxzn8m5qeUNxRTjvns=;
        b=fl+676mK05bE4+8lRve2sPv5s/qSLYEfKnDXiDacPuYC2o8xX4BCb5bVscPgYZO3xH7+ba
        f3T04u7xOzfFzXGsFRmCFtpJ+HC60miAg0nX7vSr0+aU56s2xdJHyDSxnBBEZAc+2y1j3O
        1ejtCNz4X+FhDiqyAb2YgQMTmhzCGLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663862982;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sx7vmkHmPIkgCCfhhYQyfRXPNsxzn8m5qeUNxRTjvns=;
        b=ib44gmmOgJoqqY3FJT3Lb4SCT357x8wDeO7rfDBTHDfOSfRfghZxcMaztzDFI1l8NR5nVN
        R+a2CG4bLMnbrSCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A60BC13AA5;
        Thu, 22 Sep 2022 16:09:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1NvCJ8aILGNmQQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 22 Sep 2022 16:09:42 +0000
Date:   Thu, 22 Sep 2022 18:04:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 10/13] btrfs: remove unnecessary NULL pointer checks when
 searching extent maps
Message-ID: <20220922160410.GL32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663594828.git.fdmanana@suse.com>
 <28c638167c79d62903a2bfb411f63170aa90de5f.1663594828.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28c638167c79d62903a2bfb411f63170aa90de5f.1663594828.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 19, 2022 at 03:06:37PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The previous and next pointer arguments passed to __tree_search() are
> never NULL as the only caller of this function, __lookup_extent_mapping(),
> always passes the address of two on stack pointers. So remove the NULL
> checks.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/extent_map.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index f1616aa8d0f5..12538ff04525 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -163,24 +163,21 @@ static struct rb_node *__tree_search(struct rb_root *root, u64 offset,
>  			return n;
>  	}

I've added asserts to verify the pointers are not accidentaly NULL.
