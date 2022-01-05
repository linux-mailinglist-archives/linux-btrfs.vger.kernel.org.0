Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C15485866
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 19:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242979AbiAESdQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 13:33:16 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58268 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243023AbiAESdD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jan 2022 13:33:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80574B81D1B
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jan 2022 18:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48CBC36AE9;
        Wed,  5 Jan 2022 18:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641407578;
        bh=4yoeHxjqVVSTAWfH1ND77MrilypIRBx5wrHBQy5cjdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dpFXU+SMTEN7REVSOZlbjK3rdHK1/TJkooYSp80pdPVex2qbvSzBkPZOGEjj8oPNv
         /bVvpHmO+BjuITKglDfU18WNTzIXBsjYcMobSxAZhRDyrVZo72VIExbfz1lXbt/M3p
         HCGmDiv2sgsywhF3dcxahTw6PvbxMfSysxaBu3qlDYFeuZRxwB+c0h+fFmmXOQmtwe
         bhkj6Po+D6CaShO31iv1e7n928KL1EL0eDLmbVCW6JiY9Qpujzr8rJuA74uKaeUlRd
         FMHFJM2Axup01EL2sZDcsqgoVjG69xXIVyVcRA6ouzQCU/1zuE2bzGO2VLeOuKuuD3
         d5Dkho0q4Hz/g==
Date:   Wed, 5 Jan 2022 18:32:54 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [bug] GNOME loses all settings following failure to resume from
 suspend
Message-ID: <YdXkVnh+QLbZI5oI@debian9.Home>
References: <CAJCQCtRnyUHEwV1o9k565B_u_RwQ2OQqdXHtcfa-LWAbUSB7Gg@mail.gmail.com>
 <YdXdtrHb9nTYgFo7@debian9.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdXdtrHb9nTYgFo7@debian9.Home>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 05, 2022 at 06:04:38PM +0000, Filipe Manana wrote:
> On Wed, Jan 05, 2022 at 10:34:10AM -0700, Chris Murphy wrote:
> > https://gitlab.gnome.org/GNOME/dconf/-/issues/73
> > 
> > Following a crash, instead of either the old or new dconf database
> > file being present, a corrupt one is present.
> > 
> > dconf uses g_file_set_contents() to atomically update the database
> > file, which effectively inhibits (one or more?) fsync's, yet somehow
> > in the crash/powerfail case this is resulting in a corrupt dconf
> > database. I don't know if by "corrupt" this is a 0 length file or some
> > other effect.
> 
> Looking at the issue, Sebastian Keller posted a patch to disable one
> optimization in glib, that should fix it.
> 
> Looking at the code before that patch, it explicitly skips fsync after
> a rename pointing out to:
> 
> https://btrfs.wiki.kernel.org/index.php/FAQ#What_are_the_crash_guarantees_of_overwrite-by-rename.3F
> 
> I'm afraid that information is wrong, perhaps it might have been true in
> some very distant past, but certainly not for many years.

After some digging in git history:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8d875f95da43c6a8f18f77869f2ef26e9594fecc

So that guarantee existed until August 2014.

Not anymore, and no one should rely on it (except when using "-o flushoncommit").

> 
> The wiki says, doing something like this:
> 
>    echo "oldcontent" > file
> 
>    # make sure oldcontent is on disk
>    sync
> 
>    echo "newcontent" > file.tmp
>    mv -f file.tmp file
> 
>    # *crash*
> 
> Will give either:
> 
> file contains "newcontent"; file.tmp does not exist
> file contains "oldcontent"; file.tmp may contain "newcontent", be zero-length or not exists at all.
> 
> However that's not true, there's a chance 'file' will be empty.
> 
> During a rename with overwrite we trigger writeback (via filemap_flush())
> of the file being renamed but never wait for it to complete before
> returning to user space. So what can happen is:
> 
> 1) We trigger writeback;
> 
> 2) We join the current transaction and do the rename;
> 
> 3) We return from rename to user space with success (0);
> 
> 4) Writeback didn't finish yet, or it has finished but the
>    ordered extent is not yet complete - i.e. btrfs_finish_ordered_io()
>    did not complete yet;
> 
> 5) The transaction used by the rename is committed;
>    A transaction commit does not wait for any writeback or in flight
>    ordered extents to complete - except if the fs is mounted with
>    "-o flushoncommit";
> 
> 6) Crash
> 
> After mounting the fs again 'file' is empty and 'file.tmp' does not exists.
> 
> The only for that to guarantee 'file' is not empty and has the expected
> data ("newcontent"), would be to mount with -o flushoncommit.
> 
> I don't think I have a wiki account enabled, but I'll see if I get that
> updated soon.
> 
> Thanks.
> 
> > 
> > Thanks,
> > 
> > -- 
> > Chris Murphy
