Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 318E715F7EF
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 21:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgBNUp7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 15:45:59 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43755 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgBNUp7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 15:45:59 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so7877185qtj.10
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2020 12:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wvWeHQR7gnvhyFcIq+ebbZwZM2D7X9oj8XTuNAoMQLc=;
        b=MlhyLVhhmLzVHjMXRb+X3KOPrqGoqqScjzcbCnRxL1R3swmCjlN6UvhwdmJkrUaP3l
         od6q2jQ8uXbb7gNEyNK4qTmxe4A0CGLQ0aQ8+g89aVT6lyQouGQUX0QevrH1LltnlS8w
         Ic20nbWV0LWPWZLkM4eNsB4+b8b8PRCt2MnZngazNSH9JDLs3p/7DASS6zDTC1f0pgQ5
         WHRR7Y8ZEv/SlY7V0N0qbhNe5V7BSrtwuapVfp2TjeZA0FmKtZOt3AaJ0i4cvT4SUGrW
         CHUAtoSwBxonZOQeKlCnBDOW38GJBB8bwyom74VUW2Ze5FI33Y/vA878ME5oNMmgLFL3
         Yp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wvWeHQR7gnvhyFcIq+ebbZwZM2D7X9oj8XTuNAoMQLc=;
        b=KNnWbAWCduz96LV7OdLilszw/TzIDHG7onWokKNIH3qDn7tORFBZew4CRD9BF8NjYx
         r5JzsNWYImWd+kqupVpnuqrhxFZDVsKacuW6WXevIYyr5rgGvIwuO8SNxZREFY/VPMAJ
         Qw4ZDjp+eSQ/pUIW92GWx2tEMMBjFL8GKBWIVnO7U9gKOwrOKhrTrymi9auEi+e5/V61
         raTaY/JEhhP84NbhlJbeXi5nsaFuPJj5MWFThEB5xJ7rIo/GJMIFKbWyZuc2Iol0Fm+2
         geuLAA6LIE8skDzW/c72eQo2IFQJPeDicVJ15wM/D+ybcK6bZPisTEkQ+kHG8Eu5P9ki
         Eegg==
X-Gm-Message-State: APjAAAU8v+rWGDRpyJVVZpFUFFrBuuo6/EvmWwUBaJy5y0wCWYim8nd1
        gmv+TU5Y8/hZunwGkkFiGQeYh12qzfs=
X-Google-Smtp-Source: APXvYqwXbQovESCeBuJ1ISEqaww4LSWEq7lE8slvPF2vNtriZmw5N2UtijsbqiNhinyyiSeseb49bA==
X-Received: by 2002:ac8:6f0b:: with SMTP id g11mr4079749qtv.308.1581713155945;
        Fri, 14 Feb 2020 12:45:55 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::c065])
        by smtp.gmail.com with ESMTPSA id z21sm4122002qka.122.2020.02.14.12.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 12:45:53 -0800 (PST)
Subject: Re: [PATCH] Btrfs: avoid unnecessary splits when setting bits on an
 extent io tree
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200213102002.6176-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <152c9721-8c15-f976-c9ac-df04e01f63ce@toxicpanda.com>
Date:   Fri, 14 Feb 2020 15:45:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200213102002.6176-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/13/20 5:20 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When attempting to set bits on a range of an exent io tree that already
> has those bits set we can end up splitting an extent state record, use
> the preallocated extent state record, insert it into the red black tree,
> do another search on the red black tree, merge the preallocated extent
> state record with the previous extent state record, remove that previous
> record from the red black tree and then free it. This is all unnecessary
> work that consumes time.
> 
> This happens specifically at the following case at __set_extent_bit():
> 
>    $ cat -n fs/btrfs/extent_io.c
>     957  static int __must_check
>     958  __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
>    (...)
>    1044          /*
>    1045           *     | ---- desired range ---- |
>    1046           * | state |
>    1047           *   or
>    1048           * | ------------- state -------------- |
>    1049           *
>    (...)
>    1060          if (state->start < start) {
>    1061                  if (state->state & exclusive_bits) {
>    1062                          *failed_start = start;
>    1063                          err = -EEXIST;
>    1064                          goto out;
>    1065                  }
>    1066
>    1067                  prealloc = alloc_extent_state_atomic(prealloc);
>    1068                  BUG_ON(!prealloc);
>    1069                  err = split_state(tree, state, prealloc, start);
>    1070                  if (err)
>    1071                          extent_io_tree_panic(tree, err);
>    1072
>    1073                  prealloc = NULL;
> 
> So if our extent state represents a range from 0 to 1Mb for example, and
> we want to set bits in the range 128Kb to 256Kb for example, and that
> extent state record already has all those bits set, we end up splitting
> that record, so we end up with extent state records in the tree which
> represent the ranges from 0 to 128Kb and from 128Kb to 1Mb. This is
> temporary because a subsequent iteration in that function will end up
> merging the records.
> 
> The splitting requires using the preallocated extent state record, so
> a future iteration that needs to do another split will need to allocate
> another extent state record in an atomic context, something not ideal
> that we try to avoid as much as possible. The splitting also requires
> an insertion in the red black tree, and a subsequent merge will require
> a deletion from the red black tree and freeing an extent state record.
> 
> This change just skips the splitting of an extent state record when it
> already has all the bits the we need to set.
> 
> Setting a bit that is already set for a range is very common in the
> inode's 'file_extent_tree' extent io tree for example, where we keep
> setting the EXTENT_DIRTY bit every time we replace an extent.
> 
> This change also fixes a bug that happens after the recent patchset from
> Josef that avoids having implicit holes after a power failure when not
> using the NO_HOLES feature, more specifically the patch with the subject:
> 
>    "btrfs: introduce the inode->file_extent_tree"
> 
> This patch introduced an extent io tree per inode to keep track of
> completed ordered extents and figure out at any time what is the safe
> value for the inode's disk_i_size. This assumes that for contiguous
> ranges in a file we always end up with a single extent state record in
> the io tree, but that is not the case, as there is a short time window
> where we can have two extent state records representing contiguous
> ranges. When this happens we end setting up an incorrect value for the
> inode's disk_i_size, resulting in data loss after a clean unmount
> of the filesystem. The following example explains how this can happen.
> 
> Suppose we have an inode with an i_size and a disk_i_size of 1Mb, so in
> the inode's file_extent_tree we have a single extent state record that
> represents the range [0, 1Mb[ with the EXTENT_DIRTY bit set. Then the
> following steps happen:
> 
> 1) A buffered write against file range [512Kb, 768Kb[ is made. At this
>     point delalloc was not flushed yet;
> 
> 2) Deduplication from some other inode into this inode's range
>     [128Kb, 256Kb[ is made. This causes btrfs_inode_set_file_extent_range()
>     to be called, from btrfs_insert_clone_extent(), to mark the range
>     [128Kb, 256Kb[ with EXTENT_DIRTY in the inode's file_extent_tree;
> 
> 3) When btrfs_inode_set_file_extent_range() calls set_extent_bits(), we
>     end up at __set_extent_bit(). In the first iteration of that function's
>     loop we end up in the following branch:
> 
>     $ cat -n fs/btrfs/extent_io.c
>      957  static int __must_check
>      958  __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
>     (...)
>     1044          /*
>     1045           *     | ---- desired range ---- |
>     1046           * | state |
>     1047           *   or
>     1048           * | ------------- state -------------- |
>     1049           *
>     (...)
>     1060          if (state->start < start) {
>     1061                  if (state->state & exclusive_bits) {
>     1062                          *failed_start = start;
>     1063                          err = -EEXIST;
>     1064                          goto out;
>     1065                  }
>     1066
>     1067                  prealloc = alloc_extent_state_atomic(prealloc);
>     1068                  BUG_ON(!prealloc);
>     1069                  err = split_state(tree, state, prealloc, start);
>     1070                  if (err)
>     1071                          extent_io_tree_panic(tree, err);
>     1072
>     1073                  prealloc = NULL;
>     (...)
>     1089                  goto search_again;
> 
>     This splits the state record into two, one for range [0, 128Kb[ and
>     another for the range [128Kb, 1Mb[. Both already have the EXTENT_DIRTY
>     bit set. Then we jump to the 'search_again' label, where we unlock the
>     the spinlock protecting the extent io tree before jumping to the
>     'again' label to perform the next iteration;
> 
> 4) In the meanwhile, delalloc is flushed, the ordered extent for the range
>     [512Kb, 768Kb[ is created and when it completes, at
>     btrfs_finish_ordered_io(), it calls btrfs_inode_safe_disk_i_size_write()
>     with a value of 0 for its 'new_size' argument;
> 
> 5) Before the deduplication task currently at __set_extent_bit() moves to
>     the next iteration, the task finishing the ordered extent calls
>     find_first_extent_bit() through btrfs_inode_safe_disk_i_size_write()
>     and gets 'start' set to 0 and 'end' set to 128Kb - because at this
>     moment the io tree has two extent state records, one representing the
>     range [0, 128Kb[ and another representing the range [128Kb, 1Mb[,
>     both with EXTENT_DIRTY set. Then we set 'isize' to:
> 
>     isize = min(isize, end + 1)
>           = min(1Mb, 128Kb - 1 + 1)
>           = 128Kb
> 
>     Then we set the inode's disk_i_size to 128Kb (isize).
> 
>     After a clean unmount of the filesystem and mounting it again, we have
>     the file with a size of 128Kb, and effectively lost all the data it
>     had before in the range from 128Kb to 1Mb.
> 
> This change fixes that issue too, as we never end up splitting extent
> state records when they already have all the bits we want set.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Sorry, forgot to say

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
