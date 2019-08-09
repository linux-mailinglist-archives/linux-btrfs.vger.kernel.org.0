Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F041987A04
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2019 14:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406882AbfHIMb0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Aug 2019 08:31:26 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55939 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406871AbfHIMbX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Aug 2019 08:31:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 464l3F4BlGz9sP7;
        Fri,  9 Aug 2019 22:31:21 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     bugzilla-daemon@bugzilla.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [Bug 204371] BUG kmalloc-4k (Tainted: G        W        ): Object padding overwritten
In-Reply-To: <bug-204371-206035-3TOBxXIdie@https.bugzilla.kernel.org/>
References: <bug-204371-206035@https.bugzilla.kernel.org/> <bug-204371-206035-3TOBxXIdie@https.bugzilla.kernel.org/>
Date:   Fri, 09 Aug 2019 22:31:21 +1000
Message-ID: <8736iatt9i.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

bugzilla-daemon@bugzilla.kernel.org writes:
> https://bugzilla.kernel.org/show_bug.cgi?id=204371
>
> --- Comment #10 from David Sterba (dsterba@suse.com) ---
> In my case it happened on 5.3-rc3, with a strestest. The same machine has been
> running fstests periodically, with slab debug on, but there are no slab reports
> like that.
>
> [ 8516.870046] BUG kmalloc-4k (Not tainted): Poison overwritten                 
> [ 8516.875873]
> -----------------------------------------------------------------------------   
>
> [ 8516.885864] Disabling lock debugging due to kernel taint                     
> [ 8516.891312] INFO: 0x000000001c70c8c9-0x000000003cd1e164. First byte 0x16
> instead of 0x6b                                                                 
> [ 8516.899717] INFO: Allocated in btrfs_read_tree_root+0x46/0x120 [btrfs]
> age=1769 cpu=7 pid=8717                                                         
> [ 8516.908544]  __slab_alloc.isra.53+0x3e/0x70                                  
> [ 8516.912861]  kmem_cache_alloc_trace+0x1b0/0x330                              
> [ 8516.917581]  btrfs_read_tree_root+0x46/0x120 [btrfs]                         
> [ 8516.922737]  btrfs_read_fs_root+0xe/0x40 [btrfs]                             
> [ 8516.927552]  create_reloc_root+0x17f/0x2a0 [btrfs]                           
> [ 8516.932536]  btrfs_init_reloc_root+0x72/0xe0 [btrfs]                         
> [ 8516.937686]  record_root_in_trans+0xbb/0xf0 [btrfs]                          
> [ 8516.942750]  btrfs_record_root_in_trans+0x50/0x70 [btrfs]                    
> [ 8516.948340]  start_transaction+0xa1/0x550 [btrfs]                            
> [ 8516.953237]  __btrfs_prealloc_file_range+0xca/0x490 [btrfs]                  
> [ 8516.959003]  btrfs_prealloc_file_range+0x10/0x20 [btrfs]                     
> [ 8516.964509]  prealloc_file_extent_cluster+0x13e/0x2b0 [btrfs]                
> [ 8516.970447]  relocate_file_extent_cluster+0x8d/0x530 [btrfs]                 
> [ 8516.976305]  relocate_data_extent+0x80/0x110 [btrfs]                         
> [ 8516.981469]  relocate_block_group+0x473/0x720 [btrfs]                        
> [ 8516.986711]  btrfs_relocate_block_group+0x15f/0x2c0 [btrfs]                  

So this is looking more like it could be a btrfs bug, given you've both
hit it using btrfs but on different platforms.

cheers
