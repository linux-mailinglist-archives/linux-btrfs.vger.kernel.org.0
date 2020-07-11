Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F142C21C283
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jul 2020 08:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgGKG2n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jul 2020 02:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgGKG2m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jul 2020 02:28:42 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4035EC08C5DD
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 23:28:42 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id h19so8773401ljg.13
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 23:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dhaOm85YIWw1ZZhm/igWp++cb5muYnQv936DoPOt+9k=;
        b=Yi+L1zMtjufR9hC/DjUlhieKe2Gjjlhc5CryWDYAD4hol9/fvszV2NfR4Q2XB2G9nG
         1RmihRjKo5uSkYIuZNxCPg6jyLBvfXCLps+Qgd2WsQB7gP8ZRNd0gThatxRbX+Usw725
         Y6WL/qfRaOynOzJ2L739xnm2sd+oNGH3Lwhj2DIWc9YIPtGTcf7gghUQrV93HqIDFxu+
         /KyGyTrzlXiElqLELhiFLZ6LAi7OG+UapLRvCOl1i3S0Sx9WnSaWMpxX9Sy2OINWEEP8
         SBRb0xAB9bzsCPrTp8qZPwq4DJpWiY86R8z4yPkgduwrPIjrj7QktfSMXHbGiaxz3loF
         yIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dhaOm85YIWw1ZZhm/igWp++cb5muYnQv936DoPOt+9k=;
        b=Cfqa+Y14+HebMGPqGuObopi78pz2aU6WlbHr5ZjAbhqkK7s+Ooie2bkOJZe9yEy0vF
         Qy762bIRUM+K1CuoetPvNdaR1VTAhT4NtIvR/ikrlOLZXvwbDZfvNzd02OxkW64nkHlF
         dY/bL13fHsswLblbr9+693v1GhgHRLsk7AkPzWZgkPJHqF1X4XNoa0CIuVcUezoepeRS
         45fLPLxu6Qhct9t5Wy+V7ht0pPqeYWXL6VcnNEUcKb7qO4ageW+NuC8V9nKD3Psb4N2d
         rmpZTlLybSl3yGIQkdCKteHX4/eyhlmCza7EmxKrSwa/U9/PZG4ybFv+3W6/dQfqsZ6/
         Gndg==
X-Gm-Message-State: AOAM530vA5+8WTgehuBaYwrWcAKrCajDtlwVJEsU+rD4o98IKo1otFdY
        2P4KJXm4Fj/u6xIczCxwwICpFqZN
X-Google-Smtp-Source: ABdhPJzmDaSpg/orDqesuUUFNIXsdLCaL1UYeeye967HL2UWWAliXSrbk9lyn6PFrkJ3KhlCo58+Ow==
X-Received: by 2002:a2e:b0ed:: with SMTP id h13mr31912707ljl.250.1594448920086;
        Fri, 10 Jul 2020 23:28:40 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:9bf7:50a4:1b78:5915:6126? ([2a00:1370:812d:9bf7:50a4:1b78:5915:6126])
        by smtp.gmail.com with ESMTPSA id w19sm2571616ljh.106.2020.07.10.23.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 23:28:39 -0700 (PDT)
Subject: Re: raid0 and different sized devices
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtRfXy9YDqZQgYz0_djd78oEMwiYY7Og2x=J=w361FENWg@mail.gmail.com>
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
Message-ID: <7f9a8467-6b03-6699-f124-2833fffef4ab@gmail.com>
Date:   Sat, 11 Jul 2020 09:28:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRfXy9YDqZQgYz0_djd78oEMwiYY7Og2x=J=w361FENWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

11.07.2020 04:37, Chris Murphy пишет:
> Summary:
> 
> df claims this volume is full, which is how it actually behaves. Rsync
> fails with an out of space message. But 'btrfs fi us' reports
> seemingly misleading/incorrect information:
> 
>     Free (estimated):          12.64GiB    (min: 6.33GiB)
> 
> If Btrfs can't do single device raid0, and it seems it can't, then
> this free space reporting seems wrong twice. (Both values.)
> 

This space can be used with single or dup profiles so it is actually
correct (second number being for dup). It would of course be nice to get
extended output "how much space for each profile", but as "estimation of
theoretical free space" it is absolutely correct.

Of course I do not know whether it is correct by design or by coincidence :)

> Details:
> 
> # uname -r
> 5.8.0-0.rc3.20200701git7c30b859a947.1.fc33.x86_64
> # btrfs --version
> btrfs-progs v5.7
> 
> 
> # btrfs fi show
> Label: 'fedora_localhost-live'  uuid: 1fa3ab85-2dec-46f8-9a35-264c0f412dcc
>     Total devices 2 FS bytes used 885.83MiB
>     devid    1 size 730.00MiB used 709.00MiB path /dev/vda3
>     devid    2 size 13.30GiB used 709.00MiB path /dev/vdb1
> 
> 
> # df -h
> Filesystem           Size  Used Avail Use% Mounted on
> /dev/vda3             15G  905M   60M  94% /mnt/sysroot
> 
> 
> # btrfs fi us /mnt/sysroot
> Overall:
>     Device size:          14.01GiB
>     Device allocated:           1.38GiB
>     Device unallocated:          12.63GiB
>     Device missing:             0.00B
>     Used:             901.58MiB
>     Free (estimated):          12.64GiB    (min: 6.33GiB)
>     Data ratio:                  1.00
>     Metadata ratio:              2.00
>     Global reserve:           3.25MiB    (used: 0.00B)
>     Multiple profiles:                no
> 
> Data,RAID0: Size:890.00MiB, Used:870.08MiB (97.76%)
>    /dev/vda3     445.00MiB
>    /dev/vdb1     445.00MiB
> 
> Metadata,RAID1: Size:256.00MiB, Used:15.73MiB (6.15%)
>    /dev/vda3     256.00MiB
>    /dev/vdb1     256.00MiB
> 
> System,RAID1: Size:8.00MiB, Used:16.00KiB (0.20%)
>    /dev/vda3       8.00MiB
>    /dev/vdb1       8.00MiB
> 
> Unallocated:
>    /dev/vda3      21.00MiB
>    /dev/vdb1      12.61GiB
> #
> 
> 

