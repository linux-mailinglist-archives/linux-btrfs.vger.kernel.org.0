Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA2C572727
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jul 2022 22:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbiGLUYR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jul 2022 16:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiGLUYM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jul 2022 16:24:12 -0400
X-Greylist: delayed 277 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Jul 2022 13:24:11 PDT
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77C0A852E
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 13:24:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 988C21F94E;
        Tue, 12 Jul 2022 20:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657657450;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BFNBlfS/GCL6Rk1DB/4QGi/Yr0gBRyM5N5AGan2xfBI=;
        b=uzdmqU38W8tN9dhqy2cMWOoYuNQfvDGY44fagep9+WpTxsJWFFlW4NQuEcFv/3dH1Pdos5
        anD4QOSkm1XiwxaiE6N17bAMu9W5/vGWEg2esfC0mLGu4XMk84XfrGlWj8YBK/QuOYHfdb
        DjQlerfAoayzJN+1LIFPKYilNh5QeMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657657450;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BFNBlfS/GCL6Rk1DB/4QGi/Yr0gBRyM5N5AGan2xfBI=;
        b=th+dW+pkOcfleVJMbxKoZMRJ6sW1yyRKNiP7r+3QpzNQGCzc5JNqtWa3Jf8CQ5Qg7grxxG
        I09VVnZE+AZt6CBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6532913A94;
        Tue, 12 Jul 2022 20:24:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /UyqF2rYzWJeWgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 12 Jul 2022 20:24:10 +0000
Date:   Tue, 12 Jul 2022 22:19:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, bingjingc@synology.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: send: always use the rbtree based inode ref
 management infrastructure
Message-ID: <20220712201920.GD15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org, bingjingc@synology.com,
        Filipe Manana <fdmanana@suse.com>
References: <7ceaa34df153e9aada0a093407542fa81355c83c.1657637387.git.fdmanana@suse.com>
 <4b2af2eb7790ca710edeb123e449b9c1595c7210.1657639757.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b2af2eb7790ca710edeb123e449b9c1595c7210.1657639757.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 12, 2022 at 04:31:22PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> After the patch "btrfs: send: fix sending link commands for existing file
> paths", we now have two infrastructures to detect and eliminate duplicated
> inode references (due to names that got removed and re-added between the
> send and parent snapshots):
> 
> 1) One that works on a single inode ref/extref item;
> 
> 2) A new one that works acrosss all ref/extref items for an inode, and
>    it's also more efficient because even in the single ref/extref item
>    case, it does not do a linear search for all the names encoded in the
>    ref/extref item, it uses red black trees to speedup up the search.
> 
> There's no good reason to keep both infrastructures, we can use the new
> one everywhere, and it's always more efficient.
> 
> So remove the old infrastructure and change all sites that are using it
> to use the new one.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Also remove the no longer used definition of struct find_ref_ctx.
> 
> This applies on top of the patchset at:
> 
> https://lore.kernel.org/linux-btrfs/20220712013632.7042-1-bingjingc@synology.com/

Added to misc-next, thanks, with minor fixups after changes I made to
the patches above.
