Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC68D1CEEFD
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 May 2020 10:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgELIVI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 04:21:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:54060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgELIVI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 04:21:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D074BAB91;
        Tue, 12 May 2020 08:21:08 +0000 (UTC)
Subject: Re: [PATCH v4 00/11] btrfs-progs: Support for SKINNY_BG_TREE feature
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200505000230.4454-1-wqu@suse.com>
 <20200511185810.GX18421@twin.jikos.cz>
 <ce5fe286-fa4a-e282-3b92-564cab62b776@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <61c92960-038f-068c-8ee8-a6d657739f16@suse.com>
Date:   Tue, 12 May 2020 11:21:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ce5fe286-fa4a-e282-3b92-564cab62b776@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12.05.20 г. 5:30 ч., Qu Wenruo wrote:
> 
> 
> On 2020/5/12 上午2:58, David Sterba wrote:
>> On Tue, May 05, 2020 at 08:02:19AM +0800, Qu Wenruo wrote:
>>> This patchset can be fetched from github:
>>> https://github.com/adam900710/btrfs-progs/tree/skinny_bg_tree
>>> Which is based on v5.6 tag, with extra cleanups (sent to mail list) applied.
>>>
>>> This patchset provides the needed user space infrastructure for SKINNY_BG_TREE
>>> feature.
>>>
>>> Since it's an new incompatible feature, unlike SKINNY_METADATA, btrfs-progs
>>> is needed to convert existing fs (unmounted) to new format, and
>>> vice-verse.
>>>
>>> Now btrfstune can convert regular extent tree fs to bg tree fs to
>>> improve mount time.
>>>
>>> For the performance improvement, please check the kernel patchset cover
>>> letter or the last patch.
>>> (SPOILER ALERT: It's super fast)
>>>
>>> Changelog:
>>> v2:
>>> - Rebase to v5.2.2 tag
>>> - Add btrfstune ability to convert existing fs to BG_TREE feature
>>>
>>> v3:
>>> - Fix a bug that temp chunks are not cleaned up properly
>>>   This is caused by wrong timing btrfs_convert_to_bg_tree() is called.
>>>   It should be called after temp chunks cleaned up.
>>>
>>> - Fix a bug that an extent buffer get leaked
>>>   This is caused by newly created bg tree not added to dirty list.
>>>
>>> v4:
>>> - Go with skinny bg tree other than regular block group item
>>>   We're introducing a new incompatible feature anyway, why not go
>>>   extreme?
>>>
>>> - Use the same refactor as kernel.
>>>   To make code much cleaner and easier to read.
>>>
>>> - Add the ability to rollback to regular extent tree.
>>>   So confident tester can try SKINNY_BG_TREE using their real world
>>>   data, and rollback if they still want to mount it using older kernels.
>>>
>>> Qu Wenruo (11):
>>>   btrfs-progs: check/lowmem: Lookup block group item in a seperate
>>>     function
>>>   btrfs-progs: block-group: Refactor how we read one block group item
>>>   btrfs-progs: Rename btrfs_remove_block_group() and
>>>     free_block_group_item()
>>>   btrfs-progs: block-group: Refactor how we insert a block group item
>>>   btrfs-progs: block-group: Rename write_one_cahce_group()
>>
>> I'll add the above patches independently, for the rest I don't know. I
>> still think the separate tree is somehow wrong so have to convince
>> myself that it's not.
>>
> One interesting advantage here is, separate block group tree would
> hugely reduce the possibility to fail to mount due to corrupted extent tree.
> There are two reports of different corruption on extent tree already in
> the mail list in the last 24 hours.
> 
> While the skinny bg tree could hugely reduce the amount of block group
> items, which means less possibility to corrupt.
> 
> And since we have less tree blocks for block group tree, the cow cost
> would also be reduced obviously.
> As one BGI (just a key) get modified, all modification to other keys in
> that leaf won't lead to new COW until next transaction.
> 
> So personally I believe it's much better than regular extent tree.

Perhaps it will be more convincing if you could substantiate those
claims with numbers. I.e run some benchmarks and show numbers under what
cases the added complexity brings positives to the table.

> 
> Thanks,
> Qu
> 
