Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E85389466
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 19:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241286AbhESRIm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 13:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240245AbhESRIm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 13:08:42 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F355CC06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 10:07:21 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id z1so7155996qvo.4
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 10:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=BzXlP3+BOiPWRQ54+0PMmXQrAspCbtHqiM16linQi5M=;
        b=GyYGOjUHBbowgx0hPM9h4dzH9ZUaJxQJIl/JjCr2bXQkbtLm1ZReURyBWudqSWH//y
         EcnT1LabDbGNwhU4oq81mYazNSgQOVfcRJnHENIJeQU36fiN2KmzuBqdDjmE6MKVDaYv
         XDs9GJ7OL5URXlQf33tI3v7BErYmDPdrZl0Xl9coad13c3aUfuGBr90qHURLLbJ0hxNN
         SOKV1JEGYgnCzSDJMeG+O+U6hoEpU81OSoDMJJ2lBXz4OTqUQZz69LazSOS147iJES39
         IWFjXjk29zvxXSpkL13LGJdZ2w6V7OtRogVyFt2lxn1IOCi3q6O1/6XRMnyZkYQLpssl
         1uVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BzXlP3+BOiPWRQ54+0PMmXQrAspCbtHqiM16linQi5M=;
        b=elt/ZXMGBFm+qWwWSRvlwMmbfLnSx9QuT13wEckkIS0kNqshFTcBUmp2THAMakhp5n
         t1KUROGFhBAQs0BtkQLYQiTUD9iCpIOTnksCTfuErruRyuFiT9lwMbD9mkPppTqn3+Pf
         PWRiz0b7VN0tIYiom2d3VkOgsmkvWKhnRnf0fzsC33bzG7In2AdzKf1hc5xI0zgBgFsj
         gCf1aGQ8lgkjt/WIXEQQxmKdyNUTw9rOOvKNSMuiYKt91QtwLaYXU6lEqp0QE0j4VepY
         z+I7iFbly1Z1dbD68tI/g5Rn/VDRv+M0q1Ooo2iqGlA+T5bFR95NnGzLFKbArBdq9aH/
         62zQ==
X-Gm-Message-State: AOAM5305OGV1uH/rmZZB90jP5FLvYe11qz6O1Qb2LAgGReCi23afvvdG
        KXDp0uPINvMCBjyFs+SbZje79g==
X-Google-Smtp-Source: ABdhPJwaOhmhS6ja7NeTo69vB40NMqiGPIp62f+S88sWBum8Tgfk7iIxAeYNoTCiCjxSpNc4nncImw==
X-Received: by 2002:a0c:e3ce:: with SMTP id e14mr510235qvl.49.1621444041054;
        Wed, 19 May 2021 10:07:21 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c9::116c? ([2620:10d:c091:480::1:f365])
        by smtp.gmail.com with ESMTPSA id t191sm195132qke.100.2021.05.19.10.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 10:07:20 -0700 (PDT)
Subject: Re: [PATCH v2] btrfs: do not infinite loop in data reclaim if we
 aborted
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <33a744a9768b0a46b8993c1fc39bacebb43579a9.1621438991.git.josef@toxicpanda.com>
 <PH0PR04MB7416920AA5234C219180EC959B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9875d1a2-1544-4373-4b4f-199fdd880ddc@toxicpanda.com>
Date:   Wed, 19 May 2021 13:07:19 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <PH0PR04MB7416920AA5234C219180EC959B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/19/21 12:11 PM, Johannes Thumshirn wrote:
> On 19/05/2021 17:45, Josef Bacik wrote:
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index 42d0fa2092d4..0d36d684d552 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -941,6 +941,8 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
>>   	struct reserve_ticket *ticket;
>>   	u64 tickets_id = space_info->tickets_id;
>>   	u64 first_ticket_bytes = 0;
>> +	bool aborted = test_bit(BTRFS_FS_STATE_TRANS_ABORTED,
>> +				&fs_info->fs_state);
> 
> can't this be const bool aborted = ...?
> 
> 
>> @@ -1253,6 +1259,15 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)>  			spin_unlock(&space_info->lock);
>>   			return;
>>   		}
> 
> Although this pattern is only twice in btrfs_async_reclaim_data_space()
> 
> 	const bool aborted = test_bit(BTRFS_FS_STATE_TRANS_ABORTED,
> 				      &fs_info->fs_state);
> 
> here as well?

We can't because it could have changed at some point while trying to reclaim 
space, so we have to check it every loop.  I'll make the other related changes 
tho, thanks,

Josef
