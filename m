Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0A4428CB7
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 14:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbhJKMMQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 08:12:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52516 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbhJKMMP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 08:12:15 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7ADD121DA2;
        Mon, 11 Oct 2021 12:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633954214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KOnb83whqKLpXLvl616rsUYRUCFIIt+C1NqQ9WUDdCs=;
        b=lZiy5PLP9zj3Db1ekTw62S/A76GpiQ9Mb+Ky0vVS+CKVywu62dovUV/M+3DHnv4cEt7+FU
        R55sNu4PEiGd+FYVowCG1r+sV1zUkGXI4gX1Cp+LAM4GGXkEAgRU40hi/tm7NznpBqrTnV
        pePKD7Am9VubORqS99LdC6fJR8Rcacw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 546C413C5E;
        Mon, 11 Oct 2021 12:10:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wF8cEqYpZGFvbQAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 11 Oct 2021 12:10:14 +0000
Subject: Re: [PATCH v2 0/3] btrfs-progs: mkfs: make sure we can clean up all
 temporary chunks
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20211011120650.179017-1-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <c97120d6-d599-5882-57ef-6f7534660dda@suse.com>
Date:   Mon, 11 Oct 2021 15:10:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211011120650.179017-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.10.21 г. 15:06, Qu Wenruo wrote:
> There is a bug report that with certain mkfs options, mkfs.btrfs may
> fail to cleanup some temporary chunks, leading to "btrfs filesystem df"
> warning about multiple profiles:
> 
>   WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
>   WARNING:   Metadata: single, raid1 
> 
> The easiest way to reproduce is "mkfs.btrfs -f -R free-space-tree -m dup
> -d dup".
> 
> It turns out that, the old _recow_root() can not handle tree levels > 0,
> while with newer free space tree creation timing, the free space tree
> can reach level 1 or higher.
> 
> To fix the problem, Patch 2 will do the proper full tree re-CoW, with
> extra transaction commitment to make sure all free space tree get
> re-CoWed.
> 
> The 3rd patch will do the extra verification during mkfs-tests.
> 
> The first patch is just to fix a confusing parameter which also caused
> u64 -> int width reduction and can be problematic in the future.
> 
> Changelog:
> v2:
> - Remove a duplicated recow_roots() call in create_raid_groups()
>   This call makes no difference as we will later commit transaction
>   and manually call recow_roots() again.
>   Remove such duplicated call to save some time.
> 
> - Replace the btrfs_next_sibling_tree_block() with btrfs_next_leaf()
>   Since we're always handling leaves, there is no need for
>   btrfs_next_sibling_tree_block()
> 
> - Work around a kernel bug which may cause false alerts
>   For single device RAID0, btrfs kernel is not respecting it, and will
>   allocate new chunks using SINGLE instead.
>   This can be very noisy and cause false alerts, and not always
>   reproducible, depending on how fast kernel creates new chunks.
> 
>   Work around it by mounting the RO before calling "btrfs fi df".
> 
>   The kernel bug needs to be investigated and fixed.
It's better to see the kernel bug fixed rather than papering over it.

> 
> 
> Qu Wenruo (3):
>   btrfs-progs: rename @data parameter to @profile in extent allocation
>     path
>   btrfs-progs: mkfs: recow all tree blocks properly
>   btrfs-progs: mfks-tests: make sure mkfs.btrfs cleans up temporary
>     chunks
> 
>  kernel-shared/extent-tree.c                 | 26 +++---
>  mkfs/main.c                                 | 90 ++++++++++++++++++---
>  tests/mkfs-tests/001-basic-profiles/test.sh | 16 +++-
>  3 files changed, 104 insertions(+), 28 deletions(-)
> 
