Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4C72EAEA6
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jan 2021 16:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbhAEPfo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 10:35:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:37954 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727981AbhAEPfn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 10:35:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E328AACAF;
        Tue,  5 Jan 2021 15:35:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EF95ADA7C6; Tue,  5 Jan 2021 16:33:12 +0100 (CET)
Date:   Tue, 5 Jan 2021 16:33:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Rosen Penev <rosenp@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: Question about btrfs and XOR offloading
Message-ID: <20210105153312.GM6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Rosen Penev <rosenp@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAKxU2N_=1uKoVMh20h=_8SyOnHM=WvfZjfQP3t81yN2QTZS4Xg@mail.gmail.com>
 <20210104144437.GE6430@twin.jikos.cz>
 <CAKxU2N-Q5mjTS6arE5+-UgTgAZMGhTMDaGUAT-bQwe4BdjKOsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKxU2N-Q5mjTS6arE5+-UgTgAZMGhTMDaGUAT-bQwe4BdjKOsg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 04, 2021 at 02:56:59PM -0800, Rosen Penev wrote:
> On Mon, Jan 4, 2021 at 6:46 AM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Sat, Jan 02, 2021 at 07:50:38PM -0800, Rosen Penev wrote:
> > > I've noticed that internally, btrfs' XOR code is CPU only. Does anyone
> > > know if there is a performance advantage to using a hardware
> > > accelerated path? I ask as I use BTRFS on a Marvelll ARM platform with
> > > XOR offload capability.
> >
> > Even if it's CPU, it's accelerated and best algorithm is selected at
> > boot time:
> >
> > [   16.357703] raid6: avx2x4   gen() 30635 MB/s
> > [   16.425701] raid6: avx2x4   xor() 10727 MB/s
> > [   16.493701] raid6: avx2x2   gen() 32995 MB/s
> > [   16.561701] raid6: avx2x2   xor() 19596 MB/s
> > [   16.629701] raid6: avx2x1   gen() 26349 MB/s
> > [   16.697710] raid6: avx2x1   xor() 17794 MB/s
> > [   16.765701] raid6: sse2x4   gen() 17354 MB/s
> > [   16.833701] raid6: sse2x4   xor()  9653 MB/s
> > [   16.901706] raid6: sse2x2   gen() 18495 MB/s
> > [   16.969702] raid6: sse2x2   xor() 11562 MB/s
> > [   17.037701] raid6: sse2x1   gen() 14440 MB/s
> > [   17.105818] raid6: sse2x1   xor() 10387 MB/s
> > [   17.108300] raid6: using algorithm avx2x2 gen() 32995 MB/s
> > [   17.110703] raid6: .... xor() 19596 MB/s, rmw enabled
> > [   17.113587] raid6: using avx2x2 recovery algorithm
> > [   17.327666] xor: automatically using best checksumming function   avx
> Yeah...
> 
> [    0.316064] raid6: neonx8   xor()  1087 MB/s
> [    0.452063] raid6: neonx4   xor()  1372 MB/s
> [    0.588064] raid6: neonx2   xor()  1610 MB/s
> [    0.724061] raid6: neonx1   xor()  1345 MB/s
> [    0.860072] raid6: int32x8  xor()   337 MB/s
> [    0.996092] raid6: int32x4  xor()   373 MB/s
> [    1.132087] raid6: int32x2  xor()   348 MB/s
> [    1.268090] raid6: int32x1  xor()   281 MB/s
> [    1.268093] raid6: .... xor() 1610 MB/s, rmw enabled
> 
> Not as fast here.

What's the raw speed of the hw offload? Measured on large data so that
the overhead is negligible.

It might make sense to add the async support in case the speed is
comparable or better to the CPU, but also to reduce the CPU load.
