Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F5B39EC45
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jun 2021 04:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFHCni (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 22:43:38 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:39370 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFHCni (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Jun 2021 22:43:38 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 244ABA92DA4; Mon,  7 Jun 2021 22:41:44 -0400 (EDT)
Date:   Mon, 7 Jun 2021 22:41:44 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Paul Eggert <eggert@cs.ucla.edu>
Cc:     Tom Yan <tom.ty89@gmail.com>, 48833@debbugs.gnu.org,
        linux-btrfs@vger.kernel.org
Subject: Re: bug#48833: reflink copying does not check/set No_COW attribute
 and fail
Message-ID: <20210608024144.GB11713@hungrycats.org>
References: <CAGnHSEkr0N_hnxvm89prL3vObYgvVoPFHLL4Z7wnQCSem6hB_A@mail.gmail.com>
 <CAGnHSEkeu1hW-7YQO0HrYK__aY-eMdxfgSbcOTvnMu3jUcu4iw@mail.gmail.com>
 <20210604201630.GH11733@hungrycats.org>
 <CAGnHSEk-+2tA21+sN4dioYbs_u4m_NiLPkG8u6ONJS=JbCACoA@mail.gmail.com>
 <20210606054242.GI11733@hungrycats.org>
 <4354c814-9f9f-0c26-fb11-36567da6f530@cs.ucla.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4354c814-9f9f-0c26-fb11-36567da6f530@cs.ucla.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 06, 2021 at 10:47:05PM -0700, Paul Eggert wrote:
> On 6/5/21 10:42 PM, Zygo Blaxell wrote:
> > If cp -a implements the inode attribute propagation (or inheritance), then
> > only users of cp -a are impacted.  They are more likely to be aware that
> > they may be creating new files with reduced-integrity storage attributes.
> 
> True, although I think this aspect of attribute-copying will typically come
> as a surprise even to "cp -a" users.

Existing users might be surprised when "cp -a" starts replicating storage
attributes when it did not do so before, but I suspect most future cp
users would expect "cp -a" to preserve storage-policy attributes the same
way it currently preserves ownership, permissions, timestamps, extended
attributes, and security context--a list that initially contained only
the ownership, permissions, and timestamps in the past, the others were
added over time.  If not by default, then at least have the ability to
do it when requested with a "--preserve=datacow" switch.

We could say "cp --reflink=always implies --preserve=datacow because it
might not work otherwise", which solves the immediate issue as presented,
but I don't think we _want_ to say that because it has a potentially
bad surprising case when attribute changes are unexpected (it's the same
reason that we would not want to implement it that way in the kernel).
As a cp user, I would prefer to make the choice to copy the storage
attributes with --preserve or -a, and after that choice is made, then
--reflink=always will work because cp is setting attributes in dst to
match src as I requested it to do.  If I had made the opposite choice
(didn't use -a or --preserve, or did use --no-preserve=datacow), then
cp shall not copy the storage attributes, the dst inodes have attributes
inherited from dst's parent, --reflink=always fails when there are
mismatches as it does now, and --reflink=auto or =none copies may have
different storage attributes from the src (with possibly stronger or
weaker integrity).

We could say "'cp -a --reflink=always' implies --preserve=datacow, but
'--reflink=always' and '-a' by themselves do not."  It seems complex
to describe, but maybe it does surprise the fewest people in the most
beneficial way:  plain 'cp -a' users keep exactly the old behavior,
while 'cp -a --reflink=always' users get successful copies in one case
where they currently get unexpected failures.  'cp -r' doesn't imply
--preserve=all, so 'cp -r --reflink=always' would need to be accompanied
by '--preserve=datacow' or '--preserve=all' to get the attribute-copying.

The cp doc could be clearer that filesystems that support reflink
don't guarantee every file can be reflinked to every other file.
reflink is expected to fail in a growing number of cases over time,
as more filesystem features are created that are incompatible with it
(e.g. encryption, where reflinks between files with different owners could
be unimplementable).  I've seen a number of users get burned by making big
--reflink=always copies and not checking the results for errors, assuming
that only lack of space for metadata could cause a reflink copy to fail.
There are good reasons why --reflink=auto exists and is the default,
and users ignore them at their peril.

The really awful thing about all this is that it's not datacow, the
thing visible with chattr +/-C and implemented by other filesystems,
that is the problem.  The problem is the datasum bit hidden behind the
datacow bit on btrfs.  datasum can still be disabled even when datacow
is enabled, and datasum requires privileges to detect (unprivileged
users can only observe the datasum bit's effect on reflink copies to
files with the opposite datasum setting).  The proper option name should
be --preserve=datasum, but cp can only examine or change the datacow bit.

> > If the file is empty, you can chattr +C or -C.  If the file is not
> > empty, chattr fails with an error.
> 
> Although coreutils 'cp -a' currently truncates any already-existing output
> file (by opening it with O_TRUNC), it then calls copy_file_range before
> calling fsetxattr on the destination. Presumably cp should do the equivalent
> of chattr +C before doing the copy_file_range stuff. (Perhaps you've already
> mentioned this point; if so, my apologies for the duplication.)

The important thing is that got across, whether you extracted it from what
I wrote, or reconstructed it from context.
