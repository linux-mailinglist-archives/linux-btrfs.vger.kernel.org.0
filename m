Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7B4356CF3
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Apr 2021 15:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344328AbhDGNJW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Apr 2021 09:09:22 -0400
Received: from out20-2.mail.aliyun.com ([115.124.20.2]:48730 "EHLO
        out20-2.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244018AbhDGNJO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Apr 2021 09:09:14 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04462136|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0133605-0.000248439-0.986391;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.JwOA6aC_1617800942;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JwOA6aC_1617800942)
          by smtp.aliyun-inc.com(10.147.40.200);
          Wed, 07 Apr 2021 21:09:02 +0800
Date:   Wed, 07 Apr 2021 21:09:07 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Subject: Re: unexpected -ENOMEM from percpu_counter_init()
Cc:     linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
        wangyugui@e16-tech.com
In-Reply-To: <60e9b994-e37c-d059-4af5-0cb7860ca4f3@suse.cz>
References: <20210401185158.3275.409509F4@e16-tech.com> <60e9b994-e37c-d059-4af5-0cb7860ca4f3@suse.cz>
Message-Id: <20210407210905.F790.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> +CC btrfs
> 
> On 4/1/21 12:51 PM, Wang Yugui wrote:
> > Hi,
> > 
> > an unexpected -ENOMEM from percpu_counter_init() happened when xfstest 
> > with kernel 5.11.10 and 5.10.27
> 
> Is there a dmesg log showing allocation failure or something?

When unexpected -ENOMEM of percpu_counter_init(), btrfs as upper caller
finally output something to dmesg.

And we add one trace to btrfs source to make sure that.
>     if (ret == -ENOMEM) printk("ENOMEM btrfs_drew_lock_init\n");


Now the reproduce frequency become from >50% to not happen or very slow
with the flowing change.

diff --git a/mm/percpu.c b/mm/percpu.c
index 6596a0a..0127be1 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -104,8 +104,8 @@
 /* chunks in slots below this are subject to being sidelined on failed alloc */
 #define PCPU_SLOT_FAIL_THRESHOLD	3
 
-#define PCPU_EMPTY_POP_PAGES_LOW	2
-#define PCPU_EMPTY_POP_PAGES_HIGH	4
+#define PCPU_EMPTY_POP_PAGES_LOW	8
+#define PCPU_EMPTY_POP_PAGES_HIGH	16
 
 #ifdef CONFIG_SMP
 /* default addr <-> pcpu_ptr mapping, override in asm/percpu.h if necessary */
diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 5e76af7..8cc091b 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -14,7 +14,7 @@
 
 /* enough to cover all DEFINE_PER_CPUs in modules */
 #ifdef CONFIG_MODULES
-#define PERCPU_MODULE_RESERVE		(8 << 10)
+#define PERCPU_MODULE_RESERVE		(32 << 10)
 #else
 #define PERCPU_MODULE_RESERVE		0
 #endif


Just some guess,
1) maybe some releationship to the trigger of 'vm.dirty_bytes=10737418240'.

this problem happen in 
server/T7610 with E5-2660v2 *2 and SSD/SAS(6Gb/s) and 192G memory
but not happen in
server/T620 with E5-2680v2 *2 and SSD/NVMe and 192G memory.

2) maybe some releationship to numa.
128G memory in node1(CPU1), and 64G in node2(CPU2)

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/04/07


> > direct caller:
> > int btrfs_drew_lock_init(struct btrfs_drew_lock *lock)
> > {
> >     int ret;
> > 
> >     ret = percpu_counter_init(&lock->writers, 0, GFP_KERNEL);
> >     if (ret)
> >         return ret;
> > 
> >     atomic_set(&lock->readers, 0);
> >     init_waitqueue_head(&lock->pending_readers);
> >     init_waitqueue_head(&lock->pending_writers);
> > 
> >     return 0;
> > }
> > 
> > upper caller:
> >     nofs_flag = memalloc_nofs_save();
> >     ret = btrfs_drew_lock_init(&root->snapshot_lock);
> >     memalloc_nofs_restore(nofs_flag);
> >     if (ret == -ENOMEM) printk("ENOMEM btrfs_drew_lock_init\n");
> >     if (ret)
> >         goto fail;
> > 
> > The hardware of this server:
> > CPU:  Xeon(R) CPU E5-2660 v2(10 core)  *2
> > memory:  192G, no swap
> > 
> > Only one xfstests job is running in this server, and about 7% of memory
> > is used.
> > 
> > Any advice please.
> > 
> > Best Regards
> > Wang Yugui (wangyugui@e16-tech.com)
> > 2021/04/01
> > 
> > 


