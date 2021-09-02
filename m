Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB673FF72A
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 00:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbhIBWbm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 18:31:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:44125 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231642AbhIBWbl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Sep 2021 18:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630621840;
        bh=myApfS3LM3TiMvFc7+izW/TPD6++ql5ARSG2YKgtoXY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=c5P36V+NzUTrZbnDEesPkt6QYbu05wamZaaKhl0HjPAt8la+Wu+fgg8mGt0tUoI3w
         1EQxcsfdHLAmDEXKxsW0t5jFyq5Xde993ld7Om+3dtcENmmL/aLsNLkq1TUnvpGSPP
         Db9pqUOtYie+pkMf59E6hjZJLOtYUOQSH6eFPxL8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZCfD-1mPzrS2kmf-00VBZH; Fri, 03
 Sep 2021 00:30:40 +0200
Subject: Re: [PATCH 1/5] btrfs: sysfs: introduce qgroup global attribute
 groups
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210831094903.111432-1-wqu@suse.com>
 <20210831094903.111432-2-wqu@suse.com> <20210902162840.GA3379@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <9f48f55f-a4f3-ad0c-e48e-1da02b0ef068@gmx.com>
Date:   Fri, 3 Sep 2021 06:30:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210902162840.GA3379@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:es5knGGKF9clQekQiE9KcRT2+6xGrEMiIBHehgjs14An3ZkkfAE
 AqypJB3ixR9+YHeGiMYIFO9zG1tsT4KRGLfdeFrUb2s25TEfPS0VTdfubUNeZbGHtKm23Se
 wT3YiFwAX3Oh28jBfEPnm3TYb+Cku57ScZZATY5m8aGT4c1RWJDX8qo6oNkLo6HZXvTjU8g
 ExZwrD7jXPAc1Aplgcf0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XCJDfqk7Jxs=:jRneOOd4+7DblhPIIviAEp
 nJMhvZE0fTLqBUruy9rfp+JBqEymh0XNSXMW5UE4Kx1QqrA5fik2FiIk+IInXcpFWnQ777LtP
 /of0CI9Paa/pzdirB0RWu/xJtvOhPl2lM4+9bx6Bl/b4g34VthjOAQX/mvrk4mRy2JXAvkv4G
 UtKwUoaQ+2eftcog1XMO5LuvbWmnHynGMT/nyXfkrooxtXklFqEVeHCPtk6d82mjkjncZV591
 Uo2RftodnjDBIGtQZrU5SExGA7aMcp/GYuPEbCxw4QuKohqE5dc2qgYLWURZ86+VqqF88IR/D
 oJ8j9lwrcsUrk4U2LFAgQzX65EV4hLuQL+o4tRyaTCX49SpbAjgQjTz4sGMnvWv5y8GzYKKkJ
 QzbpK0xCw5PDlTVBNsJKbGOKYYS3ptxurNiU3hciPvFXe4ViaFlvd8/Xr3zk3MjG85aqysLfr
 kFvAMS9MxgHcDpEbQmZ8YWOySGccqC/5ef0OJ9TMQbTFrnR3WK250oNYVW/MuD4CGus0m7taW
 03HkDwjPmNXXDnMotmJQrK2uMEnLw0TX67tLr1COCcoBIq3Xdx7JcGs/XY6GCcyFHxK/LMjAH
 /frCtaySQB+DyHE00yqMybS/5rKgP2ykVmf1kkfa36i79Y4oD+4xehs0JAnw7yvFXHGdp4u56
 edL3nnMQgRjSsGnN5+XXb6+4ERPLFhs11AT9OePBQEXVPon9x+GGbXTS/P2AKsaZVsD/OVZ/N
 nuyZrntiaHpesZd4ouuy9Xto97e10z7w49jOVaZrhyRfF04anO39u/dT+Sxq4NF9U+mNiSKml
 yw/fMq6POmuTSl2SGY2d79t8v/DG6WWrLWE5L7YF/RM9na+df7nr4IV1FQmLeUle2WcFtF5fE
 Ja2ez/4Gsh05tEEntMosJoJpHZ3VWwBmbuBhl0T6PQmHhGZ8FYHQ850rKlnCsaSPOFJ+uWGU4
 l3pltg2PhIkWAGl8bcLQqo75T5TGEqqIhDydihjUdUEY8aF6xG6UTirznWDtISSMULVFIszkF
 8y3rNLl0FgMWkY3e7JIu29EOJQcR/cT310JYLajAu0+gI3FjnPmNfObzskTiatB37MYfMAmWh
 Qbq1PMhtgMqDPyfDoFttYV48kuNut7T610ybo5SFcADq8DgAf0ThKkHaA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/3 =E4=B8=8A=E5=8D=8812:28, David Sterba wrote:
> On Tue, Aug 31, 2021 at 05:48:59PM +0800, Qu Wenruo wrote:
>> Although we already have info kobject for each qgroup, we don't have
>> global qgroup info attributes to show things like qgroup flags.
>>
>> Add this qgroups attribute groups, and the first member is qgroup_flags=
,
>> which is a read-only attribute to show human readable qgroup flags.
>>
>> The path is:
>>   /sys/fs/btrfs/<uuid>/qgroups/qgroup_flags
>>
>> The output would look like:
>>   ON | INCONSISTENT
>
> So that's another format of sysfs file, we should try to keep them
> consistent or follow common practices. The recommended way for sysfs is
> to have one file per value, and here it follows the known states.
>
> So eg
>
> /sys/fs/.../qgroups/enabled		-> 0 or 1
> /sys/fs/.../qgroups/inconsistent	-> 0 or 1
> ...
>
> The files can be also writable so rescan can be triggered from sysfs, or
> quotas disabled eventually. For the start exporting the state would be
> sufficient though.
>
OK, that sounds indeed better than the current solution.

Although there may be a small window that one reading 3 attributes could
get inconsistent view, as it's no longer atomic.

Would that be a problem?

Thanks,
Qu
