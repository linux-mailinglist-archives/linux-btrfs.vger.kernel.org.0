Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FD97E054D
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Nov 2023 16:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjKCPMJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Nov 2023 11:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKCPMI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Nov 2023 11:12:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B823D48
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Nov 2023 08:12:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 34DFA1F45F;
        Fri,  3 Nov 2023 15:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699024317;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ElwXSQevayNquyLW6x/lZTVLdbJQdltdKTEoIWQEg14=;
        b=FQL8mPsVPwqU2ZhxEfYzr3ugeH+GYJF9jmeNWfTXn+aXrwCyb7lQMLu/qf1K1TsalSHdAV
        BQfprmqiJ06ZGhA1rmyCPtUmrI04/NezpEUfq5h6IlCpGpSADXA82LIcnss5vZKfI5r08q
        XT23jjBSqVpbSXHTLXLnFDOtFrXlLV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699024317;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ElwXSQevayNquyLW6x/lZTVLdbJQdltdKTEoIWQEg14=;
        b=9aBknxfF72f4KslIIqv/q4Wr0d5rqo4Oz/0gBSprLA1Q7Oio/0z1uL39n7iU8sB0GLal03
        dRJQtiBugrOXMwCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0176C1348C;
        Fri,  3 Nov 2023 15:11:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5KcxO7wNRWVcJwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 03 Nov 2023 15:11:56 +0000
Date:   Fri, 3 Nov 2023 16:04:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tree-checker: add type and sequence check for
 inline backrefs
Message-ID: <20231103150457.GL11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <23fbab97bd9dbce7869e858cb59d96a7238db57e.1698105469.git.wqu@suse.com>
 <20231102190720.GA113907@zen.localdomain>
 <d69a339c-0cc2-4168-ac90-f6c1b91517b4@gmx.com>
 <20231102203529.GA119621@zen.localdomain>
 <12595173-fdc6-4e49-9e37-e97a6b7e8606@gmx.com>
 <20231102213430.GA123227@zen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102213430.GA123227@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 02, 2023 at 02:34:30PM -0700, Boris Burkov wrote:
> On Fri, Nov 03, 2023 at 07:35:48AM +1030, Qu Wenruo wrote:
> > > If it's possible at this stage to change the type number to be 170 or
> > > something, I think that would fix it, and would be a much less intrusive
> > > change than pushing the owner ref item to the back of the inline refs,
> > > which would complicate parsing a lot more, IMO.
> > 
> > I believe this is much better solution.
> 
> Agreed. I hope it's possible! Dave, can you weigh in on whether this
> exact change can be done at this point? You suggested upthread that it
> should be, but I just want to be sure.

Yes, the key number can be changed, we'll only need to synchronize
kernel and progs, which may take a few days. Once this is in kernel I'll
do a 6.6.x bugfix release short after.

The exact key number should be between

BTRFS_METADATA_ITEM_KEY 169

and

BTRFS_TREE_BLOCK_REF_KEY        176

so I wouldn't pick 170 as it leaves no gap. Also add a comment that the
key must be before the other _REF_KEY so the refs can be sorted.
