Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EF579EB8E
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 16:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241501AbjIMOuB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 10:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjIMOuA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 10:50:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC6CAC;
        Wed, 13 Sep 2023 07:49:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D312C21862;
        Wed, 13 Sep 2023 14:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694616594;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qVk3/CE5e8fLZkZLh5KxyTgw7iuH+oU1qbI7sf/DAeU=;
        b=ujGYJrZc9zUIGUE3kbhur5R1JRBiOC5Y5cCtY3pHeFKvHcIbY+8Kh2QSPMIebpOsyoqWM6
        W9NBk3cRMBA6CZPJTLI6LxLmqTbWtHwJB36IAQnUY77Lp4hXlZnGhAwFdoxaZhv+2qjVxU
        XkXZQEfiQlO+jE8BDv7PrOljU0OHNDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694616594;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qVk3/CE5e8fLZkZLh5KxyTgw7iuH+oU1qbI7sf/DAeU=;
        b=qSNADMRNpmcRg8OHB595Kv5Hl6z0BbNgbsYZnhWi3LQ17JCNk8QJstyYJqCZP+sgWvkCtz
        mFVnUObq9IlHNWDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9ABAA13440;
        Wed, 13 Sep 2023 14:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id spvwJBLMAWXobQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Sep 2023 14:49:54 +0000
Date:   Wed, 13 Sep 2023 16:49:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 01/11] btrfs: add raid stripe tree definitions
Message-ID: <20230913144951.GL20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
 <20230911-raid-stripe-tree-v8-1-647676fa852c@wdc.com>
 <20230912203214.GE20408@twin.jikos.cz>
 <50cfa5a0-c209-430f-8c00-54ba41c3791d@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50cfa5a0-c209-430f-8c00-54ba41c3791d@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 13, 2023 at 06:02:09AM +0000, Johannes Thumshirn wrote:
> On 12.09.23 22:32, David Sterba wrote:
> >> @@ -306,6 +306,16 @@ BTRFS_SETGET_FUNCS(timespec_nsec, struct btrfs_timespec, nsec, 32);
> >>   BTRFS_SETGET_STACK_FUNCS(stack_timespec_sec, struct btrfs_timespec, sec, 64);
> >>   BTRFS_SETGET_STACK_FUNCS(stack_timespec_nsec, struct btrfs_timespec, nsec, 32);
> >>   
> >> +BTRFS_SETGET_FUNCS(stripe_extent_encoding, struct btrfs_stripe_extent, encoding, 8);
> > 
> > What is encoding referring to?
> 
> At the moment (only) the RAID type. But in the future it can be expanded 
> to all kinds of encodings, like Reed-Solomon, Butterfly-Codes, etc...

I see, could it be better called ECC? Like stripe_extent_ecc, that would
be clear that it's for the correction, encoding sounds is too generic.

> >> +	__le64 devid;
> >> +	/* physical location on disk */
> >> +	__le64 physical;
> >> +	/* length of stride on this disk */
> >> +	__le64 length;
> >> +};
> > 
> > __attribute__ ((__packed__));
> 
> The structure doesn't have any holes in it so packed is not needed.
> 
> I might also be misinformed, but doesn't packed potentially lead to bad 
> code generation on some platforms?  I've always been under the 
> impression that packed forces the compiler to do byte-wise loads and 
> stores. But as I've said, I might be misinformed.

All on-disk structures have the packed attribute so for consistency and
future safety it should be here too, even if it technically does not
need it due to alignment. In addition, strucutres that need padding
would be also problematic, e.g. u64 followed by u32 needs 4 bytes of
padding but the next item after it would be placed right after u32.

It's right that on some platforms unaligned access is done by more code
but for the same reason on such platforms we can't let the compiler
decide the layout when the structure is directly mapped onto the blocks.
