Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAB1771F0
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 21:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbfGZTQl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 15:16:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:55694 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387455AbfGZTQl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 15:16:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ADC9DAC66;
        Fri, 26 Jul 2019 19:16:39 +0000 (UTC)
Subject: Re: 5.3.0-0.rc1 various tasks blocked for more than 120 seconds
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtRGNrKDBBFOZ3=Say=STMBAGMNKBwe4xsdJZL7mCRw98g@mail.gmail.com>
 <CAJCQCtSFNVTNNAEP9hSY3cbWike5VkdH8EZnaojjgZZ3tf-SfQ@mail.gmail.com>
 <a06193db-a690-49cd-0f04-0a8f7a680951@suse.com>
 <CAJCQCtQMcrAv9eQbHXenYzmbeEpFG+jkCm5Hqs75vXCyX29amg@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <35b5e6a8-8e9b-037d-b248-36fee9da8717@suse.com>
Date:   Fri, 26 Jul 2019 22:16:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQMcrAv9eQbHXenYzmbeEpFG+jkCm5Hqs75vXCyX29amg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 26.07.19 г. 22:10 ч., Chris Murphy wrote:
> On Fri, Jul 26, 2019 at 1:07 PM Nikolay Borisov <nborisov@suse.com> wrote:
>>
>>
>>
>> On 26.07.19 г. 22:00 ч., Chris Murphy wrote:
>>> On Fri, Jul 26, 2019 at 12:43 PM Chris Murphy <lists@colorremedies.com> wrote:
>>>>
>>>> Seeing this with Fedora kernel 5.3.0-0.rc1.git3.1.fc31.x86_64 which
>>>> translates to git bed38c3e2dca
>>>>
>>>> It's causing automated OS installations to hang indefinitely, only on
>>>> Btrfs. This is an excerpt of the first of many call traces:
>>>>
>>>> 15:52:20,316 ERR kernel:INFO: task kworker/u4:0:7 blocked for more
>>>> than 122 seconds.
>>>> 15:52:20,316 ERR kernel:      Not tainted 5.3.0-0.rc1.git3.1.fc31.x86_64 #1
>>>> 15:52:20,316 ERR kernel:"echo 0 >
>>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>> 15:52:20,316 INFO kernel:kworker/u4:0    D12192     7      2 0x80004000
>>>> 15:52:20,317 INFO kernel:Workqueue: btrfs-endio-write
>>>> btrfs_endio_write_helper [btrfs]
>>>> 15:52:20,317 WARNING kernel:Call Trace:
>>>> 15:52:20,317 WARNING kernel: ? __schedule+0x352/0x900
>>>> 15:52:20,317 WARNING kernel: schedule+0x3a/0xb0
>>>> 15:52:20,317 WARNING kernel: btrfs_tree_read_lock+0xa3/0x260 [btrfs]
>>>> 15:52:20,317 WARNING kernel: ? finish_wait+0x90/0x90
>>>> 15:52:20,317 WARNING kernel: btrfs_read_lock_root_node+0x2f/0x40 [btrfs]
>>>> 15:52:20,317 WARNING kernel: btrfs_search_slot+0x601/0x9d0 [btrfs]
>>>> 15:52:20,317 WARNING kernel: btrfs_lookup_file_extent+0x4c/0x70 [btrfs]
>>>> 15:52:20,317 WARNING kernel: __btrfs_drop_extents+0x16e/0xe00 [btrfs]
>>>> 15:52:20,317 WARNING kernel: ? __set_extent_bit+0x55f/0x6a0 [btrfs]
>>>> 15:52:20,317 WARNING kernel: ? kmem_cache_free+0x368/0x420
>>>> 15:52:20,318 WARNING kernel:
>>>> insert_reserved_file_extent.constprop.0+0x93/0x2e0 [btrfs]
>>>> 15:52:20,318 WARNING kernel: ? start_transaction+0x95/0x4e0 [btrfs]
>>>> 15:52:20,318 WARNING kernel: btrfs_finish_ordered_io+0x3da/0x840 [btrfs]
>>>> 15:52:20,318 WARNING kernel: normal_work_helper+0xd7/0x500 [btrfs]
>>>> 15:52:20,318 WARNING kernel: process_one_work+0x272/0x5a0
>>>> 15:52:20,318 WARNING kernel: worker_thread+0x50/0x3b0
>>>> 15:52:20,318 WARNING kernel: kthread+0x108/0x140
>>>> 15:52:20,318 WARNING kernel: ? process_one_work+0x5a0/0x5a0
>>>> 15:52:20,318 WARNING kernel: ? kthread_park+0x80/0x80
>>>> 15:52:20,318 WARNING kernel: ret_from_fork+0x3a/0x50
>>>> 15:52:20,318 ERR kernel:INFO: task kworker/u4:1:31 blocked for more
>>>> than 122 seconds.
>>>
>>> Is it related to this and maybe already fixed? Or is it a different problem?
>>> https://lore.kernel.org/linux-btrfs/20190725082729.14109-3-nborisov@suse.com/
>>
>> Likely yes.
> 
> Yes it's fixed, or yes it's different?

Yes, it looks like the problem described in the referenced patch and it
should be fixed.

> 
