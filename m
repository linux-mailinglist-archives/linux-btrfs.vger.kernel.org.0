Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1F3218A86
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbgGHO56 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:57:58 -0400
Received: from mail.itouring.de ([188.40.134.68]:57354 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729206AbgGHO56 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jul 2020 10:57:58 -0400
Received: from tux.applied-asynchrony.com (p5ddd79e0.dip0.t-ipconnect.de [93.221.121.224])
        by mail.itouring.de (Postfix) with ESMTPSA id B6ECE4160341;
        Wed,  8 Jul 2020 16:57:56 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 63009F01600;
        Wed,  8 Jul 2020 16:57:56 +0200 (CEST)
Subject: Re: [PATCH v2] btrfs: speedup mount time with readahead chunk tree
To:     dsterba@suse.cz, Robbie Ko <robbieko@synology.com>,
        linux-btrfs@vger.kernel.org
References: <20200707035944.15150-1-robbieko@synology.com>
 <20200707192511.GE16141@twin.jikos.cz>
 <3b3f9eb4-96ef-d039-5d86-a4c165e6d993@synology.com>
 <20200708140455.GA28832@twin.jikos.cz>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <de7bfbe5-7d83-2437-701c-700bbe5d3adc@applied-asynchrony.com>
Date:   Wed, 8 Jul 2020 16:57:56 +0200
MIME-Version: 1.0
In-Reply-To: <20200708140455.GA28832@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-07-08 16:04, David Sterba wrote:
> On Wed, Jul 08, 2020 at 10:19:22AM +0800, Robbie Ko wrote:
>> David Sterba 於 2020/7/8 上午3:25 寫道:
>>> On Tue, Jul 07, 2020 at 11:59:44AM +0800, robbieko wrote:
>>>> From: Robbie Ko <robbieko@synology.com>
>>>>
>>>> When mounting, we always need to read the whole chunk tree,
>>>> when there are too many chunk items, most of the time is
>>>> spent on btrfs_read_chunk_tree, because we only read one
>>>> leaf at a time.
>>>>
>>>> It is unreasonable to limit the readahead mechanism to a
>>>> range of 64k, so we have removed that limit.
>>>>
>>>> In addition we added reada_maximum_size to customize the
>>>> size of the pre-reader, The default is 64k to maintain the
>>>> original behavior.
>>>>
>>>> So we fix this by used readahead mechanism, and set readahead
>>>> max size to ULLONG_MAX which reads all the leaves after the
>>>> key in the node when reading a level 1 node.
>>> The readahead of chunk tree is a special case as we know we will need
>>> the whole tree, in all other cases the search readahead needs is
>>> supposed to read only one leaf.
>>
>> If, in most cases, readahead requires that only one leaf be read, then
>> reada_ maximum_size should be nodesize instead of 64k, or use
>> reada_maximum_ nr (default:1) seems better.
>>
>>>
>>> For that reason I don't want to touch the current path readahead logic
>>> at all and do the chunk tree readahead in one go instead of the
>>> per-search.
>>
>> I don't know why we don't make the change to readahead, because the current
>> readahead is limited to the logical address in 64k is very unreasonable,
>> and there is a good chance that the logical address of the next leaf
>> node will
>> not appear in 64k, so the existing readahead is almost useless.
> 
> I see and it seems that the assumption about layout and chances
> succesfuly read blocks ahead is not valid. The logic of readahead could
> be improved but that would need more performance evaluation.

FWIW I gave this a try and see the following numbers, averaged over multiple
mount/unmount cycles on spinning rust:

without patch : ~2.7s
with patch    : ~4.5s

..ahem..

-h
