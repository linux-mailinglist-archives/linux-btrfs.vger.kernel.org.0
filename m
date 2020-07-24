Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122B922C25A
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jul 2020 11:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgGXJdy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jul 2020 05:33:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:50596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgGXJdy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jul 2020 05:33:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CE107AC90;
        Fri, 24 Jul 2020 09:34:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5FE53DA791; Fri, 24 Jul 2020 11:33:26 +0200 (CEST)
Date:   Fri, 24 Jul 2020 11:33:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: balance root leak and runaway balance fix
Message-ID: <20200724093326.GF3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200520065851.12689-1-wqu@suse.com>
 <20200522111347.GJ18421@twin.jikos.cz>
 <20200723215430.GC5890@hungrycats.org>
 <faeff4c1-c675-a956-6ae9-c3e742df013c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <faeff4c1-c675-a956-6ae9-c3e742df013c@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 24, 2020 at 08:05:16AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/7/24 上午5:54, Zygo Blaxell wrote:
> > On Fri, May 22, 2020 at 01:13:47PM +0200, David Sterba wrote:
> >> On Wed, May 20, 2020 at 02:58:49PM +0800, Qu Wenruo wrote:
> >>> This patchset will fix the most wanted balance bug, runaway balance.
> >>> All my fault, and all small fixes.
> >>
> >> Well, that happens.
> >>
> >> d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots")
> >>
> >> is the most broken patch in recent history (5.1+), there were so many
> >> fixups but hopefully this is the last one. I've tagged the patches for
> >> 5.1+ stable but we'll need manual backports due to the root refcount
> >> changes in 5.7.
> > 
> > The patch 1dae7e0e58b4 "btrfs: reloc: clear DEAD_RELOC_TREE bit for
> > orphan roots to prevent runaway balance" does apply to 5.7 itself, but
> > it is not present in 5.7.10.  I've been running it in test (and even a
> > few pre-prod) systems since May.
> 
> Strange, I see no mail about merge failure nor merge success.
> 
> I'll send the backport manually to all older branches.
> 
> BTW, what's the proper tag for stable branch ranges?

For inspiration look at subjects at https://lore.kernel.org/stable/ ,
something like, the version needs to be visible without looking to the
patch.

"[PATCH for 5.4] btrfs: ...."

You can send it as a thread with various versions in case the patches
differ, or use [PATCH for 5.4+].
