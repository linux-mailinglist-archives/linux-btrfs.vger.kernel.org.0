Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1067C292D9C
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Oct 2020 20:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbgJSSeP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Oct 2020 14:34:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:56486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730704AbgJSSeP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Oct 2020 14:34:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1AA00AB95;
        Mon, 19 Oct 2020 18:34:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3C9FBDA8EA; Mon, 19 Oct 2020 20:32:43 +0200 (CEST)
Date:   Mon, 19 Oct 2020 20:32:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     dsterba@suse.cz, Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: btrfs-progs and libbtrfsutil versioning
Message-ID: <20201019183242.GY6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <CAEg-Je-VLz9zZOKEVa+x0V+dpyojtRcjBw7maO73zpmowdOyTQ@mail.gmail.com>
 <20201002171824.GY6756@twin.jikos.cz>
 <CAEg-Je_xvLhuB_UokkX-FYTf3aQcs3q4ewUjuFE4RS3Snc_oTQ@mail.gmail.com>
 <20201012224932.GB6756@twin.jikos.cz>
 <CAEg-Je_o5qbPBFL-2VsG3Ekm2NQO7jSgsdTpSzeHE0em8sB37w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEg-Je_o5qbPBFL-2VsG3Ekm2NQO7jSgsdTpSzeHE0em8sB37w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 12, 2020 at 08:16:36PM -0400, Neal Gompa wrote:
> On Mon, Oct 12, 2020 at 6:51 PM David Sterba <dsterba@suse.cz> wrote:
> > On Fri, Oct 02, 2020 at 04:56:24PM -0400, Neal Gompa wrote:
> > > On Fri, Oct 2, 2020 at 1:19 PM David Sterba <dsterba@suse.cz> wrote:
> > > > On Wed, Sep 23, 2020 at 09:48:44PM -0400, Neal Gompa wrote:
> >  33     minor = re.search(r'^#define BTRFS_UTIL_VERSION_MINOR ([0-9]+)$',
> >  34                       btrfsutil_h, flags=re.MULTILINE).group(1)
> >  35     patch = re.search(r'^#define BTRFS_UTIL_VERSION_PATCH ([0-9]+)$',
> >  36                       btrfsutil_h, flags=re.MULTILINE).group(1)
> >  37     return major + '.' + minor + '.' + patch
> >
> > IOW, the python package version is derived from the library .so version.
> >
> > > Basically, I want to add pkgconfig files and fix the version emitted
> > > by the Python metadata to use the project version rather than whatever
> > > soname version is used. The soname version would still be preserved
> > > and work as a way to track the ABI changes, but everything that reads
> > > metadata would get the btrfs-progs parent version consistently.
> >
> > And with something using the VERSION file instead it should do what you
> > expect, right?
> 
> Yeah, basically! This issue blocks me from enabling the Python
> bindings because version updates get weird and confusing...

So the python will now follow the package version. One thing I'm not
sure about is the pkg-config .pc file for libbtrfsutil: is the Version:
supposed to be the library ABI or the main package as well? Right now
it's the ABI.
