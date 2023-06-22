Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5141473A379
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 16:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjFVOpf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jun 2023 10:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbjFVOpC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jun 2023 10:45:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BEA26AB
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 07:44:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 54CAC1F388;
        Thu, 22 Jun 2023 14:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687445035;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wq1dfnUZcvesCaUTDmmx38VjWKNT7xa4EIXhleBwrAI=;
        b=dPKtAKRzILn5m1abzXqAQXNaVMCnDd16V8Rd0ij2nB8U1GZYCpchmLv0aMDDq03r0OjsEi
        Ofv8FpG33HgPpv8NMHxoORRRzcthj2UpCd2Kr3zFc21H2VmlOZ43sZ7TFBz7LN0XZDQtuc
        Fko3MmOX6dYZ8ooKWCapff1fKRiU1jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687445035;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wq1dfnUZcvesCaUTDmmx38VjWKNT7xa4EIXhleBwrAI=;
        b=nyzHsWujqoY5GdERxNOtENePkHpYdV4GADq/845rKBLro6eGoeOZDX5RxNclDmNJwhJZUT
        yZdGqEAk6TpM9KBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DCE013905;
        Thu, 22 Jun 2023 14:43:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fl/YCStelGQUIQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 22 Jun 2023 14:43:55 +0000
Date:   Thu, 22 Jun 2023 16:37:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use a dedicated helper to convert stripe_nr to
 offset
Message-ID: <20230622143730.GU16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <10aca1661eee22e6a74ecab62a48227b51284ece.1687416153.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10aca1661eee22e6a74ecab62a48227b51284ece.1687416153.git.wqu@suse.com>
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

The subject should be clear that it's fixing a bug not a cleanup.

On Thu, Jun 22, 2023 at 02:42:40PM +0800, Qu Wenruo wrote:
> [BACKGROUND]
> We already had a nasty regression introduced by commit a97699d1d610
> ("btrfs: replace map_lookup->stripe_len by BTRFS_STRIPE_LEN"), which is
> doing a u32 left shift and can cause overflow.
> 
> Later we have an incomplete fix, a7299a18a179 ("btrfs: fix u32 overflows
> when left shifting @stripe_nr"), which fixes 5 call sites, but with one
> missing call site (*) still not caught until a proper regression test is
> crafted.
> 
> *: The assignment on bioc->full_stripe_logical inside btrfs_map_block()
> 
> [FIX]
> To end the whack-a-mole game, this patch will introduce a helper,
> btrfs_stripe_nr_to_offset(), to do the u32 left shift with proper type
> cast to u64 to avoid overflow.
> 
> This would replace all "<< BTRFS_STRIPE_LEN_SHIFT" calls, and solve the
> problem permanently.
> 
> Fixes: a97699d1d610 ("btrfs: replace map_lookup->stripe_len by BTRFS_STRIPE_LEN")
> Fixes: a7299a18a179 ("btrfs: fix u32 overflows when left shifting stripe_nr")

The patch was expected to be based on commit a7299a18a179 as it's meant
to go to current master branch, and it does not apply cleanly. I will
resolve it, a few hunks get dropped and no other places need to be
converted but please try to make it smooth when we're getting last
minute urgent fixes.
