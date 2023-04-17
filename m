Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F5E6E4F9F
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Apr 2023 19:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjDQRtu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 13:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDQRtn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 13:49:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947F0C3
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 10:49:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4792A219C0;
        Mon, 17 Apr 2023 17:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681753781;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=09S0GbnOgGgFoeDP6wMb4ucoJH8Dyu5I8OXkkwqv5Ew=;
        b=eh00YT4acYS8Hwx7+2qH2oVi2tWm2q96S+yRjaEuA1tVYI9W8FU2L/MoIFIUKu4nrbqi9w
        vgXrjNd+FxenuzN6eullMSv+eMpLGfQFAd0D4JG10lgI6Q6RyOcCDqQ+i5QvYmEMmtB0Rr
        PeNUDXexLzj5y2UeYz3qR5Mx/HcSwmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681753781;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=09S0GbnOgGgFoeDP6wMb4ucoJH8Dyu5I8OXkkwqv5Ew=;
        b=CZqhBzhMCj65zPrgsUerlZTeBSJILnbEsduZs0Ls2iGKwirOCH1T3pkccJXmQ28X3izFFA
        zmnBjGKJDlwLP0Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D34D1390E;
        Mon, 17 Apr 2023 17:49:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 85owCrWGPWQHfwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 17 Apr 2023 17:49:41 +0000
Date:   Mon, 17 Apr 2023 19:49:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove unused raid56 functions which were
 dedicated for scrub
Message-ID: <20230417174932.GK19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <db16bb361ef4fb39c71c236dd3985ed88b85ecd0.1681282065.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db16bb361ef4fb39c71c236dd3985ed88b85ecd0.1681282065.git.wqu@suse.com>
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

On Wed, Apr 12, 2023 at 02:47:50PM +0800, Qu Wenruo wrote:
> Since the scrub rework, the following raid56 functions are no longer
> called:
> 
> - raid56_add_scrub_pages()
> - raid56_alloc_missing_rbio()
> - raid56_submit_missing_rbio()
> 
> Those functions are all utilized by scrub to handle missing device cases
> for RAID56.
> 
> However the new scrub code handle them in a completely different method:
> 
> - If it's data stripes, go recovery path through btrfs_submit_bio()
> - If it's P/Q stripes, it would be handled through
>   raid56_parity_submit_scrub_rbio()
>   And that function would handle dev-replace and repair properly.
> 
> Thus we can safely remove those functions.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to the rest of the scrub rework patches, thanks.
