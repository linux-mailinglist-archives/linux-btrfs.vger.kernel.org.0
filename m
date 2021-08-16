Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44733ED464
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 14:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhHPM52 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 08:57:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42126 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhHPM52 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 08:57:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 56AAE1FE5A;
        Mon, 16 Aug 2021 12:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629118616;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4CLf8hD32dj3BslNPPMbtgjCupprkocGZXxMW/S9fJk=;
        b=kQsBODZxXQNGhJF7bpMmn80+RiAL/aZwW9I/l3e2R/yL6oRVn1i4UfZognGdXyRYqIt4fP
        tkzjzAHYGDXnC5OQfqR+hgfsBbmlHHY4m4vKtN4UWFLRpvJ2FczAwggRwhFV/iIrQ1L2xc
        3Og+yGaoN8oDD1v9erhDZYzKvbPy+2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629118616;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4CLf8hD32dj3BslNPPMbtgjCupprkocGZXxMW/S9fJk=;
        b=xS38fZxgLPtdVWrI2GDxKd9BA2D6pNmyqKS8j/f0h+vCA1taEn2pIEhdSlXY1rSyXVeRvG
        P726fCZKUUEvmxCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4DD65A3B85;
        Mon, 16 Aug 2021 12:56:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AF2D0DA72C; Mon, 16 Aug 2021 14:54:00 +0200 (CEST)
Date:   Mon, 16 Aug 2021 14:54:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <mpdesouza@suse.de>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
Subject: Re: [PATCH RFC] btrfs: Introduce btrfs_for_each_slot
Message-ID: <20210816125400.GY5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <mpdesouza@suse.de>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
References: <20210802125738.22588-1-mpdesouza@suse.com>
 <9107ecb2f56198dc7329820d3a25173d4924682d.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9107ecb2f56198dc7329820d3a25173d4924682d.camel@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 16, 2021 at 09:21:30AM -0300, Marcos Paulo de Souza wrote:
> On Mon, 2021-08-02 at 09:57 -0300, Marcos Paulo de Souza wrote:
> > There is a common pattern when search for a key in btrfs:
> > 
> >  * Call btrfs_search_slot
> >  * Endless loop
> > 	 * If the found slot is bigger than the current items in the
> > leaf, check the
> > 	   next one
> > 	 * If still not found in the next leaf, return 1
> > 	 * Do something with the code
> > 	 * Increment current slot, and continue
> > 
> > This pattern can be improved by creating an iterator macro, similar
> > to
> > those for_each_X already existing in the linux kernel. using this
> > approach means to reduce significantly boilerplate code, along making
> > it
> > easier to newcomers to understand how to code works.
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> > 
> >  I've being testing this approach in the last few weeks, and using
> > this macro
> >  all over the btrfs codebase, and not issues found yet. This is just
> > a RFC
> >  showing how the xattr code would benefit using the macro.
> > 
> >  The only part that I didn't like was using the ret variable as a
> > macro
> >  argument, but I couldn't find a better way to do it...
> > 
> >  That's why this is an RFC, so please comment :)
> 
> Gentle ping :)

We're just before code freeze for the next merge window so non-critical
patches are on hold.
