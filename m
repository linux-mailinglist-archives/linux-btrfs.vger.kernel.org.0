Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F2E420AC4
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 14:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhJDMVx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 08:21:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48866 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhJDMVw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 08:21:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 347B622337;
        Mon,  4 Oct 2021 12:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633350003;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PpUXLbO0Xjhus7S4i/G79z6TwL9q6Ws9l3SnWNuMgSc=;
        b=HBxum2YKvxTS9ywrkLvQ7fd1p68kPrBAYWdPNDVXrpOf9ll9wrNkEk0z3QrAY4IT+G1kOW
        3tpai7pkc6x/hOCA3KUlcQl9XDrQFc2p/f3zzzlp41i8xVMx1O3JJK+cqiE9IO9Rlzgd3b
        JJqT+XVA3DyGQSgDGAoaHX3zoeL4clE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633350003;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PpUXLbO0Xjhus7S4i/G79z6TwL9q6Ws9l3SnWNuMgSc=;
        b=5gX/0Kw7r806OHUihmNMuQ6DkQoBhFt3ks10KQ9WEvrPgrE/07QB3oT0VCWms5FrzCm38i
        QpwqVKX8Q3zMIgBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2B281A3B88;
        Mon,  4 Oct 2021 12:20:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0565CDA7F3; Mon,  4 Oct 2021 14:19:43 +0200 (CEST)
Date:   Mon, 4 Oct 2021 14:19:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: 5.15.0-rc1 armv7hl Workqueue: btrfs-delalloc btrfs_work_helper
 PC is at mmiocpy LR is at ZSTD_compressStream
Message-ID: <20211004121943.GY9286@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtT+OuemovPO7GZk8Y8=qtOObr0XTDp8jh4OHD6y84AFxw@mail.gmail.com>
 <20210921195632.GR9286@twin.jikos.cz>
 <v92d3sjs.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v92d3sjs.fsf@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 04, 2021 at 07:57:25PM +0800, Su Yue wrote:
> 
> On Tue 21 Sep 2021 at 21:56, David Sterba <dsterba@suse.cz> wrote:
> 
> > On Mon, Sep 20, 2021 at 06:13:07PM -0600, Chris Murphy wrote:
> >> https://kojipkgs.fedoraproject.org//work/tasks/8820/75928820/oz-armhfp.log
> >
> >> 00:09:50,679 EMERG kernel:[<c08bd768>] (mmiocpy) from 
> >> [<c089c314>]
> >> (ZSTD_compressStream+0x184/0x294)
> >
> > The last function to fail is inside ZSTD implementation in 
> > kernel.
> > If btrfs passes wrong data to zstd we'd see that also on non-arm 
> > builds,
> > so guessing by mmiocpy as a copy-something function it could be 
> > some
> > sort of alignment problem that works on x86_64 but throws an 
> > exception
> > on arm as it's stricter about alignment.
> 
> It's about 32bits platforms. There is another report about x86 
> cpu.
> And it's reproduciable by running btrfs/004 (lzo and zstd)in x86 
> VM.
> In my arm64, all things are fine.
> And the bisection result is the highmem related patchset
> '[PATCH 0/6] Remove highmem allocations, kmap/kunmap'.

I must be missing something then, if the pages are not allocated from
HIGHMEM we don't need kmap. If the pages come from outside and are
potentially allocated from HIGHMEM kmap is used, that's for all the
file/inode pages.
