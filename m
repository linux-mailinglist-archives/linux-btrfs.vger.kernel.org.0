Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE0E6DE3AA
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Apr 2023 20:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDKSQO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Apr 2023 14:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjDKSQO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Apr 2023 14:16:14 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D46161AC
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 11:15:35 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pmIWS-0008I4-H9; Tue, 11 Apr 2023 20:15:16 +0200
Message-ID: <7e2ec2c1-e962-603c-17e7-a3c11285bf63@leemhuis.info>
Date:   Tue, 11 Apr 2023 20:15:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
Content-Language: en-US, de-DE
To:     dsterba@suse.cz, Michael Bromilow <stick.insects22@gmail.com>
Cc:     Boris Burkov <boris@bur.io>, Chris Mason <clm@meta.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Sergei Trofimovich <slyich@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Christopher Price <pricechrispy@gmail.com>,
        anand.jain@oracle.com, clm@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <CAHmG9huwQcQXvy3HS0OP9bKFxwUa3aQj9MXZCr74emn0U+efqQ@mail.gmail.com>
 <CAEzrpqeOAiYCeHCuU2O8Hg5=xMwW_Suw1sXZtQ=f0f0WWHe9aw@mail.gmail.com>
 <ZBq+ktWm2gZR/sgq@infradead.org> <20230323222606.20d10de2@nz>
 <20d85dc4-b6c2-dac1-fdc6-94e44b43692a@leemhuis.info>
 <ZCxKc5ZzP3Np71IC@infradead.org>
 <41141706-2685-1b32-8624-c895a3b219ea@meta.com> <20230404185138.GB344341@zen>
 <6a54fa77-9a0c-8844-2eb0-b65591e97a16@gmail.com>
 <20230411175239.GA19619@twin.jikos.cz>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230411175239.GA19619@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1681236936;df081d68;
X-HE-SMSGID: 1pmIWS-0008I4-H9
X-Spam-Status: No, score=-2.2 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.04.23 19:52, David Sterba wrote:
> On Mon, Apr 10, 2023 at 03:03:37AM +0100, Michael Bromilow wrote:
>> On 04/04/2023 19:51, Boris Burkov wrote:
>>> On Tue, Apr 04, 2023 at 02:15:38PM -0400, Chris Mason wrote:
>>>> So, honestly from my POV the async discard is best suited to consumer
>>>> devices.  Our defaults are probably wrong because no matter what you
>>>> choose there's a drive out there that makes it look bad.  Also, laptops
>>>> probably don't want the slow dribble.
>>>
>>> Our reasonable options, as I see them:
>>> - back to nodiscard, rely on periodic trims from the OS.
>>> - leave low iops_limit, drives stay busy unexpectedly long, conclude that
>>>    that's OK, and communicate the tuning/measurement options better.
>>> - set a high iops_limit (e.g. 1000) drives will get back to idle faster.
>>> - change an unset iops_limit to mean truly unlimited async discard, set
>>>    that as the default, and anyone who cares to meter it can set an
>>>    iops_limit.
>>>
>>> The regression here is in drive idle time due to modest discard getting
>>> metered out over minutes rather than dealt with relatively quickly. So
>>> I would favor the unlimited async discard mode and will send a patch to
>>> that effect which we can discuss.
>>
>> Will power usage be taken into consideration? I only noticed this regression
>> myself when my laptop started to draw a constant extra ~10W from the constant
>> drive activity, so I imagine other laptop users would also prefer a default
>> which avoids this if possible. If "relatively quickly" means anything more
>> than a few seconds I could see that causing rather significant battery life
>> reductions.
> 
> This may need to be configured from userspace, e.g. from
> laptop-mode-tools, I'm not sure if any of the power usage info is
> available from kernel.

Well, from the point of the regression tracker this looks a bit
different: if a system after a kernel updates draw a constant extra
~10W, it's a regression that needs to be fixed. But in the end it's of
course Linus option that matters.

But whatever, Boris afaics is looking for an improved solution that
hopefully avoids the extra power consumption and at the same time does
the right thing on modern enterprise storage devices, so that the
defaults work for the majority of the users. Hopefully this will work
out. :-D

Ciao, Thorsten
