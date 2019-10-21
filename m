Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE47DF090
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 16:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfJUOzt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 10:55:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:51082 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727111AbfJUOzt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 10:55:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 95859B129;
        Mon, 21 Oct 2019 14:55:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BBEFEDA905; Mon, 21 Oct 2019 16:55:54 +0200 (CEST)
Date:   Mon, 21 Oct 2019 16:55:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PULL REQUEST] btrfs-progs: For next merge window
Message-ID: <20191021145554.GM3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191010085932.39105-1-wqu@suse.com>
 <20191010161757.GV2751@twin.jikos.cz>
 <64097cbe-4c2d-2c90-f64f-b4dad84f87ed@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64097cbe-4c2d-2c90-f64f-b4dad84f87ed@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 11, 2019 at 10:07:16AM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/10/11 上午12:17, David Sterba wrote:
> > On Thu, Oct 10, 2019 at 04:59:32PM +0800, Qu Wenruo wrote:
> >> This patchset can be fetched from github:
> >> https://github.com/adam900710/btrfs-progs/tree/for_next
> >> Which is based on devel branch, with the following HEAD:
> > 
> > Thanks for putting the branch together, I've been too busy with kernel
> > work so progs are lagging behind constantly.
> > 
> > The current devel branch is almost ready for a release, some patches
> > will be moved to 5.4 but I'm planning to do release by tomorrow. I can
> > pull your branch as-is to 5.4 so we have time to fix any problems.
> 
> No problem at all.
> Since I don't expect this pull get merged in the next release either.

I had to rebase the branch, all patches from you (image, check) are now
in devel. I did some fixups (error messages, coding style, changelogs)
on the way.

Next will be the patchset from Omar. The fix from Johanness regarding
zstd needs to be reworked so I'll drop it for now.
