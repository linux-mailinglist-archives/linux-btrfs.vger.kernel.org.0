Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C94DD1959D3
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Mar 2020 16:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgC0P2P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Mar 2020 11:28:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:58690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbgC0P2P (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Mar 2020 11:28:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5E68FAE38;
        Fri, 27 Mar 2020 15:28:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 94F65DA72D; Fri, 27 Mar 2020 16:27:41 +0100 (CET)
Date:   Fri, 27 Mar 2020 16:27:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] btrfs-progs: Fixes for valgrind errors during
 fsck-tests
Message-ID: <20200327152741.GN5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200324105315.136569-1-wqu@suse.com>
 <20200325144217.GD5920@twin.jikos.cz>
 <b4df0751-2d8d-43c1-5156-4f7eeab5807e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4df0751-2d8d-43c1-5156-4f7eeab5807e@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 26, 2020 at 08:59:16AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/3/25 下午10:42, David Sterba wrote:
> > On Tue, Mar 24, 2020 at 06:53:09PM +0800, Qu Wenruo wrote:
> >> This patchset can be fetched from github:
> >> https://github.com/adam900710/btrfs-progs/tree/valgrind_fixes
> >>
> >> Inspired by that long-existing-but-I-can't-reproduce v5.1 bug, I will
> >> never trust D=asan/D=uban anymore, and run valgrind on all fsck-tests.
> >>
> >> The patchset is the result from the latest valgrind runs.
> >>
> >> The first patch is to make "make INSTRUMENT=valgrind test-fsck" run
> >> smoothly without false alerts due to mount/umount failure with valgrind.
> > 
> > Thanks, that's great. In addition to that, all commands that use the
> > SUDO_HELPER/root_helper won't pass through valgrind. For maximum
> > coverage we might want to remove the helper from the subcommands of
> > 'btrfs'. From a quick scan I found a lot of them and I'm not sure that
> > all are required. There's a lot of copy&paste in the tests, so that
> > would have to be cleaned up, or we leave it as it is and run the whole
> > tests under root.
> 
> The root fix is, like what we did for lowmem mode, injecting valgrind to
> proper location.
> 
> Currently I take a shortcut to reuse current infrastructure, but the
> root fix would need to inject INSTRUMENT directly before
> "btrfs/mkfs.btrfs/btrfs-convert", so that sudo_helper won't be a problem.

That's a great idea. For some reason I thought that valgrind refused to
work under root but that's not true. Injecting the instrumentation only
to the tools built from git is exactly what we want.
