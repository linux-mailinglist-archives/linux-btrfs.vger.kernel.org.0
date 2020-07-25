Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE6522D5CC
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jul 2020 09:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgGYHav (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jul 2020 03:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgGYHav (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jul 2020 03:30:51 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C747AC0619D3
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Jul 2020 00:30:50 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id h8so6374180lfp.9
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Jul 2020 00:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z7UJUFN6LjOG/7dEzTccUvcaJdQhVQJY2rtA8HYN0A4=;
        b=Ouybu2hVlVchLgPlBGtdd6lGS0eZXL9ojgutDORWFK55/KbohxbeHoN8sZJT7uJPei
         wzFSzhvfJW494PErzIqMCKsRGEccPy9YozI/x2WplUxBzdlMJgZhciolEkyRit114vhU
         s8GAvh1ssnvoW5ml9uBgB7LMgCt+mcuhTxcDW4ffmxtDBqxUTRtto8AjHZsRygsZTTE2
         yXHnlDbF4s/+L4RWTH7tU33Pwu11ury4OkTWPwgMgDUGVJGopJS3x/QqxG4m6zxq9nJl
         AIrc4+/mfcXAy4Q0toGIiW+IZKqyxmsl27altOVljrIp2+pRESvgvfSNobxPmD2ey62y
         bhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Z7UJUFN6LjOG/7dEzTccUvcaJdQhVQJY2rtA8HYN0A4=;
        b=l50Q1wE1N9aytUKFJ34yQpMX248zngTQvxgrbl1ZBl1Is+CEEGVy9wRmSfURq2cKmR
         FsCOasLh7IekNfzA/2idbQFxUKV47EB31R69AU+6H9W/tXt5LHzHQz2X6yETMz5aU1CK
         u9azV0KO5CYrMj9bmQEon9WQBDq/DMo0tCadUQUcMOK3vg57hQl+Tc8KOO5esLk4lG1Y
         wrrtMbTlqD2sAUytTs3V7g9ZiozkLWCbIOevo/6XrF/QCpwWN0oE5CiQUkuaXEvO8jxp
         FlglfDvznNzk5vm3cajBNMONqU7KlqUD+MNhTA8QFv2tTBsGeCHyytCcZlTadsMP+RHD
         Wfww==
X-Gm-Message-State: AOAM532B3jft+d/XMDDZ7MEoRCWnW4eLGDrfytluA5P52Y9NGnZueUOR
        Qi9/mC8HiKFiW7LtPWCzM6C6iSqs
X-Google-Smtp-Source: ABdhPJylYJ9xpdv6SmGjRs3Bb+Y1e44Zy+rsmwNlmvCRjOYIxa5uGZJiDAw1YXXcRpUYIS8MBJ305Q==
X-Received: by 2002:ac2:4adb:: with SMTP id m27mr7001137lfp.90.1595662248817;
        Sat, 25 Jul 2020 00:30:48 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:c763:71ff:8633:9e4a:bf5b? ([2a00:1370:812d:c763:71ff:8633:9e4a:bf5b])
        by smtp.gmail.com with ESMTPSA id s1sm809698ljj.96.2020.07.25.00.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2020 00:30:47 -0700 (PDT)
Subject: Re: df free space not correct with raid1 pools with an odd number of
 devices
To:     Chris Murphy <lists@colorremedies.com>,
        Jorge Bastos <jorge.mrbastos@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAHzMYBTU=JuEsRX7YXzMJMELy63TXrm3J6onKnhGSOOzTnnMBg@mail.gmail.com>
 <CAJCQCtS6eS7a+wHR__A_aDujANWNJEmUMApjChVMk1WNuZ0BKg@mail.gmail.com>
 <CAHzMYBT8a9D817i2TRqdRiJFdmF-c3WVyo6HNgbv8bJqqOyr5g@mail.gmail.com>
 <CAJCQCtSeAKD_bVk7GUVyLdzdSZqR8O9zEX40kCmyR--DyWtSRw@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
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
Message-ID: <dd11313f-3b9c-c743-257c-71ba1da4dde0@gmail.com>
Date:   Sat, 25 Jul 2020 10:30:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSeAKD_bVk7GUVyLdzdSZqR8O9zEX40kCmyR--DyWtSRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

24.07.2020 23:46, Chris Murphy пишет:
> On Fri, Jul 24, 2020 at 2:16 AM Jorge Bastos <jorge.mrbastos@gmail.com> wrote:
>>
>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>> /dev/sdd1       1.2T  3.4M  931G   1% /mnt/cache
> 
> Oh yeah Avail is clearly goofy.
> 
> 
>> Filesystem      Size  Used Avail Use% Mounted on
>> /dev/sdd1       699G  3.4M  466G   1% /mnt/cache
> 
> 
> Anybody know what's up?
> 
> 

df "Used" and "Avail" are totally independent values.

"Used" is computed as (total - free), both of which are reported by
statfs. By default df does not show "Free", you need to use --output=
option (at least using coreutils df).

"Avail" is computed by filesystem. Originally the difference comes from
"available to root" and "available to user" .

btrfs computes "Avail" by simulating chunk allocations on devices. See
super.c:btrfs_calc_avail_data_space(), the final chunk:

        btrfs_descending_sort_devices(devices_info, nr_devices);

        i = nr_devices - 1;
        avail_space = 0;
        while (nr_devices >= rattr->devs_min) {
                num_stripes = min(num_stripes, nr_devices);

                if (devices_info[i].max_avail >= min_stripe_size) {
                        int j;
                        u64 alloc_size;

                        avail_space += devices_info[i].max_avail *
num_stripes;
                        alloc_size = devices_info[i].max_avail;
                        for (j = i + 1 - num_stripes; j <= i; j++)
                                devices_info[j].max_avail -= alloc_size;
                }
                i--;
                nr_devices--;
        }

        kfree(devices_info);
        *free_bytes = avail_space;

devices_info holds device list sorted by unallocated space. We start
with device with smallest available space and add its full available
space (adjusted by allocation profile), then move to the previous device
with more free space.

The problem is that if we have three equal sized devices and RAID1
profile, the first iteration consumes two full devices, thus third
device cannot be used anymore (we need two of them for raid1). Real
allocator will evaluate free space every time and so alternate between
all three devices.


