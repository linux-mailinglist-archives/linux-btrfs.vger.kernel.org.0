Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092466055BA
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 05:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiJTDDM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 23:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJTDDF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 23:03:05 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E5A192B8C;
        Wed, 19 Oct 2022 20:03:03 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 29K32h5F005694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 23:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1666234965; bh=unpXEP1E407PXOt0MAIPUHFNcJ8BsWd8lWLW8JLxFrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ohsPXQ+2MGQPzgzUxvTPOzQNuqKneVYxIG0jU45R8DCrhpjdZu57G9TTwtaHh+3xr
         qtrDlfT9gkuPF0VHOVBt+gJaLmEm9Fe7ZOTTFIfXpeT61oAPw87ELZFBEBGS6uTMVi
         +Iv/zGZOzgRwPfuNOdE3U8oxZBx9VfYylnLye23aa4GqNCe4jxhJEOFYQv4phLI/Zb
         KXbtPw8XbmJT/kq85gpVcrNsdUyfpKdplLbQSovE9xIy9fjrA1PHr0i7wDywakhIws
         yOijXqVpzG5yqVTRdkY/8kg9nO75fiUGH577jgQuyuCWM0URcoIPcoN4scfcA1Bzub
         x69LybpDA2w9g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 36C1E15C3AD1; Wed, 19 Oct 2022 23:02:43 -0400 (EDT)
Date:   Wed, 19 Oct 2022 23:02:43 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH] generic: check if one fs can detect damage at/after fs
 thaw
Message-ID: <Y1C6U7KkBwndZiww@mit.edu>
References: <20221019052955.30484-1-wqu@suse.com>
 <Y1AZl3o+iSqNZgMw@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1AZl3o+iSqNZgMw@magnolia>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 19, 2022 at 08:36:55AM -0700, Darrick J. Wong wrote:
> On Wed, Oct 19, 2022 at 01:29:55PM +0800, Qu Wenruo wrote:
> > [BACKGROUND]
> > There is bug report from btrfs mailing list that, hiberation can allow
> > one to modify the frozen filesystem unexpectedly (using another OS).
> > (https://lore.kernel.org/linux-btrfs/83bf3b4b-7f4c-387a-b286-9251e3991e34@bluemole.com/)
> > 
> > Later btrfs adds the check to make sure the fs is not changed
> > unexpectedly, to prevent corruption from happening.
> > 
> > [TESTCASE]
> > Here the new test case will create a basic filesystem, fill it with
> > something by using fsstress, then sync the fs, and finally freeze the fs.
> > 
> > Then corrupt the whole fs by overwriting the block device with 0xcd
> > (default seed from xfs_io pwrite command).

It seems to me that the test case is testing something very different
from the originally stated concern, and what btrfs is testing.

The original concern is "something else modified the file system",
which btrfs is testing by checking whether the file system generation
number is different from the last recorded transaction id.

The test is "something has trashed the file system by filling the
block device by 0xcd; let's see how quickly the file system notices"
which is quite different from the scenario described in the link and
the commit description a05d3c915314 ("btrfs: check superblock to
ensure the fs was not modified at thaw time").

> What /does/ btrfs check, specifically?  Reading this makes me wonder if
> xfs shouldn't re-read its primary super on thaw to check that nobody ran
> us over with a backhoe, though that wouldn't help us in the hibernation
> case.  (Or does it?  Is userspace/systemd finally smart enough to freeze
> filesystems?)

From looking at the commit described below, it appears to do some
basic superblock sanity checks, and then it checks to see if the last
commited transaction has changed from what has been recorded in the
superblock.

The simple stupid thing I could add in ext4 is to simply make a full
copy of the ext4 superblock, and if *anything* in that 1k set of bytes
has changed between the freeze and the thaw, call ext4_error(), and mark
the file system corrupted.

We've been talking about changing the default for ext4 to remount the
file system read-only, and if we did this then the behavior would be
the same as btrfs.  Or maybe in the specific case of the superblock
has changed between freeze and thaw, we will always remount the file
system read-only.

> > For XFS, it will detect the corruption at touch time, return -EUCLEAN.
> > (Without the cache drop, XFS seems to be very happy using the cache info
> > to do the work without any error though.)
> 
> Yep.

I would suggest not putting this test in generic/NNN, but put it in
shared, and to let each file system opt-in to this test.  There are a
whole bunch of file systems such such as jfs, reiserfs, vfat, exfat,
etc., which could run this test, and depending on the specifics of how
a file system might behave to determine whether the test "passes" or
"fails" seems wrong.

After all, what you're really doing is protecting against a specific
form of "stupid user trick", and other Linux file systems happen to do
something different when you completely trash the file system by
overwriting the block device with 0xcd, callign what some other file
system, whether it be f2fs, exfat, overlayfs, nfs, as a "failure"
doesn't seem right.

Moving it into shared also means you don't have to add extra checks to
make sure the test gets skipped if there is no block device to trash
(for example, if you are testing overlayfs, nfs, tmpfs, etc.)

Cheers,

					- Ted
