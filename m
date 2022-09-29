Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EFB5EEDFA
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Sep 2022 08:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbiI2Gli (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Sep 2022 02:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbiI2Glh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Sep 2022 02:41:37 -0400
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8462D128704;
        Wed, 28 Sep 2022 23:41:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1664433693; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=V+zipX7DGpNT0VfSsSnD8pEBivBRPN2as9BH3sG0fjD4iKbVt3BqOeJ99Lo4msja1Lu6MqwMfcx/oR756xBfcfWMgHeXOu4hFuALdeglxh0yo8+cDuSFPFYs3uYrqNMIIATm5cgStnUx93qbcdyLV8d5qSE8MUfyUn2cayx1NGk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1664433693; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=EXlFcHYEvuIDXaU+aP6eHFMdyT/gqxmC/nZG41wQWG8=; 
        b=SIhOHBwQ86TPbgNCFd0kVUkXQFBWyqO7eh7w2tRX9Zmps8ek/rwWdcJC0MoJuoZDYv1ytxCmuPZlwqiL+jYCK0j7ZgjlQdh0TRaIvu3CrjJ2ufPPtRDJXCMg8bu/8rKOsamgQdAYA8UdxWGIdVDME9Ps3Vaiu7FsbCcbKb+MV4M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=message-id:date:mime-version:user-agent:subject:to:cc:references:from:in-reply-to:content-type; 
  b=dsKVwXCus/vx4HZb8Ll7diczxweR21MnfPqtc2FJ3mUBRUyKECuXpvo5wIah+neHVNdgylrBv/Xn
    QTSEnlB8APM+Vbbrwi0JS7KyXCkK8AV5Ao7k9XGd9DgIf7bdkL45  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664433693;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=EXlFcHYEvuIDXaU+aP6eHFMdyT/gqxmC/nZG41wQWG8=;
        b=WMr7uVM7JpKPho9Gq/y1lhxC2Kekix1/oEIZoVnfHYRSQfoQI3QsrNyrmw2Lh1ge
        bjQeMrOFPOv+rLACJKDQdU47ti3U41ERo5FZRhhCvnGBdpABeMROv9JBHxmqnnoxc4h
        0yzTZeJdxH898XIniAdaglzeH/Xjvc+vXrJKPe3E=
Received: from [192.168.0.103] (58.247.201.74 [58.247.201.74]) by mx.zohomail.com
        with SMTPS id 1664433692706875.4584232941247; Wed, 28 Sep 2022 23:41:32 -0700 (PDT)
Message-ID: <b1687080-a702-e1f7-0fac-e837b0317aa4@zoho.com>
Date:   Thu, 29 Sep 2022 02:41:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] btrfs:remove redundant index_rbio_pages in
 raid56_rmw_stripe
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220929014402.2450-1-hmsjwzb@zoho.com>
 <c4293742-06ba-8720-e2eb-d4d3bc4da044@suse.com>
 <18acd4e0-9d3d-77a7-a1de-b805bc259bcf@suse.com>
From:   hmsjwzb <hmsjwzb@zoho.com>
In-Reply-To: <18acd4e0-9d3d-77a7-a1de-b805bc259bcf@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

	Thanks for your reply.
	Here is my plan about destructive RMW.
	
	1. Read all the stripes in through raid56_rmw_stripe.
	2. Do xor operation in finish_rmw.
	3. If the xor result matches, nothing happened.
	4. If the xor result mismatches, we can recover the data or trigger some user space progress to fix the data corruption.

	But here are some problems.
	1. If the stripe is new allocated, the check will fail.
	2. Is it convient for kernel get checksum in finish_rmw and recover data?

Thanks,
Flint

On 9/28/22 23:13, Qu Wenruo wrote:
> 
> 
> On 2022/9/29 11:08, Qu Wenruo wrote:
>>
>>
>> On 2022/9/29 09:44, Flint.Wang wrote:
>>>    The index_rbio_pages in raid56_rmw_stripe is redundant.
>>
>> index_rbio_pages() is to populate the rbio->bio_sectors array.
>>
>> In raid56_rmw_stripe() we later calls sector_in_rbio(), which will check if a sector is belonging to bio_lists.
>>
>> If not called, all sector will be returned using the sectors in rbio->bio_sectors, not using the sectors in bio lists.
>>
>> Have you tried your patch with fstests runs?
> 
> Well, for raid56_rmw_stripe() it's fine, as without the index_rbio_pages() call, we just read all the sectors from the disk.
> 
> This would include the new pages from bio lists.
> 
> It would only cause extra IO, but since they can all be merged into one 64K stripe, it should not cause performance problem.
> 
> Furthermore it would read all old sectors from disk, allowing us later to do the verification before doing the writes.
> 
> But it should really contain a more detailed explanation.
> 
> Thanks,
> Qu
>>
>> IMHO it should fail a lot of very basic writes in RAID56.
>>
>> Thanks,
>> Qu
>>
>>>    It is invoked in finish_rmw anyway.
>>>
>>> Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
>>> ---
>>>   fs/btrfs/raid56.c | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
>>> index f6395e8288d69..44266b2c5b86e 100644
>>> --- a/fs/btrfs/raid56.c
>>> +++ b/fs/btrfs/raid56.c
>>> @@ -1546,8 +1546,6 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
>>>       if (ret)
>>>           goto cleanup;
>>> -    index_rbio_pages(rbio);
>>> -
>>>       atomic_set(&rbio->error, 0);
>>>       /* Build a list of bios to read all the missing data sectors. */
>>>       for (total_sector_nr = 0; total_sector_nr < nr_data_sectors;
