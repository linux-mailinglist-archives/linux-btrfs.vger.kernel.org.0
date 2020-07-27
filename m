Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F3A22F973
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jul 2020 21:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgG0TsX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 15:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgG0TsW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 15:48:22 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D641C061794
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jul 2020 12:48:22 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id r19so18543925ljn.12
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jul 2020 12:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2nPFjZwQMWJvwfG/epDEDlVHz+KfxNW5VQWpseiLTSo=;
        b=VHG+C/AjS4XfSMKZ9usanYlo8KcMKdizXfgZR4Zca/A1MvQFgvmmvOoY2g5KGA78ND
         ofnkiv7SbWcvWjf9VRNXgJV8o5CYawMDfImHwfwoXVjhUnVIb7RsC0N+eRSHvr6dRYjc
         VzQDLlvPjnlT2EWHYbNmJ3K0s+a5te3JeKMPO1hWvdWxUEtaPNdb878KWvGkaLB1ZxlB
         MOPqifecFHz21eWYJEgtsxftb2x4XSOfcpCiKkDEBqiqK2506SXTCeTMIcXqpZxvxDNk
         d0PxJ/KTdQjZC6Hb4GvN32OcAG7iGkI92qxfkxFYSIYRh5wLov+WiTifV8irT0qHhu3w
         XcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2nPFjZwQMWJvwfG/epDEDlVHz+KfxNW5VQWpseiLTSo=;
        b=W0Bqr9OrLWT9nifC4s2p2qWyWdOCc1bDhpTYtU7n0iD3529F9T9uD87jh6SjVNE2/v
         aplyCN3fqUtuUx1n3uoKTBHce6wysgaRXFUSvcp+AmIsyCWDqNZnAif8MvMl7F+apa1T
         yr2w5PGQ6PTAXnX6gWsRf3NBeR+VHALwtGaGTI84gbfBP1+Z6HumU/HP7gT1uBgK4sU4
         8UVc7Curtis3C5LakCAuDJpQpE1m6eBmQith0kXXCvvZ2pSWJoZDN9joBjrzSh95Otli
         fo2KDglUHkepUDc1SyQUJluapVY2cE7lO/FNO2y6b15tA1YC++bpSCJ2SLRFipiNUN69
         4qbw==
X-Gm-Message-State: AOAM531VeiDR+9UhxyxpNlkO8Psdf14xM0eIC1RzQBM/dW9bZglKkslV
        1JvJLJt1NAw+wFHM5uN/89+obLaH
X-Google-Smtp-Source: ABdhPJyEJJlgBaCXKU4aClgVLwE8x3qU1skvaWKRROr9j9uD53sTbz2szwq1nLvqo9Kf60KS74e91A==
X-Received: by 2002:a2e:8191:: with SMTP id e17mr10012865ljg.339.1595879300331;
        Mon, 27 Jul 2020 12:48:20 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:c763:71ff:8633:9e4a:bf5b? ([2a00:1370:812d:c763:71ff:8633:9e4a:bf5b])
        by smtp.gmail.com with ESMTPSA id j1sm1529936ljb.35.2020.07.27.12.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 12:48:19 -0700 (PDT)
Subject: Re: Understanding "Used" in df
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <3225288.0drLW0cIUP@merkaba>
 <20200723045106.GL10769@hungrycats.org> <1622535.kDMmNaIAU4@merkaba>
 <558ef4c5-ee61-8a0d-5ca5-43a07d6e64ac@gmail.com>
 <CAJCQCtRgug3uTLBuraWmCiCoAY9VV94nQ0TBXz9jkUyuRhLnzQ@mail.gmail.com>
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
Message-ID: <8034c0e6-a1d2-5ba9-fdcf-d9b355fd34d1@gmail.com>
Date:   Mon, 27 Jul 2020 22:48:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRgug3uTLBuraWmCiCoAY9VV94nQ0TBXz9jkUyuRhLnzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

27.07.2020 22:30, Chris Murphy пишет:
> On Mon, Jul 27, 2020 at 10:43 AM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
>>
>> Unfortunately, "df" does not display "free" (I was wrong in other post).
>> But using stat ...
>>
>>
>> $ LANGUAGE=en stat -f .
>> ...
>> Block size: 4096       Fundamental block size: 4096
>> Blocks: Total: 115164174  Free: 49153062   Available: 43297293
>>
>> $ LANGUAGE=en df -B 4K .
>> Filesystem     4K-blocks     Used Available Use% Mounted on
>> /dev/sda4      115164174 66011112  43297293  61% /
>>
>> 115164174 - 49153062 == 66011112
>>
>> But there is no way you can compute Available from other values - it is
>> whatever filesystem returns.
>>
> 
> It's definitely goofy in the odd device raid1 case.

Well, I already explained why it happens. Yes, it looks like a bug, the
question is how to do better estimation without performing exhaustive
single-chunk allocation every time. Three equal size devices looks
simple, but consider general case of multiple devices of different size
or different amount of free space.

> If I fallocate a
> file equal to Avail, Avail is not zero.

Yes, because real allocator breaks large file into chunks and estimation
in statfs "allocates" large size as single operation. So end result is
different.

> The fallocated file + new
> Avail != old Avail, which is just not at all correct behavior. So I
> keep fallocating files to get to 0 Avail, and instead I'm only chasing
> zero Avail condition. Once I'm close enough, and delete all six
> fallocated files, I end up for a short period of time, an Avail that
> seems reasonable but is way bigger than it was at the start. And then
> a minute later, without any additional action on my part, returns to
> reporting nonsense.
> 
> It's pretty confusing.
> 
> 

