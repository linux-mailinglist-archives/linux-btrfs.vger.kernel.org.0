Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96238433FC5
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 22:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhJSU2R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 16:28:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57548 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhJSU2Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 16:28:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5BE9A1FD36;
        Tue, 19 Oct 2021 20:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634675162;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8jm1uzpOk4xbYBrUo77YUecNFxAyMHM8ikZpo4BE/jU=;
        b=QdxZYqmbMWlSJdQCyOHCHIBpWQy7MJuGBnpdfAy3nzC8Vbm4FMFCtcSwZJ7BKbFjW48nFY
        mjbX4OgBfZjwV3nJhBNaRHo9JZi8f+MQZesBIzolzHn93qnv4jKo6sUhvP3QDq43nH0EIW
        j4pWip/pDbYjmsw179Ftc4RTQzbv4oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634675162;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8jm1uzpOk4xbYBrUo77YUecNFxAyMHM8ikZpo4BE/jU=;
        b=KNPxpYipCtNIogw6F77tJK0gZmCli+2qMzy9FGBuX9rzDnGXJoLvBvHfk9GLtp64dnATKC
        E4Pkham4aUn8qrAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5022DA3B81;
        Tue, 19 Oct 2021 20:26:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9EF6CDA7A3; Tue, 19 Oct 2021 22:25:34 +0200 (CEST)
Date:   Tue, 19 Oct 2021 22:25:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        nborisov@suse.com
Subject: Re: [PATCH RFC] btrfs: send: v2 protocol and example OTIME changes
Message-ID: <20211019202534.GW30611@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        nborisov@suse.com
References: <20211018144109.18442-1-dsterba@suse.com>
 <YW8Ck9pk6JGvq8V1@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW8Ck9pk6JGvq8V1@relinquished.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 19, 2021 at 10:38:27AM -0700, Omar Sandoval wrote:
> On Mon, Oct 18, 2021 at 04:41:09PM +0200, David Sterba wrote:

> Why do we need new commands for otime? I think it would make the most
> sense to include the BTRFS_SEND_A_OTIME attribute with an existing
> command: either the BTRFS_SEND_C_MK{DIR,FILE,NOD,FIFO,SOCK} command, or
> the first BTRFS_SEND_C_UTIME command after creation. We might as well
> take advantage of the TLV protocol, which allows us to add or remove
> attributes for commands as needed.

Yes there are more ways to extend the protocol, the patch demonstrated
two, and partially it was for me to refresh how the bits are put
together.

As long as the changes are hidden behind the version, we can insert the
attributes to existing commands, like the MKFILE group, that's a nice
trick.

On the receiving side the raw protocol is translated to the callbacks.
I've decoupled the libbtrfs implementation from the internal one, so
we're now free to do any changes to the callback prototypes without
worries to break snapper. Which means either mapping new attributes to
parameters (where we can sensibly detect "n/a") or add new callbacks
with more parameters.

I've found out that eg. the mkfile sends the inode number but it's never
parsed in receive. So for one I'd like to audit such things and write a
machine readable spec of the protocol.
