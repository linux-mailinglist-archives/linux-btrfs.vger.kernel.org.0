Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D0541C28A
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 12:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245478AbhI2KTP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 06:19:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40088 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245537AbhI2KSy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 06:18:54 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out2.suse.de (Postfix) with ESMTP id F1A0E1FFDC;
        Wed, 29 Sep 2021 10:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632910632;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AgjhobVbp8X/yYDdWb3CRuFzGSVwJt1C8NJL0mcxuYo=;
        b=kBuDiv1fTr8RuoU3jx40wNPol3FqgDhSzvTm+ncWtY+P5a95bawfkIPsux2A95dAIwikXv
        KDMSOtvXnjlI9/N2Y3wv9jayefWwTGPSoOEpZvVcnBbYn0ytJxhVNpni5OHj8SYr7Z9u0b
        F7yQl4nKnIuwY1mYI4nq/A0J48pkiOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632910632;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AgjhobVbp8X/yYDdWb3CRuFzGSVwJt1C8NJL0mcxuYo=;
        b=j189+3BNwxBPWnFUSRPhGoY/jFHyFPmlLWIlRW5C9+eZaTios3nwIcAD1OWmmbQ0lNj3Vs
        dVHK3yHfBsjtctBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay1.suse.de (Postfix) with ESMTP id C370625D52;
        Wed, 29 Sep 2021 10:17:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 86A4BDA7A9; Wed, 29 Sep 2021 12:16:56 +0200 (CEST)
Date:   Wed, 29 Sep 2021 12:16:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 0/5] btrfs-progs: use direct-IO for zoned device
Message-ID: <20210929101656.GL9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <20210927041554.325884-1-naohiro.aota@wdc.com>
 <20210927192618.GF9286@twin.jikos.cz>
 <20210929022101.h4v7q66xhhjvy426@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929022101.h4v7q66xhhjvy426@naota-xeon>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 29, 2021 at 02:21:02AM +0000, Naohiro Aota wrote:
> On Mon, Sep 27, 2021 at 09:26:18PM +0200, David Sterba wrote:
> > On Mon, Sep 27, 2021 at 01:15:49PM +0900, Naohiro Aota wrote:
> > > As discussed in the Zoned Storage page [1],  the kernel page cache does not
> > > guarantee that cached dirty pages will be flushed to a block device in
> > > sequential sector order. Thus, we must use O_DIRECT for writing to a zoned
> > > device to ensure the write ordering.
> > > 
> > > [1] https://zonedstorage.io/linux/overview/#zbd-support-restrictions
> > > 
> > > As a writng buffer is embedded in some other struct (e.g., "char data[]" in
> > > struct extent_buffer), it is difficult to allocate the struct so that the
> > > writng buffer is aligned.
> > > 
> > > This series introduces btrfs_{pread,pwrite} to wrap around pread/pwrite,
> > > which allocates an aligned bounce buffer, copy the buffer contents, and
> > > proceeds the IO. And, it now opens a zoned device with O_DIRECT.
> > > 
> > > Since the allocation and copying are costly, it is better to do them only
> > > when necessary. But, it is cumbersome to call fcntl(F_GETFL) to determine
> > > the file is opened with O_DIRECT or not every time doing an IO.
> > 
> > This should be in the changelog somewhere too, the last patch looks like
> > a good place so I'll copy it there.
> > 
> > > As zoned device forces to use zoned btrfs, I decided to use the zoned flag
> > > to determine if it is direct-IO or not. This can cause a false-positive (to
> > > use the bounce buffer when a file is *not* opened with O_DIRECT) in case of
> > > emulated zoned mode on a non-zoned device or a regular file. Considering
> > > the emulated zoned mode is mostly for debugging or testing, I believe this
> > > is acceptable.
> > 
> > Agreed.
> > 
> > All patches added to devel. Would be good to add some tests for the
> > emulated mode, ie. that we can test at least something regularly without
> > special devices.
> 
> Will do. We may also add some tests for zoned device by setting up
> null_blk (provided the machine has enough memory).

As setting up the elated zoned devices requires some resources or
non-trivial setup we can add a separate class of tests. As there are
still limitations to what zoned mode supports, running all current tests
won't work anyway without tons of workarounds or quirks to existing
tests.

Adding a separate class would probably duplicate some of the tests but
that's IMHO less error prone way than changing the other tests. If the
zoned-tests are not run by default it should be safe for regular
testing.

Eventually, to avoid code duplication, we cand do some sort of test
links. The zoned-test will set up the environment and then run the
existing test from other directory.
