Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8874044BDCD
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 10:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhKJJeO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 04:34:14 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57754 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhKJJeO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 04:34:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 79EE22190C;
        Wed, 10 Nov 2021 09:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636536686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xaUGIhtwnMjh2FDT5MbpbNBDdTRaJVCqEURrpaKxOLE=;
        b=KrfAZGblzwm8p2Lce75A+D7cso84SE/QP7KthQMivM/Vkp8xKZMuu3DVIhhdFkVCX5npBn
        p1gF1BiOU8p8zfm4bcXeqGdz8dqFyE/ftv0vFt1z48+Wygl0l7FpeYmtuMS64DUbKwYy07
        74vNJaVQskNL+1UqbcVFyb0EL6VOrOE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 540E713B16;
        Wed, 10 Nov 2021 09:31:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TY7/EW6Ri2GMGQAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 10 Nov 2021 09:31:26 +0000
Subject: Re: [PATCH v2 1/3] btrfs: introduce BTRFS_EXCLOP_BALANCE_PAUSED
 exclusive state
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20211108142820.1003187-1-nborisov@suse.com>
 <20211108142820.1003187-2-nborisov@suse.com>
 <ec5447a6-b9bc-17ac-11a7-4fc14e1c6a82@oracle.com>
 <e6b4d90e-5e5a-37be-24a8-f493451a889b@suse.com>
 <6b09a082-fe67-a6da-7322-1822425e14c0@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <7563dfb3-5be8-7746-0851-055b849a67da@suse.com>
Date:   Wed, 10 Nov 2021 11:31:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6b09a082-fe67-a6da-7322-1822425e14c0@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.11.21 г. 10:56, Anand Jain wrote:
> 
> 
> On 9/11/21 11:33 pm, Nikolay Borisov wrote:
>> <snip>
>>
>>>
>>>> +void btrfs_exclop_pause_balance(struct btrfs_fs_info *fs_info)
>>>> +{
>>>> +    spin_lock(&fs_info->super_lock);
>>>> +    ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE ||
>>>> +           fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD);
>>>> +    fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE_PAUSED;
>>>> +    spin_unlock(&fs_info->super_lock);
>>>> +}
>>>> +
>>>
>>> This function can be more generic and replace its open coded version
>>> in a few places.
>>>
>>>   btrfs_exclop_balance(fs_info, exclop)
>>>   {
>>> ::
>>>      switch(exclop)
>>>      {
>>>          case BTRFS_EXCLOP_BALANCE_PAUSED:
>>>                ASSERT(fs_info->exclusive_operation ==
>>>                  BTRFS_EXCLOP_BALANCE ||
>>>                           fs_info->exclusive_operation ==
>>>                  BTRFS_EXCLOP_DEV_ADD);
>>>              break;
>>>          case BTRFS_EXCLOP_BALANCE:
>>>              ASSERT(fs_info->exclusive_operation ==
>>>                  BTRFS_EXCLOP_BALANCE_PAUSED);
>>>              break;
>>>      }
>>> ::
>>>   }
>>>
>>>
>>>>    static int btrfs_ioctl_getversion(struct file *file, int __user
>>>> *arg)
>>>>    {
>>>>        struct inode *inode = file_inode(file);
>>>> @@ -4020,6 +4029,10 @@ static long btrfs_ioctl_balance(struct file
>>>> *file, void __user *arg)
>>>>                if (fs_info->balance_ctl &&
>>>>                    !test_bit(BTRFS_FS_BALANCE_RUNNING,
>>>> &fs_info->flags)) {
>>>
>>>
>>>>                    /* this is (3) */
>>>> +                spin_lock(&fs_info->super_lock);
>>>> +                ASSERT(fs_info->exclusive_operation ==
>>>> BTRFS_EXCLOP_BALANCE_PAUSED);
>>>> +                fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE;
>>>
>>> Here you set the status to BALANCE running. Why do we do it so early
>>> without even checking if the user cmd is a resume? Like a few lines
>>> below?
>>>
>>>      4064 if (bargs->flags & BTRFS_BALANCE_RESUME) {
>>>
>>> I guess it is because of the legacy balance ioctl.
>>>
>>>      4927 case BTRFS_IOC_BALANCE:
>>>      4928 return btrfs_ioctl_balance(file, NULL);
>>>
>>> Could you confirm?
>>
>>
>> Actually no, I thought that just because we are in (3) (based on the
>> comments) the right thing would be done. However, that's clearly not the
>> case...
>>
>> I wonder whether putting the code under the & BALANCE_RESUME branch is
>> sufficient because as you pointed out the v1 ioctl doesn't handle args
>> at all. If I'm reading the code correctly balance ioctl v1 can't really
>> resume balance because it will always return with :
>>
> 
> 
>>      20         if (fs_info->balance_ctl) {
As this part of the code is very confusing I think it is better to split
the balance v1 and v2 codes into separate functions.
>>
>>      19                 ret = -EINPROGRESS;
>>
>>      18                 goto out_bargs;
>>
>>      17         }
>>
>> OTOH if I put the code right before we call btrfs_balance then there's
>> no way to distinguish we are starting from paused state
>>
>> <snip>
> 
> Yeah looks like the legacy code did not resume the balance, it supported
> the pause though or may be the trick was to remount to resume the
> balance?
> 
> As this part of the code is very confusing I think it is better to split
> the balance v1 and v2 codes into separate functions.


Actually V1 is going to be deprecated so I think the way forward is to
move the resume under the & BALANCE_RESUME branch.
