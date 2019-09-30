Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38709C28DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 23:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfI3Vdu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 17:33:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:55220 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727720AbfI3Vdu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 17:33:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 564A5B15D;
        Mon, 30 Sep 2019 18:12:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 93675DA88C; Mon, 30 Sep 2019 20:12:54 +0200 (CEST)
Date:   Mon, 30 Sep 2019 20:12:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix memory leak due to concurrent append writes
 with fiemap
Message-ID: <20190930181254.GC2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190930092025.31118-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930092025.31118-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 30, 2019 at 10:20:25AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When we have a buffered write that starts at an offset greater than or
> equals to the file's size happening concurrently with a full ranged
> fiemap, we can end up leaking an extent state structure.
> 
> Suppose we have a file with a size of 1Mb, and before the buffered write
> and fiemap are performed, it has a single extent state in its io tree
> representing the range from 0 to 1Mb, with the EXTENT_DELALLOC bit set.
> 
> The following sequence diagram shows how the memory leak happens if a
> fiemap a buffered write, starting at offset 1Mb and with a length of
> 4Kb, are performed concurrently.
> 
>           CPU 1                                                  CPU 2
> 
>   extent_fiemap()
>     --> it's a full ranged fiemap
>         range from 0 to LLONG_MAX - 1
>         (9223372036854775807)
> 
>     --> locks range in the inode's
>         io tree
>       --> after this we have 2 extent
>           states in the io tree:
>           --> 1 for range [0, 1Mb[ with
>               the bits EXTENT_LOCKED and
>               EXTENT_DELALLOC_BITS set
>           --> 1 for the range
>               [1Mb, LLONG_MAX[ with
>               the EXTENT_LOCKED bit set
> 
>                                                   --> start buffered write at offset
>                                                       1Mb with a length of 4Kb
> 
>                                                   btrfs_file_write_iter()
> 
>                                                     btrfs_buffered_write()
>                                                       --> cached_state is NULL
> 
>                                                       lock_and_cleanup_extent_if_need()
>                                                         --> returns 0 and does not lock
>                                                             range because it starts
>                                                             at current i_size / eof
> 
>                                                       --> cached_state remains NULL
> 
>                                                       btrfs_dirty_pages()
>                                                         btrfs_set_extent_delalloc()
>                                                           (...)
>                                                           __set_extent_bit()
> 
>                                                             --> splits extent state for range
>                                                                 [1Mb, LLONG_MAX[ and now we
>                                                                 have 2 extent states:
> 
>                                                                 --> one for the range
>                                                                     [1Mb, 1Mb + 4Kb[ with
>                                                                     EXTENT_LOCKED set
>                                                                 --> another one for the range
>                                                                     [1Mb + 4Kb, LLONG_MAX[ with
>                                                                     EXTENT_LOCKED set as well
> 
>                                                             --> sets EXTENT_DELALLOC on the
>                                                                 extent state for the range
>                                                                 [1Mb, 1Mb + 4Kb[
>                                                             --> caches extent state
>                                                                 [1Mb, 1Mb + 4Kb[ into
>                                                                 @cached_state because it has
>                                                                 the bit EXTENT_LOCKED set
> 
>                                                     --> btrfs_buffered_write() ends up
>                                                         with a non-NULL cached_state and
>                                                         never calls anything to release its
>                                                         reference on it, resulting in a
>                                                         memory leak
> 
> Fix this by calling free_extent_state() on cached_state if the range was
> not locked by lock_and_cleanup_extent_if_need().
> 
> The same issue can happen if anything else other than fiemap locks a range
> that covers eof and beyond.
> 
> This could be triggered, sporadically, by test case generic/561 from the
> fstests suite, which makes duperemove run concurrently with fsstress, and
> duperemove does plenty of calls to fiemap. When CONFIG_BTRFS_DEBUG is set
> the leak is reported in dmesg/syslog when removing the btrfs module with
> a message like the following:
> 
>   [77100.039461] BTRFS: state leak: start 6574080 end 6582271 state 16402 in tree 0 refs 1
> 
> Otherwise (CONFIG_BTRFS_DEBUG not set) detectable with kmemleak.
> 
> CC: stable@vger.kernel.org # 4.16+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Nice one, added to 5.4 queue, thanks.
