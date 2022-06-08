Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C4A542F62
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 13:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238070AbiFHLkw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 07:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238310AbiFHLkv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 07:40:51 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A18515EA6B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 04:40:48 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 134so12232868iou.12
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jun 2022 04:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DVrzwyzzmDvYrHr9UqUnYLSk2sslhA9rOMMcd/bOFR4=;
        b=A0JFpZiABtR1y7UWehtyiGOLBlWeScQGFx9xTn7X2/HKfYV4Eve+d+lbfrV4/ecD8I
         xVFw1kR2anZ2Rw3l8l7cBREtzSYhrfqmD/Cp1zL8H5aRTfXqoS7OBkop4K1VKWqRihkd
         NYfiuBvMB+xA+d5FOYOfnk955pk1qsgGQk7EFxOgMwUhFHVmNdCxW9JakEvMq9tlnSKP
         EKKms9q28g3wq5tMsmS9S9k1IrZNof+nPNOO5AAKzP5BIFBnSpURuwHUv1gsx17Hz05i
         fRlc3KM4lNkXek2+TWRF+NJWC31GnZ2sXf1CqTvZpaWYajPSutA0HQKw53KTZJRczN4M
         /NTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DVrzwyzzmDvYrHr9UqUnYLSk2sslhA9rOMMcd/bOFR4=;
        b=GFEEj5dtRboFAE1H9W7Kw7yxIonMD4Dn0+0ZTOvzMlRDQZ9uiekodvoeGXwwCuBUbR
         5tRLmXjSLoLn6WRiNGD0oCblHRFNZURp+nWLJFK42sJHOqfsOVJZWA7RFjxWyerdCjW2
         ioEXU0+xh5KTbPaX7mOyEWl/3US4Y66boUVKAp2FV/60ZnqfIH+4XmWh/H5qdtwbZmxQ
         WD80Oprd/H65SvrV4VBF/TJISpDflJ4H76LlOCC61/ov8McDg30ET/wnUaoFJjjJwMTg
         vd0O+dEi3ZXDKoOxdfc/KngaoE2rLj+TN5Ax/jydMDxeTQj06shiaxcbCV+x9B2zMcPM
         rxqA==
X-Gm-Message-State: AOAM533ilVLGIkVROLGkaVyFjTNEaujF2yK9wqQXFn7CLQ6lT6UFXc4o
        JIur/E7+dqwWa4jfZtNRjIAQ7Rh/4SQ=
X-Google-Smtp-Source: ABdhPJwQ8e5LSbnMCXzK4KbO9fLrQd5+kOqbAJet+/hI/0cDWHNL/hbjfJo48Frl2gEJzJlpXdh+Ag==
X-Received: by 2002:a5d:9bd3:0:b0:669:50b4:8762 with SMTP id d19-20020a5d9bd3000000b0066950b48762mr7755557ion.74.1654688447426;
        Wed, 08 Jun 2022 04:40:47 -0700 (PDT)
Received: from [192.168.50.106] (99-40-201-230.lightspeed.cntmoh.sbcglobal.net. [99.40.201.230])
        by smtp.gmail.com with ESMTPSA id r11-20020a92760b000000b002d39719b34dsm8660955ilc.87.2022.06.08.04.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 04:40:47 -0700 (PDT)
Message-ID: <99585fd0-ba79-f03a-582d-db1c1b0e4e78@gmail.com>
Date:   Wed, 8 Jun 2022 07:40:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: What mechanisms protect against split brain?
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Forza <forza@tnonline.net>, Qu Wenruo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <c31c664.705b352f.1810f98f3ee@tnonline.net>
 <20220608104421.3759.409509F4@e16-tech.com>
 <20220608181502.4AB1.409509F4@e16-tech.com>
 <a97ff3a3-7b14-e6a4-32e9-b9da8cec422e@gmx.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
In-Reply-To: <a97ff3a3-7b14-e6a4-32e9-b9da8cec422e@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08/06/2022 06.32, Qu Wenruo wrote:
> In fact, fully split brain (both have the same generation, but
> experienced their own degraded mount) case can not be solved by btrfs
> itself at all.
> 
> Btrfs can only solve partial split brain case (one device has higher
> generation, thus btrfs can still determine which copy is the correct one).
Of note, this is not unique to BTRFS. The quorum requirement that Ceph 
and many other distributed storage systems impose on writes exists to 
very specifically avoid this type of situation.
> 
>>
>> #!/bin/bash
>> set -uxe -o pipefail
>>
>> mnt=/mnt/test
>> dev1=/dev/vdb1
>> dev2=/dev/vdb2
>>
>>    dmesg -C
>>    mkdir -p $mnt
>>
>>    mkfs.btrfs -f -m raid1 -d raid1 $dev1 $dev2
>>    mount $dev1 $mnt
>>    xfs_io -f -c "pwrite -S 0xee 0 1M" $mnt/file1
>>    sync
>>    umount $mnt
>>
>>    btrfs dev scan -u $dev2
>>    mount -o degraded $dev1 $mnt
>>    #xfs_io -f -c "pwrite -S 0xff 0 128M" $mnt/file2
>>    mkdir -p $mnt/branch1; /bin/cp -R /usr/bin $mnt/branch1 #complex 
>> than xfs_io
>>    umount $mnt
>>
>>    btrfs dev scan
>>    btrfs dev scan -u $dev1
>>    mount -o degraded $dev2 $mnt
> 
> Your case is the full split brain case.
> 
> Not possible to solve.
> 
> In fact, if you don't do the degraded mount on dev2, btrfs is completely
> fine to resilve the fs without any problem.
> 
And this, in turn, is why BTRFS refuses to mount degraded without the 
user explicitly asking for it, and why having `degraded` in your mount 
options in `/etc/fstab` (or on the kernel command line) is so dangerous. 
There’s no way for BTRFS (or the block layer for that matter) to 
reliably differentiate between a missing device resulting from a device 
failure and a missing device resulting from other issues, and those 
other issues can easily result in one half of a two-device volume not 
being present for one boot, and the other half not being present on the 
next boot.
