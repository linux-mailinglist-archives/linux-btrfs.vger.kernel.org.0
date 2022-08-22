Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ED759C09D
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 15:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbiHVNbn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 09:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbiHVNbk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 09:31:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5407E326CF
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 06:31:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D89A134A95;
        Mon, 22 Aug 2022 13:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661175096;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iwKeYWI6EhEfRAneTGLlbut8blrh+Nz07Ivde+eevsY=;
        b=cDelsLiL+8ZjwLPY7bv7AzFdcrLN4TKgLyL36UpzXLm7/BXEtMWKuPW1NRclLpfVenf972
        xonUDHEvY4nN4HGIaUWoY01OM0rcc86ZXK5u32HaCrJcNEaymd9woyrHoPFBGJhImBn4jU
        07eLZO4pQrFuNMQUC3GAoiVo34EZwBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661175096;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iwKeYWI6EhEfRAneTGLlbut8blrh+Nz07Ivde+eevsY=;
        b=PbbJy2aRQi5R8DUgckB3C/zoif1jGxLHVRLNRhUVSHF/lsm1kdWoX8Ndv9krQQQtlfkCLO
        apmBMizmzDjLcXCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A268B13523;
        Mon, 22 Aug 2022 13:31:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K2WKJTiFA2POZAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 Aug 2022 13:31:36 +0000
Date:   Mon, 22 Aug 2022 15:26:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: fix space cache corruption and potential
 double allocations
Message-ID: <20220822132622.GV13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1660690698.git.osandov@fb.com>
 <9ee45db86433bb8e4d7daff35502db241c69ad16.1660690698.git.osandov@fb.com>
 <20220817094708.GA2815552@falcondesktop>
 <Yv0KDifyJLPyjVnp@relinquished.localdomain>
 <CAL3q7H4Ep2HtDvFfax7nVisP=oenxAr785L8t_bwLkx7KCTdJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4Ep2HtDvFfax7nVisP=oenxAr785L8t_bwLkx7KCTdJQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 17, 2022 at 04:46:01PM +0100, Filipe Manana wrote:
> On Wed, Aug 17, 2022 at 4:32 PM Omar Sandoval <osandov@osandov.com> wrote:
> > > --- a/fs/btrfs/ctree.h
> > > +++ b/fs/btrfs/ctree.h
> > > @@ -505,7 +505,6 @@ struct btrfs_free_cluster {
> > >  enum btrfs_caching_type {
> > >         BTRFS_CACHE_NO,
> > >         BTRFS_CACHE_STARTED,
> > > -       BTRFS_CACHE_FAST,
> > >         BTRFS_CACHE_FINISHED,
> > >         BTRFS_CACHE_ERROR,
> > >  };
> >
> > You're right, I missed that. I can add that as another followup cleanup
> > patch unless you want to send it.
> 
> Feel free to add it. I think it makes more sense to squash into this
> patch rather
> than add it as a separate patch, but I don't disagree with doing it that way.

Folded to the patch, thanks.
