Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E4122F58F
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jul 2020 18:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgG0QnF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 12:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0QnE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 12:43:04 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDBDC061794
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jul 2020 09:43:04 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id r19so17945340ljn.12
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jul 2020 09:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lhJKOIFivPJwL3otMPVDBcVSMcPq4jB+n4zo/LI3ckg=;
        b=QKuBX4//eU5tNGLd84DqaJA5+uWJ0oybe5O+5/1k7RTUd0LWiKT+bRakxDysaeo12i
         SuNF6PxP8HZTarmi+KgEiIf9g7wjuu51JLBDWihENjJzNtBrDg/MHL/VNDtV+4ckZIZd
         JMPTextbsqglxVkaoVo2oSzSa6P6Eguhqz6ElYLN0heg6eGF1n6G6m5Hv/6JxPtfgjNr
         z2UsmaejBiFgiL7zbXBW61KcZRbKVYNEd0KIZxspHhur/Ng0+zdcbibfdUBpZZaKca3v
         V/fcy6vmrcVw3YuV91CQlZupnOzd1J9MOMu62NWIeURT6rxZhR+kA0TuF9V46LabZ+x7
         mmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lhJKOIFivPJwL3otMPVDBcVSMcPq4jB+n4zo/LI3ckg=;
        b=XGfeLBW888MtBS3a5I9oe1DJJ9dmzdGXQqkHHuwqYK7ptwuVnYAGNrDYHUpfcsjZZR
         kjYGrZ5Ji9KWzcvmp3cVrF119NL2NUWSbvv9okvmFAUB7XyyPhDCYHUstoqoNd+g9qkk
         jeIguAaIoxPQW+khtYC5IXMk5aSQasf7NOvBony1m8gTfaR7mFXuqlh8d2WNavSL3+2R
         ksKlX7SUcPjRS3jHIChX9fbRSVBUIkXmT6TYDYf+o5EGLwOQWg1g+QJjWkpLSq52LwOY
         w0LtzG44p65oeifF51zSN+cOAhfNyKhToM0RT8H/E7AB+cMcsZmXnj4Y+rT+vtPGb6qR
         nDTA==
X-Gm-Message-State: AOAM531Ej7uBIwMyC9/6sr0H7dlkuRhsCEfGGSsBDqV3ftyvClBuFRCU
        kMwyrdJk6wzUnQXdJI7yKGHjhLe+
X-Google-Smtp-Source: ABdhPJyzklzS4VGxlJB7MXJA8MHowkoRM79gNrlX59qFURX7gbEB25xhmj3hk+2DdgVG6yOLf6jz9g==
X-Received: by 2002:a2e:2a84:: with SMTP id q126mr10140240ljq.1.1595868181579;
        Mon, 27 Jul 2020 09:43:01 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:c763:71ff:8633:9e4a:bf5b? ([2a00:1370:812d:c763:71ff:8633:9e4a:bf5b])
        by smtp.gmail.com with ESMTPSA id c23sm3121705lfg.87.2020.07.27.09.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 09:43:00 -0700 (PDT)
Subject: Re: Understanding "Used" in df
To:     Martin Steigerwald <martin@lichtvoll.de>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <3225288.0drLW0cIUP@merkaba>
 <20200723045106.GL10769@hungrycats.org> <1622535.kDMmNaIAU4@merkaba>
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
Message-ID: <558ef4c5-ee61-8a0d-5ca5-43a07d6e64ac@gmail.com>
Date:   Mon, 27 Jul 2020 19:42:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1622535.kDMmNaIAU4@merkaba>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

27.07.2020 14:38, Martin Steigerwald пишет:
> Zygo Blaxell - 23.07.20, 06:51:06 CEST:
>> On Wed, Jul 22, 2020 at 05:10:19PM +0200, Martin Steigerwald wrote:
>>> I have:
>>>
>>> % LANG=en df -hT /home
>>> Filesystem            Type   Size  Used Avail Use% Mounted on
>>> /dev/mapper/sata-home btrfs  300G  175G  123G  59% /home
>>>
>>> And:
>>>
>>> merkaba:~> btrfs fi sh /home
>>> Label: 'home'  uuid: […]
>>>
>>>         Total devices 2 FS bytes used 173.91GiB
>>>         devid    1 size 300.00GiB used 223.03GiB path
>>>         /dev/mapper/sata-home
>>>         devid    2 size 300.00GiB used 223.03GiB path
>>>         /dev/mapper/msata-home
>>>
>>> merkaba:~> btrfs fi df /home
>>> Data, RAID1: total=218.00GiB, used=171.98GiB
>>> System, RAID1: total=32.00MiB, used=64.00KiB
>>> Metadata, RAID1: total=5.00GiB, used=1.94GiB
>>> GlobalReserve, single: total=490.48MiB, used=0.00B
>>>
>>> As well as:
>>>
>>> merkaba:~> btrfs fi usage -T /home
>>>
>>> Overall:
>>>     Device size:                 600.00GiB
>>>     Device allocated:            446.06GiB
>>>     Device unallocated:          153.94GiB
>>>     Device missing:                  0.00B
>>>     Used:                        347.82GiB
>>>     Free (estimated):            123.00GiB      (min: 123.00GiB)
>>>     Data ratio:                       2.00
>>>     Metadata ratio:                   2.00
>>>     Global reserve:              490.45MiB      (used: 0.00B)
>>>     Multiple profiles:                  no
>>>     
>>>                           Data      Metadata System
>>>
>>> Id Path                   RAID1     RAID1    RAID1    Unallocated
>>> -- ---------------------- --------- -------- -------- -----------
>>>
>>>  1 /dev/mapper/sata-home  218.00GiB  5.00GiB 32.00MiB    76.97GiB
>>>  2 /dev/mapper/msata-home 218.00GiB  5.00GiB 32.00MiB    76.97GiB
>>>
>>> -- ---------------------- --------- -------- -------- -----------
>>>
>>>    Total                  218.00GiB  5.00GiB 32.00MiB   153.94GiB
>>>    Used                   171.97GiB  1.94GiB 64.00KiB
>>>
>>> I think I understand all of it, including just 123G instead of
>>> 300 - 175 = 125 GiB "Avail" in df -hT.
>>>
>>> But why 175 GiB "Used" in 'df -hT' when just 173.91GiB (see 'btrfs
>>> fi sh') is allocated *within* the block group / chunks?
>>
>> statvfs (the 'df' syscall) does not report a "used" number, only total
>> and available btrfs data blocks (no metadata blocks are counted).
>> 'df' computes "used" by subtracting f_blocks - f_bavail.
>>
>> 	122.99875 = 300 - 171.97 - 5 - .03125
>>
>> 	df_free = total - data_used - metadata_allocated - system_allocated
> 
> I get that one. That is for what is still free.
> 
> But I do not understand "Used" in df as.
> 
> 1) It it would be doing 300 GiB - what is still available, it would do 300-122.99 = 177.01
> 

df "Used" is computed as "total" - "free", where "free" is reported by
filesystem. btrfs free is 76.97GiB + 49.12GiB. I suppose btrfs does
internally round at least the first number to the full chunk size which
gives us close to 125GiB. To

> 2) If it would add together all allocated within a chunk… 
> 
> 171.98 GiB used in data + 64 KiB used in system + 1,94 GiB used in metadata ~= 174 GiB
> 
> 3) It may consider all allocated system and metadata chunks as lost for writing
> data:
> 
> 171.98 used in date + 32 MiB allocated in system + 5 GiB allocated in metadata ~= 176.98 GiB
> 
> 4) It may consider 2 of those 5 GiB chunks for metadata as reclaimable and
> then it would go like this:
> 
> 171.98 used in date + 32 MiB allocated in system + 3 GiB metadata ~= 116.98 GiB = 174.98 GiB
> 

"df" does not know anything about data vs. metadata vs. system reserve.
It has only two values filesystem returns - free and avail. And yes,
they are computed independently.

"used" + "free" == "total", but do not expect "avail" to have any direct
relation to other metrics.

Unfortunately, "df" does not display "free" (I was wrong in other post).
But using stat ...


$ LANGUAGE=en stat -f .
...
Block size: 4096       Fundamental block size: 4096
Blocks: Total: 115164174  Free: 49153062   Available: 43297293

$ LANGUAGE=en df -B 4K .
Filesystem     4K-blocks     Used Available Use% Mounted on
/dev/sda4      115164174 66011112  43297293  61% /

115164174 - 49153062 == 66011112

But there is no way you can compute Available from other values - it is
whatever filesystem returns.


> That would be about right, but also as unpredictable as it can get.
> 
>> Inline files count as metadata instead of data, so even when you are
>> out of data blocks (zero blocks free in df), you can sometimes still
>> write small files.  Sometimes, when you write one small file, 1GB of
>> available space disappears as a new metadata block group is allocated.
>>
>> 'df' doesn't take metadata or data sharing into account at all, or
>> the space required to store csums, or bursty metadata usage workloads.
>> 'df' can't predict these events, so its accuracy is limited to no
>> better than about 0.5% of the size of the filesystem or +/- 1GB,
>> whichever is larger.
> 
> So just assume that df output can be +/- 1 GiB off?
> 
> I am just wondering cause I aimed to explaining this to participants of
> my Linux courses… and for now I have the honest answer that I have
> no clue why df displays "175 GiB" as used.
> 
>>> Does this have something to do with that global reserve thing?
>>
>> 'df' currently tells you nothing about metadata (except in kernels
>> before 5.6, when you run too low on metadata space, f_bavail is
>> abruptly set to zero).  That's about the only impact global reserve
>> has on 'df'.
> 
> But it won't claim used or even just allocated metadata space as available
> for writing data?
> 
>> Global reserve is metadata allocated-but-unused space, and all
>> metadata is not visible to df.  The reserve ensures that critical
>> btrfs metadata operations can complete without running out of space,
>> by forcing non-critical long-running operations to commit
>> transactions when no metadata space is available outside the reserved
>> pool.  It mostly works, though there are still a few bugs left that
>> lead to EROFS when metadata runs low.
> 
> Hmmm, thanks.
> 
> But as far as I understood also from the other post, Global Reserve is
> reserved but not reported as used in df?
> 
> I am not sure whether I am getting it though.
> 
> Best,
> 

