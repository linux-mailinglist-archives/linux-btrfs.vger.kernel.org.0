Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13907AA08C
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 22:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjIUUlK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 16:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjIUUk5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 16:40:57 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEED326A8;
        Thu, 21 Sep 2023 13:15:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 9F01C60173;
        Thu, 21 Sep 2023 22:15:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695327352; bh=iChgksPxgVI5zrbzqsNfRWBLn/bBIpJl1/eW/3TFk7E=;
        h=Date:To:Cc:From:Subject:From;
        b=hn2DRGBjhrBp7n2WcP5BjCLdJLX8RYRWC3m4liEA0wKHfitcMipt0QTnkJSf3Vvqf
         cAgKpJ3y5+Ypvg/siGPxWyTK0GXgqMYeird6xa+HtI27eGcEkkbvdSfuiM0rh4AZfA
         9ySE+3jPntH5wM6Y6HJtS7GKIEamiSPitAR7AQAtQ+mQ7l4V90bPZmGjnrLDxg/muN
         +gZX9hXEbkWgCIMK8Y5y7LykdjBar5YHSO7hzvgGZZsvfmI0ti66ZDo+wYDaqP0e4p
         yaibp1qugCqvOuDRO4xR0G2/1733H85lJd+vGwRqY/Q4+YUyBQmhQ8gs/0uzdHtPle
         fN4tkSvwME0+Q==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8XaLSxChDIBV; Thu, 21 Sep 2023 22:15:50 +0200 (CEST)
Received: from [192.168.1.6] (78-3-40-141.adsl.net.t-com.hr [78.3.40.141])
        by domac.alu.hr (Postfix) with ESMTPSA id 30B6760157;
        Thu, 21 Sep 2023 22:15:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695327350; bh=iChgksPxgVI5zrbzqsNfRWBLn/bBIpJl1/eW/3TFk7E=;
        h=Date:To:Cc:From:Subject:From;
        b=zhycNlTYyFR46DSgaLZbsRNO2bHmKWdeLmsifiCqJNRVt094pwboCbWyPrdmAVZF7
         XJHrYijuzCGl66DP9Nxci6o10ugz6zizADNDjK6I+W+eSu93GlY/7od71n3bCvutlT
         gORIOMrBHdxiNXgR584lEZAj0vPLkFPCUR2MVGH5P4l9kAwyRW1tpusQl+HNCbjboV
         +pKCaJ+3WEtje0i/z7jRY5KZmGrmp4czx7QXDdYLMKUzslTvWxn1Wa0KV3w/bJZ1iA
         K879I5ic0nrdQdrYKW/hK6EHFKXyy/KDKEC1W/qmKoeZ+wml/K0NpejPHOu+vhIuxu
         SBzadO+UrwfFA==
Message-ID: <01c15818-5765-408b-aff0-6c68b8c2a874@alu.unizg.hr>
Date:   Thu, 21 Sep 2023 22:15:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: BUG: KCSAN: data-race in btrfs_sync_log [btrfs] / btrfs_update_inode
 [btrfs]
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On the vanilla 6.6-rc2 torvalds kernel KCSAN reported this data-race:

[ 2690.990793] ==================================================================
[ 2690.991470] BUG: KCSAN: data-race in btrfs_sync_log [btrfs] / btrfs_update_inode [btrfs]

[ 2690.992804] write to 0xffff88811b57faf8 of 4 bytes by task 40555 on cpu 20:
[ 2690.992815] btrfs_sync_log (/home/marvin/linux/kernel/torvalds2/fs/btrfs/tree-log.c:2964) btrfs
[ 2690.993484] btrfs_sync_file (/home/marvin/linux/kernel/torvalds2/fs/btrfs/file.c:1954) btrfs
[ 2690.994149] vfs_fsync_range (/home/marvin/linux/kernel/torvalds2/fs/sync.c:188)
[ 2690.994161] __x64_sys_fsync (/home/marvin/linux/kernel/torvalds2/./include/linux/file.h:45 /home/marvin/linux/kernel/torvalds2/fs/sync.c:213 /home/marvin/linux/kernel/torvalds2/fs/sync.c:220 /home/marvin/linux/kernel/torvalds2/fs/sync.c:218 /home/marvin/linux/kernel/torvalds2/fs/sync.c:218)
[ 2690.994172] do_syscall_64 (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/common.c:50 /home/marvin/linux/kernel/torvalds2/arch/x86/entry/common.c:80)
[ 2690.994186] entry_SYSCALL_64_after_hwframe (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/entry_64.S:120)

[ 2690.994203] read to 0xffff88811b57faf8 of 4 bytes by task 5338 on cpu 21:
[ 2690.994214] btrfs_update_inode (/home/marvin/linux/kernel/torvalds2/fs/btrfs/transaction.h:175 /home/marvin/linux/kernel/torvalds2/fs/btrfs/inode.c:4016) btrfs
[ 2690.994877] btrfs_finish_one_ordered (/home/marvin/linux/kernel/torvalds2/fs/btrfs/inode.c:4028 /home/marvin/linux/kernel/torvalds2/fs/btrfs/inode.c:3139) btrfs
[ 2690.995541] btrfs_finish_ordered_io (/home/marvin/linux/kernel/torvalds2/fs/btrfs/inode.c:3230) btrfs
[ 2690.996205] finish_ordered_fn (/home/marvin/linux/kernel/torvalds2/fs/btrfs/ordered-data.c:304) btrfs
[ 2690.996871] btrfs_work_helper (/home/marvin/linux/kernel/torvalds2/fs/btrfs/async-thread.c:314) btrfs
[ 2690.997539] process_one_work (/home/marvin/linux/kernel/torvalds2/kernel/workqueue.c:2630)
[ 2690.997551] worker_thread (/home/marvin/linux/kernel/torvalds2/kernel/workqueue.c:2697 /home/marvin/linux/kernel/torvalds2/kernel/workqueue.c:2784)
[ 2690.997562] kthread (/home/marvin/linux/kernel/torvalds2/kernel/kthread.c:388)
[ 2690.997571] ret_from_fork (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/process.c:147)
[ 2690.997583] ret_from_fork_asm (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/entry_64.S:312)

[ 2690.997598] value changed: 0x00000004 -> 0x00000005

[ 2690.997613] Reported by Kernel Concurrency Sanitizer on:
[ 2690.997621] CPU: 21 PID: 5338 Comm: kworker/u65:7 Tainted: G             L     6.6.0-rc2-kcsan-00143-gb5cbe7c00aa0 #41
[ 2690.997633] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
[ 2690.997640] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
[ 2690.998311] ==================================================================

fs/btrfs/tree-log.c
-------------------------------------
2948         /*
2949          * We _must_ update under the root->log_mutex in order to make sure we
2950          * have a consistent view of the log root we are trying to commit at
2951          * this moment.
2952          *
2953          * We _must_ copy this into a local copy, because we are not holding the
2954          * log_root_tree->log_mutex yet.  This is important because when we
2955          * commit the log_root_tree we must have a consistent view of the
2956          * log_root_tree when we update the super block to point at the
2957          * log_root_tree bytenr.  If we update the log_root_tree here we'll race
2958          * with the commit and possibly point at the new block which we may not
2959          * have written out.
2960          */
2961         btrfs_set_root_node(&log->root_item, log->node);
2962         memcpy(&new_root_item, &log->root_item, sizeof(new_root_item));
2963
2964 →       root->log_transid++;
2965         log->log_transid = root->log_transid;
2966         root->log_start_pid = 0;
2967         /*
2968          * IO has been started, blocks of the log tree have WRITTEN flag set
2969          * in their headers. new modifications of the log will be written to
2970          * new positions. so it's safe to allow log writers to go in.
2971          */
2972         mutex_unlock(&root->log_mutex);

fs/btrfs/transaction.h
----------------------------------
170 static inline void btrfs_set_inode_last_trans(struct btrfs_trans_handle *trans,
171                                               struct btrfs_inode *inode)
172 {
173         spin_lock(&inode->lock);
174         inode->last_trans = trans->transaction->transid;
175         inode->last_sub_trans = inode->root->log_transid;
176         inode->last_log_commit = inode->last_sub_trans - 1;
177         spin_unlock(&inode->lock);
178 }

I am not certain whether the reader and writer side contend for the same lock, but it
seems that on the safe side would be putting the reader into READ_ONCE() to get a consistent
value?:

A diff speaks more than a thousand words:

----------------------
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 6b309f8a99a8..b8cf86ce4c9e 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -172,7 +172,7 @@ static inline void btrfs_set_inode_last_trans(struct btrfs_trans_handle *trans,
  {
         spin_lock(&inode->lock);
         inode->last_trans = trans->transaction->transid;
-       inode->last_sub_trans = inode->root->log_transid;
+       inode->last_sub_trans = READ_ONCE(inode->root->log_transid);
         inode->last_log_commit = inode->last_sub_trans - 1;
         spin_unlock(&inode->lock);
  }
--

Best regards,
Mirsad Todorovac
