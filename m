Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39AE21C7A9
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Jul 2020 07:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgGLF2k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jul 2020 01:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgGLF2j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jul 2020 01:28:39 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA94C08C5DD
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jul 2020 22:28:37 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id h22so10900245lji.9
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jul 2020 22:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3hoL8JqAbr7fWAE/ye7uSK607Nfbjet4SLpzNkTce+Y=;
        b=FHUz9sJ35E4l0ql9TfyyURfUAnFLn4b7pCbAjwHcmInIulh0WTVKBthtYDYEcSlHbs
         JDClySkrYFnla0b+mRd8RmQ2kyBPMzBQIEPOTgpErAzigh9+xmcpdglGRjx8v5Zitksv
         JhgH2+YzyYgmUuLkrlaxflRMBef8kWFs8mBiOygHJEzMHbDelb/Hqi7nc45f5MvWKZIn
         ohXTnqGrMQqhvJSQTQvyaWsnFE0aEppi3gDovTyVQa1GpOyAavC2VIusY8qAp2OcTeTK
         FOawMfEHKxdll8lpPZlEwj8LR2dHVqvHuMcZByvArvo/Btu1OEYHtdwe29x4GhE9ByZV
         C18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3hoL8JqAbr7fWAE/ye7uSK607Nfbjet4SLpzNkTce+Y=;
        b=nOZs+Xl/iZ/tBBG4UonVSuppYSAcE4R57wZUX8zTaJQLKX3p/Mh09fr2bzVljYPNKs
         hrdtSlz3Dpx9qK5Pt7tAvlRXyZiINREJqbGxjGuoNGPAFXsOd8AUJHqBpuBDN/q7UkCg
         Lp0s3nLG+rqGHHC/RRHjJG128xasPI1Dilw+dFwKAFPlthMNQ8lxBCcSL632AeDkPezE
         fcJXgNVrxYR9AI0cY8l+pE+DWVs2uOYKW89uiu9J9YKc7aTFL5+wu3ck6lcuZi1LHB8N
         ni/Sbg5fP0asdA7PNZcYCWfPD3AivkQ9LNE/m1tKy2ji6RA3M/A1QIk+ax71ED772o6y
         IpQg==
X-Gm-Message-State: AOAM532DgjJvSoq4Qt8ZzGv+kAf9G2PBO6H+5RrXHsWEuvAJ3boqRJhV
        SFHDCxjSI4tZDnfstua5JqDtVEwN
X-Google-Smtp-Source: ABdhPJxHnQ1ZU/xxzLXH57C6UrnifUEpehPd+J08hef5re6XEIlpQgnbZtUyj68YDpNSP0zw9Y430g==
X-Received: by 2002:a05:651c:3c2:: with SMTP id f2mr46158023ljp.37.1594531713871;
        Sat, 11 Jul 2020 22:28:33 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:9bf7:50a4:1b78:5915:6126? ([2a00:1370:812d:9bf7:50a4:1b78:5915:6126])
        by smtp.gmail.com with ESMTPSA id i10sm3212060ljg.80.2020.07.11.22.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2020 22:28:33 -0700 (PDT)
Subject: Re: Btrfs default on Fedora?
To:     Chris Murphy <lists@colorremedies.com>,
        Ken D'Ambrosio <ken@jots.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <933824829995390cef16f757cab1ddbc@jots.org>
 <CAJCQCtSbBCJjKcwuNB9b2ZZQWjkwxvBQpC0C7UWVsAjBAN6BgA@mail.gmail.com>
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
Message-ID: <d81cea36-bb02-88a4-e65e-3070f0dc76d9@gmail.com>
Date:   Sun, 12 Jul 2020 08:28:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSbBCJjKcwuNB9b2ZZQWjkwxvBQpC0C7UWVsAjBAN6BgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

12.07.2020 00:18, Chris Murphy пишет:
> On Sat, Jul 11, 2020 at 12:44 PM Ken D'Ambrosio <ken@jots.org> wrote:
> 
>> * Swap files.  At least last time I checked, it was a PITA to take a
>> snapshot of a volume that had a swapfile on it -- I wound up writing a
>> wrapper that goes, does a swapoff, removes the file, creates the
>> snapshot, and then re-creates the file.   Is this still "a thing"?  Or
>> is there a way to work around that that isn't kludgey?
> 
> Put the swapfile in its own subvolume and don't snapshot it. One way
> is to create a (nested) subvolume named "swap" inside of the "root"
> subvolume created at installation time; use chattr +C on it; now
> create the swapfile per 'man 5 btrfs'.
> 
> Since btrfs snapshots aren't recursive, making a snapshot of 'root'
> will not cause a snapshot to be taken of 'swap' or its swapfiles.
> 

swap file requires calculation of absolute disk offset (that is what
kernel works with) and this is not supported on btrfs with by systemd:

https://github.com/systemd/systemd/blob/d67b1d18fcda2c8c5aacfc50f9591c8dc7a4a8a1/src/shared/sleep-config.c#L240

I believe with current systemd if you manually compute and provide
resume=btrfs-partition and resume_offset=absolute-offset-of-swapfile it
should take it, but using resume=file-on-btrfs will fail.

