Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BEF48DC0C
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jan 2022 17:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236813AbiAMQmG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 11:42:06 -0500
Received: from foss.arm.com ([217.140.110.172]:48516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231919AbiAMQmE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 11:42:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3223E106F;
        Thu, 13 Jan 2022 08:42:04 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED6483F774;
        Thu, 13 Jan 2022 08:42:02 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        peterz@infradead.org, vincent.guittot@linaro.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, guro@fb.com, clm@fb.com
Subject: Re: [REGRESSION] 5-10% increase in IO latencies with nohz balance patch
In-Reply-To: <YdMhQRq1K8tW+S05@localhost.localdomain>
References: <87bl22byq2.mognet@arm.com> <YaUuyN3h07xlEx8j@localhost.localdomain> <878rx6bia5.mognet@arm.com> <87wnklaoa8.mognet@arm.com> <YappSLDS2EvRJmr9@localhost.localdomain> <87lf0y9i8x.mognet@arm.com> <87v8zx8zia.mognet@arm.com> <YbJWBGaGAW/MenOn@localhost.localdomain> <99452126-661e-9a0c-6b51-d345ed0f76ee@leemhuis.info> <87tuf07hdk.mognet@arm.com> <YdMhQRq1K8tW+S05@localhost.localdomain>
Date:   Thu, 13 Jan 2022 16:41:57 +0000
Message-ID: <87k0f37fl6.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/01/22 11:16, Josef Bacik wrote:
> On Wed, Dec 22, 2021 at 04:07:35PM +0000, Valentin Schneider wrote:
>> 
>> Hi,
>> 
>> On 22/12/21 13:42, Thorsten Leemhuis wrote:
>> > What's the status here? Just wondering, because there hasn't been any
>> > activity in this thread since 11 days and the festive season is upon us.
>> >
>> > Was the discussion moved elsewhere? Or is this still a mystery? And if
>> > it is: how bad is it, does it need to be fixed before Linus releases 5.16?
>> >
>> 
>> I got to the end of bisect #3 yesterday, the incriminated commit doesn't
>> seem to make much sense but I've just re-tested it and there is a clear
>> regression between that commit and its parent (unlike bisect #1 and #2):
>> 
>> 2127d22509aec3a83dffb2a3c736df7ba747a7ce mm, slub: fix two bugs in slab_debug_trace_open()
>> write_clat_ns_p99     195395.92     199638.20      4797.01    2.17%
>> write_iops             17305.79      17188.24       250.66   -0.68%
>> 
>> write_clat_ns_p99     195543.84     199996.70      5122.88    2.28%
>> write_iops             17300.61      17241.86       251.56   -0.34%
>> 
>> write_clat_ns_p99     195543.84     200724.48      5122.88    2.65%
>> write_iops             17300.61      17246.63       251.56   -0.31%
>> 
>> write_clat_ns_p99     195543.84     200445.41      5122.88    2.51%
>> write_iops             17300.61      17215.47       251.56   -0.49%
>> 
>> 6d2aec9e123bb9c49cb5c7fc654f25f81e688e8c mm/mempolicy: do not allow illegal MPOL_F_NUMA_BALANCING | MPOL_LOCAL in mbind() 
>> write_clat_ns_p99     195395.92     197942.30      4797.01    1.30%
>> write_iops             17305.79      17246.56       250.66   -0.34%
>> 
>> write_clat_ns_p99     195543.84     196183.92      5122.88    0.33%
>> write_iops             17300.61      17310.33       251.56    0.06%
>> 
>> write_clat_ns_p99     195543.84     196990.71      5122.88    0.74%
>> write_iops             17300.61      17346.32       251.56    0.26%
>> 
>> write_clat_ns_p99     195543.84     196362.24      5122.88    0.42%
>> write_iops             17300.61      17315.71       251.56    0.09%
>> 
>> It's pure debug stuff and AFAICT is a correct fix...
>> @Josef, could you test that on your side?
>
> Sorry, holidays and all that.  I see 0 difference between the two commits, and
> no regression from baseline.  It'll take me a few days to recover from the
> holidays, but I'll put some more effort into actively debugging wtf is going on
> here on my side since we're all having trouble pinning down what's going
> on.

Humph, that's unfortunate... I just came back from my holidays, so I'll be
untangling my inbox for the next few days. Do keep us posted!

> Thanks,
>
> Josef
