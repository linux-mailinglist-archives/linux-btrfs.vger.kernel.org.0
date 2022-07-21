Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4181757D03B
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 17:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiGUPtZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 11:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiGUPsw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 11:48:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA201EEF4;
        Thu, 21 Jul 2022 08:48:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 725B51F91A;
        Thu, 21 Jul 2022 15:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658418516;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pTFaxcnpQTAgj43gxuDBbqEI3bgKpJWVuWlNfh+RN0A=;
        b=wBN4t+mHTN2SUrDDMC1TBxBRpVpC9YH5iJq1DOkNZCjwr1eVZRkpQZ3v6O+EDZel5vKTLY
        qcx8qv2yholDy2quXyJ302i0YuIehscrprHUYy+P0zikpCF2cp3DHxUJJWhbhRRx0UkbOB
        08cb5QvitjkIHfJVpnIKYesBbyZfhbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658418516;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pTFaxcnpQTAgj43gxuDBbqEI3bgKpJWVuWlNfh+RN0A=;
        b=9mWu65ySJqoJH2ncWIWObAU+OinXEKlggC4d0pnvDU2ACY04XOquiZ8LHx7AK3sQH7h+9Z
        pMwG1kpIKbgNuDDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 346B813A1B;
        Thu, 21 Jul 2022 15:48:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vYglC1R12WLjZQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 21 Jul 2022 15:48:36 +0000
Date:   Thu, 21 Jul 2022 17:43:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.com>, torvalds@linux-foundation.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs fixes for 5.19-rc7
Message-ID: <20220721154339.GV13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.com>, torvalds@linux-foundation.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1657976305.git.dsterba@suse.com>
 <YtLadOkHl0lDNwbM@casper.infradead.org>
 <20220721144508.GU13489@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721144508.GU13489@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 21, 2022 at 04:45:08PM +0200, David Sterba wrote:
> On Sat, Jul 16, 2022 at 04:34:12PM +0100, Matthew Wilcox wrote:
> > On Sat, Jul 16, 2022 at 04:06:20PM +0200, David Sterba wrote:
> > > Note about the xarray API:
> > > 
> > > The possible sleeping is documented next to xa_insert, however there's
> > > no runtime check for that, like is eg. in radix_tree_preload.  The
> > > context does not need to be atomic so it's not as simple as
> > > 
> > >   might_sleep_if(gfpflags_allow_blocking(gfp));
> > > 
> > > or
> > > 
> > >   WARN_ON_ONCE(gfpflags_allow_blocking(gfp));
> > > 
> > > Some kind of development time debugging/assertion aid would be nice.
> > 
> > Are you saying that
> > https://git.infradead.org/users/willy/xarray.git/commitdiff/c195d497ca1ff673c2e6935152a0a5b6be2efdc9
> > 
> > is wrong?  It's been in linux-next for the last week since you drew it
> > to my attention that this would be useful.
> 
> I have misinterpreted what might_sleep_if does in case it's under mutex,
> it won't warn so the linked commit (adding might_alloc) should be
> enough, thanks.

I did a quick test, with spin locks it's detected right away, with
mutexes no warnings as expected.
