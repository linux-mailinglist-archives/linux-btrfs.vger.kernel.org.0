Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E8A2127E0
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 17:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbgGBP2e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 11:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbgGBP2e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 11:28:34 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1955DC08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 08:28:34 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 145so23507059qke.9
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 08:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=bOzkd+keL2M7iALCY9XTBpuJ93F0KAleuTGIE3tJkUE=;
        b=eAGgzU1tO3riAxN0ILSmw+6PQVvsD0nN/qOabcWrF81WGaQHfER9ZkCJm3072GyNgZ
         BLJcXOePx3uPLlovfNkpIqJdCxqvVDXKpJnpL3fJzsq/XPmyUgXdESVkYIpuskLQUoHa
         DlCgAlAigMqe/zcSI0V1ezj4ulRMclGHtzPZ6ZIf+lViXc/pBvV1cjiNLnoBAvH9sDgP
         RmBr9f3Qhlu9x0QaPoUZnp3vSEMoikZJSl0YiCCywg0I0f1yboS1up4RpihnsscYr/PK
         UKTgslaNUh4tp7UThZETsIwkbSLxxPhjnhVaDibxql6Yto7/aammw2QAe67BdfK2c5dF
         JnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bOzkd+keL2M7iALCY9XTBpuJ93F0KAleuTGIE3tJkUE=;
        b=GFf462x2pBMrtnBnMGu6fWTm/IbtAHFwIpl+ydW06U2oUX1tVRzYtvXpumVXoBtQU/
         z3BWe1IJ9V5DlI3z1utvTi26/4Xv+JBvwKVxnBihW11Tx9fq+80BbMaiFeAeccsn+YVe
         f1w4yRgT5egoTKRxTY5GpXSCKo63OS8N9+JcF3NeYZwev3w/GTmCr6YnKb8aJxj8gXg3
         3EIsTpyOmubNolag/qSEfivZ9JK5UfbpBc3XmPi3F+JAyhesXxuF0EOHaFrBbtm/uCQ5
         i/zNo5fpPaeIVprIEBexYoS/FW4a32ilgUd/TuTBhQi7eno8rRpszCY2iXOi4QBzheuO
         PpxA==
X-Gm-Message-State: AOAM531HhwQ+kzTtOLYwGwj4UHrGQ9gfx/lm3jQRph6mr7ZedRKf087J
        CH1xO1tSNtHh17nvrr8WYkrnaA==
X-Google-Smtp-Source: ABdhPJySbtSWJ1KuziJ91XAV2lBSBndRKCFD/E/ZG1D6cyXkPi3PPbpTYv8dgpSCkUALza5C4pAVpg==
X-Received: by 2002:a37:88c2:: with SMTP id k185mr19713553qkd.53.1593703713128;
        Thu, 02 Jul 2020 08:28:33 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e129sm8610410qkf.132.2020.07.02.08.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 08:28:32 -0700 (PDT)
Subject: Re: [PATCH][RFC] btrfs: introduce rescue=onlyfs
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, waxhead@dirtcellar.net,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200701144438.7613-1-josef@toxicpanda.com>
 <4adbc15c-d8ff-6132-5044-9b6117ef4f5e@dirtcellar.net>
 <bf383512-71fd-27b1-2e45-b8a0c8e2ba3f@toxicpanda.com>
 <e0294251-606e-b08f-6df7-20a225de8630@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2630e0b0-00a4-6258-f253-cbc6f0fb9847@toxicpanda.com>
Date:   Thu, 2 Jul 2020 11:28:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <e0294251-606e-b08f-6df7-20a225de8630@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/1/20 11:09 PM, Qu Wenruo wrote:
> 
> 
> On 2020/7/2 上午3:53, Josef Bacik wrote:
>> On 7/1/20 3:43 PM, waxhead wrote:
>>>
>>>
>>> Josef Bacik wrote:
>>>> One of the things that came up consistently in talking with Fedora about
>>>> switching to btrfs as default is that btrfs is particularly vulnerable
>>>> to metadata corruption.  If any of the core global roots are corrupted,
>>>> the fs is unmountable and fsck can't usually do anything for you without
>>>> some special options.
>>>>
>>>> Qu addressed this sort of with rescue=skipbg, but that's poorly named as
>>>> what it really does is just allow you to operate without an extent root.
>>>> However there are a lot of other roots, and I'd rather not have to do
>>>>
>>>> mount -o rescue=skipbg,rescue=nocsum,rescue=nofreespacetree,rescue=blah
>>>>
>>>> Instead take his original idea and modify it so it just works for
>>>> everything.  Turn it into rescue=onlyfs, and then any major root we fail
>>>> to read just gets left empty and we carry on.
>>>>
>>>> Obviously if the fs roots are screwed then the user is in trouble, but
>>>> otherwise this makes it much easier to pull stuff off the disk without
>>>> needing our special rescue tools.  I tested this with my TEST_DEV that
>>>> had a bunch of data on it by corrupting the csum tree and then reading
>>>> files off the disk.
>>>>
>>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>>> ---
>>>
>>> Just an idea inspired from RAID1c3 and RAID1c3, how about introducing
>>> DUP2 and/or even DUP3 making multiple copies of the metadata to
>>> increase the chance to recover metadata on even a single storage device?
>>
>> Because this only works on HDD.  On SSD's concurrent writes will often
>> be shunted to the same erase block, and if the whole erase block goes,
>> so do all of your copies.  This is why we default to 'single' for SSD's.
>>
>> The one thing I _do_ want to do is make better use of the backup roots.
>> Right now we always free the pinned extents once the transaction
>> commits, which makes the backup roots useless as we're likely to re-use
>> those blocks.
> 
> IIRC Filipe tried this before and didn't go that direction due to ENOSPC.
> As we need to commit multiple transactions to free the pinned extents.
> 
> But maybe the latest async pinned extent drop could solve the problem?
> 

Yeah before it was tricky, but with Nikolay's work it made async pinned extent 
drop possible, I've been testing that patch internally.

Now it's just a matter of keeping the last 4 transactions worth of pinned around 
and only unpinning under enospc conditions.  I'll dig out the async unpinning 
and send that up next week since that's already valuable by itself, and then we 
can talk about wiring up the ENOSPC part of it.  Thanks,

Josef

