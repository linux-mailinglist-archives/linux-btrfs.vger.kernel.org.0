Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B4B29601B
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Oct 2020 15:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444006AbgJVNhd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Oct 2020 09:37:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:55040 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgJVNha (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Oct 2020 09:37:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9DBD2AC2F;
        Thu, 22 Oct 2020 13:37:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CC434DA7C5; Thu, 22 Oct 2020 15:35:56 +0200 (CEST)
Date:   Thu, 22 Oct 2020 15:35:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: space-info: fix the wrong trace name for
 bytes_may_use
Message-ID: <20201022133556.GH6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201012065624.80649-1-wqu@suse.com>
 <20201014114414.GK6756@twin.jikos.cz>
 <d19621c2-2a8c-2676-f848-3c341af3e413@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d19621c2-2a8c-2676-f848-3c341af3e413@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 14, 2020 at 07:59:07PM +0800, Qu Wenruo wrote:
> On 2020/10/14 下午7:44, David Sterba wrote:
> > On Mon, Oct 12, 2020 at 02:56:24PM +0800, Qu Wenruo wrote:
> >> The trace_name for bytes_may_use should be "may_use", "space_info".
> >>
> >> Fixes: f3e75e3805e1 ("btrfs: roll tracepoint into btrfs_space_info_update helper")
> > 
> > This patch reduced all calls to the definition and kept the same output,
> > ie. the 'space_info' so it was correct and the Fixes does not seem to be
> > right here. You should explain why the 'may_use' is supposed to be
> > there.
> > 
> The next bytes_pinned still uses "pinned" for its name.
> 
> And in the DECLARE_SPACE_INFO_UPDATE(), the @trace_name is only passed
> to trcae_btrfs_space_reservation(), to indicate the cause of the trace
> event.
> 
> Under most case, we pass things like "space_info:enospc" for cases we
> will going to return -ENOSPC, and for other cases, we pass what we're
> reserving for, like in btrfs_delalloc_reserve_metadata().
> 
> For the bytes_may_use case, the DECLARE_SPACE_INFO_UPDATE() is
> definitely not called for ENOSPC, thus it should what we're reserving for.
> Since the declared function has no real context, thus using the
> "may_use" looks completely sane to me.
> 
> The fixes looks correct, as it looks like a copy-n-paste error from that
> commit.

The commit dropped the trace_ call and moved it to the update function,
so the string "space_info" made it to
btrfs_space_info_update_bytes_may_use.

                btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
                                                      -num_bytes);
-               trace_btrfs_space_reservation(fs_info, "space_info",
-                                     sinfo->flags, num_bytes, 0);

so there was no copy&paste error.

What I am missing is changelog rationale behind the change from
space_info to may_use. If 'may_use' should do the same as 'pinned', then
please explain it or give hints how to verify that the change is
correct.

  'The trace_name for bytes_may_use should be "may_use", "space_info".'

just begs to ask "why?".
