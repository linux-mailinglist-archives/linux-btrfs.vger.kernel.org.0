Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594DF6E54C9
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 00:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDQWvj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 18:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDQWvi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 18:51:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FF51BF6
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 15:51:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0FC6621981;
        Mon, 17 Apr 2023 22:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681771896;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kJ51xuwTN48NZCcRAY7fFn/rfiYiOijpUFlchUd/rfI=;
        b=rXSk4PY5ILtMLh5WQ2H83Z0FQNE5YLIE+TbySqTsXSwuJXtXZGpk84L2pN8FGJZb1rrQpv
        cWmAZDHqm9KevSQAhXObKIhDhXuyDoqpRxWgA183O3Q73QXqttqeL1Wiyk1MqdsIo9Ld1X
        kF/x0tDKiCsIefVoOh1ZP2dEKLWoPRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681771896;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kJ51xuwTN48NZCcRAY7fFn/rfiYiOijpUFlchUd/rfI=;
        b=t7Qv1UchnVmsvgVRUE1drEBOhkwpU6ECzVkghVjbCsZb2vkMig1vqTvyEhe2M1BEh+biu6
        +Jn7dxds8WKj6dCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D97C113319;
        Mon, 17 Apr 2023 22:51:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6QZANHfNPWQVBwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 17 Apr 2023 22:51:35 +0000
Date:   Tue, 18 Apr 2023 00:51:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: reduce the duplicated reads during P/Q scrub
Message-ID: <20230417225127.GP19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1681364951.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1681364951.git.wqu@suse.com>
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

On Thu, Apr 13, 2023 at 01:57:16PM +0800, Qu Wenruo wrote:
> [PROBLEM]
> It's a known problem that btrfs scrub for RAID56 is pretty slow.
> 
> [CAUSE]
> One of the causes is that we read the same data stripes at least twice
> during P/Q stripes scrub.
> 
> This means, during a full fs scrub (one scrub process for each device),
> there will be quite some extra seeks just because of this.
> 
> [FIX]
> The truth is, scrub stripes have a much better view of the data stripes.
> As btrfs would firstly verify all data stripes, and only continue
> scrubing the P/Q stripes if all the data stripes is fine after needed
> repair.
> 
> So this means, as long as there is no new RMW writes into the RAID56
> block group, we can re-use the scrub cache for P/Q verification.
> 
> This patchset would fix it by:
> 
> - Ensure the RAID56 block groups are marked read-only for scrub
>   This is to avoid RMW in to the block group, or scrub cache is no
>   longer reliable.
> 
> - Introduce a new interface to pass cached pages to RAID56 cache
>   The only disadvantage is here we still need to do page copy, due to
>   the uncertain lifespan of an rbio.
> 
> Qu Wenruo (2):
>   btrfs: scrub: try harder to mark RAID56 block groups read-only
>   btrfs: scrub: use recovered data stripes as cache to avoid unnecessary
>     read

Added to misc-next, thanks. I'd like to batch it with the rest of the
scrub but we also need to let it test for a while it so it'll be part of
some rc.
