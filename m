Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5466D143A8
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2019 04:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfEFCyc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 May 2019 22:54:32 -0400
Received: from mail.synology.com ([211.23.38.101]:51786 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbfEFCyc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 May 2019 22:54:32 -0400
Received: from _ (localhost [127.0.0.1])
        by synology.com (Postfix) with ESMTPA id 8FC2BD08F6;
        Mon,  6 May 2019 10:54:28 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1557111268; bh=Sc60gPUEF6W3QFD1oM7aR6F+AvpVrTXOykjFU9fPEd4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=WYEnRe9/JHuqfHhdAkEUw6pSCij1Ht5D3fD76rfEfbstuwp7MTkx9EwnPovPb+LtY
         hH5djG7Cpas3S1vQpyIBma2zLnA2iQYp+zLDvpxFoHpN31Ho932r66T6D/MVpII3Fo
         Y6X6ZvhzjGQC768srjEzDEpxj8MJ68AIe31pu8bw=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 06 May 2019 10:54:28 +0800
From:   robbieko <robbieko@synology.com>
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] Btrfs: avoid allocating too many data chunks on massive
 concurrent write
In-Reply-To: <CAL3q7H74euwNzawfYJTv-yb_HUfUod9qrFZvb=tnFDZ+vf1jww@mail.gmail.com>
References: <20190426110922.21888-1-robbieko@synology.com>
 <CAL3q7H74euwNzawfYJTv-yb_HUfUod9qrFZvb=tnFDZ+vf1jww@mail.gmail.com>
Message-ID: <681c3ddd79e7e16a297e1f561a5fd652@synology.com>
X-Sender: robbieko@synology.com
User-Agent: Roundcube Webmail/1.1.2
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filipe Manana 於 2019-05-03 18:53 寫到:
> On Fri, Apr 26, 2019 at 12:10 PM robbieko <robbieko@synology.com> 
> wrote:
>> 
>> From: Robbie Ko <robbieko@synology.com>
>> 
>> I found a issue when btrfs allocates much more space than it actual 
>> needed
>> on massive concurrent writes. That may consume all free space and when 
>> it
>> need to allocate more space for metadata that result in ENOSPC.
>> 
>> I did a test that issue by 5000 dd to do write stress concurrently.
>> 
>> The space info after ENOSPC:
>> Overall:
>> Device size: 926.91GiB
>> Device allocated: 926.91GiB
>> Device unallocated: 1.00MiB
>> Device missing: 0.00B
>> Used: 211.59GiB
>> Free (estimated): 714.18GiB (min: 714.18GiB)
>> Data ratio: 1.00
>> Metadata ratio: 2.00
>> Global reserve: 512.00MiB (used: 0.00B)
>> 
>> Data,single: Size:923.77GiB, Used:209.59GiB
>> /dev/devname 923.77GiB
>> 
>> Metadata,DUP: Size:1.50GiB, Used:1022.50MiB
>> /dev/devname 3.00GiB
>> 
>> System,DUP: Size:72.00MiB, Used:128.00KiB
>> /dev/devname 144.00MiB
> 
> So can you provide more details? What parameters you gave to the dd 
> processes?
> 
> I tried to reproduce that like this:
> 
> for ((i = 0; i < 5000; i++)); do
>   dd if=/dev/zero of=/mnt/sdi/dd$i bs=2M oflag=dsync &
>   dd_pids[$i]=$!
> done
> 
> wait ${dd_pids[@]}
> 
> But after it finished, the used data space was about the same as the
> allocated data space (it was on a 200G fs).
> So I didn't observe the problem you mention, even though at first
> glance the patch looks ok.
> 
> Thanks.
> 

I use the following script :

#!/bin/sh
for (( i=1; i<=1000000; i++ ))
do
	dd if=/dev/urandom of="/mnt/dir/sa${i}" bs=1k count=1024 status=none &
	remain=$(( $i % 5000))
	if [ $remain -eq 0 ]; then
		echo "i = ${i}"
		wait
	fi
done

The problem occurred after the script ran for one days.

Thanks.


>> 
>> We can see that the Metadata space (1022.50MiB + 512.00MiB) is almost 
>> full.
>> But Data allocated much more space (923.77GiB) than it actually needed
>> (209.59GiB).
>> 
>> When the data space is not enough, this 5000 dd process will call
>> do_chunk_alloc() to allocate more space.
>> 
>> In the while loop of do_chunk_alloc, the variable force will be 
>> changed
>> to CHUNK_ALLOC_FORCE in second run and should_alloc_chunk() will 
>> always
>> return true when force is CHUNK_ALLOC_FORCE. That means every 
>> concurrent
>> dd process will allocate a chunk in do_chunk_alloc().
>> 
>> Fix this by keeping original value of force and re-assign it to force 
>> in
>> the end of the loop.
>> 
>> Signed-off-by: Robbie Ko <robbieko@synology.com>
>> ---
>>  fs/btrfs/extent-tree.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index c5880329ae37..73856f70db31 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -4511,6 +4511,7 @@ static int do_chunk_alloc(struct 
>> btrfs_trans_handle *trans, u64 flags,
>>         bool wait_for_alloc = false;
>>         bool should_alloc = false;
>>         int ret = 0;
>> +       int orig_force = force;
>> 
>>         /* Don't re-enter if we're already allocating a chunk */
>>         if (trans->allocating_chunk)
>> @@ -4544,6 +4545,7 @@ static int do_chunk_alloc(struct 
>> btrfs_trans_handle *trans, u64 flags,
>>                          */
>>                         wait_for_alloc = true;
>>                         spin_unlock(&space_info->lock);
>> +                       force = orig_force;
>>                         mutex_lock(&fs_info->chunk_mutex);
>>                         mutex_unlock(&fs_info->chunk_mutex);
>>                 } else {
>> --
>> 2.17.1
>> 

