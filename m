Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783195598D9
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 13:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiFXLqV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 07:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiFXLqV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 07:46:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09637B37B
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 04:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656071176;
        bh=X6oGSF4A/m1T16cmXql+hHDSqWAU/15pQ6cJ9PvRb4A=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=eQSys55Z7vJaO20VkREfXKltmhWZOEL5Yj8HLVW9mjHE5tcQjYruklY31g/cpJ8jM
         vEYklM3R0xFFc60M0AZ8TBjz2BKTkwIrJp9nZ7C2fUhO8adyVZm6Cby66YNyAXL7qi
         rTTzpFtHYvwqIcPl1vcZPN7u1+GLExR6kwEJn8QM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N33ET-1nf2DK2kY9-013Qoj; Fri, 24
 Jun 2022 13:46:16 +0200
Message-ID: <27f72ec4-a365-20ba-03f1-8d603a66e011@gmx.com>
Date:   Fri, 24 Jun 2022 19:46:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] btrfs: remove MIXED_BACKREF sysfs file
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20220624080123.1521917-1-nborisov@suse.com>
 <20220624080123.1521917-2-nborisov@suse.com>
 <21f7eb10-09d7-826c-48c3-ded892984d50@gmx.com>
 <3e01475c-8296-4cf1-14cd-5774d780b6e2@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <3e01475c-8296-4cf1-14cd-5774d780b6e2@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Eh6Y7I03ksrTGzf4hausQ0Q3ZoMJBwg3MTbrCY45m1q36fz/ruG
 MGUPC7YQBonXPs8ElFNUuYs8WQh1nhIgXXoU1ThWHbwiQYLrDZ0TICxO7pVCT4F9/M/SJOt
 PaeFZqCJfgxr1N4QTGOok1b2nk1S6Yg+LtipqD8jU73U4yZz4gDKbwA3pJPzHVZJFNaPG0G
 ptIkOl4f6nUOwejSqprvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PIbyph7lrm0=:VmIuSXrifDZmyiHP0LCcv+
 nNlpt9v+SborzZmhIURHAdEoMHENo0tIIcSlijZDTvnAQPoVv158mgGkQXoM36EfcG9r6elNG
 GV5uaAaFdaBFRm/3u02n8RrIcYTooKy0wUfGz83O7diAqJYwR+xBAiTgqtTraNoKoZttsMlua
 oQfNzIbUyJnhxXZK7UlffN2ENo1nhfVlW+gbKBQj/rO/p1WmycbsPXEVg0XAiBSUL1n0eSq/8
 bI65B5gUBJc7dppOozmNfeOFTG4GQS7OIqU4Uikxxzp8YYxDced2NzjeI7mTTOBFjt0D3HKI7
 fbsrpnVT2Kb+e7mBzxTCqg+Ynjq8bh85SRbrVLhnn1oT8JHxGgCDdpJ5xWF8LgwwORuFjezR/
 gEzM0/YdcS7UzD0MzqKkbQGbWGaRNmR3L6EKuPRfbAQbm/dn/yDOH2CKvPCoYXGfaggO4bOTI
 If0ja2tcDhE4Nmw3FPulaTdpXbXb6OiLyULyhlt5VU65/V5rDd2LxZswAiafjXL7xlvZUg3Xh
 A6+PBblrOSXIRYirmHBoFYjNBKMS3yc+xHAIXrEWvmimj9ONr/W7ykA4lDaD77hC/DDx2iJ33
 y67SWk7EbCG015MG9/Nr5Lv74CUKVk2ViVguLfGmo19KVTQK1pr2TR2AqXbD7prMcuB3JVd2/
 /BJmaoreigOMJTRFZyZbkOHW9q50hKrpnUysxEh3QpowDdf4DtdZKzrwhndlbUJoV+yIRWX2G
 rN6GAYCz82fncSxrQ0iqHl3hJTWlJaDWK63PUgRlHMmegEs0729GeqgBsDUHjT4yhNrKO0kUi
 pLZcXYnsjE+Ttk9Rq0m0NpiIGKoBLC9kM5AgyM4M7Fe9ZSGo99bAEU1AieIQs3jqsApDGtsds
 jArrDanfvTs9NqX6tihME2mPgWbXtC+XIMy8sHnqlZT3P4I4feF2QrlV5aILRr1hffuILcE5V
 THDpA/apMuAot40Ncr8LQZTHcBAgIdjcW1M/ThEX7auWaARmVTsAiEJFS2SUQQfNi2+RIX7cR
 aOwUfhiBhIW8cP15v6mQZEBwczygYi4lMOpCx86W7aKzoBabTHS6AbervNncBH8LZx4NjO0qB
 Ez27qmrOXuC3/oELynFDoMopjMO1RR08msj6bZ+JwdlGKeLbkIPFbODdg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/24 19:32, Nikolay Borisov wrote:
>
>
> On 24.06.22 =D0=B3. 11:13 =D1=87., Qu Wenruo wrote:
>>
>> I don't think that's the correct way to go.
>>
>> In fact, I think sysfs should have everything, no matter how long
>> supported it is.
>
>
> I disagree, for things which are considered stand alone features - yes.
> Like free space tree 2, but for something like backrefs, heck I think
> we've even removed code which predates mixed backrefs so I'm not
> entirely use the filesystem can function with that feature turned off,
> actually it's not possible to create a non-mixedbackref file system
> since this behavior is hard-coded in btrfs-progs. Also the commit for
> the backrefs states:
>
>
> This commit introduces a new kind of back reference for btrfs metadata.
> Once a filesystem has been mounted with this commit, IT WILL NO LONGER
> BE MOUNTABLE BY OLDER KERNELS.
>

That means we're hiding incompat features from the user.

Even if it's not tunable and should always be enabled, we still need to
add that.

History can not be forgotten.

Thanks,
Qu
