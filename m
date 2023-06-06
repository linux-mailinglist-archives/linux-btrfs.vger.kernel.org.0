Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D025C723675
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 06:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjFFErK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 00:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFFErJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 00:47:09 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5C3109
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 21:47:07 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b1a4d74f7fso7675731fa.0
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jun 2023 21:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686026826; x=1688618826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=quLGHMzSUmPcGTJZmJVbY4jeHMTjBeF396OsxxJs/QU=;
        b=cNmiH2ZUPth1zqy6QA16g/nxIjx8mcySp/bghfbRnTAEjb+pPjJqAylNspGWuDUew+
         p3z+Qya/MU8J5x39SCx6zCr0sphwFFAuPrWLQr4Y/aR5cd/n74AoWOU00oLSYJAO7Zp5
         0H/GFOHvHhajCFlq5WbLPXFQ5TDH4h2xytEIWnB1qHBYc3cJ0En2/+VpNm9sQTn2Tv/5
         sYz77EuI12LdK15UEYCjQ/WH1T3O1uSQkNxiRHgqSajIGXNpLaeLAL/i/A5e97Pbah3E
         TZWKGgG2Q/id+hjz8fXndTe9b9z+tLMD6O9kqDG52Fl/YiS1oLBGY1+emiospWOoe6Wz
         pY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686026826; x=1688618826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quLGHMzSUmPcGTJZmJVbY4jeHMTjBeF396OsxxJs/QU=;
        b=axyXIc25+vMDmLk4uw7ZbDD/lO/QlNcrhlBQdx8nvKpP3NrY9YJAifG9Pyrub1KpMa
         bVMsGc717qMl4s16I9Dtg9YXItmj5OjLkxGn1RuL58MIqTc/W7heYDrg1nDjjGze4GyU
         WwKdoJll0aZCz+jGTbUXT6uAnRotEiacbFLf9nIEmMQ0fs4gwqTIASBe2vmEVzGBW6Bx
         ZooNtixniLz9moF4hE+b9v0+EVQb6yic7hR+10O3fFxJDlc42wiLTCMSUBTqe0nIEoZS
         cS965H+GNG8wlkk6Y4zvk4FB0ZU2+qsRrk1dbQ2/UyQp9eESHnV0ja9VUJ69JmrDIgDK
         5oag==
X-Gm-Message-State: AC+VfDygdYmvp89p8o0OK+n1JOBovIPLXTTR+NFl92JluD44fXxqPCzg
        57rkDXneNPHo/jUWH8wPQfK3otd2Rf8=
X-Google-Smtp-Source: ACHHUZ64RkAwtsXWzqBcPw0PRivr+ODlyPQYin8CWNDKahuDZiKk9HhIBZDsKReTX9FApOweivNzRw==
X-Received: by 2002:a05:651c:3c2:b0:2b1:d8fa:3e59 with SMTP id f2-20020a05651c03c200b002b1d8fa3e59mr500097ljp.4.1686026825403;
        Mon, 05 Jun 2023 21:47:05 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:1d8:d636:e803:d06:4133? ([2a00:1370:8180:1d8:d636:e803:d06:4133])
        by smtp.gmail.com with ESMTPSA id y21-20020a2e8295000000b002ad8fc8dda6sm1687473ljg.17.2023.06.05.21.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 21:47:04 -0700 (PDT)
Message-ID: <295ce1bb-bcd7-ebdf-96b2-230cfeff5871@gmail.com>
Date:   Tue, 6 Jun 2023 07:47:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: How to find/reclaim missing space in volume
Content-Language: en-US
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20230605162636.GE105809@merlins.org>
 <9bfa8bb6-b64e-d34f-f9c8-db5f9510fc29@gmail.com>
 <20230606014636.GG105809@merlins.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <20230606014636.GG105809@merlins.org>
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

On 06.06.2023 04:46, Marc MERLIN wrote:
> On Mon, Jun 05, 2023 at 08:00:02PM +0300, Andrei Borzenkov wrote:
>> On 05.06.2023 19:26, Marc MERLIN wrote:
>>> I have this:
>>> sauron [mc]# df -h .
>>> Filesystem         Size  Used Avail Use% Mounted on
>>> /dev/mapper/pool2  1.1T  853G  212G  81% /mnt/btrfs_pool2
>>> sauron [mc]# btrfs fi show .
>>> Label: 'btrfs_pool2'  uuid: fde3da31-67e9-4f88-b90d-6c3f6becd56a
>>> 	Total devices 1 FS bytes used 847.89GiB
>>> 	devid    1 size 1.04TiB used 890.02GiB path /dev/mapper/pool2
>>> sauron [mc]# btrfs fi df .
>>> Data, single: total=878.00GiB, used=843.85GiB
>>> System, DUP: total=8.00MiB, used=128.00KiB
>>> Metadata, DUP: total=6.00GiB, used=4.04GiB
>>> GlobalReserve, single: total=512.00MiB, used=0.00B
>>>
>>
>> btrfs filesystem usage -T is usually more useful than both the above
>> commands.
> sauron:/mnt/btrfs_pool2# btrfs fi usage -T .
> Overall:
>      Device size:		   1.04TiB
>      Device allocated:		 890.02GiB
>      Device unallocated:		 177.73GiB
>      Device missing:		     0.00B
>      Used:			 851.85GiB
>      Free (estimated):		 211.93GiB	(min: 123.07GiB)
>      Data ratio:			      1.00
>      Metadata ratio:		      2.00
>      Global reserve:		 512.00MiB	(used: 0.00B)
> 
>                       Data      Metadata System
> Id Path              single    DUP      DUP       Unallocated
> -- ----------------- --------- -------- --------- -----------
>   1 /dev/mapper/pool2 878.00GiB 12.00GiB  16.00MiB   177.73GiB
> -- ----------------- --------- -------- --------- -----------
>     Total             878.00GiB  6.00GiB   8.00MiB   177.73GiB
>     Used              843.79GiB  4.03GiB 128.00KiB
> 
>>> sauron:/mnt/btrfs_pool2# du -sh *
>>> 599G	varchange2
>>> 598G	varchange2_ggm_daily_ro.20230605_07:57:43
>>> 4.0K	varchange2_last
>>> 599G	varchange2_ro.20230605_08:01:30
>>> 599G	varchange2_ro.20230605_09:01:43
>>>
>>> I'm confused, the volumes above are snapshots with mostly the same data
>>> (made within the last 2 hours) and I didn't delete any data in the FS
>>> (they are mostly identical and used for btfrs send/receive)
>>>
>>> Why do they add up ot 600GB, but btrfs says 847FB is used?
>>>
>>
>> Each subvolume references 600G but it does not mean they are the same 600G.
>> If quota is enabled, "btrfs quota show" may provide some more information,
>> otherwise "btrfs filesystem du" shows shared and exclusive space (you need
>> to pass all subvolumes in question to correctly compute shared vs
>> exclusive).
> 
> Right, I did check/know that the snapshots shared the same data, but it
> doens't hurt to confirm:
> 
> sauron:/mnt/btrfs_pool2# btrfs filesystem du -s *
>       Total   Exclusive  Set shared  Filename
>   597.57GiB    20.00KiB   588.75GiB  varchange2
>   597.57GiB     4.00KiB   588.75GiB  varchange2_ggm_daily_ro.20230605_09:59:26
>   597.57GiB       0.00B   588.75GiB  varchange2_last
>   597.57GiB     4.00KiB   588.75GiB  varchange2_minly.20230605_17:30:33
>   597.57GiB       0.00B   588.75GiB  varchange2_minly.20230605_17:35:32
>   597.57GiB       0.00B   588.75GiB  varchange2_minly.20230605_17:40:32
>   597.57GiB     4.00KiB   588.75GiB  varchange2_minly.20230605_17:45:32
>   597.57GiB     4.00KiB   588.75GiB  varchange2_minly.20230605_17:50:32
>   597.57GiB     4.00KiB   588.75GiB  varchange2_minly.20230605_17:55:32
>   597.57GiB       0.00B   588.75GiB  varchange2_minly.20230605_18:00:32
>   597.57GiB       0.00B   588.75GiB  varchange2_minly.20230605_18:05:32
>   597.57GiB     8.00KiB   588.75GiB  varchange2_minly.20230605_18:10:32
>   597.57GiB    16.00KiB   588.75GiB  varchange2_ro.20230605_10:01:40
>   597.57GiB    12.00KiB   588.75GiB  varchange2_ro.20230605_11:01:31
>   597.57GiB     4.00KiB   588.75GiB  varchange2_ro.20230605_13:01:28
>   597.57GiB     4.00KiB   588.75GiB  varchange2_ro.20230605_14:01:30
>   597.57GiB     4.00KiB   588.75GiB  varchange2_ro.20230605_15:01:29
>   597.57GiB     4.00KiB   588.75GiB  varchange2_ro.20230605_16:01:32
>   597.57GiB     4.00KiB   588.75GiB  varchange2_ro.20230605_17:01:31
>   597.57GiB       0.00B   588.75GiB  varchange2_ro.20230605_18:02:02
> sauron:/mnt/btrfs_pool2# df -h .
> Filesystem         Size  Used Avail Use% Mounted on
> /dev/mapper/pool2  1.1T  853G  212G  81% /mnt/btrfs_pool2
> 
> 

Well, I have had it once, there were deleted but not freed subvolumes

https://lore.kernel.org/linux-btrfs/ecd46a18-1655-ec22-957b-de659af01bee@gmx.com/T/
