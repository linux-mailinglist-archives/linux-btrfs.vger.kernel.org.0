Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2766673154A
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jun 2023 12:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245460AbjFOK2t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jun 2023 06:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240076AbjFOK2m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jun 2023 06:28:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C032729
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jun 2023 03:28:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B140D1FE03;
        Thu, 15 Jun 2023 10:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686824916;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tBRK8bTYCSse2w2xZ/bloOs/uCBl1+PU5qKzc5QoC50=;
        b=I4effM+U+sQ+XwUdgBmqDf2fczwP2jM5t2WIWYUd7wLS2NCfXDZU9mvqaC/j/AkGsHyrPF
        kXrqGr2QpuY9M4+zWMBAlsZRA0g8L3kEPv7pGZMUpA1y0p4Yaa9DREd1s3vi+1U1ILNuiJ
        3Nexuylm7iK1iu83jhP+8YnXFlIDzwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686824916;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tBRK8bTYCSse2w2xZ/bloOs/uCBl1+PU5qKzc5QoC50=;
        b=Q+F7etzA1PeD9kIYy96HdgPZqmiEMX8kMzy2iA0iDB6LBC+louFXMXErpJA8bRa9jqYdHC
        YlsJHE4D410N9aCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81B9C13A47;
        Thu, 15 Jun 2023 10:28:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iYPVHtTnimS6cQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 15 Jun 2023 10:28:36 +0000
Date:   Thu, 15 Jun 2023 12:22:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fix accessors for big endian systems
Message-ID: <20230615102216.GU13486@suse.cz>
Reply-To: dsterba@suse.cz
References: <55b1841a271b69b8047f1195eeb26fb23f893f71.1686738215.git.wqu@suse.com>
 <20230615092844.GT13486@twin.jikos.cz>
 <407d5523-f91f-70e9-4df4-00f5e09935c9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407d5523-f91f-70e9-4df4-00f5e09935c9@gmx.com>
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

On Thu, Jun 15, 2023 at 05:56:31PM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/6/15 17:28, David Sterba wrote:
> > On Wed, Jun 14, 2023 at 06:23:43PM +0800, Qu Wenruo wrote:
> >> --- a/kernel-shared/accessors.h
> >> +++ b/kernel-shared/accessors.h
> >> @@ -7,6 +7,8 @@
> >>   #define _static_assert(expr)   _Static_assert(expr, #expr)
> >>   #endif
> >>
> >> +#include <bits/endian.h>
> >
> > Files from bits/ should not be included directly and it's
> > glibc-specific, also breaks build on musl. Fixed.
> 
> Weird, as for those things which should not be included, normally they
> have something like this from endianness.h:
> 
> #ifndef _BITS_ENDIAN_H
> # error "Never use XXXXX directly; include <whatever.h> instead."
> #endif

Yeah not all of them have it, they probably should.

> Another concern removing this line is, we're relying on the final .c
> file to include needed headers.
> For this particular case it's not a problem at all as standard library
> headers would be included anyway.
> 
> But I'm still not sure what should be the proper way to go.

Actually we have the proper way, to include kerncompat.h from all
kernel-shared files. There's endian.h included and there are also
__BYTE_ORDER checks done the right way. The accessors.h currently has
no includes at all.

Ideally all includes are self contained when compile tested, ie. all
types/macros/... are either properly defined by other includes or have a
forward definition. I had done a pass with include-what-you-use tool but
that was before the kernel source sync. Doing compile tests of headers
is simpler, using only compiler. Planned to be done eventually.

> > I'm going to enable quick build tests for pull request, right now the
> > tests are ran once I push devel which usually happens after I reply with
> > the 'applied' mail. The test results can be found at
> > https://github.com/kdave/btrfs-progs/actions .
> 
> That would be very appreciated.
> 
> However this is better with github pull hooks, I'm not sure if this
> means it's better to use github pull as the primary method, and just
> keep the emails as backup methods for old school guys like me.

Currently we do both and you can open a pull request with the patches
you send as mails to get the build tests. Or, you can do local build
test when you set up docker (how to do that is described in
ci/README.md), then it's one script away.
