Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4533B21FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 22:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhFWUqz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 16:46:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33462 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWUqy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 16:46:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2D74521962;
        Wed, 23 Jun 2021 20:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624481075;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KEPylJ/5OMVWWJLFj+uKL80g+HUG5aNaW4TuIZ7eWCc=;
        b=cmAdcr1yPiIPA0ZIDun8ywxztPKNzq+XLtzld22L0Fwkq3Cwuucr7Jvs5lcWeNoLGLd3sz
        wRO9Pa5lFG5AkyO8YcT4UL2iob5b+q+XOaKYd3MT/WeJ0gd3zBElW5+PaLz00qRfuePVmN
        fXRP0gRyNcZhlrqZ6tRkGMb1N/DyMVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624481075;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KEPylJ/5OMVWWJLFj+uKL80g+HUG5aNaW4TuIZ7eWCc=;
        b=5wiy1x+udyiiv+sDK7qXr/73HPidMAZIqY/2cFqiG3PjaqK1nXuyhrSnbqwX20uao8cnQI
        rSScIodjUChiQmDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E6295A3BB1;
        Wed, 23 Jun 2021 20:44:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 185C2DA908; Wed, 23 Jun 2021 22:41:42 +0200 (CEST)
Date:   Wed, 23 Jun 2021 22:41:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] btrfs: tests: remove unnecessary oom message
Message-ID: <20210623204142.GN28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210617083053.1064-1-thunder.leizhen@huawei.com>
 <20210617203518.GZ28158@twin.jikos.cz>
 <5f6198a7-3d3a-603e-73fe-b56c0b71fbf9@huawei.com>
 <b464d670-aa49-2f41-36f6-36a432959f46@gmx.com>
 <55b0c70b-f0c1-07e2-f8dd-073f4fdc8f07@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55b0c70b-f0c1-07e2-f8dd-073f4fdc8f07@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 18, 2021 at 02:05:59PM +0800, Qu Wenruo wrote:
> On 2021/6/18 下午1:58, Qu Wenruo wrote:
> > On 2021/6/18 上午10:33, Leizhen (ThunderTown) wrote:
> >> On 2021/6/18 4:35, David Sterba wrote:
> >>> On Thu, Jun 17, 2021 at 04:30:53PM +0800, Zhen Lei wrote:
> >>>> Fixes scripts/checkpatch.pl warning:
> >>>> WARNING: Possible unnecessary 'out of memory' message
> >>>>
> >>>> Remove it can help us save a bit of memory.
> >>>
> >>> Well, we have a few more messages in tests regarding failed memory
> >>> allocations.  Though I've never seen one in practice, I think it's not
> >>> a big deal to have that one here as well. The failures in the testsuite
> >>> are intentionally verbose and saving a few bytes in optional development
> >>> feature hardly bothers anyone.
> >>
> >> The calltrace of the OOM message contains all the information printed by
> >> test_err() here. I don't think anyone wants to see a bunch of
> >> unhelpful tips
> >> when locating an OOM problem.
> >
> > This only get enabled for btrfs developers, in production environment
> > would enable CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y.
> >
> > Thus this error message are only for btrfs developers.
> >
> > And I'm 100% sure you won't need to investigate such OOM problem, nor
> > even see it.
> >
> >>> Where bytes can be saved are error messages for the same type of error,
> >>
> >> It also saves a dozen bytes of binary code.
> >
> > It won't make any different as you won't enable that config.
> >
> >>> that I've implemented in the past, see file fs/btrfs/tests/btrfs-tests.c
> >>> array test_error that maps enums to strings.
> >>
> >> As mentioned above, I don't think these "no memory" strings are
> >> necessary,
> >> unless the rest of the test can continue to run healthy. Otherwise, no
> >> one trusts
> >> the test results in the OOM situation. They're going to locate the OOM
> >> problem
> >> first, and these information are pointless. >
> 
> And nope, it's not only OOM can cause the selftest to fail, but also
> error injection.
> 
> I guess you never ran error injection tests for filesystems.
> 
> Under most case, we inject error with specific call chain, but sometimes
> without any call chain specification, error injection may find some
> corner cases we're unaware of.
> 
> If by chance the injected memory allocation failure happens during
> selftest, there will be *NO* OOM dump at all.

Yeah, a hard OOM won't probably happen and the allocations can fail for
other valid reasons.  The error message in the logs, with the ERROR
message level is clear and helpful. Saving a few bytes here does not
make much sense.
