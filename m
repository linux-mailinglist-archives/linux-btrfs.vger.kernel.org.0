Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3EA12F957
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 15:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgACOvC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 09:51:02 -0500
Received: from bang.steev.me.uk ([81.2.120.65]:46085 "EHLO smtp.steev.me.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgACOvB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jan 2020 09:51:01 -0500
Received: from [2001:8b0:162c:2:944e:a625:9b97:d687]
        by smtp.steev.me.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.2)
        id 1inOHz-009ugJ-3Z; Fri, 03 Jan 2020 14:50:59 +0000
Subject: Re: [PATCH v2 1/3] btrfs: add readmirror type framework
To:     Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <1577959968-19427-1-git-send-email-anand.jain@oracle.com>
 <1577959968-19427-2-git-send-email-anand.jain@oracle.com>
 <4f4a1dab-fd9b-a5b6-2109-d82fc222d208@steev.me.uk>
 <e652f476-eef8-62d1-4a3d-b01dbce2677a@oracle.com>
From:   Steven Davies <btrfs-list@steev.me.uk>
Message-ID: <d9e23ee8-a1bc-b79f-60c4-9fa19d9e5592@steev.me.uk>
Date:   Fri, 3 Jan 2020 14:51:07 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <e652f476-eef8-62d1-4a3d-b01dbce2677a@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/01/2020 10:28, Anand Jain wrote:
> On 3/1/20 3:32 AM, Steven Davies wrote:
>> On 02/01/2020 10:12, Anand Jain wrote:

>>> So this patch introduces a framework where we could add more readmirror
>>> policies, such as routing the IO based on device's wait-queue or manual
>>> when we have a read-preferred device or a policy based on the target
>>> storage caching.
>>
>> I think the idea is good but that it would be cleaner if the tunable 
>> was named read_policy rather than readmirror as it's more obvious that 
>> it contains a policy tunable.
> 
>   Um. 'read_policy' sounds good, but I hope it is clear enough to
>   indicate that we are talking about read for only mirrored-chunks.
>   Will rename to read_policy.

I think it would be obvious that the policy will only apply to mirrored 
chunks; after all, you can only read a chunk from a device that contains it.

>> Do you envisage allowing more than one policy to be active for a 
>> filesystem? If not, what about using the same structure as the CPU 
>> frequency and block IO schedulers with the format
>>
>> #cat /sys/block/sda/queue/scheduler
>> noop [deadline] cfq
>>
>> Such that btrfs would (eventually) have something like
>>
>> #cat /sys/fs/btrfs/UUID/read_policy
>> by_pid [user_defined_device] by_shortest_queue
>>
> 
>   And in case of user_defined_device, the device for the read shall be
>   specified in
> 
>    cat /sys/fs/btrfs/UUID/devinfo/<devid>/read_preferred
> 
>    0 = unset, 1 = set.
> 
>    (devinfo patches are in the ML [1] open for comment)
>    [1]
>    [PATCH v3 4/4] btrfs: sysfs, add devid/dev_state kobject and attribute

I remember seeing that patch and I think the approach is logical.

Steve
