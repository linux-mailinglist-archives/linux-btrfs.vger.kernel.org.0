Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE2E7169EBC
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 07:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBXGqR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 01:46:17 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:32852 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726452AbgBXGqQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 01:46:16 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01O6k6hK015170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Feb 2020 01:46:07 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 99E9D4211EF; Mon, 24 Feb 2020 01:46:05 -0500 (EST)
Date:   Mon, 24 Feb 2020 01:46:05 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: btrfs: sleeping function called from invalid context
Message-ID: <20200224064605.GA1258811@mit.edu>
References: <20200223234246.GA1208467@mit.edu>
 <0c0fa96f-60d6-6a66-3542-d78763bbe269@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c0fa96f-60d6-6a66-3542-d78763bbe269@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 24, 2020 at 02:28:22AM +0200, Nikolay Borisov wrote:
> So this is fallout from 28553fa992cb28be6a65566681aac6cafabb4f2d because
> it's being called while we have locked extent buffers (before calling
> btrfs_free_Path which is holding a rwlock (a variant of spinlock). And
> actually unlocking btrfs' extent requires allocating structures to
> reflect the new state. This allocation is currently done with GFP_NOFS
> which implies DIRECT_RECLAIM hence the maybe sleep from slab allocator
> is triggered.
> 
> Filipe, can the unlock be done _after_ freeing the path or even better -
> reduce the critical section altogether in btrfs_truncate_inode_items?
> 
> I don't think '[PATCH] Btrfs: fix deadlock during fast fsync when
> logging prealloc extents beyond eof' actually fixes the problem since
> the unlock can happen under the path again.

Hmm... I don't know if the problem has been *completely* fixed, but I
can say that with -rc3 (which has the "fix deadlock during fast fsync
when..." commit), I'm no longer seeing the kernel complaints when I
run "gce-xfstests -c btrfs -g auto".  Here are the test results:

TESTRUNID: tytso-20200223230308
KERNEL:    kernel 5.6.0-rc3-xfstests #1522 SMP Sun Feb 23 23:01:10 EST 2020 x86_64
CMDLINE:   -c btrfs -g auto
CPUS:      2
MEM:       7680

btrfs/default: 988 tests, 8 failures, 203 skipped, 8739 seconds
  Failures: btrfs/056 btrfs/153 btrfs/204 generic/065 generic/260 
    generic/475 generic/562 shared/298 
Totals: 785 tests, 203 skipped, 8 failures, 0 errors, 8678s

FSTESTIMG: gce-xfstests/xfstests-202002211357
FSTESTPRJ: gce-xfstests
FSTESTVER: blktests f7b47c5 (Tue, 11 Feb 2020 14:22:21 -0800)
FSTESTVER: e2fsprogs v1.45.4-15-g4b4f7b35 (Wed, 9 Oct 2019 20:25:01 -0400)
FSTESTVER: fio  fio-3.18 (Wed, 5 Feb 2020 07:59:58 -0700)
FSTESTVER: fsverity v1.0 (Wed, 6 Nov 2019 10:35:02 -0800)
FSTESTVER: ima-evm-utils v1.2 (Fri, 26 Jul 2019 07:42:17 -0400)
FSTESTVER: nvme-cli v1.10.1 (Tue, 7 Jan 2020 13:55:21 -0700)
FSTESTVER: quota  9a001cc (Tue, 5 Nov 2019 16:12:59 +0100)
FSTESTVER: util-linux v2.35 (Tue, 21 Jan 2020 11:15:21 +0100)
FSTESTVER: xfsprogs v5.4.0 (Fri, 20 Dec 2019 16:47:12 -0500)
FSTESTVER: xfstests-bld a7ae9ff (Tue, 18 Feb 2020 14:22:36 -0500)
FSTESTVER: xfstests linux-v3.8-2692-g3fe2fd0d (Fri, 21 Feb 2020 13:42:43 -0500)
FSTESTCFG: btrfs
FSTESTSET: -g auto
FSTESTOPT: aex
GCE ID:    9110223165715314154

If you want the full test artifacts for this run, in case you want to
dig into the test failures, let me know; I'm happy to send them.  The
compressed tarfile is is 1952k, so it's a bit too large for the vger
mailing list.

Cheers,

						- Ted
