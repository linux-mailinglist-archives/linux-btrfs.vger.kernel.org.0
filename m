Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3804C6A6829
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 08:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCAHe2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 02:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCAHe1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 02:34:27 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC41E1517C;
        Tue, 28 Feb 2023 23:34:26 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pXGyl-0000Uc-Mv; Wed, 01 Mar 2023 08:34:23 +0100
Message-ID: <d7fe697d-09eb-3a59-6cb3-8eec480d1407@leemhuis.info>
Date:   Wed, 1 Mar 2023 08:34:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Regression] Bug 216961 - Severe IO scheduling starvation issues
 with btrfs
Content-Language: en-US, de-DE
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wyatt Childers <kernel.dbwta@haxing.ninja>, pmacedo@gmail.com,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        dsterba@suse.cz
References: <0ca02b1f-ab00-9fa6-aecc-c2c46d624e49@leemhuis.info>
 <e0998928-0f4e-f2a9-2e77-3e4bab459688@leemhuis.info>
 <CAEzrpqc6tweHqKKPZYyVuOXH1Wd+hmrTPfcrpa-5-btU_Z24Fg@mail.gmail.com>
 <06a5ada1-d1b8-3139-3a60-f43958f90f79@leemhuis.info>
 <20230228194039.GP10580@suse.cz>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230228194039.GP10580@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1677656066;a6dd2248;
X-HE-SMSGID: 1pXGyl-0000Uc-Mv
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28.02.23 20:40, David Sterba wrote:
> On Fri, Feb 17, 2023 at 06:17:58AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 16.02.23 23:39, Josef Bacik wrote:
>>> On Thu, Feb 16, 2023 at 12:43 PM Thorsten Leemhuis
>>> <regressions@leemhuis.info> wrote:
>>>>
>>>> I might be missing something, but it looks like the report was ignored.
>>>> Is there a reason for that?
>>> Mostly just being blind.
>> Happens.
>>
>>>  I've responded to the BZ, I'll investigate
>>> through the BZ.
> According to the bug it's a problem in BFQ.

Yeah, I noticed yesterday, after I looked into the issue again, as it
looked stalled. But as I already wrote in a comment in the ticket
yesterday:

Did anyone tell the bfq developers about this?

Doesn't look like it. Adding them to the list of recipients them now,
even if they might know about it. If not:

Paolo, Jens, there seems to be a regression in BFQ likely introduced
between 5.19 and 6.0 that people apparently notice often with Btrfs. For
details see:
https://bugzilla.kernel.org/show_bug.cgi?id=216961

Josef apparently has seen report about this as well where switching to
another io scheduler helped:
https://bugzilla.kernel.org/show_bug.cgi?id=216961#c8

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot title: bfq: severe IO scheduling starvation issues with btrfs
