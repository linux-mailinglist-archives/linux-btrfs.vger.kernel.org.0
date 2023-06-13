Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE7A72EA41
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 19:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjFMRvg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 13:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFMRve (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 13:51:34 -0400
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD360101
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:51:30 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.134.37])
        by smtp-18.iol.local with ESMTPA
        id 98AxqBT7d770l98Axqlmkj; Tue, 13 Jun 2023 19:51:28 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1686678688; bh=YcNA/kVEsR5xlDBsTDO5PFCFeFweoIOZt2xsDtyWAPg=;
        h=From;
        b=HbwNvjSPRFuB/rU8xbJHGO+B4H79SnxRUclkSyJW2Aj06DL7mDP0DDZcGMSI44L8U
         iCTb8+WDa1NcQSsauErmNbdKPxXMBN9tZxYwNKCkbSZKbl5JTglD8OUKJB4AO1zx5H
         JleOxcAOw4BP6GqyWmM3QcxLwyeKTC7Py19xRUCZ9ecu3xLD/ylAkX6jXnc+o+NJPt
         FQQLZ19g0djN0xX5JY5F7f/zB/59HIe+gmBWM3zoLYp8ext5ydbpEWvNx3GKzUzUhn
         gFWMCfKfFFvD6GD28idLg5waKjJdEyEizVCgu9NdldK8mdT8hcqksyVGnYqKj55PEE
         FUUUtLrxm4/Rg==
X-CNFS-Analysis: v=2.4 cv=HJIFVKhv c=1 sm=1 tr=0 ts=6488aca0 cx=a_exe
 a=/lH5ZvDrjtQkKpBALT9r7g==:117 a=/lH5ZvDrjtQkKpBALT9r7g==:17
 a=IkcTkHD0fZMA:10 a=EcTH_3JTUI-xcY4n2d4A:9 a=QEXdDO2ut3YA:10
Message-ID: <2a60875e-6629-235f-2055-8cef79e3ea1d@libero.it>
Date:   Tue, 13 Jun 2023 19:51:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH v4] [btrfs] Add handling for RAID1CN/DUP to,
 `btrfs_reduce_alloc_profile`
Content-Language: en-US
To:     dsterba@suse.cz, Matt Corallo <blnxfsl@bluematt.me>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <2895df68-7ff3-5084-d12e-4da1870c09fc@bluematt.me>
 <20230612230026.GJ13486@twin.jikos.cz>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <20230612230026.GJ13486@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKE6tCQQLq0O6llum0Tt202lJBqADOIeGQHEx18NT8OBeyDd3OY0i4dtdqqZls3z6HW8DTk9O1yPZNZnh4XIbuh1oG+o19trC3z7lmURmW1nK3VS9aTa
 PW5KWv0DwpkoMgxL/us2l256wNogQ8eHIYf+9mq+bb7Rjs9ezl/7rsdOVvWqIHklEoGbR8Evoa3p5eFqzAqhlixhrdy926Zc99OYTyOW2hRfnHWtWNm5lTmD
 PJWCXfeqtiM1tRfdoriCOw==
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/06/2023 01.00, David Sterba wrote:
> On Mon, Jun 05, 2023 at 04:49:45PM -0700, Matt Corallo wrote:
>> Changes since v3: removed broken fall-through that was added in v3 and WARN'd on SINGLE, leaving
>> only the addition of DUP since v2.
[...]

>>
>> Signed-off-by: Matt Corallo <blnxfsl@bluematt.me>
> 
> Thanks for the analysis and writeup. As you've found in the discussion
> with Goffredo the code for the block group fallbacks during rebalancing
> is tricky. I don't remember all the details or if there's anything else
> to fix but in general adding the profiles to the sequence seems right.
> 
>> ---
>>    fs/btrfs/block-group.c | 9 ++++++++-
>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index 4b69945755e4..4cb386a875d9 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -79,14 +79,21 @@ static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
>>    	}
>>    	allowed &= flags;
>>
>> -	if (allowed & BTRFS_BLOCK_GROUP_RAID6)
>> +	/* Select the highest-redundancy RAID level */
>> +	if (allowed & BTRFS_BLOCK_GROUP_RAID1C4)
>> +		allowed = BTRFS_BLOCK_GROUP_RAID1C4;
>> +	else if (allowed & BTRFS_BLOCK_GROUP_RAID6)
>>    		allowed = BTRFS_BLOCK_GROUP_RAID6;
>> +	else if (allowed & BTRFS_BLOCK_GROUP_RAID1C3)
>> +		allowed = BTRFS_BLOCK_GROUP_RAID1C3;
>>    	else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
>>    		allowed = BTRFS_BLOCK_GROUP_RAID5;
>>    	else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
>>    		allowed = BTRFS_BLOCK_GROUP_RAID10;
>>    	else if (allowed & BTRFS_BLOCK_GROUP_RAID1)
>>    		allowed = BTRFS_BLOCK_GROUP_RAID1;
>> +	else if (allowed & BTRFS_BLOCK_GROUP_DUP)
>> +		allowed = BTRFS_BLOCK_GROUP_DUP;
> 
> I'm not sure about DUP, unlike the RAID1C34 profiles where I clearly
> forgot to add them, it's been around since the logic in
> btrfs_reduce_alloc_profile for the fallback. With DUP here it would mean
> that a multi-device fileystem could potentially end up with DUP, which
> is supported but may be not desired.
> 

The last two rows are a NOOP in any case, because if all 'ifS' above don't match the
possibles values are only 0 (==SINGLE) or 1 (==DUP). And these values
will be returned unaltered, where 'DUP' wins over 'single' in any case.

The 'ifS' above have the purpose to handle case like 'other than DUP and/or SINGLE
there are RAIDxxxx'.

I suggested to explicetely also the case DUP and SINGLE only to catch a
possible 'not managed' case.



> OTOH as you said above, cancelled conversion between the unhandled can
> lead to the transaction abort. In the distant past cancelling balance
> was not easy and the extended RAID1 profiles were not availabe, so this
> problem is relatively new.
> 
> I'll add the patch to misc-next. We'll need a reproducer for that, I'll
> try to write it.

Definitely the Matt's patch solve a bug. However I have to point out that
the multiple meanings of 'flags' in the btrfs code (BG TYPE, RAID TYPE,
RAID TYPE SET...) creates a lot of confusion: to fully understand
btrfs_reduce_alloc_profile() I had to look at the callers and the
callers of the callers...

And even after, each time I some doubts....

Replacing flags with a struct { short bg_type; short raid_type; } would
require an huge effort; but the readability would increase a lot...

BR

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

