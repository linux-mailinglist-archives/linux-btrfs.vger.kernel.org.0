Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A72F362C5F
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Apr 2021 02:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbhDQASn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 20:18:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:52773 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231997AbhDQASm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 20:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618618695;
        bh=1eYXClsEpS0nlB/2E0LYRjUMaKEXCql3nQV/hyw0f6U=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fz+y7RPRMGyaXrBuwd+txY35lPvbS2fe4EZa4kMIs6PNY/Tem0y8iEJgWKWp7vnCC
         eGCGe1dN6NxFTrczEQNvkwSiOIDwOni8uQ57NgFfo0RJlNoUQzuoQqEqSWK/8IzKM9
         PN8DBtqdlSXUYXlFZQ6g/j3YBcr7kNyeb0xLT+Pk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7b6b-1lSLTH0hUj-0080kR; Sat, 17
 Apr 2021 02:18:14 +0200
Subject: Re: [PATCH 3/3] btrfs-progs: misc-tests: add test to ensure the
 restored image can be mounted
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210326125047.123694-1-wqu@suse.com>
 <20210326125047.123694-4-wqu@suse.com> <20210416174629.GH7604@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <31b7aadb-70bf-6498-2be5-6f74fe978d0f@gmx.com>
Date:   Sat, 17 Apr 2021 08:18:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210416174629.GH7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cG1hm1MzyhIELWNg4KJq+jGQAJcZVGbS/dUmA2/d7qfA9SxfQTE
 Ft/moQvp2TG9MandlUgk7bgzwvN6ovrBEAgDIoqOCgvqaYROlMcCEdzF1BlSruVVK0gX5YO
 2Ml5u8m9BI1rmfPfJFpyF2MKJPIBvMf4wTub4SIIVAkInFbK15s3QMABK8AORiEzSmFJdbt
 v7YL8sqcipenw3IsLu/lQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rp6S8oxn3/I=:9U2AFVKEy9WVZJJO7E7YTt
 dJDENyevNMnw8viyMAymr0xWUQRG8T/LKHG8+MXCZYLLHyj6icZ3QK3bm1ey0QenX2SEdxqTr
 JahgXIVq4brUIq28BJ5s21sHKjB1mHSeQlh70a7bfsxn1BP6BWsc1MUY6kVUfH3Exd5XO9d+j
 xU0kqhxAyVDmGDeOShe7xCzs2yMr005JEVWp2cmxyZLX6rJ+xKu+hojeqfEFTqWt67dnDUlAA
 F9eBBe+1z0+g1dSnSF1sRId/53Af+IGkeA2EcpxFBJCpTGfMzYMAd6paZ1gklrCHCdDBY6QuG
 aq0DK1Yvmg1D8657LfJfvD8fs1zDCGllv6BOV9C7eMWjBtIJ5Wh8LQ8AnXjVbsqJuJE/Y5XKE
 udAXdBmy9E9Kjur2VSgSy56jHN843v/rhm6R037WHLqYYaPgo04U12TSaylIOrjHE1qyOYb1I
 JfxOIY9FumXp3W6Yg+ZeLhrulXgrG4JT1nZnh8hR4e9MBZi8X5YpOvMBufd2S4U1Qs+irK191
 wAVN6gG718+7uVKXG5HijjYDIglrs0PIPQY71lj++pii/3MisWwWgbXXnTIplphtpNHCRfjzD
 sSCYzIgYbmWRvVWOXUcyfWb6ZanVUCjdvoRh354ftNgKlNFXpg12RguNSuj/nah/Gn3dcNxCu
 n+ufcc88H3EzrxdfjqtaNASxh5GGvS12oYpEmMD9dXJhL9MvIhyvYhqYy4jOHCoWP+TImaE/V
 jvYJ77YR9cADJwIVxM0jyPWsKeF9fF1zbmuT7Pfr79mHrYkgVpB2jqNwMevIzU2staxtXcVQK
 6bz4iqNIyKrOS2cKwoMZP3+2Sh9QutuNIFAF4KAZps7kCH8mhA9wEYI9EFhc5/wOG+9re4Eev
 l+uTW7jvn6C1R9AmuPGrAoLMfGeZ+NIUm2M60Br4c4w1ZfTph1/NF35uv59Gq5BLZfhi1P7sG
 HMyJTtm2n9JLM88533aiVDU/H0MvvnAvs4lbupJonhCmOMWh3FWLa7nG8qRs262VezTDPZZbI
 xkmodj9SCvc37Jbn7yDuHgdL8kYviu/eDCFsOCRgx2eVdpEQ8u7ZitiEijSPRuKFL3KPNaLP1
 iBqHDQUfnQNhB8czFAMhvr77z4xJ+WsM2ys2qgaQUNLXgrOJ2imgijSjyUirhL0GoF1rBuYUG
 amREO7uzDDK4dDNZN/tHSc/11GbU6jGRsUcbK8sjjHqrV9pEqMCUN8RFwf2RZdFhVe9TzaFgL
 Hzer8EB4DPHFoVpsa
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/17 =E4=B8=8A=E5=8D=881:46, David Sterba wrote:
> On Fri, Mar 26, 2021 at 08:50:47PM +0800, Qu Wenruo wrote:
>> This new test case is to make sure the restored image file has been
>> properly enlarged so that newer kernel won't complain.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   .../047-image-restore-mount/test.sh           | 19 ++++++++++++++++++=
+
>>   1 file changed, 19 insertions(+)
>>   create mode 100755 tests/misc-tests/047-image-restore-mount/test.sh
>>
>> diff --git a/tests/misc-tests/047-image-restore-mount/test.sh b/tests/m=
isc-tests/047-image-restore-mount/test.sh
>> new file mode 100755
>> index 000000000000..7f12afa2bab6
>> --- /dev/null
>> +++ b/tests/misc-tests/047-image-restore-mount/test.sh
>> @@ -0,0 +1,19 @@
>> +#!/bin/bash
>> +# Verify that the restored image of an empty btrfs can still be mounte=
d
>                                                  ^^^^^
>
> I've seen that in patches and comments, the use of word 'btrfs' instead
> of 'filesystem' sounds a bit inappropriate to me, so I change it
> whenever I see it. It's perhaps matter of taste and style, one can write
> it also as 'btrfs filesystem' but that may belong to some more polished
> documentation, so you can go with just 'filesystem'.
>
Thanks for pointing this out.

I'll use 'filesystem' from now on.

Thanks,
Qu
