Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7622775A20B
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 00:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjGSWhP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jul 2023 18:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGSWhO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jul 2023 18:37:14 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E882127
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 15:37:00 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b898cfa6a1so227145ad.1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 15:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689806220; x=1690411020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UX24aPxbpT4tD7x83J9ER1m4mBngi5qdS7YpJmQ4Ng4=;
        b=xr6ERvlGECC6cvkvD3z/CK0MzHM6phW6OHoieJXm4pkycClNqPhTUZQQgaFmwRrTDH
         ZjBQ5et+VErDjm08jXy/BktrGvNxJBf/VpFhWNv15jsVqVwocvtn0lTznyX+mF4FDbwN
         WrYkqOlV3biUa1m/x4Fq5wgYvneFAUmGGegUVNXy3KrwQYWezKZYppkSL4HoEq5q6e1O
         NUGh9FhKa02+A4KbaSYuD6iuHZ//PtLFZDb+tU4ZaqGF2G5qGjUowwpkp+XdHiAT15zN
         idrbro7QTl4MmG6/PdCgo0Q/o/a+yAb7nd6BMJlKTGWehB3Hvwec5Cwx010aJ9JMNq6B
         JpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689806220; x=1690411020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UX24aPxbpT4tD7x83J9ER1m4mBngi5qdS7YpJmQ4Ng4=;
        b=Csl43cRaWTb3upUhDqrGZRXTH9soCopiK/KBxtSono8v0Bt0QLLvsI+HKz3C0wqQT/
         RUnrRd0FFVSFiaLm6SW+wYINKicsixYMuam//5VWCq3o0q4c2gzdLD7xsNi0sbGXlF/+
         35+4nzpojTWSWdiIOPmdtSyWCy+TfAUfkhHC3DUsPo1+x2KjosENgk/cJOQd+BrDxvts
         URnOMIA8dkKTndiA3BQrQlkV5jwaITeAtT0Aik5at1VCbqfZgQ8z8tYMwbzYIUrlsIrx
         dMcvASkdUpJjFBLRokpguNrblVilG7sYN4/OoqjzB3VgnDTD04WNatvp/+TTBxrF9ALH
         QzeQ==
X-Gm-Message-State: ABy/qLYmSxRh1dS7UcbpWxu28FERrFjC9LgaW0tEX9ISsbK06ULB0Uhk
        Mt96Qgz6hPEjvwCjt49YIUOCDQ==
X-Google-Smtp-Source: APBJJlEVoyxCUn77svULLnPM/p95VpcuyLOu5fuYL6dsJ76tetO8xsi8b7J8I+dq4FKCOKiFga22Zw==
X-Received: by 2002:a17:902:ec8b:b0:1b3:d8ac:8db3 with SMTP id x11-20020a170902ec8b00b001b3d8ac8db3mr17070312plg.6.1689806219777;
        Wed, 19 Jul 2023 15:36:59 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902a50a00b001a69dfd918dsm4530763plq.187.2023.07.19.15.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 15:36:58 -0700 (PDT)
Message-ID: <b6d1ace1-2ba1-5ef4-5641-3813f9c1a90a@kernel.dk>
Date:   Wed, 19 Jul 2023 16:36:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] btrfs: scrub: speed up on NVME devices
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Martin Steigerwald <martin@lichtvoll.de>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <ef3951fa130f9b61fe097e8d5f6e425525165a28.1689330324.git.wqu@suse.com>
 <6c9a9e34-365a-3392-0289-a911b34a9e4d@gmx.com>
 <4f48e79c-93f7-b473-648d-4c995070c8ac@gmx.com>
 <1921732.taCxCBeP46@lichtvoll.de>
 <ffb05334-b3ee-3a74-8c07-84afa2e62932@kernel.dk>
 <2f0d357e-88bd-d824-872e-8ec3d0e40af2@gmx.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2f0d357e-88bd-d824-872e-8ec3d0e40af2@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/19/23 4:30?PM, Qu Wenruo wrote:
> 
> 
> On 2023/7/19 22:59, Jens Axboe wrote:
>> On 7/19/23 1:27?AM, Martin Steigerwald wrote:
>>> Hi Qu, hi Jens.
>>>
>>> @Qu: I wonder whether Jens as a maintainer for the block layer can shed
>>> some insight on the merging of requests in block layer or the latency of
>>> plugging aspect of this bug.
>>>
>>> @Jens: There has been a regression of scrubbing speeds in kernel 6.4
>>> mainly for NVME SSDs with a drop of speed from above 2 GiB/s to
>>> sometimes even lower than 1 GiB/s. I bet Qu can explain better to you
>>> what is actually causing this. For reference here the initial thread:
>>>
>>> Scrub of my nvme SSD has slowed by about 2/3
>>> https://lore.kernel.org/linux-btrfs/
>>> CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com/
>>>
>>> And here another attempt of Qu to fix this which did not work out as well
>>> as he hoped:
>>>
>>> btrfs: scrub: make sctx->stripes[] a ring buffer
>>>
>>> https://lore.kernel.org/linux-btrfs/cover.1689744163.git.wqu@suse.com/
>>>
>>> Maybe Jens you can share some insight on how to best achieve higher
>>> queue depth and good merge behavior for NVME SSDs while not making the
>>> queue depth too high for SATA SSDs/HDDs?
>>
>> Didn't read the whole thread, but a quick glance at the 6.3..6.4 btrfs
>> changes, it's dropping plugging around issuing the scrub IO? Using a
>> plug around issuing IO is _the_ way to ensure that merging gets done,
>> and it'll also take care of starting issue if the plug depth becomes too
>> large.
> 
> Thanks, I learnt the lesson by the harder way.
> 
> Just another question related to plugs, the whole plug is per-thread
> thing, what if we're submitting multiple bios across several kthreads?
> 
> Is there any global/device/bio based way to tell block layer to try its
> best to merge? Even it may means higher latency.

Right, the plug is on-stack for the submitting process. It's generally
pretty rare to have cross-thread merges, at least for normal workloads.
But anything beyond the plug for merging happens in the io scheduler,
though these days with devices having high queue depth, you'd have to be
pretty lucky to hit that. There's no generic way to hold off.

Do you have multiple threads doing the scrubbing? If yes, then my first
question would be why they would be working in areas that overlap to
such an extent that cross thread merging makes sense? And if there are
good reasons for that, and that's an IFF, then you could queue pending
IO locally to a shared list, and have whatever thread grabs the list
first actually perform all the submissions. That'd be more efficient
further down too.

-- 
Jens Axboe

