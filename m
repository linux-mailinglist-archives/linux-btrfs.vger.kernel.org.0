Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9216366DA
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2019 23:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfFEVcW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jun 2019 17:32:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfFEVcV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jun 2019 17:32:21 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68B9320872;
        Wed,  5 Jun 2019 21:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559770341;
        bh=fWMGopypMZ/7C4dAWZ6+0bN8QYRsGAbzaarmqrg6gxM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tbj8Y7g23X5waBqWUHzub6be7yKGuSeBV4+Bs+ago5RmjFq2q6I5ahJCu1mPAbJFM
         Ar16J1Rb7r4Aft+hncFL0s/xR5cO1l1G+6faP47VBAZlbz0SGJrdNG7NYX3AdnO8iq
         gNRLxeirFnRVtKmsWgMUvCBS9NeZJ53GJ2o9u2Rc=
Date:   Wed, 5 Jun 2019 14:32:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     dsterba@suse.cz
Cc:     Maninder Singh <maninder1.s@samsung.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        keescook@chromium.org, gustavo@embeddedor.com, joe@perches.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, pankaj.m@samsung.com, v.narang@samsung.com,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        terrelln@fb.com
Subject: Re: [PATCH 1/4] zstd: pass pointer rathen than structure to
 functions
Message-Id: <20190605143219.248ca514546f69946aa2e07e@linux-foundation.org>
In-Reply-To: <20190605123253.GZ15290@suse.cz>
References: <1559552526-4317-1-git-send-email-maninder1.s@samsung.com>
        <CGME20190603090232epcas5p1630d0584e8a1aa9495edc819605664fc@epcas5p1.samsung.com>
        <1559552526-4317-2-git-send-email-maninder1.s@samsung.com>
        <20190604154326.8868a10f896c148a0ce804d1@linux-foundation.org>
        <20190605115703.GY15290@twin.jikos.cz>
        <20190605123253.GZ15290@suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 5 Jun 2019 14:32:53 +0200 David Sterba <dsterba@suse.cz> wrote:

> > >  
> > > -static ZSTD_parameters zstd_get_btrfs_parameters(unsigned int level,
> > > +static ZSTD_parameters *zstd_get_btrfs_parameters(unsigned int level,
> > >  						 size_t src_len)
> > >  {
> > > -	ZSTD_parameters params = ZSTD_getParams(level, src_len, 0);
> > > +	static ZSTD_parameters params;
> > 
> > > +
> > > +	params = ZSTD_getParams(level, src_len, 0);
> > 
> > No thats' broken, the params can't be static as it depends on level and
> > src_len. What happens if there are several requests in parallel with
> > eg. different levels?

I wondered.  I'll drop the patch series as some more serious thinking
is needed.

> > Would be really great if the mailinglist is CCed when the code is
> > changed in a non-trivial way.

Well we didn't actually change btrfs until I discovered that Maninder
had missed it.

> So this does not compile fs/btrfs/zstd.o which Andrew probably found
> too, otherwise btrfs is the only in-tree user of the function outside of
> lib/ and crypto/.

Worked for me - I might have sent the wrong version.

> I think that Nick Terrell should have been CCed too, as he ported zstd
> to linux.
