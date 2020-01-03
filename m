Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0B212F9B8
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 16:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgACP1a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 10:27:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:46418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbgACP13 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jan 2020 10:27:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 457E7AF4E;
        Fri,  3 Jan 2020 15:27:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 140C0DA795; Fri,  3 Jan 2020 16:27:20 +0100 (CET)
Date:   Fri, 3 Jan 2020 16:27:19 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] btrfs-progs: Fixes for github issues
Message-ID: <20200103152719.GZ3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191218011942.9830-1-wqu@suse.com>
 <20200102171056.GM3929@twin.jikos.cz>
 <e8398282-264a-3ef7-43d5-63f1ac0c7c19@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8398282-264a-3ef7-43d5-63f1ac0c7c19@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 03, 2020 at 08:43:01AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/1/3 上午1:10, David Sterba wrote:
> > On Wed, Dec 18, 2019 at 09:19:36AM +0800, Qu Wenruo wrote:
> >> There are a new batch of fuzzed images for btrfs-progs. They are all
> >> reported by Ruud van Asseldonk from github.
> >>
> >> Patch 1 will make QA life easier by remove the extra 300s wait time.
> >> Patch 2~5 are all the meat for the fuzzed images.
> >>
> >> Just a kind reminder, mkfs/020 test will fail due to tons of problems:
> >> - Undefined $csum variable
> >> - Undefined $dev1 variable
> > 
> > These are fixed in devel now.
> > 
> >> - Bad kernel probe for support csum
> >>   E.g. if Blake2 not compiled, it still shows up in supported csum algo,
> >>   but will fail to mount.
> > 
> > The list of supported is from the point of view of the filesystem.
> > Providing the module is up to the user.
> 
> IIRC, doing such probe at btrfs module load time would be more user
> friendly though.

I don't understand how you think this could be improved. The list of
algorithms is provided by the filesystem, the implementations are
provided by the crypto subsystem (either compiled in or as modules). Two
different things.

So you mean that at btrfs module load time, all hash algorithms are
probed? What if some of them gets unloaded, or loaded later (so modprobe
won't see it at btrfs load time). This would require keeping the state
up to date and this is out of scope what filesystem should do.
