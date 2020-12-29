Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16782E6CEC
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Dec 2020 02:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbgL2BAe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Dec 2020 20:00:34 -0500
Received: from ns2.prnet.org ([188.165.43.41]:63079 "EHLO ns2.prnet.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgL2BAd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Dec 2020 20:00:33 -0500
Received: from extserver (extserver.prnet.org [192.168.1.101])
        by ns2.prnet.org (8.16.1/8.16.1) with ESMTP id 0BT10JXH019660;
        Tue, 29 Dec 2020 02:00:19 +0100
MIME-Version: 1.0
X-UserIsAuth: true
Received: from 2001:7e8:cf00:bc00:da50:e6ff:febb:ea28 (EHLO [IPv6:2001:7e8:cf00:bc00:da50:e6ff:febb:ea28]) ([2001:7e8:cf00:bc00:da50:e6ff:febb:ea28])
          by secure.prnet.org (JAMES SMTP Server ) with ESMTPA ID -344961188;
          Tue, 29 Dec 2020 01:59:48 +0100 (CET)
Subject: Re: 5.6-5.10 balance regression?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        =?UTF-8?Q?St=c3=a9phane_Lesimple?= <stephane_btrfs2@lesimple.fr>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <518c15d55c3d540b26341a773ff7d99f@lesimple.fr>
 <da42984a-1f75-153a-b7fd-145e0d66b6d4@suse.com>
 <505cabfa88575ed6dbe7cb922d8914fb@lesimple.fr>
 <292de7b8-42eb-0c39-d8c7-9a366f688731@prnet.org>
 <2846fc85-6bd3-ae7e-6770-c75096e5d547@gmx.com>
 <344c4bfd-3189-2bf5-9282-2f7b3cb23972@prnet.org>
 <1904ed2c92224d38747377b43e462353@lesimple.fr>
 <485db52d-cf4d-3a5c-9253-13cdb40ccd5e@gmx.com>
 <5f819b6c-d737-bb73-5382-370875b599c1@gmx.com>
From:   David Arendt <admin@prnet.org>
Message-ID: <6dc40a44-bc3b-ea9b-327b-e2700b2efd62@prnet.org>
Date:   Tue, 29 Dec 2020 01:59:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <5f819b6c-d737-bb73-5382-370875b599c1@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Just for information: On my system the error appeared on a filesystem 
using space cache v1. I think my problem might then be unrelated to this 
one. If it will happen again, I will try to collect more information. 
Maybe a should try a clear_cache to ensure that the space cache is not 
wrong.

Bye,
David Arendt

On 12/29/20 1:44 AM, Qu Wenruo wrote:
>
>
> On 2020/12/29 上午7:39, Qu Wenruo wrote:
>>
>>
>> On 2020/12/29 上午3:58, Stéphane Lesimple wrote:
>>>> I know it fails in relocate_block_group(), which returns -2, I'm
>>>> currently
>>>> adding a couple printk's here and there to try to pinpoint that 
>>>> better.
>>>
>>> Okay, so btrfs_relocate_block_group() starts with stage
>>> MOVE_DATA_EXTENTS, which
>>> completes successfully, as relocate_block_group() returns 0:
>>>
>>> BTRFS info (device <unknown>): relocate_block_group:
>>> prepare_to_realocate = 0
>>> BTRFS info (device <unknown>): relocate_block_group loop: progress =
>>> 1, btrfs_start_transaction = ok
>>> [...]
>>> BTRFS info (device <unknown>): relocate_block_group loop: progress =
>>> 168, btrfs_start_transaction = ok
>>> BTRFS info (device <unknown>): relocate_block_group: returning err = 0
>>> BTRFS info (device dm-10): stage = move data extents,
>>> relocate_block_group = 0
>>> BTRFS info (device dm-10): found 167 extents, stage: move data extents
>>>
>>> Then it proceeds to the UPDATE_DATA_PTRS stage and calls
>>> relocate_block_group()
>>> again. This time it'll fail at the 92th iteration of the loop:
>>>
>>> BTRFS info (device <unknown>): relocate_block_group loop: progress =
>>> 92, btrfs_start_transaction = ok
>>> BTRFS info (device <unknown>): relocate_block_group loop:
>>> extents_found = 92, item_size(53) >= sizeof(*ei)(24), flags = 1, ret 
>>> = 0
>>> BTRFS info (device <unknown>): add_data_references:
>>> btrfs_find_all_leafs = 0
>>> BTRFS info (device <unknown>): add_data_references loop:
>>> read_tree_block ok
>>> BTRFS info (device <unknown>): add_data_references loop:
>>> delete_v1_space_cache = -2
>>
>> Damn it, if we find no v1 space cache for the block group, it means
>> we're fine to continue...
>>
>>> BTRFS info (device <unknown>): relocate_block_group loop:
>>> add_data_references = -2
>>>
>>> Then the -ENOENT goes all the way up the call stack and aborts the
>>> balance.
>>>
>>> So it fails in delete_v1_space_cache(), though it is worth noting that
>>> the
>>> FS we're talking about is actually using space_cache v2.
>>
>> Space cache v2, no wonder no v1 space cache.
>>
>>>
>>> Does it help? Shall I dig deeper?
>>
>> You're already at the point!
>>
>> Mind me to craft a fix with your signed-off-by?
>
> The problem is more complex than I thought, but still we at least have
> some workaround.
>
> Firstly, this happens when an old fs get v2 space cache enabled, but
> still has v1 space cache left.
>
> Newer v2 mount should cleanup v1 properly, but older kernel doesn't do
> the proper cleaning, thus left some v1 cache.
>
> Then we call btrfs balance on such old fs, leading to the -ENOENT error.
> We can't ignore the error, as we have no way to relocate such left over
> v1 cache (normally we delete it completely, but with v2 cache, we can't).
>
> So what I can do is only to add a warning message to the problem.
>
> To solve your problem, I also submitted a patch to btrfs-progs, to force
> v1 space cache cleaning even if the fs has v2 space cache enabled.
>
> Or, you can disable v2 space cache first, using "btrfs check
> --clear-space-cache v2" first, then "btrfs check --clear-space_cache
> v1", and finally mount the fs with "space_cache=v2" again.
>
> To verify there is no space cache v1 left, you can run the following
> command to verify:
>
> # btrfs ins dump-tree -t root <device> | grep EXTENT_DATA
>
> It should output nothing.
>
> Then please try if you can balance all your data.
>
> Thanks,
> Qu
>
>>
>> Thanks,
>> Qu
>>
>>>
>>> Regards,
>>>
>>> Stéphane.
>>>

