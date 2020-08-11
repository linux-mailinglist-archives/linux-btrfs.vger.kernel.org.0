Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA62241E86
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 18:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgHKQn4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 12:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgHKQn4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 12:43:56 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152BFC06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 09:43:56 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l23so9555950edv.11
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 09:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=qMG8R6QeTEnMe+goMIY1bXKQ6ewGmOAYHZBFQT/chAM=;
        b=QQKE5LEhPi5Y2TJwcKK+7vsar8c8Sh/RlNGtfmlM1Knd7896h7YPZNBJGcEIspea3p
         /bExeVFtsUvg2UO/cbouNuvoNwpmB+DsomZcog9F3bbkFOHrb6HGoobLa78RxidDODuG
         z0AH5oFaq08iN/rpBb/pL0RRIznftK1Nafs3LYlGjogMApgA22bYPQKzYf6ioIQcr0YQ
         KCb3WFoJ4RKjWJZdLbc88W8ch56CtHoKjJTpHNqA8mVh8yzDt92ZNt3zzKsHoduInD8K
         cTZkCYqB9J8kKGNH0hXeM/bONNQnfB8+xN7GPt8J8h+dMWZ9BAQaaG2U1r/FZ4RY32q5
         0MxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qMG8R6QeTEnMe+goMIY1bXKQ6ewGmOAYHZBFQT/chAM=;
        b=rOpQO9pHerRWhQQtTv1bECtcIZbCovYzbjPZgV1FkHHJs0m7RdozJVPVe2Le7cnBaS
         P4Sy/dDb7xu7zuWuBvU7Whvxj88SQCZbij5mCY/h8Q21ReH2VkW10QCvYFFro+EFt9eb
         B00a+J9eO5APlx2d1JX0nvIj3sBLu4u/YMFq/6m0iTnyqcwJoXPU8Dv7wJJjcqQEEEOb
         r9HGu1Y6DSMb/ebg84Nx0CviHQHHSabpYsxT9Uw9NxPh/oT+kliDItE8xFM+XNpJbvqS
         JHpeAmbJNaoi4RlMmpL5klhk2cV02ULcQIfxhnfOIFYa7XRGVwhvkJ1hZs91oVSkkZFd
         Rrvg==
X-Gm-Message-State: AOAM533ZWu6x7BExpcWGdi9eoR8fkb7uOf1rZXyUW5e3zMZeH+Cl+ZaO
        cZae/oNGwU1wXr0dMcfnBtTb2k38hck=
X-Google-Smtp-Source: ABdhPJzzO1XuqT4cdQnMURJ66suOUBHeFzOYqr67YyW5HoX16st/VTKP76BM48KJBXazNgq7Z9u4gw==
X-Received: by 2002:aa7:d6c2:: with SMTP id x2mr26518580edr.332.1597164234301;
        Tue, 11 Aug 2020 09:43:54 -0700 (PDT)
Received: from ?IPv6:2003:d3:c718:e200:2039:39d8:7055:e09? (p200300d3c718e200203939d870550e09.dip0.t-ipconnect.de. [2003:d3:c718:e200:2039:39d8:7055:e09])
        by smtp.gmail.com with ESMTPSA id r25sm14944704edy.93.2020.08.11.09.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 09:43:53 -0700 (PDT)
Subject: Re: system hangs when running btrfs balance
From:   Johannes Rohr <jorohr@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <c684e9ac-f28b-7056-0a46-6c6450ac4c1f@gmail.com>
 <8a3370fd-7cda-78d2-b036-8350c5a3e964@gmx.com>
 <feffe90f-de6b-0f53-c54d-0df135c49868@gmail.com>
Message-ID: <10ac3036-52cc-3963-d55e-b8352388e1f6@gmail.com>
Date:   Tue, 11 Aug 2020 18:43:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <feffe90f-de6b-0f53-c54d-0df135c49868@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear Qu, dear all,

hat the fix also been backported to the 5.6 kernel series? If so, from
which version on?

Cheers,

Johannes


Am 10.08.20 um 22:23 schrieb Johannes Rohr:
> Thanks so much, Qu, for your advice and the background
>
> We had some issues with btrfs, but I definitely want to continue using
> it. So the incredible responsiveness of btrfs devs like you is
> definitely on the plus side..
>
> Apparently, Ubuntu is preparing a kernel update to v 5.4.54
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1889669 so our
> problem should be solved soon!
>
> Cheers,
>
> Johannes
>
>
> Am 10.08.20 um 11:59 schrieb Qu Wenruo:
>> On 2020/8/10 下午5:22, Johannes Rohr wrote:
>>> Dear devs,
>>>
>>> since I upgraded our system from Ubuntu 18.04 LTS to 20.04 LTS, the file
>>> system completely freezes when I run a btrfs balance on it. The only way
>>> to get a usable system for the time being is with the mount option
>>> "skip_balance".
>>>
>>> The server has a raid1 with 4 SSDs with 500 GB each. 
>>> [Sun Aug  9 12:21:35 2020] CPU: 1 PID: 4537 Comm: btrfs-balance Tainted: G           O      5.4.47 #1
>> A quick git log glance shows that, some reloc tree related fixes haven't
>> landed in v5.4.47.
>>
>> E.g. (commits are upstream commits, not stable tree commits)\
>>
>> 1dae7e0e58b484eaa43d530f211098fdeeb0f404 btrfs: reloc: clear
>> DEAD_RELOC_TREE bit for orphan roots to prevent runaway balance
>> 51415b6c1b117e223bc083e30af675cb5c5498f3 btrfs: reloc: fix reloc root
>> leak and NULL pointer dereference.
>>
>> And above fixes only landed in v5.4.54, so I guess you have to update
>> your kernel anyway.
>>
>>> There has been a related bug report at kernel.org for a year,
>>> https://bugzilla.kernel.org/show_bug.cgi?id=203405 and I have found
>>> similar reports here and there, some pertaining to quite old kernel
>>> versions, but we have only been hit with kernel 5.4. After this first
>>> occurred, I had no better luck though, with older kernels (4 something
>>> from Debian buster, also 4 something from Ubuntu 18.04).
>> Nope, the mentioned one is another bug, we had some clue on this, but
>> need some time to solve it.
>> (It's mostly related to some special timing in canceling, leading to
>> parted dropped trees).
>>
>>> Apart from fixing the underlying issue, would there be any wordaround
>>> for it?
>> Update your kernel to at least v5.4.54, then mount with skip_balance and
>> finally  "btrfs balance cancel <mnt>".
>> After that, doing whatever you like should be fine.
>>
>> I prefer to do a btrfs check on the unmounted or at least ro mounted fs
>> to ensure your fs is sane in the first place.
>>
>> Thanks,
>> Qu
>>
>>> Currently the balance for the fs is in suspended status. Since
>>> there is quite a few people who depend on this server, I can't just play
>>> around with it at random. That's why I am asking for advice here...
>>>
>>> Thanks so much for any suggestions you might have!
>>>
>>> Johannes
>>>
>
