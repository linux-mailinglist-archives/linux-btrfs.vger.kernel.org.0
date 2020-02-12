Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9246315AB78
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 15:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgBLO55 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 09:57:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:36118 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbgBLO55 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 09:57:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 260B4AF23;
        Wed, 12 Feb 2020 14:57:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E6881DA8DB; Wed, 12 Feb 2020 15:57:40 +0100 (CET)
Date:   Wed, 12 Feb 2020 15:57:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     ethanwu <ethanwu@synology.com>, dsterba@suse.cz,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] btrfs: backref, only collect file extent items
 matching backref offset
Message-ID: <20200212145740.GK2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        ethanwu <ethanwu@synology.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
References: <20200207093818.23710-1-ethanwu@synology.com>
 <20200207093818.23710-2-ethanwu@synology.com>
 <0badf0be-d481-10fb-c23d-1b69b985e145@toxicpanda.com>
 <c0453c3eb7c9b4e56bd66dbe647c5f0a@synology.com>
 <20200210162927.GK2654@twin.jikos.cz>
 <5901b2be7358137e691b319cbad43111@synology.com>
 <aeb36a34-bc9c-8500-9f36-554729a078fc@gmx.com>
 <20200211182159.GD2902@twin.jikos.cz>
 <c3b0f59840b81f4dd440264fb4276d9f@synology.com>
 <8eeca7c0-8283-8cd6-2354-9eb9373c9bd3@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eeca7c0-8283-8cd6-2354-9eb9373c9bd3@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 12, 2020 at 08:11:56PM +0800, Qu Wenruo wrote:
> >>>
> >>> This looks like an existing bug, IIRC Zygo reported it before.
> >>>
> >>> Btrfs balance just randomly failed at data reloc tree.
> >>>
> >>> Thus I don't believe it's related to Ethan's patches.
> >>
> >> Ok, than the patches make it more likely to happen, which could mean
> >> that faster backref processing hits some race window. As there could be
> >> more we should first fix the bug you say Zygo reported.
> > 
> > I added a log to check if find_parent_nodes is ever called under
> > test btrfs/125. It turns out that btrfs/125 doesn't pass through the
> > function. What my patches do is all under find_parent_nodes.
> 
> Balance goes through its own backref cache, thus it doesn't utilize the
> path you're modifying.
> 
> So don't worry your patches look pretty good.
> 
> Furthermore, this csum mismatch is not related to backref walk, but the
> data csum and the data in data reloc tree, which are all created by balance.
> 
> So there is really no reason to block such good optimization.

I don't mean to block the patchset but when I test patchsets from 5
people and tests start to fail I need to know what's the cause and if
there's a fix in sight. So far the test failed 2 out of 2 (once the
branch itself and then with for-next), I can do more rounds but at this
point it's too reliable to reproduce so there is some connection.

Sometimes it looks like I blame the messenger and complaining under
patches that don't cause the bugs, but often I don't have anyting better
than new warnings between 2 test rounds. Once we have more eyes on the
problem we'll narrow it down and find the root cause.
