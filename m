Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21056581B49
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 22:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiGZUrm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 16:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiGZUrl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 16:47:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3555E19015;
        Tue, 26 Jul 2022 13:47:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D6A921FEBF;
        Tue, 26 Jul 2022 20:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658868457;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mCeYiM98qk7/jdAtlpy7MJlNkO1AbBgsrKc1/3FMchM=;
        b=IMTvg6jcK1KStNU/fBNfruGXCGwQXHRiN8KYjKphqFuVD+Q6dgsTGJgttO9K9bvhRWaEBu
        vXhzSsvlH8eB7Dg12XyNXTDwhEiXbNX1X4cXiAngUAeXeSqssFm9aDG9R+bfGaV7ztEPiV
        QmOzlBPHCgrEa0tlEbnB+FStZAYBCCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658868457;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mCeYiM98qk7/jdAtlpy7MJlNkO1AbBgsrKc1/3FMchM=;
        b=0zA8p2rnCZzUJPgvYWQZ9svxtqJk1Ko6a8BmcYe1oXvlNcbr7sOvaiGsL+nspUXnY//mHq
        /hFc7qOdK6eOzkDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0BC613A7C;
        Tue, 26 Jul 2022 20:47:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IRclKulS4GKqSAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 26 Jul 2022 20:47:37 +0000
Date:   Tue, 26 Jul 2022 22:42:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     David Sterba <dsterba@suse.cz>,
        =?utf-8?B?0JzQuNGF0LDQuNC7INCT0LDQstGA0LjQu9C+0LI=?= 
        <mikhail.v.gavrilov@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Message-ID: <20220726204240.GM13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chris Murphy <lists@colorremedies.com>,
        =?utf-8?B?0JzQuNGF0LDQuNC7INCT0LDQstGA0LjQu9C+0LI=?= <mikhail.v.gavrilov@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz>
 <fa57195c-cd1e-464e-b099-7552f65e39f5@www.fastmail.com>
 <92e9ca9b-f458-409f-a9c4-150f6bce0b75@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92e9ca9b-f458-409f-a9c4-150f6bce0b75@www.fastmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 26, 2022 at 03:21:32PM -0400, Chris Murphy wrote:
> 
> 
> On Tue, Jul 26, 2022, at 3:19 PM, Chris Murphy wrote:
> > On Tue, Jul 26, 2022, at 12:42 PM, David Sterba wrote:
> >> On Tue, Jul 26, 2022 at 05:32:54PM +0500, Mikhail Gavrilov wrote:
> >>> Hi guys.
> >>> Always with intensive writing on a btrfs volume, the message "BUG:
> >>> MAX_LOCKDEP_CHAIN_HLOCKS too low!" appears in the kernel logs.
> >>
> >> Increase the config value of LOCKDEP_CHAINS_BITS, default is 16, 18
> >> tends to work.
> >
> > Fedora is using 17. I'll make a request to bump it to 18. Thanks.
> 
> Should it be 18 across all archs? Or is it OK to only bump x86_64?

I think it applies to all achritectures equally but I'm no lockdep
expert.
