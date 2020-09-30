Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338E527E8B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 14:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgI3Mlm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 08:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729928AbgI3Mlm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 08:41:42 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43895C061755
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 05:41:42 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q5so1184120qkc.2
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 05:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WO6c8yV+HpZdMZtopxACPcj7HVvw0GKWmVfTFCfginE=;
        b=A3ll1isl1PiVyQmc1fR9BfqW3YsIOM9qC1ahQuX6q6Z6QwAoDseLgNCvJTgLl0JP8/
         1yymaAqmqz1baBcSIo+Ib2fsW7HKN+WrcNw3GH8rmwBjlp8aEGXTDtzNezagskfmjcz5
         M/lBL7KUfQZxV9CU75dLIbhRWfJ8LGTQI+6d3Jr6F6twFoHxg8twbYbYM7Ts7Jp8iEWh
         xVDj51Lji7Stfs1EJGyalQyP2IaxhSfpdogmzB0jQFvH+4hhZhgRgiBslxBwz2w5nBAv
         g+gmPE+tgIgb+wBpiPVvkKSvcS+rSmtrHg4hDy89w8u1jERzu4AVqxHDg7IlV93un9oA
         69HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WO6c8yV+HpZdMZtopxACPcj7HVvw0GKWmVfTFCfginE=;
        b=mi2fwwDCZeWjkykGnaHw/ZlPtI0UH3GK3iQ1PavjfkbxPi6bVphQjLTKshrbpQg6dH
         F24b2GqDDYuH3q2seSGt6223a5qha34neSb/5QzatipcuMe7cjMcT2OfGHBDTR+CC+Y5
         1ptpd3Twi231eBp6sK8qi6yzgDVz6SSQbeyy5TJFETUs6OYajeL2RWrMYeTHEh8p6HQi
         RF/J1pQJ8drv18Cgf7/I2hGk+fpUN0RByc/wySzizGPcI6eG5bc7TcqNMpwwC1WY/p7m
         W+h0qanQlmjyPQ0iEh/imRREfI7RhOnw5QhdTPfQqiVh9uTqc4wTGrFVMNS5ReKw4126
         L0og==
X-Gm-Message-State: AOAM533WRJ3KWYQrq9Wu9maoakTyU4tTY1xxY6AArmbt0ICU6/+l4j6o
        g+9tlo8XhSXMOs3Nn8Wi+zb9NQ==
X-Google-Smtp-Source: ABdhPJxMgr6K7OjDQ0/FTgQH1mEprary5vAPpuU31N1HOXiEThf/Mm5GSgzoQTfPOoALFhskEG7lNQ==
X-Received: by 2002:a05:620a:140d:: with SMTP id d13mr2412065qkj.330.1601469701246;
        Wed, 30 Sep 2020 05:41:41 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o26sm2237285qtb.24.2020.09.30.05.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 05:41:40 -0700 (PDT)
Subject: Re: [PATCH v2] btrfs: free device without BTRFS_MAGIC
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes.Thumshirn@wdc.com
References: <dbc067b24194241f6d87b8f9799d9b6484984a13.1600473987.git.anand.jain@oracle.com>
 <1ee9b318e3bb851aaec9c1efd1eadb117ad46638.1600741332.git.anand.jain@oracle.com>
 <abf4c158-6b31-be1a-8645-59fc0ca7306a@toxicpanda.com>
 <2d4b10fd-a5f4-7e6b-85f4-f92591e2a539@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <65f23ad0-6c83-27dd-d1d8-2862f6d6fd34@toxicpanda.com>
Date:   Wed, 30 Sep 2020 08:41:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <2d4b10fd-a5f4-7e6b-85f4-f92591e2a539@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/30/20 3:21 AM, Anand Jain wrote:
> 
> 
> On 29/9/20 2:14 am, Josef Bacik wrote:
>> On 9/21/20 11:13 PM, Anand Jain wrote:
>>> Many things can happen after the device is scanned and before the device
>>> is mounted.
>>>
>>> One such thing is losing the BTRFS_MAGIC on the device.
>>>
>>> If it happens we still won't free that device from the memory and causes
>>> the userland to confuse.
>>>
>>> For example: As the BTRFS_IOC_DEV_INFO still carries the device path which
>>> does not have the BTRFS_MAGIC, the btrfs fi show still shows device
>>> which does not belong. As shown below.
>>>
>>> mkfs.btrfs -fq -draid1 -mraid1 /dev/sda /dev/sdb
>>>
>>> wipefs -a /dev/sdb
>>> mount -o degraded /dev/sda /btrfs
>>> btrfs fi show -m
>>>
>>> /dev/sdb does not contain BTRFS_MAGIC and we still show it as part of
>>> btrfs.
>>> Label: none  uuid: 470ec6fb-646b-4464-b3cb-df1b26c527bd
>>>          Total devices 2 FS bytes used 128.00KiB
>>>          devid    1 size 3.00GiB used 571.19MiB path /dev/sda
>>>          devid    2 size 3.00GiB used 571.19MiB path /dev/sdb
>>>
>>
>> Wouldn't this also happen if the bytenrs didn't match?  In that case you 
>> aren't freeing anything, and we'd still show the improper device correct?  So 
>> why not deal with that case in a similar way?  Thanks,
> 
> Freeing the device without the BTRFS_MAGIC is mandatory because the
> device does not belong to btrfs even though we could notice from the
> sysfs that there is missing flag on this devid.
> 
> I think I should check for the BTRFS_MAGIC first before bytenr check,
> I shall swap them in v2 if there are no other comments. We need this
> patch as a fix for the test case btrfs/198.
> 
> However bytenrs mismatch indicates corruption. If the degraded mount
> option is not provided we would fail the mount. The user shall have the
> opportunity to fix the corrupted superblock. We don't automatically
> recover the corrupted superblock from the backup superblock copies. If
> the degraded mount option is provided the corrupted device still be in
> the device_list but with the missing flag set. Just by looking at btrfs
> fi show the user won't know that one of the devices is not part of the
> volume however when he looks into the /sys/fs/btrfs/fsid/devinfo/<devid>
> /missing it shall show 1. Our serviceability part of the degraded volume
> has some unfinished business when we evaluate it against the standard
> RAS features, but we are slowly getting there.
> 

Alright that's fair.  You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
