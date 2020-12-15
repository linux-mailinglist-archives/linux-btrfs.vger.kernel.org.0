Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47B92DB309
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Dec 2020 18:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbgLORxC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Dec 2020 12:53:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:50914 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730046AbgLORw4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Dec 2020 12:52:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5A187AC7F;
        Tue, 15 Dec 2020 17:52:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 44754DA7C3; Tue, 15 Dec 2020 18:50:35 +0100 (CET)
Date:   Tue, 15 Dec 2020 18:50:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v7 01/12] btrfs: lift rw mount setup from mount and
 remount
Message-ID: <20201215175035.GA6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1605736355.git.boris@bur.io>
 <ac259f3ceafae5a8bb9b6c554375588705aa55b2.1605736355.git.boris@bur.io>
 <20201123165704.GG8669@twin.jikos.cz>
 <20201201000138.GB3661143@devbig008.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201000138.GB3661143@devbig008.ftw2.facebook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 30, 2020 at 04:01:38PM -0800, Boris Burkov wrote:
> On Mon, Nov 23, 2020 at 05:57:04PM +0100, David Sterba wrote:
> > On Wed, Nov 18, 2020 at 03:06:16PM -0800, Boris Burkov wrote:
> > > +/*
> > > + * Mounting logic specific to read-write file systems. Shared by open_ctree
> > > + * and btrfs_remount when remounting from read-only to read-write.
> > > + */
> > > +int btrfs_mount_rw(struct btrfs_fs_info *fs_info)
> > 
> > The function could be named better, to reflect that it's starting some
> > operations prior to the rw mount. As its now it would read as "mount the
> > filesystem as read-write", we already have 'btrfs_mount' as callback for
> > mount.
> > 
> > As this is a cosmetic fix it's not blocking the patchset but I'd like to
> > have that fixed for the final version. I don't have a suggestion for
> > now.
> 
> I agree, the name implies a function which does a rw mount end to end.
> 
> Some alternative ideas:
> btrfs_prepare_rw_mount
> btrfs_setup_rw_mount
> btrfs_handle_rw_mount
> btrfs_process_rw_mount
> 
> I think I personally like 'prepare' the most out of those.

I had not noticed your reply when I committed the patch, the function is
btrfs_start_pre_rw_mount. btrfs_prepare_rw_mount would be also good, we
can rename it eventually if it needed.
