Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52A224EF2B
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Aug 2020 20:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgHWSQq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Aug 2020 14:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgHWSQp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Aug 2020 14:16:45 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A15C061573
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Aug 2020 11:16:44 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y2so7160559ljc.1
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Aug 2020 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IZwULBRvVu9WffuE2Knk53RlVS9sRNbu4RLALHaPqNs=;
        b=V2fr3gMSWJ749JdjIughlmz5p0IBiPxmdognJCgXBfawJD1vNxx23hlRFV90qoVv7W
         1NLPK1+tQBrXyr7YrF2nJgxejrMN0K5fF3IdBOGNptCXJLadyW7rmW8nrRaw/+vfCvfl
         d5BHD/Rwno/XzZkyDrcJ7vnVVNKxaY12fTzSeZ/VW4uT/t5DU/Im/YEANZUkwa0pmWY/
         4tZv9rCuUIuWhxhzIWBurDLFMeHDutArE6+43zK5agj4hUp9cVGZL0ecTzZIuZEJgT9J
         7gcTps2OWIlkgpfCua/Yp7+NkAdmZrppXSqI0wLMCsG/Vs5OEiFdCYQGiIIgLVZlpudD
         k8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IZwULBRvVu9WffuE2Knk53RlVS9sRNbu4RLALHaPqNs=;
        b=audaqECdLUhUfkXgTW3PVuydq/MS3YgfkjEVQZyUX+3Kr5+h6B4bEtgbbGt/wfyJZG
         hOhzdxY/aWs//4M9J8t4aXT54z3fgQ/T15l5yQHegS6IM8s345IGFg7eZN8bvaWVDOrs
         VgVKaNKR98rP6i9ajG2c9S5a7wXENdk0N1qWUt3mjF3p1AOgwOPhZAnjlj5o7ysRaNKC
         nhkBD5QjfwD31m+eaeUV5EwSKu3Z2CMEgkB+uvE+iv1aN1k5QRLSf874mYanx2/MjVtT
         ha7bc5FsZV9Xmtx9J074n1O6fGztrhMke0hKvs4PuG39X708p1DSYR5v51TKWhNnLmwa
         wtjQ==
X-Gm-Message-State: AOAM533eDNjD7ZjBoYQ5HOhpDtcrJJ/fAm1dZrOSjqRf7i/me7hpzpMH
        Tw2NuBDBlOW5aRlUZJ1h/g69dXtgG2E=
X-Google-Smtp-Source: ABdhPJwqwRBI5MPksz6cBXN9ye+5sgB2RVeIMKFMGo0+VbIH3B8Iq2yML7ga1UOICmk7DBR6lJcVmg==
X-Received: by 2002:a2e:71a:: with SMTP id 26mr1072832ljh.198.1598206598732;
        Sun, 23 Aug 2020 11:16:38 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:93a3:28ae:5b31:d89a:107? ([2a00:1370:812d:93a3:28ae:5b31:d89a:107])
        by smtp.gmail.com with ESMTPSA id d13sm1732721lfl.89.2020.08.23.11.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2020 11:16:38 -0700 (PDT)
Subject: Re: [Help] Can't login to my systemd-homed user account due to
 fallocate failure
To:     Andrii Zymohliad <azymohliad@protonmail.com>,
        Hugo Mills <hugo@carfax.org.uk>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com>
 <20200823153746.GB1093@savella.carfax.org.uk>
 <251eb1e3-0fcd-eb22-72b9-8ab2f2a5e962@gmail.com>
 <uE-fvxC5rW1snQPXRetWASSP8a8cJVSTiDa1WNLmtVANT-M_cd6NUZxUlUtLBID2-EBEEJjP0yK7-Knt9-vjWob1dU6H9FE2Dhg0Y1XFOx4=@protonmail.com>
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
Message-ID: <db0c267c-5b8f-067b-673c-8f59002ee48e@gmail.com>
Date:   Sun, 23 Aug 2020 21:16:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <uE-fvxC5rW1snQPXRetWASSP8a8cJVSTiDa1WNLmtVANT-M_cd6NUZxUlUtLBID2-EBEEJjP0yK7-Knt9-vjWob1dU6H9FE2Dhg0Y1XFOx4=@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

23.08.2020 19:55, Andrii Zymohliad пишет:
> On Sunday, August 23, 2020 7:21 PM, Andrei Borzenkov <arvidjaar@gmail.com> wrote:
>> It's not about LUKS container. systemd tool attempts to reserve full
>> size of image with LUKS inside using fallocate which fails. It never
>> gets as far as actually unlocking it or mounting filesystem inside.
> 
> Yes, thanks Andrei for additional clarification. Here I unlocked and mounted home partition manually just to show what's the state of filesystem on it (I guess that's not important here). Usually, it should be unlocked and mounted by systemd, but it fails because of fallocate failure.
> 
> 
> On Sunday, August 23, 2020 6:37 PM, Hugo Mills <hugo@carfax.org.uk> wrote:
>> The / filesystem is a clear case of needing a data balance. See
>> this link for what to do:
>>
>> https://btrfs.wiki.kernel.org/index.php/FAQ#if_your_device_is_large_.28.3E16GiB.29
>>
>> and see also this link for how to read the data you've pasted here:
>>
>> https://btrfs.wiki.kernel.org/index.php/FAQ#or_My_filesystem_is_full.2C_and_I.27ve_put_almost_nothing_into_it.21
> 
> 
> Thanks for a very quick response and links, Hugo, those are definitely useful for me. But the issue here seems more complicated. I forgot to write about it, but the state of root filesystem differs before and after fallocate attempt (or trying to log in as systemd-homed user).
> 
> Before:
> 
>     # btrfs fi show
> 
>     Label: none  uuid: b68411ce-702a-4259-9121-ac21c9119ddf
>     	Total devices 1 FS bytes used 299.71GiB
>     	devid    1 size 476.44GiB used 301.03GiB path /dev/nvme0n1p2
> 
>     # btrfs fi df /
> 
>     Data, single: total=300.00GiB, used=299.29GiB
>     System, single: total=32.00MiB, used=48.00KiB
>     Metadata, single: total=1.00GiB, used=438.38MiB
>     GlobalReserve, single: total=62.16MiB, used=0.00B
> 
> After:
> 
>     # btrfs fi show
> 
>     Label: none  uuid: b68411ce-702a-4259-9121-ac21c9119ddf
>     	Total devices 1 FS bytes used 299.71GiB
>     	devid    1 size 476.44GiB used 476.44GiB path /dev/nvme0n1p2
> 
>     btrfs fi df /
> 
>     Data, single: total=475.41GiB, used=299.29GiB
>     System, single: total=32.00MiB, used=80.00KiB
>     Metadata, single: total=1.00GiB, used=438.39MiB
>     GlobalReserve, single: total=62.16MiB, used=0.00B
> 
> If I do "btrfs balance start /" it becomes like before fallocate attempt, but it still doesn't fix the issue for me. fallocate and hence "homectl authenticate" would still fail.
> 


Output of "btrfs fi us /" before and after fallocate would probably give
more information. Also "btrfs sub li /" and "btrfs qgroup show -re /"
would be interesting. And "btrfs fi du /home/azymohliad.home".

Rough math so far - filesystem has 175GiB free space. Filesystem inside
container uses 258GiB so assuming container consumes exactly the same
space, in the worst case it needs 145GiB on containing filesystem for
full size. There should be enough free (even unallocated) space. I
thought there could be some snapshots that force btrfs to attempt to
allocate full 403GiB, bit in my testing even after creating read-only
snapshots fallocate does not attempt to duplicate space.
