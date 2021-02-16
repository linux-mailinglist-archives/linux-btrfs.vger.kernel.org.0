Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C9C31CBD7
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 15:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhBPO0L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 09:26:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:34894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhBPO0C (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 09:26:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 165A0AC69;
        Tue, 16 Feb 2021 14:25:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C7010DA6EF; Tue, 16 Feb 2021 15:23:24 +0100 (CET)
Date:   Tue, 16 Feb 2021 15:23:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Wang Yugui <wangyugui@e16-tech.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 5.10.x] btrfs: fix crash after non-aligned direct IO
 write with O_DSYNC
Message-ID: <20210216142324.GO1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        Wang Yugui <wangyugui@e16-tech.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <94663c8a2172dc96b760d356a538d45c36f46040.1613062764.git.fdmanana@suse.com>
 <20210213090416.926A.409509F4@e16-tech.com>
 <CAL3q7H45VddXz+OVcFG8uDM2WJJsdCn0VuTVfJAb28HzU78J6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H45VddXz+OVcFG8uDM2WJJsdCn0VuTVfJAb28HzU78J6w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 15, 2021 at 11:05:33AM +0000, Filipe Manana wrote:
> On Sat, Feb 13, 2021 at 1:07 AM Wang Yugui <wangyugui@e16-tech.com> wrote:
> > > This bug only affects 5.10 kernels, and the regression was introduced in
> > > 5.10-rc1 by commit 0eb79294dbe328 ("btrfs: dio iomap DSYNC workaround").
> > > The bug does not exist in 5.11 kernels due to commit ecfdc08b8cc65d
> > > ("btrfs: remove dio iomap DSYNC workaround"), which depends on other
> > > changes that went into the merge window for 5.11. So this is a fix only
> > > for 5.10.x stable kernels, as there are people hitting this.
> >
> > It is OK too to backport commit ecfdc08b8cc65d
> >  ("btrfs: remove dio iomap DSYNC workaround") to 5.10 for this problem?
> >
> > the iomap issue for commit 0eb79294dbe328 ("btrfs: dio iomap DSYNC workaround")
> > is already fixed in 5.10?
> 
> Quoting the changelog:
> 
> "commit ecfdc08b8cc65d
> ("btrfs: remove dio iomap DSYNC workaround"), which depends on other
> changes that went into the merge window for 5.11."
> 
> All the changes, are (at least):
> 
> commit ecfdc08b8cc65d737eebc26a1ee1875a097fd6a0   --> 5.11-rc1
> Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Date:   Thu Sep 24 11:39:21 2020 -0500
> 
>     btrfs: remove dio iomap DSYNC workaround
> 
> commit a42fa643169d2325602572633fcaa16862990e28
> Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Date:   Thu Sep 24 11:39:20 2020 -0500
> 
>     btrfs: call iomap_dio_complete() without inode_lock
> 
> commit 502756b380938022c848761837f8fa3976906aa1
> Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Date:   Thu Sep 24 11:39:19 2020 -0500
> 
>     btrfs: remove btrfs_inode::dio_sem
> 
> commit e9adabb9712ef9424cbbeeaa027d962ab5262e19
> Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Date:   Thu Sep 24 11:39:18 2020 -0500
> 
>     btrfs: use shared lock for direct writes within EOF
> 
> commit c352370633400d13765cc88080c969799ea51108
> Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Date:   Thu Sep 24 11:39:17 2020 -0500
> 
>     btrfs: push inode locking and unlocking into buffered/direct write
> 
> commit a14b78ad06aba0fa7e76d2bc13c5ba581a7f331a
> Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Date:   Thu Sep 24 11:39:16 2020 -0500
> 
>     btrfs: introduce btrfs_inode_lock()/unlock()
> 
> commit b8d8e1fd570a194904f545b135efc880d96a41a4
> Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Date:   Thu Sep 24 11:39:15 2020 -0500
> 
>     btrfs: introduce btrfs_write_check()
> 
> That's probably too much to add to stable at once, plus I'm assuming
> all required iomap dependencies are in 5.10 already (it seems so,
> unless I missed something).
> 
> Usually we don't add patches to stable that didn't go through Linus'
> tree either (there were 1 or 2 very rare exceptions in the past I
> think), but when a backport depends on so many patches, and not all
> from the same patchset, the risk of getting something wrong is
> significant. That's why I opted to send this patch, which is much more
> simple.

Agreed, in this case the backport would be too big, just the diffstat
between b8d8e1fd570^..ecfdc08b8cc6 is

 5 files changed, 213 insertions(+), 240 deletions(-)

This fix is minimal and suitable for stable as an exception. You did not
CC stable@vger.kernel.org so you'll need to send it again. Please CC me
too in case there are some questions from stable team. Thanks.
