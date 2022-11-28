Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350E063AE6D
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 18:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiK1RHM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 12:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiK1RGv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 12:06:51 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CB5275C9
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 09:06:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A5E721888;
        Mon, 28 Nov 2022 17:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669655180;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Ize+itFkEQW4m0d0og2AdYvIpRLdYoZSzvkhzPYCHM=;
        b=UaVHU5aLiuGf2i0OTWO9xWha+bHVJcX6qSwVQoPxbvMNrfD0rG7EnE4rAZaRPPGfQOeIN5
        EQOjulp+pi4vb8ehYFfJSB/YddZep9SykdPgT+7r0DuuynX3roOYUlNrNnJxnsYnuupfuA
        q6HNYvbUhCD4RqqHxbazDFCPhqecE8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669655180;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Ize+itFkEQW4m0d0og2AdYvIpRLdYoZSzvkhzPYCHM=;
        b=/UmpQ/qMoW1xaVWvg0+puK4k5GDGs6qOHd1k1leiKa+lvTIy0GiWROSdzaEYKLzmtteFCL
        GNoSZQO5cOluDKBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1993C1326E;
        Mon, 28 Nov 2022 17:06:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qRdFBYzqhGPleQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 28 Nov 2022 17:06:20 +0000
Date:   Mon, 28 Nov 2022 18:05:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: initialize backref cache earlier
Message-ID: <20221128170546.GR5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <25b5197a1d0b81c12acdb79ac0f6d82df287c3c7.1669630263.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25b5197a1d0b81c12acdb79ac0f6d82df287c3c7.1669630263.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 28, 2022 at 10:12:13AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we successfully allocated the send context object but ran into an error
> after it and before initializing the backref cache, then under the 'out'
> label we'll end up calling empty_backref_cache(), which will iterate over
> a the backref cache's lru list which was not initialized, triggering
> invalid memory accesses.
> 
> Fix this by initializing the backref cache immediately after a successful
> allocation of the send context.
> 
> This fixes a recent patch not yet in Linus' tree, only in misc-next and
> linux-next, which has the subject:
> 
>   "btrfs: send: cache leaf to roots mapping during backref walking"

Folded to the patch, thanks.
