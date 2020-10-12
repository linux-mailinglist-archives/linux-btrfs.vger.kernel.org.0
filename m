Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF9928C4E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Oct 2020 00:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389095AbgJLWvB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Oct 2020 18:51:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:36172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730613AbgJLWvB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Oct 2020 18:51:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 75D43AC84;
        Mon, 12 Oct 2020 22:50:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 49C04DA7C3; Tue, 13 Oct 2020 00:49:33 +0200 (CEST)
Date:   Tue, 13 Oct 2020 00:49:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     dsterba@suse.cz, Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: btrfs-progs and libbtrfsutil versioning
Message-ID: <20201012224932.GB6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <CAEg-Je-VLz9zZOKEVa+x0V+dpyojtRcjBw7maO73zpmowdOyTQ@mail.gmail.com>
 <20201002171824.GY6756@twin.jikos.cz>
 <CAEg-Je_xvLhuB_UokkX-FYTf3aQcs3q4ewUjuFE4RS3Snc_oTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEg-Je_xvLhuB_UokkX-FYTf3aQcs3q4ewUjuFE4RS3Snc_oTQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 02, 2020 at 04:56:24PM -0400, Neal Gompa wrote:
> On Fri, Oct 2, 2020 at 1:19 PM David Sterba <dsterba@suse.cz> wrote:
> > On Wed, Sep 23, 2020 at 09:48:44PM -0400, Neal Gompa wrote:
> > > If not, is there a reason that we
> > > *can't* synchronize the versions across btrfs-progs, libbtrfs, and
> > > libbtrfsutil? We could still make sure that the library sonames are
> > > versioned properly, but having the user-facing versions actually sync
> > > up makes life a lot easier...
> >
> > I'm a bit lost in which versions are not in sync. The shared library
> > version is an ABI and that changes only when new symbols appear. The
> > whole project release versions follow the kernel scheme. So what are you
> > suggesting? Eg. that libbtrfsutil should not be 5.9 but follow the
> > soname version which is 1.2.0?
> 
> No, I'm suggesting the other way around. The libbtrfsutil "public
> version" (that is, not the ABI version) would be synchronized with the
> kernel version like the rest of btrfs-progs. Right now it's not,
> evidenced by python-btrfsutil giving me 1.2.0 instead of 5.9.

Oh, so this sounds easier than I thought. If the "main" verions is
derived from progs, then it's just the python-btrfsutil that needs to be
fixed:

libbtrfsutil/python/setup.py:

 28 def get_version():
 29     with open('../btrfsutil.h', 'r') as f:
 30         btrfsutil_h = f.read()
 31     major = re.search(r'^#define BTRFS_UTIL_VERSION_MAJOR ([0-9]+)$',
 32                       btrfsutil_h, flags=re.MULTILINE).group(1)
 33     minor = re.search(r'^#define BTRFS_UTIL_VERSION_MINOR ([0-9]+)$',
 34                       btrfsutil_h, flags=re.MULTILINE).group(1)
 35     patch = re.search(r'^#define BTRFS_UTIL_VERSION_PATCH ([0-9]+)$',
 36                       btrfsutil_h, flags=re.MULTILINE).group(1)
 37     return major + '.' + minor + '.' + patch

IOW, the python package version is derived from the library .so version.

> Basically, I want to add pkgconfig files and fix the version emitted
> by the Python metadata to use the project version rather than whatever
> soname version is used. The soname version would still be preserved
> and work as a way to track the ABI changes, but everything that reads
> metadata would get the btrfs-progs parent version consistently.

And with something using the VERSION file instead it should do what you
expect, right?
