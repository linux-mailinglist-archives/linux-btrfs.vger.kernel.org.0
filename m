Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA4C2195B8
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jul 2020 03:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgGIBqm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 21:46:42 -0400
Received: from mail.synology.com ([211.23.38.101]:32986 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726107AbgGIBqm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jul 2020 21:46:42 -0400
Subject: Re: [PATCH v2] btrfs: speedup mount time with readahead chunk tree
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1594259200; bh=7ZwIZmK1gHLTOR9xWZC00X7aT+8VS9mveyjksyXjpB4=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=FDdQThSH6QDmK3hhfnzghyyII9kKDRCxLFvDDCvPM6HHD3fY0Ssc/h+9MU3koIMYB
         +v1XgSFePy4Rv2XeKNm5VNPeYoreVUczZEOkpixJDn0ZZV0cemD+Ohvti3QpL4QlOu
         48wEdsdhPzA+lBtOPcNmUpzQl7/CCxzq+S5xJ3dY=
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20200707035944.15150-1-robbieko@synology.com>
 <20200707192511.GE16141@twin.jikos.cz>
 <3b3f9eb4-96ef-d039-5d86-a4c165e6d993@synology.com>
 <20200708140455.GA28832@twin.jikos.cz>
 <de7bfbe5-7d83-2437-701c-700bbe5d3adc@applied-asynchrony.com>
From:   Robbie Ko <robbieko@synology.com>
Message-ID: <f7891e0c-b084-5ecb-dde5-3f202ec42f57@synology.com>
Date:   Thu, 9 Jul 2020 09:46:40 +0800
MIME-Version: 1.0
In-Reply-To: <de7bfbe5-7d83-2437-701c-700bbe5d3adc@applied-asynchrony.com>
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


Holger Hoffstätte 於 2020/7/8 下午10:57 寫道:
> On 2020-07-08 16:04, David Sterba wrote:
>> On Wed, Jul 08, 2020 at 10:19:22AM +0800, Robbie Ko wrote:
>>> David Sterba 於 2020/7/8 上午3:25 寫道:
>>>> On Tue, Jul 07, 2020 at 11:59:44AM +0800, robbieko wrote:
>>>>> From: Robbie Ko <robbieko@synology.com>
>>>>>
>>>>> When mounting, we always need to read the whole chunk tree,
>>>>> when there are too many chunk items, most of the time is
>>>>> spent on btrfs_read_chunk_tree, because we only read one
>>>>> leaf at a time.
>>>>>
>>>>> It is unreasonable to limit the readahead mechanism to a
>>>>> range of 64k, so we have removed that limit.
>>>>>
>>>>> In addition we added reada_maximum_size to customize the
>>>>> size of the pre-reader, The default is 64k to maintain the
>>>>> original behavior.
>>>>>
>>>>> So we fix this by used readahead mechanism, and set readahead
>>>>> max size to ULLONG_MAX which reads all the leaves after the
>>>>> key in the node when reading a level 1 node.
>>>> The readahead of chunk tree is a special case as we know we will need
>>>> the whole tree, in all other cases the search readahead needs is
>>>> supposed to read only one leaf.
>>>
>>> If, in most cases, readahead requires that only one leaf be read, then
>>> reada_ maximum_size should be nodesize instead of 64k, or use
>>> reada_maximum_ nr (default:1) seems better.
>>>
>>>>
>>>> For that reason I don't want to touch the current path readahead logic
>>>> at all and do the chunk tree readahead in one go instead of the
>>>> per-search.
>>>
>>> I don't know why we don't make the change to readahead, because the 
>>> current
>>> readahead is limited to the logical address in 64k is very 
>>> unreasonable,
>>> and there is a good chance that the logical address of the next leaf
>>> node will
>>> not appear in 64k, so the existing readahead is almost useless.
>>
>> I see and it seems that the assumption about layout and chances
>> succesfuly read blocks ahead is not valid. The logic of readahead could
>> be improved but that would need more performance evaluation.
>
> FWIW I gave this a try and see the following numbers, averaged over 
> multiple
> mount/unmount cycles on spinning rust:
>
> without patch : ~2.7s
> with patch    : ~4.5s
>
> ..ahem..
>
I have the following two questions for you.
1. What is the version you are using?
2. Can you please measure the time of btrfs_read_chunk_tree alone?

I think the problem you are having is that btrfs_read_block_groups is
slowing down because it is using the wrong READA flag, which is causing
a lot of useless IO's when reading the block group.

This can be fixed with the following commit.
btrfs: block-group: don't set the wrong READA flag for 
btrfs_read_block_groups()
https://git.kernel.org/pub/scm/linux/kernel 
/git/torvalds/linux.git/commit/?h=v5.8-rc4& 
id=83fe9e12b0558eae519351cff00da1e06bc054d2

> -h
