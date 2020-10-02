Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9768028190B
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 19:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbgJBRTr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Oct 2020 13:19:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:48504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBRTr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Oct 2020 13:19:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 84200AC8B;
        Fri,  2 Oct 2020 17:19:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A3E73DA781; Fri,  2 Oct 2020 19:18:24 +0200 (CEST)
Date:   Fri, 2 Oct 2020 19:18:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: btrfs-progs and libbtrfsutil versioning
Message-ID: <20201002171824.GY6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <CAEg-Je-VLz9zZOKEVa+x0V+dpyojtRcjBw7maO73zpmowdOyTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEg-Je-VLz9zZOKEVa+x0V+dpyojtRcjBw7maO73zpmowdOyTQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 23, 2020 at 09:48:44PM -0400, Neal Gompa wrote:
> I've been working on a set of patches to synchronize the version
> numbers across everything produced by btrfs-progs and add pkgconfig
> files to make it easier for software to consume the libraries, but as
> I worked through it, I started realizing that btrfs-progs actually has
> *two* distinctly separate projects in one package.

Yes, we ended up doing it like that as it makes development easier. The
util library is there for 3rd party tools to use but otherwise is's
internally used by btrfs-progs too. Synchronizing btrfs-progs
development that would need new interfaces from the util library would
require separate release and deployment.

> This is somewhat problematic since it makes properly representing that
> versioning in the packages I ship in Fedora rather difficult.
> 
> Would it be possible to consider splitting libbtrfsutil into its own
> project with its own releases?

There's probably not a hard reason why to have them both in one project,
but like it is now is saving my time spent on annoying tasks.

> If not, is there a reason that we
> *can't* synchronize the versions across btrfs-progs, libbtrfs, and
> libbtrfsutil? We could still make sure that the library sonames are
> versioned properly, but having the user-facing versions actually sync
> up makes life a lot easier...

I'm a bit lost in which versions are not in sync. The shared library
version is an ABI and that changes only when new symbols appear. The
whole project release versions follow the kernel scheme. So what are you
suggesting? Eg. that libbtrfsutil should not be 5.9 but follow the
soname version which is 1.2.0?

Can this be solved on the packaging side by 3 projects that are built
from the same sources but produce only a subset of all the built files?
This is slightly inefficient as you'd have 3 copies of btrfs-progs.tar
but otherwise it's one time job, comparted to me having to update and
deploy 2 projects just to progress with progs development?
