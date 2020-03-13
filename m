Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24F4D184FAB
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 20:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgCMTyf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 15:54:35 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46995 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbgCMTyf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 15:54:35 -0400
Received: by mail-qk1-f196.google.com with SMTP id f28so14673646qkk.13
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 12:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mV1LxLVZ6QlgXkCRhkGNJ9BAHbwYGHT8Okd+/xWpV5w=;
        b=nooI7K4UTGHNDT0PYNXYna3loyd6iq1wvXHR8FFWHhVzD52a7h9XW+fBY+z6Q1/wjG
         A0xzTJYf6NYPotmXqktcrTF1jUhcjwTsOx6+sQXHlJDJjGV7jq9UDt1/bZhk3LryqoXc
         ZxJHsAe1pDXpRQ9OVsh+Ak1MGFUMInQLgFFo7zzY0Gi497JsKZ0fA5bgpOdX7n4oLPd9
         agmTrwInHQCEEF2Nd7sVlsI2Z6o3bH5d9szwrtpNLzTg6Q+DS/bxynqRBuubVuFwtAwb
         u8g94GoD+n4tE8BAHlbiCY4TgqE3zTDS5xX1VczxByuhl60ahnraG1vGe/R6sGm6S69p
         p4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mV1LxLVZ6QlgXkCRhkGNJ9BAHbwYGHT8Okd+/xWpV5w=;
        b=WVjZMKjn0WHBgQU/ECLYfW1t6AqR35eqqz+Y4tPskQDZ4DfKWlP89XL5+vlUNrOkzL
         +9Sexek21j+treOim9djR3rBI5fGRq7CF9yHheqLgVG+abrpQ+NBbqDC6kuM+7XuXitD
         niIXkLiW2aKBBhIj84cya5xaZTqu0tbHazvPdjUQDFvelpQBv8YooB1Wzq18WTKXjp9f
         NiqISNeV/3UlIiSEAzjhtfwqPgI36Vio5evLfScXNe8ujFIrQ2pr89kpKhKwGKVC8I76
         BKb/0Novnj36xgX52ALLzqMBuAH9YVlvr1jwfV1uEGFoLgoLJ6ps/y8CmVjfe2u+OjGM
         R7kQ==
X-Gm-Message-State: ANhLgQ3vd+3XSWB+qFxeRBpXN1xVvFwmTvp4qs421KFTQy7x4Yz1vreK
        WwcTUcLrKWpO8UzaFtJmr5SeAg==
X-Google-Smtp-Source: ADFU+vs75P6IggylxMPUOdERl46uXCnIkwf7rUFPxfAQQJu8ungWXPauCscDZgyQRTu0nihaXTt2BQ==
X-Received: by 2002:a05:620a:55b:: with SMTP id o27mr12830087qko.291.1584129274119;
        Fri, 13 Mar 2020 12:54:34 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n74sm7958549qke.125.2020.03.13.12.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 12:54:33 -0700 (PDT)
Subject: Re: [PATCH 5/5] btrfs: run btrfs_try_granting_tickets if a priority
 ticket fails
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200309202322.12327-1-josef@toxicpanda.com>
 <20200309202322.12327-6-josef@toxicpanda.com>
 <43e5846b-17a4-8ff2-e6e1-26a3f201a672@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <54608474-8d91-029a-6e3d-51af53c949c7@toxicpanda.com>
Date:   Fri, 13 Mar 2020 15:54:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <43e5846b-17a4-8ff2-e6e1-26a3f201a672@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/10/20 6:32 AM, Nikolay Borisov wrote:
> 
> 
> On 9.03.20 г. 22:23 ч., Josef Bacik wrote:
>> With normal tickets we could have a large reservation at the front of
>> the list that is unable to be satisfied, but a smaller ticket later on
>> that can be satisfied.  The way we handle this is to run
>> btrfs_try_granting_tickets() in maybe_fail_all_tickets().
>>
>> However no such protection exists for priority tickets.  Fix this by
>> handling it in handle_reserve_ticket().  If we've returned after
>> attempting to flush space in a priority related way, we'll still be on
>> the priority list and need to be removed.
>>
>> We rely on the flushing to free up space and wake the ticket, but if
>> there is not enough space to reclaim _but_ there's enough space in the
>> space_info to handle subsequent reservations then we would have gotten
>> an ENOSPC erroneously.
>>
>> Address this by catching where we are still on the list, meaning we were
>> a priority ticket, and removing ourselves and then running
>> btrfs_try_granting_tickets().  This will handle this particular corner
>> case.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/space-info.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index 77ea204f0b6a..03172ecd9c0b 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -1256,11 +1256,17 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
>>   	ret = ticket->error;
>>   	if (ticket->bytes || ticket->error) {
>>   		/*
>> -		 * Need to delete here for priority tickets. For regular tickets
>> -		 * either the async reclaim job deletes the ticket from the list
>> -		 * or we delete it ourselves at wait_reserve_ticket().
>> +		 * We were a priority ticket, so we need to delete ourselves
>> +		 * from the list.  Because we could have other priority tickets
>> +		 * behind us that require less space, run
>> +		 * btrfs_try_granting_tickets() to see if their reservations can
>> +		 * now be made.
>>   		 */
>> -		list_del_init(&ticket->list);
>> +		if (!list_empty(&ticket->list)) {
>> +			list_del_init(&ticket->list);
>> +			btrfs_try_granting_tickets(fs_info, space_info);
>> +		}
> 
> I'd rather have this handled in priority_reclaim_metadata_space.

I'd have to put it both in there and priority_reclaim_data_space, this is 
cleaner.  Thanks,

Josef
