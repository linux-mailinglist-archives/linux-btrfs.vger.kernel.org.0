Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE5AD176446
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 20:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgCBTvO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 14:51:14 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42475 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBTvO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Mar 2020 14:51:14 -0500
Received: by mail-qt1-f196.google.com with SMTP id r6so920490qtt.9
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2020 11:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=L2JnGFHO8nad49gww5trL3iiLOP9OVbaIh5vHRmaYOU=;
        b=BpcikHDqvFqRndxNjereD3K6/e1qLYzVgOmqnE5nnXWVqJBVyzgpGKG2mibQ0MO/wx
         XZOplfivByV+DnLxwKbMEwpvWrZbmCrokqEpQ7kAKHu9ugP+11fUbMZTSC0PtrdmgbO9
         tAZqaSfJZ30eumi6GELJesmiBvdKBI8uiUwGRU3qInQ7z6VyMJPLUdg2hj+w7Ii+mHYO
         wBLo2oNWyr/YByBswv64Z7ktu1eKcQjg2yW41hYmkOTKClYS/ESqoeH55FyhuUtbOT3z
         9LDDhdRJQNaJcjyi00x2/09QQGf8c8Oi/aZ3Z+1lNnP+VcPvK7GdM/YdNfKYj5M1Ef8B
         mwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L2JnGFHO8nad49gww5trL3iiLOP9OVbaIh5vHRmaYOU=;
        b=fl6v0ZUTmdPVY3DijGU0hifxHBI/4FMguNn0874I+fqMLn7BV+/I6m4sGDy7D5QpZw
         WvsKfVcJ4c1VKD8TnD5Ym9UWB85pfzEI9fn9+kiqxbkLJb+NoMGsak771ZPd7ZaFAEqu
         eoFITmmTF+kXxrgijMJf13uB7vRjvqqMmRQ48eSXUHYvhQGYyFVE+1iwynh9kFlH9CQt
         TE/DMVzciYnz+e12rLdkj66QJW0VN0OeVUjNrFD2LiVuS3hlgQHRqCH1SHuwRxDrci/N
         QpyP2cgzVTy4UX2UFWVEa5MsisEfYKiUa33WNEPzhf9eneIdXQbE4srknxo9GMUzr3ai
         d/FA==
X-Gm-Message-State: ANhLgQ3I+Cqj49GXQNeXKHCQ7GjO7qHW2msXGx+mrbgMW4dDGHmoWFH6
        Ywmvcq91NkqqiQixfmrak69Gyh7UZno=
X-Google-Smtp-Source: ADFU+vtK3dnwdXZZhrOVA4gr2V6Vo9THBxoYpx3ix0L5hKmcVPt5lktaeJ05faDKo7ABaGgkKBduIA==
X-Received: by 2002:ac8:140e:: with SMTP id k14mr1287600qtj.222.1583178672831;
        Mon, 02 Mar 2020 11:51:12 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o10sm10729500qtp.38.2020.03.02.11.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 11:51:12 -0800 (PST)
Subject: Re: [PATCH 5/7] btrfs: clear BTRFS_ROOT_DEAD_RELOC_TREE before
 dropping the reloc root
To:     dsterba@suse.cz, kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <20200302184757.44176-1-josef@toxicpanda.com>
 <20200302184757.44176-6-josef@toxicpanda.com>
 <20200302193120.GS2902@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ab3e1533-d0e3-8ab7-0d72-acf71ce66968@toxicpanda.com>
Date:   Mon, 2 Mar 2020 14:51:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302193120.GS2902@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/2/20 2:31 PM, David Sterba wrote:
> On Mon, Mar 02, 2020 at 01:47:55PM -0500, Josef Bacik wrote:
>> We were doing the clear dance for the reloc root after doing the drop of
>> the reloc root, which means we have a giant window where we could miss
>> having BTRFS_ROOT_DEAD_RELOC_TREE unset and the reloc_root == NULL.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/relocation.c | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index e60450c44406..acd21c156378 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -2291,18 +2291,19 @@ static int clean_dirty_subvols(struct reloc_control *rc)
>>   
>>   			list_del_init(&root->reloc_dirty_list);
>>   			root->reloc_root = NULL;
>> -			if (reloc_root) {
>> -
>> -				ret2 = btrfs_drop_snapshot(reloc_root, NULL, 0, 1);
>> -				if (ret2 < 0 && !ret)
>> -					ret = ret2;
>> -			}
>>   			/*
>>   			 * Need barrier to ensure clear_bit() only happens after
>>   			 * root->reloc_root = NULL. Pairs with have_reloc_root.
>>   			 */
>>   			smp_wmb();
>>   			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
>> +
>> +			if (reloc_root) {
>> +
>> +				ret2 = btrfs_drop_snapshot(reloc_root, NULL, 0, 1);
>> +				if (ret2 < 0 && !ret)
>> +					ret = ret2;
>> +			}
> 
> This reverts fix 1fac4a54374f7ef385938f3c6cf7649c0fe4f6cd that moved if
> (reloc_root) before the clear_bit.
> 

Hmm we should probably keep this and move the

if (root->reloc_root)

thing after the

         if (!rc || !rc->create_reloc_tree ||
             root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID)
                 return 0;

to properly fix this.  I'll add this and send an updated series.  Thanks,

Josef
