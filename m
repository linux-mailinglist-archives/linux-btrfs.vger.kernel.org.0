Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D628436FCBD
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 16:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhD3OqH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Apr 2021 10:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233597AbhD3Opl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84C4B613EE;
        Fri, 30 Apr 2021 14:44:47 +0000 (UTC)
Date:   Fri, 30 Apr 2021 16:44:44 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: Supporting idmapped mounts
Message-ID: <20210430144444.h4snmnfhry5ymhr5@wittgenstein>
References: <20210430132517.ef7gvr7e5n5wdn33@wittgenstein>
 <20210430134322.GD7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210430134322.GD7604@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 30, 2021 at 03:43:22PM +0200, David Sterba wrote:
> On Fri, Apr 30, 2021 at 03:25:17PM +0200, Christian Brauner wrote:
> > Hey everyone,
> > 
> > Userspace seems to already be catching up with idmapped mount support.
> > Systemd has started making use of it in their container manager and is
> > in the process of expanding useage throughout their codebase (cf. [1]).
> > One of the first requests obviously was "When can we get btrfs"? So I
> > was thinking about starting to work on patches for btrfs to support
> > them. Would you be interested in this if we implement it?
> 
> Yes of course, for feature parity.

Cool, good to hear.

> 
> > I'm preparing
> > the necessary vfs changes currently. I already added a comprehensive
> > generic test-suite to xfstests which would then also cover btrfs as
> > well.
> 
> Great, thanks.  Does it needs vfs changes or is it just updating the
> btrfs callbacks to pass the right namespace?

It needs one vfs change. Btrf uses lookup_one_len() in ioctl.c and these
lookup helpers call inode_permission() which wants to be passed
mnt_userns so I need to expand lookup_one_len() to take a mnt_userns
argument. That's ok though because I don't just need this for btrfs it's
also required for overlayfs and some other fses. I've already done that
work once when I did a POC for overlayfs support that uses those
lookup-helpers all over the place.
I'll send a patch for that soon and if Christoph is happy with it and Al
doesn't kill me I'll carry it for v5.14 and I'll send you patches that
are based on that branch. We are in no hurry of course.

Christian
