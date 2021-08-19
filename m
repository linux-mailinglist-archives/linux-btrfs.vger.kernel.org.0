Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5393F1976
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 14:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbhHSMfd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 08:35:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:56555 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239659AbhHSMf3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629376490;
        bh=g2lCu4Ydjy6aV0NTxu89PrlWFaLRF2d5YZMOGzff2h8=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=KH2KY0VCuw+dJEdxcO82hzj7J7xZC2tV5xM+Rvb99dasdfkfGR1RqSBo7qkRfgUIR
         v4MixPaaQ54J/zp45ftJtpS2tlgu/SBo1XmkwgBumQrjtRTte6u7VqfnZAiqyxg74t
         9/5LaqTcc8mtHwfp+W31qpTZ0fxNiKL8xPo6KAao=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mj8mb-1mkooe3hKf-00f6pR; Thu, 19
 Aug 2021 14:34:50 +0200
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210816235540.9475-1-wqu@suse.com>
 <8babcc1b-2456-8632-7b56-f9867d333a0d@suse.com>
 <ac42cd2a-82dd-1987-4e18-e9d27e127172@gmx.com>
 <20210818230032.GA5047@twin.jikos.cz>
 <0f469eae-d30f-64cf-b07f-fb0a097e6741@gmx.com>
 <20210819122326.GD5047@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] btrfs: replace BUG_ON() in btrfs_csum_one_bio() with
 proper error handling
Message-ID: <27ffe5f1-db6b-aa72-949f-60984070a1ba@gmx.com>
Date:   Thu, 19 Aug 2021 20:34:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210819122326.GD5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ehO0zEuan4OB3nmddV6gGaVjtXWbRCPNzxapih9bOrq93jFS22j
 Umrzn34nPNapvyHUHK1n/Sh+N0b7nF3403eYO7rQqAxNE6NpUKvy6fLPjrn4jXUdkUSTjHq
 9LHF8/Ao+TH8ScG9FkgxNSlkokmHDU00supC+y33IrUbD2tbh4kLoLn3+6PY4KgGdzypJ9H
 Jt95qpnSYgEbszod2iFXQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ELTEvoS4xVM=:/HVb/7k2lDj8WeY+wwrPc3
 dt78toBKNC8FeqJ9MJWNY8Vj9dOF2A9++Aq7wKGy32cbBow93FiYfe8UedLiaodC7ZdXZCEm3
 vscLeRCPVBWT53djrG+HmE3je6h+TNkLbtQbEgrb40CXCN4A6yOHBk/g+ICMR9AyZEQson0yj
 ck0o/YPSF0xXjdtlAo0PlNjRzQ364hz2dv1JWwNQpUtJ3g9LUscz48OS8WIRLYs+crL8jlYKC
 z3Fg5Y1X8rBruLQTjg2d+7t67ZnKM/wUD69wAKzuI2xgwsI2SAg9rWPMRtU45fNnIU0b7vdDO
 LXWuPEQq3/uf1aXx7HCj6D1qQu8Z97UlN639ZJprMlUvWA7lE/U8mXVihZ7IjDosnSSFRCaTX
 yJHgzVlzLfnMzW60k6TtqKt7yXZBMT6P4J7OYusLjucgy3CLMdRmRTbHlALtPZowHW15vMoSE
 6PXSl829jD5A8RypKYh7OTA+DX/nGQR9fkmF+94LhpvOiPwtnXFAJoORsOU0B4xDJ+Vo6rYwa
 8pnB88wukQfjxh3Z0zYeaRuuqFr1CkeL26n4yZOZuSDU9gAvkVBcn89sCMKzdCr4aTFqrF5y2
 JeCg/OE9zxRPPUqzsEWefgvoQOibAnh64c0mxFKHqBBWnlOcWM9xCgQ+SfBVx5fCpr1I93Wg0
 bQ3m6t0/cFQ0MEVrxLXqQru6KbddUAPaSOD8AfgHwB7it/scO16ZdvfiAApzQ6S4eWm4oZhH3
 GBDiHfMtzOTMVzYmV5od8Z/J/J09nE/72DBaZqqQehicNeXYlfERQ2Lz/vgIbWGhq5rJXZf2I
 eOG/TIMjJWfM27GYkaMVf50kVGgpAIVwLuN53rB/iAduvyuBABrhofv8xDke7NzdzUWCWi3FF
 tCVxFbvc1tt6/7mWx5QwjmFjCQ9wjfbYca6rtYIBfoQ1wq0yF/iWZiCtrAu4WBWYsHHOgV4dx
 HgF42A24D+hRuBpWWdZmDxRxkgs4HpOURVKUkU4UJEmmFPlq4G0MTjKDgjYvn3DV2f2STjOb2
 MyfMtT6RkIOLK/WiJYSJPM+FuOuyfzvhOzoEX6QN24BDsaRpOtnJEtAl0scJdmT8xNSC/yIZ9
 2Cis+yQ2+R92kBXun/YaM97qHNq9H5UMB97eQanNwD2Ofm6kzDc5RgNXA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/19 =E4=B8=8B=E5=8D=888:23, David Sterba wrote:
> On Thu, Aug 19, 2021 at 09:08:00AM +0800, Qu Wenruo wrote:
>> I want to play safe by never bothering the WARN_ON() in if () condition
>> anymore.
>>
>> The fact that some if (WARN_ON()) is acceptable and some is not is
>> already worrying.
>>
>> Can we just stick to no-WARN_ON-in-if policy?
>
> So what would be the reocommended way to do that? Also with the obvious
> question "is the warning needed at all?"

IMHO we should use WARN() other than WARN_ON().
The WARN_ON(), even with proper condition, is not providing enough info.

We want the warning mostly for fstests to catch the error, so that we
know it's something wrong.
>
> 	if (condition) {
> 		WARN_ON(1);
> 		...
> 	}
>
> This will hide the condition in the warning report, the value is usually
> in RAX and sometimes it helps to analyze what happend. We'd have to
> either duplicate it like

The condition itself is not really that helpful, compared to proper
warning message.

In fact, the line number is more useful than the condition itself.

>
> 	if (condition) {
> 		WARN_ON(condition);
> 		...
> 	}
>
> or use a temporary variable.
>
> Another question is what to do with current if+WARN calls. Lots of them
> are there without a comment. Ideally if there's a need for a warning
> even on a production build, there should be a message also printed.

We can add comments on them when we're going to refactor the code.

But historic problems shouldn't be a blockage for us to update our
current code guideline.

>
> Lots of them seem to be an assert in disguise (like in
> extract_ordered_extent) or are called before returning EUCLEAN. We've
> talked about this a few times before, we'd need more fine grained
> warnings/assertions or have them better documented. There are 300+ of
> them so that's a lot for a single pass audit, but at least some of them
> share a common pattern and can be unified.
>

This already shows that we need a proper guideline for how to do proper
warning.

Thanks,
Qu
