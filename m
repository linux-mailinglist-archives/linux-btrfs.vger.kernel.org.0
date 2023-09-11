Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFDB79B1A6
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 01:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356095AbjIKWCw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbjIKL4T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 07:56:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228A3E3
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 04:56:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386ADC433C8;
        Mon, 11 Sep 2023 11:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694433372;
        bh=izqMVeJP9+1E8Bddkk1KXhK8gNxA0s4Kf8noD68IwNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eztXblBjewp1z4woLNQO1wNdGHoA9BTSYV6Yyt7WprRhQDJzkMjWZJIgqWWfe9/s+
         QBqf6Aer11z6LF2MKdtUGrAynWK9DDGbskNrXPvlWZFfejCXBceqTLLmg4VTwbHUuO
         BiVSvoWv7P9ODGSiY9DkkMy9v6l7DAfIurHRx5bKXLjGQt8tfJjT6FdgNMPGv4FeXk
         FE2RQxzFRE8W4D4VakGVVULkSK85w6gbsbPFhIKrP1IlbrZTZMDlfe9b5Ny7sTfBQX
         74xfbUGMrJIKJRai0tQG7Kmy435pMGH/LJ6mP+BUYvPUsY6vMCZMVWQakJQziq40zG
         M4gVFJLijFVIg==
Date:   Mon, 11 Sep 2023 12:56:08 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Evangelos Foutras <evangelos@foutras.com>
Cc:     Ian Johnson <ian@ianjohnson.dev>, linux-btrfs@vger.kernel.org
Subject: Re: Possible readdir regression with BTRFS
Message-ID: <ZP8AWKMVYOY0mAwq@debian0.Home>
References: <YR1P0S.NGASEG570GJ8@ianjohnson.dev>
 <ZPweR/773V2lmf0I@debian0.Home>
 <00ed09b9-d60c-4605-b3b6-f4e79bf92fca@foutras.com>
 <ZPxiqYCeMb6vOjw9@debian0.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPxiqYCeMb6vOjw9@debian0.Home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 09, 2023 at 01:18:49PM +0100, Filipe Manana wrote:
> On Sat, Sep 09, 2023 at 02:52:19PM +0300, Evangelos Foutras wrote:
> > Hi Filipe,
> > 
> > Please be aware that this bug might not be as harmless as it seems. I'm not
> > sure if the fix you're preparing would also fix an issue we saw at Arch
> > Linux but I thought I'd mention it here.
> > 
> > We have a package repository server with 4x10 TB drives in RAID10 (btrfs
> > only, no mdadm). On multiple mirrors syncing from it we have seen rsync
> > occasionally delete ~4 small (<10 MB) files that get frequently updated by
> > renaming temporary files into them. This only happened with 6.4.12 and went
> > away after going back to 6.4.10 (the former had the commit Ian mentioned).
> > 
> > Unfortunately I don't have a reproducer for this. I can only describe what
> > our repo-add script does and how rsync behaves during problematic syncs.
> > 
> > Our repo-add script frequently adds packages to the extra repo by doing:
> > 
> >   ln -f extra.db.tar.gz extra.db.tar.gz.old
> >   mv .tmp.extra.db.tar.gz extra.db.tar.gz
> > 
> > And the same for extra.files.tar.gz:
> > 
> >   ln -f extra.files.tar.gz extra.files.tar.gz.old
> >   mv .tmp.extra.files.tar.gz extra.files.tar.gz
> > 
> > While the server was running Linux 6.4.12, rsync on some mirrors would
> > occasionally (3-4 times in the day) delete these files:
> > 
> >   deleting extra/os/x86_64/extra.files.tar.gz.old
> >   deleting extra/os/x86_64/extra.files.tar.gz
> >   deleting extra/os/x86_64/extra.db.tar.gz.old
> >   deleting extra/os/x86_64/extra.db.tar.gz
> > 
> > Since renames are atomic, I would expect this scenario to never happen.
> > 
> > Again, sorry for not being able to provide a proper reproducer like Ian;
> > there is probably some timing interaction with how rsync does directory
> > scanning and repo-add updating the directory entry during this time.
> 
> No worries, I've just sent a patchset with 2 patches:
> 
> https://lore.kernel.org/linux-btrfs/cover.1694260751.git.fdmanana@suse.com/
> 
> I've only seen your message after sending it, but I think the first patch
> should fix what you are seeing.

Ok, so I took a more detailed look at your issue this morning.
It's unrelated to what Ian reported, as rsync doesn't even use rewinddir(3).

Here's what I think it's happening (speculating a bit about how rsync
works):

1) rsync uses opendir() and readdir() to iterate over the source and
   destination (backup) directories, to obtain a list of files in each;

2) While it's iterating the source directory, the renames and "ln -f"
   happen. Because of this the readdir() calls don't return neither the
   old file names neither the new ones.

   This is because when opendir() is called, btrfs gets the index of the
   last (most recently added) directory entry, and then never iterates
   beyond that index in readdir() calls - this behaviour was introduced
   in commit 9b378f6ad48c ("btrfs: fix infinite directory reads"), and it's
   intentional to prevent readdir() never finishing while renames (or new
   files added) inside the directory are happening.

   On a rename, the new file name is assigned a new index number, larger
   then the last one we had when openddir() was called. It's effectively
   like removing an entry from the directory and adding a new one.
   The same goes for a 'ln -f' - if the destination name exists, it is
   removed and then the name is added again but pointing to a different
   inode (and with a higher index number);

3) As rsync sees that one of those renamed files is in the destination
   directory but not on the source directory, it deletes those files from
   the destination.

Looking at readdir() requirements from POSIX we have:

  "If a file is removed from or added to the directory after the most recent call
   to opendir() or rewinddir(), whether a subsequent call to readdir() returns an
   entry for that file is unspecified."

  (from https://pubs.opengroup.org/onlinepubs/007904875/functions/readdir_r.html)

Yes, renames are not explicit there, even though they are like adding a new name
and removing another one. So googling around, to be extra sure, I found this old
thread from Ted (ext4 maintainer):

   https://yarchive.net/comp/linux/readdir_nonatomicity.html

Where the most important part is this:

   "This is not a bug; the POSIX specification explicitly allows this
    behavior.  If a filename is renamed during a readdir() session of a
    directory, it is undefined where that neither, either, or both of the
    new and old filenames will be returned."

So from a POSIX point of view, we are not doing anything wrong after that commit
in btrfs. So my advise is to not have rsync running while the renames and "ln -f"
are happening.

I understand this may be a bummer as some applications may be relying on the old
behaviour that happened to guarantee that at least the new file names would always
be visible in readdir() calls, but that effectively was due to a bug in btrfs that
caused infinite directory reads as mentioned in that commit and the linked thread.
As if new indexes were added after opendir(), we would always read and return them.

We could change opendir() to allow reading up to the current last index plus N,
where N may be 10 or 100 for example, so that in the case of concurrent renames we
would still (very likely but no guaranteed) at least return the new names - but
not only that is not required by POSIX it would also not be always reliable - what
if we have N + 1 renames? Then file name N + 1 would still be not returned, or
if N new files are added and then rename happens at N + 1, we would also not return
it - i.e., it would never be reliable and it would be a hack - it would encourage
applications to rely on a behaviour that can not always be guaranteed.

Thanks.

> 
> Thanks.
> 
> > 
> > [1] https://gitlab.archlinux.org/pacman/pacman/-/blob/v6.0.2/scripts/repo-add.sh.in#L473
