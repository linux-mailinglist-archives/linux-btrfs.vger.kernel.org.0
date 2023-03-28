Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89836CCDA9
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 00:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjC1Wsd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 18:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjC1Wsc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 18:48:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BA9B6
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 15:48:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2FE92219F1;
        Tue, 28 Mar 2023 22:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680043710;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9FRh69JKxKK06tlSHfhyTfsrmgNGQ/ef/Pw7FUHJT78=;
        b=kLMtgAi8MR3KK9cjVWQkIHfaWb7B77FFVOMw0rQ7PIcN4rB0KmDbQPpC6jHfunKL5MJmh3
        LnanzQp4krjKHOiIqdKGcS8NFb8amZZJ19CSFVZQ4DyKAYpxj0Nrnbzm6hbJDzjafHYhyZ
        Xaa018JGY1fPad8sv2BKTR3PMJo11pk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680043710;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9FRh69JKxKK06tlSHfhyTfsrmgNGQ/ef/Pw7FUHJT78=;
        b=YkV55HZ70vJSOpcIu801ObqpbjlfNE4xC7jOtScNTiEX3hF18DzKEq0lVUhpx25T3D3egY
        woeFjr0AaZsLU+Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A5E61390B;
        Tue, 28 Mar 2023 22:48:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BGS4Ab5uI2QMYAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 28 Mar 2023 22:48:30 +0000
Date:   Wed, 29 Mar 2023 00:42:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: ignore fiemap path cache when there are multiple
 paths for a node
Message-ID: <20230328224215.GQ10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0322b6ece3502da4d8243882c9658c9cfbb22a28.1679996288.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0322b6ece3502da4d8243882c9658c9cfbb22a28.1679996288.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 28, 2023 at 10:45:20AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During fiemap, when walking backreferences to determine if a b+tree
> node/leaf is shared, we may find a tree block (leaf or node) for which
> two parents were added to the references ulist. This happens if we get
> for example one direct ref (shared tree block ref) and one indirect ref
> (non-shared tree block ref) for the tree block at the current level,
> which can happen during relocation.
> 
> In that case the fiemap path cache can not be used since it's meant for
> a single path, with one tree block at each possible level, so having
> multiple references for a tree block at any level may result in getting
> the level counter exceed BTRFS_MAX_LEVEL and eventually trigger the
> warning:
> 
>    WARN_ON_ONCE(level >= BTRFS_MAX_LEVEL)
> 
> at lookup_backref_shared_cache() and at store_backref_shared_cache().
> This is harmless since the code ignores any level >= BTRFS_MAX_LEVEL, the
> warning is there just to catch any unexpected case like the one described
> above. However if a user finds this it may be scary and get reported.
> 
> So just ignore the path cache once we find a tree block for which there
> are more than one reference, which is the less common case, and update
> the cache with the sharedness check result for all levels below the level
> for which we found multiple references.
> 
> Reported-by: Jarno Pelkonen <jarno.pelkonen@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CAKv8qLmDNAGJGCtsevxx_VZ_YOvvs1L83iEJkTgyA4joJertng@mail.gmail.com/
> Fixes: 12a824dc67a6 ("btrfs: speedup checking for extent sharedness during fiemap")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
