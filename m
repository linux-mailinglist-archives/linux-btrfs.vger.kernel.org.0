Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A09774F994
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jul 2023 23:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjGKVIf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jul 2023 17:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjGKVIe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 17:08:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAA210F2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 14:08:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0137C1FF0B;
        Tue, 11 Jul 2023 21:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689109709;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wVHXtPEigqUshvJY6k1jHydBPkObLeeFyWYkDxGWZSw=;
        b=Jq3Av9ai0FhP2hDRzxzd7a8kIVNbO5gudBt1wkRxHqUHIyAUxq+sQjaVlb5CKuZlr8PcH4
        mypuA24mCx5ykjzA75P32q0lvH1JivelGpQDmRmCirCBZgyhSPWwVSnAUiPps5Z0axxALg
        nMBFSPbZ9Ufeqri5ieK2gyZWEKd9ch0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689109709;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wVHXtPEigqUshvJY6k1jHydBPkObLeeFyWYkDxGWZSw=;
        b=+YRkyG3wsN8di+jg1rie/DMgpNfnBPZPyFkKoPZ0kYKVrU4DF85DDXCS8NyN0nm5e+YwQ/
        BwkXW9rrP+DowkDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D20C11391C;
        Tue, 11 Jul 2023 21:08:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 80xuMszErWR9MQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 11 Jul 2023 21:08:28 +0000
Date:   Tue, 11 Jul 2023 23:01:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
Subject: Re: [PATCH] btrfs: speedup scrub csum verification
Message-ID: <20230711210153.GG30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6c1ffe48e93fee9aa975ecc22dc2e7a1f3d7a0de.1688539673.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c1ffe48e93fee9aa975ecc22dc2e7a1f3d7a0de.1688539673.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 02:48:48PM +0800, Qu Wenruo wrote:
> [REGRESSION]
> There is a report about scrub is much slower on v6.4 kernel on fast NVME
> devices.
> 
> The system has a NVME device which can reach over 3GBytes/s, but scrub
> speed is below 1GBytes/s.
> 
> [CAUSE]
> Since commit e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to
> scrub_stripe infrastructure") scrub goes a completely new
> implementation.
> 
> There is a behavior change, where previously scrub is doing csum
> verification in one-thread-per-block way, but the new code goes
> one-thread-per-stripe way.
> 
> This means for the worst case, new code would only have one thread
> verifying a whole 64K stripe filled with data.
> 
> While the old code is doing 16 threads to handle the same stripe.
> 
> Considering the reporter's CPU can only do CRC32C at around 2GBytes/s,
> while the NVME drive can do 3GBytes/s, the difference can be big:
> 
> 	1 thread:	1 / ( 1 / 3 + 1 / 2)     = 1.2 Gbytes/s
> 	8 threads: 	1 / ( 1 / 3 + 1 / 8 / 2) = 2.5 Gbytes/s
> 
> [FIX]
> To fix the performance regression, this patch would introduce
> multi-thread csum verification by:
> 
> - Introduce a new workqueue for scrub csum verification
>   The new workqueue is needed as we can not queue the same csum work
>   into the main scrub worker, where we are waiting for the csum work
>   to finish.
>   Or this can lead to dead lock if there is no more worker allocated.
> 
> - Add extra members to scrub_sector_verification
>   This allows a work to be queued for the specific sector.
>   Although this means we will have 20 bytes overhead per sector.
> 
> - Queue sector verification work into scrub_csum_worker
>   This allows multiple threads to handle the csum verification workload.
> 
> - Do not reset stripe->sectors during scrub_find_fill_first_stripe()
>   Since sectors now contain extra info, we should not touch those
>   members.
> 
> Reported-by: Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
> Link: https://lore.kernel.org/linux-btrfs/CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com/
> Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
