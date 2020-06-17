Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167ED1FCEA6
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 15:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgFQNhS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 09:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgFQNhQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 09:37:16 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8D1C06174E
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jun 2020 06:37:16 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f18so2015725qkh.1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jun 2020 06:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=KLmiiOwos/gpzDWQSsoZalQKxeHn/ZoJohXPoffNMw8=;
        b=gW0sDoBPVvBnxqFJ1YITCmXy/mlhw5+LnfdrCh83VgBvNMHVmdeD34Mdp5sqklMC6C
         x7D8VqgorR4H0FZRWM1YxLvIin1SRSEcVi0AFOHs7p/pE+JdhaPMUlr3qx6LfRR1f1IQ
         BXAe25I4YyULokILHh1gJRmSCWFjVSg0pnRbrJX+1RHSxvPC0a5tZNRspeNQbhYgymPf
         xR3Tz6xq4EnUvm+/GJoX/zXSp0rLbyn7WwjqKbaUAEP8Erv1zchCb+DKvGi5MJAoSFJd
         dzXEIyDQqqimqz6dM7a1ty6YRZRXE3uLEvD86RVZD3DbR9ZuXVlXLnSJXQ4+ol1gPlg3
         ApEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KLmiiOwos/gpzDWQSsoZalQKxeHn/ZoJohXPoffNMw8=;
        b=jqlLqBc+zeorbVnReyYDZ/03k8PSJFrlsgLk8pb0uSjYBmMJPQJx4HV13xXAVbrcda
         qs/LUoWYs0evoZ9TdvU8NiZ2t5XLLs2D4LxWOPKTlBm7AHxBSVywiBBOAqnlqf4+WNVZ
         UwV6zDtBGbRTcFOc/dhDKK5k8Ugaov2X61y7vjMbOesZe9e5iNa8eeO5TFMh5Z6mb6KN
         5qTztaVZpix1yqGYVifwpKlk/rwANqB566wkhU8vQ3Iy5LWwCFa4vOCV0DHLdfX1/96e
         vZhkjHs8PjKSriPajwSs6obg4k0pqahnitcDEbJN6KH/JVvBTLpxN3NnMI3LSO11OjB8
         pCvg==
X-Gm-Message-State: AOAM532vC/igQGLI3mY75/9qHKs8dZciFTzaLFYc8wZxaQM8evrNnbRB
        OupHdHaE8adC5Ec6AVOBzXE2odjQ7Z+2uw==
X-Google-Smtp-Source: ABdhPJxkT1ZD7A1GC0vU40sBe4SQcl1u3N0tXYJ/jc/ABQ5J40fTnUYKhMBzhYdEu6GAqgdhW1bAIA==
X-Received: by 2002:a37:64ca:: with SMTP id y193mr25990770qkb.367.1592401031383;
        Wed, 17 Jun 2020 06:37:11 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o6sm17782242qtd.59.2020.06.17.06.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 06:37:10 -0700 (PDT)
Subject: Re: [PATCH 2/4] btrfs: detect uninitialized btrfs_root::anon_dev for
 user visible subvolumes
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20200616021737.44617-1-wqu@suse.com>
 <20200616021737.44617-3-wqu@suse.com>
 <d17609b5-ac29-937c-763d-fc978e3f1bad@toxicpanda.com>
 <f1f940ba-3f1d-302a-0d28-5620286bcdc0@gmx.com>
 <a7417666-56a0-be6a-1691-e647802e1df7@toxicpanda.com>
 <0e274dc7-ac05-078a-2a2c-348e72745d45@suse.com>
 <20200617113109.GK27795@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e665ed96-63f1-ae72-15dd-ba8d75288568@toxicpanda.com>
Date:   Wed, 17 Jun 2020 09:37:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617113109.GK27795@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/17/20 7:31 AM, David Sterba wrote:
> On Wed, Jun 17, 2020 at 07:49:33AM +0800, Qu Wenruo wrote:
>>>>> Can we handle stat->dev not having a device set?  Or will this blow up
>>>>> in other ways?  Thanks,
>>>>
>>>> We can handle it without any problem, just users get confused.
>>>>
>>>> As a common practice, we use different bdev as a namespace for different
>>>> subvolumes.
>>>> Without a valid bdev, some user space tools may not be able to
>>>> distinguish inodes in different subvolumes.
>>>>
>>>
>>> Alright that's fine then.  But I feel like stat is one of those things
>>> that'll flood the console, can we put this somewhere else that's going
>>> to be hit less? Thanks,
>>
>> Unfortunately, stat() is the only user of btrfs_root::anon_dev.
>>
>> While fortunately, the logical is pretty simple, even without the safe
>> net we can understand the lifespan pretty well.
>>
>> I'm fine to drop this patch if you're concerned about the possible
>> warning flood, as the benefit is really not that much.
> 
> It could be a developer-only warning but if there's a root with a bad
> anon_dev, a simple 'ls -l' would flood the log for sure.
> 

We'll know in btrfs_init_fs_root() when get_anon_bdev() fails right?  Can't we 
just complain then?  That seems less spammy.  Thanks,

Josef
