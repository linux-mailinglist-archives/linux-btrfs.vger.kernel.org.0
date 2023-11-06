Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8DC7E2D5C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 20:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjKFT4m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 14:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjKFT4l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 14:56:41 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E078ADB
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 11:56:35 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-66d0169cf43so31921826d6.3
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Nov 2023 11:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699300595; x=1699905395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M9QJkU/H6ENjRuJPm48iDm2+DBWRdeuLU27PN7Z9ibk=;
        b=HoAOfWFJK7YnInbqpXquTO4YzJZHra7TZudx6G789Mc2qfI7oz88Mm+1oipTWW6poh
         njIuYgh44a8aWHOE/jm2lJ6vRftbvdWjIxifE5Yb4yUbNlqIeNLMXMs8nXJtLKDShaUG
         PSpBoTEVxIkElIo4YGUGN8qrYBqMVYIJR9DqmkQT5ihVbXNGVHgxEGsZcPLMCBY5NxOl
         Wdtk3Dav5Y8Vok7OorfWyuTHkXdKnzaztxDd27vkPmTt78jn0mjbuB3R5excqTbVZnZV
         JEhIuu0MIoIi/4xFUbAmUSTWrrZk0XQwH6gpYru9JSc+tILsZZtFhY8ichfH9tavEAYE
         WAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699300595; x=1699905395;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9QJkU/H6ENjRuJPm48iDm2+DBWRdeuLU27PN7Z9ibk=;
        b=JkZN3s5fX5RHop7xhaxHs9ZUtEYpeugFLLLSf8JyplhKl79VHI73M8FSfhIOdTNCT/
         M2/s4F8wd1RSI6iC0S9SUljAzZw70JmGPWe8GXVU2Rn05Ihev0eNf2ZM1echz+xqhKfl
         rpY+r6sVO8VinhxB2iGnqUbBir8v9cEoUgbOAgdFKyKvYmY1lewvJwWMj3v6qRfrTas3
         Tq0iCM3K+nHG/o+zP64rgAQc29ED/ZuwNlIqm+J3zWukbraZO5pCRLc4BxAb4LFb1PQ5
         yiP6hgV1oWtljIZNrJzJuFvqvP73nImeZLQVXBCWuKK/fgjysJ5EHWaoRTC4woWkn/fO
         Rt/g==
X-Gm-Message-State: AOJu0Yx9WN4VdXjuuAWno1WsDfofKFpALiHx3qC3D3OsDpLYBS8YKTNs
        ehj7Ats883PM/JPT3wiSkFE=
X-Google-Smtp-Source: AGHT+IFyBqxdwyT3cTSWN46aKKjYSSXL72t02FnduWbs4d8IHs0q9CDay2wFK+OBJ/TVBhKV/zbVNw==
X-Received: by 2002:a05:6214:1d06:b0:66f:bc3f:bd7 with SMTP id e6-20020a0562141d0600b0066fbc3f0bd7mr44294087qvd.27.1699300594850;
        Mon, 06 Nov 2023 11:56:34 -0800 (PST)
Received: from [192.168.1.1] (pool-100-16-13-166.bltmmd.fios.verizon.net. [100.16.13.166])
        by smtp.gmail.com with ESMTPSA id f7-20020a0cc307000000b0064f4e0b2089sm3721962qvi.33.2023.11.06.11.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 11:56:34 -0800 (PST)
Message-ID: <de206814-ab47-40da-8e35-370ec3633bd5@gmail.com>
Date:   Mon, 6 Nov 2023 14:56:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Can btrfs repair this ?
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        BTRFS Mailing-List <linux-btrfs@vger.kernel.org>
References: <9de00454-0cd9-4d2d-aed4-23490f7dde83@gmail.com>
 <bbda4275-a07e-4921-a9c0-5a3d34801ef5@gmx.com>
From:   Joe Salmeri <jmscdba@gmail.com>
In-Reply-To: <bbda4275-a07e-4921-a9c0-5a3d34801ef5@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 11/5/23 18:45, Qu Wenruo wrote:
>
>
> On 2023/11/6 07:08, Joe Salmeri wrote:
>> Hi,
>>
>> I was running openSUSE Tumbleweed build 20231001 when I first found this
>> issue but updated to TW build 20231031 the other day and it still
>> reports the same issue.
>>
>> Kernel 6.5.9-1 btrfsprogs 6.5.1-1.2 Device Samsung 860 EVO 500 GB
>> Partion #5 root btrfs filesystem, no RAID or other drives
>>
>> I run "btrfs device stats /" about once a week and no problems are
>> reported.
>>
>> I run "btrfs scrub start /"   regularly too and no problem are reported
>>
>> I ran "btrfs check --readonly --force /dev/sda5" the other day and got
>> the following errors:
>>
>>          Opening filesystem to check...
>>
>>          WARNING: filesystem mounted, continuing because of --force
>>          Checking filesystem on /dev/sda5
>>          UUID: 7591d83f-f78e-402b-afe5-fab23dad0ffe
>>          [1/7] checking root items
>>          [2/7] checking extents
>>          [3/7] checking free space cache
>>          [4/7] checking fs roots
>>          root 262 inode 31996735 errors 1, no inode item
>>                  unresolved ref dir 132030 index 769 namelen 36 name
>> 02179466-b671-4313-8fa5-0eb87d716f92 filetype 2 errors 5, no dir item,
>> no inode ref
>>                  unresolved ref dir 132030 index 769 namelen 36 name
>> 77ef9cd4-0efe-46af-bf7f-47f582851e16 filetype 2 errors 2, no dir index
>>          ERROR: errors found in fs roots
>>          found 33034690560 bytes used, error(s) found
>>          total csum bytes: 28819244
>>          total tree bytes: 986251264
>>          total fs tree bytes: 876134400
>>          total extent tree bytes: 62521344
>>          btree space waste bytes: 277302161
>>          file data blocks allocated: 141608800256
>>           referenced 39054090240
>>
>> Running "find -inum 31996735" identifies the item is is complaining
>> about as
>>
>>          /usr/bin/find: File system loop detected;
>> ‘./.snapshots/1/snapshot’ is part of the same file system loop as ‘.’.
>>          /usr/bin/find:
>> ‘./home/denise/.config/skypeforlinux/blob_storage/02179466-b671-4313-8fa5-0eb87d716f92’: 
>> No such file or directory
>>
>> Running "ls -al /home/denise/.config/skypeforlinux/blob_storage/" also
>> shows that this is correct item
>>
>>      drwx------ 1 denise joe-denise   72 Nov  1 22:49 .
>>      drwxr-xr-x 1 denise joe-denise 3.7K Nov  1 20:07 ..
>>      d????????? ? ?      ?             ?            ?
>> 02179466-b671-4313-8fa5-0eb87d716f92
>>
>> When I originally ran btrfs check there were actually a bunch of other
>> items listed, however, I have timeline snapshots turned on for the
>> /@home subvolume and all the other items were because of that item in
>> each of the other snapshots.
>>
>> I removed all the other "home" snapshots and now btrfs check only
>> reports that one item as shown above.
>>
>> I have heard that btrfs check --repair is generally not recommended but
>> I have been unable to find a way to have btrfs remove the item it is
>> complaining about.
>
> --repair can fix the problem.
>
> But for your particular problem, please also do a memtest just in case.
>
> This problem looks like a bad hash, which may be caused by memory 
> bitflip.
>
I ran the memtests last night multiple times and no problems reported.

I have heard that --repair usage is usually not recommended.

I cannot afford to have this system have to be rebuilt right now.

Is it definitely safe in this case ?   Otherwise, I would just ignore it 
since I know why it exists and that it is not a hw problem.

Since this is the root fs, I assume I have to boot a USB live 
environment and do the repair from there or can it be done on the 
mounted btrfs root fs with the --force option ?

>
>> I have tried rmdir, rm -rf, as well as find -inum 31996735 -delete and
>> all report the same issue with not found.
>>
>> If I understand correctly, the parent directory entry ( so
>> /home/denise/.config/skypeforlinux/blob_storage/ ) has the entry for
>> /home/denise/.config/skypeforlinux/blob_storage/02179466-b671-4313-8fa5-0eb87d716f92 
>> with inode of 31996735 but it doesn't really exist.
>>
>> I do not consider this a HW issue because btrfs stats, scrub, and smart
>> do not report any errors and I also track all the smart info ( health,
>> reallocated sector, wear leveling, etc ) for SSDs and there are no
>> errors reported and I am not having any other issues.
>>
>> I suspect that this occurred the other day when Skype crashed. The item
>> is not needed, I just cannot figure out how to remove it.
>>
>> So, is it possible for me to remove this item and if so how do I do it ?
>>
I find it interesting that interesting that I can remove a snapshot which contains the item using the normal delete snapshot functionality but that none of the built in tools have a way to do it.



-- 
Regards,

Joe

