Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C719F124E3D
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 17:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfLRQrK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 11:47:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:56874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfLRQrK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 11:47:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 69696AD31;
        Wed, 18 Dec 2019 16:47:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6C271DA791; Wed, 18 Dec 2019 17:47:06 +0100 (CET)
Date:   Wed, 18 Dec 2019 17:47:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Aditya Pakki <pakki001@umn.edu>, kjlu@umn.edu,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove BUG_ON used as assertions
Message-ID: <20191218164706.GP3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Aditya Pakki <pakki001@umn.edu>, kjlu@umn.edu,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191215171237.27482-1-pakki001@umn.edu>
 <2f9d6549-47cf-fb71-3bff-50b51093e757@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f9d6549-47cf-fb71-3bff-50b51093e757@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 18, 2019 at 11:38:18AM -0500, Josef Bacik wrote:
> On 12/15/19 12:12 PM, Aditya Pakki wrote:
> > alloc_extent_state_atomic() allocates extents via GFP_ATOMIC flag
> > and cannot fail. There are multiple invocations of BUG_ON on the
> > return value to check for failure. The patch replaces certain
> > invocations of BUG_ON by returning the error upstream.
> > 
> > Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> 
> I already tried this a few months ago and gave up.  There are a few things if 
> you want to tackle something like this
> 
> 1) use bpf's error injection thing to make sure you handle every path that can 
> error out.  This is the script I wrote to do just that
> 
> https://github.com/josefbacik/debug-scripts/blob/master/error-injection-stress.py
> 
> 2) We actually can't fail here.  We would need to go back and make _all_ callers 
> of lock_extent_bits() handle the allocation error.  This is theoretically 
> possible, but a giant pain in the ass.  In general we can make allocations here 
> and we need to be able to make them.
> 
> 3) We should probably mark this path with __GFP_NOFAIL because again, this is 
> locking and we need locking to succeed.

NOFAIL can introduce loops that could lead to deadlocks, if not used
carefully. __set_extent_bit is not just locking, so if one thread wants
to set bits, allocate, wait, allocator goes to write some memory

eg.

set_extent_bit on some range
  alloc state (NOFAIL)
    allocator wants to flush dome dirty data
                   ------------------------------>
		                               set_extent_bit
					         alloc state (NOFAIL)
						 (wait)
