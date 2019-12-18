Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2BE8125256
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 20:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfLRTyr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 14:54:47 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40897 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfLRTyr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 14:54:47 -0500
Received: by mail-qt1-f196.google.com with SMTP id e6so2934733qtq.7
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2019 11:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=gUYCfJkvoOW9sK/HezS/S1t6qq/dHNlAaZb//bG4t8w=;
        b=iA1ZrmcTZLU3+eTlAlHFmX16tb5XtE/h5L1OA0P8/h2vDl3GZnq6sZhgv7p0eQSzOc
         4X/idVUpZ4QbbHRA1s6iYYABDUKwupiNvU15grLA1I/2NigJfIxbuwEbHW8UIZpNY0Su
         1vmv8KRDLnBEPQreUQp9U3uDexs7bsMQZaCtmZTuvMUdvdgZ/rUmkKf18SuZUtzJkbXy
         tuEksNSirqQ3o43+jjiPPeuxFY7I6Drb8UMPWT/l4Z9nF1OYe75RmXqf8GCt5BtwRyxI
         gt7aQzSCJrbtNMVYhdCc0fP7j/sCTbFoiP5PXy23TkPTBYMNgyev5wsnAMy/bd/emsNS
         tGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gUYCfJkvoOW9sK/HezS/S1t6qq/dHNlAaZb//bG4t8w=;
        b=PhkRhUDetHeo3H3JvZdop/d9PmDiO5efBrWv6VSM3et8dZhJO3CAZYrPm41Jc4+Vhc
         qYVAnZ9ZOarRllmfh+dmxl6E8NLiatRchc9Dmj+V7pXkt3dOogc41eSgmPUH905EKjx4
         JJTaZH0qnsRLoVH2bdhqqnHdeYyN596cD2x4ehplj7SavqN7d949s6FmYsF5RGM/ZzC9
         Jk7IAZTnLWCE4291Nr509MdkIBGM82P2gBr/m0e6iwLcMWw5evl+GalbItSNp3Lue0SZ
         A8xgCtetWgYsOvJGuiXDGjUxAlrqeDrp4mY4eFzoux9IgcU1JFmxsrFQJa0VrPkxjxql
         GMKw==
X-Gm-Message-State: APjAAAW6Slodc3tFWlRb/Tz/lI8vtp3RaG602Kpn+s68CKCq4QlIjzhR
        lo7suVg+50/FklCF5GqjS+dJBg==
X-Google-Smtp-Source: APXvYqzbtm3z5WynvFhk7k05Tloq0ed/h9hIClr8b60GvBYq+F+ai9cRDgvk8l88e3HEz9eFD3OrmQ==
X-Received: by 2002:ac8:71d7:: with SMTP id i23mr3888982qtp.50.1576698886089;
        Wed, 18 Dec 2019 11:54:46 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::65a1])
        by smtp.gmail.com with ESMTPSA id d8sm1024807qtr.53.2019.12.18.11.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 11:54:45 -0800 (PST)
Subject: Re: [PATCH] btrfs: remove BUG_ON used as assertions
To:     dsterba@suse.cz, Aditya Pakki <pakki001@umn.edu>, kjlu@umn.edu,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191215171237.27482-1-pakki001@umn.edu>
 <2f9d6549-47cf-fb71-3bff-50b51093e757@toxicpanda.com>
 <20191218164706.GP3929@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <57ffdc3b-59c7-66d4-8e55-909ad4710f5f@toxicpanda.com>
Date:   Wed, 18 Dec 2019 14:54:44 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191218164706.GP3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/18/19 11:47 AM, David Sterba wrote:
> On Wed, Dec 18, 2019 at 11:38:18AM -0500, Josef Bacik wrote:
>> On 12/15/19 12:12 PM, Aditya Pakki wrote:
>>> alloc_extent_state_atomic() allocates extents via GFP_ATOMIC flag
>>> and cannot fail. There are multiple invocations of BUG_ON on the
>>> return value to check for failure. The patch replaces certain
>>> invocations of BUG_ON by returning the error upstream.
>>>
>>> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
>>
>> I already tried this a few months ago and gave up.  There are a few things if
>> you want to tackle something like this
>>
>> 1) use bpf's error injection thing to make sure you handle every path that can
>> error out.  This is the script I wrote to do just that
>>
>> https://github.com/josefbacik/debug-scripts/blob/master/error-injection-stress.py
>>
>> 2) We actually can't fail here.  We would need to go back and make _all_ callers
>> of lock_extent_bits() handle the allocation error.  This is theoretically
>> possible, but a giant pain in the ass.  In general we can make allocations here
>> and we need to be able to make them.
>>
>> 3) We should probably mark this path with __GFP_NOFAIL because again, this is
>> locking and we need locking to succeed.
> 
> NOFAIL can introduce loops that could lead to deadlocks, if not used
> carefully. __set_extent_bit is not just locking, so if one thread wants
> to set bits, allocate, wait, allocator goes to write some memory
> 
> eg.
> 
> set_extent_bit on some range
>    alloc state (NOFAIL)
>      allocator wants to flush dome dirty data
>                     ------------------------------>
> 		                               set_extent_bit
> 					         alloc state (NOFAIL)
> 						 (wait)
> 

Yes obviously I just want it for EXTENT_LOCKED.  But we could even just use a 
mempool to be really safe, since most places are going to use GFP_KERNEL or 
something else related, we only really need the safety in a few critical areas. 
Thanks,

Josef

