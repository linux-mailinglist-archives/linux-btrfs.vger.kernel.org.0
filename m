Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00BC2D7C64
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 18:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393378AbgLKRGT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Dec 2020 12:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391078AbgLKRF4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 12:05:56 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B67C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Dec 2020 09:05:16 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 0AE589BB36; Fri, 11 Dec 2020 17:05:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1607706311;
        bh=xU7HLbNPl9qGUt2kIJgjnTL3tYqIDzapRStbCUGoBs4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nfSzSxVn0B3G3apUQQ9ZaK8Sdg7mb7DPjlmcZRcbagRqTkbaqEE23GqE9grYBk84a
         C6hJc8ykrkAYLOsjlV2iYPk0tZ6RzKR0l8pf16xrNkdmHMOJ8O2Lrjqdk4L6phA8Ou
         9SNqDwLsF3rbmyooBQaqsJi7P0jhq3cKSvLTEW0ULX5WeY+MnB1b/qAGFxCvQDm65k
         AbfK4Ij453tbf2cHFKiOGaXxiLhKtJEwkSrAUW8kZQ8bsMwL0fP+ZWoNnUbJBuZCva
         p/ZVHL7sO9J33I9wHG78XOFfYp/msDNXPcy74y6zC2BewMbPNumm7gACjj5jwWwBS+
         aIPI5zsOpudWw==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.0 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 1EC119B89F;
        Fri, 11 Dec 2020 17:05:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1607706302;
        bh=xU7HLbNPl9qGUt2kIJgjnTL3tYqIDzapRStbCUGoBs4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CJZpbuFNI0bPAp9/Nb1QNaAamLqkGzI4S+wwZv5i4ZiujgKk3z5ApDkInNPBClK+W
         b2ombmeWuDdqzi+zbFiNNIic2weo8KWfemq0S8aYEzaLI0IOahcEqCc4ZOxQdP6y6S
         vZji/PjMWNIOKCy4LY57wtT0PCpHH+IZ2gXk2AtW1L4PySVrRoYDWfGR8XDmNERAHz
         RJnPvZDlsNG/WrQ/WCxv1z6MID4KKCExSrH5VqaEtaC0oBFQ/qyCyI1g6i/qN6aNsb
         pZ9LpLXtm1JcCLWmVV2v6PsM5fDk0ccncm7uVWMjVfBovllTqPv3OWK16ezaLussVv
         CtkhoCO3jjxAw==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id D9C751B8F8E;
        Fri, 11 Dec 2020 17:04:43 +0000 (GMT)
Subject: Re: [PATCH] btrfs-progs: scrub: warn if scrub started on a device has
 mq-deadline
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Cc:     Sidong Yang <realwakka@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20201205184929.22412-1-realwakka@gmail.com>
 <SN4PR0401MB35981F791C9508429506EDA09BCE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201210202020.GH6430@twin.jikos.cz>
 <SN4PR0401MB359892AE5C0771A8209A4A559BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201211155348.GK6430@suse.cz>
 <SN4PR0401MB3598ECDD1EE787041F3C328C9BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <SN4PR0401MB3598DA1476FDAB86BD9EE4559BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <7d14b742-feef-58b4-97da-45d05132b02e@cobb.uk.net>
Date:   Fri, 11 Dec 2020 17:04:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB3598DA1476FDAB86BD9EE4559BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/12/2020 16:42, Johannes Thumshirn wrote:
> On 11/12/2020 17:02, Johannes Thumshirn wrote:
>> [+Cc Damien ]
>> On 11/12/2020 16:55, David Sterba wrote:
>>> On Fri, Dec 11, 2020 at 06:50:23AM +0000, Johannes Thumshirn wrote:
>>>> On 10/12/2020 21:22, David Sterba wrote:
>>>>> On Mon, Dec 07, 2020 at 07:23:03AM +0000, Johannes Thumshirn wrote:
>>>>>> On 05/12/2020 19:51, Sidong Yang wrote:
>>>>>>> Warn if scurb stared on a device that has mq-deadline as io-scheduler
>>>>>>> and point documentation. mq-deadline doesn't work with ionice value and
>>>>>>> it results performance loss. This warning helps users figure out the
>>>>>>> situation. This patch implements the function that gets io-scheduler
>>>>>>> from sysfs and check when scrub stars with the function.
>>>>>>
>>>>>> From a quick grep it seems to me that only bfq is supporting ioprio settings.
>>>>>
>>>>> Yeah it's only BFQ.
>>>>>
>>>>>> Also there's some features like write ordering guarantees that currently 
>>>>>> only mq-deadline provides.
>>>>>>
>>>>>> This warning will trigger a lot once the zoned patchset for btrfs is merged,
>>>>>> as for example SMR drives need this ordering guarantees and therefore select
>>>>>> mq-deadline (via the ELEVATOR_F_ZBD_SEQ_WRITE elevator feature).
>>>>>
>>>>> This won't affect the default case and for zoned fs we can't simply use
>>>>> BFQ and thus the ionice interface. Which should be IMHO acceptable.
>>>>
>>>> But then the patch must check if bfq is set and otherwise warn. My only fear
>>>> is though, people will blindly select bfq then and get all kinds of 
>>>> penalties/problems.
>>>
>>> Hm right, and we know that once such recommendations stick, it's very
>>> hard to get rid of them even if there's a proper solution implemented.
>>>
>>>> And it's not only mq-deadline and bfq here, there are also
>>>> kyber and none. On a decent nvme I'd like to have none instead of bfq, otherwise
>>>> performance goes down the drain. If my workload is sensitive to buffer bloat, I'd
>>>> use kyber not bfq.
>>>
>>> I'm not sure about high performance devices if the scrub io load on the
>>> normal priority is the same problem as with spinning devices. Assuming
>>> it is, we need some low priority/idle class for all schedulers at least.
>>>
>>>> So IMHO this patch just makes things worse. But who am I to judge.
>>>
>>> In this situation we need broader perspective, thanks for the input,
>>> we'll hopefully come to some conclusion. We don't want to make things
>>> worse, now we're left with workarounds or warnings until some brave soul
>>> implements the missing io scheduler functionality.
>>>
>>
>> I think that's all we can do now.
>>
>> Damien (CCed) did some work on mq-deadline, maybe he has an idea if this is
>> possible/doable.
>>
> 
> Ha I have a stop gap solution, we could temporarily change the io scheduler to bfq
> while the scrub job is running and then back to whatever was configured.
> 
> Of cause only if bfq supports the elevator_features the block device requires.
> 
> Thoughts?
> 

I would prefer you didn't mess with the scheduler I have chosen (or only
if asked to with a new option). My suggestion:

1. If -c or -n have been specified explicitly, check the scheduler and
error if it is known that it is incompatible.

2. If -c/-n have not been specified, just warn (not fail) if the
scheduler is known to be incompatible with the default idle class request.

3. Provide a way to suppress the warning in step 2 (is -q enough, or
does that also suppress other useful/important messages?).

4. Expand the description in the man page which currently says "Note
that not all IO schedulers honor the ionice settings." It could read
something like:

"Note that not all IO schedulers honor the ionice settings. At time of
writing, only bfq honors the ionice settings although newer kernels may
change that. A warning will be shown if the currently selected IO
scheduler is known to not support ionice."

