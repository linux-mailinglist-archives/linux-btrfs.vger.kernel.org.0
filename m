Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0F03EA842
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 18:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhHLQJY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 12:09:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39954 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhHLQJY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 12:09:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3DE75222AF;
        Thu, 12 Aug 2021 16:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628784538;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rWPsA25eCEQcZbuK9s9vvAkeM3zMKSTO73WcMgk15y8=;
        b=PEfXm6xKt0uvF3F+PuYAgrImX8vbr0jmXV3U2qTactUnqbMEl+eCArG5Q8Jm/fXw/Ql+Vw
        4DUzTCU/RahhFBvaaiqWQ9/pmzeEpCs3dzLN8BLFEsgajHVRMIWndusZzzGa+UG0UTM57V
        WC+1nY2vGl373sKfIq9ly+oVSOwOEq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628784538;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rWPsA25eCEQcZbuK9s9vvAkeM3zMKSTO73WcMgk15y8=;
        b=RkLJhrKX18sdw3S+5SYfUEVD4rY+k63BPV3GODnY66YMYALGq+79shChFW0T0f/vgcVMEf
        vQaZguAmQABzpGAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 36489A3F70;
        Thu, 12 Aug 2021 16:08:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BB56CDA733; Thu, 12 Aug 2021 18:06:04 +0200 (CEST)
Date:   Thu, 12 Aug 2021 18:06:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: setup the page before calling any subpage helper
Message-ID: <20210812160604.GN5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210730055857.149633-1-wqu@suse.com>
 <20210730110805.GF5047@twin.jikos.cz>
 <248d9d63-f078-0e34-36ea-b1ff5cd63627@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <248d9d63-f078-0e34-36ea-b1ff5cd63627@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 30, 2021 at 07:27:41PM +0800, Qu Wenruo wrote:
> On 2021/7/30 下午7:08, David Sterba wrote:
> > On Fri, Jul 30, 2021 at 01:58:57PM +0800, Qu Wenruo wrote:
> > Yeah it's hard to believe, but it's been there since almost the
> > beginning. Back then there was a hard BUG() in the fixup worker, I've
> > hit it randomly on x86_64,
> > 
> > https://lore.kernel.org/linux-btrfs/20111031154139.GF19328@twin.jikos.cz/
> > 
> > you could find a lot of other reports where it crashed inside
> > btrfs_writepage_fixup_worker.
> 
> Well, over 10 years ago.
> 
> But finally I have seen a real world report for it.
> 
> This makes me wonder, wouldn't other sites like iomap, which also 
> utilize a private structure for subpage bitmaps, also hit such crash?

I don't know.

> >> Fix it by moving set_page_extent_mapped() call before
> >> btrfs_page_clear_error().
> >> And make sure in the error path we won't call anything subpage helper.
> > 
> > I'm not sure about the fix, because the whole fixup thing is not
> > entirely clear.
> 
> Indeed, but the idea should be straightfoward:
> 
> Don't call any subpage helper before set_page_extent_mapped().
> 
> So that such page without private get passed in, we can still handle it 
> well.
> 
> > 
> >> Fixes: 32443de3382b ("btrfs: introduce btrfs_subpage for data inodes")
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> I really hope we can have a more explicit comment about in exactly which
> >> cases we can have such page, and maybe some test cases for it.
> > 
> > The only reliable test case was on s390 with a particular seed for fsx,
> > I still have it stored somewhere. On x86_64 it's very hard to hit.
> 
> Can it be reproduced by S390 qemu tcc emulation?

I think the reproducer was deterministic, depending on the fsx seed it
created a file layout that at some point triggered the desync between hw
page and memory management page, requiring the fixup.

So even if the emulation is slow, it should work to verify the test. If
you set that up, you could also restore the BUG() inside the fixup
worker to see for yourself that this mysterious fixup thing is real.

> And by S390, did you mean modern Power8/9/10 systems too?

I haven't been testing on Power machines a lot so I don't know, it's
possible that the success rate hitting that would be similar as on
x86_64.

> >> In fact, I haven't really seen any case like this, and it doesn't really
> >> make sense for me to make some MM layer code to mark a page dirty
> >> without going through set_page_dirty() interface.
> > 
> > On s390 it's quick because the page state bits are stored in 2 places
> > and need to be synced. On x86_64 it's very unclear and low level arch
> > specific MM stuff but it is still a problem.
> 
> The hard to hit part is really harming our test coverage...

I don't disagree with that.
