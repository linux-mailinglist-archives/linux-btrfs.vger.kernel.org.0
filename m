Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C594676729F
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 19:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbjG1RBE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jul 2023 13:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjG1RBD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jul 2023 13:01:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CAEFA
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 10:01:00 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f13c41c957so725818e87.1
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 10:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690563659; x=1691168459;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NwF5jc7VsboInDjakMFTvHLOCymVRMRmmeIY9NvlTuI=;
        b=GtJmo4GZz2CDEsoXgHgULzLvrnc0LC6YzsT4By9plJSwjGDwBdQZMlyqMO43EHi578
         ixyMt+5XMu+izovUnYQajBmdUuoTIfG+jfLpdfFQDIAoeXI7GOeEqWnXkzQDcQACaY3C
         dqatC4HHYYk1MOFygMeh4a8cJIZ1TV3d5ftjDjQbW51zBbHB7WzcXGHtzZlM2q/q8R3C
         Ul8ar5JUeRyr83dgbeNp5L1ECry1K5zBk+ZhmC5moLG5HjL9fhiVAx/rVKdef6a0kdlg
         LibBeIratnVSZOhrR2veyXbIAxdptDyHamVIIrPR31YUCt8TtpEGvQm4yrZivy+7zOX0
         Jcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690563659; x=1691168459;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwF5jc7VsboInDjakMFTvHLOCymVRMRmmeIY9NvlTuI=;
        b=TgEsBDZrXGxGsXFDoLkDHjpqP2/n5/+7CkROKt4wjvCAM6zctS6gRfZPiH4tftSZlr
         YxGveEgv4VlGxdSlDB2kTQ0XFsruj946QM4Pqx6FuaLuPEF1eCcJumUvpnv6Q2nyZq2V
         5P6eQ9md6U3X7mmoZLZQsJVJothUBNPkoUG79QcYgK5D8kaH3YaUT2baE6NueMVPmslj
         aq6po8u8hUs2sAgkDFwO/MTHNUFdCWlqr2lPfwoD7ejzabnRcwhJaTMjPxWrmQ3PpNT3
         qUBpmFpfUn+PPRn9O/vQuIhgH1WmkaH2oBK8bM7tWuUJ4NLAuFdBtK/QGUdkMWs2wzGn
         nvcQ==
X-Gm-Message-State: ABy/qLYU3FNelCTQG7VT4+RhYxze/UC7cmthIfcQu09B2LlnRN9VGKvo
        pJGlRkYtfHE1T3I9s9DxHEDpGpXG9WM=
X-Google-Smtp-Source: APBJJlEIbDN/BMI2D6w6cOpn8+FOSv2NkhsVACC3lNRBX5cpA8BgxLvkN5aY2tVFzS5BKEZuxGGKyw==
X-Received: by 2002:ac2:51bb:0:b0:4fb:7381:952e with SMTP id f27-20020ac251bb000000b004fb7381952emr39015lfk.2.1690563658697;
        Fri, 28 Jul 2023 10:00:58 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:2474:b66c:bdcf:94f1:a4a3? ([2a00:1370:8180:2474:b66c:bdcf:94f1:a4a3])
        by smtp.gmail.com with ESMTPSA id u24-20020ac243d8000000b004fe142afd1esm871874lfl.152.2023.07.28.10.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 10:00:58 -0700 (PDT)
Message-ID: <333b028f-a916-ccf9-8339-408b8963fd8e@gmail.com>
Date:   Fri, 28 Jul 2023 20:00:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Drives failures in irregular RAID1-Pool
Content-Language: en-US
To:     Stefan Malte Schumacher <s.schumacher@netcologne.de>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAA3ktqkR_hk++GpHM1oLUVto139oUOMLH92GPepQMA4M7-wdYQ@mail.gmail.com>
 <ec55663e-7655-a201-fc2c-6d64193e9fc7@gmail.com>
 <CAA3ktqmUXi3phYodmV7q8HQ4XvDvWo8q59z0UbR5TkQWcf5a=w@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <CAA3ktqmUXi3phYodmV7q8HQ4XvDvWo8q59z0UbR5TkQWcf5a=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28.07.2023 18:26, Stefan Malte Schumacher wrote:
> Thanks for the quick reply. Is there any way for me to validate if the
> filesystem has redundant copies of all my files on different drives?

I can only think of "btrfs scrub".

> I read that it was suggested to do a full rebalance when adding a
> drive to a RAID5 array. Should I do the same when adding a new disk to
> my array?
> 

I do not know where you read it and I cannot comment on something I have 
not seen. But for RAID1 I do not see any reason to do it.

> Yours sincerely
> Stefan
> 
> Am Fr., 28. Juli 2023 um 17:22 Uhr schrieb Andrei Borzenkov
> <arvidjaar@gmail.com>:
>>
>> On 28.07.2023 16:59, Stefan Malte Schumacher wrote:
>>> Hello,
>>>
>>> I recently read something about raidz and truenas, which led to me
>>> realizing that despite using it for years as my main file storage I
>>> couldn't answer the same question regarding btrfs. Here it comes:
>>>
>>> I have a pool of harddisks of different sizes using RAID1 for Data and
>>> Metadata. Can the largest drive fail without causing any data loss? I
>>> always assumed that the data would be distributed in a way that would
>>> prevent data loss regardless of the drive size, but now I realize I
>>> have never experienced this before and should prepare for this
>>> scenario.
>>>
>>
>> RAID1 should store each data copy on a different drive, which means all
>> data on a failed disk must have another copy on some other disk.
>>
>>> Total devices 6 FS bytes used 27.72TiB
>>> devid    7 size 9.10TiB used 6.89TiB path /dev/sdb
>>> devid    8 size 16.37TiB used 14.15TiB path /dev/sdf
>>> devid    9 size 9.10TiB used 6.90TiB path /dev/sda
>>> devid   10 size 12.73TiB used 10.53TiB path /dev/sdd
>>> devid   11 size 12.73TiB used 10.54TiB path /dev/sde
>>> devid   12 size 9.10TiB used 6.90TiB path /dev/sdc
>>>
>>> Yours sincerely
>>> Stefan Schumacher
>>

