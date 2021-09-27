Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2B24197FD
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 17:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbhI0PeQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 11:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbhI0PeP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 11:34:15 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841BAC061575
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 08:32:37 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 72so37055628qkk.7
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 08:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OfRmtDip7ctNwmewgiuc7vV8cq8065TWDM8NBFELzsU=;
        b=jdoX2A+LEUvjVEd/sWeN5Rzu50tUNZkhL2Kn5uqUTHe4+F2DZCGJqFiMq4CvQJj+R5
         3jiGb1ZyB+1xmnOEeiUc4S0JEEYlRWcFHSR3Ck3ces0NmGlboyD19IbMvnb8s7ddJ6qx
         omsZGasVe4/Q+tJatkJjplWF8v2799oLDWChlGJRlKWTI75aBjwyGjqdgo0RTNEpPLN/
         Jp0sOeQhS8JsStGdgLZcE65bWsm47Tl7y7aur3MJ7518LWGfTw/spBV75VjG+i9ISpeW
         ek2RjFKw1c7sfTeyjAt5+OwqNMPwYpbg5cFFUSw3tK5U8jPjnMMv11lYtioxRggB6dhR
         C40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OfRmtDip7ctNwmewgiuc7vV8cq8065TWDM8NBFELzsU=;
        b=GTM8olvDDr4r0O3fvXMqnEr5AncAs5uy7qv8WkKkI1KgRLH8eMLMcmHWQVW2TTmTF1
         Tz9u5pWl6NiJpp+tIbZ6bBivo0Q1Rl9ELQiewArx0WSYoYc2+S6I6RDZDRNsHx08vsXE
         DrbPmRefYf8ZfJVULNQUkGj6otrnrIvYV831ZGCwSnbp5zsXOWQ5KWKVfKCxt5bqKp3F
         DPp+Tc87d4ghXNeGZHZLpuEhlTnWfCpaF5RDJcyIOLQFAoxPR9luXbHfPFkokyyyHzkg
         sjL2Vj8J6cTfEwfHcv6Xpz6m6OP/q33zgZthp0+xiCMbm/mX7IUnJmhVl5zd6bUtR4kA
         LYjA==
X-Gm-Message-State: AOAM5303/YJWwMeVIe1Z0WrGeHXXylH/78M0Fg+03mtG1iPZnJMG7eG0
        IFMl5s+d/T7SBq6M5Vef5L6Svq4nXdy3AA==
X-Google-Smtp-Source: ABdhPJwDr57RI0pnQbxSEKkfhgsZQgICocThMkdZ3qZ9vzwJZJD9fEOHgwu/OgHeD+TLnYdj48g5zg==
X-Received: by 2002:a37:2717:: with SMTP id n23mr513710qkn.149.1632756756523;
        Mon, 27 Sep 2021 08:32:36 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::1159? ([2620:10d:c091:480::1:ba44])
        by smtp.gmail.com with ESMTPSA id h17sm457566qtp.13.2021.09.27.08.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 08:32:35 -0700 (PDT)
Subject: Re: [PATCH v2 3/7] btrfs: do not read super look for a device path
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        David Sterba <dsterba@suse.com>
References: <cover.1627419595.git.josef@toxicpanda.com>
 <26639cd9f337a84b432b6627cd7c17b3d6d51e34.1627419595.git.josef@toxicpanda.com>
 <41d2c028-6af5-ab2b-91fa-1090d4258ba9@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ffe45a8d-7ff9-ddda-2c5a-b0e1aae1441a@toxicpanda.com>
Date:   Mon, 27 Sep 2021 11:32:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <41d2c028-6af5-ab2b-91fa-1090d4258ba9@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/24/21 10:00 PM, Anand Jain wrote:
> On 28/07/2021 05:01, Josef Bacik wrote:
>> For device removal and replace we call btrfs_find_device_by_devspec,
>> which if we give it a device path and nothing else will call
>> btrfs_find_device_by_path, which opens the block device and reads the
>> super block and then looks up our device based on that.
>>
>> However this is completely unnecessary because we have the path stored
>> in our device on our fsdevices.  All we need to do if we're given a path
>> is look through the fs_devices on our file system and use that device if
>> we find it, reading the super block is just silly.
> 
> The device path as stored in our fs_devices can differ from the path
> provided by the user for the same device (for example, dm, lvm).
> 
> btrfs-progs sanitize the device path but, others (for example, an ioctl
> test case) might not. And the path lookup would fail.
> 
> Also, btrfs dev scan <path> can update the device path anytime, even
> after it is mounted. Fixing that failed the subsequent subvolume mounts
> (if I remember correctly).
> 

This is a good point, that's kind of a big deal from a UX perspective.

>> This fixes the case where we end up with our sb write "lock" getting the
>> dependency of the block device ->open_mutex, which resulted in the
>> following lockdep splat
> 
> Can we do..
> 
> btrfs_exclop_start()
>   ::
> find device part (read sb)
>   ::
> mnt_want_write_file()?
> 
> 

I looked into this, but we'd have to re-order the exclop_start to above the 
mnt_want_write_file() part everywhere to be consistent, and this is mostly OK 
except for balance.  Balance the exclop is tied to the lifetime of the balance 
ctl, which can exist past the task running balance because we could pause the 
balance.

Could we get around this?  Sure, but in my head exclop == lock.  This means we 
have something akin to

exclop_start
mnt_want_write_file()

pause balance
mnt_drop_write()

resume balance

exclop_start magic stuff in balance to resume without doing the exclop
mnt_want_write_file()
<do balance>
exclop_finish
mnt_drop_write()

If we're OK with this then we can definitely do that.

The other option is simply to make userspace do the superblock read and use the 
devid thing for us.  Then we just eat the UX problem for older tools where you 
want to do btrfs rm device /dev/mapper/whatever and we have the pathname as 
/dev/dm-#.

Both options are unattractive in their own way.  I think the first option is 
only annoying to us, and maintains the UX expectations.  But I want more than me 
to make this decision, so if you and Dave are OK with that I'll go with 
re-ordering exclop+mnt_want_write_file(), and then put the device lookup between 
the two of them for device removal.  Thanks,

Josef

