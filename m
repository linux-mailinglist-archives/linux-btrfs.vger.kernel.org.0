Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F30356C35
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Apr 2021 14:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352230AbhDGMfk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Apr 2021 08:35:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:59726 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352228AbhDGMfi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Apr 2021 08:35:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4D3C7B029;
        Wed,  7 Apr 2021 12:35:28 +0000 (UTC)
Subject: Re: unexpected -ENOMEM from percpu_counter_init()
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-mm@kvack.org
References: <20210401185158.3275.409509F4@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <60e9b994-e37c-d059-4af5-0cb7860ca4f3@suse.cz>
Date:   Wed, 7 Apr 2021 14:35:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210401185158.3275.409509F4@e16-tech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

+CC btrfs

On 4/1/21 12:51 PM, Wang Yugui wrote:
> Hi,
> 
> an unexpected -ENOMEM from percpu_counter_init() happened when xfstest 
> with kernel 5.11.10 and 5.10.27

Is there a dmesg log showing allocation failure or something?

> direct caller:
> int btrfs_drew_lock_init(struct btrfs_drew_lock *lock)
> {
>     int ret;
> 
>     ret = percpu_counter_init(&lock->writers, 0, GFP_KERNEL);
>     if (ret)
>         return ret;
> 
>     atomic_set(&lock->readers, 0);
>     init_waitqueue_head(&lock->pending_readers);
>     init_waitqueue_head(&lock->pending_writers);
> 
>     return 0;
> }
> 
> upper caller:
>     nofs_flag = memalloc_nofs_save();
>     ret = btrfs_drew_lock_init(&root->snapshot_lock);
>     memalloc_nofs_restore(nofs_flag);
>     if (ret == -ENOMEM) printk("ENOMEM btrfs_drew_lock_init\n");
>     if (ret)
>         goto fail;
> 
> The hardware of this server:
> CPU:  Xeon(R) CPU E5-2660 v2(10 core)  *2
> memory:  192G, no swap
> 
> Only one xfstests job is running in this server, and about 7% of memory
> is used.
> 
> Any advice please.
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/04/01
> 
> 

