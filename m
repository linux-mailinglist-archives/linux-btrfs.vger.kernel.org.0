Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6401F351BC7
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Apr 2021 20:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbhDASLC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 14:11:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:42004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237275AbhDASDi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Apr 2021 14:03:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7C359B178;
        Thu,  1 Apr 2021 15:34:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 21897DA790; Thu,  1 Apr 2021 17:32:19 +0200 (CEST)
Date:   Thu, 1 Apr 2021 17:32:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     dsterba@suse.cz, linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: make reflinks respect O_SYNC O_DSYNC and S_SYNC
 flags
Message-ID: <20210401153218.GX7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <dd702a279373c3b6babdf0d7a69c929e9924bb33.1616523672.git.fdmanana@suse.com>
 <20210329184651.GU7604@twin.jikos.cz>
 <CAL3q7H4fxAsmY9a0QtWGRu1Si6oUgnazctSn=HzjmBvxr0R2zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4fxAsmY9a0QtWGRu1Si6oUgnazctSn=HzjmBvxr0R2zw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 31, 2021 at 11:07:26AM +0000, Filipe Manana wrote:
> On Mon, Mar 29, 2021 at 7:49 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Tue, Mar 23, 2021 at 06:39:49PM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > If we reflink to or from a file opened with O_SYNC/O_DSYNC or to/from a
> > > file that has the S_SYNC attribute set, we totally ignore that and do not
> > > durably persist the reflink changes. Since a reflink can change the data
> > > readable from a file (and mtime/ctime, or a file size), it makes sense to
> > > durably persist (fsync) the source and destination files/ranges.
> > >
> > > This was previously discussed at:
> > >
> > > https://lore.kernel.org/linux-btrfs/20200903035225.GJ6090@magnolia/
> > >
> > > The recently introduced test case generic/628, from fstests, exercises
> > > these scenarios and currently fails without this change.
> > >
> > > So make sure we fsync the source and destination files/ranges when either
> > > of them was opened with O_SYNC/O_DSYNC or has the S_SYNC attribute set,
> > > just like XFS already does.
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >
> > Added to misc-next, thanks.
> 
> Can you squash the following diff into it?
> 
> https://pastebin.com/raw/ARSSDDxd

Squashed in, thanks.
