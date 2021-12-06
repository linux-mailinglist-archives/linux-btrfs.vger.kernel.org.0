Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415F64692EB
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 10:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241456AbhLFJvv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 04:51:51 -0500
Received: from foss.arm.com ([217.140.110.172]:52436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241417AbhLFJvu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Dec 2021 04:51:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8590D11FB;
        Mon,  6 Dec 2021 01:48:21 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E6883F73D;
        Mon,  6 Dec 2021 01:48:20 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     peterz@infradead.org, vincent.guittot@linaro.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [REGRESSION] 5-10% increase in IO latencies with nohz balance patch
In-Reply-To: <YappSLDS2EvRJmr9@localhost.localdomain>
References: <YaUH5GFFoLiS4/3/@localhost.localdomain> <87ee6yc00j.mognet@arm.com> <YaUYsUHSKI5P2ulk@localhost.localdomain> <87bl22byq2.mognet@arm.com> <YaUuyN3h07xlEx8j@localhost.localdomain> <878rx6bia5.mognet@arm.com> <87wnklaoa8.mognet@arm.com> <YappSLDS2EvRJmr9@localhost.localdomain>
Date:   Mon, 06 Dec 2021 09:48:14 +0000
Message-ID: <87lf0y9i8x.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/12/21 14:00, Josef Bacik wrote:
> On Fri, Dec 03, 2021 at 12:03:27PM +0000, Valentin Schneider wrote:
>> Could you give the 4 top patches, i.e. those above
>> 8c92606ab810 ("sched/cpuacct: Make user/system times in cpuacct.stat more precise")
>> a try?
>>
>> https://git.gitlab.arm.com/linux-arm/linux-vs.git -b mainline/sched/nohz-next-update-regression
>>
>> I gave that a quick test on the platform that caused me to write the patch
>> you bisected and looks like it didn't break the original fix. If the above
>> counter-measures aren't sufficient, I'll have to go poke at your
>> reproducers...
>>
>
> It's better but still around 6% regression.  If I compare these patches to the
> average of the last few days worth of runs you're 5% better than before, so
> progress but not completely erased.
>

Hmph, time for me to reproduce this locally then. Thanks!
