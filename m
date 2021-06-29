Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6594F3B77DE
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jun 2021 20:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbhF2Ses (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Jun 2021 14:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbhF2Ser (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Jun 2021 14:34:47 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E24C061766
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Jun 2021 11:32:19 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 19so21719636qky.13
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Jun 2021 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FdTAed2LSsBnzt5mppM7ptg5hTbGbhSZ1V8HyoAvOkg=;
        b=p4LxCNymyBtzGTN48VIjv5wsucwiQGUlrGyfEAYtdryNyX1VuRilWX0IH7v919zbW1
         hCDHX01SDCQolN4L5HVK3vJtA+VGpvaer5V0oCki282T7l9O/TJWIapCDZPjhAE3TRy4
         InPM43x/pEXuJcHqZ8CczhXKs09JS1elwlCsgHjKulLj8AnLlmiP0AJ35gjK0wMrFooN
         1gfIWPEUdVhRhj98Iuy08od821uAJYvM9D19LnX2CqbNCO3H4DSqKE5qFKnSf9UVsIXQ
         EL7r1ih98PxBm9Y8zRtaAMNOb/uw2Zqw5bSEGZfvihcYr6QBSdXVzNxU2eOmiCsNmK3C
         gqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FdTAed2LSsBnzt5mppM7ptg5hTbGbhSZ1V8HyoAvOkg=;
        b=F0JrDQeepcA903l9js0XfiINDNX65KtGR+twu4HKBDMuSuGSrA1axmNfdpyjYiAAql
         MExrM4hdMya4a+GzkPUJ2OOQvUjz9rxM6xSjU1KEdmg+58wBvXhWjz0uzkZB80KEbkz2
         eXNGkC3r8i3GEXFaP4u6/rtnAeO6bYcqp88IntyDHTvMF48fYVfhgzSc0UOo598pVHui
         Oq5rOn/B03giJaxG+2tdbfMAXJ9BCtO9uZdJKVtEogLQ3Xqij+26ofD7tQd38v9q/CKb
         NfmP+EFU6p6ZpVmEbs1O8BR+aDek5hyPFW08wPpOJdOvWdl+bjILQnrrz2uoKlNVYBns
         86yA==
X-Gm-Message-State: AOAM532872vb0ew6Xd8T9qNQhJieL6s02hv8/ff91cccs3lrddKikIM2
        MHrHzfv5zM411IlKUl3mM5A3DA==
X-Google-Smtp-Source: ABdhPJwimaCD8ZfgQbaVJoflCansSCyaQJZuRQzAm8t9OSjmgNJoCCGt7uRXohHJeygN2eo+zwX3dQ==
X-Received: by 2002:a37:ad02:: with SMTP id f2mr15664410qkm.357.1624991538273;
        Tue, 29 Jun 2021 11:32:18 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::12d2? ([2620:10d:c091:480::1:98e8])
        by smtp.gmail.com with ESMTPSA id d136sm4242135qkc.110.2021.06.29.11.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 11:32:17 -0700 (PDT)
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
Message-ID: <57cfa398-8a33-06e2-dfcd-fa959c27ac47@toxicpanda.com>
Date:   Tue, 29 Jun 2021 14:32:15 -0400
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

Ah yeah, so since you are further into this than I am, want to give my recent 
batch of fixes a try?

https://github.com/josefbacik/linux/tree/delalloc-shrink

This might actually resolve the problems.  If not I'm getting one of our 64cpu 
boxes setup to test this, I also couldn't reproduce it on my smaller local 
machines.  Thanks,

Josef

