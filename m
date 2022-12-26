Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F4F6562E0
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Dec 2022 14:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiLZNhX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Dec 2022 08:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLZNhW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Dec 2022 08:37:22 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C37219C;
        Mon, 26 Dec 2022 05:37:20 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p9nfL-00088C-EJ; Mon, 26 Dec 2022 14:37:19 +0100
Message-ID: <985064d2-fe9c-a02b-21f1-e6ce93c594c0@leemhuis.info>
Date:   Mon, 26 Dec 2022 14:37:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [6.2][regression] after commit
 947a629988f191807d2d22ba63ae18259bb645c5 btrfs volume periodical forced
 switch to readonly after a lot of disk writes #forregzbot
Content-Language: en-US, de-DE
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <CABXGCsNzVxo4iq-tJSGm_kO1UggHXgq6CdcHDL=z5FL4njYXSQ@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CABXGCsNzVxo4iq-tJSGm_kO1UggHXgq6CdcHDL=z5FL4njYXSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672061840;637a1322;
X-HE-SMSGID: 1p9nfL-00088C-EJ
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[Note: this mail contains only information for Linux kernel regression
tracking. Mails like these contain '#forregzbot' in the subject to make
then easy to spot and filter out. The author also tried to remove most
or all individuals from the list of recipients to spare them the hassle.]

On 25.12.22 22:32, Mikhail Gavrilov wrote:
> Hi,
> It is curious but it happens only on machine which have BTRFS volume
> combined from two high speed nvme (pcie 4) SSD in RAID 0. On machines
> with BTRFS volume from one HDD the bug does not appear.
> 
> To bisect the problematic commit, I had to sweat a lot. At each step,
> I downloaded the 150 GB game "Assassin's Creed Valhalla" 4 times and
> deleted it. For make sure that the commit previous to
> 947a629988f191807d2d22ba63ae18259bb645c5 is definitely not affected by
> the bug, I downloaded this game 10 times, which should have provided
> more than 1.5 Tb of data writing to the btrfs volume.
> 
> Here is result of my bisection:
> 947a629988f191807d2d22ba63ae18259bb645c5 is the first bad commit
> [...]
> Before going to readonly, the preceding line in kernel log display a message:
> [ 1908.029663] BTRFS: error (device nvme0n1p3: state A) in
> btrfs_run_delayed_refs:2147: errno=-5 IO failure
> 
> I also attached a full kernel log.

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced 947a629988f191807d2d22ba63ae18259bb64
#regzbot title btrfs: volume periodical forced switch to readonly after
a lot of disk writes
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
