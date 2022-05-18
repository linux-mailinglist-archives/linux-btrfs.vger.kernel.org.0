Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA8352B900
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 13:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbiERLnx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 07:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbiERLnw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 07:43:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2821790A5
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 04:43:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 641141F37F;
        Wed, 18 May 2022 11:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652874229;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SJ1kb6+XQvergfUOeYgapNxAmLQbqVgYdJavLCZrpi4=;
        b=Bf/4n2U8xzLKHVpgUs9Vis8LYok76NUOFFuvWo26cFMGWci65eBq8s3w1LtvN0Q+DM7NnM
        8FQK2rv+5Q0uw5zK/RWMx+Chg8flewKSvvpsFN3CxsN722L0cFohUBrKLlr2CnJnbo02m0
        KbBxnkt4S/d3q0uLz3yrTLNpnAFPwwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652874229;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SJ1kb6+XQvergfUOeYgapNxAmLQbqVgYdJavLCZrpi4=;
        b=7SMGTWCPVwK1nlEv3u/AHA5FR4GnSCJlC1BAVjWG9DDHcEL2eHIa9gq3/diD6e+82nigKl
        GP6L+FxeL0T5NACA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4325213A6D;
        Wed, 18 May 2022 11:43:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cPnxDvXbhGJuVwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 18 May 2022 11:43:49 +0000
Date:   Wed, 18 May 2022 13:39:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: doc: add more explanation on subapge limits
Message-ID: <20220518113930.GJ18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <6c11754df4341351769a0da4eaac8939aa82b700.1652852267.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c11754df4341351769a0da4eaac8939aa82b700.1652852267.git.wqu@suse.com>
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

On Wed, May 18, 2022 at 01:37:50PM +0800, Qu Wenruo wrote:
> The current subpage support in v5.18 has several limits, the most
> obvious ones are:
> 
> - Only support 64KiB page size
> - No RAID56 support
> 
> The supports are already queued for v5.19.
> 
> And some minor ones:
> 
> - No inline extent write support
>   Read is always supported.
>   Subpage mount will always just act as "max_inline=0".
> 
> - Compression write is only for page aligned range.
>   Read is always supported, no matter the alignment.
> 
> - Extra memory usage for scrub
>   Patchset is hanging there for a while though.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thank you, added to devel.
