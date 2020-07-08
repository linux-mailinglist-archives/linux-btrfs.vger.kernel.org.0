Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13673217CFD
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 04:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgGHCTZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 22:19:25 -0400
Received: from mail.synology.com ([211.23.38.101]:52328 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728479AbgGHCTZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jul 2020 22:19:25 -0400
Subject: Re: [PATCH v2] btrfs: speedup mount time with readahead chunk tree
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1594174763; bh=IT3h3UTK/+uhDIYOj8HRlzOpuTCjhxwLCTPor03YyhU=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=opeNWmpRMM4uXdJsIVAX7t9n0z25APyKaM/y24Km1cWn2OG3n8XZ6tdipBgH1EMQZ
         kX8ZR7pb6Lzk1FlgmOZ5bLSr+WM60AOntGg5qtFawIqDpq0SwC+ndqKmTcBI+68jLc
         ds/DAMYHJns+7gGyQo8AnUmo43Ms9QNcOxLK/hjE=
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20200707035944.15150-1-robbieko@synology.com>
 <20200707192511.GE16141@twin.jikos.cz>
From:   Robbie Ko <robbieko@synology.com>
Message-ID: <3b3f9eb4-96ef-d039-5d86-a4c165e6d993@synology.com>
Date:   Wed, 8 Jul 2020 10:19:22 +0800
MIME-Version: 1.0
In-Reply-To: <20200707192511.GE16141@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


David Sterba 於 2020/7/8 上午3:25 寫道:
> On Tue, Jul 07, 2020 at 11:59:44AM +0800, robbieko wrote:
>> From: Robbie Ko <robbieko@synology.com>
>>
>> When mounting, we always need to read the whole chunk tree,
>> when there are too many chunk items, most of the time is
>> spent on btrfs_read_chunk_tree, because we only read one
>> leaf at a time.
>>
>> It is unreasonable to limit the readahead mechanism to a
>> range of 64k, so we have removed that limit.
>>
>> In addition we added reada_maximum_size to customize the
>> size of the pre-reader, The default is 64k to maintain the
>> original behavior.
>>
>> So we fix this by used readahead mechanism, and set readahead
>> max size to ULLONG_MAX which reads all the leaves after the
>> key in the node when reading a level 1 node.
> The readahead of chunk tree is a special case as we know we will need
> the whole tree, in all other cases the search readahead needs is
> supposed to read only one leaf.

If, in most cases, readahead requires that only one leaf be read, then
reada_ maximum_size should be nodesize instead of 64k, or use
reada_maximum_ nr (default:1) seems better.

>
> For that reason I don't want to touch the current path readahead logic
> at all and do the chunk tree readahead in one go instead of the
> per-search.

I don't know why we don't make the change to readahead, because the current
readahead is limited to the logical address in 64k is very unreasonable,
and there is a good chance that the logical address of the next leaf 
node will
not appear in 64k, so the existing readahead is almost useless.

>
> Also I don't like to see size increase of btrfs_path just to use the
> custom once.

This variable is the parameter that controls the speed of the readahead,
and I think it should be adjustable, not the hard code in the readahead 
function.
In the future, more scenarios will be available.
For example, BGTREE. will be improved significantly faster,
My own tests have improved the speed by almost 500%.
Reference: https://lwn.net/Articles/801990 /

>
> The idea of the whole tree readahead is to do something like:
>
> - find first item
> - start readahead on all leaves from its level 1 node parent
>    (readahead_tree_block)
> - when the level 1 parent changes during iterating items, start the
>    readahead again
>
> This skips readahead of all nodes above level 1, if you find a nicer way
> to readahead the whole tree I won't object, but for the first
> implementation the level 1 seems ok to me.
>
>> I have a test environment as follows:
>>
>> 200TB btrfs volume: used 192TB
>>
>> Data, single: total=192.00TiB, used=192.00TiB
>> System, DUP: total=40.00MiB, used=19.91MiB
> Can you please check what's the chunk tree height? 'btrfs inspect
> tree-stats' prints that but it takes long as needs to go through the
> whole metadata, so extracting it from 'btrfs inspect dump-tree -c chunk'
> would be faster. Thanks.
Chunk tree height 3, level (0-2)


