Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917B23B7930
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jun 2021 22:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhF2URP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Jun 2021 16:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbhF2URO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Jun 2021 16:17:14 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD481C061766
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Jun 2021 13:14:46 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id d2so2662354qvh.2
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Jun 2021 13:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uvaby5gvroAX5HC+y94a4O9K04hquk3bJ0y+KPQxC60=;
        b=QOfJ1i6doLCaLKvWd7QE9NcumeGgRhUUqOsGSH37yiiZvQQeBlo+twAHzgkC/+xR7G
         6Gg9pFiJhN1lWfpjA2zS3jC+D6wkGR9bfz1jquysNgTuoGXVLVahVI1FVAcB1VxBjV39
         t6577/bHE6eEfg+R9ulGJnpOWWrdmLpbmi9eS7TnD6GwJXCHTzCfRHKrhX2WKFo0SGzV
         yD5Urp7YBqb2aYcMX/Rw/R7k74UByXC6DXvtlpt6pluEbX4EGYahLBoChaUMfn+R8HDA
         yPRQNBfJ6HD/6BgKEYC3L1lB9xORbDL9RPu6KBv4uzViTDFbaVVZAf8r0w2VZ6M+O3xV
         BC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uvaby5gvroAX5HC+y94a4O9K04hquk3bJ0y+KPQxC60=;
        b=Ym3IdCDDW2rM3x2b75P3nAwLYfjUipVz6Bh3kt47+cCTxlu2rVI/kwVedEz5Haz0hd
         WI/hvBzSkMU7I/cGcG2HeYWymeDuIjBc1Gflkk5KAHIAoDB6zMtGKzFFARwUFKIuKT6R
         kp6C4i8nLLITJsMG0Y656dzDX5FbPSiwzxwfIDsIAqjor0UD3fXJ5t7K3Fd1Q+AMp/Y2
         FEUfHGDS3jpTzRa4xdD330/dilD8zyC95Kw0vPJp1btSBN/UX9Kkc1loTIpTFmIxKnaL
         t27PRgBiZuGIJZ7Gv6XoUrQZ/hE8aq3kZayqqOZKMfNMPkV8ozSTNCzigvz+6P8+9k/q
         eZPg==
X-Gm-Message-State: AOAM531GPxJCaWhJDk7yzVq4kbjGTyoYpC6LlI3hZKIn+1dTC0DNmceQ
        e+S0DdF0dierel4QbolgBq3ejw==
X-Google-Smtp-Source: ABdhPJypSBP2VAgao4SXGRkrO8wNKGE5V/NO4blik1cOk9WCQLNz/7YlzWaQ8Zkw6IZ3ZZ9yUrNTXg==
X-Received: by 2002:ad4:4d85:: with SMTP id cv5mr17887549qvb.33.1624997685578;
        Tue, 29 Jun 2021 13:14:45 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::12d2? ([2620:10d:c091:480::1:1f64])
        by smtp.gmail.com with ESMTPSA id o200sm10300043qke.105.2021.06.29.13.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 13:14:45 -0700 (PDT)
Subject: Re: [BUG] btrfs potential failure on 32 core LTP test (fallocate05)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org,
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
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <62d1df14-7ee5-8ff4-5676-cf98cdd966df@toxicpanda.com>
Date:   Tue, 29 Jun 2021 16:14:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9e2214b1-999d-90cf-a5c2-2dbb5a2eadd4@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/29/21 2:28 PM, Krzysztof Kozlowski wrote:
> On 29/06/2021 20:06, Krzysztof Kozlowski wrote:
>> Minor update - it's not only Azure's. AWS m5.8xlarge and m5.16xlarge (32
>> and 64 cores) fail similarly. I'll try later also QEMU machines with
>> different amount of CPUs.
>>
> 
> Test on QEMU machine with 31 CPUs passes. With 32 CPUs - failure as
> reported.
> 
> dmesg is empty - no error around this.
> 
> Maybe something with per-cpu variables?
> 

Can I get y'alls .config?  I ran it on one of my 80cpu boxes and it didn't 
reproduce on my new code or on 5.12.  Thanks,

Josef
