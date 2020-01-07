Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE57A132516
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 12:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgAGLne (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 06:43:34 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:32849 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbgAGLnd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 06:43:33 -0500
Received: by mail-wr1-f50.google.com with SMTP id b6so53631155wrq.0
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jan 2020 03:43:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=4ts7EH7jwLxMYXvhGxU65EDBpcRpupoHoRbIPE5wAEA=;
        b=afReqVpWvcCch1BzqAstt5qFn5wZ8vL1QPnRXpU+JFA01u1u4eztKXsr6rcGeeOTZq
         CwX+IgobkGvop3a0NV+7E788HJaiyvJE8vSkirQp7f7/gFq+yhcRR3/fQIGOyo64b9gT
         JboetXyQgsQimwQOwMjGbUiU57SSiED+fUQjA/spQxFR6ETHQg1eGnGTgrd1IV9AMONP
         XOEraT0Tui/pPrFlZwQNGG+QsTKQSq011nZUtypO3nYEJBA9WBZAqbK0kUVWUCIxapvX
         6CEWqwK9OnsfUI38krMQAFklihepQr/yMBq8t7Vdr7PJknlHfeBRWcNyXQXSgTVrp2fj
         iPoQ==
X-Gm-Message-State: APjAAAWvv+cghVypuQ8KthNCJCeaDr8rbfjsCv13XWKVOKi4fgmyUiGS
        CQtkNlv+Kf6fKHrnSQRcjZ5DcVMt
X-Google-Smtp-Source: APXvYqxc+OnpEN/6KeBXDcjgUEvha2Wz6jUnorbpVjgoXUa8+Yo5PmbSoPE1CzqbOis6qGXisNkRUw==
X-Received: by 2002:adf:d848:: with SMTP id k8mr105393815wrl.328.1578397411607;
        Tue, 07 Jan 2020 03:43:31 -0800 (PST)
Received: from Johanness-MBP.fritz.box (ppp-46-244-208-11.dynamic.mnet-online.de. [46.244.208.11])
        by smtp.gmail.com with ESMTPSA id s19sm26159469wmj.33.2020.01.07.03.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 03:43:31 -0800 (PST)
Cc:     linux-btrfs@vger.kernel.org
To:     Dennis Zhou <dennis@kernel.org>
From:   Johannes Thumshirn <jth@kernel.org>
Subject: memleaks in btrfs-devel/misc-next
Message-ID: <b3cfdb33-11d6-b237-c00f-60e1e51f1848@kernel.org>
Date:   Tue, 7 Jan 2020 12:43:30 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Dennis,

When I'm running btrfs/003 and btrfs/004 in my test setup I get the
following kmemleak report:

rapido1:/home/johannes/src/xfstests-dev# cat results/btrfs/004.kmemleak
EXPERIMENTAL kmemleak reported some memory leaks!  Due to the way kmemleak
works, the leak might be from an earlier test, or something totally
unrelated.
unreferenced object 0xffff88821eee3c00 (size 1024):                 
  comm "mount", pid 7247, jiffies 4294900263 (age 26.468s)          
  hex dump (first 32 bytes):                     
    00 b0 ca 2a 82 88 ff ff 00 00 00 00 00 00 00 00  ...*............    
    00 00 00 00 00 00 00 00 00 00 10 00 00 00 00 00  ................
  backtrace:                                            
    [<00000000f993bddc>] btrfs_create_block_group_cache+0x20/0x1a0 [btrfs]
    [<00000000e0df8aa6>] btrfs_read_block_groups+0x42f/0x780 [btrfs]
    [<00000000792a6ecd>] open_ctree+0x17a8/0x1e93 [btrfs]           
    [<0000000042fa9fb8>] btrfs_mount_root+0x4e1/0x5a0 [btrfs]       
    [<00000000586791fa>] legacy_get_tree+0x22/0x40      
    [<00000000cb72e180>] vfs_get_tree+0x1b/0x90                          
    [<0000000059613ba1>] fc_mount+0x9/0x30                         
    [<00000000a752e56e>] vfs_kern_mount.part.40+0x6a/0x80
    [<000000000524dce6>] btrfs_mount+0x138/0x860 [btrfs]    
    [<00000000586791fa>] legacy_get_tree+0x22/0x40
    [<00000000cb72e180>] vfs_get_tree+0x1b/0x90
    [<000000005f5112f8>] do_mount+0x674/0x900
    [<000000007ead6809>] __x64_sys_mount+0x81/0xd0
    [<0000000028386837>] do_syscall_64+0x43/0x140
    [<00000000e8583d73>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
unreferenced object 0xffff88821cbdfb40 (size 192):
  comm "mount", pid 7247, jiffies 4294900263 (age 26.468s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 cc 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000042643477>] btrfs_create_block_group_cache+0x3d/0x1a0 [btrfs]
    [<00000000e0df8aa6>] btrfs_read_block_groups+0x42f/0x780 [btrfs]
    [<00000000792a6ecd>] open_ctree+0x17a8/0x1e93 [btrfs]
    [<0000000042fa9fb8>] btrfs_mount_root+0x4e1/0x5a0 [btrfs]
    [<00000000586791fa>] legacy_get_tree+0x22/0x40
    [<00000000cb72e180>] vfs_get_tree+0x1b/0x90
    [<0000000059613ba1>] fc_mount+0x9/0x30
    [<00000000a752e56e>] vfs_kern_mount.part.40+0x6a/0x80
    [<000000000524dce6>] btrfs_mount+0x138/0x860 [btrfs]
    [<00000000586791fa>] legacy_get_tree+0x22/0x40
    [<00000000cb72e180>] vfs_get_tree+0x1b/0x90
    [<000000005f5112f8>] do_mount+0x674/0x900
    [<000000007ead6809>] __x64_sys_mount+0x81/0xd0
    [<0000000028386837>] do_syscall_64+0x43/0x140
    [<00000000e8583d73>] entry_SYSCALL_64_after_hwframe+0x44/0xa9


I've bisected it down to:
63c3d72cf65e ("btrfs: add the beginning of async discard, discard
workqueue")

The backtrace points to this:
(gdb) l *(btrfs_create_block_group_cache+0x20)
0xa8060 is in btrfs_create_block_group_cache (fs/btrfs/block-group.c:1641).
1636                    struct btrfs_fs_info *fs_info, u64 start, u64 size)
1637    {
1638            struct btrfs_block_group *cache;
1639
1640            cache = kzalloc(sizeof(*cache), GFP_NOFS);
1641            if (!cache)
1642                    return NULL;
1643
1644            cache->free_space_ctl =
kzalloc(sizeof(*cache->free_space_ctl),
1645                                            GFP_NOFS);
(gdb) l *(btrfs_create_block_group_cache+0x3d)
0xa807d is in btrfs_create_block_group_cache (fs/btrfs/block-group.c:1646).
1641            if (!cache)
1642                    return NULL;
1643
1644            cache->free_space_ctl =
kzalloc(sizeof(*cache->free_space_ctl),
1645                                            GFP_NOFS);
1646            if (!cache->free_space_ctl) {
1647                    kfree(cache);
1648                    return NULL;
1649            }
1650


so we're leaking both cache and cache->free_space_ctl.

I'm looking into it right now but maybe you're faster seeing what's
missing here.

Byte,
    Johannes
