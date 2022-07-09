Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CF656C5BE
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 03:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiGIBe4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 21:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGIBez (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 21:34:55 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5037378DF6
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 18:34:54 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id j1so277710qtv.4
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Jul 2022 18:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GDW0QOLARGppkbZeTkUYtx7NydK/YBTqyzhmqVqRdSs=;
        b=NeGHzIAtQWWLDCIShh17uy7znA/1W8fxbsaJHip+xYpPA8Td3bH8LM07k3nf7WNbl4
         SWZ0IFGFjYwdu1vxA3yXJDqg7Sj4goC0Ta6F/FdtOvQJoCkdrHAr+qPWLlCqtX/EfVYm
         5qD3iTfjVCM3pW8K+PsoLFUtQUm/HIk3c7w2Qg098aFXpb663ptkYqVy6FttPmYjZYZX
         0tAex5di+UdcA8l8WuxuQqh10hlIy8HC46alWB0I0BbUBvygzwcRmVAr3Y4cJ1uO2HDA
         N7WrWfMV0sjx6k91GhNkl+zHZz9S57meJfwq1f4x4duAo/8cI0k/9PZnJJ4XA5FQR9s9
         Pz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GDW0QOLARGppkbZeTkUYtx7NydK/YBTqyzhmqVqRdSs=;
        b=uU+eypc0uqqE9HJ8a1d5zAAZYw6JzWqY4vLA5k08IURg237heyUXO2N9B8w4yjEAH7
         K7DAhI8bWPQQuvtfeF3gStmBeVKWTBVND+XB8G4zGsLibae6XHDnpUBrJ+p54jt/jwHC
         NKSxl5pMpNQxg9ii8gU2NM2PtnN+JWfRscGePFv0jvHk8X/2fDS1xr3wH8bdeJggVgcJ
         a5lAkMZIDbHpbX0e0Du1N0FuISjJIT+yUIuNlFhzn8NGGurjN0z5OgXk0q9GWEwfvxrN
         wTCH9PVYZbBho58CeTv8m/dMymopcMg8pASKad+rZudK/rv47gTyxzPRZN0uM14Uojp5
         glWQ==
X-Gm-Message-State: AJIora9/av6AVGuj8qkAjhFG3XwLhyeTmj6XZcSmH2vjCCl/qQaLN6SK
        DBb0HkJGLf0nM5no5iYbUoc=
X-Google-Smtp-Source: AGRyM1sY8kLliorrpPWcAxguCLFlVWaw9VLhpY9iT/2sZmzShJxW4TJaeqdXuh4okU5+sZzHwBWv5A==
X-Received: by 2002:a05:6214:d0e:b0:473:16b:8953 with SMTP id 14-20020a0562140d0e00b00473016b8953mr5198080qvh.75.1657330493473;
        Fri, 08 Jul 2022 18:34:53 -0700 (PDT)
Received: from [10.5.100.6] (modemcable117.130-83-70.mc.videotron.ca. [70.83.130.117])
        by smtp.gmail.com with ESMTPSA id x15-20020ac84d4f000000b00304df6f73f0sm389337qtv.0.2022.07.08.18.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 18:34:52 -0700 (PDT)
Message-ID: <d7276c15-37d5-d4e5-cab5-0e2703216a95@gmail.com>
Date:   Fri, 8 Jul 2022 21:34:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: BTRFS critical (device md126): corrupt node: root=1
 block=13404298215424 slot=307, unaligned pointer, have 12567101254720864896
 should be aligned to 4096
Content-Language: en-CA
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <1d43c273-5af3-6968-de18-d70a346b51aa@suse.com>
 <BD6F70A8-17FB-40E3-87DE-E185049DEA2E@gmail.com>
 <c7c50f16-92de-c9d2-d665-40f9556c6c80@gmx.com>
From:   Denis Roy <denisjroy@gmail.com>
In-Reply-To: <c7c50f16-92de-c9d2-d665-40f9556c6c80@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Love to comply to run the latest version, but I past from my 
experiences. Maybe you could help me on update/upgrading so I can do the 
check. I trying to learn here, need some help

On 2022-07-08 3:04 a.m., Qu Wenruo wrote:
>
>
> On 2022/7/8 14:20, Denis Roy wrote:
>> Ok, great. How do I do that?
>
> Considering you're using a vendor specific firmware/hardware, I don't
> have any good suggestion, other than upgrade to the latest version the
> vendor provides, and hope they upgraded the kernel.
>
> Or you may want to jump into the rabbit hole of running a common distro
> on the NAS hardware so that you have full control of the system, but
> lose all the out-of-box experience provided by those NAS vendors.
>
>
> For the corrupted fs, you may want to run btrfs check (latest version
> recommended) and post it.
> Then we may be able to decide if the fs can be repaired properly.
>
> Thanks,
> Qu
>>
>> Sent from my iPhone
>>
>>> On Jul 8, 2022, at 2:01 AM, Qu Wenruo <wqu@suse.com> wrote:
>>>
>>> ﻿
>>>
>>>> On 2022/7/8 13:50, Denis Roy wrote:
>>>>      key (7652251795456 EXTENT_ITEM 72057594063093760) block 
>>>> 12567101254720864896 (383517494345729) gen 72340209471334675
>>>>      key (2959901138859622420 EXTENT_CSUM 3664676558733568) block 
>>>> 2234066886193184768 (68178310735876) gen 18374696375462128179
>>>>      key (1153765929541501184 EXTENT_CSUM 0) block 0 (0) gen 0
>>>>      key (0 UNKNOWN.0 0) block 0 (0) gen 0
>>>
>>> The above dump shows the tree node is completely corrupted by some 
>>> weird data.
>>>
>>> The offending slot is not aligned, and its offset (extent size for 
>>> EXTENT_ITEM) is definitely not correct.
>>>
>>> But the offset looks like a bitflip:
>>>
>>> hex(72057594063093760) = '0x100000001800000'
>>>
>>> Ignoring the high bit, 0x1800000 is completely sane for the size of 
>>> an data extent.
>>>
>>> The next slot even has incorrect type, (EXTENT_CSUM) should not 
>>> occur in
>>> extent tree, but this time I can not find a pattern in the corrupted 
>>> type.
>>>
>>> The offset, 3664676558733568, is also not aligned but without a 
>>> solid corruption pattern.
>>>
>>> And finally we have an UNKNOWN key, which should not occur there at 
>>> all.
>>>
>>>
>>> So this looks like that tree node is by somehow screwed up in the 
>>> middle.
>>> I don't have any clue how this could happen, but considering the 
>>> checksum still passed, it must happen at runtime.
>>>
>>>
>>> For now, I can only recommend to go kernel newer than 5.11 which 
>>> introduced mandatory write-time tree block sanity check, and should 
>>> reject such bad tree block before it can be written to disk.
>>>
>>> Thanks,
>>> Qu
