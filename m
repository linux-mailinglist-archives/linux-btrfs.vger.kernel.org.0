Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB2E399A8E
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jun 2021 08:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFCGWd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Jun 2021 02:22:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:44283 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229667AbhFCGWd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Jun 2021 02:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622701247;
        bh=dRaoHfXurg33YvwD2zVwB5w32shphx9A2jQ2F4olfck=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QQljDcWsB15JaYc4DZedjQz3SatS8G1uoIzl7LzH5ZNsWGolweHo2ZTnDd5QsVHFL
         253DWUhSpN9kZQWn22McZ4t6xr8Z2dAAHkKn7lWYFPEhaRtAaT86hyrJA//hlPPW0C
         tKFUu/cJo0YERhnMmOgHqvHhG3ymZxHsD0J6k+ds=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2V0B-1lO3Xt2K2p-013z9K; Thu, 03
 Jun 2021 08:20:47 +0200
Subject: Re: [PATCH v4 00/30] btrfs: add data write support for subpage
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210531085106.259490-1-wqu@suse.com>
 <20210602175746.GT31483@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <a24d015d-4b22-d6a1-9e51-f2a0bfbfc73f@gmx.com>
Date:   Thu, 3 Jun 2021 14:20:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602175746.GT31483@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gPeNlxUhgnJ66CQcY8ORamRGFHd42xKcbSlq+G/N7tT8A1lGkQ4
 l09IXqGQ+FL+Vvngizvh2OVqKiAdaYgj2ssrJ01l9MRTk9G/2VQhvBv80Mqr83CngdDRpTk
 yT9KFWn/CMOSCBPPlO08XSNb3dqC49yROwflxdseE/HIezfin/kJIr68Rntk9bTC0i5hgzj
 x2rxUQen5/8NrzCdqGcnQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:diFnmPaDl4k=:UkGjuEmMTYa81skyGbd/H0
 pSP+y9LjeqDlRV8YwxwWHFlHQUkqxO02tBwfiXhNotiBp3lBqArbhHGfuN0IMYM00KgKvWkHQ
 A9xMtljx4NhTut4lDU+EAq7bp1sTS3OTmkck0o9r9m+HkFBdzKREtxlRVVoivwzxmRzBiDi5y
 WwxgFkUxqkO7dN1K+LEik6MyCQ/+51phmhA6qBxyj+7apmi77hwFML0jFZ+gc8nHQGdxOLhmS
 1A8L97JTIfxpfvegSuoY5a56STpeoAa9rVku/PJo789lWObZUguQDRlKmclWypo7gzFKeMMC7
 3heQoLBNn0Xre3Ss81fib1RSlDlKlzilKqWEIDN0wblPiPSAXOjmHV1Px3+ipMUC4zzXqEvrT
 vpycoSux0IzJOH2GOGab9gYwa6PVsnMODZfEkzNnoBpabT2L/tyXSkDY/sF50Elx7s+a8/Tsy
 6F5E+DHTOSTh3l/H/KWRjVw5VlhrwMpxLMikBUwjPRltBf85iqaBLiUVOYBqSS2cR7EfhvjKD
 11032r5av1lQY/74N2Vw1rR3hlP3CiAI6oAWJJcW72YAA08RWfTqAtLRfTjpCszJKm8Xp7B/X
 i44kpxxyQkfML4TYwq5I2A3yBxux4a+2GYov7XZpejL6rhYG9VHpGlZL4p+Y0O5FtbwqW6NB7
 8bHpmowNkLTMGayj96/wRI0Ma2OFwN8OjNbOVkZxy5YvhnncqTSbeiul/WRf1SUebkU62iXBI
 XdNWb2T9q3OhLuf5T5yscxTUPku+Ew7NPlL6y6ef7G2roIlixVR2WzFR0DSNc6hklSLXwUzC7
 ihhXI3ee5hGPZtOzzSdrn+UK6ayOVOF5vkQDLEBK23eg5x38bTtujbAaVtGo9yGkUcEb4x5Of
 SKGuU7Gq1zQb7t70l4ekhwB+YJTI0KqJUJB1UclWoPBMBtKFEz8WsXHfVjDhCqZxIKyF35IPW
 XB/7KPX+Mtuhh0S4+Sdq1l8h/V8U95cz/JA1pgYhlrntf9HdgV9x9T9zz2rfhoucMSmAA1dQG
 Zz/q+4BpqmmCW2u5BFkdE7+G1rk2ootqprfyIRFBrZYG69kpYCY+aAskzLsLw9/PB+JO+sf0S
 IMCvLU4BmCyslNMKD/lGzN35M0jag2v+fY2vVWu01PGGpFcgbqKwl337w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/3 =E4=B8=8A=E5=8D=881:57, David Sterba wrote:
> On Mon, May 31, 2021 at 04:50:36PM +0800, Qu Wenruo wrote:
>> This huge patchset can be fetched from github:
>> https://github.com/adam900710/linux/tree/subpage
>>
>> v4:
>> - Disable subpage defrag completely
>>    As full page defrag can race with fsstress in btrfs/062, causing
>>    strange ordered extent bugs.
>>    The full subpage defrag will be submitted as an indepdent patchset.
>
> I went through the whole series and now it's going through fstests (4k
> pages, x86) before I move it to misc-next. The write support is
> limiting some features but as it's still experimental I don't see a
> reason not to enable it.

Thank you very much!

> The defrag series has been posted, so that's
> the next step, compression won't be difficult to fix I hope and the
> inline support is not critical and will be addressed eventually.

Compression shouldn't be that complex, but I believe compression may
have more hidden corners, thus I'm not in that a hurry.

My main concern is the inline part.

In fact, if applied my btrfs check patches, even on x86_64, we can have
fsstress to create inline extent mixed with regular extent inside one inod=
e.

Although it doesn't cause any data corruption, if we really want to
inline extent exclusive, we need to address that first.

>
> I will probably reorder the patches in misc-next so the whole series is
> in one batch in case we need to bisect it.

I'm OK with the re-order, but I don't believe we really do for bisect.

As subpage is not enabled until the last patch, I doubt if we can get
any useful info from bisect.

> As this is first
> implementation, there are some known things to clean up or refactor. I'd
> rather postpone that for next cycle so there are no conflicts when
> merging fixes.

Yeah, sure. If you have any cleanups, I'm ready to learn from them and
prevent the same problem from happening in incoming patches.

Thanks,
Qu

>
> Thank you for taking the subpage support to a working state, even with
> the few limitations.
>
