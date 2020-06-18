Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A551FFCDA
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 22:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbgFRUn2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 16:43:28 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:38954 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbgFRUnT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 16:43:19 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 492447207A1; Thu, 18 Jun 2020 16:43:17 -0400 (EDT)
Date:   Thu, 18 Jun 2020 16:43:17 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     DanglingPointer <danglingpointerexception@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs-dedupe broken and unsupported but in official wiki
Message-ID: <20200618204317.GM10769@hungrycats.org>
References: <16bc2efa-8e88-319f-e90e-cf8536460860@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16bc2efa-8e88-319f-e90e-cf8536460860@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 18, 2020 at 12:28:41PM +1000, DanglingPointer wrote:
> btrfs-dedupe is currently broken and no longer actively supported.
> 
> It no longer builds with current rustc v1.44.0 with cargo
> 
> It is in the official btrfs Deduplication wiki:
> 
>     https://btrfs.wiki.kernel.org/index.php/Deduplication
> 
> There's no real active community and proper QA, reviewing and vetting.
> 
> A poster in the issues area of the projects Github location stated that even
> if fixed, it may not function correctly due to BTRFS having evolved since
> the tool was designed created.
> 
> There's just too many unknowns with this BTRFS specific dedupe tool.
> 
> People using your official wiki and trying to use that deduplication program
> could inadvertently destroy their data through nativity or accident. 
> Especially if they start trying to fix the code.

The point about lack of maintenance with changing Rust dependencies is
fair, but "data loss" is a strong and unsupported statement.  Can you
explain how data loss could occur in even a badly (assume not maliciously)
broken version of btrfs-dedupe?

As far as I can tell, the btrfs-dedupe code uses only non-data-mutating
btrfs kernel interfaces for manipulating extents (fiemap, defrag,
and file_extent_same/deduperange).  None of these should cause data
loss (excluding kernel bugs).

btrfs-dedupe can be trivially tricked into opening files that it did
not intend to (it has no protection against symlink injection and other
TOCCTOU attacks), but it doesn't seem to be able to alter the content
of files once it opens them.

File descriptors pointing to user files are opened O_RDWR, but they are
kept in the scope of the dedupe function and their life-cycle is properly
managed in Rust, so btrfs-dedupe won't mutate files by writing to the
wrong fd (e.g. accidentally close stderr and reopen it to a user file)
unless someone adds some seriously buggy code (see "assume not malicious"
above).

The unsafe C ioctl interfaces are unlikely to change in data-losing ways,
or they'll break all existing userspace tools that use them.  They are
also well encapsulated in the rust-btrfs module.

The errors reported on github seem to be problems with incompatible
changes in the runtime libraries btrfs-dedupe depends on, and also some
reports of what look like pre-existing bugs in the fiemap code that are
blamed on new kernel versions without evidence.  Data-losing breaking
changes in any of the ioctls btrfs-dedupe uses are extremely unlikely.
Those issues may cause btrfs-dedupe to do useless unnecessary work,
or fail to do useful necessary work, but could not cause data loss by
any mechanism I can find.

Contrast with bedup:  bedup uses data-mutating kernel interfaces
(clone_range) for dedupe that have no effective protection against
concurrent data modification.  There is ineffective protection implemented
in bedup (looking in /proc/*/fd for concurrent users of the files) which
may or may not be broken in kernel 5.0, but it's ineffective either way.
The case for data loss in bedup is trivial.  The branch with a patch to
fix it is now 7 years old, so it's fair to say bedup is unmaintained too
(github forks notwithstanding, they didn't fix these issues).

> I recommend you remove it from your website or at least put large warnings
> there that it is broken (which looks ugly, I would rather only stuff that
> works were there since it isn't your project anyway but some 3rd party).
