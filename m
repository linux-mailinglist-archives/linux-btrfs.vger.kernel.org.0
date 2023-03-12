Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741D96B6733
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Mar 2023 15:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCLOha (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Mar 2023 10:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCLOh3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Mar 2023 10:37:29 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12693525B
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Mar 2023 07:37:27 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id f19-20020a9d5f13000000b00693ce5a2f3eso5466550oti.8
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Mar 2023 07:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678631847;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9INM4TDTMAD9Gf9W1iTVuuHtXKjZdr038kwz9Q3ffwU=;
        b=TyFz8Tl95qzNc4fzLEInwXyATXRNHR+tP/f8Q+3bPiD6qQXxzNPKxifjJ0z0IDd/xB
         ljSvcYGSnZf5om8B3HGVhRvkOgI3Q7CK9lLs4sXeTT/b9Aov1UpiYCuvzAB6QRngm0TP
         qudycnJJ0g1NTqv+WsORVEKSfnpsWIK8cfEUh+pUzjgUElSAbP8FYYGNURf5Ykorv53V
         SohZKsmY84MDWJHfkfEvn3NMQZgY4MkIt3ZfYSRJZ//zX0xQY2wKjTISOkfpfpQcUa2n
         /vMWrf0qTeNDD5YbgBHRwzGwct2aZe42I9Mo4bdYfG74Xxe//2BDTjzdU/jXdyw5vxnE
         YV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678631847;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9INM4TDTMAD9Gf9W1iTVuuHtXKjZdr038kwz9Q3ffwU=;
        b=NNbBWOp/QPOzG3Qx0qXxunaph/44Z2S75bLyH+Ecf8yrgy3jTbxnr23n0TsC9Rwbs1
         la1iv58wovDuLl1C5VrutNIoDylWvwKk/sejkBFd3OAvAFyWXi9nWtypWjw24ZhsqLXf
         /mSJdrhjvHkusPCcpbDnynzHJHwR9bsEQNimL9tkG5Jmu3q3v44pHb/Z1I/dbUJRD2CL
         TWYpYxFyftmZpm0/NtVRoOzPPSQ7lFYehdtLLf8coqM9xeu8unlc6Jx4OwEeWDsf//k2
         lLQkvRh+HzKjawldJ8AdCxZaOj1xCcxfAkyK8wxD1tJoRDWOoByDWfaq+1dxTD1NoV9q
         vpcA==
X-Gm-Message-State: AO0yUKV9c51Cw6Zt9ScX3ZATQTge8jNrcF2RCZxq15HPSXY2cbnP3dUu
        1N5kER9+Ax+55QkzRQb9gefNAFqshZ0=
X-Google-Smtp-Source: AK7set/5r1s/RbV8cEt68FRHgLqiT01Ytj0KGl7k0QLbkUq/OvdZL2izM31e0/ep3/tHaVsJyuH/0w==
X-Received: by 2002:a05:6830:4486:b0:694:3bee:529e with SMTP id r6-20020a056830448600b006943bee529emr19269571otv.33.1678631847172;
        Sun, 12 Mar 2023 07:37:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i18-20020a9d6112000000b0068bcef4f543sm2232608otj.21.2023.03.12.07.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 07:37:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <caed9824-c05d-19a9-d321-edefab17c4f0@roeck-us.net>
Date:   Sun, 12 Mar 2023 07:37:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 8/8] btrfs: turn on -Wmaybe-uninitialized
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        dsterba@suse.cz
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1671221596.git.josef@toxicpanda.com>
 <1d9deaa274c13665eca60dee0ccbc4b56b506d06.1671221596.git.josef@toxicpanda.com>
 <20230222025918.GA1651385@roeck-us.net>
 <20230222163855.GU10580@twin.jikos.cz>
 <6c308ddc-60f8-1b4d-28da-898286ddb48d@roeck-us.net>
 <feb05eef-cc80-2fbe-f28a-b778de73b776@leemhuis.info>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <feb05eef-cc80-2fbe-f28a-b778de73b776@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/12/23 06:06, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 22.02.23 18:18, Guenter Roeck wrote:
>> On 2/22/23 08:38, David Sterba wrote:
>>> On Tue, Feb 21, 2023 at 06:59:18PM -0800, Guenter Roeck wrote:
>>>> On Fri, Dec 16, 2022 at 03:15:58PM -0500, Josef Bacik wrote:
>>>>> We had a recent bug that would have been caught by a newer compiler
>>>>> with
>>>>> -Wmaybe-uninitialized and would have saved us a month of failing tests
>>>>> that I didn't have time to investigate.
>>>>>
>>>>
>>>> Thanks to this patch, sparc64:allmodconfig and parisc:allmodconfig now
>>>> fail to commpile with the following error when trying to build images
>>>> with gcc 11.3.
>>>>
>>>> Building sparc64:allmodconfig ... failed
>>>> --------------
>>>> Error log:
>>>> <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>>>> fs/btrfs/inode.c: In function 'btrfs_lookup_dentry':
>>>> fs/btrfs/inode.c:5730:21: error: 'location.type' may be used
>>>> uninitialized [-Werror=maybe-uninitialized]
>>>>    5730 |         if (location.type == BTRFS_INODE_ITEM_KEY) {
>>>>         |             ~~~~~~~~^~~~~
>>>> fs/btrfs/inode.c:5719:26: note: 'location' declared here
>>>>    5719 |         struct btrfs_key location;
>>>
>>> Thanks for the report, Linus warned me that there might be some fallouts
>>> and that the warning flag might need reverted. But before I do that I'd
>>> like to try to understand why the warnings happen in a code where is no
>>> reason for it.
>>>
>>> I did a quick test on gcc 11.3 (on x86_64, not on sparc64 unlike you
>>> report), and there is no warning
>>>
>>> gcc (SUSE Linux) 11.3.1 20220721 [revision
>>> a55184ada8e2887ca94c0ab07027617885beafc9]
>>> Copyright (C) 2021 Free Software Foundation, Inc.
>>> This is free software; see the source for copying conditions.  There
>>> is NO
>>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
>>> PURPOSE.
>>>
>>>     DESCEND objtool
>>>     CALL    scripts/checksyscalls.sh
>>>     CC [M]  fs/btrfs/inode.o
>>>
>>> I.e. it's the same version, different arch and likely not the same
>>> config. In the function itself thre's a local variable passed by address
>>> to a static function in the same file.
>>>
>>>      struct btrfs_key location;
>>>      ...
>>>      ret = btrfs_inode_by_name(BTRFS_I(dir), dentry, &location, &di_type);
>>>
>>> and there it's
>>>
>>>      btrfs_dir_item_key_to_cpu(path->nodes[0], di, location);
>>>
>>> which is a series of helpers to read some data and store that to the
>>> strucutre. At some point there's a call to read_extent_buffer() that's
>>> in a different file.
>>>
>>> A local variable passed by address to external function is quite common
>>> so I'd expect more warnings and I don't see what's different in this
>>> case.
>>
>> Me not either. I also don't see the problem with other architectures, only
>> with sparc and parisc. It doesn't have to be gcc 11.3, though; it also
>> happens
>> with gcc 11.1, 11.2, 12.1, and 12.2 (tested on sparc).
>>
>> Too bad that gcc doesn't tell why exactly it believes that the object
>> may be uninitialized. Anyway, the following change would fix the problem.
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 6c18dc9a1831..4bab8ab39948 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -5421,7 +5421,7 @@ static int btrfs_inode_by_name(struct btrfs_inode
>> *dir, struct dentry *dentry,
>>                  return -ENOMEM;
>>
>>          ret = fscrypt_setup_filename(&dir->vfs_inode, &dentry->d_name,
>> 1, &fname);
>> -       if (ret)
>> +       if (ret < 0)
>>                  goto out;
>>
>> Presumably gcc assumes that fscrypt_setup_filename() could return
>> a positive value.
> 
> This discussion seems to have stalled, but from a kernelci report it
> looks like above warning still happens:
> https://lore.kernel.org/all/640bceb7.a70a0220.af8cd.146b@mx.google.com/
> 
> @btrfs developers, do you still have it on your radar?
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> #regzbot poke

There was a patch:

#regzbot monitor: https://patchwork.kernel.org/project/linux-btrfs/patch/dc091588d770923c3afe779e1eb512724662db71.1678290988.git.sweettea-kernel@dorminy.me/
#regzbot fix: btrfs: fix compilation error on sparc/parisc
#regzbot ignore-activity

Guenter

