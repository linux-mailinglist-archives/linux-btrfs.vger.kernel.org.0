Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B763192010
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 05:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgCYEJW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 00:09:22 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33591 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgCYEJW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 00:09:22 -0400
Received: by mail-lj1-f195.google.com with SMTP id f20so1039817ljm.0
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Mar 2020 21:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5h/VsQsK1gqRDD/fB/HQhvUdeR1t1EwaW1QQrw6tKoc=;
        b=jGJOJ8YVxuBMtH/quNzlHjVleuM3bluvk//gbakBiAkKyvvcepUZLxx20wl2rfsGPJ
         ag/5awTtIjyFhKBC/IpZIlObEI7uDarNCLxgr14hJ+UdcjKHNj/PPj0OSKCbG5cImviA
         MOMo4rt8jGoJKoxw/Dm5V0NTsesmeC7onMW1vbLuqD+O/EJci2BQGkGe422U5PZwCbsl
         47JcIAMqh9LOUDJTtJvJ07676IdnE4JI6oomJYJBbnKEOFU0yCJLPQjPIiajJiAcwPpJ
         JDYJ1HD6s9trqtAyQG4tYcEGj+evHRcEjKTsG7hjsNXUmBujDXXfwx/M5iFyX1AmyvMR
         OnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5h/VsQsK1gqRDD/fB/HQhvUdeR1t1EwaW1QQrw6tKoc=;
        b=WU+JMfLboly0rQhDluxM8sd3YJ0kSKlwsWCzE1mAcSMo4JXUZnRfyZMxpzxXwPsdDO
         lXtHWKF+1rI6zW4PTd2P2cxpGSv3rRvEu3zscth1aGNO83DPNM/sbJFrhFJ/XUGi8b1n
         Q+OsUsEXz/m6X3iqeYuXj6Vt+8R2uxM5BD3DDmpBURY5Rh4ZKH1RJ8FjRKe1hf060HmK
         ythcp+MdlZfb9yFCxzKqwrPy0u0dfiK7MQBmd42P7uCJCR7gPxO2A3uLjyWSl9KePjq6
         o2Btiwi08HoGx5DkF4F/wlRoPAcG8nsmfYUaaNix3S95wGyMQSAsblB0vGOOhySW10z2
         cGHA==
X-Gm-Message-State: ANhLgQ1vQMFZDdWT+HYJg68+aFvXoCfGEHGbcduXnLyo+oHV3I4RI5i8
        CGZ4dI4i/4rmi69zhTNJ5YU=
X-Google-Smtp-Source: ADFU+vvWyAuezQPgBZQy32xw0c1e3bL6CsNhluo1LFCc7NLqnZKHJ1DKllXaAnV5LnGKdcaDiEOupw==
X-Received: by 2002:a2e:b6c2:: with SMTP id m2mr649362ljo.72.1585109357609;
        Tue, 24 Mar 2020 21:09:17 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:ea69:5e88:dcf1:68f5:44ed? ([2a00:1370:812d:ea69:5e88:dcf1:68f5:44ed])
        by smtp.gmail.com with ESMTPSA id d26sm13028167lfm.0.2020.03.24.21.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 21:09:16 -0700 (PDT)
Subject: Re: Question: how understand the raid profile of a btrfs filesystem
To:     kreijack@inwind.it, Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <517dac49-5f57-2754-2134-92d716e50064@alice.it>
 <2c7f2844-b97d-0e15-6ae6-40c9c935aa77@oracle.com>
 <8977ac3d-7af6-65a7-5515-caab07983672@inwind.it>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBDxiRwwRBAC3CN9wdwpVEqUGmSoqF8tWVIT4P/bLCSZLkinSZ2drsblKpdG7x+guxwts
 +LgI8qjf/q5Lah1TwOqzDvjHYJ1wbBauxZ03nDzSLUhD4Ms1IsqlIwyTLumQs4vcQdvLxjFs
 G70aDglgUSBogtaIEsiYZXl4X0j3L9fVstuz4/wXtwCg1cN/yv/eBC0tkcM1nsJXQrC5Ay8D
 /1aA5qPticLBpmEBxqkf0EMHuzyrFlqVw1tUjZ+Ep2LMlem8malPvfdZKEZ71W1a/XbRn8FE
 SOp0tUa5GwdoDXgEp1CJUn+WLurR0KPDf01E4j/PHHAoABgrqcOTcIVoNpv2gNiBySVsNGzF
 XTeY/Yd6vQclkqjBYONGN3r9R8bWA/0Y1j4XK61qjowRk3Iy8sBggM3PmmNRUJYgroerpcAr
 2byz6wTsb3U7OzUZ1Llgisk5Qum0RN77m3I37FXlIhCmSEY7KZVzGNW3blugLHcfw/HuCB7R
 1w5qiLWKK6eCQHL+BZwiU8hX3dtTq9d7WhRW5nsVPEaPqudQfMSi/Ux1kc0mQW5kcmVpIEJv
 cnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT7CZQQTEQIAJQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AFAliWAiQCGQEACgkQR6LMutpd94wFGwCeNuQnMDxve/Fo3EvYIkAOn+zE
 21cAnRCQTXd1hTgcRHfpArEd/Rcb5+SczsBNBDxiRyQQBACQtME33UHfFOCApLki4kLFrIw1
 5A5asua10jm5It+hxzI9jDR9/bNEKDTKSciHnM7aRUggLwTt+6CXkMy8an+tVqGL/MvDc4/R
 KKlZxj39xP7wVXdt8y1ciY4ZqqZf3tmmSN9DlLcZJIOT82DaJZuvr7UJ7rLzBFbAUh4yRKaN
 nwADBwQAjNvMr/KBcGsV/UvxZSm/mdpvUPtcw9qmbxCrqFQoB6TmoZ7F6wp/rL3TkQ5UElPR
 gsG12+Dk9GgRhnnxTHCFgN1qTiZNX4YIFpNrd0au3W/Xko79L0c4/49ten5OrFI/psx53fhY
 vLYfkJnc62h8hiNeM6kqYa/x0BEddu92ZG7CRgQYEQIABgUCPGJHJAAKCRBHosy62l33jMhd
 AJ48P7WDvKLQQ5MKnn2D/TI337uA/gCgn5mnvm4SBctbhaSBgckRmgSxfwQ=
Message-ID: <8a53cf8d-980d-8c41-e35d-c8b70db1bbdc@gmail.com>
Date:   Wed, 25 Mar 2020 07:09:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8977ac3d-7af6-65a7-5515-caab07983672@inwind.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

24.03.2020 20:59, Goffredo Baroncelli пишет:
> On 3/24/20 5:55 AM, Anand Jain wrote:
>> On 3/21/20 1:56 AM, Goffredo Baroncelli wrote:
>>> Hi all,
> [..]
>>> Looking at the code it seems to me that the logic is the following
>>> (from btrfs_reduce_alloc_profile())
>>>
>>>          if (allowed & BTRFS_BLOCK_GROUP_RAID6)
>>>                  allowed = BTRFS_BLOCK_GROUP_RAID6;
>>>          else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
>>>                  allowed = BTRFS_BLOCK_GROUP_RAID5;
>>>          else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
>>>                  allowed = BTRFS_BLOCK_GROUP_RAID10;
>>>          else if (allowed & BTRFS_BLOCK_GROUP_RAID1)
>>>                  allowed = BTRFS_BLOCK_GROUP_RAID1;
>>>          else if (allowed & BTRFS_BLOCK_GROUP_RAID0)
>>>                  allowed = BTRFS_BLOCK_GROUP_RAID0;
>>>
>>>          flags &= ~BTRFS_BLOCK_GROUP_PROFILE_MASK;
>>>
>>> So in the case above the profile will be RAID6. And in the general if
>>> a RAID6 chunk is a filesystem, it wins !
>>
>>   That's arbitrary and doesn't make sense to me, IMO mkfs should save
>>   default profile in the super-block (which can be changed using ioctl)
>>   and kernel can create chunks based on the default profile. 
> 
> I'm working on this idea (storing the target profile in super-block).

What about per-subvolume profile? This comes up every now and then, like

https://lore.kernel.org/linux-btrfs/cd82d247-5c95-18cd-a290-a911ff69613c@dirtcellar.net/

May be it could be subvolume property?

> Of
> course this increase the consistency, but
> doesn't prevent the possibility that a mixed profiles filesystem could
> happen. And in this case is the user that
> has to solve the issue.
> 
> Zygo, suggested also to add a mixed profile warning to btrfs (prog). And
> I agree with him. I think that we can use
> the space info ioctl (which doesn't require root privileges).
> 
> BR
> G.Baroncelli
> 
>> This
>>   approach also fixes chunk size inconsistency between progs and kernel
>>   as reported/fixed here
>>     https://patchwork.kernel.org/patch/11431405/
>>
>> Thanks, Anand
>>
>>> But I am not sure.. Moreover I expected to see also reference to DUP
>>> and/or RAID1C[34] ...
>>>
>>> Does someone have any suggestion ?
>>>
>>> BR
>>> G.Baroncelli
>>>
>>
> 
> 

