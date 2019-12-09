Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF51116EA5
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 15:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfLIOJS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 09:09:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35073 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfLIOJS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Dec 2019 09:09:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id b19so7312433pfo.2
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2019 06:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WGPnFf99ZS+88CDOu5HCGPnB4oOduQWhVJh53kLv+Ag=;
        b=A5H1T4Vrptxb+Hu7vRslvHEXuHzby64Q2tsCiTgtdejdZaSw3nCHSJdPQjxCl2W26p
         MiEVWBYxfkusI2TM8I/w5F7vG/k+vkcCftITHaV9gdKv7sVhCjbusxtqh4muTmw1VfEt
         DFAZO8VCRhPLXZiElWQr05ugFxLbYqem3GgvZhl1Ko4QOHJfRBXFwMynpb0XAIjTpNje
         eMu48hZG0+JQnGIyfkb+999iIFzcgfN4jG5JtfvQuEHA4ztrSr38HpKkRANLHrVhszaL
         ajTfVr1Aks18D+ErmQKI8kMW0oeVdVuLeM9EyH3zrDD5tRuOTfa/bIO61stkcwQRSbio
         FxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WGPnFf99ZS+88CDOu5HCGPnB4oOduQWhVJh53kLv+Ag=;
        b=pDhGlokl6tN+EuoMw4RiD0S9fPxoikI4bRmajp0fMARX6HH8D+bou/XJp1muei57ZQ
         m3M2xchkVtAsTX5FT2KDJZpDxW4WL7FEuhgWe9naT+/ql6Ud/xLDeY5wAFKqg1x22ykz
         ZtLIso8qhkUEagwaGSlwZbru/0Sf8WPDiT8Q+I39BedRr/zjejCAGJ00XEq85+TGciUP
         bDOEwJmuGuYLBJmWvA87Z1WFuNDFh0dPhHYV6tyuBOjoirDxK3K0cO76tW0QbK4r8nSi
         gjatiE/yQpZkFTDjrtl4UChW2H6haBjnX6OAmNR1gUfwwSs3h3OypdfnP0/qYrcgD3qT
         wdCA==
X-Gm-Message-State: APjAAAVgD4o8fyBHeUgnEdHCsFqZWuMLIPHk+2287kNOjVppF3WhGwsy
        pp3JNc6e2SftWGeKJvdGIcdyqks7
X-Google-Smtp-Source: APXvYqyx1Vyg1XRch1/6RiVsW85MgHzlmDdyRl1azk4xcXBDGZHoK/eZCAGnGC5AGRsVgU5OOUsqeQ==
X-Received: by 2002:a63:7705:: with SMTP id s5mr18536893pgc.379.1575900557215;
        Mon, 09 Dec 2019 06:09:17 -0800 (PST)
Received: from [192.168.1.145] ([39.109.145.141])
        by smtp.gmail.com with ESMTPSA id r4sm12461314pji.11.2019.12.09.06.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 06:09:16 -0800 (PST)
From:   Anand Jain <anandsuveer@gmail.com>
X-Google-Original-From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH 0/4] btrfs, sysfs cleanup and add dev_state
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20191205112706.8125-1-anand.jain@oracle.com>
 <20191205150022.GR2734@twin.jikos.cz>
 <67aa265f-9eb7-b819-ec07-b1c40600e2cb@oracle.com>
Message-ID: <60e697e7-a882-b237-b99c-db640e1cc7cf@oracle.com>
Date:   Mon, 9 Dec 2019 22:09:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <67aa265f-9eb7-b819-ec07-b1c40600e2cb@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/6/19 9:46 PM, Anand Jain wrote:
> 
> 
> On 5/12/19 11:00 PM, David Sterba wrote:
>> On Thu, Dec 05, 2019 at 07:27:02PM +0800, Anand Jain wrote:
>>> Anand Jain (4):
>>>    btrfs: sysfs, use btrfs_sysfs_remove_fsid in fail return in add_fsid
>>>    btrfs: sysfs, add UUID/devinfo kobject
>>>    btrfs: sysfs, rename device_link add,remove functions
>>>    btrfs: sysfs, add devid/dev_state kobject and attribute
>>
>> So we can start adding things to devinfo, I did a quick test how the
>> sysfs directory looks like, the base structure seems ok.
>>
>> Unlike other sources for sysfs file data (like superblock), the devices
>> can appear and disappear during the lifetime of the filesystem and as
>> pointed out in the patches, some synchronization is needed.
>>
>> But it could be more tricky. Reading from the sysfs files should not
>> block normal operation (no device_list_mutex) but also must not lead to
>> use-after-free in case the device gets deleted.
>>
>> I haven't found a simple locking scheme that would avoid accessing a
>> freed device structure, the sysfs callback can happen at any time and
>> the structure can be freed already.
>>
>> So this means that btrfs_sysfs_dev_state_show cannot access it directly
>> (using offsetof(kobj, ...)). The safe (but not necessarily the best) way
>> I have so far is to track the device kobjects in the superblock and add
>> own lock for accessing this structure.
>>
>> This avoids increasing contention of device_list_mutex, each sysfs
>> callback needs to take the lock first, lookup the device and print the
>> value if it's found. Otherwise we know the device is gone.
> 
> 
> 
>> The lock is rwlock_t, sysfs callbacks take read-side, device deletion
>> takes write possibly outside of the device_list_mutex before the device
>> is actually going to be deleted. This relies on fairness of the lock so
>> the write will happen eventually (even if there are many readers).
>>
> 
>   Yeah this makes sense to me. I completely forgot about the %device
>   getting deleted while sysfs is reading. Let me fix in the patch 4/4.
> 

  Ah. No we don't need the lock. Sysfs kobject delete/put called by the
  delete thread waits for the sysfs read open to close. And after this
  operation we are freeing the %device. So its synchronized there is no
  race.

Thanks, Anand

