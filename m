Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29806BF144
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 13:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfIZL0s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 07:26:48 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43223 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfIZL0r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 07:26:47 -0400
Received: by mail-io1-f67.google.com with SMTP id v2so5460594iob.10
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2019 04:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WJOxXb7vu2fb4msgSxVWHZOvd1IfawLwdnKyKR3bh60=;
        b=aBJSyYFkliL7pkFRzU4NH8KVfrhB/ymtlh8URQH8zHft5TXdPje1Xp8z9ekej/pWhJ
         xgd7W6RhKn4scU6vioUTwUf3QwQWPunoWPXebPNOAbD870YAC9iP2XCEXlTK2ojrQPgU
         4F8cGFUFeT5ZC/ZwJwEG+uhXhRD9hH8yl3WrbuNVemj6WlgV5DYA2QY/SnRSPGBqi7AQ
         Bud53rU2mZXAmKPF6UQh9v7ldZpxJr1TmCrwMvXG9fJ49qzOjC2LADRaU4D5tu0/GMmC
         3whfbypj7iD5rFech0lSIPVMLv5awMulQIhkSan/mV6DmAnukEq/wb9PDjcW60n+k1ut
         9jHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WJOxXb7vu2fb4msgSxVWHZOvd1IfawLwdnKyKR3bh60=;
        b=dTrMByfsSyzc8ZcG1y5FE8XrlqvRb7AsRKeOG1sqtSom+vGybclHiry5w1Ww+5hF1x
         MZt47pOTGo4mM/bSka4jPyv4ZyPQt448xoPUuZWUSJ1MBCbvMsjjMplm50HLsGW92srp
         jUNYHY1JupQ9P0X980nGtV8oSzEUNQZSoCzcjfRE5fUp37GCGLn+/R0j+Q9/WjX0C1OP
         iAs3oAH+wzjO2B3uncQlYtG1ciZjojEgX5amuETjaRqQBYX0sdI3l9GqG0KCwY9j4Bu8
         bTM9GDKUQQi1x5+OcXFB1x/3ieff2k3NL75jtl3Lqs3TLcU8dgvWwwDLc3fjTT2+YPtn
         IoQg==
X-Gm-Message-State: APjAAAWrI6LipsX5k9ejOEbGxJ2yjhDaqqK2o4lzMo8SwZNdAwjN8RG3
        r5lECpc8idNsghNTY+SYTSA=
X-Google-Smtp-Source: APXvYqx0QPM3E4Odp1PFkwoRUPwEWMa6yXaekTQI0cirrDzH4mFggmTRodCE3w+zj2tk/+eqHaeWRQ==
X-Received: by 2002:a92:60b:: with SMTP id x11mr1746782ilg.212.1569497206766;
        Thu, 26 Sep 2019 04:26:46 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id m14sm491723ild.3.2019.09.26.04.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 04:26:46 -0700 (PDT)
Subject: Re: Btrfs filesystem trashed after OOM scenario
To:     Nick Bowler <nbowler@draconx.ca>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@kernel.org>
References: <CADyTPEwDifK+YA6-kh6F8Wpf9C0+acQjkxGBJhf1ATTpZbMSYg@mail.gmail.com>
 <CAJCQCtQM_Pn4SubsJw9t0TjF8WNoqguxVf--UYH6K82Ch8Dm9Q@mail.gmail.com>
 <CADyTPEw=g7y+DroBt+CO-=8T3=8kO5Muj6Ts3LrkwDtKx2=zcQ@mail.gmail.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <5c94f84b-a3ed-7f67-0178-e531895c5128@gmail.com>
Date:   Thu, 26 Sep 2019 07:26:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CADyTPEw=g7y+DroBt+CO-=8T3=8kO5Muj6Ts3LrkwDtKx2=zcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-09-25 00:25, Nick Bowler wrote:
> On Tue, Sep 24, 2019, 18:34 Chris Murphy, <lists@colorremedies.com> wrote:
>> On Tue, Sep 24, 2019 at 4:04 PM Nick Bowler <nbowler@draconx.ca> wrote:
>>> - Running Linux 5.2.14, I pushed this system to OOM; the oom killer
>>> ran and killed some userspace tasks.  At this point many of the
>>> remaining tasks were stuck in uninterruptible sleeps.  Not really
>>> worried, I turned the machine off and on again to just get everything
>>> back to normal.  But I guess now that everything had gone horribly
>>> wrong already at this point...
>>
>> Yeah the kernel oomkiller is pretty much only about kernel
>> preservation, not user space preservation.
> 
> Indeed I am not bothered at all by needing to turn it off and on again
> in this situation.  But filesystems being completely trashed is
> another matter...
> 
>>> - Upon reboot, the system boots OK but now btrfs is throwing zillions
>>> of checksum errors.  After some time the filesystem is remounted
>>> readonly and I lose the ability to interact with the system at all, so
>>> it gets powered off.
>>>
>>> - Now the filesystem is unmountable.
>>
>> The transid errors look like they might be caused by the 5.2 regression
>>
>> https://lore.kernel.org/linux-btrfs/20190911145542.1125-1-fdmanana@kernel.org/T/#u
>>
>> Fixed since 5.2.15 and 5.3.0.
> 
> Yikes, so my decision to update the latest kernel two weeks ago
> perhaps was a very bad one.  Should've stuck with 4.19.y I guess.
> 
>> So if you're willing to blow shit up again, you can try to reproduce
>> with one of those.
> 
> Well I could try but it sounds like this might be hard to reproduce...
> 
>> I was also doing oomkiller blow shit up tests a few weeks ago with
>> these same problem kernels and never hit this bug, or any others. I
>> also had to do a LOT of force power offs because the system just
>> became totally wedged in and I had no way of estimating how long it
>> would be for recovery so after 30 minutes I hit the power button. Many
>> times. Zero corruptions. That's with a single Samsung 840 EVO in a
>> laptop relegated to such testing.
> 
> Just a thought... the system was alive but I was able to briefly
> inspect the situation and notice that tasks were blocked and
> unkillable... until my shell hung too and then I was hosed.  But I
> didn't hit the power button but rather rebooted with sysrq+e, sysrq+u,
> sysrq+b.  Not sure if that makes a difference.
Not sure if this mattered, but as a general rule, unless you're dealing 
with an issue with the disk, you should always issue sysrq+s and wait a 
few seconds (or until the message that all filesystems have been synced 
shows up if you're on the console and can see kernel messages) before 
issuing a sysrq+u.  Remounting all filesystems read-only through sysrq+u 
does not reliably flush caches before forcing everything read-only.
> 
>> Might be a different bug. Not sure. But also, this is with
>>
>>> [  347.551595] CPU: 3 PID: 1143 Comm: mount Not tainted 4.19.34-1-lts #1
>>
>> So I don't know how an older kernel will report on the problem caused
>> by the 5.2 bug.
> 
> This is the kernel from systemrescuecd.  I can try taking a disk image
> and mounting on another machine with a newer linux version.
> 
> Thanks,
>    Nick
> 

