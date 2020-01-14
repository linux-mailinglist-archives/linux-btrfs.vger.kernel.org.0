Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDF2C13B40B
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 22:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgANVHZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 16:07:25 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36412 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgANVHZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 16:07:25 -0500
Received: by mail-pj1-f65.google.com with SMTP id n59so6446959pjb.1
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2020 13:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Y7svnatiMSizeYIPE6aEFJLbodTzbyI5SjmQIIMVFl4=;
        b=InOr4dJAsb41K/9qJKFTnMiPVtIN6MAChKrd20VauT/vc8/10YaCtve6LVRVJAJhEU
         MCxfLQAj/BFUQKV5HZKeTqyueuHYbOkM/FITcJXaFUJDIjVausFUEVPWsa2hNA/WHqCA
         ZOkh+8s9aCzmareacbnBS5If7BnjXvBKGtd3KjIi3EQG7v4VeLSbMZD+kqj/rRJREZkv
         2C9pV4kM/ddO1950OX49dUd/7BmqXxoTrwwEbWl/RZ8jET14I16VjPBtHpVt1PhrSsZZ
         A6JoVY/74Pgb0rg7NRWEmC7m6HuDhpijKh2b32Aamtyyn+WRA6yFICMsI3eumhkQphZP
         Kt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y7svnatiMSizeYIPE6aEFJLbodTzbyI5SjmQIIMVFl4=;
        b=pCI0uojiT0EVPRvl5sIl80mdrrlvdgLepGQCArIuOP5gBQe0wNXaVb1/8hV8bu0+VX
         HyXvZp+z6vmLHrWPYcu8k9+oPG1/k5ubuKgWPnGamHi7y2UNfcMjZ99/kUPPYsSMPhLb
         G9OIIWHkmIDUgQgrOCYPxCQD16/pP1NsCsFClPEt1X48KiF8ySG9Cbk5j1XNsUUOF/WS
         TMXsP92y08eSq6doDgxeozGGKmG7gecf/fB9PUITx7DR6Bip1ep335KH8xvkCCdSz23N
         xEtBabcu92UAJEg7nor/Enb6TEXmD1iA0Df95KQDz71MBkUX94UxkBIrJcV9V5xfHBGU
         CW+A==
X-Gm-Message-State: APjAAAV8YmCTuQV6/2f4UBvswqK4kB6RyHJMfgBhGnPR+5jBc0r34H1S
        jyoo4GklCBMWWLxeMa4YCeTZ1cCKjB8SJg==
X-Google-Smtp-Source: APXvYqwIfgLcvLtQQcdUqj4gb+M0wFt/kJrJLHIuBN78bwzqqQsgiw5cxEtdCllWuBbiC1lm3I4Xaw==
X-Received: by 2002:a17:902:fe0b:: with SMTP id g11mr2040876plj.0.1579036044134;
        Tue, 14 Jan 2020 13:07:24 -0800 (PST)
Received: from [172.31.181.199] ([216.9.110.1])
        by smtp.gmail.com with ESMTPSA id d24sm19730572pfq.75.2020.01.14.13.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 13:07:23 -0800 (PST)
Subject: Re: [PATCH 1/5] btrfs: check rw_devices, not num_devices for
 restriping
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200110161128.21710-1-josef@toxicpanda.com>
 <20200110161128.21710-2-josef@toxicpanda.com>
 <20200114205609.GL3929@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <801709ca-22cd-f6ed-4e39-622a6aa1a1e6@toxicpanda.com>
Date:   Tue, 14 Jan 2020 13:07:22 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200114205609.GL3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/14/20 12:56 PM, David Sterba wrote:
> On Fri, Jan 10, 2020 at 11:11:24AM -0500, Josef Bacik wrote:
>> While running xfstests with compression on I noticed I was panicing on
>> btrfs/154.  I bisected this down to my inc_block_group_ro patches, which
>> was strange.
> 
> Do you have stacktrace of the panic?
> 

I don't have it with me, I can reproduce when I get back.  But it's a 
BUG_ON(ret) in init_reloc_root when we do the copy_root, because we get an 
ENOSPC when trying to allocate the tree block.


>> What was happening is with my patches we now use btrfs_can_overcommit()
>> to see if we can flip a block group read only.  Before this would fail
>> because we weren't taking into account the usable un-allocated space for
>> allocating chunks.  With my patches we were allowed to do the balance,
>> which is technically correct.
> 
> What patches does "my patches" mean?
> 

The ones that convert the inc_block_group_ro() to use btrfs_can_overcommit().

>> However this test is testing restriping with a degraded mount, something
>> that isn't working right because Anand's fix for the test was never
>> actually merged.
> 
> Which patch is that?

It says in the header of btrfs/154.  I don't have xfstests in front of me right now.

> 
>> So now we're trying to allocate a chunk and cannot because we want to
>> allocate a RAID1 chunk, but there's only 1 device that's available for
>> usage.  This results in an ENOSPC in one of the BUG_ON(ret) paths in
>> relocation (and a tricky path that is going to take many more patches to
>> fix.)
>>
>> But we shouldn't even be making it this far, we don't have enough
>> devices to restripe.  The problem is we're using btrfs_num_devices(),
>> which for some reason includes missing devices.  That's not actually
>> what we want, we want the rw_devices.
> 
> The wrapper btrfs_num_devices takes into account an ongoing replace that
> temporarily increases num_devices, so the result returned to balance is
> adjusted.
> 
> That we need to know the correct number of writable devices at this
> point is right. With btrfs_num_devices we'd have to subtract missing
> devices, but in the end we can't use more than rw_devices.
> 
>> Fix this by getting the rw_devices.  With this patch we're no longer
>> panicing with my other patches applied, and we're in fact erroring out
>> at the correct spot instead of at inc_block_group_ro.  The fact that
>> this was working before was just sheer dumb luck.
>>
>> Fixes: e4d8ec0f65b9 ("Btrfs: implement online profile changing")
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/volumes.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 7483521a928b..a92059555754 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -3881,7 +3881,14 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
>>   		}
>>   	}
>>   
>> -	num_devices = btrfs_num_devices(fs_info);
>> +	/*
>> +	 * rw_devices can be messed with by rm_device and device replace, so
>> +	 * take the chunk_mutex to make sure we have a relatively consistent
>> +	 * view of the fs at this point.
> 
> Well, what does 'relatively consistent' mean here? There are enough
> locks and exclusion that device remove or replace should not change the
> value until btrfs_balance ends, no?
> 

Again I don't have the code in front of me, but there's nothing at this point to 
stop us from running in at the tail end of device replace or device rm.  The 
mutex keeps us from getting weirdly inflated values when we increment and 
decrement at the end of device replace, but there's nothing (that I can 
remember) that will stop rw devices from changing right after we check it, thus 
relatively.  Thanks,

Josef
