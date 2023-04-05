Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0617D6D76A5
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 10:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbjDEIRP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 04:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237124AbjDEIRM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 04:17:12 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D33198E
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 01:17:10 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pjyKE-0000z7-Ih; Wed, 05 Apr 2023 10:17:02 +0200
Message-ID: <fb5c2b8c-f1da-22e8-7e81-b1f79b2152ec@leemhuis.info>
Date:   Wed, 5 Apr 2023 10:17:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
To:     Boris Burkov <boris@bur.io>, David Sterba <dsterba@suse.cz>
Cc:     Chris Mason <clm@meta.com>, Christoph Hellwig <hch@infradead.org>,
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
 <20230404192205.GF19619@suse.cz> <20230404193909.GC344341@zen>
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230404193909.GC344341@zen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1680682630;e9d7ca94;
X-HE-SMSGID: 1pjyKE-0000z7-Ih
X-Spam-Status: No, score=-1.9 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04.04.23 21:39, Boris Burkov wrote:
> On Tue, Apr 04, 2023 at 09:22:05PM +0200, David Sterba wrote:
>> On Tue, Apr 04, 2023 at 11:51:51AM -0700, Boris Burkov wrote:
>>> Our reasonable options, as I see them:
>>> - back to nodiscard, rely on periodic trims from the OS.
>>
>> We had that before and it's a fallback in case we can't fix it but still
>> the problem would persist for anyone enabling async discard so it's only
>> limiting the impact.
>>
>>> - leave low iops_limit, drives stay busy unexpectedly long, conclude that
>>>   that's OK, and communicate the tuning/measurement options better.
>>
>> This does not sound user friendly, tuning should be possible but not
>> required by default. We already have enough other things that users need
>> to decide and in this case I don't know if there's enough information to
>> even make a good decision upfront.
>>
>>> - set a high iops_limit (e.g. 1000) drives will get back to idle faster.
>>> - change an unset iops_limit to mean truly unlimited async discard, set
>>>   that as the default, and anyone who cares to meter it can set an
>>>   iops_limit.
>>>
>>> The regression here is in drive idle time due to modest discard getting
>>> metered out over minutes rather than dealt with relatively quickly. So
>>> I would favor the unlimited async discard mode and will send a patch to
>>> that effect which we can discuss.
>>
>> Can we do options 3 and 4, i.e. set a high iops so that the batch gets
>> processed faster and (4) that there's the manual override to drop the
>> limit completely?
> 
> Yup, I'm on it.
> [...]

Thx everyone for looking into this and the fruitful discussion
yesterday, much appreciated.

/me will now get back to watching this only from afar and leave things
to the experts

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
