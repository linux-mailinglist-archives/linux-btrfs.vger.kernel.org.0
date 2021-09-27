Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6322B41A187
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 23:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237464AbhI0Vxf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 17:53:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50442 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbhI0Vxe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 17:53:34 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out2.suse.de (Postfix) with ESMTP id 18CA71FF82;
        Mon, 27 Sep 2021 21:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632779515;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8kMrr3VhHnzebrdvz6T5P7jc2wgoTNA8hGpza+cBBq0=;
        b=o+3zuvtqjjVIVyimj30btafOZkOjDV8bkE/HSJSo/BQq1kwmNa8DglKW7fIOKq3Kwb7yYP
        DEK3XBs768jm0r2FXM2A6hdcbthMW42jWcXuw/jgd92mOuXm3d/hWU9+D3JlJAvtl4mhxF
        xedOjAOpadSsFIaMxqemfwYUw/LsAw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632779515;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8kMrr3VhHnzebrdvz6T5P7jc2wgoTNA8hGpza+cBBq0=;
        b=Qo+jW0OhZ1A3pKGpIyYpcSLFCrqt0aYloRhBq+Bfh2Qiwvqgogxyj6kADvUQx7Nnt8dZdJ
        Me4zVZr/b6VBbrCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay1.suse.de (Postfix) with ESMTP id B739325D3E;
        Mon, 27 Sep 2021 21:51:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 51601DA7A9; Mon, 27 Sep 2021 23:51:39 +0200 (CEST)
Date:   Mon, 27 Sep 2021 23:51:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 0/5] btrfs-progs: use direct-IO for zoned device
Message-ID: <20210927215139.GJ9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20210927041554.325884-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927041554.325884-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 27, 2021 at 01:15:49PM +0900, Naohiro Aota wrote:
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
> Patch 1 is a preparation not to set an emulated zone_size value when not
> needed.
> 
> Patches 2 and 3 wraps pread/pwrite with newly introduced function
> btrfs_pread/btrfs_pwrite.
> 
> Patches 4 deals with the zoned flag while reading the initial trees.
> 
> Patch 5 finally opens a zoned device with O_DIRECT.
> 
> Naohiro Aota (5):
>   btrfs-progs: mkfs: do not set zone size on non-zoned mode
>   btrfs-progs: introduce btrfs_pwrite wrapper for pwrite
>   btrfs-progs: introduce btrfs_pread wrapper for pread
>   btrfs-progs: temporally set zoned flag for initial tree reading
>   btrfs-progs: use direct-IO for zoned device

I was doing some btrfs-convert changes and found that it crashed, rough
bisection points to this series. With the last patch applied, convert
fails with the following ASAN error:

...
Create initial btrfs filesystem
Create ext2 image file
AddressSanitizer:DEADLYSIGNAL
=================================================================
==18432==ERROR: AddressSanitizer: SEGV on unknown address (pc 0x000000496627 bp 0x7ffe5299e4d0 sp 0x7ffe5299e4b0 T0)
==18432==The signal is caused by a READ memory access.
==18432==Hint: this fault was caused by a dereference of a high value address (see register values below).  Dissassemble the provided pc to learn which register was used.
    #0 0x496627 in write_extent_to_disk kernel-shared/extent_io.c:815
    #1 0x470080 in write_and_map_eb kernel-shared/disk-io.c:525
    #2 0x411af9 in migrate_one_reserved_range convert/main.c:402
    #3 0x411fa5 in migrate_reserved_ranges convert/main.c:459
    #4 0x414088 in create_image convert/main.c:878
    #5 0x416d70 in do_convert convert/main.c:1269
    #6 0x41a294 in main convert/main.c:1993
    #7 0x7f7ef7c2753f in __libc_start_call_main (/lib64/libc.so.6+0x2d53f)
    #8 0x7f7ef7c275eb in __libc_start_main_alias_1 (/lib64/libc.so.6+0x2d5eb)
    #9 0x40ed04 in _start (.../btrfs-progs/btrfs-convert+0x40ed04)

kernel-shared/extent_io.c:815:

 811 int write_extent_to_disk(struct extent_buffer *eb)
 812 {
 813         int ret;
 814         ret = btrfs_pwrite(eb->fd, eb->data, eb->len, eb->dev_bytenr,
 815                            eb->fs_info->zoned);
 816         if (ret < 0)
 817                 goto out;
 818         if (ret != eb->len) {
 819                 ret = -EIO;
 820                 goto out;
 821         }
 822         ret = 0;
 823 out:
 824         return ret;
 825 }
