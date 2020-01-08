Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBC91337EE
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 01:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgAHAbI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 19:31:08 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40144 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgAHAbI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 19:31:08 -0500
Received: by mail-qt1-f196.google.com with SMTP id e6so1372268qtq.7
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jan 2020 16:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pgTOPQlI7aKJAlovFHED8ayJoUc69hFTUWbCBQJNYXA=;
        b=GmYlYOzqGqtbCYKP006tIaLRTuy8Hv1SsN9fOnsmAU3kLlex+zVDAroAI6N7aNd0a4
         vSf8aVxYxxo0dbLbGYB3BCGbV7y3JL1Pni6SZYPHHjf43lI0TRX2p4dSE1mtyAxjw/GX
         nZXYxEMfMjr6t0SXm1cLjNO22pXKDnHYxVe47a/+76SMDdTDUDgIY9tCzGe2BbG9Y10t
         IsncUAFg/6qtOxN03iTXuiSposPLF+rQMAUIRILCuJBCyQKwB0sgGi0fzeipjcZdmXX5
         djbgA2FD68lfBYIFJ9GCozPN7JGESn6fBCKamEKzeqCDpY7ePSL7k06L5SKcjeVhYaQn
         c6lg==
X-Gm-Message-State: APjAAAVl0cwGAIneMvzEJDTgfT3QGFS1QgNQsW90c2EFyUechFAnox1k
        pPcraJ3ipw79qkeR7XD31IeJVhHj
X-Google-Smtp-Source: APXvYqyXz4RMZr7YG2iphOAJ3UIkftZCButF0jAZgAxa+gcSWcd/AjO/EthUc2LS7aAiGv+Mix7gdw==
X-Received: by 2002:ac8:31f0:: with SMTP id i45mr1433693qte.327.1578443467062;
        Tue, 07 Jan 2020 16:31:07 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:480::7af4])
        by smtp.gmail.com with ESMTPSA id z4sm611932qkz.62.2020.01.07.16.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:31:06 -0800 (PST)
Date:   Tue, 7 Jan 2020 19:31:04 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Johannes Thumshirn <jth@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, linux-btrfs@vger.kernel.org
Subject: Re: memleaks in btrfs-devel/misc-next
Message-ID: <20200108003104.GA41934@dennisz-mbp.dhcp.thefacebook.com>
References: <b3cfdb33-11d6-b237-c00f-60e1e51f1848@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3cfdb33-11d6-b237-c00f-60e1e51f1848@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 07, 2020 at 12:43:30PM +0100, Johannes Thumshirn wrote:
> Hi Dennis,
> 
> When I'm running btrfs/003 and btrfs/004 in my test setup I get the
> following kmemleak report:
> 
> rapido1:/home/johannes/src/xfstests-dev# cat results/btrfs/004.kmemleak
> EXPERIMENTAL kmemleak reported some memory leaks!  Due to the way kmemleak
> works, the leak might be from an earlier test, or something totally
> unrelated.
> unreferenced object 0xffff88821eee3c00 (size 1024):                 
>   comm "mount", pid 7247, jiffies 4294900263 (age 26.468s)          
>   hex dump (first 32 bytes):                     
>     00 b0 ca 2a 82 88 ff ff 00 00 00 00 00 00 00 00  ...*............    
>     00 00 00 00 00 00 00 00 00 00 10 00 00 00 00 00  ................
>   backtrace:                                            
>     [<00000000f993bddc>] btrfs_create_block_group_cache+0x20/0x1a0 [btrfs]
>     [<00000000e0df8aa6>] btrfs_read_block_groups+0x42f/0x780 [btrfs]
>     [<00000000792a6ecd>] open_ctree+0x17a8/0x1e93 [btrfs]           
>     [<0000000042fa9fb8>] btrfs_mount_root+0x4e1/0x5a0 [btrfs]       
>     [<00000000586791fa>] legacy_get_tree+0x22/0x40      
>     [<00000000cb72e180>] vfs_get_tree+0x1b/0x90                          
>     [<0000000059613ba1>] fc_mount+0x9/0x30                         
>     [<00000000a752e56e>] vfs_kern_mount.part.40+0x6a/0x80
>     [<000000000524dce6>] btrfs_mount+0x138/0x860 [btrfs]    
>     [<00000000586791fa>] legacy_get_tree+0x22/0x40
>     [<00000000cb72e180>] vfs_get_tree+0x1b/0x90
>     [<000000005f5112f8>] do_mount+0x674/0x900
>     [<000000007ead6809>] __x64_sys_mount+0x81/0xd0
>     [<0000000028386837>] do_syscall_64+0x43/0x140
>     [<00000000e8583d73>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> unreferenced object 0xffff88821cbdfb40 (size 192):
>   comm "mount", pid 7247, jiffies 4294900263 (age 26.468s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 cc 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<0000000042643477>] btrfs_create_block_group_cache+0x3d/0x1a0 [btrfs]
>     [<00000000e0df8aa6>] btrfs_read_block_groups+0x42f/0x780 [btrfs]
>     [<00000000792a6ecd>] open_ctree+0x17a8/0x1e93 [btrfs]
>     [<0000000042fa9fb8>] btrfs_mount_root+0x4e1/0x5a0 [btrfs]
>     [<00000000586791fa>] legacy_get_tree+0x22/0x40
>     [<00000000cb72e180>] vfs_get_tree+0x1b/0x90
>     [<0000000059613ba1>] fc_mount+0x9/0x30
>     [<00000000a752e56e>] vfs_kern_mount.part.40+0x6a/0x80
>     [<000000000524dce6>] btrfs_mount+0x138/0x860 [btrfs]
>     [<00000000586791fa>] legacy_get_tree+0x22/0x40
>     [<00000000cb72e180>] vfs_get_tree+0x1b/0x90
>     [<000000005f5112f8>] do_mount+0x674/0x900
>     [<000000007ead6809>] __x64_sys_mount+0x81/0xd0
>     [<0000000028386837>] do_syscall_64+0x43/0x140
>     [<00000000e8583d73>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> 
> I've bisected it down to:
> 63c3d72cf65e ("btrfs: add the beginning of async discard, discard
> workqueue")
> 
> The backtrace points to this:
> (gdb) l *(btrfs_create_block_group_cache+0x20)
> 0xa8060 is in btrfs_create_block_group_cache (fs/btrfs/block-group.c:1641).
> 1636                    struct btrfs_fs_info *fs_info, u64 start, u64 size)
> 1637    {
> 1638            struct btrfs_block_group *cache;
> 1639
> 1640            cache = kzalloc(sizeof(*cache), GFP_NOFS);
> 1641            if (!cache)
> 1642                    return NULL;
> 1643
> 1644            cache->free_space_ctl =
> kzalloc(sizeof(*cache->free_space_ctl),
> 1645                                            GFP_NOFS);
> (gdb) l *(btrfs_create_block_group_cache+0x3d)
> 0xa807d is in btrfs_create_block_group_cache (fs/btrfs/block-group.c:1646).
> 1641            if (!cache)
> 1642                    return NULL;
> 1643
> 1644            cache->free_space_ctl =
> kzalloc(sizeof(*cache->free_space_ctl),
> 1645                                            GFP_NOFS);
> 1646            if (!cache->free_space_ctl) {
> 1647                    kfree(cache);
> 1648                    return NULL;
> 1649            }
> 1650
> 
> 
> so we're leaking both cache and cache->free_space_ctl.
> 
> I'm looking into it right now but maybe you're faster seeing what's
> missing here.
> 
> Byte,
>     Johannes

I believe it's because I forgot to put a reference in the relocation
path. The below seems to fix it in my tests, but would you mind
verifying?

Thanks,
Dennis

--
From: Dennis Zhou <dennis@kernel.org>
Date: Tue, 7 Jan 2020 14:14:04 -0800
Subject: [PATCH] btrfs: put lookup reference in btrfs_relocate_chunk()

Async discard requires looking up the block_group in the relocation path
to cancel any work items against it. However, I forgot to put the
reference from btrfs_lookup_block_group().

Reported-by: Johannes Thumshirn <jth@kernel.org>
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/volumes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 65e78e59d5c4..eb55df0d4038 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2898,6 +2898,7 @@ static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	if (!block_group)
 		return -ENOENT;
 	btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
+	btrfs_put_block_group(block_group);
 
 	trans = btrfs_start_trans_remove_block_group(root->fs_info,
 						     chunk_offset);
-- 
2.17.1

