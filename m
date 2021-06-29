Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E00E3B7728
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jun 2021 19:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbhF2R1i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Jun 2021 13:27:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45442 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbhF2R1g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Jun 2021 13:27:36 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lyHTw-0003NH-Fr
        for linux-btrfs@vger.kernel.org; Tue, 29 Jun 2021 17:25:08 +0000
Received: by mail-ed1-f70.google.com with SMTP id r15-20020aa7da0f0000b02903946a530334so11841461eds.22
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Jun 2021 10:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ri3WXGzuTojlL+9mSjxaDY7X42NrL+ai9PlKm2Tb+w4=;
        b=lN9Ob6sK1g3MrYuuxNL3OWdzaWP3bYOo+TamiPTwV7CgCVQHynQLzPWxBalbyGNiEu
         Lfscq3eg70BT+WThx8PQtgw7KqtVOGhGNZyVeb+JyDlszObDXA4bWChsJRJZ20B4Vt9r
         M+J+Bg1NzRzH3vtLMeBpn2EVXZ+oW9lP6fWFnobf4ytvdferR+bM+PPuc2dbu+rhyDyJ
         Wp2g1Pa7gAtWqjKJXRnQKjw9NH7cFytKK9H7AcjWsDJA3ccHVWasVh+E7UKo32Tot+W9
         oUjsZpoyuLyg4Wt9Iagk8Cxos7mGfRmB2UK/5/HCwLVQEuI03wX3DTrsoShz8/4IINwJ
         c8SA==
X-Gm-Message-State: AOAM533pAlTGj5cl07StP1e6rM0yCmIpPTSrZEC/nl2QN4lcds+URdgv
        mbDEnXfii7o5Dou8wp0ToToms4Wikb4FnuLvOiSq+O4gUX45JhgVze4HZU0aKoQaW48XjkZYi2c
        lrZLMEd36pIkBq4vsgY3N8ltqp32worJVxZQ+cwI/
X-Received: by 2002:a05:6402:31a9:: with SMTP id dj9mr41493358edb.164.1624987508245;
        Tue, 29 Jun 2021 10:25:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzU/YhwLaYMTGQNMSd2pgQJxlfGs1UWubtAp8nzGtPKda2VM7Jpw2ZllP8AvwmGwX6cwntukw==
X-Received: by 2002:a05:6402:31a9:: with SMTP id dj9mr41493349edb.164.1624987508141;
        Tue, 29 Jun 2021 10:25:08 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id n2sm11450840edi.32.2021.06.29.10.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 10:25:07 -0700 (PDT)
Subject: Re: [BUG] btrfs potential failure on 32 core LTP test (fallocate05)
To:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kernel-team@lists.ubuntu.com" <kernel-team@lists.ubuntu.com>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>
References: <a3b42abc-6996-ab06-ea9f-238e7c6f08d7@canonical.com>
 <e4c71c01-ed70-10a6-be4d-11966d1fcb75@toxicpanda.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <b5c6779b-f11d-661e-18c5-569a07f6fd8e@canonical.com>
Date:   Tue, 29 Jun 2021 19:25:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e4c71c01-ed70-10a6-be4d-11966d1fcb75@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/06/2021 19:20, Josef Bacik wrote:
> On 6/29/21 1:00 PM, Krzysztof Kozlowski wrote:
>> Dear BTRFS folks,
>>
>> I am hitting a potential regression of btrfs, visible only with
>> fallocate05 test from LTP (Linux Test Project) only on 32+ core Azure
>> instances (x86_64).
>>
>> Tested:
>> v5.8 (Ubuntu with our stable patches): PASS
>> v5.11 (Ubuntu with our stable patches): FAIL
>> v5.13 mainline: FAIL
>>
>> PASS means test passes on all instances
>> FAIL means test passes on other instance types (e.g. 4 or 16 core) but
>> fails on 32 and 64 core instances (did not test higher),
>> e.g.: Standard_F32s_v2, Standard_F64s_v2, Standard_D32s_v3,
>> Standard_E32s_v3
>>
>> Reproduction steps:
>> git clone https://github.com/linux-test-project/ltp.git
>> cd ltp
>> ./build.sh && make install -j8
>> cd ../ltp-install
>> sudo ./runltp -f syscalls -s fallocate05
>>
> 
> This thing keeps trying to test ext2, how do I make it only test btrfs?  Thanks,

It tests all available file systems, just wait till it gets to btrfs. I
don't know how to limit it only to one file system.


Best regards,
Krzysztof
