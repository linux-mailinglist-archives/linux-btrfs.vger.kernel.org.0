Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0724BBC5A
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 16:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbiBRPpF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 10:45:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiBRPpE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 10:45:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6B3258639
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:44:47 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DE75A1F37E;
        Fri, 18 Feb 2022 15:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645199085;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8yDlEGgT+zzQFSZhWmYurGkP2ysp+TTFt+tlwZUSFO4=;
        b=olYr5JjAsZmuksQbTbfm7cVZjBRhIymek1DBE3fGRF2JA3GadqFfdk+tbxd2bpnf/nK253
        PaS/0tTtwZE4kj5UyEXmBmgwCw/O7eXZvmyaKsToGI8SJXvn+YeyOMfkySp9rgzddK8dPH
        w3W0CV40sLF2PAti+OoXVuvW3Ft8OQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645199085;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8yDlEGgT+zzQFSZhWmYurGkP2ysp+TTFt+tlwZUSFO4=;
        b=fZxU+ok8HBMqHfSpgDXOXECIGBFzpnPGFUaK7bd3HSaDp41A+QXxwjoTN8Oy2SGaJZ1vFM
        Nbqpa0UMuG0IdEAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D486CA3B87;
        Fri, 18 Feb 2022 15:44:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 31743DA829; Fri, 18 Feb 2022 16:41:00 +0100 (CET)
Date:   Fri, 18 Feb 2022 16:41:00 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v13 00/17] btrfs: add ioctls and send/receive support for
 reading/writing compressed data
Message-ID: <20220218154059.GX12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1644519257.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1644519257.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 10, 2022 at 11:09:50AM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This series has three parts: new Btrfs ioctls for reading/writing
> compressed data, support for sending compressed data via Btrfs send, and
> btrfs-progs support for sending/receiving compressed data and writing it
> with the new ioctl.
> 
> Patches 1 and 2 are VFS changes exporting a couple of helpers for checks
> needed by reads and writes. Patches 3-8 are preparatory Btrfs changes
> for compressed reads and writes. Patch 6 is a cleanup. Patch 9 adds the
> compressed read ioctl and patch 10 adds the compressed write ioctl.
> 
> The main use-case for this interface is Btrfs send/receive. Currently,
> when sending data from one compressed filesystem to another, the sending
> side decompresses the data and the receiving side recompresses it before
> writing it out. This is wasteful and can be avoided if we can just send
> and write compressed extents.
> 
> Patches 11 and 12 are cleanups for Btrfs send. Patches 13-17 add the
> Btrfs send support. See the previous posting for more details and
> benchmarks [1]. Patches 13-15 prepare some protocol changes for send
> stream v2. Patch 16 implements compressed send. Patch 17 enables send
> stream v2 and compressed send in the send ioctl when requested.
> 
> These patches are based on Dave Sterba's Btrfs misc-next branch [2],
> which is in turn currently based on v5.17-rc3. Test cases are here [3].
> 
> Changes since v12 [4]:
> 
> - Changed some LZO code to use filesystem sector size instead of page
>   size.
> - Changed to use btrfs_inode_lock() instead of inode_lock().
> - Added explanation of why we don't need to hold mmap lock for encoded
>   reads to commit message.
> - Got rid of GFP_HIGHMEM allocations.
> - Changed send protocol definitions to use explicit numbers.
> - Changed btrfs send patch to default to protocol v1 for now.
> - Style cleanups.
> 
> 1: https://lore.kernel.org/linux-btrfs/cover.1615922753.git.osandov@fb.com/
> 2: https://github.com/kdave/btrfs-devel/tree/misc-next
> 3: https://github.com/osandov/xfstests/tree/btrfs-encoded-io
> 4: https://lore.kernel.org/linux-btrfs/cover.1637179348.git.osandov@fb.com/
> 
> Omar Sandoval (17):
>   fs: export rw_verify_area()
>   fs: export variant of generic_write_checks without iov_iter
>   btrfs: don't advance offset for compressed bios in
>     btrfs_csum_one_bio()
>   btrfs: add ram_bytes and offset to btrfs_ordered_extent
>   btrfs: support different disk extent size for delalloc
>   btrfs: clean up cow_file_range_inline()
>   btrfs: optionally extend i_size in cow_file_range_inline()
>   btrfs: add definitions + documentation for encoded I/O ioctls
>   btrfs: add BTRFS_IOC_ENCODED_READ
>   btrfs: add BTRFS_IOC_ENCODED_WRITE
>   btrfs: send: remove unused send_ctx::{total,cmd}_send_size
>   btrfs: send: explicitly number commands and attributes
>   btrfs: add send stream v2 definitions
>   btrfs: send: write larger chunks when using stream v2
>   btrfs: send: allocate send buffer with alloc_page() and vmap() for v2
>   btrfs: send: send compressed extents with encoded writes
>   btrfs: send: enable support for stream v2 and compressed writes
> 
>  fs/btrfs/compression.c     |  10 +-
>  fs/btrfs/compression.h     |   6 +-
>  fs/btrfs/ctree.h           |  19 +-
>  fs/btrfs/delalloc-space.c  |  18 +-
>  fs/btrfs/file-item.c       |  32 +-
>  fs/btrfs/file.c            |  68 ++-
>  fs/btrfs/inode.c           | 930 +++++++++++++++++++++++++++++++++----
>  fs/btrfs/ioctl.c           | 208 +++++++++
>  fs/btrfs/ordered-data.c    | 131 ++----
>  fs/btrfs/ordered-data.h    |  25 +-
>  fs/btrfs/relocation.c      |   2 +-
>  fs/btrfs/send.c            | 324 +++++++++++--
>  fs/btrfs/send.h            | 142 +++---
>  fs/internal.h              |   5 -
>  fs/read_write.c            |  34 +-
>  include/linux/fs.h         |   2 +
>  include/uapi/linux/btrfs.h | 142 +++++-
>  17 files changed, 1760 insertions(+), 338 deletions(-)
> 
> The btrfs-progs patches were written by Boris Burkov with some updates
> from me. Patches 1-4 are preparation. Patch 5 implements encoded writes.
> Patch 6 implements the fallback to decompressing. Patches 7 and 8
> implement the other commands. Patch 9 adds the new `btrfs send` options.
> Patch 10 adds a test case.
> 
> Boris Burkov (8):
>   btrfs-progs: receive: support v2 send stream larger tlv_len
>   btrfs-progs: receive: dynamically allocate sctx->read_buf
>   btrfs-progs: receive: support v2 send stream DATA tlv format
>   btrfs-progs: receive: process encoded_write commands
>   btrfs-progs: receive: encoded_write fallback to explicit decode and
>     write
>   btrfs-progs: receive: process fallocate commands
>   btrfs-progs: receive: process setflags ioctl commands
>   btrfs-progs: receive: add tests for basic encoded_write send/receive
> 
> Omar Sandoval (2):
>   btrfs-progs: receive: add send stream v2 cmds and attrs to send.h
>   btrfs-progs: send: stream v2 ioctl flags

Patches 1-10 (the encoded ioctls) are now in misc-next.
