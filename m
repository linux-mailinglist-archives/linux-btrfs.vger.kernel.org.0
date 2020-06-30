Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE3F20F19D
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 11:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbgF3JaD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 05:30:03 -0400
Received: from mail.itouring.de ([188.40.134.68]:53580 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730256AbgF3JaD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 05:30:03 -0400
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jun 2020 05:30:02 EDT
Received: from tux.applied-asynchrony.com (p5ddd79e0.dip0.t-ipconnect.de [93.221.121.224])
        by mail.itouring.de (Postfix) with ESMTPSA id BEA5341604DD;
        Tue, 30 Jun 2020 11:22:09 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id BA158F01600;
        Tue, 30 Jun 2020 11:22:08 +0200 (CEST)
Subject: Re: [PATCH][RESEND] btrfs: kill update_block_group_flags
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200117140826.42616-1-josef@toxicpanda.com>
 <2e16f37e-014e-6d86-76c6-801d6cb7bc20@applied-asynchrony.com>
 <20200302201804.GX2902@twin.jikos.cz>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <bbd85d2d-5490-0797-0649-616531c977fe@applied-asynchrony.com>
Date:   Tue, 30 Jun 2020 11:22:08 +0200
MIME-Version: 1.0
In-Reply-To: <20200302201804.GX2902@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-03-02 21:18, David Sterba wrote:
> On Sun, Mar 01, 2020 at 06:58:02PM +0100, Holger Hoffstätte wrote:
>> On 1/17/20 3:08 PM, Josef Bacik wrote:
>>> +		alloc_flags = btrfs_get_alloc_profile(fs_info, cache->flags);
>>>    		if (alloc_flags != cache->flags) {
>>>    			ret = btrfs_chunk_alloc(trans, alloc_flags,
>>>    						CHUNK_ALLOC_FORCE);
>>> @@ -2252,7 +2204,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
>>>    	ret = inc_block_group_ro(cache, 0);
>>>    out:
>>>    	if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
>>> -		alloc_flags = update_block_group_flags(fs_info, cache->flags);
>>> +		alloc_flags = btrfs_get_alloc_profile(fs_info, cache->flags);
>>>    		mutex_lock(&fs_info->chunk_mutex);
>>>    		check_system_chunk(trans, alloc_flags);
>>>    		mutex_unlock(&fs_info->chunk_mutex);
>>>
>>
>> It seems that this patch breaks forced metadata rebalance from dup to single;
>> all chunks remain dup (or are rewritten as dup again). I bisected the broken
>> balance behaviour to this commit which for some reason was in my tree ;-) and
>> reverting it immediately fixed things.
>>
>> I don't (yet) see this applied anywhere, but couldn't find any discussion or
>> revocation either. Maybe the logic between update_block_group_flags() and
>> btrfs_get_alloc_profile() is not completely exchangeable?
> 
> The patch was not applied because I was not sure about it and had some
> suspicion, https://lore.kernel.org/linux-btrfs/20200108170340.GK3929@twin.jikos.cz/
> I don't want to apply the patch until I try the mentioned test with
> raid1c34 but it's possible that it gets fixed by the updated patch.

I don't see this in misc-next or anywhere else, so a gentle reminder..

Original thread:
https://lore.kernel.org/linux-btrfs/20200117140826.42616-1-josef@toxicpanda.com/

As I wrote in the replies, the update to the patch fixed the balancing for me
(used with various profiles since then, no observed issues).

Josef, what about that xfstest?
David, can you try again with raid1c34?

thanks
Holger
