Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373B0753788
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 12:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjGNKKa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 06:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbjGNKK3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 06:10:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDE61989
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 03:10:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 30FA922132;
        Fri, 14 Jul 2023 10:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689329426;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Da/x8Mf8ktMn9McwjqjnfQElbDv7YdRJFuLrHzm+6s=;
        b=12Yz8FVvahSn8JtJKc0mZXNa5NDKmNwmBZZKqgAFrUlk1B43Ha3HCYm5vnSauAaoYoinfz
        QBw2JvZpFvbVRWLvngtnwTs9+ZZN878gY2+cD27m+kcKkyniOnuoJV/y7OJQWoy5kiAQKQ
        1z5z5T3B/4iBQa4UEI/FDWEPpIu0lgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689329426;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Da/x8Mf8ktMn9McwjqjnfQElbDv7YdRJFuLrHzm+6s=;
        b=AbPqhRj7jj5npVmVi3ppJPQjHSlDVlQop7U1A53uXdEnQKBSfntSaoxWLsDHlQ/Pu8CI5E
        PaYnA0YzBNY5QfAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 101E613A15;
        Fri, 14 Jul 2023 10:10:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id G60PAxIfsWTcCwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 14 Jul 2023 10:10:26 +0000
Date:   Fri, 14 Jul 2023 12:03:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/6] btrfs: preparation patches for the incoming
 metadata folio conversion
Message-ID: <20230714100349.GF20457@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1689143654.git.wqu@suse.com>
 <20230713120935.GU30916@twin.jikos.cz>
 <20230713163908.GW30916@twin.jikos.cz>
 <9251d155-2e2e-a126-579e-2765e98a4a9d@gmx.com>
 <20230713220311.GC20457@suse.cz>
 <6c7b397a-8552-e150-a6fd-95ae73390509@gmx.com>
 <20230714002605.GD20457@suse.cz>
 <1bab3588-9b53-c212-3b45-91ee61f5b820@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bab3588-9b53-c212-3b45-91ee61f5b820@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 14, 2023 at 09:58:00AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/7/14 08:26, David Sterba wrote:
> > On Fri, Jul 14, 2023 at 08:09:16AM +0800, Qu Wenruo wrote:
> >>
> >>
> >> On 2023/7/14 06:03, David Sterba wrote:
> >>> On Fri, Jul 14, 2023 at 05:30:33AM +0800, Qu Wenruo wrote:
> >>>> On 2023/7/14 00:39, David Sterba wrote:
> >>>>> 		ref#0: tree block backref root 7
> >>>>> 	item 14 key (30572544 169 0) itemoff 15815 itemsize 33
> >>>>> 		extent refs 1 gen 5 flags 2
> >>>>> 		ref#0: tree block backref root 7
> >>>>> 	item 15 key (30588928 169 0) itemoff 15782 itemsize 33
> >>>>> 		extent refs 1 gen 5 flags 2
> >>>>> 		ref#0: tree block backref root 7
> >>>>
> >>>> This looks like an error in memmove_extent_buffer() which I
> >>>> intentionally didn't touch.
> >>>>
> >>>> Anyway I'll try rebase and more tests.
> >>>>
> >>>> Can you put your modified commits in an external branch so I can inherit
> >>>> all your modifications?
> >>>
> >>> First I saw the crashes with the modified patches but the report is from
> >>> what you sent to the mailinglist so I can eliminate error on my side.
> >>
> >> Still a branch would help a lot, as you won't want to re-do the usual
> >> modification (like grammar, comments etc).
> >
> > Branch ext/qu-eb-page-clanups-updated-broken at github.
> 
> Already running the auto group with that branch, and no explosion so far
> (btrfs/004 failed to mount with -o atime though).
> 
> Any extra setup needed to trigger the failure?

I'm not aware of anything different than usual. Patches applied to git,
built, updated VM and started. I had another branch built and tested and
it finished the fstests. I can at least bisect which patch does it.
