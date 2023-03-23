Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFC16C612F
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 08:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjCWH6L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 03:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCWH6K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 03:58:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A49BDEE
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 00:58:08 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MORAU-1ppnAk2mFC-00Prkh; Thu, 23
 Mar 2023 08:58:01 +0100
Message-ID: <9628f5a7-2752-4f74-70e1-f8efd345bdc7@gmx.com>
Date:   Thu, 23 Mar 2023 15:57:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Kernel panic due to stack recursion when copying data from a
 damaged filesystem
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Ryskalczyk <david@rysk.us>, linux-btrfs@vger.kernel.org
References: <E567648E-DEE9-49EB-8B01-3CE403E4E87C@rysk.us>
 <b9ed921a-2cd2-411a-4374-c7682b56c45e@gmx.com>
 <ZBwC7n9crUsk4Pfi@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZBwC7n9crUsk4Pfi@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YiJl7zj4B/hP9j4FQ1kww0U4ol7TLIc9jFz5mZYW8+fLuctD0j3
 gk74BJrxp2i7v9QfxveGyU2xHjvZrrCuCysvwwhSFdkKn3GDl9l24VxOIDYIwfSVvyHVo6j
 S+1Q9XeqV9SAN/nkIQmS8j/VSZXV7/nseylC6NE8YrAY7L/a7GnZSPAa/dhrwRzzLocTWFQ
 moUFipYUYkVbxGlvdjjJQ==
UI-OutboundReport: notjunk:1;M01:P0:XoI5d28omUw=;SPTp16EyPLFCfmHF3XqB84bEK7s
 El9NdXPHZY2y/MJy2ZKec7xNIFm0N84abHhZKVc3BIY7tcEKsNx4dZAbS4QMrBluMCqAecanI
 7FwQGjID0VM567HIBijt72y3zwxnLo0Rv4PV6zJ/0xt0TaA6HRqSpYIEkGfdRmtLpPtDuUw22
 hqgDbUjl9J2jyN4ZYGy9VRe0DILFkXhQ1rv1I+lAGreYVMnnd5MiHKaMdk/BeGQ+Bzj1GAEBK
 ap+xfIdNQcwnf8KTLuNL4RAp8i2pxDz0D5sawc/SMXqGT7y66dfxth/nl9y8VoPPscaKjretn
 gRJ6SPObUrckHIVrGRjy8N0nsNveVq+TCYalLEOLdI4T8vDTUJF39NqB8VsyeSmRJMDKd4ZCX
 kT28NW0KsIC6xjAWrwhzt1HGSzyHKgM0OlOxt5824QbgXVrz0qhextcyepbXD5fz1jwvj16FK
 PSn2jR0SNQUOc6uwj84jRZHXsXC5Bv7qaZALLN8A/v5m5aK4oN/CG0XpCdjdllpO04HGy36Ji
 e8Hx4+2Ee91XpNqtU/hjvpftKH9LSIBx/u/Cu7ssc7Z3xleY0jTEZwiYZ7hN19ofbLv6vmnRA
 SxQGO1Bsggggg9hnwoghfRI3S9fKwYDBoACzIeoOdBy85g8G4m6lQzdexYvDr8tXoZgLJCsnN
 yFJ5gcP+IKnZ9dS/CnmUwqMs0o6vZL/0TCRee7AjzC8lyov89mLimMXKizN3+OuDDe9ftX52g
 OvVsa7vWuRQsQ9+5j+yH0yk4R1HAJ7njznXFGYdl76zLUSYsfoGvDBNIBTVN4OcY9n83M54Ww
 VKCzuaCq42+TSzPDXCIr/TAl0wXerOWvMpnk7OOnJRcc0W5mULanuOAUeRxQZGRG7GuXEpnWe
 V9Y4jq/iKCwtbeYvgqi/fDKUrntlq0hzdj/GrXwrN65nA7ZgOwqHPBD0eQeVjvu3JkKVovt5w
 H0KVuPsnYzfg68iniiNxhX5dfXU=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/23 15:42, Christoph Hellwig wrote:
> On Thu, Mar 23, 2023 at 02:41:53PM +0800, Qu Wenruo wrote:
>>> [  252.806147] BTRFS error (device sdh): level verify failed on logical 27258408435712 mirror 2 wanted 0 found 1
>>> [  252.848313] BTRFS error (device sdh): level verify failed on logical 27258408435712 mirror 3 wanted 0 found 1
>>> [  252.898989] BTRFS error (device sdh): level verify failed on logical 27258408435712 mirror 4 wanted 0 found 1
>>> ** Above four lines repeated an additional 24 times
>>
>> It's the data repair path, and the involved bad tree block seems to be the
>> csum tree block.
>>
>> CC Christoph, as he did quite some updates on the newer read repair path.
> 
> Well, the above is the metadata verifiatiom, which I haven't really
> touched (yet).
> 
> What is interesting above is that it tries to recover from 4 mirrors,
> which seems very unusual.  I wonder if something went wrong
> in btrfs_read_extent_buffer or btrfs_num_copies.

It's metadata, but that's not the cause of the stack recursion.

If you go with the frames with certainty, the stack would look like this:

stack_trace_save (kernel/stacktrace.c:123)
kasan_save_stack (mm/kasan/common.c:46)
__kasan_record_aux_stack (mm/kasan/generic.c:493)
insert_work (./include/linux/instrumented.h:72 
./include/asm-generic/bitops/instrumented-non-atomic.h:141 
kernel/workqueue.c:635 kernel/workqueue.c:642 kernel/workqueue.c:1361)
__queue_work (kernel/workqueue.c:1520)
mod_delayed_work_on (./arch/x86/include/asm/irqflags.h:137 
kernel/workqueue.c:1740)
kblockd_mod_delayed_work_on (block/blk-core.c:1039)
blk_mq_sched_insert_requests (./include/linux/rcupdate.h:771 
./include/linux/percpu-refcount.h:330 
./include/linux/percpu-refcount.h:351 block/blk-mq-sched.c:494)
blk_mq_flush_plug_list (block/blk-mq.c:2808)
__blk_flush_plug (block/blk-core.c:1152)
io_schedule (kernel/sched/core.c:8871)
folio_wait_bit_common (mm/filemap.c:1286)
read_extent_buffer_pages (./include/linux/pagemap.h:1024 
./include/linux/pagemap.h:1036 fs/btrfs/extent_io.c:5029) btrfs
btrfs_read_extent_buffer (fs/btrfs/disk-io.c:303) btrfs
read_tree_block (fs/btrfs/disk-io.c:1025) btrfs
read_block_for_search (fs/btrfs/ctree.c:1620) btrfs
btrfs_search_slot (fs/btrfs/ctree.c:2225) btrfs
btrfs_lookup_csum (fs/btrfs/file-item.c:221) btrfs
btrfs_lookup_bio_sums (fs/btrfs/file-item.c:315 
fs/btrfs/file-item.c:484) btrfs
btrfs_submit_data_read_bio (fs/btrfs/inode.c:2787) btrfs
btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
...

Thus it's still data repair path causing the stack recursion, the 
metadata is just the unfortunately one triggered it.

Thanks,
Qu
