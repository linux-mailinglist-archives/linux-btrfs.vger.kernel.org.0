Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A282B3839BE
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 18:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345416AbhEQQ0r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 12:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243472AbhEQQ0m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 12:26:42 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B7CC068C87
        for <linux-btrfs@vger.kernel.org>; Mon, 17 May 2021 08:00:25 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id a2so5978445qkh.11
        for <linux-btrfs@vger.kernel.org>; Mon, 17 May 2021 08:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0iwhvs+6VvKWe5cUstxTCLL3gDqpdpHSbFsYoay5N9k=;
        b=aJtoVK31IL3XYzk4Ljmi8FNWT5sEx1fNSL9os/YhNRoHayO/p18JSEJhoxaHGRvG5i
         kFiFcwvvJW8q4/+h+vP0CvKrogeENot1VAfVm1DoLT8gmm45ftcb7FrUW+SIYnbsqHL5
         KnSvwKDL4UxADleu3rb4zo669TlnvjGaVm41RhihQlLz/+Q5or4J9tgKVRqxo/5n6q9O
         AgTTI04sZna5HXVTjOK4cHfOEJX92MQ9kuj1fxOed65Z9B0gjIM3VIfvgMm1iYgbeGJB
         Fm074hHCMECH0NgLj9y8yEHrhEVrsQwwkA0834qhAg32DVzLGYb5qCO/601McTKaNdXZ
         ZQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0iwhvs+6VvKWe5cUstxTCLL3gDqpdpHSbFsYoay5N9k=;
        b=AWn6w4nXX51xp8CP8PDlCJQEirZ3tH6a6XhyeadJEIukiSSicMcdba9QMmx7EYKsUG
         zy5gKytaNgdBsfmsGsWmCyvxMQaIpXKQ/Va2UpU5kD9kjrVrYul0c06OeyrDzdlEmG0l
         HY1xfhbfTJ3/asrE1ay+DWf9SAex+t01V74SYf52soCaoQk5e8XlddOMM7Z+ErrE6oU7
         2BPLfIEPY/jwAio/U3c3a+h8y94UfT3bIYHR0IghWh26knJugmrYBWcEOhMPq9ORVz1b
         EgjrtaTZE7oYVQ4WLIkhYpBQV/FTfxJ4WAjImxzxbU32t1RxH4NG7+1gAR7vXe9K+fo6
         AL2Q==
X-Gm-Message-State: AOAM533PTOHb7b8FWcRl1aQcjoSKFPQaDEG3MC9j30j7MUKyHMxpGWcY
        71KQo/n5rV8dubL3uehlYJ2EDA==
X-Google-Smtp-Source: ABdhPJzVZRUXR2A4P1VgifpzLXfuXyAqQKJXYQ9XPjD06JjLgDkZMPyV1FjTOjWUP3Su8/cx6PR8Iw==
X-Received: by 2002:a37:a2c5:: with SMTP id l188mr206208qke.413.1621263624266;
        Mon, 17 May 2021 08:00:24 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::1180? ([2620:10d:c091:480::1:9b79])
        by smtp.gmail.com with ESMTPSA id t139sm10646948qka.85.2021.05.17.08.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 08:00:23 -0700 (PDT)
Subject: Re: [PATCH v3] fsnotify: rework unlink/rmdir notify events
To:     Jan Kara <jack@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        amir73il@gmail.com, wangyugui@e16-tech.com
References: <568db8243e9faa0efb9ffb545ffac5a2f87e65ef.1620999079.git.josef@toxicpanda.com>
 <20210517144832.GC25760@quack2.suse.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <55e04814-3d3d-1884-b17d-95ed4b57dc33@toxicpanda.com>
Date:   Mon, 17 May 2021 11:00:21 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210517144832.GC25760@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/17/21 10:48 AM, Jan Kara wrote:
> Hi!
> 
> Thanks for the patch but I think you missed Amir's comments to your v2 [1]?
> Also ...
> 

I think they came in after I sent v3, but I got mailinglist signup spammed last 
week, so needless to say my ability to deal with emails for the last week has 
been hampered a bit.  I'm going through his review and will send out v4 
today/tomorrow.

>> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
>> index 42e5a766d33c..714e6f9b74f5 100644
>> --- a/fs/devpts/inode.c
>> +++ b/fs/devpts/inode.c
>> @@ -617,12 +617,17 @@ void *devpts_get_priv(struct dentry *dentry)
>>    */
>>   void devpts_pty_kill(struct dentry *dentry)
>>   {
>> +	struct inode *dir = d_inode(dentry->d_parent);
>> +	struct inode *inode = d_inode(dentry);
>> +
>>   	WARN_ON_ONCE(dentry->d_sb->s_magic != DEVPTS_SUPER_MAGIC);
>>   
>> +	ihold(inode);
>>   	dentry->d_fsdata = NULL;
>>   	drop_nlink(dentry->d_inode);
>> -	fsnotify_unlink(d_inode(dentry->d_parent), dentry);
>>   	d_drop(dentry);
>> +	fsnotify_delete(dir, dentry, inode);
>> +	iput(inode);
>>   	dput(dentry);	/* d_alloc_name() in devpts_pty_new() */
>>   }
> 
> AFAICT d_drop() actually doesn't make the dentry negative so there's no
> need for this inode reference game? And similarly for d_invalidate() below?
> Or am I missing something?
> 

Nope you're right, I had it in my head that ___d_drop would do the 
dentry_unlink_inode, but it doesn't, I'll fix this, thanks,

Josef
