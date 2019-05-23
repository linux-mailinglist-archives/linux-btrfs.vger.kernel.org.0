Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2215B28496
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2019 19:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbfEWRNa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 May 2019 13:13:30 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:38845 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731083AbfEWRN3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 May 2019 13:13:29 -0400
Received: by mail-io1-f44.google.com with SMTP id x24so5468355ion.5
        for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2019 10:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kr6PTkj0sJLhoZAGXEwvyq4J22bYVebm1PV+3hTtUFY=;
        b=lHZuyQ4n1Awbh+5K9+thToKbW2sVoop3tGrseRrT/qK8oZ6V87fV1pdm51RnIETqsH
         gAz9viTHiduZYV8JQHlQYerU0wmmWiCMSniNl7CoNIsb5mBLAfx199P4NzdWGPCtd6ip
         v298AXZsrchtdcbrvgLzbjhHnu2ksmFQfOV44fQRiRUFzJoFYcXjlc84QLOYoJGZiywu
         n/jjPU7ZWNsxTFkqyDIkePFbleqmHo90uAy0myyoToHHtBYNTkd9pVe3I3kBoG1AwdSs
         t+6UZYrC9tRZQSgey6zpsksQmMZ36Z66YuQSjQN5r85gHatpInz9iMgZJPa3W3CFZB09
         sWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kr6PTkj0sJLhoZAGXEwvyq4J22bYVebm1PV+3hTtUFY=;
        b=gDGE2nDzxEsHSibtXQNdjld2vfWrLAeIPdHHiGbrVQxV9QbBNNiItFmlXMMDuI/ab2
         w5jMMGDapNZ9sOR+UjtSgU89WcQ2kllQnWYSPevjfe+K1zCmS8iKXvkLI583/dtg0VcE
         pxpyDAnwlDOs6uGSfdXUX4+1HsusOeJtYp9l6ksKhn2w5XHiXlKiDRttdcFBoT6HwrLX
         DkQ/sqpwgXdb4zPLvHtAugSasRSe20u73DXnXhk3+tEm7xG1kOM1fhF4nJrUwLpbJmXj
         jwSaMbQWtw1sU6KY+gguvwYeIg2Vjw+UIvwYdlKplR7n3iVialACed5bu14wQ126DeRf
         Dj0Q==
X-Gm-Message-State: APjAAAVaLj9ntV4yYuEIBBM9yNHopqmIJhcezN3j6olvKz5d7Cmgw22C
        sg/9BlocofCODIMMrf5S5NfQhBGHFFwXZw==
X-Google-Smtp-Source: APXvYqymECI33f3op++vhfL6dGLubWj3hvVqrMSua826S/G7dXR81zxUpbozPE8zJV1KH4XAlCexWQ==
X-Received: by 2002:a6b:f101:: with SMTP id e1mr14045253iog.262.1558631608761;
        Thu, 23 May 2019 10:13:28 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id m20sm26769ioh.13.2019.05.23.10.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 10:13:28 -0700 (PDT)
Subject: Re: Citation Needed: BTRFS Failure Resistance
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAN4oSBeEU+rmCS8+WwriGz0KoPR=Xa6KvjH=gGriFaxVNZHf6Q@mail.gmail.com>
 <8ccec20a-04b1-4a84-6739-afd35b4ab02e@gmail.com>
 <CAJCQCtTp5d+VxsQmVv68VdmCsxSVpi-_c6LJjS_T=xx3GXz9Fg@mail.gmail.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <979559b5-1fb5-debd-e101-6e4227348426@gmail.com>
Date:   Thu, 23 May 2019 13:13:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTp5d+VxsQmVv68VdmCsxSVpi-_c6LJjS_T=xx3GXz9Fg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-05-23 12:24, Chris Murphy wrote:
> On Thu, May 23, 2019 at 5:19 AM Austin S. Hemmelgarn
> <ahferroin7@gmail.com> wrote:
>>
>> On 2019-05-22 14:46, Cerem Cem ASLAN wrote:
>>> Could you confirm or disclaim the following explanation:
>>> https://unix.stackexchange.com/a/520063/65781
>>>
>> Aside from what Hugo mentioned (which is correct), it's worth mentioning
>> that the example listed in the answer of how hardware issues could screw
>> things up assumes that for some reason write barriers aren't honored.
>> BTRFS explicitly requests write barriers to prevent that type of
>> reordering of writes from happening, and it's actually pretty unusual on
>> modern hardware for those write barriers to not be honored unless the
>> user is doing something stupid (like mounting with 'nobarrier' or using
>> LVM with write barrier support disabled).
> 
> 'man xfs'
> 
>         barrier|nobarrier
>                Note: This option has been deprecated as of kernel
> v4.10; in that version, integrity operations are always performed and
> the mount option is ignored.  These mount options will be removed no
> earlier than kernel v4.15.
> 
> Since they're getting rid of it, I wonder if it's sane for most any
> sane file system use case.
> 
As Adam mentioned, it's mostly volatile storage that benefits from this. 
  For example, on the systems where I have /var/cache configured as a 
separate filesystem, I mount it with barriers disabled because the data 
there just doesn't matter (all of it can be regenerated easily) and it 
gives me a few percent better performance.  In essence, it's the mostly 
same type of stuff where you might consider running ext4 without a 
journal for performance reasons.

In the case of XFS, it probably got removed to keep people who fancy 
themselves to be power users but really have no clue what they're doing 
from shooting themselves in the foot to try and get some more performance.

IIRC, the option originally got added to both XFS and ext* because early 
write barrier support was a bigger performance hit than it is today, and 
BTRFS just kind of inherited it.
