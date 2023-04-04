Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980C76D5E0A
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 12:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjDDKup (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 06:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbjDDKu2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 06:50:28 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D194219
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 03:50:11 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pjeEP-0005yE-8i; Tue, 04 Apr 2023 12:49:41 +0200
Message-ID: <20d85dc4-b6c2-dac1-fdc6-94e44b43692a@leemhuis.info>
Date:   Tue, 4 Apr 2023 12:49:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
Content-Language: en-US, de-DE
To:     Sergei Trofimovich <slyich@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Christopher Price <pricechrispy@gmail.com>,
        anand.jain@oracle.com, boris@bur.io, clm@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, regressions@lists.linux.dev
References: <CAHmG9huwQcQXvy3HS0OP9bKFxwUa3aQj9MXZCr74emn0U+efqQ@mail.gmail.com>
 <CAEzrpqeOAiYCeHCuU2O8Hg5=xMwW_Suw1sXZtQ=f0f0WWHe9aw@mail.gmail.com>
 <ZBq+ktWm2gZR/sgq@infradead.org> <20230323222606.20d10de2@nz>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230323222606.20d10de2@nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1680605411;4d30c03e;
X-HE-SMSGID: 1pjeEP-0005yE-8i
X-Spam-Status: No, score=-1.9 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23.03.23 23:26, Sergei Trofimovich wrote:
> On Wed, 22 Mar 2023 01:38:42 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> 
>> On Tue, Mar 21, 2023 at 05:26:49PM -0400, Josef Bacik wrote:
>>> We got the defaults based on our testing with our workloads inside of
>>> FB.  Clearly this isn't representative of a normal desktop usage, but
>>> we've also got a lot of workloads so figured if it made the whole
>>> fleet happy it would probably be fine everywhere.
>>>
>>> That being said this is tunable for a reason, your workload seems to
>>> generate a lot of free'd extents and discards.  We can probably mess
>>> with the async stuff to maybe pause discarding if there's no other
>>> activity happening on the device at the moment, but tuning it to let
>>> more discards through at a time is also completely valid.  Thanks,  

BTW, there is another report about this issue here:
https://bugzilla.redhat.com/show_bug.cgi?id=2182228

/me wonders if there is a opensuse report as well, but a quick search
didn't find one

And as fun fact or for completeness, the issue even made it to reddit, too:
https://www.reddit.com/r/archlinux/comments/121htxn/btrfs_discard_storm_on_62x_kernel/

>> FYI, discard performance differs a lot between different SSDs.
>> It used to be pretty horrible for most devices early on, and then a
>> certain hyperscaler started requiring decent performance for enterprise
>> drives, so many of them are good now.  A lot less so for the typical
>> consumer drive, especially at the lower end of the spectrum.
>>
>> And that jut NVMe, the still shipping SATA SSDs are another different
>> story.  Not helped by the fact that we don't even support ranged
>> discards for them in Linux.

Thx for your comments Christoph. Quick question, just to be sure I
understand things properly:

I assume on some of those problematic devices these discard storms will
lead to a performance regression?

I also heard people saying these discard storms might reduce the life
time of some devices - is that true?

If the answer to at least one of these is "yes" I'd say we it might be
best to revert 63a7cb130718 for now.

> Josef, what did you use as a signal to detect what value was good
> enough? Did you crank up the number until discard backlog clears up in a
> reasonable time?
> 
> I still don't understand what I should take into account to change the
> default and whether I should change it at all. Is it fine if the discard
> backlog takes a week to get through it? (Or a day? An hour? A minute?)
> 
> Is it fine to send discards as fast as device allows instead of doing 10
> IOPS? Does IOPS limit consider a device wearing tradeoff? Then low IOPS
> makes sense. Or IOPS limit is just a way to reserve most bandwidth to
> non-discard workloads? Then I would say unlimited IOPS as a default
> would make more sense for btrfs.

/me would be interested in answers to these questions as well

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
