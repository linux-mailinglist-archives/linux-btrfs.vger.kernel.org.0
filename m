Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298873B7F15
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 10:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhF3Ih2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 04:37:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58185 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbhF3Ih2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 04:37:28 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lyVgQ-0006BI-Bs
        for linux-btrfs@vger.kernel.org; Wed, 30 Jun 2021 08:34:58 +0000
Received: by mail-ed1-f69.google.com with SMTP id h11-20020a50ed8b0000b02903947b9ca1f3so756085edr.7
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Jun 2021 01:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1IFtEhzs0Lv1y9+UgWa0DfCZGcuW1gInwvipY/SR0mg=;
        b=d4/1Y+i4JHgWoNol91NaUF8eSwFCNoIxr4vMGOeoWIVHlb4RzR94XaPIb3RbcD+69k
         5NFdU9Sdyvbn4hQpBuhrac1wcMsCzKiH0Xjhn90159IQIqG7Eif6xy1tZIS5YB/Mcqm2
         YieYU96IJw8HZfk00mALt6gxI9vjhDtujJqQzmE6METMdkM6CUDSGrUF6WNq56Tj6xJs
         pWZRCRdbG7aP2jrRxo421Glhte+Gq3FSkLtBQqM48EWb994e4Ac/F5XHXWu+OGpZrxEF
         yPFGHxMd+DVgwSMtGej3plGwLdUTje9v2qi4s59qJIKVmybOghPqa3YO5BHD6m9uC0nb
         W0Xw==
X-Gm-Message-State: AOAM531bC6BldwnXBvUxw9m5c6UmAw3j3AAQHnm83iJ5ChQQm71yEepC
        UWdGv+Brq7/JfRCBnAup2Zs2OToRKzxnDk0Z38BKQx79q/rm5wQO/fW3S8Q4+/bJc4ujOlZ8WzG
        ls9wqR9u887ljH15hLeSXr2T1TCxZD0FOjWY208Zu
X-Received: by 2002:a05:6402:510d:: with SMTP id m13mr44656743edd.179.1625042098154;
        Wed, 30 Jun 2021 01:34:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNgwxmBwrzLvr9noQ+vvLunox3/nAXTETv/38X874mVuhLyMIBpETi86RVWG3SYS6/SBEvBQ==
X-Received: by 2002:a05:6402:510d:: with SMTP id m13mr44656731edd.179.1625042097973;
        Wed, 30 Jun 2021 01:34:57 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id gl26sm410271ejb.72.2021.06.30.01.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 01:34:57 -0700 (PDT)
Subject: Re: [BUG] btrfs potential failure on 32 core LTP test (fallocate05)
To:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kernel-team@lists.ubuntu.com" <kernel-team@lists.ubuntu.com>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>
References: <a3b42abc-6996-ab06-ea9f-238e7c6f08d7@canonical.com>
 <124d7ead-6600-f369-7af1-a1bc27df135c@toxicpanda.com>
 <667133e5-44cb-8d95-c40a-12ac82f186f0@canonical.com>
 <0b6a502a-8db8-ef27-f48e-5001f351ef24@toxicpanda.com>
 <2576a472-1c99-889a-685c-a12bbfb08052@canonical.com>
 <9e2214b1-999d-90cf-a5c2-2dbb5a2eadd4@canonical.com>
 <57cfa398-8a33-06e2-dfcd-fa959c27ac47@toxicpanda.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <30d510db-df48-e499-6e46-bd84c85d4b41@canonical.com>
Date:   Wed, 30 Jun 2021 10:34:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <57cfa398-8a33-06e2-dfcd-fa959c27ac47@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/06/2021 20:32, Josef Bacik wrote:
> On 6/29/21 2:28 PM, Krzysztof Kozlowski wrote:
>> On 29/06/2021 20:06, Krzysztof Kozlowski wrote:
>>> Minor update - it's not only Azure's. AWS m5.8xlarge and m5.16xlarge (32
>>> and 64 cores) fail similarly. I'll try later also QEMU machines with
>>> different amount of CPUs.
>>>
>>
>> Test on QEMU machine with 31 CPUs passes. With 32 CPUs - failure as
>> reported.
>>
>> dmesg is empty - no error around this.
>>
>> Maybe something with per-cpu variables?
> 
> Ah yeah, so since you are further into this than I am, want to give my recent 
> batch of fixes a try?
> 
> https://github.com/josefbacik/linux/tree/delalloc-shrink
> 
> This might actually resolve the problems.  If not I'm getting one of our 64cpu 
> boxes setup to test this, I also couldn't reproduce it on my smaller local 
> machines.  Thanks,

I just gave ita try on v5.13 + merge of your branch and it fixes the
issue, at least on QEMU with 32 and 64 CPUs.

Would be good to find the exact commit fixing it to be sure it gets
backported to stables.


Best regards,
Krzysztof
