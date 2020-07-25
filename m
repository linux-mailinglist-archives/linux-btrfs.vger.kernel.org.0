Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6894B22D5DE
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jul 2020 09:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgGYHnv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jul 2020 03:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgGYHnu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jul 2020 03:43:50 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F008C0619D3
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Jul 2020 00:43:50 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 185so1989632ljj.7
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Jul 2020 00:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JRvloOLUA0IXgoLXWUnI/tmYD8FNMJ2Ck/8zZMKdCc4=;
        b=H6h3l1syPUsqixLHgibHthpOHAbYKfH/YkqD3MPgcEzVpdNbJK8msjt76envf060v4
         hTbtnKrNjIoebRcMJqWTy4kpKQ4m4gjGpXpapmPzjj+QH3/tjeflXvS7ZQvTHn7l24Ig
         D9PjvJviLdCEbD+d+a9xRKywqALheDd64PTyq7pnopwF+CJP/I9rHUJglJE8jqMLFZUC
         mt0UjbZQ54QXLrKBQqQ4sKLWhVmlB+MIHVctlO/EFu0XnzcuvjXeXKx4R2VtlCtjO6Ci
         0jmhjr2er/J5zq78hy/CpVqV9+QQJA96RUUWjYEq6AXaOq8w6/j2rZ0qtGWNS40SnrEN
         ko8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JRvloOLUA0IXgoLXWUnI/tmYD8FNMJ2Ck/8zZMKdCc4=;
        b=JRcJwnQzQIEsn7Eask6fEv13X+byuVmESlLCBWvesoZfBtKA37k/agmUrCFDqIWO7I
         nza8PiwB1MNi6V556qWNCr2olX3u2CfEldg12M3+88QhG1z94/VA6AeIkSd4evmMkc3V
         iC21BalqDrCoU+pv1S57XZseA7xW9SD34bK8lR4UxyXGcaan+Ryv0JskFTchluQKuzWh
         TI8fukfQTMVgciq0i3oiJ/q+zvcZhO+Z15gSG53gwmSrQYkUj8hcNI8E7Aoo3gw0kFCG
         4RGuPd2YhoxxCuGcdeegoqBW2YiHgWuDItEryz5PlSt2PuSDqGfBIBA3GE14YGMjfkqw
         +Crg==
X-Gm-Message-State: AOAM531zUlqz5igfvE1s3qIrkw1j4LmiAiE+FJYLTTHc4q48FG4l5u0T
        7wNUSlHShjgD/SeRc+l5xaEgH+PK
X-Google-Smtp-Source: ABdhPJxR8YMQynwOv0hcYNQm6Z4mltt/zJIjy4qABopZPIv8S2las9xAymlAq54ayDv7ZyThkZnI5g==
X-Received: by 2002:a2e:9d4a:: with SMTP id y10mr1321753ljj.104.1595663027148;
        Sat, 25 Jul 2020 00:43:47 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:c763:71ff:8633:9e4a:bf5b? ([2a00:1370:812d:c763:71ff:8633:9e4a:bf5b])
        by smtp.gmail.com with ESMTPSA id n29sm1170646lfi.9.2020.07.25.00.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2020 00:43:46 -0700 (PDT)
Subject: Re: df free space not correct with raid1 pools with an odd number of
 devices
From:   Andrei Borzenkov <arvidjaar@gmail.com>
To:     Chris Murphy <lists@colorremedies.com>,
        Jorge Bastos <jorge.mrbastos@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAHzMYBTU=JuEsRX7YXzMJMELy63TXrm3J6onKnhGSOOzTnnMBg@mail.gmail.com>
 <CAJCQCtS6eS7a+wHR__A_aDujANWNJEmUMApjChVMk1WNuZ0BKg@mail.gmail.com>
 <CAHzMYBT8a9D817i2TRqdRiJFdmF-c3WVyo6HNgbv8bJqqOyr5g@mail.gmail.com>
 <CAJCQCtSeAKD_bVk7GUVyLdzdSZqR8O9zEX40kCmyR--DyWtSRw@mail.gmail.com>
 <dd11313f-3b9c-c743-257c-71ba1da4dde0@gmail.com>
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUUdpQkR4aVJ3d1JCQUMz
 Q045d2R3cFZFcVVHbVNvcUY4dFdWSVQ0UC9iTENTWkxraW5TWjJkcnNibEtwZEc3CngrZ3V4
 d3RzK0xnSThxamYvcTVMYWgxVHdPcXpEdmpIWUoxd2JCYXV4WjAzbkR6U0xVaEQ0TXMxSXNx
 bEl3eVQKTHVtUXM0dmNRZHZMeGpGc0c3MGFEZ2xnVVNCb2d0YUlFc2lZWlhsNFgwajNMOWZW
 c3R1ejQvd1h0d0NnMWNOLwp5di9lQkMwdGtjTTFuc0pYUXJDNUF5OEQvMWFBNXFQdGljTEJw
 bUVCeHFrZjBFTUh1enlyRmxxVncxdFVqWitFCnAyTE1sZW04bWFsUHZmZFpLRVo3MVcxYS9Y
 YlJuOEZFU09wMHRVYTVHd2RvRFhnRXAxQ0pVbitXTHVyUjBLUEQKZjAxRTRqL1BISEFvQUJn
 cnFjT1RjSVZvTnB2MmdOaUJ5U1ZzTkd6RlhUZVkvWWQ2dlFjbGtxakJZT05HTjNyOQpSOGJX
 QS8wWTFqNFhLNjFxam93UmszSXk4c0JnZ00zUG1tTlJVSllncm9lcnBjQXIyYnl6NndUc2Iz
 VTdPelVaCjFMbGdpc2s1UXVtMFJONzdtM0kzN0ZYbEloQ21TRVk3S1pWekdOVzNibHVnTEhj
 ZncvSHVDQjdSMXc1cWlMV0sKSzZlQ1FITCtCWndpVThoWDNkdFRxOWQ3V2hSVzVuc1ZQRWFQ
 cXVkUWZNU2kvVXgxa2JRbVFXNWtjbVY1SUVKdgpjbnBsYm10dmRpQThZWEoyYVdScVlXRnlR
 R2R0WVdsc0xtTnZiVDZJWUFRVEVRSUFJQVVDU1hzNk5RSWJBd1lMCkNRZ0hBd0lFRlFJSUF3
 UVdBZ01CQWg0QkFoZUFBQW9KRUVlaXpMcmFYZmVNTE9ZQW5qNG92cGthK21YTnpJbWUKWUNk
 NUxxVzV0bzhGQUo0dlA0SVcrSWM3ZVlYeENMTTcvem05WU1VVmJyUW5RVzVrY21WNUlFSnZj
 bnBsYm10dgpkaUE4WVhKMmFXUnFZV0Z5UUc1bGQyMWhhV3d1Y25VK2lGNEVFeEVDQUI0RkFr
 SXR5WkFDR3dNR0N3a0lCd01DCkF4VUNBd01XQWdFQ0hnRUNGNEFBQ2drUVI2TE11dHBkOTR4
 ajhnQ2VJbThlK2U0cXhETWpRRXhGYlVMNXdNaWkKWUQwQW9LbUlCUzVIRW9wL1R5UUpkTmc2
 U3Z6VmlQRGR0Q1JCYm1SeVpYa2dRbTl5ZW1WdWEyOTJJRHhoY25acApaR3BoWVhKQWJXRnBi
 QzV5ZFQ2SVhBUVRFUUlBSEFVQ1Bxems4QUliQXdRTEJ3TUNBeFVDQXdNV0FnRUNIZ0VDCkY0
 QUFDZ2tRUjZMTXV0cGQ5NHlEdFFDZ2k5NHJoQXdTMXFqK2ZhampiRE02QmlTN0Irc0FvSi9S
 RG1hN0tyQTEKbkllc2JuS29MY1FMYkpZbHRDUkJibVJ5WldvZ1FtOXljMlZ1YTI5M0lEeGhj
 blpwWkdwaFlYSkFiV0ZwYkM1eQpkVDZJVndRVEVRSUFGd1VDUEdKSERRVUxCd29EQkFNVkF3
 SURGZ0lCQWhlQUFBb0pFRWVpekxyYVhmZU1pcFlBCm9MblllRUJmOGNvV2lud3hUZThEVjBS
 T2J4N1NBS0RFamwzdFFxZEY3MGFQd0lPMmgvM0ZqczJjZnJRbVFXNWsKY21WcElFSnZjbnBs
 Ym10dmRpQThZWEoyYVdScVlXRnlRR2R0WVdsc0xtTnZiVDZJWlFRVEVRSUFKUUliQXdZTApD
 UWdIQXdJR0ZRZ0NDUW9MQkJZQ0F3RUNIZ0VDRjRBRkFsaVdBaVFDR1FFQUNna1FSNkxNdXRw
 ZDk0d0ZHd0NlCk51UW5NRHh2ZS9GbzNFdllJa0FPbit6RTIxY0FuUkNRVFhkMWhUZ2NSSGZw
 QXJFZC9SY2I1K1NjdVFFTkJEeGkKUnlRUUJBQ1F0TUUzM1VIZkZPQ0FwTGtpNGtMRnJJdzE1
 QTVhc3VhMTBqbTVJdCtoeHpJOWpEUjkvYk5FS0RUSwpTY2lIbk03YVJVZ2dMd1R0KzZDWGtN
 eThhbit0VnFHTC9NdkRjNC9SS0tsWnhqMzl4UDd3VlhkdDh5MWNpWTRaCnFxWmYzdG1tU045
 RGxMY1pKSU9UODJEYUpadXZyN1VKN3JMekJGYkFVaDR5UkthTm53QURCd1FBak52TXIvS0IK
 Y0dzVi9VdnhaU20vbWRwdlVQdGN3OXFtYnhDcnFGUW9CNlRtb1o3RjZ3cC9yTDNUa1E1VUVs
 UFJnc0cxMitEawo5R2dSaG5ueFRIQ0ZnTjFxVGlaTlg0WUlGcE5yZDBhdTNXL1hrbzc5TDBj
 NC80OXRlbjVPckZJL3BzeDUzZmhZCnZMWWZrSm5jNjJoOGhpTmVNNmtxWWEveDBCRWRkdTky
 Wkc2SVJnUVlFUUlBQmdVQ1BHSkhKQUFLQ1JCSG9zeTYKMmwzM2pNaGRBSjQ4UDdXRHZLTFFR
 NU1Lbm4yRC9USTMzN3VBL2dDZ241bW52bTRTQmN0YmhhU0JnY2tSbWdTeApmd1E9Cj1nWDEr
 Ci0tLS0tRU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0K
Message-ID: <446adc05-b03b-488a-c8a3-6c31cabdb3d0@gmail.com>
Date:   Sat, 25 Jul 2020 10:43:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dd11313f-3b9c-c743-257c-71ba1da4dde0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

25.07.2020 10:30, Andrei Borzenkov пишет:
> 24.07.2020 23:46, Chris Murphy пишет:
>> On Fri, Jul 24, 2020 at 2:16 AM Jorge Bastos <jorge.mrbastos@gmail.com> wrote:
>>>
>>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>>> /dev/sdd1       1.2T  3.4M  931G   1% /mnt/cache
>>
>> Oh yeah Avail is clearly goofy.
>>
>>
>>> Filesystem      Size  Used Avail Use% Mounted on
>>> /dev/sdd1       699G  3.4M  466G   1% /mnt/cache
>>
>>
>> Anybody know what's up?
>>
>>
> 
> df "Used" and "Avail" are totally independent values.
> 
> "Used" is computed as (total - free), both of which are reported by
> statfs. By default df does not show "Free", you need to use --output=
> option (at least using coreutils df).
> 
> "Avail" is computed by filesystem. Originally the difference comes from
> "available to root" and "available to user" .
> 
> btrfs computes "Avail" by simulating chunk allocations on devices. See
> super.c:btrfs_calc_avail_data_space(), the final chunk:
> 
>         btrfs_descending_sort_devices(devices_info, nr_devices);
> 
>         i = nr_devices - 1;
>         avail_space = 0;
>         while (nr_devices >= rattr->devs_min) {
>                 num_stripes = min(num_stripes, nr_devices);
> 
>                 if (devices_info[i].max_avail >= min_stripe_size) {
>                         int j;
>                         u64 alloc_size;
> 
>                         avail_space += devices_info[i].max_avail *
> num_stripes;
>                         alloc_size = devices_info[i].max_avail;
>                         for (j = i + 1 - num_stripes; j <= i; j++)
>                                 devices_info[j].max_avail -= alloc_size;
>                 }
>                 i--;
>                 nr_devices--;
>         }
> 
>         kfree(devices_info);
>         *free_bytes = avail_space;
> 
> devices_info holds device list sorted by unallocated space. We start
> with device with smallest available space and add its full available
> space (adjusted by allocation profile), then move to the previous device
> with more free space.
> 
> The problem is that if we have three equal sized devices and RAID1
> profile, the first iteration consumes two full devices, thus third
> device cannot be used anymore (we need two of them for raid1). Real
> allocator will evaluate free space every time and so alternate between
> all three devices.
> 
> 

OTOH, this is the correct if the most pessimistic estimation either. If
you have three 250G RAID1 devices and you allocate 250G data in one file
you consume two full devices and won't be able to allocate new data at
all (or for that matter no new metadata either).


So whatever value btrfs returns will be wrong for some allocation pattern.
