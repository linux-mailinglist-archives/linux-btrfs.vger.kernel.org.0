Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686A95B36A4
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 13:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiIILpX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 07:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiIILpV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 07:45:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48755F2945
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 04:45:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 02A371F8DB;
        Fri,  9 Sep 2022 11:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662723919;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pGt10ik7/KHe5d6iZQ2EBkdqv1tGOrpHh9/Ce53lk1k=;
        b=vw01fwixq8+up4bj/VZJV47QPrdvOmMKCiAj8ndfojiA9v/3nmyNKYKJdApDOGB1yVoB49
        JuA1M7/eWzcfwhmMgVWKuZGU/Mm8Cycd7Ltjgq11TNvltBU9iYrkExguKI0xRgpKWtl0Fk
        zaz0vQPgnKANOQg1Fsf76tJ0dkbgIQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662723919;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pGt10ik7/KHe5d6iZQ2EBkdqv1tGOrpHh9/Ce53lk1k=;
        b=wvd8WF5gAi/7S7r3qvBYwlOujnEXdwhK4VaRbE57seUbm5UpVkdQ8hL2YU5oNgcFfdL7Hm
        UMltR9WvyCamJpCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA64D13A93;
        Fri,  9 Sep 2022 11:45:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wfl1ME4nG2NnGQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 09 Sep 2022 11:45:18 +0000
Date:   Fri, 9 Sep 2022 13:39:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/6] btrfs-progs: add fscrypt support to mkfs.
Message-ID: <20220909113954.GU32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1662417859.git.sweettea-kernel@dorminy.me>
 <1c087f585f2a82b295587ae37931714578cf2514.1662417859.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c087f585f2a82b295587ae37931714578cf2514.1662417859.git.sweettea-kernel@dorminy.me>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 05, 2022 at 08:01:02PM -0400, Sweet Tea Dorminy wrote:
> Add a new experimental option to allow use of encryption.
> 
> Arguably, since older kernels can technically read non-encrypted parts
> of an encrypted filesystem, perhaps this doesn't need to be an incompat
> feature.
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
>  common/fsfeatures.c   | 10 ++++++++++
>  kernel-shared/ctree.h |  4 +++-
>  libbtrfsutil/btrfs.h  |  2 ++
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 90704959..ea185a3c 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -143,6 +143,16 @@ static const struct btrfs_feature mkfs_features[] = {
>  		.desc		= "new extent tree format"
>  	},
>  #endif
> +	{
> +		.name		= "encrypt",

I'd like to call it fscrypt so it's clear what implementation it's
using.

> +		.flag		= BTRFS_FEATURE_INCOMPAT_FSCRYPT,
> +		.sysfs_name	= "fscrypt",
> +		VERSION_TO_STRING2(compat, 5,19),

The version will be at least 6.2

> +		VERSION_NULL(safe),
> +		VERSION_NULL(default),
> +		.desc		= "fs-level encryption"

That's too terse, please write something like "filesystem encryption
using fscrypt"
