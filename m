Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32B86C9752
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Mar 2023 20:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjCZSDM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Mar 2023 14:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCZSDL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Mar 2023 14:03:11 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63002706
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Mar 2023 11:03:08 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pgUhs-0004Jo-RF; Sun, 26 Mar 2023 20:03:04 +0200
Message-ID: <4fd4f5b1-0b73-5137-646a-a6d981c26696@leemhuis.info>
Date:   Sun, 26 Mar 2023 20:03:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH 8/8] btrfs: turn on -Wmaybe-uninitialized
Content-Language: en-US, de-DE
To:     Guenter Roeck <linux@roeck-us.net>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        dsterba@suse.cz
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1671221596.git.josef@toxicpanda.com>
 <1d9deaa274c13665eca60dee0ccbc4b56b506d06.1671221596.git.josef@toxicpanda.com>
 <20230222025918.GA1651385@roeck-us.net>
 <20230222163855.GU10580@twin.jikos.cz>
 <6c308ddc-60f8-1b4d-28da-898286ddb48d@roeck-us.net>
 <feb05eef-cc80-2fbe-f28a-b778de73b776@leemhuis.info>
 <caed9824-c05d-19a9-d321-edefab17c4f0@roeck-us.net>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <caed9824-c05d-19a9-d321-edefab17c4f0@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1679853788;4f9fd02b;
X-HE-SMSGID: 1pgUhs-0004Jo-RF
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 12.03.23 15:37, Guenter Roeck wrote:
> On 3/12/23 06:06, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 22.02.23 18:18, Guenter Roeck wrote:
>>> On 2/22/23 08:38, David Sterba wrote:
>>>> On Tue, Feb 21, 2023 at 06:59:18PM -0800, Guenter Roeck wrote:
>>>>> On Fri, Dec 16, 2022 at 03:15:58PM -0500, Josef Bacik wrote:
>>>>>> We had a recent bug that would have been caught by a newer compiler
>>>>>> with
>>>>>> -Wmaybe-uninitialized and would have saved us a month of failing
>>>>>> tests
>>>>>> that I didn't have time to investigate.
>>>>>>
>>>>>
>>>>> Thanks to this patch, sparc64:allmodconfig and parisc:allmodconfig now
>>>>> fail to commpile with the following error when trying to build images
>>>>> with gcc 11.3.
>>>>>
>>>>> Building sparc64:allmodconfig ... failed


> There was a patch:
> 
> #regzbot monitor:
> https://patchwork.kernel.org/project/linux-btrfs/patch/dc091588d770923c3afe779e1eb512724662db71.1678290988.git.sweettea-kernel@dorminy.me/
> #regzbot fix: btrfs: fix compilation error on sparc/parisc
> #regzbot ignore-activity

Thx for this, Guenter, unfortunately the fix got a different subject
when it was applied. Happens, no worries, but regzbot thus needs to get
told manually:

#regzbot fix: 10a8857a1beaa015efba7d56e06243d484549fb6
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
