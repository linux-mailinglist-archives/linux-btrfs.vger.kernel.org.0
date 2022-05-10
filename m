Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DB7521447
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 13:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbiEJL5U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 07:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiEJL5L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 07:57:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AC427B33C
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 04:53:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 07B0A21B5E;
        Tue, 10 May 2022 11:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652183593;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d2BxK27J1Xbi50S64YsAUXLU53IXZoHb3gW/l8swHw0=;
        b=WsNnWR/hCA/rVbg67kUV91ytacCdhpjFFGrm8fBipj8jdCXs7HlYvjGg0Luy9jiZtGtLYy
        1Ih0rSNEFZq+sXtKnB7FokEMRZbQEtQ5qQdZXzKlEKk3jhDOj4fauJI2zEJZi5IJq+DTaL
        J7fH77TiJHdAcQI82xLMjMhAS+7IsO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652183593;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d2BxK27J1Xbi50S64YsAUXLU53IXZoHb3gW/l8swHw0=;
        b=HI64PRewYc1Bg7BJvuUgAbYFvp56NQjqtOvXJHiFiAlga6DNGXVXc+AG6u2tVNIz0BZKma
        /lldPOfKAU6/YqBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8C0F13AA5;
        Tue, 10 May 2022 11:53:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gKLpLyhSemK8dgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 10 May 2022 11:53:12 +0000
Date:   Tue, 10 May 2022 13:48:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: print-tree: print the checksum of header
 without tailing zeros
Message-ID: <20220510114858.GL18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <38bf1bf79e8443d570e982edb8a6b71f27cf1ab5.1652162441.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38bf1bf79e8443d570e982edb8a6b71f27cf1ab5.1652162441.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 10, 2022 at 02:03:18PM +0800, Qu Wenruo wrote:
> For the default CRC32 checksum, print-tree now prints tons of
> unnecessary padding zeros:
> 
>   btrfs-progs v5.17
>   chunk tree
>   leaf 22036480 items 7 free space 15430 generation 6 owner CHUNK_TREE
>   leaf 22036480 flags 0x1(WRITTEN) backref revision 1
>   checksum stored 0ac1b9fa00000000000000000000000000000000000000000000000000000000
>   checksum calced 0ac1b9fa00000000000000000000000000000000000000000000000000000000
>   fs uuid 3d95b7e3-3ab6-4927-af56-c58aa634342e
> 
> This is caused by commit 1bb6fb896dfc ("btrfs-progs: btrfstune:
> experimental, new option to switch csums"), and it looks like most
> distros just enable EXPERIMENTAL features by default.

Which distros?

> (Which is a good thing to provide much better coverage).

Well, this depends if the experimental features are used as such. I'll
add a warning in case they get actually used.

> So here we just limit the csum print to the utilized csum size.
> 
> Now the output looks like:
> 
>   btrfs-progs v5.17
>   chunk tree
>   leaf 22036480 items 4 free space 15781 generation 6 owner CHUNK_TREE
>   leaf 22036480 flags 0x1(WRITTEN) backref revision 1
>   checksum stored 676b812f
>   checksum calced 676b812f
>   fs uuid d11f8799-b6dc-415d-b1ed-cebe6da5f0b7
> 
> Fixes: 1bb6fb896dfc ("btrfs-progs: btrfstune: experimental, new option to switch csums")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
