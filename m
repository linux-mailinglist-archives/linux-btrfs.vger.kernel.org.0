Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA1E69853C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 21:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjBOUIH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 15:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBOUIE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 15:08:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD1E3A86A
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 12:08:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7C5C51F8C2;
        Wed, 15 Feb 2023 20:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676491682;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sdr+Y2AFCMLOFIyx1LtZpfFXcKSOdIXhBcLB11YeFMA=;
        b=uTg23Np/HfFZlQ8jl8Tl2oCkPjfDm8bHvnL3b+rD+ZX9d1B+HleJUUiqgyrgMkQo5OPSgZ
        FCsbTTiyXcamTNVg80+wGOD980i1cxczXCPRUBptRwBodJ25NDqqjql/+CqGgE0j4yhynB
        ztvc8oPajANifGtf8Ifwfv/714P7EZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676491682;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sdr+Y2AFCMLOFIyx1LtZpfFXcKSOdIXhBcLB11YeFMA=;
        b=FY4NHa2eLYPxDViFMEvpRN6ny+G73K156ak6YZss9BJBtlL2+Muomk1VkQoXdJTscU+j57
        IHUoI2KdFMGUQ1AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A9F5134BA;
        Wed, 15 Feb 2023 20:08:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wRFVFKI77WNyFwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 15 Feb 2023 20:08:02 +0000
Date:   Wed, 15 Feb 2023 21:02:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/4] btrfs: small improvement for btrfs_io_context
 structure
Message-ID: <20230215200209.GV28288@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1675743217.git.wqu@suse.com>
 <63c3c509ec42d83e8038b33e2f21e036c591fe0b.1675743217.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63c3c509ec42d83e8038b33e2f21e036c591fe0b.1675743217.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 07, 2023 at 12:26:13PM +0800, Qu Wenruo wrote:
> That structure is our ultimate objective for all __btrfs_map_block()
> related functions.
> 
> We have some hard to understand members, like tgtdev_map, but without
> any comments.
> 
> This patch will improve the situation by:
> 
> - Add extra comments for num_stripes, mirror_num, num_tgtdevs and
>   tgtdev_map[]
>   Especially for the last two members, add a dedicated (thus very long)
>   comments for them, with example to explain it.
> 
> - Shrink those int members to u16.
>   In fact our on-disk format is only using u16 for num_stripes, thus
>   no need to go int at all.

Note that u16 is maybe good for space saving in structures but otherwise
it's a type that's a bit clumsy for CPU to handle. Int for passing it
around does not require masking or other sorts of conversions when
there's arithmetic done. This can be cleaned up later with close
inspection of the effects, so far we have u16 for fs_info::csum_type or
some item lengths.
