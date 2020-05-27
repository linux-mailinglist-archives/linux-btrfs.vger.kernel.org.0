Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D51E1E4EB7
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 21:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgE0T73 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 15:59:29 -0400
Received: from smtp-34.italiaonline.it ([213.209.10.34]:52817 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726701AbgE0T72 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 15:59:28 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 May 2020 15:59:27 EDT
Received: from venice.bhome ([78.12.136.199])
        by smtp-34.iol.local with ESMTPA
        id e257jebNytrlwe257jJKkP; Wed, 27 May 2020 21:51:18 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1590609078; bh=xUgI3EBQYYpoF9ncYwjN36+7GwSVSuF/lFx1B0yBUs8=;
        h=From;
        b=vnujpAlVyfWT/SbukgbTu4CZGC3ZTonA5W/xWoYTSKq2TxOluFj2QJCaZvGW7oDQf
         602bP2QvmYKygqwb/3oazmsMZZq+uKpzP+tgDqBj0TrIKIt/3m4kyMgBbRHv45zqRJ
         hKl1Y5SAoXEVxW4LMLZtjfi0OGjK2bJ0U+SPoCYc9FhcalXR0+UH83WLOKN3Dd2R1P
         qD4UH+PFCmyzzI9vbDHtqqlCI0r8043QBp9NLohWylhsToqjUGCMVM3f0Ds+Gzpc0G
         F225x2Q/CCewguHVbTnJZ7w+olbDurWZWYr0W92eznRcNgl9a/fjc3c9K04+Xv8W2u
         PMo3pvvlqDYOg==
X-CNFS-Analysis: v=2.3 cv=TOE7tGta c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=4ioPoZy6ZwoBv4AQaZ4A:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: Planning out new fs. Am I missing anything?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Justin Engwer <justin@mautobu.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGAeKut52ymR5WVDTxJgQ=-fZzJ+pU8oVF89p4mBO-eaoAHiKw@mail.gmail.com>
 <CAJCQCtSyJp0LiaO246NcEX-p7rk8-h1NocW4o4rJgN=B1Kwrug@mail.gmail.com>
 <46fa65a3-137b-3164-0998-12bb996c15ef@gmail.com>
 <CAJCQCtTmcRfrZEtdnUgF0CkFFWDW-d5-LtM4SFKO4F7Xr9ai_A@mail.gmail.com>
 <0d3b740d-a431-cca0-3841-a85e49ffff9e@libero.it>
 <CAJCQCtTt0cusvmo-W3vUqmWNbGeH1f3JFSD4gLNBE2_38avd9A@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <a53aaabf-412e-2124-49fd-c995dc5dc473@inwind.it>
Date:   Wed, 27 May 2020 21:51:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTt0cusvmo-W3vUqmWNbGeH1f3JFSD4gLNBE2_38avd9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIQwmAhiaRoE7YRdKiePKG+Ub9BHyWysb/tNhzmY4d+yZxCAY9mHZ8IPv8YPEAuq6HOcDkLuVoO7q6JxHLWSVQ6ZiIS8d4puf+y4EPE/aJTreXXePlA+
 29D2bjz/F82TUzvEZNj4IGSwaTCfjULU8WqTR5Kk43OPXFd0UIKZSNIYSHgciPCv3p6kFGT2KuD+LLfaMTHnlF5fJNAby2MzvdIq3wD8Lvzu3G1wiCHkfpcI
 06A2c+OID8j4Qh5YEvE1dUETs+n/lqVTVMnXD0Usohk=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/27/20 8:40 PM, Chris Murphy wrote:
> On Wed, May 27, 2020 at 10:23 AM Goffredo Baroncelli <kreijack@libero.it> wrote:
>>
>> Hi All,
>>
>> On 5/27/20 8:25 AM, Chris Murphy wrote:
>>> On Tue, May 26, 2020 at 11:22 PM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
>>>>
>>>> 27.05.2020 05:20, Chris Murphy пишет:
>>>>>
>>>>> single, dup, raid0, raid1 (all), raid10 are safe and stable.
>>>>
>>>> Until btrfs can reliably detect and automatically handle outdated device
>>>> I would not call any multi-device profiles "safe", at least unconditionally.
>>>
>>> I agree.
>>>
>>
>> Checking the generation of each device should be sufficient to detect "outdated" devices. Why this check is not performed ?
>> May be that I am missing something ?
> 
> But transid isn't unique enough except in isolation. Degraded volumes
> are treated completely independently. So if I take a 2x raid1 and
> mount each one degraded on separate computers and modify them. Then
> join them back together, how can Btrfs resolve the differences? It's a
> mess. Yes that is obviously a kind of sabotage. While not literal
> sabotage, the effect is the same if you have alternating degraded
> drives in successive boots.

Even tough we can't close all the holes, we can reduce the likelihood of a this issue.

Anyway mounting a filesystem with different generation number is wrong. And the
fact the we can't prevent all the kind of mismatches doesn't mean that
we don't have to do anything.

I am thinking about adding a "opt in" check. I.e. if the mismatch happens
btrfs should raise a warning. If a flag is passed at mount (like
mount -o prevent-generation-mismatch) and the generations don't match,
the mount fails.

Then, on the basis of feedback returned, in the future we can change the
flags from "opt in" to "opt out" (mount -o no-prevent-generation-mismatch)

> 
> So you just cannot use degraded with either fstab or rootflags. It's
> bad advice to anyone who gives it and we need to be vigilant about
> recommending against it. Maybe the man 5 btrfs page should expressly
> say not to include degraded in fstab, or at least warn there are
> consequences.
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
