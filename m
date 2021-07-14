Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4020C3C7F40
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 09:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238129AbhGNHV1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 03:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbhGNHV1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 03:21:27 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0E8C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 00:18:35 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id j199so1212338pfd.7
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 00:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=G5hpqnd/EPaes0Tyb7HVsg6XMvhlib07jp+mo1aAquM=;
        b=oSnR+0JWoZhtK64yxlzNJgLvZIDjbuGeRPxwGieCwt3O+yHGXPj6ujq32UYG+XtV6b
         6jNePMrKtHdz98JD4gXb0PG9MLF8AIbRoJS756U59J9maS4++rsEf737IQG8BSY+eLDh
         IgxRxLU2HhozGwPiG5Z1NAnpAJtBsqJc6N6B7eT16Ih0SAjYSXhnaPpNcgJUi9PdCppe
         iCpZ2//NH9MabPc9WUAffvATWH08KwtyfT1w2OCjUHgGcY0El6Wqi8B6Al9A/IicyB4e
         8JvfOuzqZpJbu71mxJsswwqruKWNF4kd8+MK3QMp/mnk7HsTkQi6+Ywh33dWleyUFsgZ
         DjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=G5hpqnd/EPaes0Tyb7HVsg6XMvhlib07jp+mo1aAquM=;
        b=s1Bq9l6VWk+BlGjDOkqHomi7nAuJZlWYttYfA4H10vqKKbQnGN1k5/E3d9RTGMAarx
         tStFgIKiOvLIqMTNgmUCgPO7ZcxL//iM2QkHz5vaM5EhoQHQGlJciEOyb40Fsp66nGv1
         jP5HWtuvY/bWYgod3X+y1sI//2zDkNst/xL98Jqn4JL/hUFlMqqYdX8OCOBfmvyZbE3n
         0kHEf/SToZWZBU9RA9SApxQw7sWeav7BTG0nwGinhwxXKYMd+IQvuaIfZex7BiUxo9eN
         cGMFfKmCAk42VJxe4X5reGKqqiYenezJZbhSV1EzqxO92klFrHjtpwfoAqc0MDA2pTkb
         T6yA==
X-Gm-Message-State: AOAM531SBVeBi1Ki6knqdOfcjkszuAdMvcET04FqJrPCg/pio0EA1GCN
        dU52VDWHyzP1xi8NGLY3O8A=
X-Google-Smtp-Source: ABdhPJxYoYs4VuUL/VGUSdsyxWGGwWsuIy3fokq/rwfKFUKMO2BKTSaxWzrAFbdBoAQ8944cNqnAbw==
X-Received: by 2002:a63:2b92:: with SMTP id r140mr8117132pgr.394.1626247115038;
        Wed, 14 Jul 2021 00:18:35 -0700 (PDT)
Received: from [192.168.178.53] (14-203-78-180.tpgi.com.au. [14.203.78.180])
        by smtp.gmail.com with ESMTPSA id k19sm1339981pji.32.2021.07.14.00.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 00:18:34 -0700 (PDT)
Subject: Re: migrating to space_cache=2 and btrfs userspace commands
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <63396688-0dc7-17c5-a830-5893b030a30f@gmail.com>
 <86f0624a-cba4-58a3-0a80-460d3f12e8b3@gmx.com>
From:   DanglingPointer <danglingpointerexception@gmail.com>
Cc:     danglingpointerexception@gmail.com
Message-ID: <c81f758f-c452-d30c-75a2-a6cdcf2f9a8e@gmail.com>
Date:   Wed, 14 Jul 2021 17:18:31 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <86f0624a-cba4-58a3-0a80-460d3f12e8b3@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

a) "echo l > /proc/sysrq-trigger"

The backup finished today already unfortunately and we are unlikely to 
run it again until we get an outage to remount the array with the 
space_cache=v2 and noatime mount options.
Thanks for the command, we'll definitely use it if/when it happens again 
on the next large migration of data.


b) "sudo btrfs qgroup show -prce" ........

$ ERROR: can't list qgroups: quotas not enabled

So looks like it isn't enabled.

File sizes are between: 1,048,576 bytes and 16,777,216 bytes (Duplicacy 
backup defaults)

What classifies as a transaction?  Any/All writes done in a 30sec 
interval?  If 100 unique files were written in 30secs, is that 1 
transaction or 100 transactions?  Millions of files of the size range 
above were backed up.


c) "Just mount with "space_cache=v2""

Ok so no need to "clear_cache" the v1 cache, right?
I wrote this in the fstab but hadn't remounted yet until I can get an 
outage....

..."btrfs defaults,autodefrag,clear_cache,space_cache=v2,noatime  0  2"

Thanks again for your help Qu!

On 14/7/21 2:59 pm, Qu Wenruo wrote:
>
>
> On 2021/7/13 下午11:38, DanglingPointer wrote:
>> We're currently considering switching to "space_cache=v2" with noatime
>> mount options for my lab server-workstations running RAID5.
>
> Btrfs RAID5 is unsafe due to its write-hole problem.
>
>>
>>   * One has 13TB of data/metadata in a bunch of 6TB and 2TB disks
>>     totalling 26TB.
>>   * Another has about 12TB data/metadata in uniformly sized 6TB disks
>>     totalling 24TB.
>>   * Both of the arrays are on individually luks encrypted disks with
>>     btrfs on top of the luks.
>>   * Both have "defaults,autodefrag" turned on in fstab.
>>
>> We're starting to see large pauses during constant backups of millions
>> of chunk files (using duplicacy backup) in the 24TB array.
>>
>> Pauses sometimes take up to 20+ seconds in frequencies after every
>> ~30secs of the end of the last pause.  "btrfs-transacti" process
>> consistently shows up as the blocking process/thread locking up
>> filesystem IO.  IO gets into the RAID5 array via nfsd. There are no disk
>> or btrfs errors recorded.  scrub last finished yesterday successfully.
>
> Please provide the "echo l > /proc/sysrq-trigger" output when such pause
> happens.
>
> If you're using qgroup (may be enabled by things like snapper), it may
> be the cause, as qgroup does its accounting when committing transaction.
>
> If one transaction is super large, it can cause such problem.
>
> You can test if qgroup is enabled by:
>
> # btrfs qgroup show -prce <mnt>
>
>>
>> After doing some research around the internet, we've come to the
>> consideration above as described.  Unfortunately the official
>> documentation isn't clear on the following.
>>
>> Official documentation URL -
>> https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)
>>
>> 1. How to migrate from default space_cache=v1 to space_cache=v2? It
>>     talks about the reverse, from v2 to v1!
>
> Just mount with "space_cache=v2".
>
>> 2. If we use space_cache=v2, is it indeed still the case that the
>>     "btrfs" command will NOT work with the filesystem?
>
> Why would you think "btrfs" won't work on a btrfs?
>
> Thanks,
> Qu
>
>>   So will our
>>     "btrfs scrub start /mount/point/..." cron jobs FAIL?  I'm guessing
>>     the btrfs command comes from btrfs-progs which is currently v5.4.1-2
>>     amd64, is that correct?
>> 3. Any other ideas on how we can get rid of those annoying pauses with
>>     large backups into the array?
>>
>> Thanks in advance!
>>
>> DP
>>
