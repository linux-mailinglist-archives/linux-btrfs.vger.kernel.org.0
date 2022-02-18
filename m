Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21134BB782
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 12:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbiBRLBF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 06:01:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiBRLBD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 06:01:03 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280AD1ED631;
        Fri, 18 Feb 2022 03:00:47 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nL10E-0002pT-IO; Fri, 18 Feb 2022 12:00:42 +0100
Message-ID: <f0ebbdfd-d14c-b497-07fb-54eb8d71ff38@leemhuis.info>
Date:   Fri, 18 Feb 2022 12:00:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [REGRESSION] 5-10% increase in IO latencies with nohz balance
 patch
Content-Language: en-BS
To:     Roman Gushchin <guro@fb.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, peterz@infradead.org,
        vincent.guittot@linaro.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        clm@fb.com
References: <878rx6bia5.mognet@arm.com> <87wnklaoa8.mognet@arm.com>
 <YappSLDS2EvRJmr9@localhost.localdomain> <87lf0y9i8x.mognet@arm.com>
 <87v8zx8zia.mognet@arm.com> <YbJWBGaGAW/MenOn@localhost.localdomain>
 <99452126-661e-9a0c-6b51-d345ed0f76ee@leemhuis.info>
 <87tuf07hdk.mognet@arm.com> <YdMhQRq1K8tW+S05@localhost.localdomain>
 <87k0f37fl6.mognet@arm.com> <YeBZ7qNjPsonEYZz@carbon.dhcp.thefacebook.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <YeBZ7qNjPsonEYZz@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1645182047;beeb04d5;
X-HE-SMSGID: 1nL10E-0002pT-IO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking. Top-posting
for once, to make this easy accessible to everyone.

FWIW, this is a gentle reminder that I'm still tracking this regression.
Afaics nothing happened in the last few weeks.

If the discussion continued somewhere else, please let me know; you can
do this directly or simply tell my regression tracking bot yourself by
sending a reply to this mail with a paragraph containing a regzbot
command like "#regzbot monitor
https://lore.kernel.org/r/some_msgi@example.com/"

If you think there are valid reasons to drop this regressions from the
tracking, let me know; you can do this directly or simply tell my
regression tracking bot yourself by sending a reply to this mail with a
paragraph containing a regzbot command like "#regzbot invalid: Some
explanation" (without the quotes).

Anyway: I'm putting it on back burner now to reduce the noise, as this
afaics is less important than other regressions:

#regzbot backburner: Culprit is hard to track down
#regzbot poke

You likely get two more mails like this after the next two merge
windows, then I'll drop it if I don't here anything back.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.


On 13.01.22 17:57, Roman Gushchin wrote:
> On Thu, Jan 13, 2022 at 04:41:57PM +0000, Valentin Schneider wrote:
>> On 03/01/22 11:16, Josef Bacik wrote:
>>> On Wed, Dec 22, 2021 at 04:07:35PM +0000, Valentin Schneider wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 22/12/21 13:42, Thorsten Leemhuis wrote:
>>>>> What's the status here? Just wondering, because there hasn't been any
>>>>> activity in this thread since 11 days and the festive season is upon us.
>>>>>
>>>>> Was the discussion moved elsewhere? Or is this still a mystery? And if
>>>>> it is: how bad is it, does it need to be fixed before Linus releases 5.16?
>>>>>
>>>>
>>>> I got to the end of bisect #3 yesterday, the incriminated commit doesn't
>>>> seem to make much sense but I've just re-tested it and there is a clear
>>>> regression between that commit and its parent (unlike bisect #1 and #2):
>>>>
>>>> 2127d22509aec3a83dffb2a3c736df7ba747a7ce mm, slub: fix two bugs in slab_debug_trace_open()
>>>> write_clat_ns_p99     195395.92     199638.20      4797.01    2.17%
>>>> write_iops             17305.79      17188.24       250.66   -0.68%
>>>>
>>>> write_clat_ns_p99     195543.84     199996.70      5122.88    2.28%
>>>> write_iops             17300.61      17241.86       251.56   -0.34%
>>>>
>>>> write_clat_ns_p99     195543.84     200724.48      5122.88    2.65%
>>>> write_iops             17300.61      17246.63       251.56   -0.31%
>>>>
>>>> write_clat_ns_p99     195543.84     200445.41      5122.88    2.51%
>>>> write_iops             17300.61      17215.47       251.56   -0.49%
>>>>
>>>> 6d2aec9e123bb9c49cb5c7fc654f25f81e688e8c mm/mempolicy: do not allow illegal MPOL_F_NUMA_BALANCING | MPOL_LOCAL in mbind() 
>>>> write_clat_ns_p99     195395.92     197942.30      4797.01    1.30%
>>>> write_iops             17305.79      17246.56       250.66   -0.34%
>>>>
>>>> write_clat_ns_p99     195543.84     196183.92      5122.88    0.33%
>>>> write_iops             17300.61      17310.33       251.56    0.06%
>>>>
>>>> write_clat_ns_p99     195543.84     196990.71      5122.88    0.74%
>>>> write_iops             17300.61      17346.32       251.56    0.26%
>>>>
>>>> write_clat_ns_p99     195543.84     196362.24      5122.88    0.42%
>>>> write_iops             17300.61      17315.71       251.56    0.09%
>>>>
>>>> It's pure debug stuff and AFAICT is a correct fix...
>>>> @Josef, could you test that on your side?
>>>
>>> Sorry, holidays and all that.  I see 0 difference between the two commits, and
>>> no regression from baseline.  It'll take me a few days to recover from the
>>> holidays, but I'll put some more effort into actively debugging wtf is going on
>>> here on my side since we're all having trouble pinning down what's going
>>> on.
>>
>> Humph, that's unfortunate... I just came back from my holidays, so I'll be
>> untangling my inbox for the next few days. Do keep us posted!
> 
> I'm trying to bisect it independently and make sense of it too, thanks to Josef
> for providing me a test setup. From the very first data I've got yesterday,
> the only thing I can say the data is very noisy and I'm not totally convinced
> that the regression is coming from the patch which was blamed initially.
> 
> I hope to make more progress today/tomorrow, will keep you updated.
> 
> Thanks!
> 
