Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F2A78C411
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Aug 2023 14:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbjH2MRl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Aug 2023 08:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbjH2MRi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Aug 2023 08:17:38 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85971A3
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 05:17:35 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qaxf4-0007Lv-9L; Tue, 29 Aug 2023 14:17:34 +0200
Message-ID: <efbe13a5-1c6d-e6fe-25be-bd942823432c@leemhuis.info>
Date:   Tue, 29 Aug 2023 14:17:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Scrub of my nvme SSD has slowed by about 2/3
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     linux-btrfs@vger.kernel.org
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
 <1d611dbb-8aee-9a6e-701c-6498f1b51c34@leemhuis.info>
In-Reply-To: <1d611dbb-8aee-9a6e-701c-6498f1b51c34@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1693311455;fad1446c;
X-HE-SMSGID: 1qaxf4-0007Lv-9L
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12.07.23 13:02, Linux regression tracking #adding (Thorsten Leemhuis)
wrote:

> On 03.07.23 22:19, Tim Cuthbertson wrote:
>> Yesterday, I noticed that a scrub of my main system filesystem has
>> slowed from about 2.9 gb/sec to about 949 mb/sec. My scrub used to run
>> in about 12 seconds, now it is taking 51 seconds. I had just installed
>> Linux kernel 6.4.1 on Arch Linux, upgrading from 6.3.9. At first I
>> suspected the new kernel, but now I am not so sure.
> 
> Thanks for the report. It seems it will take some work to address this,
> so to be sure the issue doesn't fall through the cracks unnoticed, I'm
> adding it to regzbot, the Linux kernel regression tracking bot:
> 
> #regzbot ^introduced e02ee89baa66

#regzbot resolve: various changes merged for 6.6 improve things again;
more planned; backporting is planned, too;
#regzbot ignore-activity

(yes, that is not idea, but that's how it is sometimes)

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

