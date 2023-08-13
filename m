Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAF677AA1A
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Aug 2023 18:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjHMQlm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Aug 2023 12:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHMQll (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Aug 2023 12:41:41 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7183291
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Aug 2023 09:41:43 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-34992058e95so15931855ab.1
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Aug 2023 09:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20221208.gappssmtp.com; s=20221208; t=1691944903; x=1692549703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uRIRmSqZ5W6+yqRPKqDUiUf1SkTV2HK59WGAuIFtK34=;
        b=3TYnt6WcVA6Adaa78ygP+2aJ7D2sjEpikj5ubtiS4oUclZ9i5n7vxfY4TzGJURYOBH
         8QlioPtWeyorfVU351KkeTkXYNm5ik47NuPExoL4gc2u2s5olzXiZZjZOnQqEnDQWkMd
         1kVgUlw7L8ZS7F3+7dZ5XKIsc/503LJq5JOBfRNZamT9nOF9IfaK6tzcyt3NSAHRqjJO
         hkSQCREZzWg6zheOgft6QSkmbPij9ANnsbnJtJPNP75o0jqYY2J6hYksHPom0RHfg/Ur
         9pfZEylsSxFfxTqku4yAhpCaSzBz8QB8kul+ktzto+dx4XxDfDdbXsNEVfe+dFaXMk9y
         NuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691944903; x=1692549703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRIRmSqZ5W6+yqRPKqDUiUf1SkTV2HK59WGAuIFtK34=;
        b=h13mtNXxQ7IjEPh400ixV6rrMrN5ANLM+REO1e4MzHo0WqJKwzb4T0hd569CM/nDAq
         8A0qDWxf+Y5vT2QQrVuSWz1/CxbI43Zx5WtgzKcDj1+we6b3aSvy37mC0Wsn1BszKjHd
         p7f6OlwWwEQ5yV68VfQiqG2EvP2KYByLpOuHoX4uJBkDRb9wqHNDXCBzW0gPIKp64gxA
         ygEoKQjUPHCwvgFW91/8wGtmkyBYnWyILqVk5ZOa07is893F0T7gdNWTq02UGXKxLdKj
         imRZKs7WbmXQAaEO5LSo+kGnVSG+tyo25PFR6D/SQV27nUeMFTrzWeCaLR2iFVjwpTDU
         zsMA==
X-Gm-Message-State: AOJu0Yy0WaggFF3Zt+iaT26TT1Ytf/bqoFKVaElLCPLMT4MKoi89tEew
        j9JI7R/77E2TmkNncfIEE96Y4g==
X-Google-Smtp-Source: AGHT+IGAPzWbkuj93iyFfE7dlsFZBWfC+O9+oOxm/acvOnBM8T+ZqsjjYd4xhPUz8f09WMMyQ4Y/lQ==
X-Received: by 2002:a05:6e02:1c24:b0:348:ffdb:78 with SMTP id m4-20020a056e021c2400b00348ffdb0078mr12888473ilh.9.1691944902765;
        Sun, 13 Aug 2023 09:41:42 -0700 (PDT)
Received: from [172.16.32.83] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id t18-20020a92cc52000000b003498b847e7bsm2633192ilq.22.2023.08.13.09.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 09:41:42 -0700 (PDT)
Message-ID: <d5a42b8f-fd8d-7974-fd78-f76399e78541@landley.net>
Date:   Sun, 13 Aug 2023 11:43:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Endless readdir() loop on btrfs.
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, enh <enh@google.com>
References: <2c8c55ec-04c6-e0dc-9c5c-8c7924778c35@landley.net>
 <CAL3q7H6ehkiLBZpfFf3dy7whnE1fWK5HhW6XdNbYAu2FtqNHxA@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <CAL3q7H6ehkiLBZpfFf3dy7whnE1fWK5HhW6XdNbYAu2FtqNHxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 8/13/23 06:37, Filipe Manana wrote:
> On Sun, Aug 13, 2023 at 12:04 AM Rob Landley <rob@landley.net> wrote:
>>
>> Would anyone like to comment on:
>>
>>   https://bugzilla.kernel.org/show_bug.cgi?id=217681
>>
>> which resulted from:
>>
>>   https://github.com/landley/toybox/issues/306
>>
>> and just got re-reported as:
>>
>>   https://github.com/landley/toybox/issues/448
>>
>> The issue is that modifications to the directory during a getdents()
>> deterministically append the modified entry to the getdents(), which means
>> directory traversal is never guaranteed to end, which seems like a denial of
>> service attack waiting to happen.
>>
>> This is not a problem on ext4 or tmpfs or vfat or the various flash filesystems,
>> where readdir() reliably completes. This is a btrfs-specific problem.
>>
>> I can try to add a CONFIG_BTRFS_BUG optional workaround comparing the dev:inode
>> pair of returned entries to filter out ones I've already seen, but can I
>> reliably stop at the first duplicate or do I have to continue to see if there's
>> more I haven't seen yet? (I dunno what your return order is.) If some OTHER
>> process is doing a "while true; do mv a b; mv b a; done" loop in a directory,
>> that could presumably pin any OTHER process doing a naieve readdir() loop over
>> that directory, hence denial of service...
> 
> I've just sent a fix for this, it's at:
> 
> https://lore.kernel.org/linux-btrfs/c9ceb0e15d92d0634600603b38965d9b6d986b6d.1691923900.git.fdmanana@suse.com/
> 
> Thanks for the report.

Tested-by: Rob Landley <rob@landley.net>

Worked for me. Specifically, using mkroot in toybox 0.8.10 to build a tiny qemu
test system:

$ mkroot/mkroot.sh CROSS=x86_64 LINUX=~/linux/btrfs-patched KEXTRA=BTRFS_FS
$ cd root/x86_64
$ truncate -s 1g btrfs.img
$ mkfs.btrfs btrfs.img
$ ./run-qemu.sh -hda btrfs.img
# wget http://10.0.2.2/btrfs-test-static
# chmod +x btrfs-test-static
# grep btrfs /proc/mounts # just confirming
# mkdir /mnt/sub
# cd /mnt/sub
# for i in {1..1000}; do touch $i; done
# /btrfs-test-static
# exit

The test program completed normally after 1000 files.

Thank you kindly,

Rob
