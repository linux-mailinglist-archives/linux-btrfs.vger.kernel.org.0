Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDF22E287F
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Dec 2020 19:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgLXSKk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Dec 2020 13:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgLXSKj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Dec 2020 13:10:39 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6471AC061573
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Dec 2020 10:09:59 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id b9so1925620qtr.2
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Dec 2020 10:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ztbFfJ3Fkh9UVS90TKS6wJ6uphlQjcNc3e1DNhK+DqY=;
        b=a+ELvrdNWcd21/0pkOOfHE9avUcEeSVY83cqBMii9WduUW7Av1Lu3MZwS80t563p+r
         bZmuhLbk0rOq4PD3g/SDaLqlj4OXufkLKUGYOFETbw2kb1QFmxxh9oVZPVMFwXEU1VnF
         ErfxHjiLxR8P+k8qTMz+vekkz0BeY9+L7zAbFNyG7XjtfyO9Y/SqHOvu/n8gunVumjZc
         sFF53JUhiqejV4Uu5YHkXH3D+kHaXKP2M3zcfT61nXCfyYseFOE3CHqrAqkuM1EZCx6B
         9STQOsEK9ND8Zhw/ewoONi7HaCMr3n5LnmvXRwcM8Tuf4H25yp/TZMdmjFDNxu/r1DJS
         F9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ztbFfJ3Fkh9UVS90TKS6wJ6uphlQjcNc3e1DNhK+DqY=;
        b=HTdEbSU7SqU/+UA9ut42MEQyfHA7rhFS6Wb5KpOyyF4EUY7Fh8pFbjBrj97Q15NcYM
         gyWlR5t6bujKS+/QiH0Gva2zDnc16LzybK8VwG05l7ohvxWKE1lDKtEQeDhuTngFSXO5
         Fqum3Sl487g9mCAaP+1/4ymW6E4KddQJ42safACKflyGOFme8mPkkNgoWTy5BfWRvF3A
         rnRyXuqlvfAV988nigUkQnblHQqUYAKQe3TaCxxGeyGPo+YofIqSvV0hdqNvVoILZVsd
         bdsHa76v7QxbXiebP1Je/VXx2njvBcXrV5ce60ucEzqzKGCMJngAeaFRxPBgyEamJsEG
         xI4g==
X-Gm-Message-State: AOAM530OMIoEBZ1r+IV1bo9KSk3iKQbURkNaAQXd9TSJV2ArLX9cxWh2
        MO7dPnA99pbj/O67tylhErNpGIcCxa0PFsoD
X-Google-Smtp-Source: ABdhPJwVAFyTUFAAsHEPnirYANr5VDLpahLHZEfku+5EfpHmFndSiibieye+tP+57UFMEi/rFaoUzg==
X-Received: by 2002:aed:2f64:: with SMTP id l91mr30964393qtd.363.1608833397506;
        Thu, 24 Dec 2020 10:09:57 -0800 (PST)
Received: from localhost.localdomain (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j142sm17744216qke.117.2020.12.24.10.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Dec 2020 10:09:56 -0800 (PST)
Subject: Re: [BUG] 500-2000% performance regression w/ 5.10
To:     =?UTF-8?Q?Ren=c3=a9_Rebe?= <rene@exactcode.de>,
        linux-btrfs@vger.kernel.org
References: <B4BB2DCB-C438-4871-9DDD-D6FB0E6E4F1B@exactcode.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6df7ff08-b9bf-a06e-13a9-bf1c431920e4@toxicpanda.com>
Date:   Thu, 24 Dec 2020 13:09:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <B4BB2DCB-C438-4871-9DDD-D6FB0E6E4F1B@exactcode.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/21/20 2:45 PM, René Rebe wrote:
> Hey there,
> 
> as a long time btrfs user I noticed some some things became very slow
> w/ Linux kernel 5.10. I found a very simple test case, namely extracting
> a huge tarball like:
> 
>    tar xf /usr/src/t2-clean/download/mirror/f/firefox-84.0.source.tar.zst
> 
> Why my external, USB3 road-warrior SSD on a Ryzen 5950x this
> went from ~15 seconds w/ 5.9 to nearly 5 minutes in 5.10, or 2000%
> 
> To rule out USB, I also tested a brand new PCIe 4.0 SSD, with
> a similar, albeit not as shocking regression from 5.2 seconds
> to ~34 seconds or∫~650%.
> 
> Somehow testing that in a VM did over virtio did not produce
> as different results, although it was already 35 seconds slow
> with 5.9.
> 
> # first bad commit: [38d715f494f2f1dddbf3d0c6e50aefff49519232]
>    btrfs: use btrfs_start_delalloc_roots in shrink_delalloc
> 
> Now just this single commit does obviously not revert cleanly,
> and I did not have the time today to look into the rather more
> complex code today.
> 
> I hope this helps improve this for the next release, maybe you
> want to test on bare metal, too.
> 

Alright to close the loop with this, this slipped through the cracks 
because I was doing a lot of performance related work, and specifically 
had been testing with these patches on top of everything

https://lore.kernel.org/linux-btrfs/cover.1602249928.git.josef@toxicpanda.com/

These patches bring the performance up to around 40% higher than 
baseline.  In the meantime we'll probably push this partial revert into 
5.10 stable so performance isn't sucking in the meantime.  Thanks,

Josef
