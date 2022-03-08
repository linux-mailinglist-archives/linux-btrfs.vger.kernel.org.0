Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E262D4D2046
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 19:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbiCHSbN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 13:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbiCHSbM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 13:31:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368DE3969F
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 10:30:15 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DBD931F380;
        Tue,  8 Mar 2022 18:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646764213;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MfIgpYQC/ltd+DC0FX7WBbsVrFVJbtGdYHehjjC3Dik=;
        b=cgo0fUUxHIobQRVyK2ceZ2fg6WShuL1N+tHEr9pMCfHYxKI+XzlxcucDEq3Tebmu2maXt8
        OrZHBDbX4k8ilvdU01nr5mrF8ybmUo++mAWAj2XC/BetRW910XRaG3kb1+yC/cEBM00FN3
        7ZyD5CLci/KhMx7t4Sd7ebJJPuiRw0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646764213;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MfIgpYQC/ltd+DC0FX7WBbsVrFVJbtGdYHehjjC3Dik=;
        b=/ifSoXLPp1l5vvWQJVOAsVqmWSdDPMQL/LYT8Ubg5HLcaAMBwAtq0lv8S/f9RA8X0nwQMS
        PBLQI/2/fhJwXFAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D2A17A3B81;
        Tue,  8 Mar 2022 18:30:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BB1CDDA7DE; Tue,  8 Mar 2022 19:26:18 +0100 (CET)
Date:   Tue, 8 Mar 2022 19:26:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 01/13] btrfs-progs: turn on more compiler warnings and
 use -Wall
Message-ID: <20220308182618.GU12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1645568701.git.josef@toxicpanda.com>
 <2e052f1f853c09952ff44d250e78f64a3ba1471c.1645568701.git.josef@toxicpanda.com>
 <20220308165126.GO12643@twin.jikos.cz>
 <20220308181503.GT12643@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308181503.GT12643@twin.jikos.cz>
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

On Tue, Mar 08, 2022 at 07:15:03PM +0100, David Sterba wrote:
> On Tue, Mar 08, 2022 at 05:51:26PM +0100, David Sterba wrote:
> > On Tue, Feb 22, 2022 at 05:26:11PM -0500, Josef Bacik wrote:
> > > In converting some of our helpers to take new args I would miss some
> > > locations because we don't stop on any warning, and I would miss the
> > > warning in the scrollback.  Fix this by stopping compiling on any error
> > > and turn on the fancy compiler checks.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ---
> > >  Makefile | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/Makefile b/Makefile
> > > index af4908f9..e0921ca3 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -93,6 +93,9 @@ CFLAGS = $(SUBST_CFLAGS) \
> > >  	 -D_XOPEN_SOURCE=700  \
> > >  	 -fno-strict-aliasing \
> > >  	 -fPIC \
> > > +	 -Wall \
> > > +	 -Wunused-but-set-parameter \
> > > +	 -Werror \
> > 
> > That's in the default flags and based on the recent experience in kernel
> > defaulting to Werror it creates more problems than not. The build is
> > clean enough that new warnings are quite obvious and get fixed right
> > away.
> > 
> > You can always use the EXTRA_CFLAG=-Werror when developing or you can
> > also set CFLAGS=-Werror at configure time, as they get stored in the
> > generated Makefile.inc into SUBST_CFLAGS.
> 
> And actually there's make parameter W=1 like in kernel, that enables
> more warnings though the W=1 build is not clean. I'd rather not clutter
> the default flags by random warnings at all as the build is supposed to
> work on various LTS distros and compilers so that would probably fail
> build.

Ok, so not theoretical, the musl and centos7 builds fail, so I'm
dropping the patch.
