Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834A3462916
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Nov 2021 01:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhK3A3y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 29 Nov 2021 19:29:54 -0500
Received: from foss.arm.com ([217.140.110.172]:52214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230092AbhK3A3y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 19:29:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 699BA1042;
        Mon, 29 Nov 2021 16:26:35 -0800 (PST)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 815D83F5A1;
        Mon, 29 Nov 2021 16:26:34 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     peterz@infradead.org, vincent.guittot@linaro.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [REGRESSION] 5-10% increase in IO latencies with nohz balance patch
In-Reply-To: <YaUuyN3h07xlEx8j@localhost.localdomain>
References: <YaUH5GFFoLiS4/3/@localhost.localdomain> <87ee6yc00j.mognet@arm.com> <YaUYsUHSKI5P2ulk@localhost.localdomain> <87bl22byq2.mognet@arm.com> <YaUuyN3h07xlEx8j@localhost.localdomain>
Date:   Tue, 30 Nov 2021 00:26:26 +0000
Message-ID: <878rx6bia5.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/11/21 14:49, Josef Bacik wrote:
> On Mon, Nov 29, 2021 at 06:31:17PM +0000, Valentin Schneider wrote:
>> On 29/11/21 13:15, Josef Bacik wrote:
>> > On Mon, Nov 29, 2021 at 06:03:24PM +0000, Valentin Schneider wrote:
>> >> Would you happen to have execution traces by any chance? If not I should be
>> >> able to get one out of that fsperf thingie.
>> >>
>> >
>> > I don't, if you want to tell me how I can do it right now.  I've disabled
>> > everything on this box for now so it's literally just sitting there waiting to
>> > have things done to it.  Thanks,
>> >
>>
>> I see you have Ftrace enabled in your config, so that ought to do it:
>>
>>   trace-cmd record -e 'sched:*' -e 'cpu_idle' $your_test_cmd
>>
>
> http://toxicpanda.com/performance/trace.dat
>
> it's like 16mib.  Enjoy,
>

Neat, thanks!

Runqueue depth seems to be very rarely greater than 1, tasks with ~1ms
runtime and lots of sleeping (also bursty kworker activity with activations
of tens of µs), and some cores (Internet tells me that Xeon Bronze 3204
doesn't have SMT) spend most of their time idling. Not the most apocalyptic
task placement vs ILB selection, but the task activation patterns roughly
look like what I was thinking of - there might be hope for me yet.

I'll continue the headscratching after tomorrow's round of thinking juice.

> Josef
