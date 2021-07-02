Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB223B9F7B
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 13:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhGBLLe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jul 2021 07:11:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54554 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhGBLLe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jul 2021 07:11:34 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6AB3F22583;
        Fri,  2 Jul 2021 11:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625224141;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ic0EIGkr9DW/ssuvV0rYQTB40AxfOuFC0bOfJbq/U7I=;
        b=1VxPr71GTZ7QZ4aIXGlR4XBiX5XrZ03v/ZT5bIvnjO8vGUloSk8cceni3YfGP7jJUtaHNL
        XAsAmKt1HHLK1Lb7/5mJNHufNPqQWv3pJUNgrfAkeAPstR+GuzY2hq+RzRI1i3oT9CH8bI
        Gj0bRj6uznVXicgPEzB6EKvll4uIzEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625224141;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ic0EIGkr9DW/ssuvV0rYQTB40AxfOuFC0bOfJbq/U7I=;
        b=iCV9M6FUhOeD7pcaO2W2mTC4eKU0v+EAg0o1wY1m8otUihpx3N3zBqo9skrHXagRCrp3Cw
        GJqFaUfNR5rzm2Aw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 61080A3B81;
        Fri,  2 Jul 2021 11:09:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6535CDA6FD; Fri,  2 Jul 2021 13:06:30 +0200 (CEST)
Date:   Fri, 2 Jul 2021 13:06:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH] btrfs: add special case to setget helpers for 64k pages
Message-ID: <20210702110630.GE2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
References: <20210701160039.12518-1-dsterba@suse.com>
 <YN67+nvpQBfiLXzh@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN67+nvpQBfiLXzh@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 02, 2021 at 08:10:50AM +0100, Christoph Hellwig wrote:
> > +	if (INLINE_EXTENT_BUFFER_PAGES == 1) {				\
> >  		return get_unaligned_le##bits(token->kaddr + oip);	\
> > +	} else {							\
> 
> No need for an else after the return and thus no need for all the
> reformatting.

That leads to worse code, compiler does not eliminate the block that
would otherwise be in the else block. Measured on x86_64 with
instrumented code to force INLINE_EXTENT_BUFFER_PAGES = 1 this adds
+1100 bytes of code and has impact on stack consumption.

That the code that is in two branches that do not share any code is
maybe not pretty but the compiler did what I expected.  The set/get
helpers get called a lot and are performance sensitive.

This patch pre (original version), post (with dropped else):

1156210   19305   14912 1190427  122a1b pre/btrfs.ko
1157386   19305   14912 1191603  122eb3 post/btrfs.ko

DELTA: +1176

And effect on function stacks:

btrfs_set_token_32                   +8 (48 -> 56)
btrfs_set_token_64                  +16 (48 -> 64)
btrfs_set_32                        +32 (32 -> 64)
btrfs_set_16                        +32 (32 -> 64)
btrfs_set_token_16                   +8 (48 -> 56)
btrfs_set_64                        +40 (32 -> 72)
btrfs_set_token_8                    -8 (48 -> 40)
