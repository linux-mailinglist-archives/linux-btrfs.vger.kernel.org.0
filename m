Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2E11EA5E3
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 16:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgFAOah (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 10:30:37 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.234]:41980 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726124AbgFAOag (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 10:30:36 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 1B9258F55EB
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Jun 2020 09:05:57 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id fl4ejz1S2AGTXfl4fjAdLo; Mon, 01 Jun 2020 09:05:57 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4ufNmWmduoR5QeCqDyN/mA4gfe/roRoquvKpGKWqw/M=; b=sQAZTGkA1zcnOq+HI7NMKzyC8f
        1X3S/aRoNm6bjOTftXSIm833bU0FuVJw+AKZOMcv+MW7RJsS9zP+sGrjYxFVrFx94GoGsycdGcM5r
        LhKSW96nUgPoI6Wpvto7KCuHapFZwHfX3uJE+xZBl1v0Z1h9IblTk93nfb44OnBhcuGctZEQw1pzi
        udGyn3f6OInOQJELhlolvRyvQLoU60ODtQxisIiy2mz0wntsyYdphD86iFtatmzLSeFsmeNcO7hOA
        GMmmaI7TW//OF2KpJblJuiV1ime4qN7EEODWvD6mr4iD+J51SlpMJavMR/9ZX2z2uC/ST9euFLhoN
        YD+AetAg==;
Received: from 179.187.207.6.dynamic.adsl.gvt.net.br ([179.187.207.6]:55406 helo=[192.168.0.172])
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jfl4d-004Dn9-Ua; Mon, 01 Jun 2020 11:05:56 -0300
Message-ID: <ecf0925d65d0ac36f36b19fb74dc72a80ae0a698.camel@mpdesouza.com>
Subject: Re: [PATCH] btrfs: test if the capability is kept on incremental
 send
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     fdmanana@gmail.com
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>, fstests <fstests@vger.kernel.org>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Date:   Mon, 01 Jun 2020 11:09:25 -0300
In-Reply-To: <CAL3q7H61dS6GQh29vL-Pq+jaDLA-z3dwAkXkBdOgiW2XYgB6PQ@mail.gmail.com>
References: <20200508195548.25429-1-marcos@mpdesouza.com>
         <CAL3q7H5Xnk6Ds9inLY7xOeT_knq3ySghrYeXQk2z-nQkyr712Q@mail.gmail.com>
         <CAL3q7H61dS6GQh29vL-Pq+jaDLA-z3dwAkXkBdOgiW2XYgB6PQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.187.207.6
X-Source-L: No
X-Exim-ID: 1jfl4d-004Dn9-Ua
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179.187.207.6.dynamic.adsl.gvt.net.br ([192.168.0.172]) [179.187.207.6]:55406
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 4
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 2020-06-01 at 14:48 +0100, Filipe Manana wrote:
> On Mon, May 11, 2020 at 12:52 PM Filipe Manana <fdmanana@gmail.com>
> wrote:
> >
> > On Fri, May 8, 2020 at 9:14 PM Marcos Paulo de Souza
> > <marcos@mpdesouza.com> wrote:
> > >
> > > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > >
> > > There is a situation where the incremental send can drop the
> capability
> > > from the receiving side. If you have a file that changed the
> group, but
> > > the capability was the same of before the group changed, the
> current
> > > kernel code will only emit a chown, since the capability is the
> same.
> > >
> > > The steps bellow can reproduce the problem.
> > >
> > > $ mount /dev/sda fs1
> > > $ mount /dev/sdb fs2
> > >
> > > $ touch fs1/foo.bar
> > > $ setcap cap_sys_nice+ep fs1/foo.bar
> > > $ btrfs subvol snap -r fs1 fs1/snap_init
> > > $ btrfs send fs1/snap_init | btrfs receive fs2
> > >
> > > $ chgrp adm fs1/foo.bar
> > > $ setcap cap_sys_nice+ep fs1/foo.bar
> > >
> > > $ btrfs subvol snap -r fs1 fs1/snap_complete
> > > $ btrfs subvol snap -r fs1 fs1/snap_incremental
> > >
> > > $ btrfs send fs1/snap_complete | btrfs receive fs2
> > > $ btrfs send -p fs1/snap_init fs1/snap_incremental | btrfs
> receive fs2
> >
> > It's redundant to put here the steps to trigger the problem, that's
> > what the test does.
> >
> > You just want to say this test exercises full send and incremental
> > send operations for cases where files have capabilities, to verify
> the
> > capabilities aren't lost.
> >
> > >
> > > At this point, a chown was emitted by "btrfs send" since only the
> group
> > > was changed. This makes the cap_sys_nice capability to be dropped
> from
> > > fs2/snap_incremental/foo.bar
> >
> > Explaining in a changelog for a test case why exactly the bug
> happens
> > is out of scope.
> > We just want to know what bug are we testing for.
> >
> > The gory details about why the bug happens usually go the in the
> > changelog of the patch that fixes btrfs.
> >
> > >
> > > This test fails on current kernel, the fix was submitted to the
> btrfs
> > > mailing list titled:
> > >
> > > "btrfs: send: Emit file capabilities after chown"
> > >
> > > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > > ---
> > >  tests/btrfs/211     | 153
> ++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/btrfs/211.out |   6 ++
> > >  tests/btrfs/group   |   1 +
> > >  3 files changed, 160 insertions(+)
> > >  create mode 100755 tests/btrfs/211
> > >  create mode 100644 tests/btrfs/211.out
> > >
> > > diff --git a/tests/btrfs/211 b/tests/btrfs/211
> > > new file mode 100755
> > > index 00000000..e9aeaef3
> > > --- /dev/null
> > > +++ b/tests/btrfs/211
> > > @@ -0,0 +1,153 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights
> Reserved.
> > > +#
> > > +# FS QA Test 211
> > > +#
> > > +# Test if the file capabilities aren't lost after full and
> incremental send
> > > +#
> > > +seq=`basename $0`
> > > +seqres=$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +
> > > +here=`pwd`
> > > +tmp=/tmp/$$
> > > +status=1       # failure is the default!
> > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > +
> > > +# get standard environment, filters and checks
> > > +. ./common/rc
> > > +. ./common/filter
> > > +
> > > +# remove previous $seqres.full before test
> > > +rm -f $seqres.full
> > > +
> > > +_supported_fs btrfs
> > > +_supported_os Linux
> > > +_require_scratch
> > > +_require_command "$SETCAP_PROG" setcap
> > > +_require_command "$GETCAP_PROG" getcap
> > > +
> > > +_cleanup()
> > > +{
> > > +       cd /
> > > +       rm -f $tmp.*
> > > +}
> > > +
> > > +_check_xattr()
> >
> > Function names starting with '_' are usually reserved for functions
> > provided by fstests, global functions (like the ones in common/*).
> > Same comment applies to all the other function names.
> >
> > Also, a better name would be "check_capabilities" - that they are
> > stored in a xattr it's irrelevant as we are using the getcap and
> > setcap utilities to read and set them, and not accessing xattrs
> > directly.
> >
> > > +{
> > > +       local RET
> > > +       local FILE
> > > +       local CAP
> > > +       FILE="$1"
> > > +       CAP="$2"
> >
> > Variables in uppercase are meant to be used for global variables.
> Same
> > comment applies to all the other functions.
> >
> > > +       RET=$($GETCAP_PROG "$FILE")
> > > +       if [ -z "$RET" ]; then
> > > +               echo "$RET"
> > > +               _fail "missing capability in file $FILE"
> >
> > This is a practice generally discouraged, we should avoid "_fail"
> > unless absolutely necessary.
> > The right approach here is just to "echo" the message. That's
> enough
> > to make the test fail as that message is not part of the golden
> > output.
> > Furthermore, not using _fail allows the test to proceed and
> > potentially find other problems.
> >
> > > +       fi
> > > +       if [[ "$RET" != *$CAP* ]]; then
> > > +               echo "$RET"
> > > +               echo "$CAP"
> > > +               _fail "Capability do not match. Output: $RET"
> >
> > Capability -> Capabilities
> >
> > > +       fi
> > > +}
> > > +
> > > +_setup()
> > > +{
> > > +       _scratch_mkfs >/dev/null
> > > +       _scratch_mount
> > > +
> > > +       FS1="$SCRATCH_MNT/fs1"
> > > +       FS2="$SCRATCH_MNT/fs2"
> >
> > To make it easier to follow, perhaps declare this outside this
> > function, as they are used by the other functions.
> >
> > > +
> > > +       $BTRFS_UTIL_PROG subvolume create "$FS1" > /dev/null
> > > +       $BTRFS_UTIL_PROG subvolume create "$FS2" > /dev/null
> > > +}
> > > +
> > > +_full_nocap_inc_withcap_send()
> > > +{
> > > +       _setup
> > > +
> > > +       # Test full send containing a file with no capability
> > > +       touch "$FS1/foo.bar"
> > > +       $BTRFS_UTIL_PROG subvolume snapshot -r "$FS1"
> "$FS1/snap_init" >/dev/null
> > > +       $BTRFS_UTIL_PROG send "$FS1/snap_init" -q |
> $BTRFS_UTIL_PROG receive "$FS2" -q
> > > +       # ensure that we don't have caps set
> > > +       RET=$($GETCAP_PROG "$FS2/snap_init/foo.bar")
> >
> > Should be declared local (and lower case name).
> >
> > > +       if [ -n "$RET" ]; then
> > > +               _fail "File contain capabilities when it
> shouldn't"
> >
> > echo and contain -> contains
> >
> > > +       fi
> > > +
> > > +       # Test if  incremental send bring the newly added
> capability
> > > +       $SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep"
> "$FS1/foo.bar"
> > > +       $BTRFS_UTIL_PROG subvolume snapshot -r "$FS1"
> "$FS1/snap_inc" >/dev/null
> > > +       $BTRFS_UTIL_PROG send -p "$FS1/snap_init" "$FS1/snap_inc"
> -q | \
> > > +                                       $BTRFS_UTIL_PROG receive
> "$FS2" -q
> > > +       _check_xattr "$FS2/snap_inc/foo.bar"
> "cap_sys_ptrace,cap_sys_nice+ep"
> > > +
> > > +       _scratch_unmount
> > > +}
> > > +
> > > +_roundtrip_send()
> > > +{
> > > +       local FILES
> > > +       local FS1
> > > +       local FS2
> >
> > So FS1 and FS2 are declared local but never set. And they were
> > previously set as global by "_setup".
> > So those two declarations should be removed here.
> >
> > > +
> > > +       # FILES should include foo.bar
> > > +       FILES="$1"
> > > +
> > > +       _setup
> > > +
> > > +       # create files on fs1, must contain foo.bar
> > > +       for f in $FILES; do
> > > +               touch "$FS1/$f"
> > > +       done
> > > +
> > > +       # Test full send, checking if the receiving side keeps
> the capability
> >
> > capability -> capabilities (as the test sets 2)
> >
> > > +       $SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep"
> "$FS1/foo.bar"
> > > +       $BTRFS_UTIL_PROG subvolume snapshot -r "$FS1"
> "$FS1/snap_init" >/dev/null
> > > +       $BTRFS_UTIL_PROG send "$FS1/snap_init" -q |
> $BTRFS_UTIL_PROG receive "$FS2" -q
> > > +       _check_xattr "$FS2/snap_init/foo.bar"
> "cap_sys_ptrace,cap_sys_nice+ep"
> > > +
> > > +       # Test incremental send with different owner/group but
> same capability
> >
> > capability -> capabilities (as the test sets 2)
> >
> > > +       chgrp 100 "$FS1/foo.bar"
> > > +       $SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep"
> "$FS1/foo.bar"
> > > +       $BTRFS_UTIL_PROG subvolume snapshot -r "$FS1"
> "$FS1/snap_inc" >/dev/null
> > > +       _check_xattr "$FS1/snap_inc/foo.bar"
> "cap_sys_ptrace,cap_sys_nice+ep"
> > > +       $BTRFS_UTIL_PROG send -p "$FS1/snap_init" "$FS1/snap_inc"
> -q | \
> > > +                               $BTRFS_UTIL_PROG receive "$FS2"
> -q
> > > +       _check_xattr "$FS2/snap_inc/foo.bar"
> "cap_sys_ptrace,cap_sys_nice+ep"
> > > +
> > > +       # Test capability after incremental send with different
> capability and group
> >
> > capability -> capabilities (as the test sets 2)
> >
> > > +       chgrp 0 "$FS1/foo.bar"
> > > +       $SETCAP_PROG "cap_sys_time+ep cap_syslog+ep"
> "$FS1/foo.bar"
> > > +       $BTRFS_UTIL_PROG subvolume snapshot -r "$FS1"
> "$FS1/snap_inc2" >/dev/null
> > > +       _check_xattr "$FS1/snap_inc2/foo.bar"
> "cap_sys_time,cap_syslog+ep"
> > > +       $BTRFS_UTIL_PROG send -p "$FS1/snap_inc" "$FS1/snap_inc2"
> -q | \
> > > +                               $BTRFS_UTIL_PROG receive
> "$FS2"  -q
> > > +       _check_xattr "$FS2/snap_inc2/foo.bar"
> "cap_sys_time,cap_syslog+ep"
> > > +
> > > +       _scratch_unmount
> > > +}
> > > +
> > > +# real QA test starts here
> > > +
> > > +echo "Test full send + file without caps, then inc send bringing
> a new cap"
> >
> > inc -> incremental
> >
> > Also, the abbreviation "caps" is used but in other messages (below)
> > the non-abbreviated name "capabilities" is used.
> > We should be consistent and use only one form.
> >
> > > +_full_nocap_inc_withcap_send
> > > +
> > > +echo "Testing if foo.bar alone can keep it's capability"
> >
> > it's -> its
> > capability -> capabilities (as the test sets 2)
> >
> > > +_roundtrip_send "foo.bar"
> > > +
> > > +echo "Test foo.bar being the first item among other files"
> > > +_roundtrip_send "foo.bar foo.bax foo.baz"
> > > +
> > > +echo "Test foo.bar with objectid between two other files"
> > > +_roundtrip_send "foo1 foo.bar foo3"
> > > +
> > > +echo "Test foo.bar being the last item among other files"
> > > +_roundtrip_send "foo1 foo2 foo.bar"
> > > +
> > > +status=0
> > > +exit
> > > diff --git a/tests/btrfs/211.out b/tests/btrfs/211.out
> > > new file mode 100644
> > > index 00000000..fc50c923
> > > --- /dev/null
> > > +++ b/tests/btrfs/211.out
> > > @@ -0,0 +1,6 @@
> > > +QA output created by 211
> > > +Test full send + file without caps, then inc send bringing a new
> cap
> > > +Testing if foo.bar alone can keep it's capability
> > > +Test foo.bar being the first item among other files
> > > +Test foo.bar with objectid between two other files
> > > +Test foo.bar being the last item among other files
> > > diff --git a/tests/btrfs/group b/tests/btrfs/group
> > > index 9426fb17..437d4431 100644
> > > --- a/tests/btrfs/group
> > > +++ b/tests/btrfs/group
> > > @@ -213,3 +213,4 @@
> > >  208 auto quick subvol
> > >  209 auto quick log
> > >  210 auto quick qgroup snapshot
> > > +211 auto quick snapshot
> >
> > Missing the 'send' group.
> >
> > Other that is looks good and it works as expected (with patched and
> > unpatched btrfs)
> > Thanks.
> 
> Marcos, ping. Anything I can help with?

Sorry, the test was in my radar but somehow I forgot about it. I hope
to send a new version later today, addressing all your comments.

> We should really have this test case in fstests.

Sure, I agree.

>  

> 
> Thanks.
> 
> >
> > > --
> > > 2.25.1
> > >
> >
> >
> > --
> > Filipe David Manana,
> >
> > “Whether you think you can, or you think you can't — you're right.”
> 
> 
> 

