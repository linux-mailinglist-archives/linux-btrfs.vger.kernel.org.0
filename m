Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245B529D7A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Oct 2020 23:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732877AbgJ1WZW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 18:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732874AbgJ1WZV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 18:25:21 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C11C0613CF
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 15:25:21 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id r8so670974qtp.13
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 15:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XDKshFT67w1TenH4xvDZOT2AucE4MpYkvogvdq8G1fc=;
        b=vl0DAxTxmkgeJ+6HsOLP+O6KW4mdtJpR5rcPedZkMV9Ajv1+T7MEz88qWTw45FuKmr
         SNHwfIkqXsuHP8u3MjrLnXICQ10Vb4+B4gLujOwdu2182O0OwMF0P2OXOGEQXSP0nued
         ECyLuqxFDI/bJCm9rSZvbeW6m3jaEOxkQ5q+IMVX1KnL6KbEvCwKmV9MLZL2Ff5uFsCc
         7/809fIAG6R/iqwCr/RQ3/jd1HzOfuVifpyP+2Wk8KNAh8MRGoeUmftBHuyAPx9N5k5v
         83JMzJEw1uM6OmYkkyZnXXHKcixXSBxbP6yFd/+W/K0FNns7brC+LUPGxcOFf9DrW7hM
         3cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XDKshFT67w1TenH4xvDZOT2AucE4MpYkvogvdq8G1fc=;
        b=lYZ0T4cp/Pmie6LFXI1UsHDDkmkzqYk3AgLPv7EkfJ/icAngiwgLwt44ULnpkAKBLi
         M2WEo3ouNiubWPLHvb69biDNbP54K1iDbbVzMXtyc8+MCjuJEbE9+4t2VdLhMPPNAh6H
         XA1t22oSyEkc9WJ7D5fUUs3V32ONMZCtpNb8NfeYjamYBWpCPUVb4+bMe7P7lXSKhUfU
         pGpWU6QI1vvP8WVNexsXYKRNs8ShdM7YV6HhFx7m/ODqeBPXGY1DpqxzvxUbhXjSBOE9
         cJ9mFG2WcFCINEwTH1EdcXsKpQdgsdETfBymexO1d5nIEASYTF5J0gE2BLjhajxdbidl
         vqcQ==
X-Gm-Message-State: AOAM5335Lt7R1mRXMWG/ihNm+jrv3RaQ5KoKo99CdJqUUtrclbZdhweQ
        fcz/1P2sp5vCAkw3VkhZG1ZAUffk/M4Ztd1o
X-Google-Smtp-Source: ABdhPJx6HXLC2P/UI4H0UJXR9RRicrgptDyVwekrMhUwGVz0qhtr+Pn7qpYqA7ugB+Gs5aSwVOUEXw==
X-Received: by 2002:a05:620a:127a:: with SMTP id b26mr7690466qkl.166.1603895522277;
        Wed, 28 Oct 2020 07:32:02 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 63sm3088772qkn.9.2020.10.28.07.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 07:32:01 -0700 (PDT)
Subject: Re: [PATCH v1 0/4] btrfs: read_policy types latency, device and
 round-robin
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1603884539.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ac428935-c20c-d02d-6678-d88cc5eb4b63@toxicpanda.com>
Date:   Wed, 28 Oct 2020 10:32:00 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <cover.1603884539.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/28/20 9:25 AM, Anand Jain wrote:
> Based on misc-next
> 
> Depends on the following 3 patches in the mailing list.
>    btrfs: add btrfs_strmatch helper
>    btrfs: create read policy framework
>    btrfs: create read policy sysfs attribute, pid
> 
> v1:
> Drop tracing patch
> Drop factoring inflight command
>    Here below is the performance differences, when inflight is used, it pushed
>    few commands to the other device, so losing the potential merges.
> 
>    with inflight:
>     READ: bw=195MiB/s (204MB/s), 195MiB/s-195MiB/s (204MB/s-204MB/s), io=15.6GiB (16.8GB), run=82203-82203msec
> sda 256054
> sdc 20
> 
>    without inflight:
>     READ: bw=192MiB/s (202MB/s), 192MiB/s-192MiB/s (202MB/s-202MB/s), io=15.6GiB (16.8GB), run=83231-83231msec
> sda 141006
> sdc 0
> 

What's the baseline?  I think 3mib/s is not that big of a tradeoff for 
complexity, but if baseline is like 190mib/s then maybe its worth it.  If 
baseline is 90mib/s then I say it's not worth the inflight.  Thanks,

Josef
