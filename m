Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B0D56C5DD
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 03:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiGIByn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 21:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiGIBy1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 21:54:27 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6709E86882
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 18:53:51 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id f14so282987qkm.0
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Jul 2022 18:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GVSG4KmTRBxDWcaxom1r8thjkeIBeJdSmVGb4z0XgpQ=;
        b=Ie+/bku1iUGWA3ooDwmysR4VXfMoIwR+EFIX6rvxQU4pxYbpihUPZtKgtmjQlJ2sTf
         306KxzbQU934fs8dDMt5rQIR1x1lyCpyYchg7RjOEoAgdP7oGj2HuGUVbZmllVWdp/Lb
         S6eN+zkkojuID8G7tluvVeKYfAruQvRc7AxdmtuczgxYT+JrG01rSudh2Tb9JtFs9R2E
         dXeS0ZyCi5zBaRIW8MIxOtrKJwch9Tq+0Wz6aES/DRQS0LBINO6AVqm9g7wSETIvLPK0
         KUEIfNT38aDnqWRJcfUSDojSLeCK0LlZex7vme4JT9+S9Vjt502uIHuxorZet7+SjRi4
         YAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GVSG4KmTRBxDWcaxom1r8thjkeIBeJdSmVGb4z0XgpQ=;
        b=VumHgZuaCaImYBO1fSCG45ZU8ZtoPpdJUgp0ibr0+rmbnzpFNZA0pFM8L78AL4Od36
         98fgQtpSyMpsXjBztBK9LBe5zTvq3B+c4rNMRGvlrvFnPx8MFBi0yIeNwx5BefuXmtQ6
         /QyY/7D+DI8He0cLwL0Z8s9pMBnCsNeaHjZzhTHGJ7+QFFt04NmFjwb3fw/0CKdghGiX
         rguLWW3DYum3xEpVLJVYxG3Hxpkz7ow5KHX6RRE6yQBUb9daFW/PEjB7esm8baOkMjqu
         lXXDCK30UpKH+NZVNkNr0XM3V20MGBP+UfGTeZnFud5ygYw99OZ68ntOrHHyZEe1Oiup
         bJLA==
X-Gm-Message-State: AJIora8wq/+KGEAUf9bUdbdm1UjUcfV5cWCNGZ91M9JQMQ3C1Q1zacgj
        DAp4mn0Agx440e8zkHJ3oHy9tkgj7GA=
X-Google-Smtp-Source: AGRyM1sQsDPDIpJuNQXT4agsiuZWZmsBj10kuA2FAmRBoDAoCi9KF9sFboA1mmZX2dUm+x6dwJ7Ftw==
X-Received: by 2002:a37:b986:0:b0:6b5:5067:b1e3 with SMTP id j128-20020a37b986000000b006b55067b1e3mr4394825qkf.749.1657331630106;
        Fri, 08 Jul 2022 18:53:50 -0700 (PDT)
Received: from [10.5.100.6] (modemcable117.130-83-70.mc.videotron.ca. [70.83.130.117])
        by smtp.gmail.com with ESMTPSA id h129-20020a379e87000000b006b55df40976sm260117qke.27.2022.07.08.18.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 18:53:49 -0700 (PDT)
Message-ID: <01d1eb16-3b16-a65a-f4e8-66de03e5d93b@gmail.com>
Date:   Fri, 8 Jul 2022 21:53:48 -0400
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
 <d7276c15-37d5-d4e5-cab5-0e2703216a95@gmail.com>
 <39218256-628f-dd47-57cc-65ae6ece1fec@gmx.com>
From:   Denis Roy <denisjroy@gmail.com>
In-Reply-To: <39218256-628f-dd47-57cc-65ae6ece1fec@gmx.com>
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

maybe I should just run on what I got then.


ReadyNAS is a line of network-attached storages sold by Netgear. These 
devices run ReadyNAS OS, a Linux distribution based on Debian 8


On 2022-07-08 9:48 p.m., Qu Wenruo wrote:
>
>
> On 2022/7/9 09:34, Denis Roy wrote:
>> Love to comply to run the latest version, but I past from my
>> experiences. Maybe you could help me on update/upgrading so I can do the
>> check. I trying to learn here, need some help
>
> This can vary from very complex or even impossible (if your NAS has a
> very rare setup, like using some rare archtecture/boot sequence) to as
> simple as installing a distro (like debian or ubuntu).
>
> If your NAS is an x86/x86_64 based system, then it may be much easier,
> just try to find how to go into the BIOS, change the boot sequence and
> try boot from LiveCD of your choice.
>
>
> Otherwise, it will be a long long journey to find out a distro
> supporting your device.
>
> Thanks,
> Qu
>>
>> On 2022-07-08 3:04 a.m., Qu Wenruo wrote:
>>>
>>>
>>> On 2022/7/8 14:20, Denis Roy wrote:
>>>> Ok, great. How do I do that?
>>>
>>> Considering you're using a vendor specific firmware/hardware, I don't
>>> have any good suggestion, other than upgrade to the latest version the
>>> vendor provides, and hope they upgraded the kernel.
>>>
>>> Or you may want to jump into the rabbit hole of running a common distro
>>> on the NAS hardware so that you have full control of the system, but
>>> lose all the out-of-box experience provided by those NAS vendors.
>>>
>>>
>>> For the corrupted fs, you may want to run btrfs check (latest version
>>> recommended) and post it.
>>> Then we may be able to decide if the fs can be repaired properly.
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> Sent from my iPhone
>>>>
>>>>> On Jul 8, 2022, at 2:01 AM, Qu Wenruo <wqu@suse.com> wrote:
>>>>>
>>>>> ﻿
>>>>>
>>>>>> On 2022/7/8 13:50, Denis Roy wrote:
>>>>>>      key (7652251795456 EXTENT_ITEM 72057594063093760) block
>>>>>> 12567101254720864896 (383517494345729) gen 72340209471334675
>>>>>>      key (2959901138859622420 EXTENT_CSUM 3664676558733568) block
>>>>>> 2234066886193184768 (68178310735876) gen 18374696375462128179
>>>>>>      key (1153765929541501184 EXTENT_CSUM 0) block 0 (0) gen 0
>>>>>>      key (0 UNKNOWN.0 0) block 0 (0) gen 0
>>>>>
>>>>> The above dump shows the tree node is completely corrupted by some
>>>>> weird data.
>>>>>
>>>>> The offending slot is not aligned, and its offset (extent size for
>>>>> EXTENT_ITEM) is definitely not correct.
>>>>>
>>>>> But the offset looks like a bitflip:
>>>>>
>>>>> hex(72057594063093760) = '0x100000001800000'
>>>>>
>>>>> Ignoring the high bit, 0x1800000 is completely sane for the size of
>>>>> an data extent.
>>>>>
>>>>> The next slot even has incorrect type, (EXTENT_CSUM) should not
>>>>> occur in
>>>>> extent tree, but this time I can not find a pattern in the corrupted
>>>>> type.
>>>>>
>>>>> The offset, 3664676558733568, is also not aligned but without a
>>>>> solid corruption pattern.
>>>>>
>>>>> And finally we have an UNKNOWN key, which should not occur there at
>>>>> all.
>>>>>
>>>>>
>>>>> So this looks like that tree node is by somehow screwed up in the
>>>>> middle.
>>>>> I don't have any clue how this could happen, but considering the
>>>>> checksum still passed, it must happen at runtime.
>>>>>
>>>>>
>>>>> For now, I can only recommend to go kernel newer than 5.11 which
>>>>> introduced mandatory write-time tree block sanity check, and should
>>>>> reject such bad tree block before it can be written to disk.
>>>>>
>>>>> Thanks,
>>>>> Qu
