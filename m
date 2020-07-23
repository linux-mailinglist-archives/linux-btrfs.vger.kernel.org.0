Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5D122B8FB
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jul 2020 23:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGWVyd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jul 2020 17:54:33 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48248 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgGWVyd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jul 2020 17:54:33 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 4072E77BA3C; Thu, 23 Jul 2020 17:54:31 -0400 (EDT)
Date:   Thu, 23 Jul 2020 17:54:30 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: balance root leak and runaway balance fix
Message-ID: <20200723215430.GC5890@hungrycats.org>
References: <20200520065851.12689-1-wqu@suse.com>
 <20200522111347.GJ18421@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522111347.GJ18421@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 22, 2020 at 01:13:47PM +0200, David Sterba wrote:
> On Wed, May 20, 2020 at 02:58:49PM +0800, Qu Wenruo wrote:
> > This patchset will fix the most wanted balance bug, runaway balance.
> > All my fault, and all small fixes.
> 
> Well, that happens.
> 
> d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots")
> 
> is the most broken patch in recent history (5.1+), there were so many
> fixups but hopefully this is the last one. I've tagged the patches for
> 5.1+ stable but we'll need manual backports due to the root refcount
> changes in 5.7.

The patch 1dae7e0e58b4 "btrfs: reloc: clear DEAD_RELOC_TREE bit for
orphan roots to prevent runaway balance" does apply to 5.7 itself, but
it is not present in 5.7.10.  I've been running it in test (and even a
few pre-prod) systems since May.

We still get someone in IRC with a runaway balance every week or so.
Currently we can only tell them to wait for 5.8, or roll all the way
back to 4.19.

> I reproduced the umount crash and verified the fix, the runaway balance
> does not happen anymore in the test so I guess we have all the needed
> fixes in place to allow the fast balance cancel. Thanks.
