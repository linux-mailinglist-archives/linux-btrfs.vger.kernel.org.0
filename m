Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BB17BC4A1
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Oct 2023 06:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343527AbjJGEUz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Oct 2023 00:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343492AbjJGEUy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Oct 2023 00:20:54 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214CCBE;
        Fri,  6 Oct 2023 21:20:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 627BE60155;
        Sat,  7 Oct 2023 06:20:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1696652448; bh=wHUA1f0W6FCQC1zHhDmW2yQT88G4LC7ETYGV2emjjHU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=erI+azZ7gYg7xZhyTDAfGhMFsB9zHRQHcGZDcv2Ggu2WhG3D0Y3viYz6iMcdFzDd1
         j5ZnA4bHAPG2ypOs6QvYsZ6Tao63fdMH6SseQGFYExPsRTWCYgT8xA90udMbxtKfJp
         /c835Kus87iOHRJJh1EZMQbzxBDAz2EKn1GUE/1On30qIzaJB2Srled3PWy4Xdix4d
         GB0b/2FsYgcHPTlxn5HafjEWcvSNSGR2lBJQ8oZQUP9CPaHU87c2R394TJ/gwHW1p7
         m0cQnclgJuCqblW2/5qg2KU21w88DOCqApjhL79FjMjJelnQ9jDYRxL0dIdSFZmcFO
         DPRqm7iQK86ew==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5W_wY54THf8Z; Sat,  7 Oct 2023 06:20:45 +0200 (CEST)
Received: from [192.168.1.3] (78-2-88-19.adsl.net.t-com.hr [78.2.88.19])
        by domac.alu.hr (Postfix) with ESMTPSA id BDCD260152;
        Sat,  7 Oct 2023 06:20:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1696652445; bh=wHUA1f0W6FCQC1zHhDmW2yQT88G4LC7ETYGV2emjjHU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=r7BdE/Spv+l9iIwWm2SF9TnaBehjqgWYorw6phzkSdf9oUST31ZrIpdQ+4TyKD3SF
         IecEsyY0/cSbV6g+uJ/r/d3VJao7DbK9VmrLXk9X5/qCdj1/qid83pCCVahJXaGvXN
         wb6s97+WxzF+IwM4ysstsDZ7bMsMev0edi1REchHm2DkNe70P2/AArmK2vdXNCA0wz
         JaBrPOUx2flNdRaRf2WoaDNgcywltsw8lcu1GAA2XCngOgmaIydj7l6XuAe+VyHvOV
         rwIrIjX+ER3ejf36RYj3rkqBnShXn5dV9urrMY/oNeBr810mh3JwgQBEu3ZOKxUVqI
         8UMz/T5brnqnA==
Message-ID: <7054f1cc-c02f-4f48-9d73-36040b70fa0c@alu.unizg.hr>
Date:   Sat, 7 Oct 2023 06:20:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: KCSAN: data-race in btrfs_sync_log [btrfs] /
 btrfs_update_inode [btrfs]
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org
References: <01c15818-5765-408b-aff0-6c68b8c2a874@alu.unizg.hr>
 <20231006162649.GL28758@twin.jikos.cz>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Autocrypt: addr=mirsad.todorovac@alu.unizg.hr; keydata=
 xjMEYp0QmBYJKwYBBAHaRw8BAQdAI14D1/OE3jLBYycg8HaOJOYrvEaox0abFZtJf3vagyLN
 Nk1pcnNhZCBHb3JhbiBUb2Rvcm92YWMgPG1pcnNhZC50b2Rvcm92YWNAYWx1LnVuaXpnLmhy
 PsKPBBMWCAA3FiEEdCs8n09L2Xwp/ytk6p9/SWOJhIAFAmKdEJgFCQ0oaIACGwMECwkIBwUV
 CAkKCwUWAgMBAAAKCRDqn39JY4mEgIf/AP9hx09nve6VH6D/F3m5jRT5m1lzt5YzSMpxLGGU
 vGlI4QEAvOvGI6gPCQMhuQQrOfRr1CnnTXeaXHhlp9GaZEW45QzOOARinRCZEgorBgEEAZdV
 AQUBAQdAqJ1CxZGdTsiS0cqW3AvoufnWUIC/h3W2rpJ+HUxm61QDAQgHwn4EGBYIACYWIQR0
 KzyfT0vZfCn/K2Tqn39JY4mEgAUCYp0QmQUJDShogAIbDAAKCRDqn39JY4mEgIMnAQDPKMJJ
 fs8+QnWS2xx299NkVTRsZwfg54z9NIvH5L3HiAD9FT3zfHfvQxIViWEzcj0q+FLWoRkOh02P
 Ny0lWTyFlgc=
Organization: Academy of Fine Arts, University of Zagreb
In-Reply-To: <20231006162649.GL28758@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/6/2023 6:26 PM, David Sterba wrote:
> On Thu, Sep 21, 2023 at 10:15:49PM +0200, Mirsad Todorovac wrote:
>> Hi,
>>
>> On the vanilla 6.6-rc2 torvalds kernel KCSAN reported this data-race:
>>
>> [ 2690.990793] ==================================================================
>> [ 2690.991470] BUG: KCSAN: data-race in btrfs_sync_log [btrfs] / btrfs_update_inode [btrfs]
>>
>> [ 2690.992804] write to 0xffff88811b57faf8 of 4 bytes by task 40555 on cpu 20:
>> [ 2690.992815] btrfs_sync_log (/home/marvin/linux/kernel/torvalds2/fs/btrfs/tree-log.c:2964) btrfs
>> [ 2690.993484] btrfs_sync_file (/home/marvin/linux/kernel/torvalds2/fs/btrfs/file.c:1954) btrfs
>> [ 2690.994149] vfs_fsync_range (/home/marvin/linux/kernel/torvalds2/fs/sync.c:188)
>> [ 2690.994161] __x64_sys_fsync (/home/marvin/linux/kernel/torvalds2/./include/linux/file.h:45 /home/marvin/linux/kernel/torvalds2/fs/sync.c:213 /home/marvin/linux/kernel/torvalds2/fs/sync.c:220 /home/marvin/linux/kernel/torvalds2/fs/sync.c:218 /home/marvin/linux/kernel/torvalds2/fs/sync.c:218)
>> [ 2690.994172] do_syscall_64 (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/common.c:50 /home/marvin/linux/kernel/torvalds2/arch/x86/entry/common.c:80)
>> [ 2690.994186] entry_SYSCALL_64_after_hwframe (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/entry_64.S:120)
>>
>> [ 2690.994203] read to 0xffff88811b57faf8 of 4 bytes by task 5338 on cpu 21:
>> [ 2690.994214] btrfs_update_inode (/home/marvin/linux/kernel/torvalds2/fs/btrfs/transaction.h:175 /home/marvin/linux/kernel/torvalds2/fs/btrfs/inode.c:4016) btrfs
>> [ 2690.994877] btrfs_finish_one_ordered (/home/marvin/linux/kernel/torvalds2/fs/btrfs/inode.c:4028 /home/marvin/linux/kernel/torvalds2/fs/btrfs/inode.c:3139) btrfs
>> [ 2690.995541] btrfs_finish_ordered_io (/home/marvin/linux/kernel/torvalds2/fs/btrfs/inode.c:3230) btrfs
>> [ 2690.996205] finish_ordered_fn (/home/marvin/linux/kernel/torvalds2/fs/btrfs/ordered-data.c:304) btrfs
>> [ 2690.996871] btrfs_work_helper (/home/marvin/linux/kernel/torvalds2/fs/btrfs/async-thread.c:314) btrfs
>> [ 2690.997539] process_one_work (/home/marvin/linux/kernel/torvalds2/kernel/workqueue.c:2630)
>> [ 2690.997551] worker_thread (/home/marvin/linux/kernel/torvalds2/kernel/workqueue.c:2697 /home/marvin/linux/kernel/torvalds2/kernel/workqueue.c:2784)
>> [ 2690.997562] kthread (/home/marvin/linux/kernel/torvalds2/kernel/kthread.c:388)
>> [ 2690.997571] ret_from_fork (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/process.c:147)
>> [ 2690.997583] ret_from_fork_asm (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/entry_64.S:312)
>>
>> [ 2690.997598] value changed: 0x00000004 -> 0x00000005
>>
>> [ 2690.997613] Reported by Kernel Concurrency Sanitizer on:
>> [ 2690.997621] CPU: 21 PID: 5338 Comm: kworker/u65:7 Tainted: G             L     6.6.0-rc2-kcsan-00143-gb5cbe7c00aa0 #41
>> [ 2690.997633] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
>> [ 2690.997640] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
>> [ 2690.998311] ==================================================================
>>
>> fs/btrfs/tree-log.c
>> -------------------------------------
>> 2948         /*
>> 2949          * We _must_ update under the root->log_mutex in order to make sure we
>> 2950          * have a consistent view of the log root we are trying to commit at
>> 2951          * this moment.
>> 2952          *
>> 2953          * We _must_ copy this into a local copy, because we are not holding the
>> 2954          * log_root_tree->log_mutex yet.  This is important because when we
>> 2955          * commit the log_root_tree we must have a consistent view of the
>> 2956          * log_root_tree when we update the super block to point at the
>> 2957          * log_root_tree bytenr.  If we update the log_root_tree here we'll race
>> 2958          * with the commit and possibly point at the new block which we may not
>> 2959          * have written out.
>> 2960          */
>> 2961         btrfs_set_root_node(&log->root_item, log->node);
>> 2962         memcpy(&new_root_item, &log->root_item, sizeof(new_root_item));
>> 2963
>> 2964 →       root->log_transid++;
>> 2965         log->log_transid = root->log_transid;
>> 2966         root->log_start_pid = 0;
>> 2967         /*
>> 2968          * IO has been started, blocks of the log tree have WRITTEN flag set
>> 2969          * in their headers. new modifications of the log will be written to
>> 2970          * new positions. so it's safe to allow log writers to go in.
>> 2971          */
>> 2972         mutex_unlock(&root->log_mutex);
>>
>> fs/btrfs/transaction.h
>> ----------------------------------
>> 170 static inline void btrfs_set_inode_last_trans(struct btrfs_trans_handle *trans,
>> 171                                               struct btrfs_inode *inode)
>> 172 {
>> 173         spin_lock(&inode->lock);
>> 174         inode->last_trans = trans->transaction->transid;
>> 175         inode->last_sub_trans = inode->root->log_transid;
>> 176         inode->last_log_commit = inode->last_sub_trans - 1;
>> 177         spin_unlock(&inode->lock);
>> 178 }
>>
>> I am not certain whether the reader and writer side contend for the same lock, but it
>> seems that on the safe side would be putting the reader into READ_ONCE() to get a consistent
>> value?:
> 
> Filipe send a series adding the READ_ONCE/WRITE_ONCE annotations for the
> log_transid (and more):
> https://lore.kernel.org/linux-btrfs/cover.1696415673.git.fdmanana@suse.com/
> 
> This will appear in linux-next soon.

That looks promising and I will test whether it pleases KCSAN in my setup
(it looks like it should). I consider filesystem data integrity a paramount.

If you found this bug report helpful, consider adding:

Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

Best regards,
Mirsad Todorovac

-- 
Mirsad Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
tel. +385 (0)1 3711 451
mob. +385 91 57 88 355
