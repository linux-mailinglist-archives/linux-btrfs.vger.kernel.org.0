Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D99E521586
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 14:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240678AbiEJMjU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 08:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239777AbiEJMjT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 08:39:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC1B2A974F
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 05:35:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2D7A41F8BA;
        Tue, 10 May 2022 12:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652186121;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eK6oo+7xs0NSEuDRqADbMNqLpZ2fOD1DitfHXxHkNrE=;
        b=EiEN5gRBfnETUPZiJ4DyajfLzBd1FanGuTOfkqGi79UoxDe9ZiLlrO/GiVREAKQL6hCU6v
        MyGNrKy5WB4En/fxve6H0JYObey41KVumvT34QlkchTN357rHfeW+8K7omle5VVZ5W67My
        QvrmUxqbjLY6k/gbv7YbPHHLAiTa17A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652186121;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eK6oo+7xs0NSEuDRqADbMNqLpZ2fOD1DitfHXxHkNrE=;
        b=QFZ8yAIsyv273pr285gauxeGIOV7pA3tZHHbUhe8xECfc6zYwevlBz2j4ez9DMaeSEKBp5
        NUEpxgoWFOsas3Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE88213AC1;
        Tue, 10 May 2022 12:35:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id E+dNOQhcemJ/DAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 10 May 2022 12:35:20 +0000
Date:   Tue, 10 May 2022 14:31:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: print-tree: print the checksum of header
 without tailing zeros
Message-ID: <20220510123106.GO18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <38bf1bf79e8443d570e982edb8a6b71f27cf1ab5.1652162441.git.wqu@suse.com>
 <20220510114858.GL18596@twin.jikos.cz>
 <87f809c9-3b85-4eb0-8919-a80fc68740c1@gmx.com>
 <b3bd300f-7b1c-6bef-5377-b437e947f1c1@gmx.com>
 <20220510121900.GN18596@twin.jikos.cz>
 <99bde932-f9b4-5212-4dff-2748e8e0489b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99bde932-f9b4-5212-4dff-2748e8e0489b@gmx.com>
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

On Tue, May 10, 2022 at 08:24:33PM +0800, Qu Wenruo wrote:
> >>
> >> In configure, we set $EXPERIMENTAL=0 by default, then
> >> add the line into confdefs.h:
> >>
> >> #define EXPERIMENTAL 0
> >>
> >> However in print-tree.c, we use
> >>
> >> #ifdef EXPERIMENTAL
> >>
> >> Then it always get enabled, no matter if it's 0 or 1.
> >>
> >> We should either don't define it at all, and use the "#ifdef" way, or we
> >> should go "#if EXPERIMENTAL" instead.
> >
> > Oh you're right, #ifdef is wrong, it's supposed to be either
> > "if (EXPERIMENTAL)" or "#if". My bad, I'll fix it.
> 
> Although personally speaking, I'm pretty happy to enable experimental
> features for everyone, even just by an accident.

I understand that for you it's just another feature and you'll get
informed how to use it or what to avoid, or eventually fix or report
bugs you find. But this can't be expected from a common user and the
experimental status means basically anything from serious bugs to
incomplete functionality. Incremental development is the model here and
the build-time option is a shield to avoid anything that might harm
users.

Once a feature is relatively complete and well tested, then it's time to
promote it. At this point the checksum switch is closest to that point.
I don't remember any remaining bugs after you've fixed the enumeration
of extents for the --init-csum-tree, so we can hammer it a bit more and
then drop the status.
