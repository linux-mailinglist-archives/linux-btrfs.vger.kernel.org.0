Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF753DB267
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 18:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406579AbfJQQct (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 12:32:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:60168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730640AbfJQQct (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 12:32:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2C93CB58B;
        Thu, 17 Oct 2019 16:32:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2947CDA808; Thu, 17 Oct 2019 18:32:56 +0200 (CEST)
Date:   Thu, 17 Oct 2019 18:32:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: drop unique uuid test for btrfstune -M
Message-ID: <20191017163252.GL2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190906005025.2678-1-anand.jain@oracle.com>
 <f3d33e1d-803e-34a5-4dfa-7eeceec6177c@suse.com>
 <232bccd3-3623-8ee9-18db-98edf7cd2e25@oracle.com>
 <673ba386-debc-96e9-311e-4c3c0abd89d0@suse.com>
 <41b5b682-e67f-40d6-93cb-75e4889a4b06@oracle.com>
 <20190911170139.GH2850@twin.jikos.cz>
 <1cd24402-40dd-86f0-ac47-91cad78ef5fe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cd24402-40dd-86f0-ac47-91cad78ef5fe@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 12, 2019 at 08:45:50AM +0800, Anand Jain wrote:
> In case of vm guest images copied from the golden image there is no
> physical device or loop device or nbd device until its configured on
> the host when required, so check for duplicate fsid at the time of
> btrfstune -M is not convincing or a very limited approach.
> 
> >> - As I said before, its a genuine use-case here where the user wants to
> >>     revert the fsid change, so that btrfs fs root image can be booted.
> >>     Its up-to the user if fsid is duplicate in the user space, as btrfs
> >>     kernel rightly fails the mount if its duplicate fsid anyways.
> > 
> > Reverting the uuid is fine 
> 
> ok thanks.
> 
> > and requiring the uuids to be unique is
> > preventing the users doing stupid things unknowingly.
> 
> Right it should be done. But..
> btrfstune -M is a wrong place.

No it's not, it's exactly the right place because that's the moment when
user is doing an action that has consequences and if there's room for
mistakes, it should not be too easy. If the usecase is valid, it should
be possible though.

> Because it can't avoid all the
> cases of fsid getting duplicated.

But this does not matter. We're not protecting an image against external
changes, but by accidental change by a concrete user action at a
specific time.

> Even after btrfstune -M, the fsid can be duplicated by the user.

Yes of course, eg. by doing 'echo UUID | dd of=image seek=... bs=...',
there's no way we can prevent users from doing that. But that command is
up to user to check for the target device and we have no responsibility
for the damage.

> So what's the point in restricting the btrfstune -M and fail to
> undo the changed fsid.

The point is to prevent accidental damage. For the same reasons we have
'mkfs.btrfs -f' or 'btrfd device add -f' or even 'btrfstune -f -S 0'.

I'm surprised and slightly disappointed that we have to go through these
points, this is 101 of user interfaces.

> > You seem to have a
> > usecase where even duplicate uuids are required but I'm afraid it's not
> > all clear how is it supposed to work. A few more examples or commands
> > would be helpful.
> 
> In the use case here, even the host is also running a copy of the golden
> image (same fsid as vm guest) and because of duplicate fsid you can
> only mount a vm guest image on the host after the btrfstune -m command
> on the vm guest image. But after you have done that, as the vm guest
> fsid is changed, it fails to boot, unfortunately changed fsid can not
> be undone without this patch.

I can't say I have a clear picture yet, can you please describe it in
some more desriptive way, like

host1: create image1-uuid1

host2: copy image1-uuid1 to image1-uuid2
host2: use image1-uuid2
host2: change image1-uuid2 back to uuid1     <-- I want this to work

> The fsid can be duplicate by many different other ways anyways. So in
> this case how does it matter if btrfstune -M tries to ensure that fsid
> is unique among the blkid known set of devices, which may change any
> time after btrfstune -M as well (just copy a vm guest and map it to
> a loop device). So btrfstune -M should be free from this check and
> help the use case as above.
> 
> And if we are concerned about the duplicate fsid as I asked Nikolay
> before, we need to know what are problems in specifies, so that it can
> be fixed in separate patches, but definitely not in btrfstune -M as
> it can't fix the duplicate fsid problem completely as vm images can
> be copied and mapped to a loop/nbd device anytime even after
> btrfstune -M.

This only reiterates and was aswered above.

The usecase was not explained at the beginning, so it got a NAK because
it brought a potentially dangerous change. The next step is usecase
clarification so we understand if there's a way to make it work for the
common and your usecase.

And we're almost there, but instead of handwaving that we can't prevent
users doing lots of things, a simple 'so let's allow duplicate uuids
with -f with a big warning and a paragraph in documentation, and btw
here's a testcase' would do.  The patch could have been merged a month
ago.
