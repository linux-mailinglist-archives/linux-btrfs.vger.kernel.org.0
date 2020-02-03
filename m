Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADEB2150FF7
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 19:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgBCSvM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 13:51:12 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37059 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgBCSvM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 13:51:12 -0500
Received: by mail-qk1-f195.google.com with SMTP id 21so15302369qky.4
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 10:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AFAVijNneXCH0DUQuWS+1hNYy1gvQ361eRE50lu5LRo=;
        b=ZQd0SAkErLYXh9+iySaiu/K2uXfcw/0UBAj31cfKIobeVYjxzR69/QXKe1hihi30oC
         2p74OZK2720V8IAiKIjt4EkB/vxB3RRP8f0luK7FmbHxfiG20Zr5zcE13oxCyTXUUeX3
         tJlzmgyutO4KpRIW7qQBQcyn1hYD9gLJpGXvqzkt4gQsZ9ni1fStHzYo/Nj/XHxeP1rL
         KnsK0x5Nk27hJNf6SfcMa0/wPvHwI2NQuPTqQ3TdbBVVa00DShykvkT/EyfcfKybdlFu
         X2jF5xV6pxx/CWUEexb5T9ZByoGMihMhWwV24FWdX8/cj+3RV/KCkSTQzsQF52i7Hada
         ZqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AFAVijNneXCH0DUQuWS+1hNYy1gvQ361eRE50lu5LRo=;
        b=AMTdj6IQ+L/huGAvHi+Xwvgz8mlNl7K8VuzrPG9yEsli18GN5L6OUh6jYzI8KOXmOi
         S6FYpKl+tOGFdnz2lJm2a//SBgOkE5tiqryiH2NFFsDvE6EZHk89EDRlw6N41Y1xHHCH
         snv0KBkjE/Riy6z3PCpoDcXuBNdOz9PmOYkrYl2SWhZ6+wfGL0Ppef8hEUXzTTtlpDRN
         rDl98Pv8f9ze60XMg1cqp728gyOPsHYYYkYnyoPMp1xvBsPOVVcD0T5IpCha4E/uOlIc
         5avA+mEfu8Fc8h8JzP97V4GfHD9jxX7tyS2ofAhHplREMoY02N3uHg3fPd+kU5rlaYMT
         mu8g==
X-Gm-Message-State: APjAAAWwZwI9qJPjonpo5GdxiHC8SleefX7VpfarX/X2CKTOsW6N1zoF
        1n7oOKvXmfpOi3Av5iD1frHh1g==
X-Google-Smtp-Source: APXvYqzGArOvh/eKCMAWwAnoQv7mr597LOro8B6UMw2uL6Pf43QaBboZIf5j4pdOjJWPJb8yg5ah6Q==
X-Received: by 2002:a37:6313:: with SMTP id x19mr24143792qkb.443.1580755870946;
        Mon, 03 Feb 2020 10:51:10 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p19sm9700701qkm.69.2020.02.03.10.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 10:51:10 -0800 (PST)
Subject: Re: [PATCH 23/23] btrfs: do async reclaim for data reservations
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200131223613.490779-1-josef@toxicpanda.com>
 <20200131223613.490779-24-josef@toxicpanda.com>
 <e1f19786-38d1-10fd-a1a1-9354f18c6aa8@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <da1b4650-868c-cb05-197b-b560e6239f78@toxicpanda.com>
Date:   Mon, 3 Feb 2020 13:51:09 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <e1f19786-38d1-10fd-a1a1-9354f18c6aa8@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/3/20 12:19 PM, Nikolay Borisov wrote:
> 
> 
> On 1.02.20 г. 0:36 ч., Josef Bacik wrote:
>> Now that we have the data ticketing stuff in place, move normal data
>> reservations to use an async reclaim helper to satisfy tickets.  Before
>> we could have multiple tasks race in and both allocate chunks, resulting
>> in more data chunks than we would necessarily need.  Serializing these
>> allocations and making a single thread responsible for flushing will
>> only allocate chunks as needed, as well as cut down on transaction
>> commits and other flush related activities.
>>
>> Priority reservations will still work as they have before, simply
>> trying to allocate a chunk until they can make their reservation.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com> but look below for one
> minor nit.
> 
>> ---
>>   fs/btrfs/ctree.h      |   3 +-
>>   fs/btrfs/disk-io.c    |   2 +-
>>   fs/btrfs/space-info.c | 123 ++++++++++++++++++++++++++++++------------
>>   3 files changed, 91 insertions(+), 37 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 865b24a1759e..709823a23c62 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -493,7 +493,7 @@ enum btrfs_orphan_cleanup_state {
>>   	ORPHAN_CLEANUP_DONE	= 2,
>>   };
>>   
>> -void btrfs_init_async_reclaim_work(struct work_struct *work);
>> +void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
> 
> nit: This doesn't bring much value apart from introducing yet another
> function, I'd rather have the 2 INIT_WORK calls open coded in init_fs_info.

Then I'd have to export the two reclaim functions, thats why this exists.  Thanks,

Josef
