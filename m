Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE81779EDF3
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 18:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjIMQHF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 12:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjIMQHE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 12:07:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698C290;
        Wed, 13 Sep 2023 09:07:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D6E9321836;
        Wed, 13 Sep 2023 16:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694621213;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=InTVVixgarLdq9sJW0xxw5lBvVws3XVqlLLBklMYUPg=;
        b=iIMWgw0qN4Ol+WcvWpTZHirch8DSvJEiJsGAS4XL1EuIeZmYKDRb4hyfgrWAKZ0wbZTCwn
        1O6k/JH2TvC4ZxoRB+IB8gEzsxdT21X9gedufYYlHLiEWB2uTnzABRasWeD7t6borYuPDJ
        AjyPvIHjP+TPQemN0GFmN7ooMDiBPvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694621213;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=InTVVixgarLdq9sJW0xxw5lBvVws3XVqlLLBklMYUPg=;
        b=upYbLT52d7aqpR7OX0t7FgmhnU4s+FHD0n0QNcN9PYmYGiDz0xf26lBrOSf4lgBGqvQWML
        EcnngPISOulsOfDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A1E3913582;
        Wed, 13 Sep 2023 16:06:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QkW3Jh3eAWWFEwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Sep 2023 16:06:53 +0000
Date:   Wed, 13 Sep 2023 18:06:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 01/11] btrfs: add raid stripe tree definitions
Message-ID: <20230913160651.GN20408@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
 <20230911-raid-stripe-tree-v8-1-647676fa852c@wdc.com>
 <20230912203214.GE20408@twin.jikos.cz>
 <50cfa5a0-c209-430f-8c00-54ba41c3791d@wdc.com>
 <20230913144951.GL20408@twin.jikos.cz>
 <110deaa7-9682-4ddb-a5b0-2b5f627f6044@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <110deaa7-9682-4ddb-a5b0-2b5f627f6044@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 13, 2023 at 02:57:50PM +0000, Johannes Thumshirn wrote:
> On 13.09.23 16:50, David Sterba wrote:
> > On Wed, Sep 13, 2023 at 06:02:09AM +0000, Johannes Thumshirn wrote:
> >> On 12.09.23 22:32, David Sterba wrote:
> >>>> @@ -306,6 +306,16 @@ BTRFS_SETGET_FUNCS(timespec_nsec, struct btrfs_timespec, nsec, 32);
> >>>>    BTRFS_SETGET_STACK_FUNCS(stack_timespec_sec, struct btrfs_timespec, sec, 64);
> >>>>    BTRFS_SETGET_STACK_FUNCS(stack_timespec_nsec, struct btrfs_timespec, nsec, 32);
> >>>>    
> >>>> +BTRFS_SETGET_FUNCS(stripe_extent_encoding, struct btrfs_stripe_extent, encoding, 8);
> >>>
> >>> What is encoding referring to?
> >>
> >> At the moment (only) the RAID type. But in the future it can be expanded
> >> to all kinds of encodings, like Reed-Solomon, Butterfly-Codes, etc...
> > 
> > I see, could it be better called ECC? Like stripe_extent_ecc, that would
> > be clear that it's for the correction, encoding sounds is too generic.
> 
> Hmm but for RAID0 there is no correction, so not really as well. I'd 
> suggest 'type', but I /think/ for RAID5/6 we'll need type=data and 
> type=parity (and future ECC as well).
> 
> Maybe level, as in RAID level? I know currently it is redundant, as we 
> can derive it from the block-group.

Ok, let's keep encoding, we might actually need the genric meaning, what
I was missing was the context.
