Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1B93DCC89
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Aug 2021 18:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhHAQA2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Aug 2021 12:00:28 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33116 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232190AbhHAP6e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Aug 2021 11:58:34 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 171Fvijf020195
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 1 Aug 2021 11:57:45 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4940915C3DD2; Sun,  1 Aug 2021 11:57:44 -0400 (EDT)
Date:   Sun, 1 Aug 2021 11:57:44 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eryu Guan <guan@eryu.me>
Cc:     Josef Bacik <josef@toxicpanda.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: generic/204: fail if the mkfs fails
Message-ID: <YQbEeAYqXAAMGn7G@mit.edu>
References: <fe1cd52ce8954e5aee1fc0a4baf5c75ef7d2635a.1627590942.git.josef@toxicpanda.com>
 <YQaWmtw5/OoXm26Z@desktop>
 <YQaZUK880CRVf6Sn@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQaZUK880CRVf6Sn@desktop>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 01, 2021 at 08:53:36PM +0800, Eryu Guan wrote:
> > So the underlying disk is 1TB in size, and we ended up using this 1T
> > filesystem when _scratch_mkfs_sized failed?
> > 
> > But we have done _try_wipe_scratch_devs before each test to make sure we
> > don't use previous scratch dev accidently (just like this case), and the
> > subsesquent _scratch_mount will fail and fail the whole test. So it's
> > not clear to me what caused the failure you hit.

The call to _try_wipe_scratch_devs was added in 2019.  My commit to
add:

	|| _notrun "mkfs.${FSTYP} failed"

dates from 2017.  So the reason I was seeing the problem was because
it was before we started running wipefs between tests.

That being said, I've checked a recent test run, and the _notrun
hasn't triggered recently.  Looking at the git history, it looks like
a large number of tests had their arguments to _scratch_mkfs_sized
adjusted upwards to avoid failures when running with 64k block sizes
on powerpc.

Going back to generic/204, I see why Josef ran into issues, however.
even though we are running wipefs before each test.  In the case of
generic/204, it runs _scratch_mkfs to determine the blocksize, and
then it runs _scratch_mkfs_sized --- and if it fails, the file system
is left at the full size of the scratch file system, and then
generic/204 takes a vey long time.

So even if we can rely on wipefs causing the tests to fail, maybe we
should just add a check for mkfs failure to _scratch_mkfs_sized?  I
think that's a better fix than Josef's proposed patch to generic/204.
One benefit of adding the check to _scratch_mkfs_sized is we can
supply a clearer explanation of the failure since the failure would be
"mkfs failed" as opposed to "mount: /vdc: wrong fs type, bad option,
bad superblock on /dev/vdc, missing codepage or helper program, or
other error."

It might also make sense to adjust the size passed to
_scratch_mkfs_sized in generic/204 to be a something slightly larger,
since otherwise it's pretty much guaranteed that generic/204 will
start failing on PowerPC when testing with a 64k block size.

Cheers,

						- Ted
