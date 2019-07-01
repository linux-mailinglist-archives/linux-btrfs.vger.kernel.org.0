Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A38E5BA65
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2019 13:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbfGALLo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jul 2019 07:11:44 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:6215 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbfGALLo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jul 2019 07:11:44 -0400
Received: from 6.3.0.0.0.0.e.f.f.f.2.6.e.1.2.0.0.f.5.c.f.a.e.e.4.3.e.0.1.0.a.2.ip6.arpa (unknown [78.234.252.95])
        by smtp1-g21.free.fr (Postfix) with ESMTP id 870D9B0056B;
        Mon,  1 Jul 2019 13:11:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by 6.3.0.0.0.0.e.f.f.f.2.6.e.1.2.0.0.f.5.c.f.a.e.e.4.3.e.0.1.0.a.2.ip6.arpa (Postfix) with ESMTP id 08599AAFA;
        Mon,  1 Jul 2019 11:11:41 +0000 (UTC)
Received: from 6.3.0.0.0.0.e.f.f.f.2.6.e.1.2.0.0.f.5.c.f.a.e.e.4.3.e.0.1.0.a.2.ip6.arpa ([IPv6:::1])
        by localhost (mail.couderc.eu [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id axhm-OlKk3Gb; Mon,  1 Jul 2019 11:11:40 +0000 (UTC)
Received: from [192.168.163.11] (unknown [192.168.163.11])
        by 6.3.0.0.0.0.e.f.f.f.2.6.e.1.2.0.0.f.5.c.f.a.e.e.4.3.e.0.1.0.a.2.ip6.arpa (Postfix) with ESMTPSA id D252BAAF7;
        Mon,  1 Jul 2019 11:11:40 +0000 (UTC)
Subject: Re: What are the maintenance recommendation ?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <f9ceb3c8-b557-16d6-3f21-f2de34dfae9c@couderc.eu>
 <2798e32e-92cb-529e-e0bc-8e79a3a5ff69@gmx.com>
From:   Pierre Couderc <pierre@couderc.eu>
Message-ID: <eb1cf0e4-4e63-5e8d-4040-2f3e42cac774@couderc.eu>
Date:   Mon, 1 Jul 2019 13:11:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <2798e32e-92cb-529e-e0bc-8e79a3a5ff69@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 6/30/19 9:20 AM, Qu Wenruo wrote:
>
> On 2019/6/30 上午2:50, Pierre Couderc wrote:
>> 1- Is there a summary of btrfs recommendations for maintenance ?
>>
>> I have read somewhere that  a monthly  btrfs scrub is recommended. Is
>> there somewhere a reference,  an "official" (or not...) guide of all
>> that  is recommended ?
> I'd say scrub can tell you how bad your disks are.
> But at least, I'd recommend to do an offline check (btrfs check) and a
> scrub after every unclean shutdown.
OK, thank you !
>
> For the maintenance recommends, Zygo Blaxell should has a pretty good
> ideas on this topic.
Is there some link to these "ideas"...?
>> I am lost in the wiki...
>>
>> 2- Is there a repair guide ? I see all these commands restore, scrub,
>> rescue. Is there a guide of what to do when a disk has some errors ? The
>> man does not say when use some command...
> If you're doing scrub routinely, it should give your a more reliable
> early warning than SMART.
>
> Normally for bad disk(s), you could replace them in advance. E.g when
> the disk begins to have unrecoverable errors suddenly, it is a good time
> to replace it.
>
> If it's too late that the fs can't be mounted any more, my recommends are:
> 1. btrfs check --readonly and save the output
>     Sent the output to the mail list for help. The mail list will provide
>     much detailed solution to recover.
>
> 2. try to mount the fs RO and save the output
>     Just like step 1.
>
> 3. Btrfs-restore if you have enough space
>     The only generic and easy to use way to salvage data.
>
> The following methods are only for guys with some btrfs internal knowledge:
> - mount with usebackroot option
> - btrfs-find-root paired with btrfs check --chunk-root/--tree-root
>    Both methods are mostly the same, trying to use old roots.
>    Not reliable.
> - experimental kernel patches to skip extent tree at mount time
>    Kernel equivalent for btrfs-restore. Needs to recompile at least btrfs
>    kernel module. Only works for extent tree related corruption.
>
Thank you, I note that
