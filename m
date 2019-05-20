Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6187E2323E
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 13:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732676AbfETLZQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 07:25:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:35140 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732609AbfETLZQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 07:25:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9DA4CABD0;
        Mon, 20 May 2019 11:25:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A848CDA8B4; Mon, 20 May 2019 13:26:12 +0200 (CEST)
Date:   Mon, 20 May 2019 13:26:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Robert White <rwhite@pobox.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Feature Request: Directory property to upconvert mkdir/rmdir to
 subvol create/delete
Message-ID: <20190520112612.GD3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Robert White <rwhite@pobox.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <a108b077-ff18-7c6d-ac5c-ea666de48084@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a108b077-ff18-7c6d-ac5c-ea666de48084@pobox.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On Sat, May 18, 2019 at 04:06:40AM +0000, Robert White wrote:
> For several reasons it would be really convenient if there was a way to 
> mark a btrfs directory such that the directories created in the marked 
> directory would actually be automatically converted to subvolume 
> creation and destruction.
> 
> NFS4 particularly pivots on file system boundaries, which it seems to 
> include subvolumes-in-place as such boundaries.
> 
> doing this to /home is another opportunity if you have transient 
> accounts created by scripts/programs you cannot easily change.
> 
> Other uses include creating virtual machine sets via tarballs and such.
> 
> It would also be super useful in apps that create large cache 
> directories that you'll eventually drop in bulk. /usr/src is another 
> place where large directories come and go under installer control.
> 
> The core logic would be to upconvert any legal rmdir to a subvol delete 
> if it's applied to a subvol. Yes, this _would_ remove non-empty subvols, 
> that would be the point. Then any mkdir in that directory would create a 
> subvol instead of a directory.
> 
> Normal files in the directory would be unchanged.
> 
> And a normal directory moved into the directory would remain a normal 
> directory for obvious reasons.
> 
> And a subvol moved out of the directory (can you even do that?) would 
> remain a subvol for equally obvious reasons.
> 
> It's implicit that the non-superuser create/remove subvol operation 
> would be legal for such a directory.
> 
> Programs could be rewritten to do this explicitly, of course, but that's 
> a heck of a lot of impractical patching.
> 
> Anyway, just a thought I've had repeatedly that I finally thought to broach.

My first reaction to the subject line subvolume/directory conversion
idea was not positive, the two objects have a different representation
inside the filesystem and I thought it was the idea that was on wiki.

But you bring something completely different and it's well thought
through, the usecase, some of the practical questions rmdir/mv. And I
think this is not actually hard to implement with current state of
attributes and bits available.

The file attributes/flags defined by ext2 and adopted by other
filesystems were originally specific to ext2, but nothing prevents us to
repurpose some of them. Lesser known flag 'T' (described in chattr(1))
marks a directory as 'top level of a hierarchy', and is an optimization
for block placement.

How can btrfs reuse the flag? In a directory with 'T', all mkdir will be
mksubvol, and rmdir on a subvolume would work as you describe.

The rename operation only updates the directory entry and does not
change the type of the object, ie. moving a directory to a 'T' directory
will not magically convert it to a subvolume.

The nice thing is that the 'T' bit is there, the semantics is IMHO close
to the original meaning and the tools to manage it are available.

So yes, this can be implemented, I'll put it on the wiki projects page.
