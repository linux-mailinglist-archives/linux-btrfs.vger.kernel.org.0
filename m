Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB61424871
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 23:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbhJFVFD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 17:05:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57450 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239454AbhJFVFB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Oct 2021 17:05:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5619922596;
        Wed,  6 Oct 2021 21:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633554188;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tK9pn0u3csRVaYGwMdlTobLlYHtlIdXaLoh2f3GwHjs=;
        b=eKco7PZsvVQGwMoZArDMIafsHJ3ErVGVrO7k5rbOGAbjUSX/vxXD9wjOCo7DCcHvNb2p1V
        WEY0bUaOHonMVULw4vUAgewjSTn9iomZMX2dm0nDOS5VO/xzn6Oa5l+oFPTAjUua966Mgx
        eDW3wjuO5xPyLkxpkRh6dpU6IuVxNT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633554188;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tK9pn0u3csRVaYGwMdlTobLlYHtlIdXaLoh2f3GwHjs=;
        b=I+bftsmjpG8ANNUKWitwRhGxuiSp1BMyF6VXPd8duSVJyobG4SHcmwhyHCIlI0XcSjXnmW
        5xE1z4X2NjtEEhAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 210F2A3B85;
        Wed,  6 Oct 2021 21:03:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9E097DA7F3; Wed,  6 Oct 2021 23:02:47 +0200 (CEST)
Date:   Wed, 6 Oct 2021 23:02:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2 0/7] btrfs-progs: use direct-IO for zoned device
Message-ID: <20211006210247.GY9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20211005062305.549871-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005062305.549871-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 05, 2021 at 03:22:58PM +0900, Naohiro Aota wrote:
> As discussed in the Zoned Storage page [1],  the kernel page cache does not
> guarantee that cached dirty pages will be flushed to a block device in
> sequential sector order. Thus, we must use O_DIRECT for writing to a zoned
> device to ensure the write ordering.
> 
> [1] https://zonedstorage.io/linux/overview/#zbd-support-restrictions
> 
> As a writng buffer is embedded in some other struct (e.g., "char data[]" in
> struct extent_buffer), it is difficult to allocate the struct so that the
> writng buffer is aligned.
> 
> This series introduces btrfs_{pread,pwrite} to wrap around pread/pwrite,
> which allocates an aligned bounce buffer, copy the buffer contents, and
> proceeds the IO. And, it now opens a zoned device with O_DIRECT.
> 
> Since the allocation and copying are costly, it is better to do them only
> when necessary. But, it is cumbersome to call fcntl(F_GETFL) to determine
> the file is opened with O_DIRECT or not every time doing an IO.
> 
> As zoned device forces to use zoned btrfs, I decided to use the zoned flag
> to determine if it is direct-IO or not. This can cause a false-positive (to
> use the bounce buffer when a file is *not* opened with O_DIRECT) in case of
> emulated zoned mode on a non-zoned device or a regular file. Considering
> the emulated zoned mode is mostly for debugging or testing, I believe this
> is acceptable.
> 
> * Changes
> v2
>   - Rebased on the latest "devel" branch
>   - Add patch to fix segfault in several cases
>   - drop ZONED flag from BTRFS_CONVERT_ALLOWED_FEATURES
> 
> Patches 1 to 3 are preparation to fix some issues in the current code.
> 
> Patches 4 and 5 wraps pread/pwrite with newly introduced function
> btrfs_pread/btrfs_pwrite.
> 
> Patch 6 deals with the zoned flag while reading the initial trees.
> 
> Patch 7 finally opens a zoned device with O_DIRECT.
> 
> Naohiro Aota (7):
>   btrfs-progs: mkfs: do not set zone size on non-zoned mode
>   btrfs-progs: set eb->fs_info properly
>   btrfs-progs: drop ZONED flag from BTRFS_CONVERT_ALLOWED_FEATURES
>   btrfs-progs: introduce btrfs_pwrite wrapper for pwrite
>   btrfs-progs: introduce btrfs_pread wrapper for pread
>   btrfs-progs: temporally set zoned flag for initial tree reading
>   btrfs-progs: use direct-io for zoned device

Is this still supposed to work?

  $ ./mkfs.btrfs -f -O zoned -d single -m single img
  ...
  ERROR: 16384 is not aligned to 1048576
  ERROR: error during mkfs: Input/output error

On commit below this patchset it works and creates a filesystem with
zoned mode and zone size 256M.
