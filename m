Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E334D543240
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 16:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241069AbiFHOLn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 10:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241014AbiFHOLm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 10:11:42 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542091D64D6
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 07:11:41 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u26so32713628lfd.8
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jun 2022 07:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OA9VYjSO8kCESKq3Hwc+caIrPTFYZSu9Zx1EENj091c=;
        b=pMNV7nfmI+EjWqvNwBTS2icX5rKkMTN+I8bE8lIhek/oG8kA9+mhm2StyIcZCw3nQT
         cW2K+32DN0yofxwDZeCvf5KOCXpKYIsbAMEIdYWrdQ+DO/t+uyweOqw0CzZTPfu4xMht
         W0vfB0kr1qpnGf2WAlwYU3XvwRL0v4BXibQggi0XyavHWDmnwo5I/y86DnLIf629TqYo
         DpipI98MUj5vUNWp3dR+qjfZbu01d8yBVParMtNlcT7/KIbT87oKBkyuwn/5HsSKbi5I
         Wgce/t9Vm1eh9zBv2Jwa+DayRDPPxrEfMy4QVI1qUj+q+FDNrwAetl8BkibKw8EEu3aw
         V2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OA9VYjSO8kCESKq3Hwc+caIrPTFYZSu9Zx1EENj091c=;
        b=6mL090c+GFGbaaYnegU8VUOknrqTh2DjUJZvst8jE6Zt4fIyvE8jdTA292gVeoVALw
         73L+b8cDNI+ZvhmovfrvsFANnszg+pBVOp7DL4FEDD75QaYRj72RR1By8/eYXwIGsiLN
         NMcZ62N52QqTFsnw0g5pWm5Ml1UJ9oR02N1nevbCas+kdhZpk7d3eOO2HSpiDYHnwuk9
         eQWPN5/9Q45/RvVzt2qF4OK5SlP7w+yxyn7tMR/0d1gIEMe2HrOZ/lt4XvEbGtsIoKdb
         iPwUI15qdfAupHKEeT6sbeF32NbzvHPUV1HTH1Hv/2vO1Nu8srMRVz2Kr9MRNi7Ssyuv
         q+Jw==
X-Gm-Message-State: AOAM531EgBC7uLZzC5cC4vLuckiu0HmHzuR0hGWi7soPp6sahv/npoAF
        IJsLYj3Vm0BuYXxwtyS8vcA=
X-Google-Smtp-Source: ABdhPJxdLvVx/iZpbmI6AI0V37eXo6WX0h60bpjU0eTUrGq5wKPbtUn7kgrXhFxxS/7GnAHUsv/Lkw==
X-Received: by 2002:a05:6512:987:b0:479:3983:e744 with SMTP id w7-20020a056512098700b004793983e744mr11231055lft.402.1654697499376;
        Wed, 08 Jun 2022 07:11:39 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:326:f23d:11ea:8518:cd53? ([2a00:1370:8182:326:f23d:11ea:8518:cd53])
        by smtp.gmail.com with ESMTPSA id h16-20020a2e3a10000000b002556d356a1esm2436718lja.140.2022.06.08.07.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 07:11:38 -0700 (PDT)
Message-ID: <cf220242-25dd-9241-01d5-38555c262d9e@gmail.com>
Date:   Wed, 8 Jun 2022 17:11:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: What mechanisms protect against split brain?
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>
Cc:     Forza <forza@tnonline.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <c31c664.705b352f.1810f98f3ee@tnonline.net>
 <20220608104421.3759.409509F4@e16-tech.com>
 <20220608181502.4AB1.409509F4@e16-tech.com>
 <a97ff3a3-7b14-e6a4-32e9-b9da8cec422e@gmx.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <a97ff3a3-7b14-e6a4-32e9-b9da8cec422e@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08.06.2022 13:32, Qu Wenruo wrote:
> 
> 
> On 2022/6/8 18:15, Wang Yugui wrote:
>> Hi, Forza, Qu Wenruo
>>
>> I write a script to test RAID1 split brain base on Qu's work of raid5(*1)
>> *1: https://lore.kernel.org/linux-btrfs/53f7bace2ac75d88ace42dd811d48b7912647301.1654672140.git.wqu@suse.com/T/#u
> 
> No no no, that is not to address split brain, but mostly to drop cache
> for recovery path to maximize the chance of recovery.
> 
> It's not designed to solve split brain problem at all, it's just one
> case of such problem.
> 
> In fact, fully split brain (both have the same generation, but
> experienced their own degraded mount) case can not be solved by btrfs
> itself at all.
> 
> Btrfs can only solve partial split brain case (one device has higher
> generation, thus btrfs can still determine which copy is the correct one).
> 

Start with both devices having the same generation number N.

Mount device1 separately, do some writes, device has generation N+1.

Mount device2 separately, do some writes, device has generation N+2.

Applying changes between N+1 and N+2 to device1 is wrong because content
of N+1 is different on both devices.

So there is absolutely no difference between "same generation" and
"higher generation".

The only thing btrfs could do is to try to detect this and refuse to
integrate another device. One suggested rather radical approach was to
change UUID on degraded mount, but this is probably unfeasible in real life.

Removing missing device from device list in superblock (or at least
marking it as permanently missing until replaced) is probably another
option.

And write intent log as discussed further in this thread could be used
as well - if btrfs detects write intent log on device it should refuse
to add it to existing filesystem.
