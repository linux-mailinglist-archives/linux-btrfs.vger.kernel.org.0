Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5035BFBA6
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Sep 2022 11:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiIUJto (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 05:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIUJtS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 05:49:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674EB93532
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 02:47:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 52B0221B24;
        Wed, 21 Sep 2022 09:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663753546;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hbxDVQ9a2G4B5Oi0g8Qi/vg1fI1g9YxNvSSMQf0pMZw=;
        b=TMuwct+UMLIyOcKp1Ap+aiRXP/hm/CaDmc/ssUJ6vxz6Cs6F17xFKgAffRDlueLtpc33nL
        IkhIABf0FS6j1CKe41LOEqFvE60A1JBXTUM5EC3u7+cXaysrrhK/FuIHJfiteSnwao6Ypg
        3y8YfptTbxHY+OiO28UUkRGQB/3Qtno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663753546;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hbxDVQ9a2G4B5Oi0g8Qi/vg1fI1g9YxNvSSMQf0pMZw=;
        b=uijnVsaCq27/iUMcvSfHVQywbE53ZagDDnjnAsLF7MFReB94WJ8P2JOK/OHZjhVm0cIIbF
        2Mrzg+bDVEe/EOBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A87F13A00;
        Wed, 21 Sep 2022 09:45:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5LU7BUrdKmOgTwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 21 Sep 2022 09:45:46 +0000
Date:   Wed, 21 Sep 2022 11:40:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: split the bio submission path into a separate
 file
Message-ID: <20220921094014.GB32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20220912141121.3744931-1-hch@lst.de>
 <20220912141121.3744931-2-hch@lst.de>
 <PH0PR04MB7416C3ED5D9F5732E5C4D5D09B449@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220913050829.GA29304@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913050829.GA29304@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 13, 2022 at 07:08:29AM +0200, Christoph Hellwig wrote:
> On Mon, Sep 12, 2022 at 03:27:10PM +0000, Johannes Thumshirn wrote:
> > On 12.09.22 16:11, Christoph Hellwig wrote:
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2007 Oracle.  All rights reserved.
> > > + * Copyright (C) 2022 Christoph Hellwig.
> > > + */
> > 
> > IIRC David does try to get rid of all the per-company copyright
> > statements for new files.
> 
> We just had that discussion in another thread - there really is no
> basis for getting rid of them.  In fact talking to lawyers, most
> of them thing we should have more of them, not less.

There seems to be no clear consensus that would satisfy lawyers (track
complete copyright information) and practical point of view (it's in the
git metadata). The problem not only I see taking this patch as an
example is that your (c) name now appears in file containing changes
from several other people whose names are not mentioned (but yes the
original copyright is preserved).

I don't want to speculate what would this mean from the legal POV and I
think we've heard each other's arguments. If there's a recommended
practice coming "from above" as linux project, like it was with the
SPDX, ok let everybody add their copyright notices. But until then I
won't take such patches.
