Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74C9C16B35F
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 22:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgBXV4I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 16:56:08 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35708 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727421AbgBXV4H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 16:56:07 -0500
Received: from callcc.thunk.org ([4.28.11.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01OLu1MZ030221
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Feb 2020 16:56:02 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9D0924211EF; Mon, 24 Feb 2020 16:56:00 -0500 (EST)
Date:   Mon, 24 Feb 2020 16:56:00 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs: sleeping function called from invalid context
Message-ID: <20200224215600.GB6688@mit.edu>
References: <20200223234246.GA1208467@mit.edu>
 <0c0fa96f-60d6-6a66-3542-d78763bbe269@suse.com>
 <20200224064605.GA1258811@mit.edu>
 <CAL3q7H4-edAwsSc0Z+dYVzphm6-D1BjvToywL0A2v6unsCCtyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4-edAwsSc0Z+dYVzphm6-D1BjvToywL0A2v6unsCCtyg@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 24, 2020 at 10:14:06AM +0000, Filipe Manana wrote:
> We do have some tests that fail in any kernel release so far. Some
> because the corresponding fixes are not yet merged or some fail often
> due to known problems.
> Looking at your list of failure, I see some that shouldn't be failing
> like btrfs/053.

I've sent you the compressed tarfile with the test artifacts under
separate cover.  The files that you'll probably want to look at first
are ./runtests.log and ./syslog.  The xfstests results artifacts will
be in ./btrfs/results-default/.

If you have a wiki page or some other pointer of what tests that you
expect to fail, I can put them into a btrfs-specific or file system
configuration specific exclude file.  For example, see [1] and [2].

[1] https://github.com/tytso/xfstests-bld/blob/master/kvm-xfstests/test-appliance/files/root/fs/ext4/exclude
[2] https://github.com/tytso/xfstests-bld/blob/master/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/bigalloc.exclude

I'm planning on running btrfs and xfs tests more frequently to support
some $WORK initiatives.  So if there are tests which are known
failures that would be good for me to suppress, and if there are some
file system configurations that would be useful for me to run, please
let me know and I'm happy to set them so that gce-xfstests and
kvm-xfstests can better test btrfs.

Also, I assume you do have some btrfs developers who are regularly
running xfstests, so I don't know how helpful this would be to you,
but given that I'm going to be running the tests *anyway*, if it would
be helpful for me to forward test results to you, or to only send you
a note when test regressions show up, I'm happy to do that.

Cheers,

					- Ted
