Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2588522D6B3
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jul 2020 12:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGYKV7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jul 2020 06:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgGYKV7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jul 2020 06:21:59 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C3BC0619D3
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Jul 2020 03:21:58 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b11so6498630lfe.10
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Jul 2020 03:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WsTqp6nMGedAdguOL47HxHm9z+AbaPXEzpitZ9pW2YE=;
        b=hY/lznVyJMdKBfiY9/MPung7K6CVO7+d4k0xkCKJpDTHMIHyqimkQoHUAxW557wIM8
         wfnIlGyLcofdHdlpHYlZC0l8T/RQ5rpHVPsOqERe8SDpvNLlZZ/LRq3Srl9MyBEsl72t
         LmGMBio/I1PBq1ki6nNIba7Syzw4Q3Fs62GaKXIIVS7fP4oYOYWyWFAZ6MKayhjAYnUn
         oA2x/J/IkAxBeU6KGTh9olSGmMLB1sNZaFn8clJrc2ZhMn4BaloCNuLFb3ydaPssPrlq
         ZBQVVXnHN8Emn5nWYRAAqWQrU7/lH6cjncTFji1IfGEfRxTKjo/jadGcVOg0OMl8X1yh
         Id8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WsTqp6nMGedAdguOL47HxHm9z+AbaPXEzpitZ9pW2YE=;
        b=BYYMll1mlhEFLabLyUMqANPw2Rr99pwxVbIslkjN+4ih90+wjjgsNVxgKH0fgexvN9
         xBDAKWKcCDj5L8rESEP8bi74A0rSWY+iJHYubh2ZuWtZez0CnlKuvql4ColqsEt3zaqy
         BTv+fc8QViawexyCxD+g7uWusj/hM7DqKmZCmzTeUUSYkIwG1ouvunoWXndKcQguhWK1
         uFLQ+r8CJoc8zxY7opTXogkFUL1EHnQ9XRQw76spPIaEu00KaQ0SfatzV3F/PrD45XKz
         6u3N92O1ZqM6y0oCMMzpeM1cVIFu/ARmWL2tI5goTUuYdwqSupwdLxHXec+InJoxG6mM
         spgA==
X-Gm-Message-State: AOAM530e6i+UHV7GzhiGkTxmc89uVRdKEXqjpq8ly+mCz/2A8zzUJS7U
        Ba992m1ur4WIlYOzr0ODDynIemIl
X-Google-Smtp-Source: ABdhPJwijAlPjigIMHPc1JdVuSe8bccynUyHxpKFFNgBK/vMNYWiZOsTV3576taTzrQ3Hss9YE/CXg==
X-Received: by 2002:a19:4345:: with SMTP id m5mr7158801lfj.60.1595672516570;
        Sat, 25 Jul 2020 03:21:56 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:c763:71ff:8633:9e4a:bf5b? ([2a00:1370:812d:c763:71ff:8633:9e4a:bf5b])
        by smtp.gmail.com with ESMTPSA id q22sm1162173lfc.33.2020.07.25.03.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2020 03:21:56 -0700 (PDT)
Subject: Re: df free space not correct with raid1 pools with an odd number of
 devices
To:     Jorge Bastos <jorge.mrbastos@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAHzMYBTU=JuEsRX7YXzMJMELy63TXrm3J6onKnhGSOOzTnnMBg@mail.gmail.com>
 <CAJCQCtS6eS7a+wHR__A_aDujANWNJEmUMApjChVMk1WNuZ0BKg@mail.gmail.com>
 <CAHzMYBT8a9D817i2TRqdRiJFdmF-c3WVyo6HNgbv8bJqqOyr5g@mail.gmail.com>
 <CAJCQCtSeAKD_bVk7GUVyLdzdSZqR8O9zEX40kCmyR--DyWtSRw@mail.gmail.com>
 <dd11313f-3b9c-c743-257c-71ba1da4dde0@gmail.com>
 <446adc05-b03b-488a-c8a3-6c31cabdb3d0@gmail.com>
 <CAHzMYBTUx5Xp9HVhB5r-eQRrL=8fdQwKY=awfGTCxqczCHSsHA@mail.gmail.com>
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
Message-ID: <dc1197d9-0265-78a3-b7f7-06ad72a24c3e@gmail.com>
Date:   Sat, 25 Jul 2020 13:21:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHzMYBTUx5Xp9HVhB5r-eQRrL=8fdQwKY=awfGTCxqczCHSsHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

25.07.2020 13:04, Jorge Bastos пишет:
> On Sat, Jul 25, 2020 at 8:43 AM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
>>
> 
>>
>> OTOH, this is the correct if the most pessimistic estimation either. If
>> you have three 250G RAID1 devices and you allocate 250G data in one file
>> you consume two full devices and won't be able to allocate new data at
>> all (or for that matter no new metadata either).
>>
>>
>> So whatever value btrfs returns will be wrong for some allocation pattern.
> 
> I considered that but wouldn't a single file still be stripped and
> blocks allocated to all devices, on a most free space basis?
> 

Yes, I was unsure and stay corrected. It seems real allocation happens
per chunk and so gets distributed to all devices.

Sorry.

> E.g.: 3 x 500GB RAID1 pool:
> 
> $ btrfs fi usage -T /mnt/cache
> Overall:
>     Device size:                   1.36TiB
>     Device allocated:              2.13GiB
>     Device unallocated:            1.36TiB
>     Device missing:                  0.00B
>     Used:                        288.00KiB
>     Free (estimated):            697.61GiB      (min: 697.61GiB)
>     Data ratio:                       2.00
>     Metadata ratio:                   2.00
>     Global reserve:                3.25MiB      (used: 32.00KiB)
>     Multiple profiles:                  no
> 
>              Data     Metadata  System
> Id Path      RAID1    RAID1     RAID1    Unallocated
> -- --------- -------- --------- -------- -----------
>  1 /dev/sdb1 36.00MiB         - 32.00MiB   465.69GiB
>  2 /dev/sde1 36.00MiB   1.00GiB 32.00MiB   464.69GiB
>  3 /dev/sdf1        -   1.00GiB        -   464.76GiB
> -- --------- -------- --------- -------- -----------
>    Total     36.00MiB   1.00GiB 32.00MiB     1.36TiB
>    Used         0.00B 128.00KiB 16.00KiB
> 
> 
> 
> $ fallocate -l 690G /mnt/cache/file
> $ btrfs fi usage -T /mnt/cache
> Overall:
>     Device size:                   1.36TiB
>     Device allocated:              1.35TiB
>     Device unallocated:           13.15GiB
>     Device missing:                  0.00B
>     Used:                          1.35TiB
>     Free (estimated):              7.61GiB      (min: 7.61GiB)
>     Data ratio:                       2.00
>     Metadata ratio:                   2.00
>     Global reserve:                3.25MiB      (used: 0.00B)
>     Multiple profiles:                  no
> 
>              Data      Metadata  System
> Id Path      RAID1     RAID1     RAID1     Unallocated
> -- --------- --------- --------- --------- -----------
>  1 /dev/sdb1 461.04GiB         -  32.00MiB     4.69GiB
>  2 /dev/sde1 460.04GiB   1.00GiB  32.00MiB     4.69GiB
>  3 /dev/sdf1 461.00GiB   1.00GiB         -     3.76GiB
> -- --------- --------- --------- --------- -----------
>    Total     691.04GiB   1.00GiB  32.00MiB    13.15GiB
>    Used      690.00GiB 976.00KiB 112.00KiB
> 
> Jorge
> 

