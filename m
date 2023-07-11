Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E3D74FBAF
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jul 2023 01:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjGKXEp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jul 2023 19:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjGKXEm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 19:04:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355281BCB
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 16:04:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CC4C121EA2;
        Tue, 11 Jul 2023 23:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689116667;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+dQO5vcnvpIOUOmuJERKJoQCXLBceew8ajyXFU649/c=;
        b=EQ6rLPq7ibpn4qr/tRLkmhRl2br2Tqj7FWK3jLyTK+1L/0GGYkQ3bv6KOM/1FA3agbC8Io
        /q/C2gx/tBAsNo4B4Hk7Rk8/MaLVzDyeo2tgimp2CizJeQ4aAOrHTSU9GZuxjfh6oTh5iH
        R+9OZs3th+1vKnjdpfQ0I6Nt0cBwYwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689116667;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+dQO5vcnvpIOUOmuJERKJoQCXLBceew8ajyXFU649/c=;
        b=333uOTKdjmn9zqvOuMxFJG/HBnmmFKQljygub6LuiK1oBHQHDqgfE0XJldemadeV4siGsN
        xod/lVUFUeuXP6CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 914131391C;
        Tue, 11 Jul 2023 23:04:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eby3IvvfrWSbXgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 11 Jul 2023 23:04:27 +0000
Date:   Wed, 12 Jul 2023 00:57:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
Subject: Re: [PATCH] btrfs: speedup scrub csum verification
Message-ID: <20230711225752.GI30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6c1ffe48e93fee9aa975ecc22dc2e7a1f3d7a0de.1688539673.git.wqu@suse.com>
 <20230711210153.GG30916@twin.jikos.cz>
 <f3cd2a35-04a3-d5d7-d8ae-c967617b64dd@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3cd2a35-04a3-d5d7-d8ae-c967617b64dd@gmx.com>
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

On Wed, Jul 12, 2023 at 06:24:41AM +0800, Qu Wenruo wrote:
> On 2023/7/12 05:01, David Sterba wrote:
> > On Wed, Jul 05, 2023 at 02:48:48PM +0800, Qu Wenruo wrote:
> >> - Queue sector verification work into scrub_csum_worker
> >>    This allows multiple threads to handle the csum verification workload.
> >>
> >> - Do not reset stripe->sectors during scrub_find_fill_first_stripe()
> >>    Since sectors now contain extra info, we should not touch those
> >>    members.
> >>
> >> Reported-by: Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
> >> Link: https://lore.kernel.org/linux-btrfs/CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com/
> >> Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure")
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >
> > Added to misc-next, thanks.
> 
> Please drop this, I got feedback from some real world tester, and it
> doesn't help at all.
> (Although it shows that the CPU usage is indeed lower than previous)

Ok, no problem. Paralelizing the checksums is likely the way to go but
I don't see how it could be made faster.
