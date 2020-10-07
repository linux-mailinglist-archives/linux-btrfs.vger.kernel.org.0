Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CD7285E87
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Oct 2020 13:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgJGL5f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Oct 2020 07:57:35 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42320 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgJGL5f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Oct 2020 07:57:35 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 220DC841925; Wed,  7 Oct 2020 07:57:32 -0400 (EDT)
Date:   Wed, 7 Oct 2020 07:57:32 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Eric Levy <ericlevy@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: de-duplicating +C files
Message-ID: <20201007115732.GO5890@hungrycats.org>
References: <CA++hEgxkGhnbKBhwuwSAJn2BtZ+RAPuN+-ovkKLsUUfTRnD1_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA++hEgxkGhnbKBhwuwSAJn2BtZ+RAPuN+-ovkKLsUUfTRnD1_g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 07, 2020 at 02:29:34AM -0400, Eric Levy wrote:
> Recently a discussion [1] began about the desirability or risk of
> applying a de-duplication operation on files with a C (no-CoW)
> attribute set. The controversy rests largely on the observation that
> calls to Btrfs currently fail for de-duplication between two files if
> exactly one has the attribute set, but succeed in other cases, even in
> which both have the attribute set. It may seem more natural that
> success depends on neither file having the attribute set.
> 
> Comments would be welcome in either this thread, or perhaps even more
> conveniently, in the Github discussion, over how this behavior of
> Btrfs relates to the preferred operation of a de-duplication
> application.
> 
> [1] https://github.com/markfasheh/duperemove/issues/251

It came up as a bees issue 3 years ago:

	https://github.com/Zygo/bees/issues/31

The btrfs behavior results from an optimization for data checksums:
rather than looking up csums on an extent-by-extent basis, there is a
flag in the inode which specifies whether the entire file has csums.
If the inode flag indicates no csums, the entire csum lookup can be
skipped for any read from the file.  The inode flag also means that
extents which are referenced by a file that has csums cannot be shared
(dedupe, reflink, or snapshot) with a file that does not have csums
or vice versa.  nodatacow implies nodatasum because atomic csum update
requires copy-on-write to work, and that is where the +C attribute comes
in.  Other filesystems don't have data csums so they don't hit this issue.

nodatacow files can be reflinked or snapshotted on btrfs.  Unlike
nodatasum, any individual extent in any file can be datacow or not.
Extents in nodatacow files which are shared will operate temporarily in
datacow mode until they are no longer shared, then revert to nodatacow
behavior.  Prealloc does something similar, but only to extents created
with fallocate (and in reverse, starting in nodatacow and ending in
datacow state).  Dedupe is just reflink with an extra verification step.

As a temporary hack to avoid bad behavior for people running VM image
files in nodatacow mode, bees currently ignores nodatacow (+C) files.
This isn't correct--it should be ignoring nodatasum files instead, but
the nodatasum flag is only visible in the raw inode metadata, and has
to be fetched by the btrfs-specific TREE_SEARCH ioctl.  So far, nobody
has complained about datacow+nodatasum files not getting deduped, and
datasum+nodatacow is disallowed by btrfs, so the temporary hack seems
fine for now.

Proper support for nodatasum is planned in future bees versions, with a
user option to either exclude nodatasum and/or nodatacow files completely
from dedupe (as is done now, but using the correct inode flag) or support
separate dedupe domains for datasum and nodatasum extents.  This can be
done easily in most dedupers by hashing extents from datasum files with a
different hash salt than extents from nodatasum files, so that no datasum
block could match a non-datasum block, but nodatasum blocks could match
other nodatasum blocks, and datasum blocks can match other datasum blocks.
(bees has extent-splitting, which adds some additional requirements not
addressed in this paragraph)

Duperemove can easily implement both options:  Check for FS_NOCOW_FL
attribute on file open, and either drop the file, or invert the bits
of the hash as a crude but effective hash salt for hashes coming from
the file, and everything else works as before.  Some hash functions
have an explicit separate salt parameter or IV that can be set to
implement segregated collision domains.  Based on the zero complaints
I've received so far, I doubt any duperemove users will complain about
incorrect handling of datacow+nodatasum files either--and those users
can run the current duperemove anyway, they just need to make sure
they only pass files on the command line that have nodatasum set.

Filesystem tricks and quirks aside, it seems likely most users would
prefer the "ignore all nodatacow files for dedupe" behavior, regardless
of the datasum issue.  The whole point of nodatacow files would seem
to be to not have shared extents in them, while the whole point of
dedupe would seem to be to have as many shared extents as possible, and
only one of those points can be reached at a time.  Since chattr +C is
localized a statement of user intent wrt a specific filesystem object,
the sensible default is to not dedupe +C files.

That said, there are some edge use cases where it's useful, like big
read-only segments in VM images.  My plan is to keep that as default
bees behavior, but make dedupe on nodatacow and nodatasum fully supported
as optional modes.

Aside:  It looks like it should be possible to support a reflink or dedupe
from a datasum file to a nodatasum file (the nodatasum file would ignore
the csums), but the current btrfs code doesn't allow it.  That would make
some things easier and others a bit more complicated.
