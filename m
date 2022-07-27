Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52645833D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 21:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiG0TtC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 15:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiG0TtB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 15:49:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79ED52DF4
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 12:48:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 627C43EF79;
        Wed, 27 Jul 2022 19:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658951338;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pCjd817TMiI9mvBMN7hmYkYv3lWSbhMvhH1/pSvtLp8=;
        b=qKHC6Z59u65VtQWPqGChz/UCvy3Avo9u8uJ2ruzU0cBLuqYr5DCY841FIw9gEyABe6h8kE
        ecaEq7C5P/SuEYWEWvt8NjOrJswTUDgLrjWvY2KJQ32Y0/1D5qcjbXQJDdYFt/n68Oi43a
        IJ2PUPCHhZdErzbOErTwLj6iTEXGqRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658951338;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pCjd817TMiI9mvBMN7hmYkYv3lWSbhMvhH1/pSvtLp8=;
        b=RWvCa2XeJ4HQx3fiX2rVMRDiQTfgMq/q19rfWDao89BbqxbwBb1yS4P+c1db3Bw/dsR+Mj
        vvZA/VQ+D9Wx4xBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 424FA13A8E;
        Wed, 27 Jul 2022 19:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wEgaD6qW4WItUAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 27 Jul 2022 19:48:58 +0000
Date:   Wed, 27 Jul 2022 21:44:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: misc-next/for-next: bad key order during log replay
Message-ID: <20220727194400.GZ13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <Yt2kU0CEkX5DRFhN@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt2kU0CEkX5DRFhN@hungrycats.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 24, 2022 at 03:58:11PM -0400, Zygo Blaxell wrote:
> Test case is running all of these at the same time in a loop:
> 
> 	- rename log tree test from
> 	https://lore.kernel.org/linux-btrfs/YdDsAl0bx6DLZT+i@hungrycats.org/
> 
> 	- continuous metadata balances to keep delayed ref queue full
> 
> 	- 20x rsync writing to the filesystem to keep the page cache full
> 
> 	- crash the VM after 30 minutes uptime

Thanks for the detailed report, this should be fixed by
https://lore.kernel.org/linux-btrfs/2afa2744e3ea3a2290ab683cac51907ef10f8582.1658332827.git.josef@toxicpanda.com/

and it's been added to misc-next a few days ago. It's a separate patch
not merged with the one that possibly caused it.
