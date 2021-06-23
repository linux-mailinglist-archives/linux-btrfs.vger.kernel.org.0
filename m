Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589163B226F
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 23:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFWV2d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 17:28:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54556 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWV23 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 17:28:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A8B6E1FD36;
        Wed, 23 Jun 2021 21:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624483570;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xF9U4HtLorbrXTXyJnA73AZXXDsYfax9dB+kqGLGDwk=;
        b=xBb5j0oHefYZUFLel6nOYbV9sJQ8gYLUpeQsVV+6uVBX7oMucGnZk4ZSh4S9m+glBpIgUO
        BEy98xJ5BH2xji331NvUo18F6/ar9eoNcKonFcXLjTv8fKsIC5imv8Yz8TU6g+EXaf5J20
        zu6Y2HtA5ccw7FZXVNtgrMXBuhHBuG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624483570;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xF9U4HtLorbrXTXyJnA73AZXXDsYfax9dB+kqGLGDwk=;
        b=ZAnQevRn6vUoevr+IeHoLC5iLGualh8TSRPPiURfY3NRmbzkgGQY03fQJ4n9bEvQtH11DA
        53iTh1nyvRiq1UAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9D7E4A3B83;
        Wed, 23 Jun 2021 21:26:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3ECB7DA908; Wed, 23 Jun 2021 23:23:19 +0200 (CEST)
Date:   Wed, 23 Jun 2021 23:23:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/8] btrfs: experimental compression support for
 subpage
Message-ID: <20210623212319.GP28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210623055529.166678-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623055529.166678-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 23, 2021 at 01:55:21PM +0800, Qu Wenruo wrote:
> This patchset is based on my previously submitted compression refactor,
> which is further based on subpage patchset.
> 
> It can be fetched from the following repo:
> https://github.com/adam900710/linux/tree/compression
> 
> It only has been lightly tested, no stress test/full fstests run yet.
> The reason for such a unstable patchset is to get feedback on how to
> continue the development, aka the feedback for the last patch.
> 
> The first 7 patches are mostly cleanups to make compression path to be
> more subpage compatible.
> 
> The RFC is for the last patch, which will enable subpage compression in
> a pretty controversial way.
> 
> The reason is copied from that patch:
> 
> ```
> This mechanism allows btrfs to continue handling next ranges, without
> waiting for the time consuming compression.
> 
> But this has a problem for subpage case, as we could have the following
> delalloc range for a page:
> 
> 0		32K		64K
> |	|///////|	|///////|
> 		\- A		\- B
> 
> In above case, if we pass both range to cow_file_range_async(), both
> range A and range B will try to unlock the full page [0, 64K).
> 
> And which finishes later than the other range will try to do other page
> operatioins like end_page_writeback() on a unlocked page, triggering VM
> layer BUG_ON().
> 
> Currently I don't have any perfect solution to this, but two
> workarounds:
> 
> - Only allow compression for fully page aligned range
> 
>   This is what I did in this patch.
>   By this, the compressed range can exclusively lock the first page
>   (and other pages), so they are completely safe to do whatever they
>   want.
>   The problem is, we will not compress a lot of small writes.
>   This is especially problematic as our target page size is 64K, not
>   a small size.
> 
> - Make cow_file_range_async() to behave like cow_file_range() for
>   subpage
> 
>   This needs several behavier change, and are all subpage specific:
>   * Skip the first page of the range when finished
>     Just like cow_file_range()
>   * Have a way to wait for the async_cow to finish before handling the
>     next delalloc range
> 
>   The biggest problem here is the performance impact.
>   Although by this we can compress all sector aligned ranges, we will
>   waste time waiting for the async_cow to finish.
>   This is completely denying the meaning of "async" part.
>   Now to mention there are tons of code needs to be changed.
> 
> Thus I choose the current way to only compress ranges which is fully
> page aligned.
> The cost is we will skip a lot of small writes for 64K page size.
> ```
> 
> Any feedback on this part would be pretty helpful.

As another step, progressing towards full subpage support I think that
the limiting compression to the full 64k page is acceptable. Better than
nothing and without intrusive changes described above.

There still might be some odd case even with the whole page, I'm not
sure how exactly it would work with 4k/64k but there are some checks
inside compression anyway if the size is getting smaller and then
bailing out uncompressed anyway. So in general fallback to uncompressed
data happens already.
