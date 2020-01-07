Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79FB7132DEC
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 19:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgAGSFA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 13:05:00 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:33694 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbgAGSFA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 13:05:00 -0500
Received: by mail-qk1-f174.google.com with SMTP id d71so239599qkc.0
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jan 2020 10:04:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=z8qAYyzTXy/wSe8qtYcevgaVoopS0M9KMgvkeab+iug=;
        b=jYSOk6vBQk1jTVoPGIkhiOssDVPWg2eH69a6rjjg/jLgVU7zzChzZ/od0M7j9hmSEt
         0NCOa2GYTCiEmKKAILuAE3lWfx7piId5hl8NzqEkrvqWsTqXno5IfZjbhG97BJgkpkvp
         c2MxzcHR8kOSJEj1XLHUyYPLFJONwLLbgZI28ieKCmh+kcx6gjFdZoljqKRlAKCiAdHV
         6rP5QUCW32mVtyhtWhut0bSjG0K0FhgUQDEs+RraixuK0aVKnXMLEymY52HOwGsHfaS/
         yTWSox/JUMPVWYDRFiTELi/7GErkTM7v9MJ+/uCZEilxUCGKoiceiq5WMLdQL947d9H1
         BLlQ==
X-Gm-Message-State: APjAAAX709vNidJPga+5zfmbEhYJxcso1zSOK6bTiwtSYOM1mwQLxoPu
        2EAGWYsTlORnCJeneVcgxwkSgJAD
X-Google-Smtp-Source: APXvYqy/yDvWjcWlNjpzE9Svmu1IUlqzuqFZ/aAE+KN2FdHEHGlQwRaFSXEnaddGdrRvCmFGrD3Vpg==
X-Received: by 2002:a37:4702:: with SMTP id u2mr598172qka.106.1578420298949;
        Tue, 07 Jan 2020 10:04:58 -0800 (PST)
Received: from dennisz-mbp ([2620:10d:c091:500::2:412a])
        by smtp.gmail.com with ESMTPSA id z141sm163608qkb.63.2020.01.07.10.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 10:04:58 -0800 (PST)
Date:   Tue, 7 Jan 2020 13:04:56 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Johannes Thumshirn <jth@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, linux-btrfs@vger.kernel.org
Subject: Re: memleaks in btrfs-devel/misc-next
Message-ID: <20200107180456.GA30329@dennisz-mbp>
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

Thanks for reporting this. I'm looking into it now. Do you know what the
refcount of the object is and other state related to it?

Thanks,
Dennis
