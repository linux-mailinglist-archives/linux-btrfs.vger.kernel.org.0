Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505C9731F93
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jun 2023 20:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjFOSAO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jun 2023 14:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjFOSAN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jun 2023 14:00:13 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A82513E
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jun 2023 11:00:12 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q9rGT-0007E7-B5; Thu, 15 Jun 2023 20:00:10 +0200
Message-ID: <926b81be-8ac3-fae0-f4df-e03ab7f0a691@leemhuis.info>
Date:   Thu, 15 Jun 2023 20:00:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Regression that causes data csum mismatch
Content-Language: en-US, de-DE
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <da414ecc-f329-48ec-94d2-67c94755effb@gmx.com>
 <20230613160247.GK13486@twin.jikos.cz>
 <0523f743-38e0-bc21-df4e-6a9d4e842ecf@gmx.com>
 <20230615153219.GX13486@twin.jikos.cz>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230615153219.GX13486@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1686852012;aaadfec6;
X-HE-SMSGID: 1q9rGT-0007E7-B5
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15.06.23 17:32, David Sterba wrote:
> On Wed, Jun 14, 2023 at 06:17:31AM +0800, Qu Wenruo wrote:
>> On 2023/6/14 00:02, David Sterba wrote:
>>> It would be good to share the updates to fstests with the tests. I've
>>> added the data csum check to _check_btrfs_filesystem.
>>>
>>>> Furthermore this is profile independent, I have see all profiles hitting
>>>> such data corruption.
>>>
>>> How does the corruption look like?
>>
>> Just some csum mismatch, which both scrub and btrfs check
>> --check-data-csum report.
>>
>> One of my concern here is the temperature of my environment, with AC
>> running it no longer reproduces...
>>
>> Hope it's really just a false alert.
> 
> No signs of problems so far, blaming it on overheating would fit the
> mysterious hard to reproduce bugs. We'll keep testing and see but this
> should not get a status of regression until we have something more
> concrete.

Don't worry, I was keeping an eye on it already after I saw Qu's msg and
would have removed it from the list of tracked issues before sending my
next report to Linus.

Anyway, with your additional confirmation, let me remove this from the
tracking right now:

#regzbot inconclusive: likely a overheating problem and not a regression
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

