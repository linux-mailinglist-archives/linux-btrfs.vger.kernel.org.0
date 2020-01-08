Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2671713456C
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 15:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgAHOzR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 09:55:17 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42367 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgAHOzR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jan 2020 09:55:17 -0500
Received: by mail-qt1-f193.google.com with SMTP id j5so2964266qtq.9
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jan 2020 06:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TKmjx/hYFW7dcmOea8BHZr+efiUj1M9OR6XPj+wxOzo=;
        b=x0GenQe9UyupIC0PkRfthwYodi4ae8sfB0kKH/1l+Bh+cQpyLGEazUSewuxwa5BErN
         U42sSFQKPKp4lI7LzWotp9PHnCcTd6ZOzG0XzR+i8VUlz54b18H6E79+aU4V/+DJS51I
         yWVexstQK9PAAUcly0Q98ImBXu4iW8/XMOTaoNGYbnpLWor224QkF9OIKvH6qu0Q9Zvo
         1yus+YfS7mhZMRk+9W+dMXllbDhsjgjt3HNy5jA60hVW9Qz994kNGGpQaNBfrxFHjGDO
         ppFQxBGUPuzLBbvlLPZ5RGsm74EdX7tIRLKhbhUezYsdYgijGgJ3gpfZtl77XpnFKpSN
         m7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TKmjx/hYFW7dcmOea8BHZr+efiUj1M9OR6XPj+wxOzo=;
        b=W6hjiGApzx6Hw5+Ou4bCOjrsPBXANK5FxzIz3ns5Dd/5tjS0YAxHI3wGKxe593hH9J
         g5S/20tjy8330kvlYrp9V5zJSEvgpZN5UuB/7Z5vzkFWSnSdQYUsElwxDXVhZJTH8lAB
         pxsWtkJqvJOYEjVTymimNlC8mvDOZtTCbvFLySI2RnAqxJuziBQr4VBNPgK9a64IbX0W
         fsskikx/sp2YsXfaE9jbEZ1TBHY1hXSvF5UYpJQfJEk/q19L4Omw0vma4hPIZDn41TfH
         0nSC4pfcu0YWAxK4ljLCFXn6MSUdmcQC94/uuGBfPyTjN/7cmd0Q1y54Odl49+GqEu/G
         CYXg==
X-Gm-Message-State: APjAAAX0N4pANEik/u0yRWClyE3HC30FYjj6MMahDICHmdfhHoZgH2z/
        qgYEw2xlgbWEpyycgQzdYFvOKg==
X-Google-Smtp-Source: APXvYqyrPGBqv9tJFET4Apsa7WalarOQqo6EvRvTSoFX+pAgEtSch6OMq5NK0DJcLpGUqDxIW3LLaQ==
X-Received: by 2002:ac8:6747:: with SMTP id n7mr3867825qtp.224.1578495315232;
        Wed, 08 Jan 2020 06:55:15 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::f832])
        by smtp.gmail.com with ESMTPSA id 184sm1441064qke.73.2020.01.08.06.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 06:55:14 -0800 (PST)
Subject: Re: [PATCH v2] btrfs: relocation: Fix KASAN reports caused by
 extended reloc tree lifespan
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
References: <20200108051200.8909-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7482d2f3-f3a1-7dd9-6003-9042c1781207@toxicpanda.com>
Date:   Wed, 8 Jan 2020 09:55:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200108051200.8909-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/8/20 12:12 AM, Qu Wenruo wrote:
> [BUG]
> There are several different KASAN reports for balance + snapshot
> workloads.
> Involved call paths include:
> 
>     should_ignore_root+0x54/0xb0 [btrfs]
>     build_backref_tree+0x11af/0x2280 [btrfs]
>     relocate_tree_blocks+0x391/0xb80 [btrfs]
>     relocate_block_group+0x3e5/0xa00 [btrfs]
>     btrfs_relocate_block_group+0x240/0x4d0 [btrfs]
>     btrfs_relocate_chunk+0x53/0xf0 [btrfs]
>     btrfs_balance+0xc91/0x1840 [btrfs]
>     btrfs_ioctl_balance+0x416/0x4e0 [btrfs]
>     btrfs_ioctl+0x8af/0x3e60 [btrfs]
>     do_vfs_ioctl+0x831/0xb10
>     ksys_ioctl+0x67/0x90
>     __x64_sys_ioctl+0x43/0x50
>     do_syscall_64+0x79/0xe0
>     entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>     create_reloc_root+0x9f/0x460 [btrfs]
>     btrfs_reloc_post_snapshot+0xff/0x6c0 [btrfs]
>     create_pending_snapshot+0xa9b/0x15f0 [btrfs]
>     create_pending_snapshots+0x111/0x140 [btrfs]
>     btrfs_commit_transaction+0x7a6/0x1360 [btrfs]
>     btrfs_mksubvol+0x915/0x960 [btrfs]
>     btrfs_ioctl_snap_create_transid+0x1d5/0x1e0 [btrfs]
>     btrfs_ioctl_snap_create_v2+0x1d3/0x270 [btrfs]
>     btrfs_ioctl+0x241b/0x3e60 [btrfs]
>     do_vfs_ioctl+0x831/0xb10
>     ksys_ioctl+0x67/0x90
>     __x64_sys_ioctl+0x43/0x50
>     do_syscall_64+0x79/0xe0
>     entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>     btrfs_reloc_pre_snapshot+0x85/0xc0 [btrfs]
>     create_pending_snapshot+0x209/0x15f0 [btrfs]
>     create_pending_snapshots+0x111/0x140 [btrfs]
>     btrfs_commit_transaction+0x7a6/0x1360 [btrfs]
>     btrfs_mksubvol+0x915/0x960 [btrfs]
>     btrfs_ioctl_snap_create_transid+0x1d5/0x1e0 [btrfs]
>     btrfs_ioctl_snap_create_v2+0x1d3/0x270 [btrfs]
>     btrfs_ioctl+0x241b/0x3e60 [btrfs]
>     do_vfs_ioctl+0x831/0xb10
>     ksys_ioctl+0x67/0x90
>     __x64_sys_ioctl+0x43/0x50
>     do_syscall_64+0x79/0xe0
>     entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> [CAUSE]
> All these call sites are only relying on root->reloc_root, which can
> undergo btrfs_drop_snapshot(), and since we don't have real refcount
> based protection to reloc roots, we can reach already dropped reloc
> root, triggering KASAN.
> 
> [FIX]
> To avoid such access to unstable root->reloc_root, we should check
> BTRFS_ROOT_DEAD_RELOC_TREE bit first.
> 
> This patch introduces a new wrapper, have_reloc_root(), to do the proper
> check for most callers who don't distinguish merged reloc tree and no
> reloc tree.
> 
> The only exception is should_ignore_root(), as merged reloc tree can be
> ignored, while no reloc tree shouldn't.
> 
> [CRITICAL SECTION ANALYSE]
> Although test_bit()/set_bit()/clear_bit() doesn't imply a barrier, the
> DEAD_RELOC_TREE bit has extra help from transaction as a higher level
> barrier, the lifespan of root::reloc_root and DEAD_RELOC_TREE bit are:
> 
> 	NULL: reloc_root is NULL	PTR: reloc_root is not NULL
> 	0: DEAD_RELOC_ROOT bit not set	DEAD: DEAD_RELOC_ROOT bit set
> 
> 	(NULL, 0)    Initial state		 __
> 	  |					 /\ Section A
>          btrfs_init_reloc_root()			 \/
> 	  |				 	 __
> 	(PTR, 0)     reloc_root initialized      /\
>            |					 |
> 	btrfs_update_reloc_root()		 |  Section B
>            |					 |
> 	(PTR, DEAD)  reloc_root has been merged  \/
>            |					 __
> 	=== btrfs_commit_transaction() ====================
> 	  |					 /\
> 	clean_dirty_subvols()			 |
> 	  |					 |  Section C
> 	(NULL, DEAD) reloc_root cleanup starts   \/
>            |					 __
> 	btrfs_drop_snapshot()			 /\
> 	  |					 |  Section D
> 	(NULL, 0)    Back to initial state	 \/
> 
> Very have_reloc_root() or test_bit(DEAD_RELOC_ROOT) caller has hold a
> transaction handler, so none of such caller can cross transaction
> boundary.
> 
> In Section A, every caller just found no DEAD bit, and grab reloc_root.
> 
> In the cross section A-B, caller may get no DEAD bit, but since
> reloc_root is still completely valid thus accessing reloc_root is
> completely safe.
> 
> No test_bit() caller can cross the boundary of Section B and Section C.
> 
> In Section C, every caller found the DEAD bit, so no one will access
> reloc_root.
> 
> In the cross section C-D, either caller gets the DEAD bit set, avoiding
> access reloc_root no matter if it's safe or not.
> Or caller get the DEAD bit cleared, then access reloc_root, which is
> already NULL, nothing will be wrong.
> 
> Here we need extra memory barrier in cross section C-D, to ensure
> proper memory order between reloc_root and clear_bit().
> 
> In Section D, since no DEAD bit and no reloc_root, it's back to initial
> state.
> 
> With this lifespan, it should be clear only one memory barrier is
> needed, between setting reloc_root to NULL and clearing DEAD_RELOC_ROOT
> bit.
> 
> Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots")
> Suggested-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Add the [CRITICAL SECTION ANALYSE] part
>    This gets me into the rabbit hole of memory ordering, but thanks for
>    the help from David (initially mentioning the mb hell) and Nikolay
>    (for the proper doc), finally I could explain clearly why only
>    one mb is needed.
> - Add comment for the only needed memory barrier.
> ---
>   fs/btrfs/relocation.c | 32 ++++++++++++++++++++++++++++----
>   1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index d897a8e5e430..17a2484f76a5 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -517,6 +517,22 @@ static int update_backref_cache(struct btrfs_trans_handle *trans,
>   	return 1;
>   }
>   
> +/*
> + * Check if this subvolume tree has valid reloc(*) tree.
> + *
> + * *: Reloc tree after swap is considered dead, thus not considered as valid.
> + *    This is enough for most callers, as they don't distinguish dead reloc
> + *    root from no reloc root.
> + *    But should_ignore_root() below is a special case.
> + */
> +static bool have_reloc_root(struct btrfs_root *root)
> +{
> +	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
> +		return false;

You still need a smp_mb__after_atomic() here, test_bit is unordered.  Thanks,

Josef
