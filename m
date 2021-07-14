Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B0C3C7ECA
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 08:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238144AbhGNG5U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 02:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237948AbhGNG5U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 02:57:20 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDE9C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 23:54:28 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t9so1438595pgn.4
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 23:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Nf8t6x+ynYVytynQc/H+89DGqb3p0LRvLDOZfJGbiPo=;
        b=l3w5qFLcwit257UQBWUmajlO+APb8mQlGvZyacyfvCVPAOh35bQe4xQOuYNNwYZk5q
         2XYeb112lht4ZG55m6+9dBQ0JuAfgTaT5vPgTNRQfczbQTRb+YUkI0l16mkz4IFLZGYi
         /O09HIkIrchVJAVdEtmmBKN6VH/fWyKeD4iV8w/4sGNs8k13bNssiFXC9THGJjPq5Q1W
         /9x1pSRzbsw+SrslI+e4TC4sPBOe4pDUHBoriX87hsGbprFHCicSGYIAoypw1dgrYoZ3
         uliotdkFEp0/0tMi7F7lyKPlzOkew8t/qpjbWD/UExGXfTlJKY80qxldBWLUxzecARQV
         E6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Nf8t6x+ynYVytynQc/H+89DGqb3p0LRvLDOZfJGbiPo=;
        b=YOh1WfeVUNYDAktse8P9cXmChAqSlsV4faF0sRT6vq6gecBgJ9GmOPXCARosuBVx8X
         XWrD3SSJD1qpTos27OE6MRJZRo7dsZi9ANbl6RHzIxK1GkINvTwLpVur6aF2onlKdkjx
         dwwwIJN3Pg2z3gRvMgyKX1z/cns/7/AG6wZ+/qit5wAc3A9dJGKDptcAu+hQReDw+Pfv
         LtS7rDrG1O+ePpa3wqREb8iR105olSBZiHmGqV4WdjvW6gBQlhTJWEg6y2VDD0/Y0ISQ
         kbR2ausYaakX34wmIhcCd3eqLRhxB4dtn8LY4/z76Zvspc6k07awCVibEjidhEi+jHQH
         NaIw==
X-Gm-Message-State: AOAM531nwnbtWNcI3F5oiUY5Gzt1jluDSBgNtQNXQmfV6tyMljNcW087
        Nbbhgl43tr7wks+AV95RPGmNerDeNw4=
X-Google-Smtp-Source: ABdhPJydRA/e4zuiEEABXUZLvHqtgn9Y0gT+BeUwv6qf1SuT3sVt6CEHEYz0hlKr1PRl+Ze5YUOHCA==
X-Received: by 2002:a63:1718:: with SMTP id x24mr8065025pgl.416.1626245667655;
        Tue, 13 Jul 2021 23:54:27 -0700 (PDT)
Received: from [192.168.178.53] (14-203-78-180.tpgi.com.au. [14.203.78.180])
        by smtp.gmail.com with ESMTPSA id y4sm1614198pfc.15.2021.07.13.23.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 23:54:27 -0700 (PDT)
Subject: Re: migrating to space_cache=2 and btrfs userspace commands
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <63396688-0dc7-17c5-a830-5893b030a30f@gmail.com>
 <86f0624a-cba4-58a3-0a80-460d3f12e8b3@gmx.com>
 <CAJCQCtTFkYHocpdqtS=1y-At11wz5-Kv4Tx5D-QeRg9JpEGdMA@mail.gmail.com>
 <889c88ad-f51a-5b1f-3613-0b78af77477c@gmx.com>
From:   DanglingPointer <danglingpointerexception@gmail.com>
Message-ID: <1333ad7a-941d-aead-6e5f-06e321c84feb@gmail.com>
Date:   Wed, 14 Jul 2021 16:54:24 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <889c88ad-f51a-5b1f-3613-0b78af77477c@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Yep that's what I'm referring to here: 
https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)

Thanks for the prompt respone Qu!

So just to confirm, our scheduled cron jobs to scrub will still work 
with space_cache=v2?



On 14/7/21 4:05 pm, Qu Wenruo wrote:
>
>
> On 2021/7/14 下午1:44, Chris Murphy wrote:
>> On Tue, Jul 13, 2021 at 10:59 PM Qu Wenruo <quwenruo.btrfs@gmx.com> 
>> wrote:
>>>
>>>
>>>
>>> On 2021/7/13 下午11:38, DanglingPointer wrote:
>>
>>>> 2. If we use space_cache=v2, is it indeed still the case that the
>>>>      "btrfs" command will NOT work with the filesystem?
>>>
>>> Why would you think "btrfs" won't work on a btrfs?
>>>
>>
>> Maybe this?
>>
>> man 5 btrfs, space_cache includes:
>>
>>   The btrfs(8) command currently only has read-only support for v2. A
>> read-write command may be run on a v2 filesystem by clearing the
>> cache, running the command, and then remounting with space_cache=v2.
>>
>
> Oh, that's only for offline tools writing into the fs, namingly "btrfs
> check --repair" and "mkfs.btrfs -R"
>
> And I believe that sentence is now out-of-date after btrfs-progs v4.19,
> which pulls all the support for write time free space tree (v2 space 
> cache).
>
> I'll soon send out a patch to fix that.
>
> Thanks,
> Qu
